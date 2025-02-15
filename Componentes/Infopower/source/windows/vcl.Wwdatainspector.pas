unit vcl.Wwdatainspector;
{$R-}
{
  //
  // Components : TwwDataInspector
  //
  // Copyright (c) 1999 by Woll2Woll Software
  //
  // 11/15/99 - Fix problem for active cell updating in detail query
  // 11/18/99 - Make sure this is a valid row when resizing row
  // 12/2/99 - Dbl-click should be passed to base class to handle, and
  //           dbl-click in customcombo when it does not have focus originally
  //           should still work.
  // 1/21/2000-Check for nil pointer in SetEditText
  // 1/28/2000 - Send to parent form, not parent
  // 2/24/00 - Fire OnItemChanged event when exiting control
  // 3/6/2000 - Flush changes when expanding
  // 3/6/00 - Check for nil active control
  // 3/11/00 - Clear modified for inplaceeditor
  // 3/21/00 - Honor setting of text for cbsEllipsis combo style when it is bound
  // 4/21/00 - Fix expand/collapse button click problem when cell font changed during painting
  // 4/25/00 - Make sure Obj is not nil.  This can happen when reassigning the datasource. (PYW)
  // 4/26/00 - Check for nil obj in GetField method
  // 5/3/00 - Make sure obj.edittext is updated to inplaceeditor's value
  //          This is only necessary because when a picture mask is assigned, the obj.edittext
  //          is not updated for some reason
  // 5/4/00   Unbound with custom control item was losing original text
  // 6/23/00 - Handle needs to be created to avoid blank display in some cases
  // 7/19/00 - RSW - Don't remove inplaceeditor painting if it has the focus
  // 7/19/00 - Richedit paint problem when dragging dialog in front
  // 7/20/00 - ovTabToVisibleOnly should use 2nd paramater, not first
  // 8/1/00 - ValidateRect put back in to avoid flicker when expanding all
  // 8/5/00 - Add method Flush contents to force cell to flush its changes
  // 12/4/00 - Support EditText to update inplaceeditor
  // 12/17/00 - Already updated when toggling checkbox
  // 1/22/00 - Add support for ActionLists (PYW)
  // 5/11/2001 - PYW - Make sure that obj <> nil.
  // 6/11/2001 - PYW - Fixed ToolTip Cell Hint Issues.
  // 7/21/01 - Fix invisible inplaceeditor bug when
  //           running in 120 pixels per inch
  // 8/7/01 - Fix problem where unbound default combobox was having text
  //          cleared.  Also fix problem with painting of combobox
  //
  // 8/9/01 - If no active item then have GetActiveEdit method return nil
  // 09/04/01 - Set row to 1st not-fixed row when resetActiveitem tab style
  // 1/21/02 - Add new event CalcCustomEdit to allow developer to prevent customedit
  //           for selected records when the dataset moves to the record
  // 3/18/2002-Call OnMouseUp event if assigned.
  // 4/11/2002 - Verify control is focused if calling setfocuscell (PYW)
  // 5/7/2002-PYW-Handles problem with main menu and return key when datainspector has focus.
  // 5/8/2002 -PYW- Handled column Sizing bug when clicking on edge of Datainspector when embedded in grid.
  // 6/13/02 - RSW Fix editor.text uipdating when inspector first receives focus
  // 6/13/02 - Inspector in Grid problem where right/left arrows exited inspector during editing of inspector cell
  //           It should instead just move within the edit control
  // 10/7/02 - DefaultCombobox not using display text before
  // 10/22/02 - Maplist not initialized correctly unless we use obj.displaytext
  // 11/24/02 - if background is clnone, then use grid's choice of font since we are transparent
  //            otherwise reset captionfont color
  // 12/30/02 - Initialize caption font
  // 4/4/03 - Don't process key if different window is open in hook
  // 4/19/03 - Logic incorrect before causing problem in unbound case
  // 5/19/03 - Fix bug which causes caption column to be hidden in certain cases
  // 6/20/03 - Should have been removed as in IP 3000
  // 7/10/03 - Allow IME editor to handle keystrokes
  // 9/16/03 - in case no items visible
  // 3/18/05 - Undo sizing line so it behaves the same as sizing in data rows
  // 10/29/08 Don't set RowHeight if out of range
}
{$i wwIfDef.pas}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, db, dbctrls, wwstr, stdctrls, wwcommon, wwdbedit, wwpict, wwsystem,
  wwdbdatetimepicker, wwdbcomb, wwdblook, wwdotdot, wwframe, wwriched, extctrls,
  wwbitmap, wwpaintoptions, imm, wwtypes, system.uitypes, system.Types;

type
  TwwInspectorCollection = class;
  TwwDataInspector = class;
  TwwInspectorItem = class;

  TwwInspectorHintWindow = class(THintWindow)
  private
  protected
    procedure Paint; override;
  public
    Field: TField;
    WordWrap: boolean;
    Alignment: TAlignment;
    CenterVertically: boolean;
  end;

  TwwInspectorStyleHook = class(TScrollingStyleHook)
  strict private
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;

  protected
    procedure PaintNC(Canvas: TCanvas); override;
    procedure PaintBackground(Canvas: TCanvas); override;
    procedure DrawHorzScroll(DC: HDC); override;
    procedure DrawVertScroll(DC: HDC); override;

  public
    constructor Create(AControl: TWinControl); override;
  end;

  TwwDataInspectorDataLink = class(TDataLink)
  private
    FObjectView: TwwDataInspector;
    FInUpdateData: boolean;
    FModified: boolean;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;

  public
    constructor Create(AObjectView: TwwDataInspector);
    procedure Modified;
    procedure Reset;
    property isFieldModified: boolean read FModified;
  end;

  TwwInspectorPickList = class(TPersistent)
  private
    FItems: TStrings;
    FMapped: boolean;
    FDisplayAsCheckbox: boolean;
    FStyle: TComboBoxStyle;
    FShowMatchText: boolean;
    FAllowClearKey: boolean;
    FButtonStyle: TwwComboButtonStyle;
    FButtonGlyph: TBitmap;
    FButtonWidth: Integer;
    procedure SetItems(val: TStrings);
    procedure SetButtonGlyph(Value: TBitmap);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Items: TStrings read FItems write SetItems;
    property MapList: boolean read FMapped write FMapped default false;
    property Style: TComboBoxStyle read FStyle write FStyle
      default stdctrls.csDropDown;
    property ShowMatchText: boolean read FShowMatchText write FShowMatchText
      default true;
    property AllowClearKey: boolean read FAllowClearKey write FAllowClearKey
      default false;
    property ButtonStyle: TwwComboButtonStyle read FButtonStyle
      write FButtonStyle default cbsDownArrow;
    property DisplayAsCheckbox: boolean read FDisplayAsCheckbox
      write FDisplayAsCheckbox default false;
    property ButtonGlyph: TBitmap read FButtonGlyph write SetButtonGlyph;
    property ButtonWidth: Integer read FButtonWidth write FButtonWidth
      default 0;
  end;

  TwwInspectorItemOption = (iioAutoDateTimePicker, iioAutoLookupCombo);
  TwwInspectorItemOptions = set of TwwInspectorItemOption;
  TwwInspectorItemChanged = procedure(Sender: TwwDataInspector;
    Item: TwwInspectorItem; NewValue: string) of object;
  TwwInspectorItemNotifyEvent = procedure(Sender: TwwDataInspector;
    Item: TwwInspectorItem) of object;
  TwwInspectorNotifyEvent = procedure(Sender: TwwDataInspector) of object;

  TwwInspectorOnCanShowEvent = procedure(Sender: TwwDataInspector;
     Item: TwwInspectorItem;
     var canShow: boolean) of object;

  TwwInspectorItem = class(TCollectionItem)
  private
    FEditText: string;
    FItems: TwwInspectorCollection;
    FReadOnly: boolean;
    FCustomControlName: TWinControl;
    FCustomControlAlwaysPaints: boolean;
    FCaption: string;
    FCellHeight: Integer;
    FDataField: string;
    FDataLink: TFieldDataLink;
    FExpanded: boolean;
    FPickList: TwwInspectorPickList;
    FPicture: TwwDBPicture;
    FRegexMask: TwwRegexMask;

    FParentItem: TwwInspectorItem;
    FResizeable: boolean;
    FVisible: boolean;
    FTag: Integer;
    FTagString: string;
    FOptions: TwwInspectorItemOptions;
    FTabStop: boolean;
    FItemChanged: TwwInspectorItemChanged;
    FWordWrap: boolean;
    FDisableDefaultEditor: boolean;
    FActiveRecord: boolean;
    // FWantArrowKeys: boolean;

    FOnEditButtonClick: TwwInspectorItemNotifyEvent;
    FAlignment: TAlignment;
    FCustomControlHighlight: boolean;
    FEnabled: boolean;
    FOnCanShowCustomControl: TwwInspectorOnCanShowEvent;
    // procedure ComboDropDownEvent(Sender: TObject);
    // OrigEditText: string;

    procedure SetItems(Value: TwwInspectorCollection);
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetDataField: string;
    procedure SetDataField(const Value: string);
    procedure SetCaption(const Value: string);
    Function GetControl: TComponent;
    Function GetField: TField;
    procedure SetCellHeight(const Value: Integer);
    function GetLevel: Integer;
    procedure SetCustomControl(val: TWinControl);
    procedure SetVisible(val: boolean);
    procedure SetExpanded(val: boolean);
    function GetChecked: boolean;
    procedure SetChecked(val: boolean);
    function GetDataLink: TDataLink;
    function GetDisplayText: string;
    procedure SetDisplayText(val: string);
    procedure SetEditText(val: string);

  protected
    ButtonPoint: TPoint;
    { 4/21/00 - Save buttonpt as if user changed font during
      paint events, then buttonpt would not be consistent.  This
      fixes problem where button click not being recognized. }
    property DataLink: TDataLink read GetDataLink;
    function HaveItems: boolean; virtual;
    Function GetDesigner: TControl;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoItemTextChanged; virtual;
    Function UseDefaultComboBox: boolean;
    Function GetMappedPaintText(StoredValue: string): string; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    Function HaveVisibleItem: boolean;
    function GetDisplayName: string; override;
    function GetNamePath: string; override;
    procedure Assign(Source: TPersistent); override;
    property ActiveRecord: boolean read FActiveRecord write FActiveRecord;
    // Only valid within DrawDataCell and DrawIndicatorCell
    property Field: TField read GetField;
    property Control: TComponent read GetControl;
    property Level: Integer read GetLevel;
    property ParentItem: TwwInspectorItem read FParentItem write FParentItem;
    function GetFirstChild(VisibleItemsOnly: boolean = true;
      ExpandedOnly: boolean = false): TwwInspectorItem;
    function GetLastChild(VisibleItemsOnly: boolean = true;
      ExpandedOnly: boolean = false): TwwInspectorItem;
    function GetPrior(VisibleItemsOnly: boolean = true;
      ExpandedOnly: boolean = false): TwwInspectorItem;
    function GetNext(VisibleItemsOnly: boolean = true;
      ExpandedOnly: boolean = false): TwwInspectorItem;
    function GetNextSibling(VisibleItemsOnly: boolean = true): TwwInspectorItem;
    function GetPriorSibling(VisibleItemsOnly: boolean = true)
      : TwwInspectorItem;
    property Checked: boolean read GetChecked write SetChecked;
    property DisplayText: string read GetDisplayText write SetDisplayText;

  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property Caption: string read FCaption write SetCaption;
    property CellHeight: Integer read FCellHeight write SetCellHeight default 0;
    property EditText: string read FEditText write SetEditText;
    { Design-time settings only applicable if unbound item }

    property Alignment: TAlignment read FAlignment write FAlignment
      default taLeftJustify;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
    property CustomControl: TWinControl read FCustomControlName
      write SetCustomControl;
    property CustomControlAlwaysPaints: boolean read FCustomControlAlwaysPaints
      write FCustomControlAlwaysPaints default true;
    property CustomControlHighlight: boolean read FCustomControlHighlight
      write FCustomControlHighlight default false;
    property Expanded: boolean read FExpanded write SetExpanded default false;
    property PickList: TwwInspectorPickList read FPickList write FPickList;
    property Picture: TwwDBPicture read FPicture write FPicture;
    property RegexMask: TwwRegexMask read FRegexMask write FRegexMask;
    property Resizeable: boolean read FResizeable write FResizeable
      default false;
    property Items: TwwInspectorCollection read FItems write SetItems
      stored HaveItems;
    property Visible: boolean read FVisible write SetVisible default true;
    property Tag: Integer read FTag write FTag default 0;
    property TagString: string read FTagString write FTagString;
    property TabStop: boolean read FTabStop write FTabStop default true;
    property Options: TwwInspectorItemOptions read FOptions write FOptions
      default [iioAutoDateTimePicker];
    property WordWrap: boolean read FWordWrap write FWordWrap;
    { 12/11/99 - Removed default as it did not match constructor before }
    property DisableDefaultEditor: boolean read FDisableDefaultEditor
      write FDisableDefaultEditor default false;
    property Enabled: boolean read FEnabled write FEnabled default true;

    property OnItemChanged: TwwInspectorItemChanged read FItemChanged
      write FItemChanged;
    property OnEditButtonClick: TwwInspectorItemNotifyEvent
      read FOnEditButtonClick write FOnEditButtonClick;
    property OnCanShowCustomControl: TwwInspectorOnCanShowEvent read
       FOnCanShowCustomControl write FOnCanShowCustomControl;
  end;

  TwwInspectorCollection = class(TCollection)
  private
    FParentItem: TwwInspectorItem;
    function GetItem(Index: Integer): TwwInspectorItem;
    procedure SetItem(Index: Integer; Value: TwwInspectorItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    Control: TComponent;
    property ParentItem: TwwInspectorItem read FParentItem;

    constructor Create(Control: TComponent);
    destructor Destroy; override;
    function Add: TwwInspectorItem;
    function Insert(Index: Integer): TwwInspectorItem;
    procedure SaveToStream(s: TStream);
    procedure LoadFromStream(s: TStream);
    procedure SaveToFile(const FileName: string);
    procedure LoadFromFile(const FileName: string);
    property Items[Index: Integer]: TwwInspectorItem read GetItem
      write SetItem; default;
  end;

  TwwInspectorItemCallback = procedure(obj: TwwInspectorItem; UserData: Pointer;
    var AContinue: boolean) of object;

  TwwDataInspectorOption = (ovColumnResize, ovRowResize, ovTabExits,
    ovEnterToTab, ovHighlightActiveRow, ovHideVertDataLines,
    ovCenterCaptionVert, ovTabToVisibleOnly, ovShowTreeLines,
    ovShowCaptionHints, ovShowCellHints, ovFillNonCellArea,
    ovActiveRecord3DLines, ovAllowInsert, ovHideCaptionColumn,
    ovHideVertFixedLines, ovUseOwnBackgroundColors);
  // 8/2/02 - When UseOwnBackgroundcolors is true, then
  // inspector fills its background using its color and captioncolor properties.
  // This allows an inspector in a grid to still use its own colors instead of the alternating colors
  TwwDataInspectorOptions = set of TwwDataInspectorOption;

  TwwDataInspectorLineStyle = (ovNoLines, ovDottedLine, ovLight3DLine,
    ovDark3DLine, ovButtonLine);

  // 1/21/02
  TwwInspectorCalcCustomEditEvent = procedure(Sender: TwwDataInspector;
    Item: TwwInspectorItem; CustomEdit: TWinControl;
    var AllowCustomEdit: boolean) of object;

  TwwInspectorDrawDataCellEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem; ASelected: boolean; ACellRect: TRect;
    var DefaultDrawing: boolean) of object;

  TwwInspectorDrawICellEvent = procedure(Sender: TwwDataInspector;
    ACol: Integer; ACellRect: TRect; var DefaultDrawing: boolean) of object;

  TwwInspectorDrawCaptionEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem; ASelected: boolean; ACellRect: TRect;
    var ACaptionRect: TRect; var DefaultTextDrawing: boolean) of object;

  TwwDataInspectorEdit = class(TInplaceEdit)
  private
    FwwPicture: TwwDBPicture;
    FRegexMask: TwwRegexMask;

    FWordWrap: boolean;
    ParentGrid: TwwDataInspector;
    FUsePictureMask: boolean;
    OrigForeColor: TColor;
    OrigBackColor: TColor;

    FCanvas: TControlCanvas;

    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMPaste(var Message: TMessage); message WM_PASTE; { 10/28/96 }
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;

  protected
    procedure BoundsChanged; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure SetWordWrap(val: boolean);
    procedure UpdateContents; override;
  public
    constructor wwCreate(AOwner: TComponent; dummy: Integer); virtual;
    destructor Destroy; override;
    function IsValidPictureValue(s: string): boolean;
    Function HavePictureMask: boolean;

    procedure ApplyValidationColors(valid: boolean); virtual;
    procedure ResetValidationColors(ForeColor: TColor = clNone;
      BackColor: TColor = clNone); virtual;
    procedure DoRefreshValidationDisplay(valid: boolean); overload; virtual;
    procedure DoRefreshValidationDisplay(input: string = ''); overload; virtual;

    property Picture: TwwDBPicture read FwwPicture write FwwPicture;
    property RegexMask: TwwRegexMask read FRegexMask write FRegexMask;

    property WordWrap: boolean read FWordWrap write SetWordWrap;
    property Color;
    property Font;
  end;

  TwwInspectorFieldChangedEvent = procedure(Sender: TwwDataInspector;
    Field: TField) of object;
  TwwInspectorCreateDTPEvent = procedure(Sender: TwwDataInspector;
    ADateTimePicker: TwwDBCustomDateTimePicker) of object;
  TwwInspectorCreateComboEvent = procedure(Sender: TwwDataInspector;
    Combo: TwwDBComboBox) of object;
  TwwInspectorBeforeSelectCellEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem; var CanSelect: boolean) of object;
  TwwInspectorAfterSelectCellEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem) of object;

  TwwInspectorCanExpandEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem; var CanExpand: boolean) of object;
  TwwInspectorCanCollapseEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem; var CanCollapse: boolean) of object;
  TwwInspectorExpandedEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem) of object;
  TwwInspectorCollapsedEvent = procedure(Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem) of object;

  TwwInspectorTabSetFocusStyle = (itsPreserveActiveItem, itsResetActiveItem);

  TwwInspectorButtonOptions = class(TPersistent)
  private
    FExpandGlyph: TBitmap;
    FCollapseGlyph: TBitmap;
    Control: TWinControl;
    FTransparentGlyphs: boolean;
    procedure SetExpandGlyph(Value: TBitmap);
    procedure SetCollapseGlyph(Value: TBitmap);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  published
    property ExpandGlyph: TBitmap read FExpandGlyph write SetExpandGlyph;
    property CollapseGlyph: TBitmap read FCollapseGlyph write SetCollapseGlyph;
    property TransparentGlyphs: boolean read FTransparentGlyphs
      write FTransparentGlyphs default false;
  end;

  TwwInspectorPaintTextEvent = procedure(Sender: TwwDataInspector;
    Item: TwwInspectorItem; var PaintText: string) of object;
  TwwInspectorValidationError = procedure(Sender: TwwDataInspector;
    Item: TwwInspectorItem; var Msg: string; var DoDefault: boolean) of object;
  TwwCreateInspectorHintWindowEvent = procedure(Sender: TObject;
    HintWindow: TwwInspectorHintWindow; AField: TField; R: TRect;
    var WordWrap: boolean; var MaxWidth, MaxHeight: Integer;
    var DoDefault: boolean) of object;

  TwwInspectorIndicatorRow = class(TPersistent)
  private
    FEnabled: boolean;
    FCaption: string;
    FHeight: Integer;
    FColor: TColor;
    FTextAlignment: TAlignment;
    procedure SetColor(Value: TColor);
    procedure SetEnabled(Value: boolean);
    procedure SetHeight(Value: Integer);
    procedure SetCaption(Value: string);
    procedure SetTextAlignment(Value: TAlignment);
  public
    Inspector: TwwDataInspector;
    constructor Create(Owner: TComponent);
    procedure Invalidate;
  published
    property TextAlignment: TAlignment read FTextAlignment
      write SetTextAlignment default taLeftJustify;
    property Color: TColor read FColor write SetColor default clBtnFace;
    property Enabled: boolean read FEnabled write SetEnabled default false;
    property Caption: string read FCaption write SetCaption;
    property Height: Integer read FHeight write SetHeight default 0;
  end;

  TwwDataInspector = class(TCustomGrid)
  private
    SkipUpdateCustomControlInFocus: boolean;
    NewMouseRow: Integer;
    FIndicators: TImageList;
    FOnDrawDataCell: TwwInspectorDrawDataCellEvent;
    FOnDrawIndicatorCell: TwwInspectorDrawICellEvent;
    FOnTopLeftChanged: TNotifyEvent;
    FOnCalcCustomEdit: TwwInspectorCalcCustomEditEvent; // 1/21/02

    FOptions: TwwDataInspectorOptions;
    FPaintOptions: TwwGridPaintOptions;
    FDesigner: TControl;
    FItems: TwwInspectorCollection;

    FDataLink: TwwDataInspectorDataLink;
    FCaptionWidth: Integer;
    FInactiveFocusColor: TColor;

    FEditText: string;
    FSizingIndex: Integer;
    FSizingPos, FSizingOfs: Integer;
    FOnCheckValue: TwwValidateEvent;
    FOnFieldChanged: TwwInspectorFieldChangedEvent;
    FOnItemChanged: TwwInspectorItemChanged;
    FReadOnly: boolean;
    FCaptionIndent: Integer;
    FDateTimePicker: TwwDBCustomDateTimePicker;
    FCombo: TwwDBComboBox;
    FOnCreateDateTimePicker: TwwInspectorCreateDTPEvent;
    FOnCreateDefaultCombo: TwwInspectorCreateComboEvent;
    FPictureMaskFromDataSet: boolean;
    FDefaultRowHeight: Integer;
    FCaptionFont: TFont;
    FLineStyleData: TwwDataInspectorLineStyle;
    FLineStyleCaption: TwwDataInspectorLineStyle;
    FDottedLineColor: TColor;
    FUpdateCount: Integer;
    InvalidateInEndUpdate: boolean;
    FButtonOptions: TwwInspectorButtonOptions;
    FSetFocusTabStyle: TwwInspectorTabSetFocusStyle;

    FOnDrawCaptionCell: TwwInspectorDrawCaptionEvent;
    FOnBeforePaint: TwwInspectorNotifyEvent;
    FOnGetEditMask: TGetEditEvent;
    FOnBeforeSelectCell: TwwInspectorBeforeSelectCellEvent;
    FOnAfterSelectCell: TwwInspectorAfterSelectCellEvent;
    FOnCanExpand: TwwInspectorCanExpandEvent;
    FOnCanCollapse: TwwInspectorCanCollapseEvent;
    FOnExpanded: TwwInspectorExpandedEvent;
    FOnCollapsed: TwwInspectorCollapsedEvent;
    FOnCalcDataPaintText: TwwInspectorPaintTextEvent;
    FOnValidationErrorUsingMask: TwwInspectorValidationError;
    FOnCreateHintWindow: TwwCreateInspectorHintWindowEvent;

    TextIsSame: boolean;
    LastDefaultRowHeight: Integer;
    SkipErase: boolean;
    CheckRowCount: boolean;

    FPaintCanvas: TCanvas;
    FPaintBitmap: TBitmap;
    UseTempCanvas: boolean;
    OldDesigning: boolean;
    LastActiveItem: TwwInspectorItem;

    FActiveItem, FTopItem: TwwInspectorItem;
    FMinRowHeight: Integer;
    OldTopRow: Integer;
    DoBeginUpdateInSelectCell: boolean;
    SelectCellUpdateRect: TRect;
    ChildDataChanged: boolean;
    // 2/10/2000 - Clear inplaceeditor if child datalink is changed.
    FDataColumns: Integer;
    FTreeLineColor: TColor;
    FFixedDataRows: Integer;
    // FAlternatingRowColor: TColor;
    // FActiveColumnColor: TColor;

    // Cell hint support
    lastMouseX, lastMouseY: Integer;
    HintWindow: THintWindow;
    HintTimer: TTimer;
    HintTimerCount: Integer;
    FCustomControlKeyMode: boolean;

    UpdateRect: TRect;
    // OldClientRect: TRect;
    // InitBlendBitmapsFlag: boolean;
    OldBoundsRect: TRect;
    FScrollBars: System.UITypes.TScrollStyle;
    // FIndicatorCaption: string;
    FIndicatorRow: TwwInspectorIndicatorRow;
    // PaintCopyBrushColor: TColor;
    PaintCopyTextColor: TColor;
    SkipSetFocus: boolean;
    SkipUpdateEditText: boolean;
    lastMouseCoord: TGridCoord;
{$IFDEF wwUseThemeManager}
    HotCol: Integer;
    HotRow: Integer;
{$ENDIF}
    FDisableThemes: boolean;

    class constructor Create;
    procedure HintTimerEvent(Sender: TObject);

    procedure EditingChanged;
    procedure SetDataSource(Value: TDataSource);
    Function GetDataSource: TDataSource;
    procedure SetCaptionWidth(Value: Integer);
    procedure FieldChanged(Field: TField);

    procedure RecordChanged(Field: TField);
    procedure UpdateData;
    function GetPageHeight: Integer;
    function InValidColSizingArea(x: Integer): boolean;
    function GetDateTimePicker: TwwDBCustomDateTimePicker;
    function DataRow(ARow: Integer): Integer;

    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMLButtonDown(var Message: TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;

    Function IsHighlightRowVisible: boolean;
    Procedure GetActiveItemCallback(Item: TwwInspectorItem; UserData: Pointer;
      var AContinue: boolean);
    Procedure GetActiveRowsCallback(Item: TwwInspectorItem; UserData: Pointer;
      var AContinue: boolean);
    Procedure ApplySettingsCallback(Item: TwwInspectorItem; UserData: Pointer;
      var AContinue: boolean);
    Procedure LinkActiveCallback(Item: TwwInspectorItem; UserData: Pointer;
      var AContinue: boolean);
    Function GetActiveRows: Integer;
    procedure SetCaptionIndent(val: Integer);

    procedure SetItems(Value: TwwInspectorCollection);
    procedure SetOptions(Value: TwwDataInspectorOptions);
    // procedure SetPaintOptions(Value: TwwInspectorPaintOptions);
    procedure SetDefaultRowHeight(Value: Integer);
    procedure SetCaptionFont(Value: TFont);
    procedure CaptionFontChanged(Sender: TObject);
    procedure ToggleCheckbox(obj: TwwInspectorItem);
    procedure SetLineStyleCaption(val: TwwDataInspectorLineStyle);
    procedure SetLineStyleData(val: TwwDataInspectorLineStyle);
    procedure SetUpdateState(Updating: boolean);
    function isFocused: boolean;
    Procedure SetActiveItem(obj: TwwInspectorItem);
    function GetActiveItem: TwwInspectorItem;
    function GetCaptionColor: TColor;
    function GetTreeLineColor: TColor;
    procedure SetCaptionColor(val: TColor);
    procedure SetTreeLineColor(val: TColor);
    Function GetTopItem: TwwInspectorItem;
    procedure UpdateRowCount;
    procedure EditDataLinkDataChange(Sender: TObject);
    procedure EditDataLinkUpdateData(Sender: TObject);
    Function GetActiveEdit: TWinControl;
    procedure SetDottedLineColor(val: TColor);
    procedure SetDataColumns(val: Integer);
    procedure SetScrollBars(Value: System.UITypes.TScrollStyle);
    procedure SetFixedDataRows(Value: Integer);
    // procedure SetIndicatorCaption(val: string);
  protected
    CurrentCustomEdit: TWinControl; // CustomEdit;
    CurrentCustomEditRow: Integer;
    CurrentCustomEditCol: Integer;
    InTracking: boolean;
    FFocused: boolean;
    FastDesign: boolean; { Need to test more with this as true }
    TempRichEdit: TwwDBRichEdit;

    function GetEditLimit: Integer; override;
    function CanEditAcceptKey(Key: Char): boolean; override;
    // 1/21/02
    procedure CurrentCustomEditSetfocus; virtual;
    procedure DoCalcCustomEdit(Item: TwwInspectorItem; CustomEdit: TWinControl;
      var AllowCustomEdit: boolean); virtual;
    function RecordCountIsValid: boolean; virtual;
    function GetClientRect: TRect; override;
    procedure UpdateScrollBar; virtual;
    procedure CreateWnd; override;
    procedure Scroll(Distance: Integer); virtual;
    Function CreateHintWindow: THintWindow; virtual;
    procedure HintMouseMove(Shift: TShiftState; x, Y: Integer); virtual;
    procedure DisplayIndicatorCell(ACol: Integer; ARect: TRect); virtual;
    Function EffectiveFocused: boolean;

    procedure DoCreateHintWindow(HintWindow: TwwInspectorHintWindow;
      AField: TField; R: TRect; var WordWrap: boolean;
      var MaxWidth, MaxHeight: Integer; var DoDefault: boolean); virtual;

    procedure UpdateCurrentEditPosition;
    function ControlRect(ACol, ARow: Integer): TRect;
    procedure UpdateCustomEdit;
    procedure FreeHintWindow; virtual;
    function IsActiveControl: boolean;
    procedure ChangeOrientation(RightToLeftOrientation: boolean);
    procedure InheritedPaint;
    procedure FirstTimePaint; virtual;

    procedure SetDesigner(Value: TControl); virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function CreateDateTimePicker: TwwDBCustomDateTimePicker; virtual;
    function CreateDefaultCombo: TwwDBComboBox; virtual;
    procedure DoCreateDateTimePicker(ADateTimePicker
      : TwwDBCustomDateTimePicker); virtual;
    procedure DoCreateDefaultCombo(ACombo: TwwDBComboBox); virtual;
    procedure LinkActive(Value: boolean); virtual;
    function CanEditModify: boolean; override;
    procedure DoFieldChanged(Field: TField); virtual;
    procedure DoItemChanged(Item: TwwInspectorItem; NewValue: string); virtual;

    function CreateEditor: TInplaceEdit; override;
    procedure DoExit; override;
    procedure TopLeftChanged; override;
    function CanEditShow: boolean; override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect;
      AState: TGridDrawState); override;
    procedure MouseMove(Shift: TShiftState; x, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      x, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      x, Y: Integer); override;
    procedure CalcSizingState(x, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure UpdateDataColumnWidth; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetEditText(ACol, ARow: Longint): string; override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure Loaded; override;
    function AcquireFocus: boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure SetFocusCell(ACol, ARow: Integer); virtual;
    function SelectCell(ACol, ARow: Longint): boolean; override;
    procedure DataChanged; virtual;
    procedure UpdateActive; virtual;
    function GetField(ARow: Integer): TField;
    function UseDefaultEditor: boolean; virtual;
    function UseCheckbox(ARow: Integer): boolean; virtual;
    function ButtonPt(ARect: TRect; obj: TwwInspectorItem): TPoint; virtual;
    function CheckboxRect(ARect: TRect; obj: TwwInspectorItem): TRect; virtual;
    procedure DrawSizingLine(const DrawInfo: TGridDrawInfo);
    procedure RowHeightsChanged; override;
    procedure DoDrawDataCell(ObjItem: TwwInspectorItem; ASelected: boolean;
      ACellRect: TRect; var DefaultDrawing: boolean); virtual;
    // procedure DoDrawIndicatorCell(ObjItem: TwwInspectorItem;
    // ACellRect: TRect;
    // var DefaultDrawing: boolean); virtual;
    procedure InitCustomEdit(CustomEdit: TWinControl;
      obj: TwwInspectorItem); virtual;
    procedure DoDrawCaptionCell(ObjItem: TwwInspectorItem; ASelected: boolean;
      ACellRect: TRect; var ACaptionRect: TRect;
      var DefaultTextDrawing: boolean); virtual;
    Function GetCanvas: TCanvas; virtual;
    Function IsDefaultDateTimePicker(obj: TwwInspectorItem): boolean;
    Function IsDefaultLookupCombo(obj: TwwInspectorItem): boolean;
    procedure DoCollapse(ObjItem: TwwInspectorItem); virtual;
    procedure DoExpand(ObjItem: TwwInspectorItem); virtual;
    procedure Click; override;
    procedure PaintLines(Item: TwwInspectorItem); virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint)
      : boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint)
      : boolean; override;
    procedure DoCalcDataPaintText(Item: TwwInspectorItem;
      var PaintText: string); virtual;
    procedure ValidationErrorUsingMask(Item: TwwInspectorItem); virtual;
    procedure FillWithFixedBitmap(TempRect: TRect; CurRelRow: Integer); virtual;
    procedure FillWithAlternatingRowBitmap(TempRect: TRect); virtual;
    Procedure WriteTextLines(ACanvas: TCanvas; const ARect: TRect;
      DX, DY: Integer; s: PWideChar; Alignment: TAlignment;
      WriteOptions: TwwWriteTextOptions); virtual;
    Procedure WriteTitleLines(ACanvas: TCanvas; const ARect: TRect;
      DX, DY: integer; s: PWideChar; Alignment: TAlignment;
      WriteOptions: TwwWriteTextOptions); virtual;
    Procedure DoOnCanShowCustomControl(
      Item: TwwInspectorItem;
      var canShow: boolean); virtual;

    property InactiveFocusColor: TColor read FInactiveFocusColor
      write FInactiveFocusColor default clNone;
    property TopItem: TwwInspectorItem read GetTopItem;
    { Currently not implemented so leave as protected }

  public
    property Col;
    property ColWidths;
    property EditorMode;
    property GridHeight;
    property GridWidth;
    property LeftCol;
    property Selection;
    property Row;
    property RowHeights;
    property TabStops;
    property TopRow;
    property RowCount;
    property ActiveEdit: TWinControl read GetActiveEdit;
{$IFDEF wwdelphi4up}
    function ExecuteAction(Action: TBasicAction): boolean; override;
    function UpdateAction(Action: TBasicAction): boolean; override;
{$ENDIF}
    property DataLink: TwwDataInspectorDataLink read FDataLink;
    property DefaultDateTimePicker: TwwDBCustomDateTimePicker
      read GetDateTimePicker;
    property DefaultCombo: TwwDBComboBox read FCombo;
    property Canvas: TCanvas read GetCanvas;
    property CustomControlKeyMode: boolean read FCustomControlKeyMode
      write FCustomControlKeyMode;

    Function LevelRect(Item: TwwInspectorItem): TRect;
    procedure MouseToCell(x, Y: Integer; var ACol, ARow: Longint);
    function MouseToItem(x, Y: Integer): TwwInspectorItem;
    function RefreshActiveItem: TwwInspectorItem;
    procedure BeginUpdate;
    procedure EndUpdate(Repaint: boolean = false);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplySettings;
    procedure RefreshItem(Item: TwwInspectorItem); virtual;
    // procedure Click; override;
    Function GetRowByItem(AItem: TwwInspectorItem): Integer; virtual;
    procedure IterateItems(CallBack: TwwInspectorItemCallback;
      ExpandedOnly: boolean; UserData: Pointer);
    procedure InvalidateRow(ARow: Integer);
    procedure InvalidateRowCol(ARow: Integer; ACol: Integer = -1);
    // procedure RefreshCustomControl;
    Function GetItemByFieldName(AFieldName: string): TwwInspectorItem;
    Function GetItemByRow(ARow: Integer; Optimize: boolean = true)
      : TwwInspectorItem; virtual;
    Function GetItemByCaption(ACaption: string): TwwInspectorItem;
    Function GetItemByTagString(ATagString: string): TwwInspectorItem;
    Function HaveVisibleItem: boolean;
    function GetFirstChild(VisibleItemsOnly: boolean = true): TwwInspectorItem;
    procedure FlushContents; // 8/5/00 New method
    property Designer: TControl read FDesigner write SetDesigner;
    property ActiveRows: Integer read GetActiveRows;
    property InplaceEditor;
    property ActiveItem: TwwInspectorItem read GetActiveItem
      write SetActiveItem;
    // property DefaultDrawing;
    { Perhaps publish later, but this event seems unncessary as the OnItemChanged event can do the job }
    property OnFieldChanged: TwwInspectorFieldChangedEvent read FOnFieldChanged
      write FOnFieldChanged;

    // FixeddataRows Not published now as it is not fully functional.
    // 1. Need to resolve scrolling down from fixed row as it should not jump 2 2nd row
    // but instead it should jump to the current top row.
    // 2. Some lines are not drawn in their proper location when fixeddatarows is assigned
    property FixedDataRows: Integer read FFixedDataRows write SetFixedDataRows
      default 0;

  published
    property DisableThemes: boolean read FDisableThemes write FDisableThemes;
    property Align;
    property Anchors;
    // property AlternatingRowColor: TColor read FAlternatingRowColor write FAlternatingRowColor default $00B1B1B1;
    // property ActiveColumnColor: TColor read FActiveColumnColor write FActiveColumnColor default clNone;
    property BiDiMode;
    property BorderStyle;
    property Color default clBtnFace;
    property Constraints;
    property Ctl3D;
    // property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property CaptionColor: TColor read GetCaptionColor write SetCaptionColor
      default clBtnFace;
    property TreeLineColor: TColor read GetTreeLineColor write SetTreeLineColor
      default clWhite;
    // property FixedColor;
    property Font;
    property DataColumns: Integer read FDataColumns write SetDataColumns
      default 1;
    // property IndicatorCaption: string read FIndicatorCaption write SetIndicatorCaption;
    property IndicatorRow: TwwInspectorIndicatorRow read FIndicatorRow
      write FIndicatorRow;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars: System.UITypes.TScrollStyle read FScrollBars write SetScrollBars
      default ssVertical;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property PictureMaskFromDataSet: boolean read FPictureMaskFromDataSet
      write FPictureMaskFromDataSet default false;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Items: TwwInspectorCollection read FItems write SetItems;
    property DefaultRowHeight: Integer read FDefaultRowHeight
      write SetDefaultRowHeight default 0;
    property CaptionWidth: Integer read FCaptionWidth write SetCaptionWidth;
    // property WordWrap : boolean read FWordWrap write FWordWrap;
    property Options: TwwDataInspectorOptions read FOptions write SetOptions;
    property PaintOptions: TwwGridPaintOptions read FPaintOptions
      write FPaintOptions; // SetPaintOptions;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property LineStyleCaption: TwwDataInspectorLineStyle read FLineStyleCaption
      write SetLineStyleCaption default ovDark3DLine;
    property LineStyleData: TwwDataInspectorLineStyle read FLineStyleData
      write SetLineStyleData default ovDark3DLine;
    property DottedLineColor: TColor read FDottedLineColor
      write SetDottedLineColor default clBtnShadow;
    // property InactiveFocusColor: TColor read FInactiveFocusColor write FInactiveFocusColor default clNone;
    property ButtonOptions: TwwInspectorButtonOptions read FButtonOptions
      write FButtonOptions;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
    property CaptionIndent: Integer read FCaptionIndent write SetCaptionIndent
      default 12;
    property SetFocusTabStyle: TwwInspectorTabSetFocusStyle
      read FSetFocusTabStyle write FSetFocusTabStyle
      default itsPreserveActiveItem;
    property Visible;
{$IFDEF wwDELPHI2010Up}
    property Touch;
{$ENDIF}
    // 1/21/02
    property OnCalcCustomEdit: TwwInspectorCalcCustomEditEvent
      read FOnCalcCustomEdit write FOnCalcCustomEdit;
    property OnClick;
    property OnCreateHintWindow: TwwCreateInspectorHintWindowEvent
      read FOnCreateHintWindow write FOnCreateHintWindow;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawDataCell: TwwInspectorDrawDataCellEvent read FOnDrawDataCell
      write FOnDrawDataCell;
    property OnDrawIndicatorCell: TwwInspectorDrawICellEvent
      read FOnDrawIndicatorCell write FOnDrawIndicatorCell;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnBeforeSelectCell: TwwInspectorBeforeSelectCellEvent
      read FOnBeforeSelectCell write FOnBeforeSelectCell;
    property OnAfterSelectCell: TwwInspectorAfterSelectCellEvent
      read FOnAfterSelectCell write FOnAfterSelectCell;
    property OnStartDock;
    property OnStartDrag;
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged
      write FOnTopLeftChanged;
    property OnContextPopup;
{$IFDEF wwDELPHI2010Up}
    property OnGesture;
{$ENDIF}
    property OnCreateDateTimePicker: TwwInspectorCreateDTPEvent
      read FOnCreateDateTimePicker write FOnCreateDateTimePicker;
    property OnCreateDefaultCombo: TwwInspectorCreateComboEvent
      read FOnCreateDefaultCombo write FOnCreateDefaultCombo;
    property OnDrawCaptionCell: TwwInspectorDrawCaptionEvent
      read FOnDrawCaptionCell write FOnDrawCaptionCell;
    property OnBeforePaint: TwwInspectorNotifyEvent read FOnBeforePaint
      write FOnBeforePaint;
    property OnCanExpand: TwwInspectorCanExpandEvent read FOnCanExpand
      write FOnCanExpand;
    property OnCanCollapse: TwwInspectorCanCollapseEvent read FOnCanCollapse
      write FOnCanCollapse;
    property OnExpanded: TwwInspectorExpandedEvent read FOnExpanded
      write FOnExpanded;
    property OnCollapsed: TwwInspectorCollapsedEvent read FOnCollapsed
      write FOnCollapsed;
    // property OnCheckValue: TwwValidateEvent read FOnCheckValue write FOnCheckValue;
    property OnItemChanged: TwwInspectorItemChanged read FOnItemChanged
      write FOnItemChanged;
    // property OnGetEditMask: TGetEditEvent read FOnGetEditMask write FOnGetEditMask;
    property OnCalcDataPaintText: TwwInspectorPaintTextEvent
      read FOnCalcDataPaintText write FOnCalcDataPaintText;
    property OnValidationErrorUsingMask: TwwInspectorValidationError
      read FOnValidationErrorUsingMask write FOnValidationErrorUsingMask;

    {$ifdef wwDELPHI2013Up}
    property StyleElements;
    property DoubleBuffered;
    property ParentDoubleBuffered;
    {$endif}
  end;

  { 12/15/99 - Support dbl-click }
  TwwInspectorComboBox = class(TwwDBComboBox)
  private
    Inspector: TwwDataInspector;
  protected
    FClickTime: Integer;
    procedure CloseUp(Accept: boolean); override;
    procedure DblClick; override;
    procedure WndProc(var Message: TMessage); override;
  public
    procedure DropDown; override;
    constructor Create(AOwner: TComponent); override;
  end;

procedure Register;

implementation

uses consts {, wwblend} ,
{$IFDEF wwDelphi7Up}
  themes,
{$ENDIF}
{$IFDEF ThemeManager}
  thememgr, themesrv, uxtheme,
{$ENDIF}
  wwdbgrid, wwintl;
{$R WWDATAIN.RES}

procedure TwwInspectorComboBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN:
      begin
        if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
          Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TwwInspectorComboBox.DblClick;
begin
  inherited;
  Inspector.DblClick;
end;

constructor TwwInspectorComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TabStop := false;
  Inspector := AOwner as TwwDataInspector;
end;

procedure TwwInspectorComboBox.CloseUp(Accept: boolean);
var
  WasDroppedDown: boolean;
  OldEditText: string;
begin
  WasDroppedDown := IsDroppedDown;
  if Inspector.ActiveItem <> nil then
    OldEditText := Inspector.ActiveItem.EditText
  else
    OldEditText := '';
  inherited CloseUp(Accept);
  if Accept and WasDroppedDown then
  begin
    if Inspector.ActiveItem = nil then
      exit;
    Inspector.ActiveItem.EditText := GetComboValue(Text);
    if OldEditText <> Inspector.ActiveItem.EditText then
      Inspector.ActiveItem.DoItemTextChanged;
  end
end;

procedure TwwInspectorComboBox.DropDown;
begin
  with Inspector.ActiveItem do
  begin
    if Assigned(FOnEditButtonClick) then
    begin
      FOnEditButtonClick(Inspector, Inspector.ActiveItem);
      if Inspector.CurrentCustomEdit is TwwDBComboBox then
      begin
        if (TwwDBComboBox(Inspector.CurrentCustomEdit).ButtonStyle = cbsellipsis)
        then
        begin
          if Inspector.CanEditModify then
          begin { 3/21/00 - Check text property for cbsEllipsis style }
            EditText := TwwDBComboBox(Inspector.CurrentCustomEdit).Value;
            Inspector.FEditText := EditText;
          end
        end
        else
          EditText := TwwDBComboBox(Inspector.CurrentCustomEdit).Value;
      end
    end
    else
      inherited DropDown;
  end
end;

procedure TwwDataInspectorDataLink.DataSetChanged;
begin
  FObjectView.DataChanged;
  FModified := false;
end;

procedure TwwDataInspectorDataLink.Modified;
begin
  FModified := true;
end;

procedure TwwDataInspectorDataLink.Reset;
begin
  if FModified then
  begin
    RecordChanged(nil);
    FObjectView.InvalidateEditor;
  end
  else
    exit;
  { else begin
    if ((DataSource.DataSet.State = dsEdit) or (DataSource.DataSet.State = dsInsert)) and
    dataSet.modified then
    begin
    if MessageDlg(wwInternational.UserMessages.wwDBGridDiscardChanges,
    mtConfirmation, [mbYes,mbNo], 0)<>mrYes then exit;
    end;
    Dataset.Cancel;
    end }
end;

procedure TwwDataInspectorDataLink.UpdateData;
begin
  FInUpdateData := true;
  try
    if FModified then
      FObjectView.UpdateData;
    FModified := false;
  finally
    FInUpdateData := false;
  end;
end;

constructor TwwDataInspectorDataLink.Create(AObjectView: TwwDataInspector);
begin
  inherited Create;
  FObjectView := AObjectView;
  VisualControl := true;
end;

procedure TwwDataInspectorDataLink.EditingChanged;
begin
  FObjectView.EditingChanged;
end;

procedure TwwDataInspectorDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) or not FInUpdateData then
  begin
    FObjectView.RecordChanged(Field);
    FModified := false;
  end;

  if (Field <> Nil) and (Dataset.State in [dsEdit, dsInsert]) then
  begin
    FObjectView.FieldChanged(Field);
    FObjectView.TextIsSame := true;
  end
end;

procedure TwwDataInspectorDataLink.LayoutChanged;
begin
  { 11/15/99 - Fixes problem for active cell updating in detail query }
  FObjectView.InvalidateEditor;
  FObjectView.Invalidate;
  // FRecordViewPanel.LinkActive(Active);
end;

procedure TwwDataInspectorDataLink.ActiveChanged;
begin
  FObjectView.LinkActive(Active);
end;

procedure TwwDataInspectorDataLink.DataSetScrolled(Distance: Integer);
begin
  FObjectView.Scroll(Distance);
end;

{ TDrawGrid }

Function TwwDataInspector.MouseToItem(x, Y: Integer): TwwInspectorItem;
var
  ACol, ARow: Integer;
begin
  MouseToCell(x, Y, ACol, ARow);
  result := GetItemByRow(ARow);
end;

procedure TwwDataInspector.MouseToCell(x, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(x, Y);
  ACol := Coord.x;
  ARow := Coord.Y;
end;

Function GetCenterPoint(ARect: TRect): TPoint;
var
  R: TRect;
begin
  R := ARect;
  result.Y := R.Top + (wwRectHeight(R)) div 2;
  result.x := R.Left + (wwRectWidth(R)) div 2;
end;

procedure TwwInspectorIndicatorRow.Invalidate;
var
  R: TRect;
begin
  if Enabled then
  begin
    R := Inspector.CellRect(0, 0);
    R.right := Inspector.ClientWidth;
    InvalidateRect(Inspector.Handle, @R, true);
  end
end;

procedure TwwInspectorIndicatorRow.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Inspector.PaintOptions.Row1Color := Value;
    Inspector.PaintOptions.InitBlendBitmapsFlag := true;
    Invalidate;
  end
end;

procedure TwwInspectorIndicatorRow.SetTextAlignment(Value: TAlignment);
begin
  if FTextAlignment <> Value then
  begin
    FTextAlignment := Value;
    if Enabled then
      Inspector.invalidateCell(0, 0);
  end
end;

procedure TwwInspectorIndicatorRow.SetEnabled(Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Inspector.ApplySettings;
  end
end;

procedure TwwInspectorIndicatorRow.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if (Inspector.RowCount > 0) and Enabled then
      Inspector.RowHeights[0] := Value;
  end
end;

procedure TwwInspectorIndicatorRow.SetCaption(Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if Enabled then
      Inspector.invalidateCell(0, 0);
  end
end;

constructor TwwInspectorIndicatorRow.Create(Owner: TComponent);
begin
  Inspector := Owner as TwwDataInspector;
  FColor := clBtnFace;
end;

constructor TwwDataInspector.Create(AOwner: TComponent);
const
  bmArrow = 'WWINSPECTORARROW';
  bmEdit = 'WWINSPECTOREDIT';
  bmInsert = 'WWINSPECTORINSERT';
var
  Bmp: TBitmap;
begin
  inherited Create(AOwner);
  NewMouseRow := -1;
  // FAlternatingRowColor:=$00B1B1B1;
  // FActiveColumnColor:= clNOne;
  FPaintBitmap := TBitmap.Create;
  FPaintCanvas := FPaintBitmap.Canvas;
  ControlStyle := ControlStyle + [csReplicatable];

  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    FIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    FIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;

  SetFocusTabStyle := itsPreserveActiveItem;
  Color := clBtnFace;
  ScrollBars := ssVertical;
  FLineStyleData := ovDark3DLine;
  FLineStyleCaption := ovDark3DLine;
  FSaveCellExtents := false;

  FDottedLineColor := clBtnShadow;
  FDataLink := TwwDataInspectorDataLink.Create(self);
  FItems := TwwInspectorCollection.Create(self);
  // FSelected:= TStringList.create;
  // FControlType:= TStringList.create;
  FixedCols := 0;
  FCaptionIndent := 12;
  ColCount := 2;
  RowCount := 1;
  FixedRows := 0;
  FCaptionWidth := 100;

  inherited Options := [goColSizing, goTabs, goEditing, goAlwaysShowEditor];
  Options := [ovColumnResize, ovRowResize, ovHighlightActiveRow,
    ovCenterCaptionVert, ovEnterToTab];
  DefaultDrawing := false;

  FCaptionFont := TFont.Create;
  FCaptionFont.OnChange := CaptionFontChanged;
  FInactiveFocusColor := clNone;
  FButtonOptions := TwwInspectorButtonOptions.Create(self);
  FDataColumns := 1;
  FTreeLineColor := clWhite;

  FIndicatorRow := TwwInspectorIndicatorRow.Create(self);
  FPaintOptions := TwwGridPaintOptions.Create(self, FPaintBitmap);
  FPaintOptions.Row1Color := IndicatorRow.Color;
  FPaintOptions.Column1Color := CaptionColor;

  FixedDataRows := 0;

  if wwGridEssentials then
  begin
    DisplayProfessionalVersionOnlyMessage(self,
      'TwwDataInspector is only supported in the professional version');
  end;

end;

var
  KeyHook: HHOOK;

type
  TCheatCast = class(TwwDataInspector)
  end;

function wwHookKeyProc(nCode: Integer; wParam: Integer; lParam: Integer)
  : LResult; stdcall;
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;
var
  ac: TWinControl;
  Inspector: TwwDataInspector;

  Function IsChildOfInspector(var Inspector: TwwDataInspector): boolean;
  var
    tc: TWinControl;
  begin
    tc := screen.activecontrol;
    if not(tc is TwwDataInspector) then
    begin
      repeat
        tc := tc.parent;
      until (tc = nil) or (tc is TwwDataInspector);
    end;
    result := (tc is TwwDataInspector);
    if result then
      Inspector := TwwDataInspector(tc)
    else
      Inspector := nil;
  end;

  function Selection: TSelection;
  begin
    SendMessage(ac.Handle, EM_GETSEL, Longint(@result.StartPos),
      Longint(@result.EndPos));
  end;

  Function AllSelected: boolean;
  begin
    with ac do
      with Selection do
        result := (StartPos = 0) and (EndPos = GetTextLen);
  end;

  function RightSide: boolean;
  begin
    with ac do
      with Selection do
        result := ((StartPos = 0) or (EndPos = StartPos)) and
          (EndPos = GetTextLen);
  end;

  function LeftSide: boolean;
  begin
    with ac do
      with Selection do
        result := (StartPos = 0) and ((EndPos = 0) or (EndPos = GetTextLen)
          { or (isMasked and (EndPos=1)) } );
    if ac is TwwDBCustomEdit then
      with TwwDBCustomEdit(ac) do
        if isMasked and (Selection.EndPos = 1) then
          result := true;
  end;

  function IsInExpandedGrid: boolean;
  begin
    result := false;
    if (Inspector.parent is TwwDBGrid) then
      with TDrawGrid(Inspector.parent) do
      begin
        if Inspector.Height + 2 < RowHeights[Row] then
          result := true;
      end
  end;

  function TrueFocusIsGrid: boolean;
  begin
    result := IsChild(Inspector.Handle, GetFocus) or
      (GetFocus = Inspector.Handle);
  end;

begin
  ac := screen.activecontrol;
  if ac is TwwDataInspector then // inplaceeditor doesn't update ac
  begin
    if (TwwDataInspector(ac).InplaceEditor <> nil) and
      (TwwDataInspector(ac).InplaceEditor.Handle = GetFocus) then
    begin
      ac := TwwDataInspector(ac).InplaceEditor;
    end
  end;

  result := CallNextHookEx(KeyHook, nCode, wParam, lParam);
  if result = 1 then
    exit; // if someone else has processed the key then skip below code
  if ac = nil then
    exit;
  // if ImmGetOpenStatus(ImmGetContext(ac.handle))=True then exit; // 7/10/03 - Allow IME editor to handle keystrokes

  if ((wParam = 13) or (wParam = 9)) and not(GetKeyState(vk_control) < 0) and
    not(GetKeyState(vk_menu) < 0) and (GetFocus = ac.Handle) then
  begin
    if (lParam and $80000000) = 0 then
    begin
      if IsChildOfInspector(Inspector) then
      begin
        if (ovEnterToTab in Inspector.Options) or (wParam = vk_tab) then
        begin
          // 5/7/2002-PYW-Handles problem with main menu and return key.
          PostMessage(Inspector.Handle, WM_KEYDOWN, wParam, 0);
          result := 1;
        end
      end
    end
    else
      result := 1
  end
  else if (wParam = vk_f2) and not(GetKeyState(vk_control) < 0) and
    not(GetKeyState(vk_menu) < 0) then
  begin
    if IsChildOfInspector(Inspector) then
    begin
      if (lParam and $80000000) = 0 then
        Inspector.FCustomControlKeyMode := not Inspector.FCustomControlKeyMode;
    end
  end
  // Need obj property to see if we should pass vk_down, vk_up, vk_next, and vk_prior to inspector
  // Always pass vk_left, vk_right
  else if (wParam in [vk_right, vk_left, vk_down, vk_up, vk_next, vk_prior]) and
    ((lParam and $80000000) = 0) and (GetKeyState(vk_control) < 0) then
  begin
    if IsChildOfInspector(Inspector) and (ac <> Inspector) then
    begin
      PostMessage(Inspector.Handle, WM_KEYDOWN, wParam, 0);
      result := 1;
    end
  end
  else if (wParam in [vk_left, vk_right, vk_down, vk_up, vk_next, vk_prior]) and
    not(GetKeyState(vk_control) < 0) and not(GetKeyState(vk_menu) < 0) then
  begin
    if wwHaveVisibleChild(ac) then
      exit;

    if (lParam and $80000000) = 0 then
    begin
      if IsChildOfInspector(Inspector) then
      begin
        if not TrueFocusIsGrid then
          exit; // 4/4/03 - Don't process key if different window is open

        // Send to inspector navigation keys
        if (ac is TCustomEdit) then
        begin
          case wParam of
            vk_left:
              if (Inspector.parent is TwwDBGrid) then
              // 6/13/02 - Left arrow can leave inspector when inspector is in grid
              begin
                if (not IsInExpandedGrid) and AllSelected then
                begin
                  PostMessage(Inspector.parent.Handle, WM_KEYDOWN, wParam, 0);
                  result := 1;
                end;
                exit;
              end
              else if (Inspector.ColCount <= 2) or (not LeftSide) then
                exit;

            vk_right:
              if (Inspector.parent is TwwDBGrid) then
              // 6/13/02 - Left arrow can leave inspector when inspector is in grid
              begin
                if (not IsInExpandedGrid) and AllSelected then
                begin
                  PostMessage(Inspector.parent.Handle, WM_KEYDOWN, wParam, 0);
                  result := 1;
                end;
                exit;
              end
              else if (Inspector.ColCount <= 2) or (not RightSide) then
                exit;
            // VK_RIGHT: if (Inspector.ColCount<=2) or (not RightSide) then exit;
          end
        end;

        if Inspector.FCustomControlKeyMode then
          exit
        else
          PostMessage(Inspector.Handle, WM_KEYDOWN, wParam, 0);

        result := 1;
      end
    end
    else
      result := 1
  end

end;

destructor TwwDataInspector.Destroy;
begin
  if KeyHook <> 0 then
  begin
    UnhookWindowsHookEx(KeyHook);
    KeyHook := 0;
  end;
  FPaintOptions.Free;
  FIndicators.Free;
  FIndicators := nil;

  if Designer <> nil then
  begin
    Designer.Free;
  end;
  FreeHintWindow;
  if HintTimer <> nil then
  begin
    HintTimer.Enabled := false;
    HintTimer := nil;
  end;
  FDesigner := nil;
  FItems.Free;

  FCaptionFont.Free;
  FCaptionFont := Nil;

  FDataLink.Free;
  FDataLink := nil;
  FPaintBitmap.Free;
  FButtonOptions.Free;
  FIndicatorRow.Free;

  inherited;
end;

procedure TwwDataInspector.SetItems(Value: TwwInspectorCollection);
begin
  FItems.Assign(Value);
  // RowCount:= ActiveRows;
end;

procedure TwwDataInspector.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

Function TwwDataInspector.GetDataSource: TDataSource;
begin
  result := FDataLink.DataSource as TDataSource;
end;

Function TwwDataInspector.GetRowByItem(AItem: TwwInspectorItem): Integer;
var
  curIndex, i: Integer;
  found: boolean;
  function Scan(Item: TwwInspectorItem): boolean;
  var
    i: Integer;
  begin
    result := true;
    if Item = AItem then
      exit;
    inc(curIndex);
    if Item.Expanded then
    begin
      for i := 0 to Item.Items.Count - 1 do
        if Item.Items[i].Visible and Scan(Item.Items[i]) then
        begin
          result := true;
          exit;
        end
    end;
    result := false;
  end;

begin
  if IndicatorRow.Enabled then
    curIndex := 1
  else
    curIndex := 0;
  found := false;
  for i := 0 to Items.Count - 1 do
    if Items[i].Visible and Scan(Items[i]) then
    begin
      found := true;
      break;
    end;
  if not found then
    curIndex := -1;
  result := curIndex;
end;

Procedure TwwDataInspector.GetActiveRowsCallback(Item: TwwInspectorItem;
  UserData: Pointer; var AContinue: boolean);
begin
  if Item.Visible then
    PInteger(UserData)^ := PInteger(UserData)^ + 1;
end;

Procedure TwwDataInspector.GetActiveItemCallback(Item: TwwInspectorItem;
  UserData: Pointer; var AContinue: boolean);
begin
  if Item.Visible then
  begin
    if PInteger(UserData)^ = Row then
    begin
      AContinue := false;
      FActiveItem := Item;
    end
    else
      PInteger(UserData)^ := PInteger(UserData)^ + 1;
  end
end;

Function TwwDataInspector.GetActiveRows: Integer;
var
  ActiveRowCount: Integer;
begin
  if IndicatorRow.Enabled then
    ActiveRowCount := 1
  else
    ActiveRowCount := 0;
  IterateItems(GetActiveRowsCallback, true, @ActiveRowCount);
  result := ActiveRowCount;
end;

Function TwwDataInspector.RefreshActiveItem: TwwInspectorItem;
var
  ActiveRowCount: Integer;
begin
  if FastDesign then
  begin
    if IndicatorRow.Enabled then
      ActiveRowCount := 1
    else
      ActiveRowCount := 0;
    IterateItems(GetActiveItemCallback, true, @ActiveRowCount);
    result := FActiveItem;
  end
  else
    result := ActiveItem;
end;

function TwwDataInspector.GetFirstChild(VisibleItemsOnly: boolean = true)
  : TwwInspectorItem;
var
  i: Integer;
begin
  result := nil;

  for i := 0 to Items.Count - 1 do
  begin
    if (not VisibleItemsOnly) or TwwInspectorItem(Items[i]).Visible then
    begin
      result := TwwInspectorItem(Items[i]);
      break;
    end
  end;
end;

Function TwwDataInspector.GetTopItem: TwwInspectorItem;
begin
  if FTopItem = nil then
  begin
    FTopItem := GetFirstChild;
  end;

  if not FastDesign then
  begin
    FTopItem := GetItemByRow(TopRow);
  end;

  result := FTopItem;
end;

Function TwwDataInspector.GetItemByRow(ARow: Integer; Optimize: boolean = true)
  : TwwInspectorItem;
var
  curIndex: Integer;
  RetObjItem: TwwInspectorItem;
  i: Integer;

  function Scan(Item: TwwInspectorItem): boolean;
  var
    i: Integer;
  begin
    if not Item.Visible then
    begin
      result := false;
      exit;
    end;

    result := true;

    inc(curIndex);
    if curIndex = ARow then
    begin
      RetObjItem := Item;
      exit;
    end;
    if Item.Expanded then
    begin
      for i := 0 to Item.Items.Count - 1 do
        if Scan(Item.Items[i]) then
          break;
    end;
    result := false;
  end;

begin
  if Optimize and FastDesign then
  begin
    if ARow = Row then
    begin
      result := ActiveItem;
      exit;
    end
    else if (ARow >= TopRow) and (ARow <= TopRow + 100) then
    begin
      RetObjItem := TopItem;
      if RetObjItem <> nil then
      begin
        for i := 1 to ARow - TopRow do
          RetObjItem := RetObjItem.GetNext(true);
      end;
      result := RetObjItem;
      exit;
    end
  end;

  if Row < 0 then
  begin
    result := nil;
    exit;
  end;

  curIndex := -1;
  if IndicatorRow.Enabled then
    curIndex := 0;
  RetObjItem := nil;
  for i := 0 to Items.Count - 1 do
    if Scan(Items[i]) then
      break;
  result := RetObjItem;
end;

Function TwwDataInspector.GetItemByCaption(ACaption: string): TwwInspectorItem;
var
  curItem: TwwInspectorItem;
begin
  result := nil;
  curItem := GetFirstChild(false);
  ACaption := AnsiUppercase(ACaption);

  while curItem <> nil do
  begin
    if AnsiUppercase(curItem.Caption) = ACaption then
    begin
      result := curItem;
      break;
    end;
    curItem := curItem.GetNext(false);
  end;
end;

Function TwwDataInspector.GetItemByTagString(ATagString: string)
  : TwwInspectorItem;
var
  curItem: TwwInspectorItem;
begin
  result := nil;
  curItem := GetFirstChild(false);
  ATagString := AnsiUppercase(ATagString);

  while curItem <> nil do
  begin
    if AnsiUppercase(curItem.TagString) = ATagString then
    begin
      result := curItem;
      break;
    end;
    curItem := curItem.GetNext(false);
  end;
end;

Function TwwDataInspector.GetItemByFieldName(AFieldName: string)
  : TwwInspectorItem;
var
  curItem: TwwInspectorItem;
begin
  result := nil;
  curItem := GetFirstChild(false);
  AFieldName := AnsiUppercase(AFieldName);

  while curItem <> nil do
  begin
    if AnsiUppercase(curItem.DataField) = AFieldName then
    begin
      result := curItem;
      break;
    end;
    curItem := curItem.GetNext(false);
  end;
end;

function TwwDataInspector.ButtonPt(ARect: TRect; obj: TwwInspectorItem): TPoint;
var
  pt: TPoint;
  MinY: Integer;
  tempHeight: Integer;
begin
  if obj = nil then
    exit;

  if ovCenterCaptionVert in Options then
  begin
    MinY := (Canvas.TextHeight('Y') + 2) div 2;
    pt.Y := ARect.Top + wwMax(MinY, (ARect.Bottom - ARect.Top - 2) div 2);
  end
  else
  begin

    tempHeight := Canvas.TextHeight('Y') + 2;
    if (not obj.Expanded) and (ButtonOptions.ExpandGlyph.Handle <> 0) then
      tempHeight := wwMax(ButtonOptions.ExpandGlyph.Height, tempHeight)
    else if (obj.Expanded) and (ButtonOptions.CollapseGlyph.Handle <> 0) then
      tempHeight := wwMax(ButtonOptions.CollapseGlyph.Height, tempHeight);

    pt.Y := ARect.Top + (tempHeight) div 2;
  end;
  pt.x := ARect.Left + (obj.Level) * CaptionIndent + (CaptionIndent div 2) + 1;
  result := pt;
end;

function TwwDataInspector.CheckboxRect(ARect: TRect;
  obj: TwwInspectorItem): TRect;
var
  cp: TPoint;
  offset: Integer;
begin
  cp := GetCenterPoint(ARect);
  offset := 5;
  result := Rect(ARect.Left + 3, cp.Y - offset - 2, ARect.Left + 3 * offset + 5,
    cp.Y + offset + 1);
end;

procedure TwwDataInspector.DoDrawCaptionCell(ObjItem: TwwInspectorItem;
  ASelected: boolean; ACellRect: TRect; var ACaptionRect: TRect;
  var DefaultTextDrawing: boolean);
begin
  if Assigned(FOnDrawCaptionCell) then
    FOnDrawCaptionCell(self, ObjItem, ASelected, ACellRect, ACaptionRect,
      DefaultTextDrawing);
end;

procedure TwwDataInspector.DoDrawDataCell(ObjItem: TwwInspectorItem;
  ASelected: boolean; ACellRect: TRect; var DefaultDrawing: boolean);
begin
  if Assigned(FOnDrawDataCell) then
  begin
    FOnDrawDataCell(self, ObjItem, ASelected, ACellRect, DefaultDrawing);
  end;
end;

{ procedure TwwDataInspector.DoDrawIndicatorCell(ObjItem: TwwInspectorItem;
  ACellRect: TRect;
  var DefaultDrawing: boolean);
  begin
  if Assigned(FOnDrawIndicatorCell) then
  begin
  FOnDrawIndicatorCell(self, ObjItem, ACellRect, DefaultDrawing);
  end;
  end;
}
function TwwDataInspector.isFocused: boolean;
begin
  result := (screen.activecontrol = self) or
  { 3/6/00 - Check for nil active control }
    (Assigned(screen.activecontrol) and (screen.activecontrol.parent = self))
end;

Function TwwDataInspector.IsDefaultDateTimePicker
  (obj: TwwInspectorItem): boolean;
begin
  result := (iioAutoDateTimePicker in obj.Options) and
    (obj.Field is TDateTimeField)
end;

Function TwwDataInspector.IsDefaultLookupCombo(obj: TwwInspectorItem): boolean;
begin
  result := (iioAutoLookupCombo in obj.Options) and (obj.Field <> nil) and
    (obj.Field.Lookup)
end;

function TwwInspectorItem.GetChecked: boolean;
var
  Value: string;
begin
  if Field = nil then
    Value := EditText
  else
    Value := Field.Text;
  result := (PickList.Items.Count > 0) and (Value = PickList.Items[0]);
end;

procedure TwwInspectorItem.SetChecked(val: boolean);
begin
  if PickList.Items.Count < 2 then
    exit;

  if Field <> nil then
  begin
    if not TwwDataInspector(Control).CanEditModify then
      exit;
    if val then
      Field.Text := PickList.Items[0]
    else
      Field.Text := PickList.Items[1];
    EditText := Field.Text;
  end
  else
  begin
    if val then
      EditText := PickList.Items[0]
    else
      EditText := PickList.Items[1]
  end;

end;

procedure TwwDataInspector.DoCalcDataPaintText(Item: TwwInspectorItem;
  var PaintText: string);
begin
  if Assigned(FOnCalcDataPaintText) then
    FOnCalcDataPaintText(self, Item, PaintText);
end;

{ procedure TwwInspectorItem.ComboDropDownEvent(Sender: TObject);
  var inspector: TwwDataInspector;
  begin
  if Assigned(FOnEditButtonClick) then begin
  inspector:= Control as TwwDataInspector;
  FOnEditButtonClick(Inspector, self);
  if Inspector.CurrentCustomEdit is TwwDBComboBox then
  EditText:= TwwDBComboBox(Inspector.CurrentCustomEdit).value;
  end
  end;
}

Function TwwInspectorItem.UseDefaultComboBox: boolean;
begin
  result := not(PickList.DisplayAsCheckbox) and (PickList.Items.Count > 0) or
    Assigned(FOnEditButtonClick)
end;

function TwwInspectorItem.GetDisplayText: string;
begin
  result := GetMappedPaintText(EditText);
end;

procedure TwwInspectorItem.SetEditText(val: string);
begin
  if FEditText <> val then
  begin
    FEditText := val;
  end
end;

procedure TwwInspectorItem.SetDisplayText(val: string);
var
  i, curpos: Integer;
  DisplayVal, StoredVal, OrigEditText: string;

  procedure UpdateActiveEdit;
  begin
    { If active control then update the control as well }
    if (Control is TwwDataInspector) then
      with (Control as TwwDataInspector) do
      begin
        if ActiveItem = self then
        begin
          if CurrentCustomEdit <> nil then
          begin
            TEdit(CurrentCustomEdit).Text := val
          end
          else if UseDefaultEditor and (InplaceEditor <> nil) then
          begin
            InplaceEditor.Text := val;
          end
        end
      end;
  end;

begin
  OrigEditText := EditText;

  if (not PickList.MapList) then
  begin
    EditText := val;
    UpdateActiveEdit; // 12/4/00
    if EditText <> OrigEditText then
      DoItemTextChanged;
    exit;
  end;

  for i := 0 to PickList.Items.Count - 1 do
  begin
    curpos := 1;
    DisplayVal := strGetToken(PickList.Items[i], #9, curpos);
    StoredVal := strGetToken(PickList.Items[i], #9, curpos);
    if wwEqualStr(DisplayVal, val) then
    begin
      EditText := StoredVal;
      break;
    end
  end;

  { If active control then update the control as well }
  UpdateActiveEdit;
  if EditText <> OrigEditText then
    DoItemTextChanged;

end;

Function TwwInspectorItem.GetMappedPaintText(StoredValue: string): string;
var
  i, curpos: Integer;
  DisplayVal: string;
begin
  result := '';

  { if Field=nil then
    StoredValue:= EditText
    else StoredValue:= Field.asString;
  }
  if not PickList.MapList then
  begin
    result := StoredValue;
    exit;
  end;

  for i := 0 to PickList.Items.Count - 1 do
  begin
    curpos := 1;
    DisplayVal := strGetToken(PickList.Items[i], #9, curpos);
    if strGetToken(PickList.Items[i], #9, curpos) = StoredValue then
    begin
      result := DisplayVal;
      break;
    end
  end;
end;

function sameRect(rect1, rect2: TRect): boolean;
begin
  result := (rect1.Left = rect2.Left) and (rect1.right = rect2.right) and
    (rect1.Top = rect2.Top) and (rect1.Bottom = rect2.Bottom);
end;

function TwwDataInspector.ControlRect(ACol, ARow: Integer): TRect;
begin
  result := CellRect(ACol, ARow);
  result.Left := result.Left + 1;
  // if ColCount>2 then
  if ovActiveRecord3DLines in Options then
    result.right := result.right - 1
  else
    result.right := result.right - 1;
  result.Top := result.Top;
  result.Bottom := result.Top + RowHeights[ARow] - 1; // obj.cellHeight;
end;

procedure TwwDataInspector.FillWithAlternatingRowBitmap(TempRect: TRect);
begin
  if PaintOptions.AlternatingColorBitmap <> nil then
    Canvas.CopyRect(TempRect,
      PaintOptions.AlternatingColorBitmap.Canvas, TempRect)
  else
  begin
    Canvas.Brush.Color := PaintOptions.AlternatingRowColor;
    Canvas.FillRect(TempRect);
  end
end;

procedure TwwDataInspector.FillWithFixedBitmap(TempRect: TRect;
  CurRelRow: Integer);
begin
  if (PaintOptions.AlternatingRowColor <> clNone) and
    (arrFixedColumns in PaintOptions.AlternatingRowRegions) and (CurRelRow >= 0)
    and Odd(CurRelRow) then
  begin
    FillWithAlternatingRowBitmap(TempRect);
  end
  else if (not wwIsCustomStyle(self)) and (PaintOptions.Column1Bitmap <> nil)
  then
  // else if PaintOptions.Column1Bitmap <> nil then
  begin
    Canvas.CopyRect(TempRect, PaintOptions.Column1Bitmap.Canvas, TempRect);
  end
  else if (parent is TwwDBGrid) and (CaptionColor = clNone) then
  begin
    // if not (csPaintCopy in ControlState) then
    // TwwDBGrid(parent).PaintActiveRowBackground(Canvas, TempRect);
  end
  else if not Assigned(FOnBeforePaint) and (CaptionColor <> clNone) then
  begin
    Canvas.Brush.Color := PaintOptions.Column1Color;
    Canvas.FillRect(TempRect);
  end
end;

procedure TwwDataInspector.DisplayIndicatorCell(ACol: Integer; ARect: TRect);
const
  AlignFlags: array [TAlignment] of Integer = (DT_LEFT or DT_EXPANDTABS or
    DT_NOPREFIX, DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
var
  Indicator: Integer;
  Indicator_style: TThemedGrid;

  ALeft: Integer;
  Flags: Integer;
  DefaultDrawing: boolean;
  Function GetTitleRect: TRect;
  var
    TitleRect: TRect;
  begin
    result := TitleRect;
  end;

begin
  DefaultDrawing := true;
  if Assigned(FOnDrawIndicatorCell) then
  begin
    FOnDrawIndicatorCell(self, ACol, ARect, DefaultDrawing);
    if not DefaultDrawing then
      exit;
  end;

  if (ACol = 0) and (IndicatorRow.Caption <> '') then
  begin
    SetBkMode(Canvas.Handle, TRANSPARENT);
    if IndicatorRow.TextAlignment = taLeftJustify then
      ARect := Rect(ARect.Left + CaptionIndent, ARect.Top + 1, ARect.right,
        ARect.Bottom)
    else
      ARect := Rect(ARect.Left, ARect.Top + 1, ARect.right, ARect.Bottom);

    try
      Flags := AlignFlags[IndicatorRow.TextAlignment];
      DrawText(Canvas.Handle, PChar(IndicatorRow.Caption),
        length(IndicatorRow.Caption), ARect, Flags);
    finally
      SetBkMode(Canvas.Handle, OPAQUE);
    end
  end;

  if (not FDataLink.Active) or ((ACol - 1) <> FDataLink.ActiveRecord) then
    exit;

  ALeft := wwMax(0, ((ARect.right + ARect.Left) - FIndicators.Width) div 2);

  if wwIsCustomStyle(self) then
  begin
    Indicator_style := tgIndicatorArrow;
    if FDataLink.Dataset <> nil then
      case FDataLink.Dataset.State of
        dsEdit:
          Indicator_style := tgIndicatorEdit;
        dsInsert:
          Indicator_style := tgIndicatorInsert;
        dsBrowse:
          ;
      end;

    StyleServices.DrawElement(Canvas.Handle,
      StyleServices.GetElementDetails(Indicator_style), ARect)
  end
  else
  begin
    Indicator := 0;
    if FDataLink.Dataset <> nil then
    begin
      case FDataLink.Dataset.State of
        dsEdit:
          Indicator := 1;
        dsInsert:
          Indicator := 2;
        dsBrowse:
          ;
      end;
    end;

    FIndicators.Draw(Canvas, ALeft,
      (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator, true);
  end
end;

procedure TwwDataInspector.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  obj: TwwInspectorItem;
  CustomEdit: TWinControl;
  // FoundCustomEdit: boolean;
  DrawTextRect, TitleRect: TRect;
  TextHeight: Integer;
  Flags: Integer;
  DefaultDrawing, DefaultTextDrawing: boolean;
  // LookupCombo: TwwDBLookupCombo;
  PaintText: string;
  StoredValue: string;
  OldActiveRecord: Integer;
  // bm: TBitmap;
  TempRect: TRect;
  savedDC: Integer;
  BackRect: TRect;
  NoData: boolean;
  IsCustomStyle: boolean;
  WriteOptions: TwwWriteTextOptions;
  canShow: boolean;

  procedure PaintInactiveCustomControl;
  var
    exStyle, origStyle: Longint;
    TempRect: TRect;

    procedure PaintControl(Control: TWinControl; ARect: TRect);
    var
      i: Integer;
      SaveIndex: Integer;
    begin
      Control.ControlState := Control.ControlState + [csPaintCopy];
      SaveIndex := SaveDC(Canvas.Handle);
      MoveWindowOrg(Canvas.Handle, ARect.Left, ARect.Top);
      IntersectClipRect(Canvas.Handle, 0, 0, ARect.right - ARect.Left,
        ARect.Bottom - ARect.Top);
      Control.Perform(WM_PAINT, Canvas.Handle, ARect.Bottom - ARect.Top);
      with Control do
      begin
        for i := 0 to ControlCount - 1 do
        begin
          if Controls[i] is TWinControl then
            with TWinControl(Controls[i]) do
              if Visible then
                PaintTo(Canvas.Handle, Left, Top);
        end
      end;
      RestoreDC(Canvas.Handle, SaveIndex);
      Control.ControlState := Control.ControlState - [csPaintCopy];
    end;

  begin
    CustomEdit := obj.CustomControl;
    InitCustomEdit(CustomEdit, obj);

    if (obj.DataField = '') or (obj.DataSource = nil) then
    begin
      CustomEdit.HandleNeeded;
      if CustomEdit is TCustomEdit then
        TEdit(CustomEdit).Text := obj.EditText;
    end;

    TempRect := ControlRect(ACol, ARow);
    if (TempRect.right - TempRect.Left <> CustomEdit.Width) or
      (TempRect.Bottom - TempRect.Top <> CustomEdit.Height) then
    begin
      CustomEdit.Width := TempRect.right - TempRect.Left;
      CustomEdit.Height := TempRect.Bottom - TempRect.Top;
    end;
    // if (customEdit.Width<>ARect.Right-ARect.Left-2) or
    // (customEdit.Height<>ARect.Bottom-ARect.Top-1) then
    // begin
    // customEdit.width:= ARect.Right-ARect.Left-2;
    // customEdit.Height:= ARect.Bottom-ARect.Top-1;
    // end;
    // customEdit.BoundsRect:= ControlRect(ACol, ARow);

    begin
      origStyle := Windows.GetWindowLong(CustomEdit.Handle, GWL_EXSTYLE);
      exStyle := origStyle or WS_EX_TRANSPARENT;

      Canvas.Lock;
      try
        Windows.SetWindowLong(CustomEdit.Handle, GWL_EXSTYLE, exStyle);
        { if (ARow=Row) and (ACol=Col) then
          begin
          Canvas.Brush.Color:= clHighlight;
          Canvas.FillRect(ARect);
          end;
        }
        SetBkMode(Canvas.Handle, TRANSPARENT);
        if (CustomEdit is TwwDBRichEdit) and (obj.Field <> nil) and false then
        begin
          if TempRichEdit = Nil then
          begin
            TempRichEdit := TwwDBRichEdit.Create(self);
            TempRichEdit.Visible := false;
            TempRichEdit.parent := self;
            TempRichEdit.BorderStyle := bsNone;
            if csDesigning in ComponentState
            then { otherwise shows up at design time }
              ShowWindow(TempRichEdit.Handle, sw_hide);
            Windows.SetWindowLong(TempRichEdit.Handle, GWL_EXSTYLE, exStyle);
          end;
          TempRichEdit.Lines.Assign(obj.Field);
          TempRect := ARect;
          TempRect.Bottom := TempRect.Bottom - 2;
          TempRect.right := TempRect.right - 6;
          TempRichEdit.BoundsRect := TempRect; // customEdit.BoundsRect;
          TempRichEdit.PaintTo(Canvas.Handle, TempRect.Left, TempRect.Top);
        end
        else // customEdit.PaintTo(Canvas.Handle, ARect.Left+1, ARect.Top);
        begin
          TempRect := ARect;
          TempRect.Left := TempRect.Left + 1;
          PaintControl(CustomEdit, TempRect);
        end;

      finally
        SetBkMode(Canvas.Handle, OPAQUE);
        Canvas.Unlock;
        Windows.SetWindowLong(CustomEdit.Handle, GWL_EXSTYLE, origStyle);
        // customEdit.Update;
      end;

    end;

  end;

  procedure PaintCheckbox;
  const
    MaxCheckboxSize = 6;
    ItemChecked: array [boolean] of Integer = (0, DFCS_CHECKED);
    Grayed: array [boolean] of Integer = (0, DFCS_INACTIVE);
  var
    Value: string;
{$IFDEF wwUseThemeManager}
    val: boolean;
    CheckboxStyle: TThemedButton;
    Details: TThemedElementDetails;
    PaintRect: TRect;
    sp, cp: TPoint;
    cr: TRect;
{$ENDIF}
  begin
    if (obj.Field = nil) then
      Value := obj.EditText
    else if (obj.Field.Dataset <> nil) and obj.Field.Dataset.Active then
      Value := obj.Field.Text
    else
      Value := obj.EditText;

    if wwUseThemes(self) then
    begin
{$IFDEF wwUseThemeManager}
      val := Value = obj.PickList.Items[0];
      if obj.ReadOnly or (not obj.Enabled) then
      begin
        if val then
          CheckboxStyle := tbCheckboxCheckedDisabled
        else
          CheckboxStyle := tbCheckboxUnCheckedDisabled
      end
      else
      begin
        GetCursorPos(cp);
        sp := self.ScreenToClient(cp);
        cr := CellRect(ACol, ARow);

        // Only change mouseover for active record
        // 5/8/03 - Don't do hot-tracking for csPaintCopy state
        if (ptinrect(cr, sp)) and (Col = ACol) and
          not(csPaintCopy in ControlState) then
        begin
          HotCol := ACol;
          HotRow := ARow;
          if val then
            CheckboxStyle := tbCheckboxCheckedHot
          else
            CheckboxStyle := tbCheckboxUnCheckedHot
        end
        else
        begin
          if val then
            CheckboxStyle := tbCheckboxCheckedNormal
          else
            CheckboxStyle := tbCheckboxUnCheckedNormal
        end;
      end;
      Details := StyleServices.GetElementDetails(CheckboxStyle);
      PaintRect := CheckboxRect(ARect, obj);
      StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
{$ENDIF}
    end
    else
      DrawFrameControl(Canvas.Handle, CheckboxRect(ARect, obj), DFC_BUTTON,
        Grayed[not obj.Enabled] or DFCS_BUTTONCHECK or
        ItemChecked[Value = obj.PickList.Items[0]]);
  end;

  procedure PaintButton;
  var
    pt: TPoint;
    offset: Integer;
    OrigColor: TColor;
    buttonsize: Integer;
    buttonoffset: Integer;
    src, Dest: TRect;
{$IFDEF wwUseThemeManager}
    buttonRect: TRect;
    Style: TThemedTreeview;
    Details: TThemedElementDetails;
{$ENDIF}
  begin
    pt := ButtonPt(ARect, obj);
    obj.ButtonPoint := pt;

    if not obj.Expanded then
    begin
      with ButtonOptions.ExpandGlyph do
      begin
        if Handle <> 0 then
        begin
          src := Rect(0, 0, Width, Height);
          src.Bottom := wwMin(Height, ARect.Bottom - ARect.Top - 1);
          Dest.Left := pt.x - (Width div 2);
          if ovCenterCaptionVert in Options then
            Dest.Top := pt.Y - ((Height - 1) div 2)
          else
            Dest.Top := pt.Y - (Height div 2);
          Dest.right := Dest.Left + src.right;
          Dest.Bottom := Dest.Top + src.Bottom;
          if ButtonOptions.TransparentGlyphs then
          begin
            TransparentMode := tmAuto;
            TRANSPARENT := true;
            self.Canvas.Draw(Dest.Left, Dest.Top, ButtonOptions.ExpandGlyph);
          end
          else
            self.Canvas.CopyRect(Dest, Canvas, src);
          exit;
        end
      end
    end
    else
    begin
      with ButtonOptions.CollapseGlyph do
      begin
        if Handle <> 0 then
        begin
          src := Rect(0, 0, Width, Height);
          src.Bottom := wwMin(Height, ARect.Bottom - ARect.Top - 1);
          Dest.Left := pt.x - (Width div 2);
          if ovCenterCaptionVert in Options then
            Dest.Top := pt.Y - ((Height - 1) div 2)
          else
            Dest.Top := pt.Y - (Height div 2);
          Dest.right := Dest.Left + src.right;
          Dest.Bottom := Dest.Top + src.Bottom;

          if ButtonOptions.TransparentGlyphs then
          begin
            TransparentMode := tmAuto;
            TRANSPARENT := true;
            self.Canvas.Draw(Dest.Left, Dest.Top, ButtonOptions.CollapseGlyph);
          end
          else
            self.Canvas.CopyRect(Dest, Canvas, src);

          exit;
        end
      end
    end;

    if wwUseThemes(self) then
    begin
{$IFDEF wwUseThemeManager}
      buttonsize := 5;
      buttonoffset := 0;
      buttonRect := Rect(pt.x - buttonsize, pt.Y - (buttonsize - 1) +
        buttonoffset, pt.x + buttonsize - 1, pt.Y + buttonsize + buttonoffset);
      if obj.Expanded then
        Style := ttGlyphOpened
      else
        Style := ttGlyphClosed;
      Details := StyleServices.GetElementDetails(Style);
      StyleServices.DrawElement(Canvas.Handle, Details, buttonRect);
      exit;
{$ENDIF}
    end;
    buttonsize := 5;
    buttonoffset := 0;
    OrigColor := Canvas.Brush.Color;
    offset := 2;
    Canvas.Brush.Color := clWindow;
    Canvas.FillRect(Rect(pt.x - (buttonsize - 2), pt.Y - (buttonsize - 1) +
      buttonoffset, pt.x + buttonsize - 2, pt.Y + buttonsize - 1 +
      buttonoffset));
    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(pt.x - buttonsize, pt.Y - (buttonsize - 1) + buttonoffset,
      pt.x + buttonsize - 1, pt.Y + buttonsize + buttonoffset);
    Canvas.Pen.Color := clBlack;
    if not obj.Expanded then
      Canvas.Polyline([Point(pt.x - 1, pt.Y - offset + buttonoffset),
        Point(pt.x - 1, pt.Y + offset + 1 + buttonoffset)]);
    Canvas.Polyline([Point(pt.x - offset - 1, pt.Y + buttonoffset),
      Point(pt.x + offset, pt.Y + buttonoffset)]);
    Canvas.Brush.Color := OrigColor;
  end;

  Function GetTitleRect: TRect;
  var
    TitleRect: TRect;
  begin
    TitleRect := Rect(ARect.Left + (obj.Level + 1) * CaptionIndent,
      ARect.Top + 1, ARect.right, ARect.Bottom);
    result := TitleRect;
  end;

  function DefaultDrawCell(obj: TwwInspectorItem): boolean;
  var
    Hold: Integer;
    DefaultDrawing: boolean;
  begin
    DefaultDrawing := true;
    if Assigned(FOnDrawDataCell) then
    begin
      if UseRightToLeftAlignment then
      begin
        ARect.Left := ClientWidth - ARect.Left;
        ARect.right := ClientWidth - ARect.right;
        Hold := ARect.Left;
        ARect.Left := ARect.right;
        ARect.right := Hold;
        ChangeOrientation(false);
      end;
      ARect.Bottom := ARect.Bottom - 1;
      obj.ActiveRecord := ACol = Col;
      DoDrawDataCell(obj, ARow = Row, ARect, DefaultDrawing);
      // FOnDrawDataCell(Self, Obj, ARow=Row, ARect, DefaultDrawing);
      ARect.Bottom := ARect.Bottom + 1;
      if UseRightToLeftAlignment then
        ChangeOrientation(true);
    end;

    result := DefaultDrawing;
  end;

  Function CustomEditHasFocus: boolean;
  var
    ac: TWinControl;
  begin
    // 7/16/01 - Inspector in grid should always paint custom controls
    if csPaintCopy in ControlState then
    begin
      result := false;
      exit;
    end;
    if ((Row <> ARow) or (Col <> ACol)) then
    begin
      result := false;
      exit;
    end;

    result := false;
    ac := screen.activecontrol;
    if (ac <> nil) then
    begin
      if (ac = obj.CustomControl) or (ac.parent = obj.CustomControl) then
        result := true;
    end;
  end;

begin
  if UseTempCanvas then
  begin
    // if (ACol=1) and (not UseCheckbox(ARow)) then exit { Paint caption area only }
  end
  else
  begin
    if (ACol = 0) or UseCheckbox(ARow) then
      exit; { Paint data area only }
  end;
  IsCustomStyle := wwIsCustomStyle(self);
  if IndicatorRow.Enabled and (ARow = 0) then
  begin
    Canvas.Font.Assign(FCaptionFont);
    if (PaintOptions.Row1Bitmap <> nil) and (not IsCustomStyle) then
    begin
      if ovHideVertFixedLines in Options then
        TempRect := Rect(ARect.Left, ARect.Top, ARect.right, ARect.Bottom)
      else
        TempRect := Rect(ARect.Left + 1, ARect.Top, ARect.right - 1,
          ARect.Bottom);
      Canvas.CopyRect(TempRect, PaintOptions.Row1Bitmap.Canvas, TempRect);
      DisplayIndicatorCell(ACol, ARect);
    end
    else
    begin
      Canvas.Brush.Color := IndicatorRow.Color;
      if IsCustomStyle then
        wwPaintFixedGridCellBackgroundColor(self, Canvas,
          Rect(ARect.Left + 1, ARect.Top - 1, ARect.right - 1, ARect.Bottom))
        // This should change to paint fixedcol color
      else
        Canvas.FillRect(Rect(ARect.Left + 1, ARect.Top - 1, ARect.right - 1,
          ARect.Bottom));
      DisplayIndicatorCell(ACol, ARect);
    end;
    exit;
  end;

  obj := GetItemByRow(ARow);

  if obj = nil then
    exit;

  if FDataLink.Active and ((ACol > 1) or ((ACol > 0) and (ColCount > 2))) then
  begin
    NoData := false;
    if (FDataLink.RecordCount = 0) and (ACol > 1) then
      NoData := true; // If no record, then only paint 1 data column
    if (FDataLink.RecordCount <> 0) and (FDataLink.RecordCount <= ACol - 1) then
      NoData := true;
    if NoData then
    begin
      TempRect := Rect(ARect.Left, ARect.Top, ARect.right - 1, ARect.Bottom);
      TempRect.Left := TempRect.Left - 1;
      if (not IsCustomStyle) and PaintOptions.HaveBackgroundForDataCells then
      begin
        Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.Canvas, TempRect);
      end
      else
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(TempRect);
      end;
      exit;
    end;

    OldActiveRecord := FDataLink.ActiveRecord;
    FDataLink.ActiveRecord := ACol - 1;
  end
  else
    OldActiveRecord := -1;

  savedDC := 0;
  BackRect := ARect;
  BackRect.Left := ARect.Left - 1;
  // if ovHideVertDataLines in Options then ARect.Left:= ARect.Left -1;

  try
    with obj do
    begin

      if ACol = 0 then
      begin
        Canvas.Font.Assign(FCaptionFont); // 12/30/02 - Initialize caption font
        if (InactiveFocusColor = clNone) or (ARow <> Row) or isFocused then
          Canvas.Brush.Color := FixedColor
        else
          Canvas.Brush.Color := InactiveFocusColor;
        if (PaintCopyTextColor <> clNone) and (csPaintCopy in ControlState) then
        begin
          // 11/24/02 - if background is clnone, then use grid's choice of font since we are transparent
          // otherwise reset captionfont color
          if (CaptionColor = clNone) then
          begin
            Canvas.Font.Color := PaintCopyTextColor;
          end
          else
            Canvas.Font.Color := CaptionFont.Color;
        end;

        try
          TitleRect := GetTitleRect;

          SetBkMode(Canvas.Handle, TRANSPARENT);
          WriteOptions := [wtoTransparent];

          Flags := DT_LEFT or DT_END_ELLIPSIS { or DT_WORDBREAK };
          TextHeight := DrawText(Canvas.Handle, PChar(obj.Caption),
            length(obj.Caption), TitleRect, Flags or DT_CALCRECT);
          TitleRect := GetTitleRect;
          if ovCenterCaptionVert in self.Options then
          begin
            TitleRect.Top := TitleRect.Top +
              ((TitleRect.Bottom - TitleRect.Top) - (TextHeight + 2)) div 2;
          end;

          SetBkMode(Canvas.Handle, TRANSPARENT);
          { could be reset by PaintButton }
          DefaultTextDrawing := true;
          ARect.right := ARect.right - 1;
          if IsCustomStyle then
          begin
            wwPaintFixedGridCellBackgroundColor(self, Canvas, ARect);
          end

          else
            FillWithFixedBitmap(ARect, ARow);

          DoDrawCaptionCell(obj, (ARow = Row), ARect, TitleRect,
            DefaultTextDrawing);
          ARect.Bottom := ARect.Bottom + 1;
          ARect.right := ARect.right + 1;

          if DefaultTextDrawing then
          begin
            if IsCustomStyle then
            begin
              WriteTitleLines(Canvas, TitleRect, 0, 0,
                 PWideChar(obj.caption), Alignment, WriteOptions)
            end
            else
              DrawText(Canvas.Handle, PChar(obj.Caption), length(obj.Caption),
                TitleRect, Flags);
            if obj.HaveVisibleItem then
              PaintButton;
            PaintLines(obj);
          end
        finally
          SetBkMode(Canvas.Handle, OPAQUE);
        end

      end
      else
      begin
        Canvas.Font.Assign(self.Font);
        if (PaintCopyTextColor <> clNone) and (csPaintCopy in ControlState) then
        begin
          Canvas.Font.Color := PaintCopyTextColor;
        end;
        if (InactiveFocusColor = clNone) or (ARow <> Row) or Focused then
          Canvas.Brush.Color := Color
        else
          Canvas.Brush.Color := InactiveFocusColor;
        if (Color <> clNone) and (ARow = Row) and OldDesigning then
          Canvas.FillRect(BackRect);

        if (Field <> nil) and (Field.Dataset <> nil) and (Field.Dataset.Active)
        then
          PaintText := Field.DisplayText
        else
          PaintText := obj.EditText;

        if (parent is TwwDBGrid) then
        begin
        end
        else if (PaintOptions.AlternatingRowColor <> clNone) and Odd(ARow) and
          (((ACol = Col) and (arrActiveDataColumn
          in PaintOptions.AlternatingRowRegions)) or
          ((ACol <> Col) and (arrDataColumns
          in PaintOptions.AlternatingRowRegions))) then
        begin
          TempRect := Rect(ARect.Left, ARect.Top, ARect.right - 1,
            ARect.Bottom);
          if (ovHideVertDataLines in self.Options) then
            TempRect.Left := TempRect.Left - 1;
          if PaintOptions.AlternatingColorBitmap <> nil then
            Canvas.CopyRect(TempRect,
              PaintOptions.AlternatingColorBitmap.Canvas, TempRect)
          else
          begin
            Canvas.Brush.Color := PaintOptions.AlternatingRowColor;
            Canvas.FillRect(TempRect);
          end
        end
        else if (ACol = Col) and (PaintOptions.ActiveRecordColor <> clNone) then
        begin
          TempRect := Rect(ARect.Left, ARect.Top, ARect.right - 1,
            ARect.Bottom);
          if (ovHideVertDataLines in self.Options) then
            TempRect.Left := TempRect.Left - 1;
          if (PaintOptions.ActiveRecordBitmap <> nil) and (not IsCustomStyle)
          then
            Canvas.CopyRect(TempRect,
              PaintOptions.ActiveRecordBitmap.Canvas, TempRect)
          else
          begin
            if false and IsCustomStyle then
              wwPaintActiveGridCellBackgroundColor(self, Canvas, TempRect)
            else
            begin
              Canvas.Brush.Color := PaintOptions.ActiveRecordColor;
              Canvas.FillRect(TempRect);
            end
          end
        end
        else if PaintOptions.HaveBackgroundForDataCells and (not IsCustomStyle)
        then
        begin
          TempRect := Rect(ARect.Left, ARect.Top, ARect.right - 1,
            ARect.Bottom);
          if (ovHideVertDataLines in self.Options) then
            TempRect.Left := TempRect.Left - 1;
          Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.Canvas, TempRect);
        end;

        DefaultDrawing := DefaultDrawCell(obj);

        if DefaultDrawing then
        begin
          DoCalcDataPaintText(obj, PaintText);

          if (obj.CustomControl <> nil) and (obj.CustomControlAlwaysPaints) then
          begin
            if (not CustomEditHasFocus) then
            begin
              canShow:= true;
              DoOnCanShowCustomControl(obj, canShow);
              if canShow then begin
                PaintInactiveCustomControl;
                exit;
              end;
            end
          end;

          if (ACol = Col) and (ARow = Row) and (ColCount > 2) and EffectiveFocused
          then
          begin
            if ((obj.CustomControl <> nil) and
              (not wwGetAlwaysTransparent(obj.CustomControl))) or
              ((obj.CustomControl = nil)) then
            begin
              if IsCustomStyle then
                wwPaintActiveGridCellBackgroundColor(self, Canvas, ARect)
              else
              begin
                savedDC := SaveDC(Canvas.Handle);
                // 10/09/2001-Suggestion to add new property to respect diabledefaulteditor property add focusrect instead of highlight. (PYW)
                // if (obj.CustomControl<>nil) or not (obj.disabledefaulteditor) then begin
                Canvas.Brush.Color := clHighlight;
                Canvas.FillRect(Rect(ARect.Left + 1, ARect.Top, ARect.right - 1,
                  ARect.Bottom - 1));
                SetTextColor(Canvas.Handle, ColorToRGB(clHighlightText));
              end
            end
          end;

          if IsCustomStyle and (ARow = Row) and (ColCount = 2) and EffectiveFocused
          then
          begin
            if ((obj.CustomControl <> nil) and
              (not wwGetAlwaysTransparent(obj.CustomControl))) or
              ((obj.CustomControl = nil)) then
            begin
              wwPaintActiveGridCellBackgroundColor(self, Canvas, ARect)
            end
          end;

          if (Field is TBlobField) and
            (TBlobField(Field).datatype in [ftMemo, ftOraBlob, ftOraCLob,
            ftWideMemo]) then
          begin
            SetBkMode(Canvas.Handle, TRANSPARENT);
            try
              Flags := DT_LEFT or DT_END_ELLIPSIS or DT_NOPREFIX;
              if obj.WordWrap then
                Flags := Flags or DT_WORDBREAK;
              DrawTextRect := ARect;
              DrawTextRect.Left := ARect.Left + 2;
              DrawTextRect.Top := ARect.Top + 1;
              DrawText(Canvas.Handle, PChar(Field.asString),
                length(Field.asString), DrawTextRect, Flags);
            finally
              SetBkMode(Canvas.Handle, OPAQUE);
            end
          end
          else if (obj.PickList.Items.Count > 0) and
            (obj.PickList.DisplayAsCheckbox) then
          begin
            PaintCheckbox;
          end
          else if (obj.CustomControl = nil) or not obj.CustomControlAlwaysPaints
          then
          begin
            SetBkMode(Canvas.Handle, TRANSPARENT);
            WriteOptions := [wtoTransparent];

            try
              DrawTextRect := ARect;
              DrawTextRect.Left := ARect.Left + 2;
              DrawTextRect.Top := ARect.Top + 1;
              { if obj.Alignment = taRightJustify then
                begin
                Flags := DT_RIGHT or DT_END_ELLIPSIS or DT_NOPREFIX;
                DrawTextRect.right := DrawTextRect.right - 2;
                end
                else if obj.Alignment = taLeftJustify then
                Flags := DT_LEFT or DT_END_ELLIPSIS or DT_NOPREFIX
                else // 2/19/10 - Support Centering
                Flags := DT_CENTER or DT_END_ELLIPSIS or DT_NOPREFIX;
              }
              if obj.WordWrap then
                WriteOptions := WriteOptions + [wtoWordWrap];
              // Flags := Flags or DT_WORDBREAK;

              if obj.UseDefaultComboBox then
              begin
                if (Field = nil) then
                begin // 3/29/03 - Fix bug where mapped text not working in unbound
                  StoredValue := EditText;
                  PaintText := obj.GetMappedPaintText(StoredValue);
                end
                else if self.FDataLink.Active then
                // 8/7/01 - Avoid error if inactive
                begin
                  StoredValue := Field.asString;
                  if not PickList.MapList then
                    // 10/7/02 - DefaultCombobox not using display text before
                    PaintText := Field.DisplayText
                  else
                    PaintText := obj.GetMappedPaintText(StoredValue);
                end
                else
                begin
                  StoredValue := '';
                  PaintText := obj.GetMappedPaintText(StoredValue);
                end
              end;

              if (not obj.Enabled) then
              begin
                if wwUseThemes(self) then
                begin
                  WriteOptions:= WriteOptions + [wtoDisabledText];
                end
                else
                  Canvas.Font.Color := clGrayText;
              end;
              WriteTextLines(Canvas, DrawTextRect, 0, 0, PChar(PaintText),
                obj.Alignment, WriteOptions);
              // DrawText(Canvas.Handle, PChar(PaintText), length(PaintText),
              // DrawTextRect, Flags);
            finally
              SetBkMode(Canvas.Handle, OPAQUE);
            end
          end
        end
      end
    end;
  finally
    if FDataLink.Active and ((ACol > 1) or ((ACol > 0) and (ColCount > 2))) then
      FDataLink.ActiveRecord := OldActiveRecord;
    if savedDC <> 0 then
      RestoreDC(Canvas.Handle, savedDC);
  end

end;

Procedure TwwDataInspector.WriteTextLines(ACanvas: TCanvas; const ARect: TRect;
  DX, DY: Integer; s: PWideChar; Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions);
var
  NonWideStr: string;
begin
  NonWideStr := s;
  if not wwUseThemes(self) then
    WriteOptions := WriteOptions + [wtoDisableThemes];
  wwWriteTextLinesT(ACanvas, ARect, DX, DY, PChar(NonWideStr), Alignment,
    WriteOptions);
end;

Procedure TwwDataInspector.WriteTitleLines(ACanvas: TCanvas; const ARect: TRect;
  DX, DY: integer; s: PWideChar; Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions);
var
  NonWideStr: string;
begin
  NonWideStr := s;
  WriteOptions := WriteOptions + [wtoIsTitle];
  if not wwUseThemes(self) then
    WriteOptions := WriteOptions + [wtoDisableThemes];
  wwWriteTextLinesT(ACanvas, ARect, DX, DY, PChar(NonWideStr), Alignment,
    WriteOptions);
end;

Procedure TwwDataInspector.DoOnCanShowCustomControl(
      Item: TwwInspectorItem;
      var canShow: boolean);
begin
   if Assigned(item.FOnCanShowCustomControl) then
      item.FOnCanShowCustomControl(self, item, canShow);
end;

function TwwDataInspector.GetEditText(ACol, ARow: Longint): string;
var
  obj: TwwInspectorItem;
begin
  obj := GetItemByRow(ARow);
  if obj = nil then
    exit;

  if obj.Field = nil then
  begin
    result := obj.EditText;
    exit;
  end;
  // 2/28/01 - Check that dataset is open (required for closed dataset's that
  // can't handle reference to text property, i.e. TADOTable)
  // This probelm is introduced with delphi5 update pack 2
  if (obj.Field.Dataset <> nil) and (not obj.Field.Dataset.Active) then
  begin
    result := ''
  end
  else if (obj.Field is TBlobField) and
    (TBlobField(obj.Field).datatype in [ftMemo, ftOraBlob, ftOraCLob
{$IFDEF wwDelphi2006Up}
    , ftWideMemo
{$ENDIF} ]) then
  begin
    result := obj.Field.asString;
  end
  else
  begin
    result := obj.Field.Text;
  end;
  // obj.OrigEditText:= result;
  // obj.EditText:= result;
  FEditText := result;
end;

procedure TwwDataInspector.SetEditText(ACol, ARow: Longint;
  const Value: string);
var
  obj: TwwInspectorItem;
begin
  if SkipUpdateEditText then
    exit;

  obj := GetItemByRow(ARow);
  if obj <> nil then
    obj.EditText := Value; { 1/21/2000-Check for nil pointer in SetEditText }
  FEditText := Value;
end;

procedure TwwDataInspector.UpdateDataColumnWidth;
var
  NewColWidth1, ACol: Integer;
  ECaptionWidth: Integer;
begin
  if (ovHideCaptionColumn in Options) then
    ECaptionWidth := 0
  else
    ECaptionWidth := CaptionWidth;

  if VisibleRowCount > RowCount then
    NewColWidth1 := ClientWidth - ECaptionWidth - GetSystemMetrics(SM_CXHThumb)
    // - (ColCount-2)
    // else if parent is TCustomGrid then
    // NewColWidth1:= Width - 15 - ColWidths[0]
  else
    NewColWidth1 := ClientWidth - ECaptionWidth; // - (ColCount-2);

  if ColCount = 2 then
    ColWidths[1] := NewColWidth1
  else
  begin
    // DefaultColWidth:= (NewColWidth1 div (DataColumns));
    for ACol := 1 to ColCount - 1 do
    begin
      ColWidths[ACol] := // (NewColWidth1 div (ColCount-1));
        ((NewColWidth1) div (DataColumns));
    end;

    // Force data columns to all be same size
    // ColWidths[0]:= ClientWidth - DataColumns*ColWidths[1]

    // Be as close to possible as CaptionWidth, never less
    // 6/7/01
    // ColWidths[0]:= (CaptionWidth + DataColumns-1) * DataColumns div DataColumns
    ColWidths[0] := ClientWidth - (ColWidths[1] * DataColumns);
  end;

  if CurrentCustomEdit <> nil then
  begin
    CurrentCustomEdit.BoundsRect := ControlRect(Col, Row);
  end;

end;

procedure TwwDataInspector.UpdateRowCount;
var
  numRows: Integer;
begin
  if not(csLoading in ComponentState) and CheckRowCount then
  begin
    numRows := GetActiveRows;
    if (RowCount <> numRows) and (numRows > 0) then
    begin
      RowCount := numRows;
    end;
    CheckRowCount := false;
  end;
end;

procedure TwwDataInspector.RefreshItem(Item: TwwInspectorItem);
var
  curRow: Integer;
  // numRows: integer;
begin
  if csLoading in ComponentState then
    exit;
  if Items.UpdateCount > 0 then
    exit;

  { if not (csLoading in ComponentState) and CheckRowCount then
    begin
    numRows:= GetActiveRows;
    if (RowCount<>NumRows) and (NumRows>0) then
    RowCount:= NumRows;
    CheckRowCount:= False;
    end;
  }
  if Item = nil then
    exit;
  curRow := GetRowByItem(Item);
  if (curRow >= 0) and (curRow < RowCount) then
  begin // 10/29/08 Don't set RowHeight if out of range
    if Item.CellHeight = 0 then
      RowHeights[curRow] := inherited DefaultRowHeight
    else
      RowHeights[curRow] := Item.CellHeight;
  end
end;

Procedure TwwDataInspector.ApplySettingsCallback(Item: TwwInspectorItem;
  UserData: Pointer; var AContinue: boolean);
var
  currentRow: PInteger;
begin
  currentRow := PInteger(UserData);
  if Item.CustomControl <> nil then
  begin

    if Item.CustomControl.handleAllocated then
      Item.CustomControl.Enabled := Item.Enabled;

    TEdit(Item.CustomControl).ControlStyle := TEdit(Item.CustomControl)
      .ControlStyle + [csNoDesignVisible];
  end;
  if not Item.Visible then
    exit;

  if Item.CellHeight > 0 then
    RowHeights[currentRow^] := Item.CellHeight
  else
    RowHeights[currentRow^] := inherited DefaultRowHeight;
  currentRow^ := currentRow^ + 1;
end;

procedure TwwDataInspector.ApplySettings;
var
  i: Integer;
  Item: TwwInspectorItem;
  curRow: Integer;
  numRows: Integer;
begin
  if csLoading in ComponentState then
    exit;

  BeginUpdate;

  Canvas.Font.Assign(self.Font);

  FMinRowHeight := Canvas.TextHeight('0') + 3;
  if DefaultRowHeight = 0 then
  begin
    if FMinRowHeight <> inherited DefaultRowHeight then
      inherited DefaultRowHeight := FMinRowHeight;
  end;

  if (Items.Count = 0) and (DataSource <> nil) and (DataSource.Dataset <> nil)
    and DataLink.Active then
    with DataSource.Dataset do
    begin
      for i := 0 to FieldCount - 1 do
      begin
        Item := TwwInspectorItem.Create(Items);
        Item.Caption := Fields[i].DisplayLabel;
        Item.CustomControl := nil;
        Item.ReadOnly := Fields[i].ReadOnly;
        Item.CellHeight := 0;
        Item.Expanded := false;
        Item.DataField := Fields[i].FieldName;
      end
    end;

  if not(csLoading in ComponentState) then
  begin
    numRows := GetActiveRows;
    // if ovIndicatorRow in Options then numRows:= numRows + 1;
    if (RowCount <> numRows) and (numRows > 0) then
      RowCount := numRows;
  end;

  // RowCount:= ActiveRows;

  if IndicatorRow.Enabled then
    curRow := 1
  else
    curRow := 0;
  IterateItems(ApplySettingsCallback, true, @curRow);

  if IndicatorRow.Enabled and (RowCount > 1) then
  // Fixed rows must be less than rowcount
  begin
    FixedRows := 1 + FFixedDataRows;
    if IndicatorRow.Height <> 0 then
      RowHeights[0] := IndicatorRow.Height
    else
      RowHeights[0] := inherited DefaultRowHeight;
  end
  else
    FixedRows := FixedDataRows;

  UpdateDataColumnWidth;
  ColCount := FDataColumns + 1;
  FDataLink.BufferCount := DataColumns;
  if FDataLink.Active then
  begin
    if (FDataLink.RecordCount < DataColumns) and (FDataLink.RecordCount > 0)
    then
    begin
      // ColCount:= FDataLink.RecordCount+1;
    end;
  end;
  if (ColCount > 1) and (Col = 0) then
    Col := 1;
  { Col:= 1; }

  // { Create controls }
  // DateTimePicker:= TwwDBDateTimePicker.create(self);
  // Update; { Complete erase background }
  EndUpdate(true);

  { Collapse on checkbox causes inplaceeditor to not become visible even though it should }
  // if UseDefaultEditor then ShowEditor;
  if UseDefaultEditor then
    InvalidateEditor; // 7/29/04 - Call InvalidateEditor instead of ShowEditor
  // so that inplaceposition gets set to -1, -1

end;

procedure TwwDataInspector.SetCaptionWidth(Value: Integer);
var
  NewWidth: Integer;
begin
  NewWidth := wwMax(10, wwMin(Value, ClientWidth - 20));
  if NewWidth <> FCaptionWidth then
  begin
    if (ovHideCaptionColumn in Options) and (ColCount = 2) then
      ColWidths[0] := 0
    else
    begin
      ColWidths[0] := wwMax(10, wwMin(Value, ClientWidth - 20));
      FCaptionWidth := ColWidths[0];
    end;
    Invalidate;
  end
end;

function TwwDataInspector.AcquireFocus: boolean;
var
  OrigFocus: HWND;
begin
  result := true;
  OrigFocus := GetFocus;
  if CanFocus and not(csDesigning in ComponentState) then
  begin
    SetFocus;
    // if InplaceEditor<>nil then
    // TEdit(InplaceEditor).Font.Color:= clWindowText; { Change later to be based on property FocusTextColor }
    result := FFocused or (InplaceEditor <> nil) and InplaceEditor.Focused;

    // 2/18/04 - Prevent exception from being thrown twice in some cases
    if (GetFocus = OrigFocus) and (GetFocus <> Handle) then
      if (ActiveItem <> nil) and Assigned(ActiveItem.CustomControl) and
        ActiveItem.CustomControl.Focused then
        result := false;
  end;
end;

function TwwDataInspector.UseCheckbox(ARow: Integer): boolean;
var
  obj: TwwInspectorItem;
begin
  obj := GetItemByRow(ARow);
  if obj = nil then
  begin
    result := false;
    exit;
  end;
  result := (obj.CustomControl = nil) and not IsDefaultDateTimePicker(obj) and
    (obj.PickList.Items.Count > 0) and (obj.PickList.DisplayAsCheckbox)
end;

function TwwDataInspector.UseDefaultEditor: boolean;
var
  obj: TwwInspectorItem;
begin
  obj := GetItemByRow(Row);
  if (obj = nil) or (obj.DisableDefaultEditor) { or (not obj.enabled) } then
  begin
    result := false;
    exit;
  end;

  result := not((obj.CustomControl <> nil) or IsDefaultDateTimePicker(obj) or
    (obj.PickList.Items.Count > 0) or obj.UseDefaultComboBox or
    ((obj.Field <> nil) and IsDefaultLookupCombo(obj)))
end;

procedure TwwInspectorItem.DoItemTextChanged;
begin
  // if EditText<>OrigEditText then
  // begin
  if Assigned(FItemChanged) then
    FItemChanged((Control as TwwDataInspector), self, EditText);
  (Control as TwwDataInspector).DoItemChanged(self, EditText);
  // OrigEditText:= EditText;
  // end;
end;

Function TwwDataInspector.GetActiveEdit: TWinControl;
begin
  result := nil;

  if CurrentCustomEdit <> nil then
    result := CurrentCustomEdit
  else if not UseCheckbox(Row) then
  begin
    // 8/9/01 - If no active item then return nil
    if (ActiveItem <> nil) and (not ActiveItem.DisableDefaultEditor) and
      ActiveItem.Enabled then
      result := InplaceEditor
  end

end;

procedure TwwDataInspector.InitCustomEdit(CustomEdit: TWinControl;
  obj: TwwInspectorItem);
begin
  if CustomEdit.parent <> self then
  begin
    CustomEdit.parent := self;
    // 6/23/00 - Handle needs to be created to avoid blank display in some cases
    CustomEdit.HandleNeeded;
  end;

  if (obj.DataField <> wwGetControlDataField(CustomEdit)) or
    (obj.DataSource <> wwGetControlDataSource(CustomEdit)) then
  begin
    wwSetControlDataField(CustomEdit, '');
    if (obj.DataSource <> nil) and (obj.DataField = '') then
    begin
      // if (obj.datasource<>wwGetControlDataSource(customEdit)) then
      // wwSetControlDataSource(customEdit, nil);
    end
    else
    begin
      if (obj.DataSource <> wwGetControlDataSource(CustomEdit)) then
        wwSetControlDataSource(CustomEdit, obj.DataSource);
      wwSetControlDataField(CustomEdit, obj.DataField);
    end;

    { Select all after painting }
    if not(CustomEdit is TCustomMemo) then
    begin
      if (CustomEdit <> nil) and CustomEdit.Enabled then
        PostMessage(CustomEdit.Handle, EM_SETSEL, 0, -1);
    end
  end;

  if CustomEdit is TWinControl then
  begin
    TEdit(CustomEdit).Ctl3D := false;
    if TEdit(CustomEdit).ParentFont then
      TEdit(CustomEdit).Font := self.Font;
    TEdit(CustomEdit).TabStop := false;
    wwSetBorder(CustomEdit, false);
    // if (CustomEdit is TCustomEdit) and (TEdit(CustomEdit).BorderStyle<> bsNone) then
    // TEdit(CustomEdit).BorderStyle:= bsNone;
  end;

  { 11/3/99 - Update picture mask property of TwwDBCustomEdit }
  if (CustomEdit is TwwDBCustomEdit) then
  begin
    TwwDBCustomEdit(CustomEdit).Picture.Assign(obj.Picture);
    TwwDBCustomEdit(CustomEdit).Picture.PictureMaskFromDataSet := false;
  end;

end;

procedure TwwDataInspector.UpdateCustomEdit;
var
  FoundCustomEdit: boolean;
  obj: TwwInspectorItem;
  CustomEdit: TWinControl;
  lookupCombo: TwwDBLookupCombo;

  { function ControlRect: TRect;
    begin
    result:= CellRect(Col, Row);
    //     result:= ARect;
    result.Left:= result.Left +1;
    result.Bottom:= result.Bottom -1;
    end;
  }
begin
  obj := ActiveItem;
  if obj = nil then
    exit; // 5/11/2001 - PYW - Make sure that obj <> nil.
  CustomEdit := nil; // Make compiler happy about its warnings

  if (not(csDesigning in ComponentState)) and (EffectiveFocused or
    // 2/7/01 - Use FFocused instead as
    (Assigned(screen.activecontrol) and
    { 3/6/00 - Check for nil active control }
    (screen.activecontrol.parent = self))) then
  begin
    // DirtyCustomInfo:= False;
    FoundCustomEdit := false;
    if obj.CustomControl <> nil then
    begin
      CustomEdit := obj.CustomControl;
      FoundCustomEdit := true;
    end
    else if (obj.UseDefaultComboBox) then
    begin
      FoundCustomEdit := true;
      if FCombo = Nil then
      begin
        FCombo := CreateDefaultCombo;
        FCombo.parent := self;
        FCombo.Font := self.Font;
        FCombo.Visible := false;
        (FCombo as TwwInspectorComboBox).FClickTime := GetMessageTime;
        { 12/2/99 - Support dbl-click }
      end;
      CustomEdit := FCombo;
      FCombo.Items.Assign(obj.PickList.Items);
      FCombo.MapList := obj.PickList.MapList;
      FCombo.ShowMatchText := obj.PickList.ShowMatchText;
      FCombo.Style := obj.PickList.Style;
      FCombo.ButtonStyle := obj.PickList.ButtonStyle;
      FCombo.AllowClearKey := obj.PickList.AllowClearKey;
      FCombo.ButtonGlyph.Handle := 0;
      FCombo.ButtonGlyph.Assign(obj.PickList.ButtonGlyph);
      FCombo.ButtonWidth := obj.PickList.ButtonWidth;
      FCombo.ApplyList;
      // FCombo.OnDropDown:= obj.ComboDropDownEvent;
      if (obj.DataSource = nil) or (obj.DataField = '') then
        FCombo.Value := obj.EditText;
    end
    else if IsDefaultLookupCombo(obj) then
    begin
      FoundCustomEdit := true;
      if obj.CustomControl = nil then
      begin
        lookupCombo := TwwDBLookupCombo.Create(self);
        obj.CustomControl := lookupCombo;
      end
      else if obj.CustomControl is TwwDBLookupCombo then
        lookupCombo := TwwDBLookupCombo(obj.CustomControl)
      else
        exit;

      lookupCombo.Font := self.Font;
      lookupCombo.Visible := false;
      lookupCombo.parent := self;
      lookupCombo.LookupTable := obj.Field.LookupDataSet;
      lookupCombo.Selected.Add(obj.Field.LookupResultField + #9 +
        inttostr(obj.Field.displaywidth) + #9 + obj.Field.DisplayLabel);
      lookupCombo.ShowMatchText := true;
      lookupCombo.LookupField := obj.Field.LookupKeyFields;
      lookupCombo.TabStop := false;
      CustomEdit := lookupCombo;
      // DoCreateLookupCombo(LookupCombo);
    end
    else if IsDefaultDateTimePicker(obj) then
    begin
      FoundCustomEdit := true;
      if FDateTimePicker = Nil then
      begin
        FDateTimePicker := CreateDateTimePicker;
        FDateTimePicker.Visible := false;
        FDateTimePicker.Font := self.Font;
        FDateTimePicker.TabStop := false;

        DoCreateDateTimePicker(FDateTimePicker);
      end;
      CustomEdit := FDateTimePicker;
      FDateTimePicker.ShowButton := not(obj.Field is TTimeField);
    end;

    DoCalcCustomEdit(obj, CustomEdit, FoundCustomEdit); // 1/21/02

    if FoundCustomEdit then
    begin
      if not sameRect(CustomEdit.BoundsRect, ControlRect(Col, Row)) then
      begin
        CustomEdit.BoundsRect := ControlRect(Col, Row);
      end;
      InitCustomEdit(CustomEdit, obj);
      CustomEdit.BoundsRect := ControlRect(Col, Row);
      wwSetReadOnly(CustomEdit, obj.ReadOnly or self.ReadOnly);

      { 5/4/00 - Unbound with custom control item was losing original text when changing rows }
      if CurrentCustomEdit <> CustomEdit then
      begin
        if (not obj.CustomControlAlwaysPaints) or (obj.UseDefaultComboBox) then
        // 8/7/01 - Also reset text for defautl combo box
        begin
          if (obj.DataField = '') or (obj.DataSource = nil) then
          begin
            CustomEdit.HandleNeeded;
            TEdit(CustomEdit).Text := obj.DisplayText;
          end;
        end;
        CurrentCustomEditRow := Row;
        CurrentCustomEditCol := Col;
      end;

      CurrentCustomEdit := CustomEdit;
    end;
  end;

  // 8/21/02 - Support obj.enabled property
  if CurrentCustomEdit <> nil then
    CurrentCustomEdit.Enabled := obj.Enabled;

end;

procedure UpdateCustomEditPaint(CurrentCustomEdit: TWinControl);
var
  i: Integer;
begin
  with CurrentCustomEdit do
    for i := 0 to CurrentCustomEdit.ControlCount - 1 do
      Controls[i].Update;

  CurrentCustomEdit.Update;
end;

procedure TwwDataInspector.SetFocusCell(ACol, ARow: Integer);
var
  OldRow: Integer;
  obj: TwwInspectorItem;
  PrevTopRow: Integer;
  CurrentUpdateCount: Integer;
  // InvalidateAll: boolean;
  DrawInfo: TGridDrawInfo;
  ie: TwwDataInspectorEdit;
  canshow: boolean;
begin
  if (ACol = Col) and (ARow = Row) then
  begin
    // Scrolling right/left when cell doesn't change should
    // invalidate currentcustomedit

    if { ((CurrentCustomEditRow<>ARow) or (CurrentCustomEditCol<>ACol)) and }
      (CurrentCustomEdit <> nil) then
    begin
      // 7/26/02 - Only set focus if inspector is on the active form
      if FFocused and (screen.ActiveForm = GetParentForm(self)) then // 5/2/01
        SetFocus;
      CurrentCustomEdit.Visible := false;
      CurrentCustomEdit := nil;
      CurrentCustomEditRow := -1;
      CurrentCustomEditCol := -1;
    end;

    UpdateCustomEdit;

    // Don't show custom control if canshow is false
    CanShow:=true;
    obj := GetItemByRow(ARow);
    DoOnCanShowCustomControl(obj, canShow);
    if not canShow then
    begin
       CurrentCustomEdit.visible:=false;
       CurrentCustomEdit:=nil;
    end;

    if (CurrentCustomEdit <> nil) then
    begin
      CurrentCustomEdit.Visible := true;

      UpdateCustomEditPaint(CurrentCustomEdit);
      // 7/26/02 - Only set focus if inspector is on the active form
      if FFocused and (screen.ActiveForm = GetParentForm(self)) then // 5/2/01
        CurrentCustomEditSetfocus;
    end;
    exit;
  end;
  if IndicatorRow.Enabled and (ARow < 1) then
    ARow := Row;

  if (ARow <> Row) or (ACol <> Col) then
  begin
    FCustomControlKeyMode := false;
    TwwDataInspectorDataLink(FDataLink).UpdateData;
  end;

  OldRow := Row;
  PrevTopRow := TopRow;

  obj := GetItemByRow(OldRow);

  if (obj <> nil) and (CurrentCustomEdit <> nil) then
  begin
    if CurrentCustomEdit is TwwDBComboBox then
      obj.EditText := TwwDBComboBox(CurrentCustomEdit).Value
      // 12/3/02 - Don't allow unbound combo to update incorrect EditText
      // by first calling closeup before setting EditText
    else if CurrentCustomEdit is TwwDBLookupCombo then
    begin
      with CurrentCustomEdit as TwwDBLookupCombo do
      begin
        if (DataSource = nil) and (Style = csDropDownList) then
          CloseUp(true)
      end;
      obj.EditText := TEdit(CurrentCustomEdit).Text
    end
    else
      obj.EditText := TEdit(CurrentCustomEdit).Text;
  end;

  if CurrentCustomEdit <> nil then
  begin
    if CurrentCustomEdit.handleAllocated then
      if SendMessage(CurrentCustomEdit.Handle, EM_GETMODIFY, 0, 0) <> 0 then
        obj.DoItemTextChanged;
  end
  else
  begin
    if (InplaceEditor <> nil) and InplaceEditor.Modified then
    begin
      ie := TwwDataInspectorEdit(InplaceEditor);

      if (DataSource = nil) and (CurrentCustomEdit = nil) and
        (InplaceEditor <> nil) and ie.HavePictureMask then
      begin
        if (not ie.IsValidPictureValue(ie.Text)) and
          (not ie.Picture.AllowInvalidExit) then
        begin
          MessageBeep(0);
          SysUtils.Abort;
        end
      end;

      { 5/3/00 - Make sure obj.edittext is updated to inplaceeditor's value }
      { This is only necessary because when a picture mask is assigned, the obj.edittext
        is not updated for some reason }
      if InplaceEditor.Text <> obj.EditText then
        obj.EditText := InplaceEditor.Text;

      obj.DoItemTextChanged;
      InplaceEditor.Modified := false; { 3/11/00 - Clear modified }
    end
  end;

  // UpdateRect:= FPaintCanvas.ClipRect;
  // windows.GetUpdateRect(Handle, UpdateRect, false);
  // BeginUpdate;
  CurrentUpdateCount := FUpdateCount;
  try
    // 2/10/01 - RSW Calling BeginUpdate prevents closing combo-box from invalidating its pop-up window area
    // However not calling it makes scrolling painting occur!
    // So we make temporary flag to invalidate whole inspector if drop-down was previously
    // showing before changing cell

    // DoBeginUpdateInSelectCell:= True; { Do BeginUpdate after BeforeSelect event }
    // InvalidateAll:= HaveVisibleChild(CurrentCustomEdit);

    // Inherited calls ScrollWindowEx, so disable painting if this
    // will be called so that we don't get this scrolling
    CalcDrawInfo(DrawInfo);
    with DrawInfo do
    begin
      if (ACol > Horz.LastFullVisibleCell) or (ARow > Vert.LastFullVisibleCell)
        or (ACol < LeftCol) or (ARow < TopRow) then
      begin
        DoBeginUpdateInSelectCell := true;
        { Do BeginUpdate after BeforeSelect event }
      end
    end;

    MoveColRow(ACol, ARow, true, true)
  finally
    if (PrevTopRow <> TopRow) and (FixedDataRows > 0) then
    begin
      if TopRow < FixedRows then
        TopRow := PrevTopRow; // FixedRows;
    end;
    if FUpdateCount > CurrentUpdateCount then
      EndUpdate;
  end;

  if ((CurrentCustomEditRow <> ARow) or (CurrentCustomEditCol <> ACol)) and
    (CurrentCustomEdit <> nil) then
  begin
    CurrentCustomEdit.Visible := false;
    CurrentCustomEdit := nil;
    CurrentCustomEditRow := -1;
    CurrentCustomEditCol := -1;
  end;

  if UseDefaultEditor then
  begin
    SkipSetFocus := true;
    // 6/13/01 - Don't set inplaceeditor focus when inspector receives focus
    try
      ShowEditor;
    finally
      SkipSetFocus := false;
    end;
  end
  else
    HideEditor;

  if (PrevTopRow <> TopRow) then
  begin
    if TopRow < FixedRows then
      TopRow := FixedRows;
    Invalidate;
    Update; // 2/23/01 - Make sure no problem when on last visible row and enter downa-arrow.
  end
  else
  begin
    // Invalidate;
    InvalidateRect(Handle, @SelectCellUpdateRect, false);
    InvalidateRow(OldRow);
    InvalidateRow(ARow);
  end;

  // if SkipUpdateCustomControl then exit;

  UpdateCustomEdit;

  // Don't show custom control if canshow is false
  CanShow:=true;
  obj := GetItemByRow(ARow);
  DoOnCanShowCustomControl(obj, canShow);
  if not canShow then
  begin
     CurrentCustomEdit.visible:=false;
     CurrentCustomEdit:=nil;
  end;

  if CurrentCustomEdit <> nil then
  begin
    CurrentCustomEdit.Visible := true;
    UpdateCustomEditPaint(CurrentCustomEdit);
    if FFocused then // 5/2/01
      CurrentCustomEditSetfocus;
  end
end;

function TwwDataInspector.SelectCell(ACol, ARow: Longint): boolean;
var
  obj: TwwInspectorItem;
  // ie: TwwDataInspectorEdit;
begin
  FreeHintWindow;

  result := true;
  obj := GetItemByRow(ARow);

  if Assigned(FOnBeforeSelectCell) then
  begin
    FOnBeforeSelectCell(self, obj, result);
  end;

  if DoBeginUpdateInSelectCell then
  begin
    Windows.GetUpdateRect(Handle, SelectCellUpdateRect, false);
    BeginUpdate;
    DoBeginUpdateInSelectCell := false;
  end;

  // ie:= TwwDataInspectorEdit(InplaceEditor);

  if result then
  begin
    if ACol = 0 then
    begin
      result := false;
      exit;
    end;
    if ((CurrentCustomEditRow <> ARow) or (CurrentCustomEditCol <> ACol)) and
      (CurrentCustomEdit <> nil) then
    begin
      SkipErase := true;
      { 9/29/99 - Need to move focus to inspector since custom edit is not visible }
      if CurrentCustomEdit.Visible then
        SetFocus;

      // 11/12/03 - Make sure currentcustomedit is not nil in case it got cleared when calling SetFocus
      if CurrentCustomEdit <> nil then
      begin
        // if (DataSource=nil) and
        if CurrentCustomEdit.Focused then
        begin
          SysUtils.Abort;
          // 3/29/03 - Don't allow exit for unbound case when tied to a TwwDBEdit
          result := false;
          exit;
        end
        else
          CurrentCustomEdit.Visible := false;
      end
      else
      begin
        result := false;
        SkipErase := false;
        exit;
      end;

      SkipErase := false;
      CurrentCustomEdit := nil;
      CurrentCustomEditRow := -1;
      CurrentCustomEditCol := -1;
    end;
    (* else if (DataSource=nil) and
      (CurrentCustomEdit=nil) and (ie<>nil) and ie.HavePictureMask and ie.modified then
      begin
      if (not ie.IsValidPictureValue(ie.Text)) and // 4/19/03 - Logic incorrect before causing problem in unbound case
      (not ie.Picture.AllowInvalidExit) then
      begin
      MessageBeep(0);
      sysutils.Abort;
      end
      end;
    *)
    { Initialize edit text values when it receives focus }
    if obj <> nil then
      obj.EditText := GetEditText(1, ARow);
    // obj.OrigEditText:= Obj.EditText;

    InvalidateRow(Row);
    InvalidateRow(ARow);

    if (ARow <> Row) and FastDesign then
      FActiveItem := GetItemByRow(ARow);

  end;

end;

procedure TwwDataInspector.MouseUp(Button: TMouseButton; Shift: TShiftState;
  x, Y: Integer);
var
  DrawInfo: TGridDrawInfo;
  NewSize: Integer;

  function ResizeLine(const AxisInfo: TGridAxisDrawInfo): Integer;
  var
    i: Integer;
  begin
    with AxisInfo do
    begin
      result := FixedBoundary;
      for i := FirstGridCell to FSizingIndex - 1 do
        inc(result, GetExtent(i) + EffectiveLineWidth);
      result := FSizingPos - result;
    end;
  end;

begin
  CalcDrawInfo(DrawInfo);
  if FGridState = gsColSizing then
    try
      if UseRightToLeftAlignment then
        FSizingPos := ClientWidth - FSizingPos;
      NewSize := ResizeLine(DrawInfo.Horz);
      if NewSize > 1 then
      begin
        CaptionWidth := NewSize;
        UpdateDataColumnWidth;
        UpdateDesigner;
      end;
      if Assigned(OnMouseUp) then
        OnMouseUp(self, Button, Shift, x, Y);
    finally
      FGridState := gsNormal;
    end
  else if FGridState = gsRowSizing then
  begin
    inherited;
    if CurrentCustomEdit <> nil then
    begin
      CurrentCustomEditSetfocus;
      // TEdit(CurrentCustomEdit).Font.Color:= clBlack; { Change later to be based on property FocusTextColor }
    end;

    if (FSizingIndex >= 0) and (FSizingIndex < RowCount) then // 4/3/03
      RowHeights[FSizingIndex] := wwMax(RowHeights[FSizingIndex],
        FMinRowHeight);
    if GetItemByRow(FSizingIndex) <> nil
    then { 11/18/99 - Make sure this is a valid row }
    begin
      GetItemByRow(FSizingIndex).CellHeight := RowHeights[FSizingIndex];
    end;
    InvalidateRow(FSizingIndex);
  end
  else if FGridState in [gsSelecting, gsColMoving, gsRowMoving] then
    inherited
  else if Assigned(OnMouseUp) then
    OnMouseUp(self, Button, Shift, x, Y);
  // 3/18/2002-Call OnMouseUp event if assigned.
end;

procedure TwwDataInspector.DrawSizingLine(const DrawInfo: TGridDrawInfo);
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  try
    with Canvas, DrawInfo do
    begin
      OldPen.Assign(Pen);
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Width := 1;
      try
        if FGridState = gsRowSizing then
        begin
          MoveTo(0, FSizingPos);
          LineTo(Horz.GridBoundary, FSizingPos);
        end
        else
        begin
          MoveTo(FSizingPos, 0);
          LineTo(FSizingPos, Vert.GridBoundary);
        end;
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TwwDataInspector.DoCollapse(ObjItem: TwwInspectorItem);
var
  AllowCollapse: boolean;
begin
  AllowCollapse := true;
  if Assigned(FOnCanCollapse) then
    FOnCanCollapse(self, ObjItem, AllowCollapse);
  if AllowCollapse then
  begin
    ObjItem.Expanded := false;
    if not(csLoading in ComponentState) then
    begin
      if Assigned(FOnCollapsed) then
        FOnCollapsed(self, ObjItem)
    end
  end
end;

procedure TwwDataInspector.DoExpand(ObjItem: TwwInspectorItem);
var
  AllowExpand: boolean;
begin
  AllowExpand := true;
  if Assigned(FOnCanExpand) then
    FOnCanExpand(self, ObjItem, AllowExpand);
  if AllowExpand then
  begin
    ObjItem.Expanded := true;
    if not(csLoading in ComponentState) then
    begin
      if Assigned(FOnExpanded) then
        FOnExpanded(self, ObjItem)
    end
  end;

end;

procedure TwwDataInspector.MouseDown(Button: TMouseButton; Shift: TShiftState;
  x, Y: Integer);
var
  DrawInfo: TGridDrawInfo;
  Cell: TGridCoord;
  obj: TwwInspectorItem;
  R: TRect;
  pt: TPoint;
  SendMouseMessage: boolean;
  MouseControl: TControl;
  OldTopRow: Integer;
  ie: TwwDataInspectorEdit;
  // OldRow: integer;
begin
  FreeHintWindow;

  Cell := MouseCoord(x, Y);

  { Don't set focus if clicking on first column of active row }
  if (not isFocused) or (Cell.x <> 0) or (Cell.Y <> Row) and isFocused then
  begin
    if FFocused then
      SkipUpdateCustomControlInFocus := true;
    if not AcquireFocus then
      exit;
    SkipUpdateCustomControlInFocus := false;
  end;

  if (Cell.x < 0) and (Cell.Y < 0) or (ssDouble in Shift)
  then { 12/2/99 - Dbl-click should be passed to base class to handle }
  begin
    // 7/17/01
    TwwDataInspectorDataLink(FDataLink).UpdateData;
    // Flush editor contents so its not lost

    // 4/19/03 - Don't call inherited MouseDown if doesn't satisfy picture mask constraints as
    // inherited MouseDown clears modified flag and sets EditText
    ie := TwwDataInspectorEdit(InplaceEditor);
    if (ssDouble in Shift) and (DataSource = nil) and (CurrentCustomEdit = nil)
      and (InplaceEditor <> nil) and ie.HavePictureMask then
    begin
      if (not ie.IsValidPictureValue(ie.Text)) and
        (not ie.Picture.AllowInvalidExit) then
      begin
        MessageBeep(0);
        exit;
      end
    end;

    inherited MouseDown(Button, Shift, x, Y);
    // 5/8/2002 - Bug when clicking on edge of Datainspector when embedded in grid.
    if (parent is TCustomGrid) and (Cell.x < 0) and (Cell.Y < 0) then
      FGridState := gsNormal;

    // 3/18/05 - Undo sizing line so it behaves the same as sizing in data rows
    // Also make sure we don't update sizingstate unless left mouse button is pressed
    if ([ssDouble, ssRight] * Shift = []) then
    begin
      CalcDrawInfo(DrawInfo);
      CalcSizingState(x, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs,
        DrawInfo);
      if (FGridState = gsColSizing) then
        DrawSizingLine(DrawInfo); { Undo sizing line }
    end;
    exit;
  end;

  { 12/2/99 - Support dbl-click }
  if DefaultCombo <> nil then
    (DefaultCombo as TwwInspectorComboBox).FClickTime := GetMessageTime;

  obj := GetItemByRow(Cell.Y);
  if (Cell.x = 0) and (obj <> nil) then
  begin
    pt := obj.ButtonPoint;
    if (obj.Items.Count > 0) and (((abs(x - pt.x) <= 4) and (abs(Y - pt.Y) <= 4)
      ) or (ssDouble in Shift)) then
    begin
      // OldRow:= Row;
      SetFocusCell(Col, GetRowByItem(obj));
      { 3/6/2000 - Flush changes when expanding }

      // Row:= GetRowByItem(obj);  { Must set row before updating obj.expanded as otherwise
      // error when flusing edit contents}
      if UseDefaultEditor then
        ShowEditor
      else
        HideEditor;
      if obj.Expanded then
        DoCollapse(obj)
      else
        DoExpand(obj);

      if Assigned(OnMouseDown) then
        OnMouseDown(self, Button, Shift, x, Y);
      exit;
    end
  end;

  if ((Cell.x >= 0) and (Cell.x <= ColCount)) and
    (not Sizing(x, Y) or not InValidColSizingArea(x)) then
  begin
    if Assigned(OnMouseDown) then
      OnMouseDown(self, Button, Shift, x, Y);

    SendMouseMessage := ((Row <> Cell.Y) or (Col <> Cell.x)) and (Cell.x <> 0);
    // Changed rows so send mouse to custom control
    OldTopRow := TopRow;

    if Cell.x = 0 then
      SetFocusCell(Col, Cell.Y)
    else
    begin
      if (Cell.x <> Col) then
      begin
        if CurrentCustomEdit <> nil then
        begin
          SetFocus;
          CurrentCustomEdit.Visible := false;
        end;

        NewMouseRow := Cell.Y;
        try
          if FDataLink.Active then
            FDataLink.Dataset.MoveBy(Cell.x - Col);
        finally
          NewMouseRow := -1;
        end
      end
      else
      begin
        Cell.x := wwMin(Cell.x, ColCount - 1);
        SetFocusCell(Cell.x, Cell.Y);
      end;

      // FCustomControlKeyMode:= True;

    end;

    // Send mouse message to control that has just become visible
    if SendMouseMessage and (CurrentCustomEdit <> nil) and
      (CurrentCustomEdit.Visible) and (TopRow = OldTopRow) then
    begin
      pt := Point(x - CurrentCustomEdit.Left, Y - CurrentCustomEdit.Top);
      MouseControl := CurrentCustomEdit.ControlAtPos(pt, false, true);

      if (MouseControl <> nil) and (MouseControl is TWinControl) then
      begin
        MouseControl.ScreenToClient(pt);
        SendMessage(TWinControl(MouseControl).Handle, WM_LBUTTONDOWN, 0,
          MakeLParam(pt.x - MouseControl.Left, pt.Y - MouseControl.Top));

        // 2/10/01 - Sending up as well to take care of problem of combo-button
        // remaining down if clicked when it is not visible.
        SendMessage(TWinControl(MouseControl).Handle, wm_lbuttonUp, 0,
          MakeLParam(pt.x - MouseControl.Left, pt.Y - MouseControl.Top));
        // MouseControl.ControlState:=MouseControl.ControlState-[cslButtonDown];
      end
      else
      begin
        // i.e. embedded TwwCheckbox
        if CurrentCustomEdit.Enabled then
          SendMessage(CurrentCustomEdit.Handle, WM_LBUTTONDOWN, 0,
            MakeLParam(x - CurrentCustomEdit.Left, Y - CurrentCustomEdit.Top));
      end
    end;

    R := CheckboxRect(CellRect(Cell.x, Row), obj);
    InflateRect(R, 1, 1);
    if (Cell.x >= 1) and UseCheckbox(Cell.Y) and ptinrect(R, Point(x, Y)) then
    begin
      ToggleCheckbox(obj);
      invalidateCell(1, Cell.Y);
    end;
    exit;
  end;

  { Flush data if we are sizing }
  if ([ssDouble, ssRight] * Shift = []) then
  begin
    CalcDrawInfo(DrawInfo);
    CalcSizingState(x, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs,
      DrawInfo);
    if (FGridState = gsColSizing) or (FGridState = gsRowSizing) then
      FDataLink.UpdateData;
  end;

  inherited;

  if ([ssDouble, ssRight] * Shift = []) then
  begin
    CalcDrawInfo(DrawInfo);

    { Check grid sizing }
    CalcSizingState(x, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs,
      DrawInfo);

    if FGridState = gsColSizing then
    begin
      if not InValidColSizingArea(x) then
        FGridState := gsNormal;
      DrawSizingLine(DrawInfo); { Undo sizing line }
    end
  end;
end;

procedure TwwDataInspector.MouseMove(Shift: TShiftState; x, Y: Integer);
var
  DrawInfo: TGridDrawInfo;
  NewSize: Integer;
  OldCaptionWidth: Integer;
{$IFDEF wwUseThemeManager}
  Coord: TGridCoord;
{$ENDIF}
  function ResizeLine(const AxisInfo: TGridAxisDrawInfo): Integer;
  var
    i: Integer;
  begin
    with AxisInfo do
    begin
      result := FixedBoundary;
      for i := FirstGridCell to FSizingIndex - 1 do
        inc(result, GetExtent(i) + EffectiveLineWidth);
      result := FSizingPos - result;
    end;
  end;

begin
  CalcDrawInfo(DrawInfo);
  case FGridState of
    gsSelecting, gsColMoving, gsRowMoving:
      ;

    gsRowSizing:
      ;

    gsColSizing:
      begin
        NewSize := ResizeLine(DrawInfo.Horz);
        if (NewSize > 1) then
        begin
          OldCaptionWidth := CaptionWidth;
          CaptionWidth := NewSize;
          if CaptionWidth <> OldCaptionWidth then
          begin
            UpdateDataColumnWidth;
            UpdateDesigner;
          end
        end;
        FSizingPos := x + FSizingOfs;
        exit;
      end;
  end;
  inherited MouseMove(Shift, x, Y);

  // Following code to paint mouseenter for themes
  // Problems implementing as it only works when control has the focus anyways
  // If we support this, then we should only invalidate if it has the focus
  // Code also causes flicker in active cell as mouse is moved
  if wwUseThemes(self) then
  begin
{$IFDEF wwUseThemeManager}
    Coord := MouseCoord(x, Y);
    if ((lastMouseCoord.x <> Coord.x) or (lastMouseCoord.Y <> Coord.Y)) then
    begin
      if (HotCol <> 0) or (HotRow <> 0) then
      begin
        // InvalidateCell(LastMouseCoord.x, LastMouseCoord.y);
        invalidateCell(HotCol, HotRow); // MouseExit
        HotCol := 0;
        HotRow := 0;
      end;
      // if not ((coord.x=Col) and (coord.y=Row)) then
      if Coord.x = Col then // Only do for active record
        invalidateCell(Coord.x, Coord.Y);
    end;
    lastMouseCoord := Coord;
{$ENDIF}
  end;

  HintMouseMove(Shift, x, Y);
end;

procedure TwwDataInspector.CalcSizingState(x, Y: Integer; var State: TGridState;
  var Index: Longint; var SizingPos, SizingOfs: Integer;
  var FixedInfo: TGridDrawInfo);

  procedure CalcAxisState(const AxisInfo: TGridAxisDrawInfo; Pos: Integer;
    NewState: TGridState);
  var
    i, Line, Back, Range: Integer;
    tolerance: Integer;
    obj: TwwInspectorItem;
  begin
    if NewState = gsColSizing then
      tolerance := 7
    else
      tolerance := 5;

    if UseRightToLeftAlignment then
      Pos := ClientWidth - Pos;
    with AxisInfo do
    begin
      Line := FixedBoundary;
      Range := EffectiveLineWidth;
      Back := 0;
      if Range < tolerance then
      begin
        Range := tolerance;
        Back := (Range - EffectiveLineWidth) shr 1;
      end;

      for i := FirstGridCell to GridCellCount - 1 do
      begin
        inc(Line, GetExtent(i));
        if Line > GridBoundary then
          break;
        if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
        begin
          if NewState = gsRowSizing then
          begin
            obj := GetItemByRow(i);
            if (obj <> nil) and not obj.Resizeable then
              exit;
          end;

          State := NewState;
          SizingPos := Line;
          SizingOfs := Line - Pos;
          Index := i;
          exit;
        end;
        inc(Line, EffectiveLineWidth);
      end;
      if (GridBoundary = GridExtent) and (Pos >= GridExtent - Back) and
        (Pos <= GridExtent) then
      begin
        if NewState = gsRowSizing then
        begin
          obj := GetItemByRow(i);
          if (obj <> nil) and not obj.Resizeable then
            exit;
        end;
        State := NewState;
        SizingPos := GridExtent;
        SizingOfs := GridExtent - Pos;
        Index := LastFullVisibleCell + 1;
      end;
    end;
  end;

  function XOutsideHorzFixedBoundary: boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        result := x > Horz.FixedBoundary
      else
        result := x < ClientWidth - Horz.FixedBoundary;
  end;

  function XOutsideOrEqualHorzFixedBoundary: boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        result := x >= Horz.FixedBoundary
      else
        result := x <= ClientWidth - Horz.FixedBoundary;
  end;

var
  EffectiveOptions: TGridOptions;
begin
  State := gsNormal;
  Index := -1;
  EffectiveOptions := inherited Options;
  if csDesigning in ComponentState then
    EffectiveOptions := EffectiveOptions + DesignOptionsBoost;
  if [goColSizing, goRowSizing] * EffectiveOptions <> [] then
    with FixedInfo do
    begin
      Vert.GridExtent := ClientHeight;
      Horz.GridExtent := ClientWidth;
      if (goColSizing in EffectiveOptions) then
      begin
        CalcAxisState(Horz, x, gsColSizing);
      end;

      if (State <> gsColSizing) and (goRowSizing in EffectiveOptions) then
      begin
        if x > ColWidths[0] then
          exit;
        CalcAxisState(Vert, Y, gsRowSizing);
      end;
    end;
end;

function TwwDataInspector.GetPageHeight: Integer;
var
  DrawInfo: TGridDrawInfo;
  PageHeight: Integer;
begin
  CalcDrawInfo(DrawInfo);
  PageHeight := (DrawInfo.Vert.LastFullVisibleCell + 1) - TopRow;
  if PageHeight < 1 then
    PageHeight := 1;
  result := PageHeight;
end;

// Return true row from data row number
function TwwDataInspector.DataRow(ARow: Integer): Integer;
begin
  if IndicatorRow.Enabled then
    result := ARow + 1
  else
    result := ARow;
end;

procedure TwwDataInspector.KeyDown(var Key: Word; Shift: TShiftState);
  procedure SetCustomControlFocus;
  begin
    if (CurrentCustomEdit <> nil) and (CurrentCustomEdit.Visible) then
      CurrentCustomEditSetfocus;
  end;

var
  obj: TwwInspectorItem;
  ParentForm: TCustomForm;
begin
  if Assigned(OnKeyDown) then
    OnKeyDown(self, Key, Shift);

  if (ovEnterToTab in Options) and (Key = VK_RETURN) then
    Key := 9;

  if (ssCtrl in Shift) or (ColCount <= 2) then
  begin
    case Key of
      vk_right:
        begin
          obj := GetItemByRow(Row);
          if ((obj.ReadOnly) or (ssCtrl in Shift)) and (obj.Items.Count > 0) and
            (not obj.Expanded) then
          begin
            DoExpand(obj);
            Key := 0;
          end;
        end;
      vk_left:
        begin
          obj := GetItemByRow(Row);
          if ((obj.ReadOnly) or (ssCtrl in Shift)) and (obj.Items.Count > 0) and
            obj.Expanded then
          begin
            DoCollapse(obj);
            Key := 0;
          end;
        end;
      vk_home:
        begin
          SetFocusCell(Col, DataRow(0))
        end;
      vk_end:
        begin
          SetFocusCell(Col, RowCount - 1);
        end;
    end;
  end;

  begin

    case Key of
      vk_next:
        begin
          SetFocusCell(Col, wwMin(RowCount - 1, Row + GetPageHeight));
        end;

      vk_prior:
        begin
          SetFocusCell(Col, wwMax(DataRow(0), Row - GetPageHeight));
        end;

      vk_right:
        begin
          if (ColCount > 2) and { (Col<ColCount-1) and } FDataLink.Active and
            not(FDataLink.Dataset.Eof) then
          begin
            if CurrentCustomEdit <> nil then
            begin
              SetFocus;
              CurrentCustomEdit.Visible := false;
            end;
            FDataLink.MoveBy(1); // SetFocusCell(Col+1, Row)
            Key := 0;
          end
          else if parent is TCustomGrid then
          begin
            PostMessage(parent.Handle, WM_KEYDOWN, Key, wwGetEventShift(Shift));
          end
        end;

      vk_left:
        begin
          if (ColCount > 2) and FDataLink.Active and not(FDataLink.Dataset.Bof)
          then
          begin
            if CurrentCustomEdit <> nil then
            begin
              SetFocus;
              CurrentCustomEdit.Visible := false;
            end;
            FDataLink.MoveBy(-1); // SetFocusCell(Col-1, Row)
            Key := 0;
          end
          else if parent is TCustomGrid then
          begin
            PostMessage(parent.Handle, WM_KEYDOWN, Key, wwGetEventShift(Shift));
          end
        end;
      vk_up:
        begin
          if Row > DataRow(0) then
            SetFocusCell(Col, Row - 1)
          else if parent is TCustomGrid then
          begin
            SendMessage(parent.Handle, WM_KEYDOWN, Key, wwGetEventShift(Shift));
            // Row:= RowCount-1; // 6/20/03 - Should have been removed as in IP 3000

            // 8/1/02 - Call SetFocusCell instead of setteing Row so focus is set
            // correctly to inplaceeditor or customcontrol
            SetFocusCell(Col, RowCount - 1);
          end

        end;

      vk_down:
        begin
          if Row < RowCount - 1 then
            SetFocusCell(Col, Row + 1)
          else if parent is TCustomGrid then
          begin
            // 10/26/07 - Try to flush contents before asking grid to move to next row
            // This gives chance for exception to occur to prevent other code from executing
            FlushContents;

            SendMessage(parent.Handle, WM_KEYDOWN, Key, wwGetEventShift(Shift));
            // Row:= DataRow(0); // 6/20/03 - Should have been removed as in IP 3000

            // 8/1/02 - Call SetFocusCell instead of setteing Row so focus is set
            // correctly to inplaceeditor or customcontrol
            SetFocusCell(Col, 0);
          end
        end;

      vk_tab:
        if not(ssCtrl in Shift) then
        begin // 11/23/02 - If control pressed then ignore tab
          if ssShift in Shift then
          begin
            obj := GetItemByRow(Row);
            if obj <> nil then
              repeat { 7/20/00 - ovTabToVisibleOnly should use 2nd paramater, not first }
                obj := obj.GetPrior(true, (ovTabToVisibleOnly in Options))
              until (obj = nil) or ((obj.TabStop = true) and (obj.Enabled));
            if obj <> nil then
              ActiveItem := obj
            else
            begin
              if parent is TCustomGrid then
              begin
                PostMessage(parent.Handle, WM_KEYDOWN, vk_tab,
                  wwGetEventShift(Shift));
              end
              else
              begin
                { 1/28/2000 - Send to parent form, not parent }
                ParentForm := GetParentForm(self);
                if Assigned(ParentForm) then
                  ParentForm.Perform(wm_nextdlgctl, 1, 0);
              end
            end
          end
          else
          begin
            obj := GetItemByRow(Row);
            if obj <> nil then
              repeat { 7/20/00 - ovTabToVisibleOnly should use 2nd paramater, not first }
                obj := obj.GetNext(true, (ovTabToVisibleOnly in Options))
              until (obj = nil) or ((obj.TabStop = true) and (obj.Enabled));
            if obj <> nil then
              ActiveItem := obj
            else
            begin
              if parent is TCustomGrid then
              begin
                PostMessage(parent.Handle, WM_KEYDOWN, vk_tab, 0);
              end
              else
              begin
                { 1/28/2000 - Send to parent form, not parent }
                ParentForm := GetParentForm(self);
                if Assigned(ParentForm) then
                  ParentForm.Perform(wm_nextdlgctl, 0, 0);
              end
            end;
          end
        end;

      13:
        begin
          if CurrentCustomEdit <> nil then
          begin
            if CurrentCustomEdit is TCustomEdit then
            begin
              with TEdit(CurrentCustomEdit) do
                SelectAll;
            end;
          end
        end;

      VK_ESCAPE:
        begin
          TwwDataInspectorDataLink(FDataLink).Reset;
          { Highlight entire inplaceedit upon escape }
          if (InplaceEditor <> nil) and (InplaceEditor.Visible) then
            InplaceEditor.SelectAll;

        end;
    end
  end;

  SetCustomControlFocus; // inherited;
end;

Function TwwDataInspector.GetCanvas: TCanvas;
begin
  if UseTempCanvas and not(csPaintCopy in ControlState) then
    result := FPaintCanvas
  else
    result := inherited Canvas;
end;

Function TwwDataInspector.HaveVisibleItem: boolean;
var
  i: Integer;
begin
  result := false;

  for i := 0 to Items.Count - 1 do
  begin
    if TwwInspectorItem(Items[i]).Visible then
    begin
      result := true;
      break;
    end
  end;
end;

Function TwwInspectorItem.HaveVisibleItem: boolean;
var
  i: Integer;
begin
  result := false;

  for i := 0 to Items.Count - 1 do
  begin
    if TwwInspectorItem(Items[i]).Visible then
    begin
      result := true;
      break;
    end
  end;
end;

function TwwDataInspector.IsHighlightRowVisible: boolean;
begin
  result := (ovHighlightActiveRow in Options) and FFocused and
    not(csPaintCopy in ControlState)
end;

procedure TwwDataInspector.Paint;
var
  RowPixel: Integer;
  curRow: Integer;
  DrawInfo: TGridDrawInfo;
  TempRect: TRect;
  obj: TwwInspectorItem;
  SkipPaintIndicatorLines: boolean;
  IsCustomStyle: boolean;

  procedure DottedDataLine;
  var
    ACol: Integer;
    R: TRect;
    TempColCount: Integer;
  begin
    // if (parent is TCustomGrid) and (CurRow>DrawInfo.Vert.LastFullVisibleCell) then exit;

    TempColCount := ColCount;
    if FDataLink.Active and (ColCount > 2) then
      TempColCount := wwMax(1, wwMin(ColCount, FDataLink.RecordCount + 1));

    for ACol := 1 to TempColCount - 1 do
    begin
      R := CellRect(ACol, curRow);

      if EffectiveFocused and (curRow = Row + 1) and (Col = ACol) then
        continue
      else if (curRow = TopRow) and IndicatorRow.Enabled then
      begin
        if (Col = ACol) and (ovActiveRecord3DLines in Options) then
        begin
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(R.Left, RowPixel - 1);
          Canvas.LineTo(R.right, RowPixel - 1);
        end
        else
        begin
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(R.Left, RowPixel - 1);
          Canvas.LineTo(R.right, RowPixel - 1);
        end;
        continue;
      end;

      Canvas.Pen.Color := DottedLineColor;
      wwDottedLine(Canvas, Point(R.Left, RowPixel - 1),
        Point(R.right, RowPixel - 1));
    end;
  end;

  procedure DottedCaptionLine;
  begin
    Canvas.Pen.Color := DottedLineColor;
    if IsHighlightRowVisible and (curRow = Row + 1) then
      exit; { Don't draw dotted line for top of next row }

    wwDottedLine(Canvas, Point(0, RowPixel - 1),
      Point(ColWidths[0], RowPixel - 1));
  end;

  procedure LightDataLine;
  var
    ACol: Integer;
    R: TRect;
    TempColCount: Integer;
  begin
    TempColCount := ColCount;
    if FDataLink.Active and (ColCount > 2) then
      TempColCount := wwMax(1, wwMin(ColCount, FDataLink.RecordCount + 1));

    for ACol := 1 to TempColCount - 1 do
    begin
      R := CellRect(ACol, curRow);
      // Don't paint dbl-btnhighlight or shadow
      if (curRow = TopRow) and IndicatorRow.Enabled and
        ((ACol <> Col) or (DataColumns = 1) or not(ovActiveRecord3DLines
        in Options)) then
      begin
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, RowPixel - 1);
        Canvas.LineTo(R.right, RowPixel - 1);
        continue;
      end
      else
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, RowPixel - 1);
        Canvas.LineTo(R.right, RowPixel - 1);
        if IsHighlightRowVisible and (curRow = Row) then
          continue;

        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, RowPixel);
        Canvas.LineTo(R.right, RowPixel);
      end;
      {
        if EffectiveFocused and (CurRow=Row) then
        begin
        if ACol<>Col then
        begin
        Canvas.Pen.Color:= clBtnShadow;
        Canvas.MoveTo(r.left, RowPixel-1);
        Canvas.LineTo(r.right, RowPixel-1);
        end;
        if not IsHighlightRowVisible then
        begin
        Canvas.Pen.Color:= clBtnHighlight;
        Canvas.MoveTo(r.left, RowPixel);
        Canvas.LineTo(r.right, RowPixel);
        end
        end;
      }
    end
  end;

  procedure NoDataLine;
  var
    R: TRect;
  begin
    R := CellRect(Col, Row);
    if csPaintCopy in ControlState then // 3/17/2013 - Don't paint lines at all in cspaintcopy
      exit;
    // Canvas.Pen.Color:= clBlack;
    Canvas.Pen.Color := clSilver;
    Canvas.MoveTo(R.Left, R.Top - 1);
    Canvas.LineTo(R.right, R.Top - 1);
    Canvas.MoveTo(R.Left, R.Bottom - 1);
    Canvas.LineTo(R.right, R.Bottom - 1);
  end;

  procedure DarkDataLine;
  var
    ACol: Integer;
    R: TRect;
    TempColCount: Integer;
  begin
    TempColCount := ColCount;
    if FDataLink.Active and (ColCount > 2) then
      TempColCount := wwMax(1, wwMin(ColCount, FDataLink.RecordCount + 1));

    for ACol := 1 to TempColCount - 1 do
    begin
      R := CellRect(ACol, curRow);
      // Don't paint dbl-btnhighlight or shadow
      if (curRow = TopRow) and IndicatorRow.Enabled and
        ((ACol <> Col) or (DataColumns = 1) or not(ovActiveRecord3DLines
        in Options)) then
      begin
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, RowPixel - 1);
        Canvas.LineTo(R.right, RowPixel - 1);
        continue;
      end
      else
      begin
        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(R.Left, RowPixel - 1);
        Canvas.LineTo(R.right, RowPixel - 1);
        if IsHighlightRowVisible and (curRow = Row) then
          continue;
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, RowPixel);
        Canvas.LineTo(R.right, RowPixel);
      end;
    end;
  end;

{ Draw separater line }
  procedure DrawSeparatorLines;
  var
    ACol: Integer;
    R: TRect;
    BottomLine, TopLine: Integer;
    TempColCount: Integer;
  begin
    TempColCount := ColCount;
    if FDataLink.Active and (ColCount > 2) then
      TempColCount := wwMax(1, wwMin(ColCount, FDataLink.RecordCount + 1));

    for ACol := 1 to ColCount - 1 do
    begin
      R := CellRect(ACol, TopRow);

      if (parent is TCustomGrid) then
        Canvas.Pen.Color := clBtnShadow
      else
        Canvas.Pen.Color := clBlack;

      if ((ACol > 1) or (ColCount = 2)) and
        ((ovHideVertDataLines in Options) or (ACol > TempColCount)) then
      begin
        BottomLine := 0;
        if IndicatorRow.Enabled then
          BottomLine := CellRect(0, 0).Bottom - 1
      end
      else
        BottomLine := RowPixel - 1;

      // Support dotted vertical line in grid
      if not(ovHideVertFixedLines in Options) or
        not(ovHideVertDataLines in Options) then
        if (not(parent is TCustomGrid)) or not(LineStyleData = ovDottedLine)
        then
        begin
          TopLine := 0;
          if ovHideVertFixedLines in Options then
            TopLine := CellRect(0, 0).Bottom - 1;
          Canvas.MoveTo(R.Left - 1, TopLine);
          Canvas.LineTo(R.Left - 1, BottomLine);
          if (LineStyleData <> ovButtonLine) then
          begin
            Canvas.Pen.Color := clBtnHighlight;
            Canvas.MoveTo(R.Left, TopLine);
            Canvas.LineTo(R.Left, BottomLine);
          end;
        end
        else
        begin
          Canvas.Pen.Color := DottedLineColor;
          wwDottedLine(Canvas, Point(R.Left - 1, 1),
            Point(R.Left - 1, BottomLine));
        end;
    end;

    // Not enough records to fill inspector so paint last vertical line
    if (ColCount > TempColCount) then
      BottomLine := CellRect(0, 0).Bottom
    else
      BottomLine := RowPixel;
    // BottomLine:= RowPixel;

    if (ColCount <= DataColumns + 1) and not(parent is TCustomGrid) then
    begin
      R := CellRect(ColCount - 1, TopRow);
      Canvas.Pen.Color := clBtnShadow;
      Canvas.MoveTo(R.right - 1, 0);
      Canvas.LineTo(R.right - 1, BottomLine - 1);
      Canvas.Pen.Color := clBtnHighlight;
      Canvas.MoveTo(R.right, 0);
      Canvas.LineTo(R.right, BottomLine - 1);
    end
  end;

  procedure ButtonDataLine;
  var
    ACol: Integer;
    R: TRect;
  begin
    // if FFocused and (CurRow=Row+1) then exit;
    for ACol := 1 to ColCount do
    begin
      R := CellRect(ACol, curRow);
      if EffectiveFocused and (curRow = Row) then
      begin
        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(R.Left, RowPixel - 1);
        Canvas.LineTo(R.right, RowPixel - 1);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, RowPixel - 2);
        Canvas.LineTo(R.right, RowPixel - 2);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, RowPixel);
        Canvas.LineTo(R.right, RowPixel);
      end
      else
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, RowPixel - 2);
        Canvas.LineTo(R.right, RowPixel - 2);

        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(R.Left, RowPixel - 1);
        Canvas.LineTo(R.right, RowPixel - 1);

        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, RowPixel);
        Canvas.LineTo(R.right, RowPixel);
      end
    end
  end;

  procedure LightCaptionLine;
  begin
    if (curRow = TopRow) and IndicatorRow.Enabled then
      exit;
    if IsHighlightRowVisible and (curRow = Row) then
      exit;

    Canvas.Pen.Color := clBtnShadow;
    Canvas.MoveTo(0, RowPixel - 1);
    Canvas.LineTo(ColWidths[0] - 1, RowPixel - 1);
    Canvas.Pen.Color := clBtnHighlight;
    Canvas.MoveTo(0, RowPixel);
    Canvas.LineTo(ColWidths[0], RowPixel);
  end;

  procedure DarkCaptionLine;
  begin
    if (curRow = TopRow) and IndicatorRow.Enabled then
      exit;
    if IsHighlightRowVisible and (curRow = Row) then
      exit;

    Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(0, RowPixel - 1);
    Canvas.LineTo(ColWidths[0] - 1, RowPixel - 1);
    Canvas.Pen.Color := clBtnHighlight;
    Canvas.MoveTo(0, RowPixel);
    Canvas.LineTo(ColWidths[0], RowPixel);
  end;

  procedure ButtonCaptionLine;
  begin
    if (curRow = TopRow) and IndicatorRow.Enabled then
      exit;
    { if IsCaptionLinesVisible and (CurRow=Row+1) then
      begin
      end
      else } if IsHighlightRowVisible and (curRow = Row) then
    begin
      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(0, RowPixel - 1);
      Canvas.LineTo(ColWidths[0] - 1, RowPixel - 1);
      Canvas.Pen.Color := clBtnShadow;
      Canvas.MoveTo(0, RowPixel - 2);
      Canvas.LineTo(ColWidths[0] - 1, RowPixel - 2);
      Canvas.Pen.Color := clBtnShadow;
      Canvas.MoveTo(0, RowPixel);
      Canvas.LineTo(ColWidths[0] - 1, RowPixel);
    end
    else
    begin
      Canvas.Pen.Color := clBtnShadow;
      Canvas.MoveTo(0, RowPixel - 2);
      Canvas.LineTo(ColWidths[0] - 1, RowPixel - 2);
      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(0, RowPixel - 1);
      Canvas.LineTo(ColWidths[0] - 1, RowPixel - 1);
      Canvas.Pen.Color := clBtnHighlight;
      Canvas.MoveTo(0, RowPixel);
      Canvas.LineTo(ColWidths[0], RowPixel);
    end;
  end;

  procedure EndPainting;
  var
    R, sourceRect: TRect;
    PaintClipRect: TRect;
    TempRect: TRect;
  begin
    if (inherited Canvas = Canvas) then
      exit;
    R := ClientRect;

    OffsetRect(R, 1, 0);
    if csPaintCopy in ControlState then
      Canvas.CopyMode := cmSrcAnd
    else
      Canvas.CopyMode := cmSrcCopy;
    // (inherited Canvas).CopyMode:= cmSrcCopy;

    PaintClipRect := FPaintCanvas.ClipRect;
    if PaintClipRect.right > ClientRect.right then
    begin
      PaintClipRect.right := ClientRect.right;
    end;
    if UpdateRect.Bottom > ClientRect.Bottom then
    begin
      UpdateRect.Bottom := ClientRect.Bottom;
    end;

    if (UpdateRect.Top = 0) and (UpdateRect.Bottom = 0) and
      (UpdateRect.Left = 0) and (UpdateRect.right = 0) then
      UpdateRect := PaintClipRect;
    sourceRect := Rect(0, UpdateRect.Top, PaintClipRect.right,
      UpdateRect.Bottom);
    { Remove painting of currently edited cell }
    if not(csDesigning in ComponentState) and (EffectiveFocused) and
      (HaveVisibleItem) then
    begin
      if Col <= 1 then
        TempRect := CellRect(1, Row)
      else
        TempRect := CellRect(Col, Row);
      TempRect.Left := TempRect.Left + 1;
      { Used to be +2, but richedit gray line would show after resizing }
      TempRect.Bottom := TempRect.Bottom - 2;
      // 2/5/01 - Need to paint bottom so -1 subtracted
      TempRect.right := TempRect.right - 1;

      { 7/19/00 - RSW - Don't remove inplaceeditor painting if it has the focus }
      // 2/20/01 - Don't remove activeedit area as it causes problem with AlwaysTransparent of checkbox
      if (ActiveEdit <> nil) and (ActiveEdit <> InplaceEditor) and
        (not UseCheckbox(Row)) then
        if not wwGetAlwaysTransparent(ActiveEdit) then
          FPaintCanvas.CopyRect(TempRect, inherited Canvas, TempRect);
    end;

    sourceRect := Rect(0, 0, ClientRect.right, ClientRect.Bottom);
    inherited Canvas.CopyRect(sourceRect, FPaintCanvas, sourceRect);
  end;

  procedure DrawHighlightCustomControlLines;
  var
    R: TRect;
  begin
    obj := ActiveItem;
    if (obj <> nil) and (obj.CustomControlHighlight) then
    begin
      Canvas.Brush.Color := clWindowFrame;
      R := CellRect(Col, Row);
      R.right := R.right + 1;
      Canvas.FrameRect(R);
    end;
  end;

  procedure PaintIndicatorLines;
  var
    ACol: Integer;
    TempColCount: Integer;
    lineoffset: Integer;
  begin

    if IndicatorRow.Enabled then
    begin
      // Canvas.Pen.Color:= clBtnHighlight;
      // Canvas.MoveTo(0, 0);
      // Canvas.LineTo(CellRect(ColCount-1, 0).right, 0);
      Canvas.Pen.Color := clBtnHighlight;
      TempColCount := ColCount;
      if FDataLink.Active and (ColCount > 2) then
        TempColCount := wwMax(1, wwMin(ColCount, FDataLink.RecordCount + 1));

      for ACol := 0 to ColCount - 1 do
      begin
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(CellRect(ACol, 0).Left, 0);
        lineoffset := 0;
        if ACol <= TempColCount then
          lineoffset := 1;
        if ovHideVertFixedLines in Options then
          lineoffset := 0;
        Canvas.LineTo(CellRect(ACol, 0).right - lineoffset, 0);

        if ACol <= TempColCount then
          lineoffset := 1;
        Canvas.MoveTo(CellRect(ACol, 0).Left, RowHeights[0] - 1);
        Canvas.LineTo(CellRect(ACol, 0).right - lineoffset, RowHeights[0] - 1);

        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(CellRect(ACol, 0).right, RowHeights[0] - 2);
        Canvas.LineTo(CellRect(ACol, 0).right, RowHeights[0] - 2);
      end;

      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(0, RowHeights[0] - 2);
      Canvas.LineTo(CellRect(0, 0).right, RowHeights[0] - 2);

      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(CellRect(0, 0).right, RowHeights[0] - 2);
      Canvas.LineTo(CellRect(ColCount - 1, 0).right, RowHeights[0] - 2);
    end;
  end;
  procedure DrawActiveVerticalLine;
  var
    Bottom, Top: Integer;
    procedure DrawLine(cr: TRect; StartY, EndY: Integer);
    begin
      Canvas.Pen.Color := clBtnShadow;
      Canvas.MoveTo(cr.Left - 1, StartY);
      Canvas.LineTo(cr.Left - 1, EndY);
      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(cr.Left, StartY - 1);
      Canvas.LineTo(cr.Left, EndY);

      Canvas.Pen.Color := clSilver;
      Canvas.MoveTo(cr.right - 1, StartY);
      Canvas.LineTo(cr.right - 1, EndY);
      Canvas.Pen.Color := clWhite;
      Canvas.MoveTo(cr.right, StartY);
      Canvas.LineTo(cr.right, EndY);
    end;

  begin
    if IndicatorRow.Enabled then
      Top := CellRect(0, 0).Bottom
    else
      Top := 0;

    if (RowCount - 1 = DrawInfo.Vert.LastFullVisibleCell) then
    begin
      Bottom := CellRect(Col, RowCount - 1).Bottom;
    end
    else
      Bottom := ClientHeight;

    if IsHighlightRowVisible then
    begin
      DrawLine(CellRect(Col, Row), Top, CellRect(Col, Row).Top);
      DrawLine(CellRect(Col, Row), CellRect(Col, Row).Bottom, Bottom);
    end
    else
    begin
      DrawLine(CellRect(Col, Row), Top, Bottom);
    end
  end;

begin
  if not isFocused then
  begin
    HideEditor;
    { Make sure inplaceeditor is not visible when inspector doesn't have focus }
  end;

  OldDesigning := csDesigning in ComponentState;
  UseTempCanvas := true;
  if PaintOptions.InitBlendBitmapsFlag then
    PaintOptions.InitBlendBitmaps;

  FPaintBitmap.Width := ClientWidth;
  FPaintBitmap.Height := ClientHeight;

  CalcDrawInfo(DrawInfo);
  // Fill data area
  if Color = clNone then
    Canvas.Brush.Color := clWindow
  else
    Canvas.Brush.Color := Color;
  TempRect := ClientRect;
  TempRect.Left := ColWidths[0];
  IsCustomStyle := wwIsCustomStyle(self);

  if (ovUseOwnBackgroundColors in Options) or not(csPaintCopy in ControlState)
  then
  begin
    if IsCustomStyle then
      // Fill with style background
      wwPaintGridCellBackgroundColor(self, Canvas, TempRect)
    else
      Canvas.FillRect(TempRect);
  end;

  // Fill bottom data area
  if not(csPaintCopy in ControlState) then
    with DrawInfo do
    begin
      if (RowCount - 1 = Vert.LastFullVisibleCell) then
      begin
        TempRect := CellRect(0, RowCount - 1);
        TempRect.Top := TempRect.Bottom;
        TempRect.Bottom := ClientHeight;
        TempRect.right := ClientWidth;
        if (ovFillNonCellArea in Options) then
        begin
          if (not IsCustomStyle) and (PaintOptions.Column1Bitmap <> nil) then
            Canvas.CopyRect(TempRect,
              PaintOptions.Column1Bitmap.Canvas, TempRect)
          else
          begin
            if FixedColor = clNone then
              Canvas.Brush.Color := clWindow
            else
              Canvas.Brush.Color := FixedColor;
            if IsCustomStyle then
              wwPaintFixedGridCellBackgroundColor(self, Canvas, TempRect)
            else
              Canvas.FillRect(TempRect);
          end
        end
        else
        begin
          TempRect.Left := ColWidths[0];
          if (not IsCustomStyle) and PaintOptions.HaveBackgroundForDataCells
          then
            Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.Canvas, TempRect)
          else
          begin
            Canvas.Brush.Color := Color;
            if IsCustomStyle then
              wwPaintGridCellBackgroundColor(self, Canvas, TempRect)
            else
              Canvas.FillRect(TempRect);
          end
        end
      end;
    end;

  // 8/2/02
  if (not(ovUseOwnBackgroundColors in Options)) and (parent is TwwDBGrid) and
    not(csPaintCopy in ControlState) then
    TwwDBGrid(parent).PaintActiveRowBackground(Canvas, ClientRect);

  // Fill caption area
  TempRect := ClientRect;
  TempRect.right := ColWidths[0];

  // Honor CaptionColor = clNone
  if (not(csPaintCopy in ControlState) and not(parent is TwwDBGrid)) or
    (CaptionColor <> clNone) then
  begin
    if (not IsCustomStyle) and (PaintOptions.Column1Bitmap <> nil) then
      Canvas.CopyRect(TempRect, PaintOptions.Column1Bitmap.Canvas, TempRect)
    else
    begin
      if FixedColor = clNone then
        Canvas.Brush.Color := clWindow
      else
        Canvas.Brush.Color := FixedColor;
      if IsCustomStyle then
        wwPaintFixedGridCellBackgroundColor(self, Canvas, TempRect)
      else
        Canvas.FillRect(TempRect);
    end;
  end;

  try
    if Assigned(FOnBeforePaint) then
    begin
      FOnBeforePaint(self);
    end;
    if CheckRowCount then
      FirstTimePaint;
    UpdateRowCount;

    CalcDrawInfo(DrawInfo);

    RowPixel := 0;
    if IndicatorRow.Enabled then
      RowPixel := RowHeights[0];

    InheritedPaint;

    for curRow := TopRow to RowCount do
    begin
      if (parent is TCustomGrid) and (curRow = RowCount) then
        break;

      case LineStyleCaption of
        ovNoLines:
          if curRow = RowCount then
            LightCaptionLine;
        ovDottedLine:
          DottedCaptionLine;
        ovLight3DLine:
          LightCaptionLine;
        ovDark3DLine:
          DarkCaptionLine;
        ovButtonLine:
          ButtonCaptionLine;
      end;

      if (curRow >= TopRow) then
      begin
        case LineStyleData of
          ovNoLines:
            begin
              if (curRow = RowCount) then
                LightDataLine
              else if (curRow = TopRow) and IndicatorRow.Enabled then
                // LightDataLine
              else
                NoDataLine;
            end;

          ovDottedLine:
            DottedDataLine;
          ovLight3DLine:
            LightDataLine;
          ovDark3DLine:
            DarkDataLine;
          ovButtonLine:
            ButtonDataLine;
        end;
      end;

      if (LineStyleData = ovButtonLine) and (curRow <> Row)
      { and (CurRow <> Row+1) } and (curRow < RowCount) then
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(ColWidths[0] - 2, RowPixel);
        Canvas.LineTo(ColWidths[0] - 2, RowPixel + RowHeights[curRow]);
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(0, RowPixel);
        Canvas.LineTo(0, RowPixel + RowHeights[curRow]);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(ColWidths[0] + ColWidths[1] - 1, RowPixel);
        Canvas.LineTo(ColWidths[0] + ColWidths[1] - 1,
          RowPixel + RowHeights[curRow]);
      end
      else if (LineStyleData = ovButtonLine) and (curRow = Row) and
        (curRow < RowCount) then
      begin
        if not IsHighlightRowVisible then
        begin
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(ColWidths[0], RowPixel);
          Canvas.LineTo(ColWidths[0], RowPixel + RowHeights[curRow]);
          Canvas.MoveTo(ColWidths[0] - 2, RowPixel);
          Canvas.LineTo(ColWidths[0] - 2, RowPixel + RowHeights[curRow]);
        end;

        if not IsHighlightRowVisible then
          Canvas.Pen.Color := clBtnHighlight
        else
          Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(0, RowPixel);
        Canvas.LineTo(0, RowPixel + RowHeights[curRow]);

        if BorderStyle = bsNone then
        begin
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(ColWidths[0] + ColWidths[1] - 1, RowPixel);
          Canvas.LineTo(ColWidths[0] + ColWidths[1] - 1,
            RowPixel + RowHeights[curRow]);
        end;
      end;

      if curRow < RowCount then
        inc(RowPixel, RowHeights[curRow]);
      if RowPixel > DrawInfo.Vert.GridBoundary then
        break;
    end;

    DrawSeparatorLines;
    DrawHighlightCustomControlLines;
    SkipPaintIndicatorLines := false;

    { Draw caption highlight line for active row }
    if EffectiveFocused then
    begin
      // Paint bottom of dotted line or we don't get any bottom line for active row with black background style
      if (not IsHighlightRowVisible) and (LineStyleData = ovDottedLine) and IsCustomStyle
      then
      begin
        Canvas.Pen.Color := DottedLineColor;

        RowPixel := CellRect(0, Row).Bottom;
        wwDottedLine(Canvas, Point(CellRect(Col, Row).Left + 1, RowPixel - 1),
          Point(CellRect(Col, Row).right, RowPixel - 1));
      end;

      RowPixel := CellRect(0, Row).Top;

      if ColorToRGB(CaptionColor) = ColorToRGB(clBtnHighlight) then
        Canvas.Pen.Color := clBlack
      else
        Canvas.Pen.Color := clBtnHighlight;
      Canvas.Pen.Color := clBtnShadow;

      if IsHighlightRowVisible then
      begin
        PaintIndicatorLines;
        SkipPaintIndicatorLines := true;
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(0, RowPixel - 2);
        Canvas.LineTo(CellRect(ColCount - 1, Row).right, RowPixel - 2);
        Canvas.Pen.Color := clBlack;
        Canvas.MoveTo(0, RowPixel - 1);
        Canvas.LineTo(CellRect(ColCount - 1, Row).right, RowPixel - 1);
        RowPixel := CellRect(0, Row).Bottom;
        Canvas.Pen.Color := clSilver;
        Canvas.MoveTo(0, RowPixel - 1);
        Canvas.LineTo(CellRect(ColCount - 1, Row).right - 1, RowPixel - 1);
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(0, RowPixel);
        Canvas.LineTo(CellRect(ColCount - 1, Row).right, RowPixel);
      end
      else
      begin
        if (Row <> TopRow) then
        begin
          if (not IsHighlightRowVisible) and (LineStyleData = ovDottedLine) and IsCustomStyle
          then
          else
          begin
            Canvas.MoveTo(CellRect(Col, Row).Left, RowPixel - 1);
            Canvas.LineTo(CellRect(Col, Row).right, RowPixel - 1);
          end
        end;
        { RowPixel:= CellRect(0, Row).Bottom;
          Canvas.MoveTo(CellRect(Col, Row).left, RowPixel-2);
          Canvas.LineTo(CellRect(Col, Row).Right, RowPixel-2); }
      end;
    end;

    if (ovActiveRecord3DLines in Options) then
    begin
      DrawActiveVerticalLine;
    end;
    if not SkipPaintIndicatorLines then
      PaintIndicatorLines;

    EndPainting;

    if UseDefaultEditor and (InplaceEditor <> nil) then
    begin
      InplaceEditor.Invalidate;
      InplaceEditor.Update;
    end
    else
    begin
      if CurrentCustomEdit <> nil then
      begin
        UpdateCustomEditPaint(CurrentCustomEdit);
      end;
    end;

    obj := ActiveItem;
    if obj <> LastActiveItem then
    begin
      LastActiveItem := obj;
      if Assigned(FOnAfterSelectCell) then
      begin
        FOnAfterSelectCell(self, obj);
      end;
    end;

  finally
    UseTempCanvas := false;
    ValidateRect(Handle, nil); // Don't paint again
  end;

end;

function TwwDataInspector.CanEditShow: boolean;
// var
// customEdit: TCustomEdit;
// obj: TwwInspectorItem;
begin
  result := inherited CanEditShow;
  if result then
  begin
    // obj:= GetItemByRow(Row);
    result := UseDefaultEditor;
    // result:= (Obj<>nil) and (obj.CustomControl=nil) and not (obj.Field is TDateTimeField)
  end;

end;

procedure TwwDataInspector.UpdateCurrentEditPosition;
var
  DrawInfo: TGridDrawInfo;
//  canShow: boolean;
//  obj: TwwInspectorItem;
begin
  if CurrentCustomEdit <> nil then
  begin
    CalcDrawInfo(DrawInfo);
    if (Row < TopRow) or (Row > DrawInfo.Vert.LastFullVisibleCell + 1) then
    begin
      if screen.activecontrol = CurrentCustomEdit then
        SetFocus;
      CurrentCustomEdit.Hide;
    end
    else
    begin
      CurrentCustomEdit.BoundsRect := ControlRect(Col, Row);
      CurrentCustomEdit.Visible := true;
      CurrentCustomEditSetfocus;
    end;
  end;
end;

(*
  procedure TwwDataInspector.InitBlendBitmaps(ForceInit: boolean = False);
  var ARect: TRect;
  NewboundsRect: TRect;
  DrawInfo: TGridDrawInfo;
  HaveBackgroundBitmap: boolean;
  i,j: integer;
  MemDC: HDC;
  begin
  if (not ForceInit) and (not InitBlendBitmapsFlag) then exit;

  {   NewboundsRect:= Rect(0, 0, BoundsRect.right-BoundsRect.left, BoundsRect.bottom-BoundsRect.top);
  if SameRect(OldBoundsRect, NewBoundsRect) then exit;
  OldboundsRect:= NewBoundsRect;
  }
  NewboundsRect:= Rect(0, 0, BoundsRect.right-BoundsRect.left, BoundsRect.bottom-BoundsRect.top);

  CalcDrawInfo(DrawInfo);
  UseTempCanvas:=True;
  try
  FPaintBitmap.Width := NewBoundsRect.right;
  FPaintBitmap.Height:= NewBoundsRect.Bottom;

  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(newBoundsRect);

  if not (PaintOptions.BackgroundBitmap.Width=0) then
  begin
  HaveBackgroundBitmap:=True;
  case PaintOptions.BackgroundBitmapDrawStyle of
  bdsTile:
  begin
  with PaintOptions.BackgroundBitmap do begin
  for i := 0 to (Self.Width div Width) do
  for j := 0 to (Self.Height div Height) do
  Canvas.Draw(i*Width, j*Height,Graphic);
  end
  end;
  bdsTopLeft:
  begin
  with PaintOptions.BackgroundBitmap do
  Canvas.Draw(0, 0, Graphic);
  end;
  bdsCenter:
  begin
  with PaintOptions.BackgroundBitmap do
  Canvas.Draw((self.width-Width)div 2,
  (self.Height-Height) div 2, Graphic);
  end;
  bdsStretch:
  begin
  with PaintOptions.BackgroundBitmap do
  Canvas.StretchDraw(Rect(0, 0, newBoundsRect.right, NewBoundsRect.bottom), Graphic);
  end;
  end;
  end
  else if Assigned(FOnBeforePaint) then
  begin
  FOnBeforePaint(self);
  HaveBackgroundBitmap:= True;
  end
  else HaveBackgroundBitmap:=False;

  // If 256 colors or less then no blending
  MemDC := GetDC(0);
  try
  if GetDeviceCaps(MemDC, BITSPIXEL)<=8 then exit;
  finally
  ReleaseDC(0, MemDC);
  end;

  if HaveBackgroundBitmap then
  begin
  if (OrigBitmap=nil) then
  OrigBitmap := TBitmap.Create;
  ARect:= NewBoundsRect;
  OrigBitmap.Assign(FPaintBitmap);
  end
  else begin
  OrigBitmap.Free;
  OrigBitmap:= nil;
  end;

  if (PaintOptions.ActiveColumnColor<>clNone) and
  HaveBackgroundBitmap and (coBlendActiveColumn in PaintOptions.BlendBitmapOptions) then
  begin
  if ActiveColumnBitmap = nil then
  ActiveColumnBitmap := TwwBitmap.Create;
  ARect:= newBoundsRect;//ClientRect;
  ActiveColumnBitmap.SetSize(ARect.Right, ARect.Bottom);
  ActiveColumnBitmap.canvas.CopyRect(ARect, Canvas, ARect);
  with wwGetColor(ColorToRGB(PaintOptions.ActiveColumnColor)) do
  ActiveColumnBitmap.Colorize(r,g,b);
  end
  else begin
  ActiveColumnBitmap.Free;
  ActiveColumnBitmap:= nil;
  end;

  if (PaintOptions.AlternatingRowColor<>clNone) and
  (PaintOptions.AlternatingRowRegions<>[]) and
  HaveBackgroundBitmap and (coBlendAlternatingRow in PaintOptions.BlendBitmapOptions) then
  begin
  if AlternatingColorBitmap = nil then
  AlternatingColorBitmap := TwwBitmap.Create;

  ARect:= NewBoundsRect;
  AlternatingColorBitmap.SetSize(ARect.Right, ARect.Bottom);
  AlternatingColorBitmap.canvas.CopyRect(ARect, Canvas, ARect);

  with wwGetColor(ColorToRGB(PaintOptions.AlternatingRowColor)) do
  AlternatingColorBitmap.Colorize(r,g,b);
  end
  else begin
  AlternatingColorBitmap.Free;
  AlternatingColorBitmap:= nil;
  end;

  if IndicatorRow.enabled and
  HaveBackgroundBitmap and (coBlendIndicatorRow in PaintOptions.BlendBitmapOptions) then
  begin
  if IndicatorRowBitmap=nil then
  IndicatorRowBitmap:= TwwBitmap.create;
  ARect:= CellRect(0,0);
  ARect.Right:= NewBoundsRect.Right;

  IndicatorRowBitmap.SetSize(ARect.Right, ARect.Bottom);
  IndicatorRowBitmap.Canvas.CopyRect(ARect, Canvas, ARect);

  with wwGetColor(ColorToRGB(IndicatorRow.Color)) do
  IndicatorRowBitmap.Colorize(r,g,b);
  end
  else begin
  IndicatorRowBitmap.Free;
  IndicatorRowBitmap:= nil;
  end;

  if HaveBackgroundBitmap and (coBlendCaptionColumn in PaintOptions.BlendBitmapOptions) then
  begin
  if CaptionColumnBitmap=nil then
  CaptionColumnBitmap:= TwwBitmap.create;
  //        ARect:= CellRect(0,0);
  //        ARect.Bottom:= NewBoundsRect.bottom;
  if ovFillNonCellArea in Options then ARect:= NewBoundsRect;
  ARect:= NewBoundsRect;

  CaptionColumnBitmap.SetSize(ARect.Right, ARect.Bottom);
  CaptionColumnBitmap.Canvas.CopyRect(ARect, Canvas, ARect);

  if (FixedColor<>clNone) then
  begin
  with wwGetColor(ColorToRGB(FixedColor)) do
  CaptionColumnBitmap.Colorize(r,g,b);
  end
  end
  else begin
  CaptionColumnBitmap.Free;
  CaptionColumnBitmap:= nil;
  end;
  finally
  UseTempCanvas:= False;
  InitBlendBitmapsFlag:= False;
  end
  end;
*)
procedure TwwDataInspector.TopLeftChanged;
var
  NextItem: TwwInspectorItem;
  i: Integer;
begin
  FreeHintWindow;

  inherited;
  if Assigned(FOnTopLeftChanged) then
    FOnTopLeftChanged(self);
  // InitBlendBitmaps;

  UpdateCurrentEditPosition;

  if not FastDesign then
    exit;

  if FTopItem = nil then
  begin
    FTopItem := GetFirstChild;
    if FTopItem = nil then
      exit;
  end;

  if (TopRow > OldTopRow) then
  begin
    if (TopRow - OldTopRow < 100) then
    begin
      for i := 1 to TopRow - OldTopRow do
      begin
        NextItem := FTopItem.GetNext(true);
        if NextItem <> nil then
          FTopItem := NextItem
        else
          break;
      end
    end
    else
      FTopItem := GetItemByRow(TopRow, false);
  end
  else
  begin
    if (OldTopRow - TopRow < 100) then
    begin
      for i := 1 to OldTopRow - TopRow do
      begin
        NextItem := FTopItem.GetPrior(true);
        if NextItem <> nil then
          FTopItem := NextItem
        else
          break;
      end;
    end
    else
      FTopItem := GetItemByRow(TopRow, false)
  end;

  OldTopRow := TopRow;
end;

procedure TwwDataInspector.DoExit;
begin
  if CurrentCustomEdit <> nil then
  begin
    CurrentCustomEdit.Hide;
    CurrentCustomEdit := nil;
  end;
  HideEditor;
  inherited DoExit;
end;

function TwwDataInspector.CreateEditor: TInplaceEdit;
begin
  result := TwwDataInspectorEdit.wwCreate(self, 0);
end;

constructor TwwDataInspectorEdit.wwCreate(AOwner: TComponent; dummy: Integer);
begin
  Create(AOwner);
  FwwPicture := TwwDBPicture.Create(self);
  FRegexMask := TwwRegexMask.Create(self);

  ParentGrid := Owner as TwwDataInspector;
  FWordWrap := false;
  // FWordWrap:= TwwDataInspector(ParentGrid).WordWrap;
{$IFDEF wwDelphi3Up}
  ImeMode := ParentGrid.ImeMode;
  ImeName := ParentGrid.ImeName;
{$ENDIF}
  ControlStyle := ControlStyle + [csReplicatable];

  OrigForeColor := clNone;
  OrigBackColor := clNone;

end;

destructor TwwDataInspectorEdit.Destroy;
begin
  FwwPicture.Free;
  FRegexMask.Free;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TwwDataInspectorEdit.DoRefreshValidationDisplay(input: string = '');

var
  valid: boolean;
begin
  if input = '' then
    input := Text;
  valid := true;
  if input <> '' then
  begin
    if not IsValidPictureValue(input) then
    begin
      valid := false;
    end
    else if (RegexMask.Mask <> '') then
    begin
      valid := RegexMatch(RegexMask.Mask, not RegexMask.CaseSensitive, input);
    end;
  end;

  // Change colors here
  // ApplyValidationColors(valid);
  DoRefreshValidationDisplay(valid);

end;

procedure TwwDataInspectorEdit.ResetValidationColors(ForeColor: TColor = clNone;
  BackColor: TColor = clNone);
begin
  if ForeColor = clNone then
  begin
    if OrigForeColor <> clNone then
      self.Font.Color := OrigForeColor
  end
  else
    self.Font.Color := ForeColor;

  if ForeColor = clNone then
  begin
    if OrigBackColor <> clNone then
      self.Color := OrigBackColor
  end
  else
    self.Color := BackColor;

  OrigBackColor := clNone;
  OrigForeColor := clNone;
end;

procedure TwwDataInspectorEdit.ApplyValidationColors(valid: boolean);
begin
  if csDesigning in ComponentState then
    exit;

  if wwInternational.ValidationFeedback.ErrorForeColor <> clNone then
  begin
    if not valid then
    begin
      if (OrigForeColor = clNone) then
      begin
        OrigForeColor := self.Font.Color;
        self.Font.Color := wwInternational.ValidationFeedback.ErrorForeColor
      end;
    end
    else if OrigForeColor <> clNone then
    begin
      self.Font.Color := OrigForeColor;
      OrigForeColor := clNone;
    end;
  end;

  if wwInternational.ValidationFeedback.ErrorBackColor <> clNone then
  begin
    if not valid then
    begin
      if (OrigBackColor = clNone) then
      begin
        OrigBackColor := self.Color;
        self.Color := wwInternational.ValidationFeedback.ErrorBackColor
      end;
    end
    else if OrigBackColor <> clNone then
    begin
      self.Color := OrigBackColor;
      OrigBackColor := clNone;
    end;
  end;

end;

procedure TwwDataInspectorEdit.DoRefreshValidationDisplay(valid: boolean);
begin
  // DoOnCheckValue(valid);

  ApplyValidationColors(valid); // Change colors here
  if Assigned(ParentGrid.FOnCheckValue) then
    ParentGrid.FOnCheckValue(self, valid);

end;

{ Convert cr to tab }
procedure TwwDataInspectorEdit.KeyDown(var Key: Word; Shift: TShiftState);
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

  procedure SendToParent;
  begin
    ParentGrid.SetFocus;
    ParentGrid.KeyDown(Key, Shift);
    Key := 0;
    Update;
  end;

  procedure SendToObjectView;
  begin
    // ParentGrid.setFocus;
    ParentGrid.KeyDown(Key, Shift);
  end;

  function Selection: TSelection;
  begin
    SendMessage(Handle, EM_GETSEL, Longint(@result.StartPos),
      Longint(@result.EndPos));
  end;

  function RightSide: boolean;
  begin
    with Selection do
      result := ((StartPos = 0) or (EndPos = StartPos)) and
        (EndPos = GetTextLen);
  end;

  function LeftSide: boolean;
  begin
    with Selection do
      result := (StartPos = 0) and ((EndPos = 0) or (EndPos = GetTextLen) or
        (isMasked and (EndPos = 1)));
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
    GridKeyDown := ParentGrid.OnKeyDown;
    if Assigned(GridKeyDown) then
      GridKeyDown(ParentGrid, Key, Shift);
  end;

  function Ctrl: boolean;
  begin
    result := ssCtrl in Shift;
  end;

  function InspectorInGrid: boolean;
  begin
    result := ParentGrid.parent is TwwDBGrid;
  end;

begin
  case Key of
    VK_RETURN:
      if ovEnterToTab in ParentGrid.Options then
      begin
        SendToParent;
      end;
    vk_up, vk_down, vk_prior, vk_next, VK_ESCAPE:
      SendToParent;
    VK_INSERT:
      if Shift = [] then
        SendToParent
      else if (Shift = [ssShift]) and not ParentGrid.CanEditModify then
        Key := 0;
    vk_left:
      if (Ctrl or (not InspectorInGrid)) and (ParentGrid.ColCount <= 2) then
        SendToObjectView; // 6/13/02 - Don't send unless Ctrl
    vk_right:
      if (Ctrl or (not InspectorInGrid)) and (ParentGrid.ColCount <= 2) then
        SendToObjectView; // 6/13/02 - Don't send unless Ctrl
    vk_home:
      if Ctrl then
        SendToParent;
    vk_end:
      if Ctrl then
        SendToParent;
    vk_f2:
      begin
        ParentEvent;
        if Key = vk_f2 then
        begin
          Deselect;
          exit;
        end;
      end;
    vk_tab:
      if not(ssAlt in Shift) then
        SendToParent;
  end;
  if (Key = VK_DELETE) and not ParentGrid.CanEditModify then
    Key := 0;
  if Key <> 0 then
  begin
    ParentEvent;
    if isMasked then
      inherited KeyDown(Key, Shift)
    else if Assigned(OnKeyDown) then
      OnKeyDown(self, Key, Shift);
  end;
end;

procedure TwwDataInspectorEdit.BoundsChanged;
var
  R: TRect;
begin
  { Inplaceeditor is one pixel too tall and wide, so shrink it }
  SetWindowPos(Handle, HWND_TOP, Left + 1, Top, Width - 2, Height - 1,
    SWP_SHOWWINDOW or SWP_NOREDRAW);

  R := Rect(1, 1, Width - 2, Height);
  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TwwDataInspectorEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (ovEnterToTab in ParentGrid.Options) and (Key = VK_RETURN) then
    Key := 9;
  inherited KeyUp(Key, Shift);
  if (Key = VK_DELETE) then
  begin
    if Assigned(ParentGrid.FOnCheckValue) then
      IsValidPictureValue(Text);
  end
end;

procedure TwwDataInspectorEdit.KeyPress(var Key: Char);
var
  pict: TwwPictureValidator;
  s: string;
  res: TwwPicResult;
  padlength, OldSelStart, Oldlen, OldSelLen: Integer;
  DisplayTextIsInvalid, skipInvalidValueTest: boolean;
  valid: boolean;

  Function NewText(Key: Char): string;
  var
    curStr: string;
  begin
    curStr := Text;
    if (ord(Key) = vk_back) then
    begin
      if (length(curStr) >= 1) then
        delete(curStr, selStart, 1);
      result := curStr;
    end
    else
      result := copy(curStr, 1, selStart + 1 - 1) + Char(Key) +
        copy(curStr, selStart + 1 + length(SelText), 32767);
  end;

begin
  if (ovEnterToTab in ParentGrid.Options) and (ord(Key) = VK_RETURN) then
    Key := #9;
  inherited KeyPress(Key);

  valid := true;
  DisplayTextIsInvalid := false;
  skipInvalidValueTest := false;

  if (RegexMask.Mask <> '') then
  begin
    s := NewText(Key);
    if (Maxlength > 0) and (length(s) > Maxlength) and (length(s) > length(Text))
    then
      exit; { Limit to maxlength }
    valid := RegexMatch(RegexMask.Mask, not RegexMask.CaseSensitive, s);
    // EnableEdit; // Otherwise readonly can still be true
    DisplayTextIsInvalid := not valid;

  end;

  if valid and HavePictureMask then
  begin
    if (ord(Key) = vk_back) then
    begin
      if Assigned(ParentGrid.FOnCheckValue) then
        IsValidPictureValue(NewText(Key));
      exit;
    end;
    if (ord(Key) < VK_SPACE) then
      exit;

    s := NewText(Key);
    if (Maxlength > 0) and (length(s) > Maxlength) and (length(s) > length(Text))
    then
      exit; { Limit to maxlength }

    pict := TwwPictureValidator.Create(FwwPicture.PictureMask,
      FwwPicture.AutoFill);
    res := pict.Picture(s, FwwPicture.AutoFill);

    OldSelStart := selStart;
    Oldlen := length(Text);
    OldSelLen := SelLength;

    // 6/2/06 - Support Autofilling of prefix
    if FwwPicture.AutoFill { and (not Patch[0]) } then
    begin { AutoFill prefix }
      if (res = prError) then
      begin
        s := NewText(' ');
        res := pict.Picture(s, FwwPicture.AutoFill);
        if res <> prError then
        begin
          s := s + Char(Key);
          res := pict.Picture(s, FwwPicture.AutoFill);
        end;
      end
    end;

    case res of
      prError:
        begin
          { If at end of list }
          if (selStart + length(SelText) >= length(Text)) then
          begin
            Key := Char(0);
            MessageBeep(0);
            skipInvalidValueTest := true; { 2/4/98 - Rely upon previous call }
          end
          else
            DisplayTextIsInvalid := true;
        end;

      prIncomplete:
        begin
          padlength := length(s) - length(Text);
          Text := s;
          (Owner as TwwDataInspector).FEditText := Text;
          if (OldSelLen = Oldlen) then
            selStart := length(s)
          else
            selStart := OldSelStart + padlength;
          Key := Char(0);
          DisplayTextIsInvalid := true;
          if ParentGrid.DataSource = nil then
            Modified := true;
          { 3/29/03 - Allow FlushContents to do modified test for picture masks }
        end;

      prComplete:
        begin
          { 11/21/96 - Workaround for Delphi 2 bug in scrolling in unbordered control }
          Text := s;
          (Owner as TwwDataInspector).FEditText := s;
          if (OldSelLen = Oldlen) then
            selStart := length(s)
          else if (length(s) > Oldlen) then
            selStart := OldSelStart + (length(s) - Oldlen)
            { Move caret to the right }
          else
            selStart := OldSelStart + 1; { 11/26/96 }
          SelLength := 0; { 8/12/97 }
          Key := Char(0);
          Modified := true;
          { 11/3/99 - Allow inspector item change event to fire }
        end;

    end;
    pict.Free;

    // if (not skipInvalidValueTest) and Assigned(ParentGrid.FOnCheckValue) then
    // ParentGrid.FOnCheckValue(self, not DisplayTextIsInvalid);

  end;

  if HavePictureMask or (RegexMask.Mask <> '') then
  begin
    if (not skipInvalidValueTest) then
    begin
      DoRefreshValidationDisplay(not DisplayTextIsInvalid);
    end
  end;

end;

{ Allow paste to change text - 10/29/96 }
procedure TwwDataInspectorEdit.WMPaste(var Message: TMessage);
begin
  inherited;
  if not ParentGrid.CanEditModify then
    exit;
end;

procedure TwwDataInspectorEdit.SetWordWrap(val: boolean);
begin
  FWordWrap := val;
  RecreateWnd;
end;

procedure TwwDataInspectorEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not(ES_AUTOVSCROLL or ES_WANTRETURN);
  if (BorderStyle = bsNone) or WordWrap then
    Params.Style := Params.Style or ES_MULTILINE;
  if WordWrap then
    Params.Style := (Params.Style or ES_AUTOVSCROLL) and not ES_AUTOHSCROLL;
end;

function TwwDataInspectorEdit.IsValidPictureValue(s: string): boolean;
var
  pict: TwwPictureValidator;
  res: TwwPicResult;
begin
  if s = '' then
    result := true
  else if not HavePictureMask then
    result := true
  else
  begin
    pict := TwwPictureValidator.Create(FwwPicture.PictureMask,
      FwwPicture.AutoFill);;
    res := pict.Picture(s, false);
    result := res = prComplete;
    pict.Free;
  end;
  if Assigned(ParentGrid.FOnCheckValue) then
    ParentGrid.FOnCheckValue(self, result);
end;

procedure TwwDataInspectorEdit.UpdateContents;
var
  obj: TwwInspectorItem;
  ARect: TRect;
begin
  inherited;
  obj := ParentGrid.GetItemByRow(ParentGrid.Row);
  if obj = nil then
    exit; // 4/25/2000 PYW Make sure Obj is not nil.  This can happen when reassigning the datasource.
  ReadOnly := obj.ReadOnly;
  ARect := ParentGrid.CellRect(ParentGrid.Row, 1);
  FWordWrap := (obj.WordWrap) or (obj.Field is TBlobField) { and
    (not wwIsSingleLineEdit(ParentGrid.Canvas.Handle, ARect, 0)) };
  Enabled := obj.Enabled; // 8/21/02

  ParentGrid.SkipSetFocus := true;
  Try
    RecreateWnd;
  finally
    ParentGrid.SkipSetFocus := false;
    SetFocus;
  end;

end;

procedure TwwDataInspectorEdit.WMSetFocus(var Message: TWMSetFocus);
var
  tempMask: string;
  tempAutoFill: boolean;
  obj: TwwInspectorItem;
begin
  // 7/21/01 - Fix invisible combo bug
  with ParentGrid do
    if InplaceEditor <> nil then
      TEdit(InplaceEditor).Font := Font;

  inherited;
  with ParentGrid do
  begin
    obj := GetItemByRow(Row);

    if ParentGrid.PictureMaskFromDataSet and (obj.Field <> nil) then
    begin
      if (ParentGrid.DataSource = nil) or (ParentGrid.DataSource.Dataset = nil)
      then
        exit;
      wwPictureByField(DataSource.Dataset, obj.Field.FieldName, true, tempMask,
        tempAutoFill, FUsePictureMask);
      FwwPicture.PictureMask := tempMask;
      FwwPicture.AutoFill := tempAutoFill;
      FwwPicture.AllowInvalidExit := false;
      IsValidPictureValue(obj.Field.Text)
    end
    else
      TwwDataInspectorEdit(InplaceEditor).Picture.Assign(obj.Picture);

    TwwDataInspectorEdit(InplaceEditor).RegexMask.Assign(obj.RegexMask);
  end;

end;

Function TwwDataInspectorEdit.HavePictureMask: boolean;
begin
  result :=
  // FUsePictureMask and
    (FwwPicture.PictureMask <> '')
end;

procedure TwwDataInspectorEdit.CMFontChanged(var Message: TMessage);
var
  Loc: TRect;
begin
  inherited;
  Loc.Bottom := ClientHeight;
  Loc.right := ClientWidth - 1;
  if BorderStyle = bsNone then
  begin
    Loc.Top := 2;
    Loc.Left := 2;
  end
  else
  begin
    Loc.Top := 0;
    Loc.Left := 0;
  end;
  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@Loc));
  { Use 2 pixel border on top and left }
end;

procedure TwwDataInspector.ValidationErrorUsingMask(Item: TwwInspectorItem);
var
  Msg: string;
  DoDefault: boolean;
begin
  Msg := Format(SMaskEditErr, ['']);
  DoDefault := true;
  if Assigned(FOnValidationErrorUsingMask) then
    FOnValidationErrorUsingMask(self, Item, Msg, DoDefault);
  if DoDefault then
  begin
    MessageBeep(0);
    raise EInvalidOperation.Create(Msg);
  end
end;

procedure TwwDataInspector.UpdateData;
var
  NewDate, NewTime: TDateTime;
  obj: TwwInspectorItem;
  editor: TwwDataInspectorEdit;
  FloatValue: Extended;
begin
  if UseCheckbox(Row) then
    exit; // 12/17/00 - RSW - Already updated when toggling checkbox
  obj := GetItemByRow(Row);

  if (InplaceEditor <> nil) then
  begin
    editor := TwwDataInspectorEdit(InplaceEditor);
    if (editor.HavePictureMask) and (FDataLink as TwwDataInspectorDataLink)
      .isFieldModified and (not editor.IsValidPictureValue(editor.Text)) and
      (not editor.Picture.AllowInvalidExit) then
    begin
      ValidationErrorUsingMask(obj);
      exit;
    end
  end;

  if (obj.Field <> nil) and (obj.DataSource <> nil) and
    (obj.DataSource.State in [dsEdit, dsInsert]) then
  begin // 3/31/03 - fix problem where cancel from navigator after expand button opened with navigator
    { Handle 2 digit year logic }
    TextIsSame := (obj.Field.Text = FEditText);

    if (obj.Field is TBlobField) and
      (obj.Field.datatype in [ftMemo, ftOraBlob, ftOraCLob
{$IFDEF wwDelphi2006Up}
      , ftWideMemo
{$ENDIF}
      ]) then
    begin
      obj.Field.asString := FEditText;
    end
    else if (obj.Field is TDateTimeField) and wwStrToDate(FEditText) then
    begin
      { Uses 1950 as Epoch Date for 2 digt years }
      if wwScanDate(FEditText, NewDate)
      then { 10/12/98 - Avoid converting 4 digit years }
      begin
        NewTime := Frac(StrToDateTime(FEditText));
        TDateTimeField(obj.Field).asDateTime := NewDate + NewTime;
      end;
    end
    else if ((obj.Field is TIntegerField) or (obj.Field is TFloatField)) and
      (FEditText <> '') and
    // 8/15/02 - Allow clearing of field (If text is blank then don't do formatting code)
      (TNumericField(obj.Field).DisplayFormat <> '') then
    begin
      if wwStrToFloat2(FEditText, FloatValue, TNumericField(obj.Field)
        .DisplayFormat) then
      begin
        if obj.Field is TFloatField then
          obj.Field.asFloat := FloatValue
        else if obj.Field is TIntegerField then
        begin
          obj.Field.asInteger := Round(FloatValue)
        end
      end
      else
        obj.Field.Text := FEditText;
    end
    else
      obj.Field.Text := FEditText;

    if not TextIsSame then
      FieldChanged(obj.Field);
  end
end;

procedure TwwDataInspector.FieldChanged(Field: TField);
var
  i: Integer;
  obj: TwwInspectorItem;
begin
  DoFieldChanged(Field);
  for i := TopRow to TopRow + VisibleRowCount - 1 do
  begin
    obj := GetItemByRow(i);
    if (obj <> nil) and (Field <> nil) and (obj.Field = Field) then
      InvalidateRow(i);
  end;
end;

procedure TwwDataInspector.DoItemChanged(Item: TwwInspectorItem;
  NewValue: string);
begin
  if Assigned(FOnItemChanged) then
    FOnItemChanged(self, Item, NewValue);
end;

procedure TwwDataInspector.DoFieldChanged(Field: TField);
begin
  if Assigned(FOnFieldChanged) then
    FOnFieldChanged(self, Field);
end;

procedure TwwDataInspector.RecordChanged(Field: TField);
var
  R: TRect;
  obj: TwwInspectorItem;
  OldSelStart, OldSelLength: Integer;
  SameText: boolean;
begin
  if not handleAllocated then
    exit;

  obj := GetItemByRow(Row);

  R := CellRect(1, Row);
  InvalidateRect(Handle, @R, false);
  if obj = nil then
    exit; // 9/16/03 - in case no items visible

  SameText := (obj.Field <> nil) and (obj.Field.Text = FEditText);
  if SameText and (InplaceEditor <> nil) and InplaceEditor.handleAllocated then
  begin
    OldSelStart := InplaceEditor.selStart;
    OldSelLength := InplaceEditor.SelLength;
  end
  else
  begin // make compiler happy
    OldSelStart := 0;
    OldSelLength := 0;
  end;

  // ? Calling InvalidateEditor would cause the text to all get selected when going into edit mode
  // 8/21/01 - Uncomment code so tfield assignments change active editor.  At this point
  // the below code was commented but the problem described above does not occur
  // in testing.
  if ((Field = nil) or ((obj.Field <> nil) and (obj.Field = Field)) and
    (obj.Field.Text <> FEditText)) then
  begin
    InvalidateEditor;
    { This code would cause the text to go to the end of instead of replacing the highlighted text }
    { Perhaps should make this a property instead to enable this behavior }
    if SameText and (InplaceEditor <> nil) and InplaceEditor.handleAllocated
    then
    begin
      InplaceEditor.selStart := OldSelStart;
      InplaceEditor.SelLength := OldSelLength;
    end;
    // if (not AllSelected) and (InplaceEditor <> nil) then InplaceEditor.Deselect;
  end;

end;

procedure TwwDataInspector.DataChanged;
begin
  if not handleAllocated then
    exit;

  // Adjust ColCount for inserting new record
  if (DataColumns > 1) and (FDataLink.RecordCount <> ColCount - 1) and
    (FDataLink.RecordCount > 0) then
  begin
    // ColCount:= wwmin(FDataLink.RecordCount+1, DataColumns+1);
    ColCount := DataColumns + 1;
    UpdateDataColumnWidth;
  end;

  if FDataLink.Active and FFocused then
  // 4/11/2002 - Verify control is focused if calling setfocuscell
  begin
    if NewMouseRow >= 0 then
      SetFocusCell(FDataLink.ActiveRecord + 1, NewMouseRow)
    else
      SetFocusCell(FDataLink.ActiveRecord + 1, Row);
  end;

  UpdateScrollBar;
  UpdateActive; // 7/23/02

  if ActiveItem <> nil then
    if (ActiveItem.DataSource = DataSource) or ChildDataChanged then
      InvalidateEditor;

  ValidateRect(Handle, nil);
  Invalidate;

end;

// 7/23/02 - New method to reposition column based on active record
// For instance, if dataset is opened, or locate is called on dataset
procedure TwwDataInspector.UpdateActive;
begin
  // 8/28/02 - Index out of range when setting table to active before
  if (DataSource = nil) or (DataSource.Dataset = nil) or
    (not DataSource.Dataset.Active) then
    exit;

  // 5/19/03 - Fix bug which causes caption column to be hidden in certain cases
  if (ColCount = 2) and (ColWidths[0] + ColWidths[1] > ClientWidth) then
    UpdateDataColumnWidth;

  // 8/28/02 - HideCaptionCol irrelevant to column as caption column is really always there
  if FDataLink.ActiveRecord + 1 <= ColCount - 1 then
    Col := FDataLink.ActiveRecord + 1
end;

function TwwDataInspector.GetField(ARow: Integer): TField;
var
  obj: TwwInspectorItem;
begin
  obj := GetItemByRow(Row); { 4/26/00 - Check for nil obj }
  if obj = nil then
    result := nil
  else
    result := obj.Field;
end;

function TwwDataInspector.CanEditModify: boolean;
var
  obj: TwwInspectorItem;
  DoEdit: boolean;
begin
  result := false;
  obj := GetItemByRow(Row);

  if FDataLink.Dataset = nil then
  // if obj.DataLink.DataSet=nil then
  begin
    result := (not ReadOnly) and (not obj.ReadOnly) and (RowCount > 0);
    exit;
  end;

  { Don't allow insert/edit if no records and ovallowinsert is false }
  if (DataSource <> nil) and (DataSource.Dataset <> nil) and
    DataSource.Dataset.Bof and DataSource.Dataset.Eof and
    (DataSource.State = dsBrowse) and not(ovAllowInsert in Options) then
  begin
    exit;
  end;

  DoEdit := not ReadOnly and FDataLink.Active and not FDataLink.ReadOnly and
    (RowCount > 0) and (not obj.ReadOnly);

  if obj.Field <> nil then
  begin
    DoEdit := DoEdit and ((obj.Field.CanModify) or (not obj.Field.ReadOnly));
  end;

  if DoEdit then
  begin
    { FDatalink.Edit;
      Result := FDatalink.Editing;
      if Result then TwwDataInspectorDataLink(FDatalink).Modified;
    }
    if FDataLink <> obj.DataLink
    then { Related table need to go into edit mode }
    begin
      obj.DataLink.Edit;
      result := obj.DataLink.Editing;
      if result then
        TFieldDataLink(obj.DataLink).Modified;
      if result then
        TwwDataInspectorDataLink(FDataLink).Modified;
    end
    else
    begin
      FDataLink.Edit;
      result := FDataLink.Editing;
      if result then
        TwwDataInspectorDataLink(FDataLink).Modified;
    end;

  end;
end;

procedure TwwDataInspector.WMVScroll(var Message: TWMVScroll);
var
  PrevTopRow: Integer;
begin
  PrevTopRow := TopRow;
  BeginUpdate;

  case Message.ScrollCode of
    SB_THUMBTRACK:
      begin
        InTracking := true;
        TabStop := false;
      end;

    SB_ENDSCROLL:
      begin
        if InTracking then
        begin
          inherited;
          TabStop := true;
          InTracking := false;
          EndUpdate;
          InvalidateRow(Row); { otherwise caret does not seem to show }
          exit;
        end;
      end;

  end;

  { if csDesigning in ComponentState then
    begin
    SpecialHide:= False;
    end;
  }
  TabStop := false;
  inherited;
  TabStop := true;

  EndUpdate;
  if PrevTopRow <> TopRow then
  begin
    if UseDefaultEditor then
      ShowEditor
    else
      HideEditor;
    Invalidate;
    Update; { So that if scrollbar is dragged quickly causing multiple scrolling
      operations, the control does not omit painting any area.  This can
      happen since wm_setreddraw loses the area that is not valid.
      Alternatively, we could save the cliprect and restore it. }
  end

end;

function TwwDataInspector.GetEditMask(ACol, ARow: Longint): string;
var
  Field: TField;
begin
  result := '';
  if FDataLink.Active then
    Field := GetField(ARow)
  else
    Field := nil;
  if Assigned(Field) then
    result := Field.EditMask;
  if Assigned(FOnGetEditMask) then
    FOnGetEditMask(self, ACol, ARow, result);
end;

Procedure TwwDataInspector.LinkActiveCallback(Item: TwwInspectorItem;
  UserData: Pointer; var AContinue: boolean);
begin
  if Item.CustomControl <> nil then
  begin
    Item.CustomControl.Visible := false;
    wwSetControlDataField(Item.CustomControl, '');
  end
end;

procedure TwwDataInspector.LinkActive(Value: boolean);
begin
  if (DefaultDateTimePicker <> Nil) then
  begin
    wwSetControlDataField(FDateTimePicker, ''); { 8/5/98 }
  end;
  if (FCombo <> Nil) then
  begin
    wwSetControlDataField(FCombo, ''); { 8/5/98 }
  end;
  if not Value then
    HideEditor;

  if (csDestroying in ComponentState) then
    exit;

  IterateItems(LinkActiveCallback, false, nil);
  CurrentCustomEdit := nil;

  if InplaceEditor <> nil then
    TwwDataInspectorEdit(InplaceEditor).UpdateContents;
  ApplySettings;
  UpdateActive; // 7/23/02
  UpdateScrollBar;

end;

procedure TwwDataInspector.DoCreateDefaultCombo(ACombo: TwwDBComboBox);
begin
  if Assigned(FOnCreateDefaultCombo) then
    FOnCreateDefaultCombo(self, FCombo);
end;

procedure TwwDataInspector.DoCreateDateTimePicker(ADateTimePicker
  : TwwDBCustomDateTimePicker);
begin
  if Assigned(FOnCreateDateTimePicker) then
    FOnCreateDateTimePicker(self, FDateTimePicker);
end;

function TwwDataInspector.CreateDateTimePicker: TwwDBCustomDateTimePicker;
begin
  result := TwwDBDateTimePicker.Create(self);
end;

function TwwDataInspector.CreateDefaultCombo: TwwDBComboBox;
begin
  result := TwwInspectorComboBox.Create(self);
end;

function TwwDataInspector.GetDateTimePicker: TwwDBCustomDateTimePicker;
begin
  if FDateTimePicker = nil then
  begin
    FDateTimePicker := CreateDateTimePicker;
    DoCreateDateTimePicker(FDateTimePicker);
  end;
  result := FDateTimePicker;
end;

procedure TwwDataInspector.WMSize(var Message: TWMSize);
var
  NewBoundsRect: TRect;
begin
  inherited;
  UpdateDataColumnWidth;

  NewBoundsRect := Rect(0, 0, BoundsRect.right - BoundsRect.Left,
    BoundsRect.Bottom - BoundsRect.Top);
  if sameRect(OldBoundsRect, NewBoundsRect) then
    exit;
  OldBoundsRect := NewBoundsRect;
  PaintOptions.InitBlendBitmapsFlag := true;

  // if not SameRect(ClientRect, OldClientRect) then
  // InitBlendBitmaps;
  // OldClientRect:= ClientRect;
end;

procedure TwwDataInspector.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;

  procedure ClearCustomControl(Item: TwwInspectorItem);
  var
    i: Integer;
  begin
    if Item.CustomControl = AComponent then
      Item.CustomControl := nil;
    for i := 0 to Item.Items.Count - 1 do
      ClearCustomControl(Item.Items[i]);
  end;

begin
  inherited Notification(AComponent, Operation);
  if csDestroying in ComponentState then
    exit;
  if (Operation = opRemove) then
  begin
    for i := 0 to Items.Count - 1 do
      ClearCustomControl(Items[i]);
  end
end;

procedure TwwDataInspector.SetDesigner(Value: TControl);
begin
  FDesigner := Value;
end;

procedure TwwDataInspector.SetCaptionIndent(val: Integer);
begin
  if FCaptionIndent <> val then
  begin
    FCaptionIndent := val;
    Invalidate;
  end;
end;

procedure TwwDataInspector.WMKillFocus(var Message: TMessage);
begin
  inherited;
end;

procedure TwwDataInspector.WMSetFocus(var Msg: TWMSetFocus);
var
  obj: TwwInspectorItem;
  canShow: boolean;
begin
  // if (Col=0) and (ColCount>1) then Col:= 1;
  inherited;
  if SkipSetFocus then
    exit; // 6/13/01 - Don't move focus to inplaceeditor during its recreatewnd

  if not UseDefaultEditor then
  begin
    SkipUpdateEditText := true;
    // 6/13/02 - Just Receiving focus, so updating obj.EditText is not correct
    HideEditor;
    SkipUpdateEditText := false;
  end
  else
  begin
    ShowEditor;
    InplaceEditor.SelectAll;
  end;

  if (not SkipUpdateCustomControlInFocus) and (CurrentCustomEdit = nil) then
  begin
    UpdateCustomEdit;

    // 6/13/02 - Make sure custom edit is updated when inspector receives focus
    obj := ActiveItem;

    // Don't show custom control if canshow is false
    CanShow:=true;
    DoOnCanShowCustomControl(ActiveItem, canShow);
    if not canShow then
    begin
      CurrentCustomEdit.visible:=false;
      CurrentCustomEdit:=nil;
    end;


    if (CurrentCustomEdit <> nil) and (obj <> nil) and
      ((obj.DataField = '') or (obj.DataSource = nil)) then
    begin
      if (CurrentCustomEdit.handleAllocated) and
        (CurrentCustomEdit is TCustomEdit) then
      begin
        // 10/22/02 - Maplist not initialized correctly unless we use obj.displaytext
        if obj.UseDefaultComboBox and obj.PickList.MapList then
          TEdit(CurrentCustomEdit).Text := obj.DisplayText
        else
          TEdit(CurrentCustomEdit).Text := obj.EditText;
      end
    end;

    if CurrentCustomEdit <> nil then
    begin
      CurrentCustomEdit.Visible := true;
      UpdateCustomEditPaint(CurrentCustomEdit);
      // CurrentCustomEdit.Update;
      CurrentCustomEditSetfocus;
    end
  end;

  // if KeyHook=0 then
  // KeyHook := SetWindowsHookEx(WH_KEYBOARD, @wwHookKeyProc, HINSTANCE, GetCurrentThreadID);

  // invalidate; { Takes care of problem of notepad in front }
end;

procedure TwwDataInspector.Click;
// var obj: TwwInspectorItem;
begin
  inherited;

  { 11/2/99 - Editor is being shown but it shouldn't be, so hide it }
  if (not UseDefaultEditor) and
    ((InplaceEditor <> nil) and InplaceEditor.Focused) then
    HideEditor;

  { obj:= GetItemByRow(Row);
    if obj=nil then exit;
    if InplaceEditor=nil then exit; }
end;

procedure TwwDataInspector.IterateItems(CallBack: TwwInspectorItemCallback;
  ExpandedOnly: boolean; UserData: Pointer);
var
  i: Integer;
  continue: boolean;
  procedure Scan(Item: TwwInspectorItem);
  var
    i: Integer;
  begin
    CallBack(Item, UserData, continue);
    if not continue then
      exit;

    if not ExpandedOnly or (Item.Expanded and Item.Visible) then
    begin
      for i := 0 to Item.Items.Count - 1 do
        Scan(Item.Items[i]);
    end;
  end;

begin
  continue := true;
  for i := 0 to Items.Count - 1 do
  begin
    Scan(Items[i]);
    if not continue then
      exit;
  end
end;

{
  procedure TwwInspectorPaintOptions.SetAlternateRowCaptionColors(Value: Boolean);
  begin
  if Value<>AlternateRowCaptionColors then
  begin
  FAlternateRowCaptionColors:= Value;
  Inspector.InitBlendBitmapsFlag:=True;
  Inspector.Invalidate;
  end
  end;

  procedure TwwInspectorPaintOptions.SetAlternateRowDataColors(Value: Boolean);
  begin
  if Value<>AlternateRowDataColors then
  begin
  FAlternateRowDataColors:= Value;
  Inspector.InitBlendBitmapsFlag:=True;
  Inspector.Invalidate;
  end
  end;
}
procedure TwwDataInspector.SetOptions(Value: TwwDataInspectorOptions);
const
  LayoutOptions = [ { ovWordWrap, } ovHighlightActiveRow, ovCenterCaptionVert,
    ovShowTreeLines, ovHideCaptionColumn];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TwwDataInspectorOptions;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [goEditing, goAlwaysShowEditor, goThumbTracking];
    if ovRowResize in Value then
      NewGridOptions := NewGridOptions + [goRowSizing];
    if ovColumnResize in Value then
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
    if not(ovTabExits in Value) then
      Include(NewGridOptions, goTabs);
    inherited Options := NewGridOptions;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    { if (ovWordWrap in Value) <> (ovWordWrap in FOptions) then
      begin
      if (InplaceEditor<>Nil) then
      (InplaceEditor as TwwDataInspectorEdit).WordWrap:= (ovWordWrap in Value);
      end; }
    FOptions := Value;
    if ovHideCaptionColumn in LayoutOptions then
    begin
      if (ovHideCaptionColumn in FOptions) and (ColCount = 2) then
        ColWidths[0] := 0
      else
        ColWidths[0] := CaptionWidth;
      if handleAllocated then
        UpdateDataColumnWidth;
    end;
    if ChangedOptions * LayoutOptions <> [] then
      Invalidate; // LayoutChanged;
  end;

end;

procedure TwwDataInspector.RowHeightsChanged;
begin
  inherited;
  if LastDefaultRowHeight <> inherited DefaultRowHeight then
  begin
    ApplySettings;
  end;
  LastDefaultRowHeight := inherited DefaultRowHeight;
end;

procedure TwwDataInspector.SetDefaultRowHeight(Value: Integer);
begin
  FDefaultRowHeight := Value;
  if FDefaultRowHeight = 0 then
  begin
    ApplySettings;
  end
  else
  begin
    inherited DefaultRowHeight := DefaultRowHeight;
  end
end;

procedure TwwDataInspector.SetCaptionFont(Value: TFont);
begin
  FCaptionFont.Assign(Value);
  Invalidate;
end;

procedure TwwDataInspector.CaptionFontChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TwwDataInspector.InvalidateRow(ARow: Integer);
begin
  InvalidateRowCol(ARow, -1);
end;

procedure TwwDataInspector.InvalidateRowCol(ARow: Integer; ACol: Integer = -1);
var
  InvalidRect: TRect;
begin
  if not handleAllocated then
    exit;
  if ACol = -1 then
  begin
    InvalidRect := BoxRect(0, ARow, ColCount, ARow);
    InvalidRect.Top := InvalidRect.Top - 2;
    InvalidRect.Bottom := InvalidRect.Bottom + 1;
    InvalidRect.Left := InvalidRect.Left - 1;
    InvalidRect.right := ClientWidth;
    // Not accurate when ColWidths[0] is 0 so let us overwrite value
    Windows.InvalidateRect(Handle, @InvalidRect, false);
  end
  else
  begin
    InvalidRect := BoxRect(ACol, ARow, ACol + 1, ARow);
    InvalidRect.Top := InvalidRect.Top - 2;
    InvalidRect.Bottom := InvalidRect.Bottom + 1;
    InvalidRect.Left := InvalidRect.Left - 1;
    Windows.InvalidateRect(Handle, @InvalidRect, false);
  end;
end;

procedure TwwDataInspectorEdit.WMPaint(var Message: TWMPaint);
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := self;
    end;
  end;

begin
  if csPaintCopy in ControlState then
  begin
    message.result := 1;
    exit;
    // DrawCell(Col, Row);
    { CanvasNeeded;
      DC := Message.DC;
      if IsInGridPaint(self.parent) and (message.dc<>0) then
      tc:= GetTextColor(message.dc);
      if DC = 0 then DC := BeginPaint(Handle, PS);
      FCanvas.Handle := DC;
      try
      Focused := GetFocus = Handle;
      FCanvas.Font := Font;
      with FCanvas do
      begin
      ARect := ClientRect;
      else if IsInGridPaint(self) and (message.dc<>0) then

      //      inherited;
      //      message.result:=1;
    }
  end
  else
    inherited;
end;

procedure TwwDataInspectorEdit.CMExit(var Message: TMessage);
begin
  { try
    ParentGrid.FDataLink.UpdateData;
    except
    SetFocus;
    raise;
    end;
  }
  inherited;
  // ParentGrid.invalidateRow(ParentGrid.Row);
end;

procedure TwwDataInspector.FlushContents;
var
  obj: TwwInspectorItem;
  ie: TwwDataInspectorEdit;
begin
  obj := GetItemByRow(Row);
  if obj <> nil then
  begin
    if CurrentCustomEdit <> nil then
    begin
      if CurrentCustomEdit is TwwDBComboBox then
        obj.EditText := TwwDBComboBox(CurrentCustomEdit).Value
      else
        obj.EditText := TEdit(CurrentCustomEdit).Text;

      if TEdit(CurrentCustomEdit).Modified then
        obj.DoItemTextChanged;
    end
    else
    begin
      if (InplaceEditor <> nil) and InplaceEditor.Modified then
      begin
        ie := TwwDataInspectorEdit(InplaceEditor);

        if (DataSource = nil) and (ie <> nil) and ie.HavePictureMask then
        begin
          if (not ie.IsValidPictureValue(ie.Text)) and
          // 3/29/03 - Fix unbound case with picture mask
            (not ie.Picture.AllowInvalidExit) then
          begin
            MessageBeep(0);
            SysUtils.Abort;
          end
        end;

        { 10/25/07 - Make sure obj.edittext is updated to inplaceeditor's value }
        { This is only necessary because when a picture mask is assigned, the obj.edittext
          is not updated for some reason }
        if InplaceEditor.Text <> obj.EditText then
          obj.EditText := InplaceEditor.Text;

        obj.DoItemTextChanged;
        InplaceEditor.Modified := false; { 3/11/00 - Clear modified }
      end
    end;
  end;
  FDataLink.UpdateData;
end;

procedure TwwDataInspector.CMExit(var Message: TMessage);
// var obj: TwwInspectorItem;
begin
  if KeyHook <> 0 then
  begin
    UnhookWindowsHookEx(KeyHook);
    KeyHook := 0;
  end;

  try
    FlushContents;
  except
    SetFocus;
    raise;
  end;

  inherited;

  FFocused := false;
  InvalidateRow(Row);
end;

function TwwDataInspector.InValidColSizingArea(x: Integer): boolean;
begin
  result := (x <= ColWidths[0] + 3);
end;

procedure TwwDataInspector.WMSetCursor(var Msg: TWMSetCursor);
var
  DrawInfo: TGridDrawInfo;
  State: TGridState;
  Index: Longint;
  Pos, Ofs: Integer;
  // Cur: HCURSOR;
begin
  // Cur := 0;
  with Msg do
  begin
    if HitTest = HTCLIENT then
    begin
      if FGridState = gsNormal then
      begin
        CalcDrawInfo(DrawInfo);
        CalcSizingState(self.HitTest.x, self.HitTest.Y, State, Index, Pos, Ofs,
          DrawInfo);
      end
      else
        State := FGridState;

      if State = gsColSizing then
      begin
        if not InValidColSizingArea(self.HitTest.x) then
        begin
          exit;
        end
      end
    end;
  end;
  inherited;

end;

procedure TwwDataInspectorEdit.WMEraseBkgnd(var Message: TWmEraseBkgnd);
// var r: TRect;
begin
  if csPaintCopy in ControlState then
  begin
    Message.result := 1;
  end
  // 8/1/02 - Theme - Otherwise lots of flicker when it gets the focus
  // 8/8/02 - Does not seem necessary anymore after latest beta build so
  // comment out awaiting further testing
  { else if false and StyleServices.ThemesEnabled then
    begin
    r:= ClientRect;
    if FCanvas<>nil then
    Windows.FillRect(message.dc, r, FCanvas.brush.handle );
    message.result:=1
    end }
  else
    inherited;
end;

procedure TwwDataInspector.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if true or SkipErase then
  begin
    Message.result := 1;
    exit;
  end
  else
    inherited;
end;

procedure TwwDataInspector.ToggleCheckbox(obj: TwwInspectorItem);
begin
  if not obj.Enabled then
    exit;

  if obj.Field <> nil then
  begin
    if not CanEditModify then
      exit;
    if obj.Field.Text = obj.PickList.Items[0] then
      obj.Field.Text := obj.PickList.Items[1]
    else
      obj.Field.Text := obj.PickList.Items[0];
    obj.EditText := obj.Field.Text;

  end
  else
  begin
    if ReadOnly or obj.ReadOnly then
      exit;

    if obj.EditText = obj.PickList.Items[0] then
      obj.EditText := obj.PickList.Items[1]
    else
      obj.EditText := obj.PickList.Items[0]
  end;

  obj.DoItemTextChanged;
  // if Assigned(obj.FItemChanged) then
  // obj.FItemChanged(self, obj, obj.EditText);
end;

procedure TwwDataInspector.WMChar(var Msg: TWMChar);
var
  obj: TwwInspectorItem;
begin
  if UseCheckbox(Row) then
  begin
    if (goEditing in inherited Options) and (Char(Msg.CharCode) = #32) then
    begin
      obj := GetItemByRow(Row);
      ToggleCheckbox(obj);
      invalidateCell(1, Row);
    end
  end;
  // inherited;
end;

procedure TwwDataInspector.WMPaint(var Message: TWMPaint);
begin
  // if csPaintCopy in ControlState then exit;
  Windows.GetUpdateRect(Handle, UpdateRect, false);

  PaintCopyTextColor := clNone;
  if IsInGridPaint(self) and (message.dc <> 0) then
  begin
    PaintCopyTextColor := GetTextColor(message.dc);
  end;

  inherited;
end;

procedure TwwDataInspector.SetLineStyleCaption(val: TwwDataInspectorLineStyle);
begin
  FLineStyleCaption := val;
  Invalidate;
end;

procedure TwwDataInspector.SetDottedLineColor(val: TColor);
begin
  FDottedLineColor := val;
  Invalidate;
end;

procedure TwwDataInspector.SetLineStyleData(val: TwwDataInspectorLineStyle);
begin
  FLineStyleData := val;
  Invalidate;
end;

{ TCustomGrid }
function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): boolean;
begin
  result := (Col >= Rect.Left) and (Col <= Rect.right) and (Row >= Rect.Top) and
    (Row <= Rect.Bottom);
end;

procedure TwwDataInspector.InheritedPaint;
type
  PIntArray = ^TIntArray;
  TIntArray = array [0 .. MaxCustomExtents] of Integer;
var
  DrawInfo: TGridDrawInfo;
  Sel: TGridRect;
  UpdateRect: TRect;
  FColOffset: Integer;

  procedure DrawCells(ACol, ARow: Longint;
    StartX, StartY, StopX, StopY: Integer; Color: TColor;
    IncludeDrawState: TGridDrawState);
  var
    CurCol, curRow: Longint;
    Where: TRect;
    DrawState: TGridDrawState;
    // Focused: Boolean;
  begin
    curRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (curRow < RowCount) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[curRow];
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
        Where.right := Where.Left + ColWidths[CurCol];
        if (Where.right > Where.Left) and RectVisible(Canvas.Handle, Where) then
        begin
          DrawState := IncludeDrawState;
          // Focused := IsActiveControl;
          if EffectiveFocused and (curRow = Row) { and (CurCol = Col) } then
            Include(DrawState, gdFocused);
          if PointInGridRect(CurCol, curRow, Sel) then
            Include(DrawState, gdSelected);
          if not((gdFocused in DrawState) and (CurCol = Col)) or
            not(goEditing in inherited Options) or not EditorMode or
            (csDesigning in ComponentState) or (csPaintCopy in ControlState)
          then
          begin
            DrawCell(CurCol, curRow, Where, DrawState);
          end;
        end;
        Where.Left := Where.right + DrawInfo.Horz.EffectiveLineWidth;
        inc(CurCol);
      end;
      Where.Top := Where.Bottom + DrawInfo.Vert.EffectiveLineWidth;
      inc(curRow);
    end;
  end;

begin
  if UseRightToLeftAlignment then
    ChangeOrientation(true);
  UpdateRect := Canvas.ClipRect;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    { Draw the cells in the four areas }
    Sel := Selection;

    FColOffset := 0;
    DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.FixedBoundary,
      IndicatorRow.Color, [gdFixed]);
    DrawCells(LeftCol, 0, Horz.FixedBoundary - FColOffset, 0, Horz.GridBoundary,
      // !! clip
      Vert.FixedBoundary, FixedColor, [gdFixed]);
    DrawCells(0, TopRow, 0, Vert.FixedBoundary, Horz.FixedBoundary,
      Vert.GridBoundary, FixedColor, [gdFixed]);
    DrawCells(LeftCol, TopRow, Horz.FixedBoundary - FColOffset, // !! clip
      Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary, Color, []);

  end;

  if UseRightToLeftAlignment then
    ChangeOrientation(false);
end;

function TwwDataInspector.IsActiveControl: boolean;
var
  H: HWND;
  ParentForm: TCustomForm;
begin
  result := false;
  ParentForm := GetParentForm(self);
  if Assigned(ParentForm) then
  begin
    if (ParentForm.activecontrol = self) then
      result := true
  end
  else
  begin
    H := GetFocus;
    while IsWindow(H) and (result = false) do
    begin
      if H = WindowHandle then
        result := true
      else
        H := GetParent(H);
    end;
  end;
end;

procedure TwwDataInspector.ChangeOrientation(RightToLeftOrientation: boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth, 0);
    Ext := Point(-1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.x, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.x * ClientWidth,
      Ext.Y * ClientHeight, nil);
  end
  else
  begin
    Org := Point(0, 0);
    Ext := Point(1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.x, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.x * ClientWidth,
      Ext.Y * ClientHeight, nil);
  end;
end;

procedure TwwDataInspector.BeginUpdate;
begin
  if not Showing then
    exit;
  if FUpdateCount = 0 then
    SetUpdateState(true);
  inc(FUpdateCount);
end;

procedure TwwDataInspector.SetUpdateState(Updating: boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, ord(not Updating), 0);
end;

procedure TwwDataInspector.EndUpdate(Repaint: boolean = false);
begin
  if not Showing then
    exit;
  if Repaint then
    InvalidateInEndUpdate := true;

  if FUpdateCount > 0 then
    Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    SetUpdateState(false);
    if InvalidateInEndUpdate then
      Invalidate;
    InvalidateInEndUpdate := false;
  end
end;

{ Function TwwDataInspector.ItemByFieldName(AFieldName: string): TwwInspectorItem;
  begin
  result:= nil;
  end;
}

procedure TwwInspectorButtonOptions.SetExpandGlyph(Value: TBitmap);
begin
  FExpandGlyph.Assign(Value);
  Control.Invalidate;
end;

procedure TwwInspectorButtonOptions.SetCollapseGlyph(Value: TBitmap);
begin
  FCollapseGlyph.Assign(Value);
  Control.Invalidate;
end;

constructor TwwInspectorButtonOptions.Create(AOwner: TComponent);
begin
  FExpandGlyph := TBitmap.Create;
  FCollapseGlyph := TBitmap.Create;
  Control := AOwner as TWinControl;
end;

destructor TwwInspectorButtonOptions.Destroy;
begin
  FExpandGlyph.Free;
  FCollapseGlyph.Free;
  inherited Destroy;
end;

procedure TwwDataInspector.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    { Remove horizontal scrollbar }
    if DataColumns <= 1 then
      if ScrollBars in [ssHorizontal, ssBoth] then
        Style := Style and not WS_HSCROLL;
  end;
end;

Procedure TwwDataInspector.SetActiveItem(obj: TwwInspectorItem);
var
  temprow: Integer;
  parentobj: TwwInspectorItem;
  SomethingExpanded: boolean;
begin
  FActiveItem := obj;

  if obj = nil then
    exit
  else
  begin
    { Need to expand parents if necessary }
    parentobj := obj.ParentItem;
    SomethingExpanded := false;
    while parentobj <> nil do
    begin
      // 8/1/00 - Otherwise shift-tab causes vertical scrollbar to disappear.
      if (not parentobj.Expanded) and (not SomethingExpanded) then
      begin
        BeginUpdate;
        SomethingExpanded := true;
      end;
      parentobj.Expanded := true;
      parentobj := parentobj.ParentItem;
    end;

    try
      temprow := GetRowByItem(obj);
      if temprow >= 0 then
      begin
        SetFocusCell(Col, temprow)
      end;
    finally // 11/12/03 - Make sure EndUpdate called in case of exception
      if SomethingExpanded then
        EndUpdate;
    end;
  end
end;

Function TwwDataInspector.GetActiveItem: TwwInspectorItem;
begin
  if FastDesign then
  begin
    result := FActiveItem;
    if result = nil then
      result := GetItemByRow(Row, false);
  end
  else
    result := GetItemByRow(Row, false);
end;

procedure TwwDataInspector.Loaded;
begin
  inherited;
  ApplySettings;
  UseTempCanvas := true;
  PaintOptions.InitBlendBitmaps;
  UseTempCanvas := false;
end;

function TwwDataInspector.GetCaptionColor: TColor;
begin
  result := FixedColor;
end;

procedure TwwDataInspector.SetCaptionColor(val: TColor);
begin
  FixedColor := val;
  PaintOptions.Column1Color := FixedColor;
  PaintOptions.InitBlendBitmapsFlag := true;
  Invalidate;
end;

function TwwDataInspector.GetTreeLineColor: TColor;
begin
  result := FTreeLineColor;
end;

procedure TwwDataInspector.SetTreeLineColor(val: TColor);
begin
  FTreeLineColor := val;
end;

constructor TwwInspectorPickList.Create;
begin
  inherited;
  FItems := TStringList.Create;
  FShowMatchText := true;
  FButtonStyle := cbsDownArrow;
  FButtonGlyph := TBitmap.Create;
end;

destructor TwwInspectorPickList.Destroy;
begin
  FItems.Free;
  FButtonGlyph.Free;
  inherited Destroy;
end;

procedure TwwInspectorPickList.SetItems(val: TStrings);
begin
  FItems.Assign(val);
end;

procedure TwwInspectorPickList.SetButtonGlyph(Value: TBitmap);
begin
  FButtonGlyph.Assign(Value);
end;

procedure TwwInspectorPickList.AssignTo(Dest: TPersistent);
begin
  with Dest as TwwInspectorPickList do
  begin
    Items.Assign(self.Items);
    MapList := self.MapList;
    DisplayAsCheckbox := self.DisplayAsCheckbox;
    Style := self.Style;
    ShowMatchText := self.ShowMatchText;
    AllowClearKey := self.AllowClearKey;
    ButtonStyle := self.ButtonStyle;
    ButtonGlyph.Assign(self.ButtonGlyph);
    ButtonWidth := self.ButtonWidth;
  end;
end;

function TwwInspectorItem.HaveItems: boolean;
begin
  result := FItems.Count > 0;
end;

type
  TwwInspectorFieldDataLink = class(TFieldDataLink)
  protected
    procedure DataSetChanged; override;
  public
    InspectorItem: TwwInspectorItem;
  end;

procedure TwwInspectorFieldDataLink.DataSetChanged;
begin
  inherited;

  { 2/10/2000 - Updates inplaceeditor for this row - Only do if this is the active item }
  if (InspectorItem.Control is TwwDataInspector) then
  begin
    if InspectorItem = (InspectorItem.Control as TwwDataInspector).ActiveItem
    then
    begin
      with (InspectorItem.Control as TwwDataInspector) do
      begin
        ChildDataChanged := true;
        DataLink.DataSetChanged;
        ChildDataChanged := false;
      end
    end
  end

end;

constructor TwwInspectorItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FEnabled := true;
  FAlignment := taLeftJustify;
  FWordWrap := false; { 12/11/99 - Default of true was wrong }
  FCustomControlAlwaysPaints := true;
  FItems := TwwInspectorCollection.Create
    (TwwInspectorCollection(Collection).Control);
  FItems.FParentItem := self;
  FParentItem := TwwInspectorCollection(Collection).ParentItem;
  FPickList := TwwInspectorPickList.Create;
  FPicture := TwwDBPicture.Create(nil);
  FRegexMask := TwwRegexMask.Create(TwwInspectorCollection(Collection).Control);

  FVisible := true;
  FResizeable := false;
  FOptions := [iioAutoDateTimePicker];
  FTabStop := true;

  FDataLink := TwwInspectorFieldDataLink.Create;
  TwwInspectorFieldDataLink(FDataLink).InspectorItem := self;
  FDataLink.Control := TwwInspectorCollection(Collection).Control;
  if Control is TwwDataInspector then
  begin
    FDataLink.onDataChange := (FDataLink.Control as TwwDataInspector)
      .EditDataLinkDataChange;
    FDataLink.onUpdateData := (FDataLink.Control as TwwDataInspector)
      .EditDataLinkUpdateData;
    TwwDataInspector(Control).CheckRowCount := true;
  end;
end;

procedure TwwDataInspector.EditDataLinkDataChange(Sender: TObject);
begin
  // TwwDataInspectorDataLink(FDatalink).DataSetChanged;
  Invalidate;
end;

procedure TwwDataInspector.EditDataLinkUpdateData(Sender: TObject);
begin
  TwwDataInspectorDataLink(FDataLink).UpdateData;
end;

destructor TwwInspectorItem.Destroy;
begin
  if not(csDestroying in Control.ComponentState) and
    (csDesigning in Control.ComponentState) and (CustomControl <> nil) then
  begin
    CustomControl := nil;
    // make custom control visible for design-time manipulation
  end;

  FItems.Free;
  FPickList.Free;
  FPicture.Free;
  FRegexMask.Free;
  { if UseDefaultLookupComboBox then
    begin
    if (CustomControl is TwwDBLookupCombo) and (CustomControl<>nil) then
    begin
    CustomControl.Free;
    CustomControl:= nil;
    end
    end;
  }
  if not(csDestroying in Control.ComponentState) and
    (Control is TwwDataInspector) then
  begin
    TwwDataInspector(Control).CheckRowCount := true;
    TwwDataInspector(Control).Invalidate;
  end;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TwwInspectorItem.GetLevel: Integer;
var
  Level: Integer;
  tempParent: TwwInspectorItem;
begin
  tempParent := ParentItem;
  Level := 0;
  while tempParent <> nil do
  begin
    tempParent := tempParent.ParentItem;
    Level := Level + 1;
  end;

  result := Level;

end;

procedure TwwInspectorItem.SetCustomControl(val: TWinControl);
begin
  if val = Control then
    exit;

  if (FCustomControlName <> val) then
  begin
    if (val = nil) then
    begin
      FCustomControlName.ControlStyle := FCustomControlName.ControlStyle -
        [csNoDesignVisible];
      FCustomControlName.parent := GetParentForm(FCustomControlName);
    end
    else
    begin
      val.ControlStyle := val.ControlStyle + [csNoDesignVisible];
      val.Visible := false; { 9/27/99 }

      // Following sets datasource/datafield to valid problem
      // where change record before control is visible causes
      // wrong value to be remembered by contorl such as month calendar
      if (GetDataSource <> nil) then // 12/19/01 - Not necessary for unbound
        // Can cause streaming to be overwritten in some cases if InitCustomEidt called
        TwwDataInspector(Control).InitCustomEdit(val, self);
    end;

    FCustomControlName := val;
  end;
  if (TwwInspectorCollection(Collection).UpdateCount = 0) and
    (Control is TwwDataInspector) then
  begin
    TwwDataInspector(Control).Update;
    TwwDataInspector(Control).Invalidate; // RefreshItem(self);
    TwwDataInspector(Control).Update;
  end
end;

Function TwwInspectorItem.GetField: TField;
begin
  if (DataSource <> nil) and (DataSource.Dataset <> nil) then
    result := DataSource.Dataset.FindField(DataField)
  else
    result := nil;
end;

Function TwwInspectorItem.GetControl: TComponent;
begin
  result := TwwInspectorCollection(Collection).Control;
end;

procedure TwwInspectorItem.SetCellHeight(const Value: Integer);
begin
  if FCellHeight <> Value then
  begin
    FCellHeight := Value;
    if Control is TwwDataInspector then
      TwwDataInspector(Control).RefreshItem(self)
  end
end;

procedure TwwInspectorItem.SetVisible(val: boolean);
begin
  if FVisible <> val then
  begin
    FVisible := val;
    if Control is TwwDataInspector then
      TwwDataInspector(Control).ApplySettings
  end
end;

procedure TwwInspectorItem.SetExpanded(val: boolean);
var
  Inspector: TwwDataInspector;
begin
  if FExpanded <> val then
  begin
    FExpanded := val;
    if Control is TwwDataInspector then
    begin
      Inspector := TwwDataInspector(Control);
      Inspector.ApplySettings;
    end
  end
end;

procedure TwwInspectorItem.SetCaption(const Value: string);
begin
  FCaption := Value;
  if GetDesigner <> nil then
  begin
    GetDesigner.Update;
    if Control is TwwDataInspector then
      TWinControl(Control).Invalidate;
  end
end;

function TwwInspectorItem.GetDataLink: TDataLink;
begin
  result := FDataLink;
  if (FDataLink <> Nil) and (FDataLink.DataSource = nil) then
  begin
    if Control is TwwDataInspector then
      result := TwwDataInspector(Control).DataLink
  end;
end;

function TwwInspectorItem.GetDataSource: TDataSource;
begin
  result := nil;
  if (FDataLink <> Nil) then
    result := FDataLink.DataSource;
  if result = nil then
  begin
    if Control is TwwDataInspector then
      result := TwwDataInspector(Control).DataSource;
  end
end;

procedure TwwInspectorItem.SetDataSource(Value: TDataSource);
begin
  if Control is TwwDataInspector then
  begin
    if Value <> TwwDataInspector(Control).DataSource then
      FDataLink.DataSource := Value
    else
      FDataLink.DataSource := nil;
  end
  else
    FDataLink.DataSource := Value;
end;

function TwwInspectorItem.GetDataField: string;
begin
  if FDataLink.DataSource <> nil then
    result := FDataLink.FieldName
  else
    result := FDataField
end;

procedure TwwInspectorItem.SetDataField(const Value: string);
begin
  // if not (csDesigning in ComponentState) then
  // ResetMaxLength(Self);
  // if FDataLink.DataSource<>nil then
  FDataLink.FieldName := Value;
  // else
  FDataField := Value
end;

procedure TwwInspectorItem.Assign(Source: TPersistent);
begin
  if Source is TwwInspectorItem then
  begin
    EditText := TwwInspectorItem(Source).EditText;
    Caption := TwwInspectorItem(Source).Caption;
    CellHeight := TwwInspectorItem(Source).CellHeight;
    ReadOnly := TwwInspectorItem(Source).ReadOnly;
    CustomControl := TwwInspectorItem(Source).CustomControl;
    DataField := TwwInspectorItem(Source).DataField;
    Resizeable := TwwInspectorItem(Source).Resizeable;
    Visible := TwwInspectorItem(Source).Visible;
    Tag := TwwInspectorItem(Source).Tag;
    TagString := TwwInspectorItem(Source).TagString;
    Expanded := TwwInspectorItem(Source).Expanded;
    if TwwInspectorItem(Source).Items.Count > 0 then
      Items.Assign(TwwInspectorItem(Source).Items);
    PickList.Assign(TwwInspectorItem(Source).PickList);
    exit;
  end;
  inherited Assign(Source);
end;

function TwwInspectorItem.GetNamePath: string;
var
  tempName: string;
  tempItem: TwwInspectorItem;
begin
  result := inherited GetNamePath;
  tempName := '';
  tempItem := self;
  repeat
    tempName := 'Items[' + inttostr(tempItem.Index) + ']' + tempName;
    tempItem := tempItem.ParentItem;
  until tempItem = nil;
  tempName := Control.name + '.' + tempName;
  result := tempName;
end;

function TwwInspectorItem.GetDisplayName: string;
var
  TempText: string;
begin
  if Caption = '' then
    TempText := '<InspectorItem>'
  else
    TempText := Caption;
  result := inttostr(Index) + ' - ' + TempText;
end;

function TwwInspectorItem.GetPrior(VisibleItemsOnly: boolean = true;
  ExpandedOnly: boolean = false): TwwInspectorItem;
var
  NextItem, LastChild: TwwInspectorItem;
begin
  NextItem := GetPriorSibling(VisibleItemsOnly);
  if NextItem <> nil then
  begin
    LastChild := NextItem.GetLastChild(VisibleItemsOnly, ExpandedOnly);
    if LastChild = nil then
      result := NextItem
    else
      result := LastChild;
    exit;
  end;

  result := ParentItem;
end;

function TwwInspectorItem.GetFirstChild(VisibleItemsOnly: boolean = true;
  ExpandedOnly: boolean = false): TwwInspectorItem;
var
  i: Integer;
begin
  result := nil;
  if ExpandedOnly and (not Expanded) then
    exit;

  for i := 0 to Items.Count - 1 do
  begin
    if (not VisibleItemsOnly) or TwwInspectorItem(Items[i]).Visible then
    begin
      result := TwwInspectorItem(Items[i]);
      break;
    end
  end;
end;

function TwwInspectorItem.GetLastChild(VisibleItemsOnly: boolean = true;
  ExpandedOnly: boolean = false): TwwInspectorItem;
var
  i: Integer;
begin
  result := nil;
  if ExpandedOnly and (not Expanded) then
    exit;

  for i := Items.Count - 1 downto 0 do
  begin
    if (not VisibleItemsOnly) or TwwInspectorItem(Items[i]).Visible then
    begin
      result := TwwInspectorItem(Items[i]);
      break;
    end
  end;
end;

function TwwInspectorItem.GetNext(VisibleItemsOnly: boolean = true;
  ExpandedOnly: boolean = false): TwwInspectorItem;
var
  NextItem, curItem: TwwInspectorItem;
begin
  NextItem := GetFirstChild(VisibleItemsOnly, ExpandedOnly);

  if NextItem <> nil then
  begin
    result := NextItem;
    exit;
  end;

  NextItem := GetNextSibling(VisibleItemsOnly);
  curItem := self;

  while (NextItem = nil) and (curItem <> nil) do
  begin
    curItem := curItem.ParentItem;
    if curItem <> nil then
      NextItem := curItem.GetNextSibling(VisibleItemsOnly)
  end;
  result := NextItem;
end;

function TwwInspectorItem.GetNextSibling(VisibleItemsOnly: boolean = true)
  : TwwInspectorItem;
var
  i: Integer;
begin
  result := nil;
  for i := index + 1 to Collection.Count - 1 do
  begin
    if (not VisibleItemsOnly) or TwwInspectorItem(Collection.Items[i]).Visible
    then
    begin
      result := TwwInspectorItem(Collection.Items[i]);
      break;
    end
  end;
end;

function TwwInspectorItem.GetPriorSibling(VisibleItemsOnly: boolean = true)
  : TwwInspectorItem;
var
  i: Integer;
begin
  result := nil;
  for i := index - 1 downto 0 do
  begin
    if (not VisibleItemsOnly) or TwwInspectorItem(Collection.Items[i]).Visible
    then
    begin
      result := TwwInspectorItem(Collection.Items[i]);
      break;
    end
  end;
end;

constructor TwwInspectorCollection.Create(Control: TComponent);
begin
  inherited Create(TwwInspectorItem);
  self.Control := Control;
end;

destructor TwwInspectorCollection.Destroy;
begin
  inherited Destroy;
end;

function TwwInspectorCollection.Insert(Index: Integer): TwwInspectorItem;
begin
  result := TwwInspectorItem(inherited Insert(index));
end;

function TwwInspectorCollection.Add: TwwInspectorItem;
begin
  result := TwwInspectorItem(inherited Add);
end;

function TwwInspectorCollection.GetItem(Index: Integer): TwwInspectorItem;
begin
  result := TwwInspectorItem(inherited GetItem(Index));
end;

function TwwInspectorCollection.GetOwner: TPersistent;
begin
  result := Control;
end;

procedure TwwInspectorCollection.SetItem(Index: Integer;
  Value: TwwInspectorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TwwInspectorCollection.Update(Item: TCollectionItem);
begin
end;

procedure TwwInspectorItem.SetItems(Value: TwwInspectorCollection);
begin
  FItems.Assign(Value);
end;

Function TwwInspectorItem.GetDesigner: TControl;
begin
  result := nil;
  if Control is TwwDataInspector then
    result := TwwDataInspector(TwwInspectorCollection(Collection)
      .Control).Designer;
end;

procedure TwwInspectorItem.DefineProperties(Filer: TFiler);
begin
  // Filer.DefineProperty('ItemsTest', ReadItems, WriteItems, HaveItems);
  inherited DefineProperties(Filer);
end;

{
  procedure TwwDataInspector.Click;
  begin
  inherited Click;
  end;
}
procedure TwwDataInspector.CMEnter(var Message: TCMEnter);
var
  IndicatorOffset: Integer;
begin
  inherited;
  FFocused := true;
  if IndicatorRow.Enabled then
    IndicatorOffset := 1
  else
    IndicatorOffset := 0;

  if SetFocusTabStyle = itsResetActiveItem then
  begin
    Row := IndicatorOffset; // 09/04/01 - Set row to 1st not-fixed row
  end;
  InvalidateRow(Row);

  if KeyHook = 0 then
    KeyHook := SetWindowsHookEx(WH_KEYBOARD, @wwHookKeyProc, HInstance,
      GetCurrentThreadID);

end;

type
  TwwCollectionStreamComponent = class(TComponent)
  private
    FItems: TwwInspectorCollection;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Items: TwwInspectorCollection read FItems write FItems;
  end;

constructor TwwCollectionStreamComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TwwInspectorCollection.Create(self);
end;

destructor TwwCollectionStreamComponent.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TwwInspectorCollection.SaveToStream(s: TStream);
var
  tempC: TwwCollectionStreamComponent;
begin
  tempC := TwwCollectionStreamComponent.Create(Control);
  with tempC do
  begin
    Items.Assign((Control as TwwDataInspector).Items);
    s.WriteComponent(tempC);
    Free;
  end;
end;

procedure TwwInspectorCollection.LoadFromStream(s: TStream);
var
  tempC: TwwCollectionStreamComponent;
begin
  if (Control is TwwDataInspector) then
    TwwDataInspector(Control).HideEditor;
  tempC := TwwCollectionStreamComponent.Create(Control);
  with tempC do
  begin
    s.ReadComponent(tempC);
    (Control as TwwDataInspector).Items.Assign(Items);
    Free;
  end;
end;

procedure TwwInspectorCollection.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TwwInspectorCollection.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function TwwDataInspector.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): boolean;
begin
  SendMessage(Handle, WM_VSCROLL, sb_linedown, 0);
  result := true;
end;

function TwwDataInspector.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): boolean;
begin
  SendMessage(Handle, WM_VSCROLL, sb_lineup, 0);
  result := true;
end;

procedure TwwDataInspector.FirstTimePaint;
begin
end;

// 1/22/00 - Add support for ActionLists (PYW)
function TwwDataInspector.ExecuteAction(Action: TBasicAction): boolean;
begin
  result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TwwDataInspector.UpdateAction(Action: TBasicAction): boolean;
begin
  result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ procedure TwwDataInspector.RefreshCustomControl;
  begin
  DirtyCustomInfo:= True;
  Invalidate;
  end;
}
procedure TwwDataInspector.WMLButtonDown(var Message: TWMLButtonDown);
begin
  // LastActiveControl:= Screen.ActiveControl;
  inherited;

end;

procedure TwwDataInspector.WMHScroll(var Message: TWMHScroll);
  procedure NextRow;
  begin
    with FDataLink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDataLink.FModified then
        if Eof then
          exit
        else
          Cancel
      else
      begin
        { Already pointing to end of table but active record is before this. 10/15/96 - dsInsert should not increment }
        if Eof and (FDataLink.ActiveRecord >= 0) and
        { IP2 - Used to be >0, now >=0 }
          (FDataLink.ActiveRecord < FDataLink.RecordCount - 1) and
          not(State = dsInsert) then
          FDataLink.ActiveRecord := FDataLink.ActiveRecord + 1
        else
        begin
          Next;
        end
      end;
    end;
  end;

  procedure PriorRow;
  begin
    with FDataLink.Dataset do
      if (State = dsInsert) and not Modified and Eof and not FDataLink.FModified
      then
        Cancel
      else
      begin
        if Bof and (FDataLink.ActiveRecord > 0) then
          FDataLink.ActiveRecord := FDataLink.ActiveRecord - 1
        else
          Prior;
      end
  end;

  Function Sequencable: boolean;
  begin
    result := FDataLink.Dataset.isSequenced;
  end;

  procedure ParadoxPosition;
  var
    SI: TScrollInfo;
  begin
    with FDataLink.Dataset do
    begin
      { Support proportional scrollbar }
      SI.cbSize := sizeof(SI);
      SI.fMask := SIF_ALL;
      GetScrollInfo(self.Handle, SB_VERT, SI);
      CheckBrowseMode;
      if SI.nTrackPos <= 1 then
        First
      else if SI.nTrackPos >= RecordCount then
        Last
      else
        RecNo := SI.nTrackPos;
      Resync([]);
    end;
  end;

begin
  if Message.ScrollBar = 0 then
  // Ignore scrolling message from scrollbar/trackbar control
  begin
    if not AcquireFocus then
      exit;
    if FDataLink.Active then
      with Message, FDataLink.Dataset, FDataLink do
        case ScrollCode of
          sb_lineup:
            PriorRow;
          sb_linedown:
            NextRow;
          SB_PAGEUP:
            MoveBy(-(VisibleColCount - 1));
          SB_PAGEDOWN:
            MoveBy(VisibleColCount - 1);
          SB_THUMBPOSITION:
            begin
              if Sequencable then
              begin
                ParadoxPosition;
              end
              else
              begin
                case Pos of
                  0:
                    First;
                  1:
                    MoveBy(-VisibleColCount);
                  2:
                    exit;
                  3:
                    MoveBy(VisibleColCount);
                  4:
                    Last;
                end;
              end
            end;

          SB_BOTTOM:
            Last;
          SB_TOP:
            First;
        end;
    // inherited
  end
  else
    message.result := 0;
end;

procedure TwwDataInspector.UpdateScrollBar;
var
  Sequencable: boolean;
  SIOld, SINew: TScrollInfo;
begin
  if not(ScrollBars in [ssHorizontal, ssBoth]) then
    exit;

  // 2/1/2001 - Add check to see if dataset is active as well. (PYW)
  if FDataLink.Active and FDataLink.Dataset.Active and handleAllocated then
  begin
    { Set scroll bar precisely }
    Sequencable := FDataLink.Dataset.isSequenced;
    if Sequencable then
      FDataLink.Dataset.UpdateCursorPos;

    { Support proportional scrollbar }
    SIOld.cbSize := sizeof(SIOld);
    SIOld.fMask := SIF_ALL;
    GetScrollInfo(self.Handle, SB_HORZ, SIOld);
    SINew := SIOld;

    if Sequencable then
      with FDataLink.Dataset do
      begin
        SINew.nMin := 1;
        SINew.nPage := self.VisibleRowCount;
        SINew.nMax := Integer(DWORD(RecordCount) + SINew.nPage - 1);
        if State in [dsInactive, dsBrowse, dsEdit] then
          SINew.nPos := RecNo; // else keep old pos
      end
    else
    begin
      SINew.nMin := 0;
      SINew.nPage := 0;
      SINew.nMax := 4;
      if FDataLink.Bof then
        SINew.nPos := 0
      else if FDataLink.Eof then
        SINew.nPos := 4
      else
        SINew.nPos := 2;
    end;

    if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
      (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    begin
      SINew.fMask := SIF_ALL;
      // SIF_DisableNoScroll does not seem to work reliably so do not
      // use it. Instead just make scrollbar thumb as large as the scrollbar
      // so there is nothing to scroll.
      if SINew.nMax - SINew.nMin <= 1 { SINew.nPage } then
      begin
        SINew.nPage := 1000;
        SINew.nMax := 1001;
        SINew.nMin := 1;
        // SINew.fMask:= SIF_ALL or SIF_DISABLENOSCROLL;
      end;
      SetScrollInfo(self.Handle, SB_HORZ, SINew, true);
    end
  end;

end;

procedure TwwDataInspector.SetScrollBars(Value: System.UITypes.TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    if FScrollBars in [ssVertical, ssBoth] then
      inherited ScrollBars := ssVertical
    else
      inherited ScrollBars := ssNone;
    RecreateWnd;
  end;
end;

procedure TwwDataInspector.SetDataColumns(val: Integer);
begin
  if val <> FDataColumns then
  begin
    FDataColumns := val;
    ColCount := FDataColumns + 1;
    if (ColCount > 1) and (Col = 0) then
      Col := 1;
    FDataLink.BufferCount := val;
    UpdateDataColumnWidth;
  end;

end;

procedure TreeLine(Canvas: TCanvas; p1, p2: TPoint);
var
  i: Integer;
  x, Y: Integer;
  tot: Integer;
begin
  Canvas.Pen.Color := clBlack;
  Canvas.Polyline([p1, p2]);
  Canvas.Pen.Color := clWhite;
  if (p1.Y = p2.Y) then
  begin
    p1.Y := p1.Y + 1;
    p2.Y := p2.Y + 1;
    p1.x := p1.x + 1;
  end
  else
  begin
    p1.x := p1.x + 1;
    p2.x := p2.x + 1;
  end;
  Canvas.Polyline([p1, p2]);
  exit;
  // Refresh;
  x := p1.x;
  Y := p1.Y;
  tot := wwMax(abs(p2.Y - p1.Y), abs(p2.x - p1.x));
  for i := 0 to tot do
    if i mod 2 = 0 then
    begin
      Canvas.Polyline([Point(x, Y), Point(x + 1, Y + 1)]);
      inc(x, (p2.x - p1.x) div wwMax(1, (tot div 2)));
      inc(Y, (p2.Y - p1.Y) div wwMax(1, (tot div 2)));
    end;
end;

Function TwwDataInspector.LevelRect(Item: TwwInspectorItem): TRect;
var
  ARow: Integer;
begin
  result := Rect(0, 0, 0, 0);
  ARow := GetRowByItem(Item);
  if ARow >= 0 then
    result := CellRect(0, ARow);
end;

procedure TwwDataInspector.PaintLines(Item: TwwInspectorItem);
var
  LevelNode: TwwInspectorItem;
  LineStartX: Integer;
  LineTop, LineBottom: TPoint;
  x, Y: Integer;
  R: TRect;
  pt: TPoint;

  Function GetTitleRect2: TRect;
  var
    TitleRect: TRect;
  begin
    TitleRect := Rect(R.Left + (Item.Level + 1) * CaptionIndent, R.Top + 1,
      R.right, R.Bottom);
    result := TitleRect;
  end;

  Function GetTitleRect(ARect: TRect): TRect;
  var
    TitleRect: TRect;
  begin
    TitleRect := Rect(ARect.Left + (Item.Level + 1) * CaptionIndent - 1,
      ARect.Top + 1, ARect.right, ARect.Bottom);
    if Item.HaveVisibleItem then
      TitleRect.Left := ButtonPt(ARect, Item).x - 7;
    result := TitleRect;
  end;

  Function GetStartX(Item: TwwInspectorItem): Integer;
  // const MaxCheckboxSize = 6;
  var
    R: TRect;
    pt: TPoint;
  begin
    result := 0;
    R := LevelRect(Item);
    Item := Item.ParentItem;
    if Item = nil then
      exit;
    if Item.HaveItems then
    begin
      pt := ButtonPt(R, Item);
      result := pt.x - 1;
    end;
  end;

begin
  R := LevelRect(Item);
  if ovShowTreeLines in Options then
  begin
    // FPaintCanvas.Pen.Color := FLineColor; //clBtnShadow; { for line drawing }
    FPaintCanvas.Pen.Color := clBtnShadow; { for line drawing }
    FPaintCanvas.Pen.Color := clWhite; { for line drawing }
    LevelNode := Item;
    if Item.Expanded and Item.HaveVisibleItem then
    begin
      pt := ButtonPt(R, Item);
      LineTop := Point(pt.x - 1, pt.Y + 7);
      LineBottom := Point(pt.x - 1, R.Bottom);
      TreeLine(FPaintCanvas, LineTop, LineBottom);
    end;

    while (LevelNode <> nil) and
      ((LevelNode.Level = 0) or (LevelNode.ParentItem <> nil)) do
    begin
      LineStartX := GetStartX(LevelNode);
      LineTop := Point(LineStartX, R.Top);
      LineBottom := Point(LineStartX, R.Bottom);

      if LevelNode.Level = Item.Level then
      begin
        if (Item.GetPriorSibling = nil) and (Item.ParentItem = nil) then
          inc(LineTop.Y, GetCenterPoint(R).Y);
        if Item.GetNextSibling = nil then
        begin
          Dec(LineBottom.Y, wwRectHeight(R) div 2 - 1)
        end
      end;
      if (LevelNode.GetNextSibling <> nil) or (LevelNode.Level = Item.Level)
      then
        if LevelNode.Level > 0 then // LineStartX>0 then
          TreeLine(FPaintCanvas, LineTop, LineBottom);
      // TreeLine(FPaintCanvas, Point(LineTop.x, r.bottom-1), Point(r.right, r.bottom-1));
      // TreeLine(FPaintCanvas,LineTop, LineBottom);
      LevelNode := LevelNode.ParentItem;
    end;

    // Horizontal line
    R := LevelRect(Item);
    if { (tvoShowRoot in Options) or } (Item.Level <> 0) then
    begin
      if ovCenterCaptionVert in Options then
        Y := GetCenterPoint(R).Y
      else
      begin
        Y := ButtonPt(R, Item).Y;
      end;
      x := GetStartX(Item);
      TreeLine(FPaintCanvas, Point(x, Y), Point(GetTitleRect(R).Left, Y));
      { TreeLine(FPaintCanvas, Point(2+GetTitleRect2.left+Canvas.TextWidth(item.caption), y),
        Point(r.right-8,y));
        TreeLine(FPaintCanvas, Point(r.right-8, ((r.Bottom+r.Top) div 2)-4),
        Point(r.right-8, ((r.Bottom+r.Top) div 2)+4));
        TreeLine(FPaintCanvas, Point(r.right-8, ((r.Bottom+r.Top) div 2)-4),
        Point(r.right-2, ((r.Bottom+r.Top) div 2)));
        TreeLine(FPaintCanvas, Point(r.right-2, ((r.Bottom+r.Top) div 2)),
        Point(r.right-8, ((r.Bottom+r.Top) div 2)+4));
      }
      // 2+GetTitleRect2.left+Canvas.TextWidth(item.caption), y),
      // Point(r.right-4,y));

      // FPaintCanvas.Ellipse(Rect(r.right-6,r.Top,r.Right-2,r.bottom));

      // TreeLine(FPaintCanvas, Point(x, r.bottom-1), Point(r.right, r.bottom-1));
      // DottedLine(FPaintCanvas, Point(r.right-105, y), Point(r.right-2,y));
    end
  end;
end;

procedure TwwDataInspector.FreeHintWindow;
begin
  HintTimerCount := 0;
  SkipErase := true;
  HintWindow.Free;
  SkipErase := false;
  HintWindow := nil;
  if HintTimer <> nil then
    HintTimer.Enabled := false;
end;

Function TwwDataInspector.CreateHintWindow: THintWindow;
begin
  HintWindow := TwwInspectorHintWindow.Create(self);
  HintWindow.Color := GetSysColor(COLOR_INFOBK);
  HintWindow.Canvas.Brush.Color := GetSysColor(COLOR_INFOBK);
  HintWindow.Canvas.Font := self.Font;
  HintWindow.Canvas.Font.Color := GetSysColor(COLOR_INFOTEXT);
  HintWindow.Canvas.Pen.Color := clBlack;
  result := HintWindow;
end;

procedure TwwDataInspector.HintTimerEvent(Sender: TObject);
var
  sp, cp: TPoint;
  OutsideClient: boolean;
  cr: TRect;
  hintTimerInterval: Integer;
begin
  if not(HintWindow <> nil) then
    exit;

  GetCursorPos(cp);

  sp := self.ScreenToClient(cp);
  cr := CellRect(lastMouseX, lastMouseY);
  InflateRect(cr, 1, 1);
  if not(ptinrect(cr, sp)) then
  begin
    FreeHintWindow;
    lastMouseX := 0;
    lastMouseY := 0;
    exit;
  end;

  sp := self.ClientToScreen(Point(0, 0));

  if (cp.x < sp.x) or (cp.x > sp.x + ClientRect.right - ClientRect.Left) or
    (cp.Y < sp.Y) or (cp.Y > sp.Y + ClientRect.Bottom - ClientRect.Top) then
  begin
    OutsideClient := true;
  end
  else
    OutsideClient := false;

  { Process Hint Timer clean-up }
  if OutsideClient then
  begin
    FreeHintWindow;
    lastMouseX := 0;
    lastMouseY := 0;
  end
  else
  begin
    inc(HintTimerCount);
    hintTimerInterval := HintTimer.interval;
    if HintTimerCount >
      wwMax(Application.HintHidePause div hintTimerInterval, 16) then
    begin
      FreeHintWindow;
    end
  end

end;

function TwwDataInspector.RecordCountIsValid: boolean;
begin
  result := (FDataLink <> nil) and FDataLink.Active and
    (FDataLink.Dataset <> nil) and FDataLink.Dataset.Active;
end;

procedure TwwDataInspector.HintMouseMove(Shift: TShiftState; x, Y: Integer);
var
  R: TRect;
  sp: TPoint;
  AHintText: string;
  drawrect: TRect;
  drawflags: Integer;
  MaxWidth, MaxHeight, hintwidth: Integer;
  DoDefault: boolean;
  VerticalFits, HorizontalFits: boolean;
  obj: TwwInspectorItem;
  oldDrawRect: TRect;
  OldActiveRecord: Integer;
  OldMaxHeight: Integer;

  Function GetTitleRect: TRect;
  var
    TitleRect: TRect;
    ARect: TRect;
  begin
    ARect := CellRect(lastMouseX, lastMouseY);
    TitleRect := Rect(ARect.Left + (obj.Level + 1) * CaptionIndent,
      ARect.Top + 1, ARect.right, ARect.Bottom);
    result := TitleRect;
  end;

  function GetHintText: string;
  var
    AHintText: string;
  begin
    if (obj.Field <> nil) then
    begin
      if obj.Field is TBlobField then
      begin
        if obj.Field.datatype in [ftMemo, ftOraBlob, ftOraCLob
{$IFDEF wwDelphi2006Up}
          , ftWideMemo
{$ENDIF}
          ] then
          AHintText := obj.Field.asString;
      end
      else
        AHintText := obj.Field.DisplayText
    end
    else
      AHintText := obj.EditText;
    result := AHintText;
  end;

begin
  if (ovShowCellHints in Options) and (csDesigning in ComponentState) then
    exit;
  with MouseCoord(x, Y) do
  begin
    if not(ovShowCaptionHints in Options) and (x = 0) then
      exit;
    if not(ovShowCellHints in Options) and (x >= 1) then
      exit;
    if ((x <> lastMouseX) or (Y <> lastMouseY)) then
    begin
      R := CellRect(x, Y);
      lastMouseX := x;
      lastMouseY := Y;
      FreeHintWindow;
      HintTimer.Free;
      HintTimer := nil;

      if (x = Col) and (Y = Row) then
      begin
        if (InplaceEditor <> nil) and (InplaceEditor.Visible) then
          exit;
        if (TCheatCast(self).CurrentCustomEdit <> nil) and
          (TCheatCast(self).CurrentCustomEdit.Visible) then
          exit;
      end;
      obj := GetItemByRow(Y);
      if obj = nil then
        exit;

      if obj.CustomControlAlwaysPaints and (obj.CustomControl <> nil) then
        exit;

      if x = 0 then
        AHintText := obj.Caption
      else
      begin
        if RecordCountIsValid and (x - 1 < FDataLink.RecordCount) then
        begin
          OldActiveRecord := FDataLink.ActiveRecord;
          FDataLink.ActiveRecord := x - 1;
          AHintText := GetHintText;
          FDataLink.ActiveRecord := OldActiveRecord;
        end
        else
          AHintText := GetHintText;
      end;
      if AHintText = '' then
        exit;

      drawflags := DT_NOPREFIX;
      if x = 0 then
      begin
        drawrect := GetTitleRect;
        Canvas.Font.Assign(CaptionFont);
        { 8/24/00 - Set default before calling calccellcolors }
      end
      else
      begin
        drawrect := Rect(0, 0, R.right - R.Left - 4, 0);
        if obj.WordWrap then
          drawflags := drawflags or DT_EDITCONTROL or DT_WORDBREAK;
        Canvas.Font.Assign(Font);
        { 8/24/00 - Set default before calling calccellcolors }
      end;
      if Pos(#9, AHintText) > 0 then
        drawflags := drawflags or DT_EXPANDTABS; // 9/7/00

      oldDrawRect := drawrect;
      DrawTextEx(Canvas.Handle, PChar(AHintText), length(AHintText), drawrect,
        drawflags or DT_CALCRECT, nil);
      VerticalFits := (drawrect.Bottom - drawrect.Top <= R.Bottom - R.Top);
      HorizontalFits := (drawrect.right - drawrect.Left < oldDrawRect.right -
        oldDrawRect.Left - 1);
      // HorizontalFits:= (drawrect.Right-drawrect.Left<r.right-r.left-1);
      if VerticalFits and HorizontalFits then
        exit;

      HintWindow := CreateHintWindow;
      HintWindow.Canvas.Font.Assign(Canvas.Font);
      { Default to current cell's font }
      HintTimer := TTimer.Create(self);
      HintTimer.OnTimer := HintTimerEvent;
      HintTimer.interval := 250;
      HintTimer.Enabled := true;

      sp := self.ClientToScreen(Point(0, 0));
      with TwwInspectorHintWindow(HintWindow) do
      begin
        DoDefault := true;
        MaxHeight := R.Bottom - R.Top - 2;
        OldMaxHeight := MaxHeight;
        MaxWidth := screen.Width;
        Caption := AHintText; // 9/7/00

        WordWrap := obj.WordWrap;
        CenterVertically := false;
        DoCreateHintWindow(TwwInspectorHintWindow(HintWindow), obj.Field, R,
          WordWrap, MaxWidth, MaxHeight, DoDefault);

        // { 2/29/00 - subtract 4 to be consistent with above calculation }
        // MaxWidth := wwmax((r.right-r.left-4), MaxWidth);

        if not DoDefault then
          exit;

        R.Bottom := R.Bottom - 2;

        drawflags := DT_NOPREFIX;
        if x = 0 then
        begin
          drawrect := GetTitleRect;
          // drawRect := Rect(0,0,MaxWidth,MaxHeight);
          if ovCenterCaptionVert in Options then
            CenterVertically := true;
          WordWrap := false;
        end
        else
        begin
          drawrect := Rect(0, 0, MaxWidth, MaxHeight);
          // drawRect := Rect(0, 0, r.Right-r.left-4, 0);
          if WordWrap then
            drawflags := drawflags or DT_EDITCONTROL or DT_WORDBREAK;
        end;
        if Pos(#9, AHintText) > 0 then
          drawflags := drawflags or DT_EXPANDTABS; // 9/7/00
        DrawTextEx(Canvas.Handle, PChar(AHintText), length(AHintText), drawrect,
          drawflags or DT_CALCRECT, nil);
        hintwidth := drawrect.right - drawrect.Left;
        if drawrect.right - drawrect.Left > MaxWidth then
          drawrect.right := MaxWidth;
        if drawrect.Bottom - drawrect.Top > MaxHeight then
          drawrect.Bottom := MaxHeight;
        if (MaxHeight <> OldMaxHeight) then
          R.Bottom := wwMax(R.Top + (drawrect.Bottom - drawrect.Top), R.Bottom);

        if R.Left + drawrect.right + 8 <= MaxWidth then
          R.right := R.Left + drawrect.right + 8
        else if MaxWidth <> 0 then
        begin
          if R.Left + drawrect.right + 8 > screen.Width then
            R.Left := R.right - drawrect.right - 8
          else
            R.right := R.Left + hintwidth + 8;
        end;
        if x = 0 then
        begin
          R.Left := drawrect.Left - 2;
          R.Top := drawrect.Top - 1; // 2;
        end;
        OffsetRect(R, sp.x - 1, sp.Y - 2);
        ActivateHint(R, AHintText);
      end;
    end
  end
end;

procedure TwwDataInspector.DoCreateHintWindow
  (HintWindow: TwwInspectorHintWindow; AField: TField; R: TRect;
  var WordWrap: boolean; var MaxWidth, MaxHeight: Integer;
  var DoDefault: boolean);
begin
  if Assigned(FOnCreateHintWindow) then
    FOnCreateHintWindow(self, HintWindow, AField, R, WordWrap, MaxWidth,
      MaxHeight, DoDefault);
end;

procedure TwwInspectorHintWindow.Paint;
var
  R: TRect;
  WriteOptions: TwwWriteTextOptions;
begin
  R := ClientRect;
  inc(R.Left, 2);
  inc(R.Top, 2);
  Canvas.Font.Color := clInfoText;

  if WordWrap then
    WriteOptions := [wtoWordWrap]
  else
    WriteOptions := [];

  if CenterVertically then
    WriteOptions := WriteOptions + [wtoCenterVert];

  wwWriteTextLinesT(Canvas, R, 0, 0, PChar(Caption), Alignment, WriteOptions);
end;

procedure TwwDataInspector.EditingChanged;
begin
  if IndicatorRow.Enabled then
    invalidateCell(Col, 0);
end;

procedure TwwDataInspector.CreateWnd;
begin
  inherited CreateWnd;

  UpdateScrollBar;
end;

procedure TwwDataInspector.Scroll(Distance: Integer);
var
  ColWidth: Integer;
  OldRect, NewRect: TRect;
begin
  if not handleAllocated then
    exit; { 6/2/97 }

  OldRect := BoxRect(Col, 0, Col, RowCount - 1);
  if FDataLink.Active then
  begin
    if NewMouseRow >= 0 then
      SetFocusCell(FDataLink.ActiveRecord + 1, NewMouseRow)
    else
      SetFocusCell(FDataLink.ActiveRecord + 1, Row);
  end;

  UpdateScrollBar;
  UpdateActive; // 7/23/02

  NewRect := BoxRect(Col, 0, Col, RowCount - 1);
  ValidateRect(Handle, @OldRect);
  // if ovHideVertDataLines in Options then
  begin
    OldRect.right := OldRect.right + 1;
    OldRect.Left := OldRect.Left - 1;
    NewRect.right := NewRect.right + 1;
    NewRect.Left := NewRect.Left - 1;
  end;
  InvalidateRect(Handle, @OldRect, false);
  InvalidateRect(Handle, @NewRect, false);

  if (Distance <> 0) and (ColCount > 2) then
  begin
    try
      if (abs(Distance) > VisibleColCount) or
        (not PaintOptions.FastRecordScrolling) then
      begin
        Invalidate;
        exit;
      end
      else
      begin
        ColWidth := ColWidths[1];
        NewRect := BoxRect(1, 0, ColCount - 1, RowCount - 1);
        ScrollWindowEx(Handle, -ColWidth * Distance, 0, @NewRect, @NewRect, 0,
          nil, SW_Invalidate);
      end;
    finally
    end;
  end;

  if ActiveItem <> nil then
    if (ActiveItem.DataSource = DataSource) or ChildDataChanged then
    begin
      SkipSetFocus := true;
      try
        InvalidateEditor;
      finally
        SkipSetFocus := false;
      end
    end
end;

function TwwDataInspector.GetClientRect: TRect;
begin
  result := inherited GetClientRect;
  // result.bottom := result.bottom - 16;
end;

procedure Register;
begin
  RegisterComponents('IP Controls', [TwwDataInspector]);
end;
{
  procedure TwwDataInspector.SetIndicatorCaption(val: string);
  begin
  FIndicatorCaption:= val;
  if ovShowIndicatorRow in Options then InvalidateCell(0, 0);
  end;
}

procedure TwwDataInspector.SetFixedDataRows(Value: Integer);
var
  IndicatorOffset: Integer;
begin
  FFixedDataRows := Value;
  if IndicatorRow.Enabled then
    IndicatorOffset := 1
  else
    IndicatorOffset := 0;
  RowCount := wwMax(Value + IndicatorOffset, RowCount);
  FixedRows := Value;
end;

procedure TwwDataInspector.CMGetDataLink(var Message: TMessage);
begin
  Message.result := Integer(FDataLink);
end;

Function TwwDataInspector.EffectiveFocused: boolean;
begin
  result := FFocused and not(csPaintCopy in ControlState)
end;

procedure TwwDataInspectorDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FObjectView.ActiveItem := FObjectView.GetItemByFieldName(Field^.FieldName);
    if FObjectView.ActiveItem <> nil then
    begin
      if (FObjectView.ActiveItem.Field = Field^) and FObjectView.AcquireFocus
      then
      begin
        Field^ := nil;
      end;
    end
  end;
end;

// 1/21/02
Procedure TwwDataInspector.DoCalcCustomEdit(Item: TwwInspectorItem;
  CustomEdit: TWinControl; var AllowCustomEdit: boolean);
begin
  if Assigned(FOnCalcCustomEdit) then
    FOnCalcCustomEdit(self, Item, CustomEdit, AllowCustomEdit);
end;

procedure TwwDataInspector.CMMouseLeave(var Message: TMessage);
begin
  if wwUseThemes(self) then
  begin
    invalidateCell(lastMouseCoord.x, lastMouseCoord.Y);
  end;
  inherited;
end;

procedure TwwDataInspector.CMMouseEnter(var Message: TMessage);
var
  pt: TPoint;
  Coord: TGridCoord;
begin
  if wwUseThemes(self) then
  begin
    GetCursorPos(pt);
    pt := self.ScreenToClient(pt);
    Coord := MouseCoord(pt.x, pt.Y);

    if Coord.x = Col then // Only do for active record
      invalidateCell(Coord.x, Coord.Y);
  end;
  inherited;
end;

procedure TwwDataInspector.CurrentCustomEditSetfocus;
begin
  if CurrentCustomEdit <> nil then
  begin
    if CurrentCustomEdit.Enabled then
      CurrentCustomEdit.SetFocus;
  end
end;

// 3/31/03 - Respect MaxLength
function TwwDataInspector.GetEditLimit: Integer;
var
  curField: TField;
begin
  result := 0;
  curField := GetField(Row);
  if (curField is TStringField) then
    result := TStringField(curField).Size;
end;

// 3/31/03 - Respect field type
function TwwDataInspector.CanEditAcceptKey(Key: Char): boolean;
var
  curField: TField;
begin
  result := true;
  curField := GetField(Row);

  if curField = nil then
    exit;

  result := FDataLink.Active and curField.IsValidChar(Key);
end;

class constructor TwwDataInspector.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TwwDataInspector, TwwInspectorStyleHook);
end;
procedure TwwInspectorStyleHook.WMEraseBkgnd(var Message: TMessage);
begin
  inherited;
  //message.Result:=1;
end;

procedure TwwInspectorStyleHook.PaintNC(Canvas: TCanvas);
begin
   inherited;
end;

constructor TwwInspectorStyleHook.Create(AControl: TWinControl);
begin
  inherited;
end;

procedure TwwInspectorStyleHook.DrawHorzScroll(DC: HDC);
begin
   if Control.Visible then
      inherited;
end;

procedure TwwInspectorStyleHook.DrawVertScroll(DC: HDC);
begin
   if Control.Visible then
      inherited;
end;


procedure TwwInspectorStyleHook.PaintBackground(Canvas: TCanvas);
begin
end;

procedure TwwInspectorStyleHook.WMNCPaint(var Message: TMessage);
begin
  inherited;
// For some reason setting handled to true prevents expandbutton panel to expand in demo
  //  if OverridePaintNC then
//    Handled:=false;
end;



end.
