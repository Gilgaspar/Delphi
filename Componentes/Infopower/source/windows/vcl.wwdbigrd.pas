{
  //
  // Components : TwwDBCustomGrid
  //
  // Copyright (c) 1995-2001 by Woll2Woll Software
  //
  //
  //  7/10/97 - Unselect all only if left button is clicked - Allows popupmenu to work.
  //  7/10/97 - Support bitmaps with lookup fields - Only 1 field lookups supported
  //  7/18/97 - Call hidecontrols in Layoutchanged so displayed embedded control
  //            does not remain visible when column order is changed.
  //  7/23/97 - Display bitmaps even in insert mode if lookup bitmap
  //  7/31/97 - Don't use displaylabel property when useTFields=False
  //  8/12/97 - Checkmark checkboxes optimized to use DisplayBitmap canvas
  //  8/12/97 - Clear selLength when handling mask in keypress event.  This fixes
  //            a bug which updated the text incorrectly.
  //  10/15/97- Save and restore pen color later to allow column-moving line to be
  //            drawn correctly
  //  10/15/97- Allow resize even if titlebuttons is True
  //  11/2/97 - Added to take care of wordwrap bug in memos displayed in grid
  //  12/8/97 - Use ScrollWindowEx so background isn't cleared before painting
  //  12/11/97 - Insert in front instead of switching columns
  //  12/15/97 - Paint indicator button now so blank space isn't displayed too long
  //  12/21/97 - Use goColMoving instead of dgColumnResize.  Developer can
  //             then progmatically set goColMoving to False, while leaving the
  //             column sizing as True.  This allows the developer a way of
  //             removing the column dragging vertical bar.
  //  1/28/98 -  Clear multi-select last record
  //  2/4/98 -   Don't call OnCheckValue if character is not accepted
  //  2/9/98 -   Only depress currently clicked column
  //  3/30/98 -  Support ampersands in titles
  //  3/30/98 -  Support imagelist to display bitmaps
  //  3/31/98 -  If CenterJustify then allow DrawText to properly center text
  //  3/31/98 -  Check to see if this is a single line edit control to
  //               determine if we should or should not have word breaks
  //  4/28/98 - IsMemoField uses ftMemo
  //  5/13/98 - Fix memory leak for ShiftSelectBookmark
  //  8/24/98 - Support Delphi 4 ActionLists
  //  8/24/98 - Don't allow insert/edit if no records and dgallowinsert is false
  //  9/2/98 -  Fixed 2 digit year bug in method UpdateData
  //  9/2/98 -  FieldChanged event not fired in some cases.  This problem
  //            is corrected by using UpdateData instead when using the
  //            default inplaceeditor.  Also previous call to FieldChanged
  //            is only called when a customedit is attached.
  // 9/2/98 -   Fix bug where footer is not cleared when maximizing grid with
  //            no records.
  // 9/15/98 - Test for GoFoward when going back to previous row
  // 9/21/98 - Make DoCalcTitleImage virtual for Delphi 4
  // 9/22/98 - Don't call inherited if fail to set focus as this would
  lead to OnValidate getting called twice
  // 9/24/98 - Prevent recursion in OnFieldChanged event by comparing text
  // 10/2/98 - Allow editing if editing in CanEditModify
  // 10/12/98 - Avoid converting 4 digit years to prevent 1900 from converting to 2000
  // 10/26/98 - Truncate to character boundary in SetColumnAttributes.  Prevents problem
  //            of column changing size when sizing another column.
  // 10/28/98 - Subtract -4 from ColWidths in SetColumnAttributes.  Also undo change made on
  //            10/26/98
  // 11/11/98 - Invisible grid problem when width=0
  // 11/24/98 - Check for nil curbookmark in DoCheckRowChanged
  // 12/4/98  - Fix problem when descenders cutoff when dgRowLines=False.  Indirectly
  //            fixes problem with lookupcombos with this problem.
  // 12/7/98 - Correct OnColWidthChanged event passing the wrong column
  // 12/9/98 - Just call RequestAlign in CMShowingChanged
  // 1/8/99 - Fix descendor cutoff problem when wordwrap is true
  // 1/31/99 - Support OnRowChanged for insert
  // 2/17/99 - If append in grid, custom controls were not automatically moved to new row
  // 2/17/99 - Added MouseWheel support by overriding virtual methods DoMouseWheelUp and DoMouseWheelDown (Delphi 4 Only)
  // 2/21/99 - RSW, Don't highlight if fixed row multi-select cell
  // 3/30/99 - Only include Insert if the dataset is not empty
  // 4/21/99 - Free ShiftSelectBookmark first to fix memory leak.
  // 4/28/99 - Fix problem where fixed column didn't fire event after drag operation
  // 6/11/99 - Make sure adding never subtracting
  // 1/13/2000 - Updated to use UseRightToLeftAlignment instead to test for Bidi mode
  // 2/21/2000 - Fix bug introduced by Delphi 5 Patch 1 -
  //             Need to make sure this code is not executed for lookupcombo
  // 2/29/00 - subtract 4 to be consistent with above calculation
  // 5/2/00 - Add method to clear last bookmark values
  // 6/8/00 - Don't need to change grid layout when setting color
  // 6/29/00 - PYW - Compute hint position correctly in different screen resolutions
  //                 like 800x600 and when setting MaxLength in event.
  // 7/2/2000 - Check for nil Screen.ActiveControl
  // 9/7/00 - Expand tabs when computing hint window size
  // 7/26/01 - Added code to handle abort in OnDrawDataCell event to prevent default customcontrol painting. - PYW
  // 7/26/01 - Make sure datalink is active if showing hints. -PYW
  // 8/8/2001- PYW - Make sure Datalink is active before going to next or prior record with mouse wheel.
  // 9/24/2001 - If UseTFields is True, then have column return the fields displaywidth. -PYW
  // 9/27/2001 - OnKeyUp not firing for tab or return key.
  // 10/01/2001 - Don't allow setting smaller than defaultrowheight. -PYW
  // 11/30/2001 - Made isMemoField virtual method.
  // 12/12/01 - Set rowcount to 1+FTitleOffset if recordcount is not valid
  // 12/21/01 - Fix hint not showing bug
  // 1/4/02 - Don't paint data columns to the left of data area.
  // 1/9/2002 - Call raise when patch variable set to allow messages from onvalidate to fire when focus exits grid.
  // 1/21/02 - Fix left/right column scrolling problem where it didn't exit column when inplaceeditor being used (RSW)
  // 2/11/2002 - Need to place in a begin/end block as following code only applies to above case -PYW
  // 2/13/2002 - Don't call InitBlendBitmaps if no background bitmap loaded.
  // 2/20/2002-PYW-When displaying bitmap take into account colline and rowlines.
  // 3/3/2002-PYW-Don't showeditor if this is the right mouse button.
  // 3/18/2002 - Make sure top line is drawn.
  // 4/4/2002 -PYW- Check if Scrollbar has moved.  If so, then need to call DoTopROwChanged.
  // 4/9/2002 -PYW - Preserve Cursor before URLPaint
  // 5/9/2002 - PYW - Need to handle exception or hook raises it and it closes form.
  // 6/17/02 - Allow transparent image when using alternating colors in grid
  // 7/16/02 - Fixed bug where 1st horintal line in fixed column for 1st row
  //           was previously missing when dgTitles was false
  // 9/17/02 Allow fixed column to update correctly
  // 10/31/02 - Avoid ADO bug in BookmarkValid generating exception when no records
  // 4/2/03 - Check toprow and rowchanged as previosly didn't fire these events when paging up/down from navigator
  // 4/15/03 - Fix bidi mode alignment problem with footer
  // 4/16/03 Start offset at bottom of grouping label in fixed area
  // 4/17/03 - Allow IME editor to handle keystrokes
  // 4/17/03 - Support righttoleft hint
  // 4/25/03 - Ditto direction not previously passed so only supported dittoprior
  // 4/25/03 - Ditto Attributes - Not persistent before so didn't show up in object inspector
  // 5/9/03 - Prevent index out of range if ACol<0 when Titlebuttons is true with themes
  // 5/17/03 - Respect DefaultDrawContents for custom controls
  // 9/3/03 - Fix line for grouping where top line was left
  // 9/3/03 - Make case insensitive for GroupFieldName
  // 9/10/03 - Support bidi-mode with special handling for numerics being reversed
  // 3/23/04 - Still paint for checkbox
  // 7/8/04 - Check datasource is valid first in DoAfterDrawCell
  // 8/20/04 - As suggested by Eyal Zvi
  // 4/30/07 - Fix multi-select paint bug with themes enabled (when control has focus).
  // 7/31/07 - Fix problem with TitleFont Color being ignored.
}
unit vcl.wwdbigrd;
{$R-}
{$I wwIfDef.pas}

interface

uses
  GraphUtil, // TGradientDirection
  SysUtils, Windows, Messages, Classes, Controls, Forms,
  Graphics, Menus, StdCtrls, DB, Grids, DBCtrls,
  wwdbdatetimepicker, wwgridfilter, themes,
  RTLConsts, wwtreeview,
{$IFNDEF GRIDESSENTIALS}
  wwriched, wwpaintoptions,
{$ENDIF}
  wwStr, wwdbedit, wwtypes, buttons, wwlocate, wwsystem, extctrls,
  system.Types, system.UITypes;
// const icBlack = clBlack;
// icYellow = clYellow;
type
  TwwCustomDBGrid = class;

  TwwEditControlOption = (ecoCheckboxSingleClick, ecoSearchOwnerForm,
    ecoDisableCustomControls, ecoDisableDateTimePicker,
    ecoDisableEditorIfReadOnly);
  TwwEditControlOptions = set of TwwEditControlOption;

  TwwDittoDirection = (wwDittoPrior, wwDittoNext, wwDittoPriorOrNext);
  TwwDittoOption = (wwdoSkipBlobFields, wwdoSkipReadOnlyFields,
    wwdoSkipHiddenFields);
  TwwDittoOptions = Set of TwwDittoOption;

  TwwDittoAttributes = class(TPersistent)
    // 4/25/03 - Not persistent before so didn't show up in object inspector
  private
    FDittoDirection: TwwDittoDirection;
    FShortCutDittoField: TShortCut;
    FShortCutDittoRecord: TShortCut;
    FOptions: TwwDittoOptions;
  published
    property DittoDirection: TwwDittoDirection read FDittoDirection
      write FDittoDirection default wwDittoPrior;
    property ShortCutDittoField: TShortCut read FShortCutDittoField
      write FShortCutDittoField default 0;
    property ShortCutDittoRecord: TShortCut read FShortCutDittoRecord
      write FShortCutDittoRecord default 0;
    property Options: TwwDittoOptions read FOptions write FOptions default [];
  end;

  TwwGridSearchEditor = class(TwwDBEdit)
  protected
    procedure DoExit; override;
  public
    FieldName: string;
    Column: integer;
  end;

  TwwSelectColumnsTreeNode = class(TwwTreeNode)
  private
    FFieldName: string;
    FIsCategory: boolean;
  public
    property FieldName: string read FFieldName write FFieldName;
    property IsCategory: boolean read FIsCategory write FIsCategory;
  end;

  TwwSelectColumnsTreeView = class(TwwTreeView)
  private
    FGrid: TCustomGrid;
  protected
    function CreateNode: TwwTreeNode; override;
  public
    procedure AddField(NodeGroups: string; FieldName: string);
    property Grid: TCustomGrid read FGrid write FGrid;
  end;

  TwwSortFilterOption = (sfoSortAscending, sfoSortDescending, sfoFilter,
    sfoGrouping, sfoSelectColumns, sfoCreateIndexes, sfoAutoTitleButtonSort,
    sfoClientCursor, sfoUseCurrentValueForFilter, sfoAllowNullFilters);
  TwwSortFilterOptions = set of TwwSortFilterOption;

  TwwTitleMenuAttributes = class(TPersistent)
  private
    FOptions: TwwSortFilterOptions;
    FMenuEnabled: boolean;
    FGrid: TCustomGrid;

    procedure SetOptions(value: TwwSortFilterOptions);
    procedure SetMenuEnabled(value: boolean);
  public
    constructor Create(AGrid: TCustomGrid); virtual;
    function TitleMenuEnabled: boolean; virtual;
  published
    property Options: TwwSortFilterOptions read FOptions write SetOptions
      default [sfoSortAscending, sfoFilter, sfoCreateIndexes,
      sfoAutoTitleButtonSort];
    property MenuEnabled: boolean read FMenuEnabled write SetMenuEnabled
      default false;
  end;

  TwwGridHintWindow = class(THintWindow)
  protected
    procedure Paint; override;
  public
    Grid: TwwCustomDBGrid;
    Field: TField;
    WordWrap: boolean;
    Alignment: TAlignment;
  end;

  TwwTitleImageAttributes = record
    ImageIndex: integer;
    Alignment: TAlignment;
    Margin: integer;
    IsGroupHeader: boolean;
  end;

  TTitleButtonClickEvent = procedure(Sender: TObject; AFieldName: string)
    of object;
  TCalcCellColorsEvent = procedure(Sender: TObject; Field: TField;
    State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush)
    of object;
  TCalcTitleAttributesEvent = procedure(Sender: TObject; AFieldName: string;
    AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment) of object;

  TwwDrawTitleCellEvent = procedure(Sender: TObject; Canvas: TCanvas;
    Field: TField; Rect: TRect; var DefaultDrawing: boolean) of object;

  TwwDrawGroupHeaderCellEvent = procedure(Sender: TObject; Canvas: TCanvas;
    GroupHeaderName: string; Rect: TRect; var DefaultDrawing: boolean)
    of object;

  TwwCalcTitleImageEvent = procedure(Sender: TObject; Field: TField;
    var TitleImageAttributes: TwwTitleImageAttributes) of object;

  TDrawFooterCellEvent = procedure(Sender: TObject; Canvas: TCanvas;
    FooterCellRect: TRect; Field: TField; FooterText: string;
    var DefaultDrawing: boolean) of object;

  TColWidthChangedEvent = procedure(Sender: TObject; Column: integer) of object;

  TAllowColResizeEvent = procedure(Sender: TObject; Column: integer;
    var Accept: boolean) of object;

  TwwLeftColChangedEvent = procedure(Sender: TObject; NewLeftCol: integer)
    of object;

  TwwCreateGridHintWindowEvent = procedure(Sender: TObject;
    HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
    var WordWrap: boolean; var MaxWidth, MaxHeight: integer;
    var DoDefault: boolean) of object;

  TwwOnCanShowCustomControlEvent = procedure(Sender: TObject;
     Control: TWinControl; Field: TField; var canShow: boolean) of object;

  TwwOnInitSelectColumnsDialogEvent = procedure(Form: TCustomForm;
    TreeView: TwwSelectColumnsTreeView; var DoDefault: boolean) of object;

  TwwBeforeSortEvent = procedure(Sender: TObject; AFieldName: string;
    SortDescending: boolean; var DoDefault: boolean) of object;
  TwwSortEvent = procedure(Sender: TObject; AFieldName: string;
    SortDescending: boolean) of object;
  TwwCanSortEvent = procedure(Sender: TObject; AFieldName: string;
    SortDescending: boolean; var CanSort: boolean) of object;
  TwwCanFilterEvent = procedure(Sender: TObject; AFieldName: string;
    var CanFilter: boolean) of object;
  TwwCanGroupEvent = procedure(Sender: TObject; AFieldName: string;
    var CanGroup: boolean) of object;
  TwwBeforeTitleMenuEvent = procedure(Sender: TObject; AFieldName: string;
    var DoDefault: boolean) of object;
  TwwBeforeColumnAddEvent = procedure(Sender: TObject; AFieldName: string;
    insertBefore: boolean; var DoDefault: boolean) of object;

  TwwBeforeGetFilterRangeEvent = procedure(Sender: TObject; AFieldName: string;
    var ADisplayLabel: string; var RangeStart, RangeEnd: string;
    var doDefaultDialog: boolean; var ApplyFilter: boolean) of object;

  TwwBeforeGetFilterValueEvent = procedure(Sender: TObject; AFieldName: string;
    var ADisplayLabel: string; var FilterValue: string;
    var doDefaultDialog: boolean; var ApplyFilter: boolean) of object;

  TwwColumn = class;

  TwwAddSelectColumnEvent = procedure(Sender: TObject; AField: TField;
    var NodeGroups: string; var canAdd: boolean) of object;

  TwwCanShowTitleDropDownEvent = procedure(Sender: TObject; AFieldName: string;
    var CanShow: boolean) of object;
  TwwQuerySortFieldEvent = procedure(Sender: TObject; var SortFieldName: string;
    var IsDescending: boolean) of object;
  TwwPopupTitleDropDownEvent = procedure(Sender: TObject; PopupMenu: TPopupMenu)
    of object;

  TwwMultiSelectOption = (msoAutoUnselect, msoShiftSelect);
  TwwMultiSelectOptions = set of TwwMultiSelectOption;
  TwwFieldChangedEvent = procedure(Sender: TObject; Field: TField) of object;

  TwwGridDataLink = class(TDataLink)
  private
    FGrid: TwwCustomDBGrid;
    FFieldCount: integer;
    FFieldMapSize: integer;
    FModified: boolean;
    FInUpdateData: boolean;
    FFieldMap: Pointer;
    function GetDefaultFields: boolean;
    function GetFields(I: integer): TField;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create(AGrid: TwwCustomDBGrid);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property DefaultFields: boolean read GetDefaultFields;
    property FieldCount: integer read FFieldCount;
    property Fields[I: integer]: TField read GetFields;
    property isFieldModified: boolean read FModified;
  end;

  TwwDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect,
    { dgRowSelectEditable, }
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap,
    dgPerfectRowFit, dgMultiSelect, dgShowFooter, dgFooter3DCells,
    dgNoLimitColSize, dgTrailingEllipsis, dgShowCellHint, dgTabExitsOnLastCol,
    dgFixedResizable, dgFixedEditable, dgProportionalColResize, dgRowResize,
    dgRowLinesDisableFixed, dgColLinesDisableFixed, dgFixedProportionalResize,
    dgHideBottomDataLine, dgDblClickColSizing, dgDisableColumnReorder);
  TwwDBGridOptions = set of TwwDBGridOption;
  TwwDBGridKeyOption = (dgEnterToTab, dgAllowDelete, dgAllowInsert);
  TwwDBGridKeyOptions = set of TwwDBGridKeyOption;
  TwwDrawDataCellEvent = procedure(Sender: TObject; const Rect: TRect;
    Field: TField; State: TGridDrawState) of object;

  TwwCustomDrawGridCellInfo = class
    Rect: TRect;
    Field: TField;
    State: TGridDrawState;
    DataCol, DataRow: integer;
    DefaultDrawBackground: boolean;
    DefaultDrawHorzTopLine: boolean;
    DefaultDrawHorzBottomLine: boolean;
    DefaultDrawContents: boolean;
  end;

  TwwCustomDrawCellEvent = procedure(Sender: TwwCustomDBGrid;
    DrawCellInfo: TwwCustomDrawGridCellInfo) of object;

  TIndicatorColorType = (icBlack, icYellow);
  TwwBitmapSizeType = (bsOriginalSize, bsStretchToFit, bsFitHeight, bsFitWidth);

  TwwIButton = class(TSpeedButton)
  public
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    procedure Loaded; override;
    procedure Paint; override;
  end;

  TwwInplaceEdit = class(TInplaceEdit)
  private
    FwwPicture: TwwDBPicture;
    FRegexMask: TwwRegexMask;

    FWordWrap: boolean;
    ParentGrid: TwwCustomDBGrid;
    FUsePictureMask: boolean;

    OrigForeColor: TColor;
    OrigBackColor: TColor;

    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMPaste(var Message: TMessage); message WM_PASTE; { 10/28/96 }
    procedure WMCut(var Message: TMessage); message WM_CUT;

  protected
    procedure BoundsChanged; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure SetWordWrap(val: boolean);
    procedure UpdateContents; override;
  public
    constructor wwCreate(AOwner: TComponent; dummy: integer); virtual;
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

  // For filterdialog and new grid filtering
  {
    TwwFilterGridMatchType = (fdgMatchStart, fdgMatchAny, fdgMatchExact,
    fdgMatchEnd, fdgMatchRange, fdgMatchNone);
    TwwFilterGridInfo = class
    public
    FieldName: string;
    DisplayLabel: string;
    MatchType: TwwFilterGridMatchType;
    FilterValue: string;
    MinValue: string;
    MaxValue: string;
    CaseSensitive: boolean;
    NonMatching: boolean;
    end;
  }

  TwwColumn = class
  private
    FFieldName: string;
    Grid: TwwCustomDBGrid;
    FFooterValue: string;
    FGroupName: string;
    FDisableSizing: boolean;
    FSearchValue: string;
    FVisible: boolean;
    FDisplayWidth: integer;
    FDisplayLabel: string;
    // FFilterInfo: TwwFilterGridInfo;
    function GetReadOnly: boolean;
    function GetDisplayLabel: string;
    function GetDisplayWidth: integer;
    function GetGroupName: string;
    function GetIndex: integer;
    procedure SetReadOnly(val: boolean);
    procedure SetDisplayLabel(val: string);
    procedure SetDisplayWidth(val: integer);
    procedure SetFooterValue(val: string);
    procedure SetGroupName(val: string);
    procedure SetSearchValue(val: string);
    procedure SetIndex(val: integer);
    function GetVisible: boolean;
    procedure SetVisible(val: boolean);

  public
    ColumnFlags: PByteArray;
    // array[0..255] of byte;  // Support max 256 rows for line groupings
    property FieldName: string read FFieldName;
    property ReadOnly: boolean read GetReadOnly write SetReadOnly;
    property DisplayLabel: string read GetDisplayLabel write SetDisplayLabel;
    property DisplayWidth: integer read GetDisplayWidth write SetDisplayWidth;
    property FooterValue: string read FFooterValue write SetFooterValue;
    property GroupName: string read GetGroupName write SetGroupName;
    property DisableSizing: boolean read FDisableSizing write FDisableSizing;
    property SearchValue: string read FSearchValue write SetSearchValue;
    property Index: integer read GetIndex write SetIndex;
    property Visible: boolean read GetVisible write SetVisible;

    // property FilterInfo: TwwFilterGridInfo read FFilterInfo;
    constructor Create(AOwner: TComponent; AFieldName: string);
    destructor Destroy; override;
    procedure InsertBeforeColumn(FieldName: string);
    procedure InsertAfterColumn(FieldName: string);

    procedure MakeVisible(val: boolean);
  end;

  TwwGridURLOpenEvent = procedure(Sender: TObject; var URLLink: string;
    Field: TField; var UseDefault: boolean) of object;
  TwwPadColumnStyle = (pcsPlain, pcsPadHeader, pcsPadHeaderAndData);

  TwwCacheColInfoItem = class
    CustomControl: TWinControl;
    ControlType: string;
    ControlData: string;
    AlwaysPaints: boolean;
    IsWhiteBackground: boolean;
    // PaintedBrushColor: TColor;
  end;

  TwwGridLineStyle = (glsSingle, gls3D, glsDynamic);

  TwwGridLineColors = class(TPersistent)
  private
    FDataColor: TColor;
    FHighlightColor: TColor;
    FShadowColor: TColor;
    FFixedColor: TColor;
    FGroupingColor: TColor;
    FGrid: TwwCustomDBGrid;
    procedure SetDataColor(val: TColor);
    procedure SetHighlightColor(val: TColor);
    procedure SetShadowColor(val: TColor);
    procedure SetFixedColor(val: TColor);
    procedure SetGroupingColor(val: TColor);
  published
    property DataColor: TColor read FDataColor write SetDataColor
      default clSilver;
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor
      default clBtnHighlight;
    property ShadowColor: TColor read FShadowColor write SetShadowColor
      default clBtnShadow;
    property FixedColor: TColor read FFixedColor write SetFixedColor
      default clBlack;
    property GroupingColor: TColor read FGroupingColor write SetGroupingColor
      default clBlack;

  end;

  TwwDittoEvent = procedure(Sender: TObject; DataSet: TDataSet; Field: TField;
    var DittoValue: string; var AllowDitto: boolean) of object;

  TwwBookmarkList = class
  private
    FList: array of TBookmark;
    FGrid: TwwCustomDBGrid;
    FCache: TBookmark;
    FCacheIndex: integer;
    FCacheFind: boolean;
    FLinkActive: boolean;
    function GetCount: integer;
    function GetCurrentRowSelected: boolean;
    function GetItem(Index: integer): TBookmark;
    procedure InsertItem(Index: integer; Item: TBookmark);
    procedure DeleteItem(Index: integer);
    procedure SetCurrentRowSelected(value: boolean);
    // procedure BookmarksChanged;
    procedure DataChanged(Sender: TObject);

  protected
    function CurrentRow: TBookmark;
  public
    constructor Create(AGrid: TwwCustomDBGrid);
    function Compare(const Item1, Item2: TBookmark): integer;
    procedure DeleteSelection(Index: integer);
    destructor Destroy; override;
    procedure Clear; // free all bookmarks
    procedure Delete; // delete all selected rows from dataset
    function Find(const Item: TBookmark; var Index: integer): boolean;
    function IndexOf(const Item: TBookmark): integer;
    function Refresh: boolean; // drop orphaned bookmarks; True = orphans found
    procedure LinkActive(value: boolean);

    property Count: integer read GetCount;
    property CurrentRowSelected: boolean read GetCurrentRowSelected
      write SetCurrentRowSelected;
    property Items[Index: integer]: TBookmark read GetItem; default;
  end;

  TwwCustomDBGrid = class(TCustomGrid)
  private
    FGroupFieldName: string; // Data value Grouping
    FOnDitto: TwwDittoEvent;
    FDittoAttributes: TwwDittoAttributes;
    FTitleMenuAttributes: TwwTitleMenuAttributes;
    FOnInitSelectColumnsDialog: TwwOnInitSelectColumnsDialogEvent;
    FOnCanShowCustomControl: TwwOnCanShowCustomControlEvent;

    FShowHorzScrollBar: boolean;
    FOnBeforePaint: TNotifyEvent;
    FSelected: TStrings;
    FLineColors: TwwGridLineColors;
    // FDataLineColor:TColor;
    FTitleFont: TFont;
    FTitleColor: TColor;
    FFooterColor: TColor;
    FFooterCellColor: TColor;
    FFooterHeight: integer;
    FReadOnly: boolean;
    FUserChange: boolean;
    // FDataChanged: Boolean;
    // FEditRequest: Boolean;
    FUpdatingColWidths: integer;
    FOptions: TwwDBGridOptions;
    FKeyOptions: TwwDBGridKeyOptions;
    FTitleOffset: Byte;
    FUpdateLock: Byte;
    FInColExit: boolean;
    FDefaultDrawing: boolean;
    FSelfChangingTitleFont: boolean;
    FSelRow: integer;
    FDataLink: TwwGridDataLink;
    // FVDataLink: TwwGridDataLink;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnDrawDataCell: TwwDrawDataCellEvent;
    FOnCalcCellColors: TCalcCellColorsEvent;
    FOnCalcTitleAttributes: TCalcTitleAttributesEvent;
    FOnDrawTitleCell: TwwDrawTitleCellEvent;
    FOnDrawGroupHeaderCell: TwwDrawGroupHeaderCellEvent;
    FOnCalcTitleImage: TwwCalcTitleImageEvent;
    FOnTitleButtonClick: TTitleButtonClickEvent;
    FOnCheckValue: TwwValidateEvent;
    FOnTopRowChanged: TNotifyEvent;
    FOnRowChanged: TNotifyEvent;
    FOnCellChanged: TNotifyEvent;
    FOnLeftColChanged: TwwLeftColChangedEvent;
    FEditText: string;
    FIndicatorColor: TIndicatorColorType;
    FIndicatorIconColor: TColor;
    FTitleAlignment: TAlignment;
    FRowHeightPercent: integer;
    FTitleLines: integer;
    FShowVertScrollBar: boolean;
    FOnColumnMoved: TMovedEvent;
    FOnColWidthChanged: TColWidthChangedEvent;
    FOnAllowColResize: TAllowColResizeEvent;
    FTitleButtons: boolean;
    FEditCalculated: boolean;
    FUseTFields: boolean;
    FIndicatorWidth: integer;
    FIndicatorButton: TwwIButton;
    FImageList: TImageList;
    FTitleImageList: TImageList;
    FOnDrawFooterCell: TDrawFooterCellEvent;
    FOnFieldChanged: TwwFieldChangedEvent;
    FOnUpdateFooter: TNotifyEvent;
    FOnCreateHintWindow: TwwCreateGridHintWindowEvent;
    FOnURLOpen: TwwGridURLOpenEvent;
    // FOnValidationErrorUsingMask: TwwPictureValidationError;
    FSavePrevGridWidth: integer;
    FHideAllLines: boolean;
    FSavedCursor: TCursor; // 4/9/2002 -PYW - Preserve Cursor before URLPaint

    URLLinkActiveRow: integer;
    URLLinkActiveCol: integer;
    InUpdateRowCount: boolean;
    FCalcCellRow, FCalcCellCol: integer;
    IsWhiteBackground: boolean;
    isDrawFocusRect: boolean;
    SkipLineDrawing: boolean;
    TitleClickColumn: integer;
    TitleClickRow: integer;
    TitleClickGroupTitle: boolean;
    // PYW - Added to determine if the enduser clicked on the TitleGroup button or the Title SubGroup Buttons.
    MouseOverGroupTitle: boolean;
    MouseOverGroupChild: boolean;
    FMultiSelectOptions: TwwMultiSelectOptions;
    DisableCellChangedEvent: boolean;
    ColItems: TList;
    SavedColItems: TList;

    { Suport drag/drop of titles }
    UseDragCanvas: boolean;
    CaptureTitleBitmap: TBitmap;
    FDragVertOffset: integer;
    SkipTitleButtonClick: boolean;

    FControlType: TStrings;
    FControlInfoInDataset: boolean;
    FPictureMasks: TStrings;
    FRegexMasks: TStrings;
    FPictureMaskFromDataSet: boolean;
    CallColEnter: boolean;
    LastBookmark, LastMasterBookmark: TBookmark;
    TempLastCol: integer;
    { Used when dataset is made active to fire ColEnter only once }
    ShouldUpdateFooter: boolean;
    DummyColumn: TwwColumn;

    lastMouseX, lastMouseY: integer;
    titleLastMouseX, titleLastMouseY: integer;
    HintTimer: TTimer;
    HintTimerCount: integer;
    FUpdateCount: integer;
    FPadColumnStyle: TwwPadColumnStyle;
    FPaintCanvas: TCanvas;
    FPaintBitmap: TBitmap;
    // Membitmap: HBitmap;
    // UseTempCanvas: boolean;
    FEditControlOptions: TwwEditControlOptions;
{$IFNDEF GRIDESSENTIALS}
    FPaintOptions: TwwGridPaintOptions;
{$ENDIF}
    UpdateRect: TRect;
    ChangedBrushColor: boolean;
    ChangedFontColor: boolean;
    AlternatingEven: boolean;
    FSizingIndex: integer;
    FPriorSizingWidth: integer;
    FRowOffset: integer;
    FLineStyle: TwwGridLineStyle;

    ClickedOnGroupName: boolean;
    ClickedOnGroupChild: boolean;
    PaintingSearchCell: boolean;
    FCompareBookmarksAltMethod: boolean;
    FOnBeforeDrawCell: TwwCustomDrawCellEvent;
    FOnAfterDrawCell: TwwCustomDrawCellEvent;
    FDisableThemesInTitle: boolean;
    // FSortFilterInCaption: boolean;
    FShowSearchRow: boolean;
    FSearchEditor: TwwGridSearchEditor;
    FSearchMode: boolean;

    FOnBeforeSort: TwwBeforeSortEvent;
    FOnAfterSort: TwwSortEvent;
    FOnCanSort: TwwCanSortEvent;
    FOnCanFilter: TwwCanFilterEvent;
    FOnCanGroup: TwwCanGroupEvent;
    FOnCanShowTitleDropDown: TwwCanShowTitleDropDownEvent;
    FOnQuerySortField: TwwQuerySortFieldEvent;
    FOnPopupTitleDropDown: TwwPopupTitleDropDownEvent;
    FOnBeforeGroup: TwwBeforeTitleMenuEvent;
    FOnBeforeClearGroup: TwwBeforeTitleMenuEvent;
    FOnBeforeColumnRemove: TwwBeforeTitleMenuEvent;
    FOnBeforeColumnAdd: TwwBeforeColumnAddEvent;
    FOnAddSelectColumn: TwwAddSelectColumnEvent;
    FOnBeforeGetFilterRange: TwwBeforeGetFilterRangeEvent;
    FOnBeforeGetFilterValue: TwwBeforeGetFilterValueEvent;

    class constructor Create;
    Function HaveActiveRecordColor: boolean;
    Function HaveAlternatingRowColor: boolean;

    function CalcCoordFromPoint(X, Y: integer; const DrawInfo: TGridDrawInfo)
      : TGridCoord;
    procedure SetRowOffset(value: integer);
    // FFocused: boolean;

    procedure SetUseTFields(val: boolean);
    Function GetPictureControl: TComponent;
    procedure HintTimerEvent(Sender: TObject);
    procedure MouseLoop_DragColumn(HitTest: integer; X, Y: integer);
    Function IsScrollBarVisible: boolean;
    function AcquireFocus: boolean;
    procedure EditingChanged;
    // function Edit: Boolean;
    function GetDataSource: TDataSource;
    function GetFieldCount: integer;
    function GetFields(Index: integer): TField;
    function GetSelectedField: TField;
    function GetSelectedIndex: integer;
    procedure RecordChanged(Field: TField);
    procedure FieldChanged(Field: TField);
    procedure SetDataSource(value: TDataSource);
    procedure SetOptions(value: TwwDBGridOptions);
    procedure SetSelectedField(value: TField);
    procedure SetSelectedIndex(value: integer);
    procedure SetTitleFont(value: TFont);
    procedure SetIndicatorIconColor(value: TColor);
    procedure SetTitleAlignment(sel: TAlignment);
    procedure SetTitleLines(sel: integer);
    procedure SetRowHeightPercent(sel: integer);
    Procedure SetShowVertScrollBar(val: boolean);
    Procedure SetTitleButtons(val: boolean);
    Function GetShowHorzScrollBar: boolean;
    Procedure SetShowHorzScrollBar(val: boolean);
    function GetSelectedFields: TStrings;
    procedure SetSelectedFields(sel: TStrings);
    { Procedure SetWordWrap(val: boolean); }

    function GetColWidthsPixels(Index: Longint): integer; { 4/23/97 }
    procedure SetColWidthsPixels(Index: Longint; value: integer); { 4/23/97 }
    procedure SetIndicatorWidth(val: integer);

    procedure TitleFontChanged(Sender: TObject);
    procedure UpdateData; // virtual;
    procedure UpdateActive; // virtual;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentFontChanged(var Message: TMessage);
      message CM_PARENTFONTCHANGED;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest);
      message CM_DESIGNHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMRButtonDown(var Message: TWMRButtonDown);
      message WM_RBUTTONDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
{$IFDEF wwdelphi4up}
    procedure CMShowingChanged(var Message: TMessage);
      message CM_SHOWINGCHANGED;
{$ENDIF}
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GetFastColumn(Index: integer): TwwColumn;
    function GetColumn(Index: integer): TwwColumn;
    procedure SetFooterColor(sel: TColor);
    procedure SetFooterCellColor(sel: TColor);
    procedure SetFooterHeight(val: integer);
    // function GetColumnByName(Index: string): TwwColumn;
    function GetCanvas: TCanvas;
    procedure SetPictureMasks(val: TStrings);
    procedure SetRegexMasks(val: TStrings);
    procedure SetControlType(val: TStrings);
    procedure SetUpdateState(Updating: boolean);
    procedure InheritedPaint;
    procedure SetIndicatorColor(value: TIndicatorColorType);
    function GetCalcCellRow: integer;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    { procedure ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal;
      UseRightToLeft: Boolean);
      function CalcMaxTopLeft(const Coord: TGridCoord;
      const DrawInfo: TGridDrawInfo): TGridCoord;
    }
    function CalcMaxTopLeft(const Coord: TGridCoord;
      const DrawInfo: TGridDrawInfo): TGridCoord;
    procedure SetGroupFieldName(value: string);
    function GetGroupFieldName: string;
    procedure SetShowSearchRow(value: boolean);
    // procedure SetSortFilterInCaption(Value: boolean);
  protected
    FCacheColInfo: TList; // PwwCustomControlItem;
    FTopRecord: integer;
    FIndicatorOffset: Byte;
{$IFNDEF GRIDESSENTIALS}
    TempRichEdit: TwwDBRichEdit;
{$ENDIF}
    FUpdateFields: boolean;
    FAcquireFocus: boolean;
    SuppressShowEditor: boolean;
    ShiftSelectMode: boolean;
    ShiftSelectBookmark: TBookmark;
    dummy1, dummy2: string;
    TitleTextOffset: integer;
    FieldMappedText: boolean;
    URLLinkActive: boolean;
    // RichEditBufferList: TStrings;
    HintWindow: THintWindow;
    OrigColWidths: PWordArray;
    OrigColWidthsCount: integer;
    DrawCellInfo: TwwCustomDrawGridCellInfo;
{$IFDEF wwDelphi4Up}
    SkipErase: boolean;
    { 1/26/99 - Prevent clearing of grid when hiding controls }
{$ENDIF}
    CurrentCustomEdit: TWinControl;
    FDateTimePicker: TwwDBCustomDateTimePicker;
    FFocused: boolean;

    function UseAlternateBuffering: boolean; virtual;
    function GetGridDataBottom(DrawInfo: TGridDrawInfo): integer; virtual;
//    Procedure PaintCustomControl(control: TWinControl; tempField: TField;
//       ARect: TRect);
    procedure ResetTitleClick;
    procedure UpdateLeftCol(ACol: integer);
    procedure ShowEditor; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MoveCol(ACol: integer);
    procedure DoCreateHintWindow(HintWindow: TwwGridHintWindow; AField: TField;
      R: TRect; var WordWrap: boolean; var MaxWidth, MaxHeight: integer;
      var DoDefault: boolean); virtual;
    Function IsProportionalColumns: boolean; virtual;
    // procedure InitIndicators;
    procedure DoURLOpen(var URLLink: string; Field: TField;
      var UseDefault: boolean); virtual;
    Function IsDropDownGridFocused: boolean;
    Function IsDropDownGridShowing: boolean;
    procedure FillWithAlternatingRowBitmap(TempRect: TRect); virtual;
    procedure LayoutChanged; virtual;
    procedure CalcRowHeight; dynamic;
    function RecordCountIsValid: boolean;
    // function CalcVariableRowCount: integer; virtual;
    Function AllowCancelOnExit: boolean; dynamic;
    function CanEditAcceptKey(Key: Char): boolean; override;
    function CanEditModify: boolean; override;
    function GetEditLimit: integer; override;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure ColEnter; dynamic;
    procedure ColExit; dynamic;
    procedure Scroll(Distance: integer); virtual;
    procedure ColWidthsChanged; override;
    function HighlightCell(DataCol, DataRow: integer; const value: string;
      AState: TGridDrawState): boolean; virtual;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;

    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const value: string); override;
    function GetColField(ACol: integer): TField;
    function GetFieldValue(ACol: integer): string; dynamic; // obsolete
    procedure DefineFieldMap; virtual;
    procedure DrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); dynamic;
    procedure ProportionalColWidths; virtual;
    procedure SetColumnAttributes; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure LinkActive(value: boolean); virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    function TitleImageRect(ACol: integer): TRect; virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure TimedScroll(Direction: TGridScrollDirection); override;
    procedure CreateWnd; override;
    function IsWWControl(ACol, ARow: integer): boolean; virtual;
    procedure InvalidateTitle; virtual;

    property DefaultDrawing: boolean read FDefaultDrawing write FDefaultDrawing
      default True;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    { W2W }
    property ParentColor default false;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
    property TitleColor: TColor read FTitleColor write FTitleColor
      default clBtnFace;
    // property DataLineColor: TColor read FDataLineColor write FDataLineColor default clSilver;
    property FooterColor: TColor read FFooterColor write SetFooterColor
      default clBtnFace;
    property FooterCellColor: TColor read FFooterCellColor
      write SetFooterCellColor default clBtnFace;
    property FooterHeight: integer read FFooterHeight write SetFooterHeight
      default 0;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
    property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
    property OnDrawDataCell: TwwDrawDataCellEvent read FOnDrawDataCell
      write FOnDrawDataCell;
    procedure DoTitleButtonClick(AFieldName: string); virtual;
    procedure DoDrawTitleCell(ACanvas: TCanvas; Field: TField; ARect: TRect;
      var DefaultDrawing: boolean); virtual;
    procedure DoDrawGroupHeaderCell(ACanvas: TCanvas; GroupHeaderName: string;
      ARect: TRect; var DefaultDrawing: boolean); virtual;
    procedure DoCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
{$IFDEF wwdelphi4up} virtual; {$ENDIF}
{$IFDEF wwDelphi4Up}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint)
      : boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint)
      : boolean; override;
{$ENDIF}
    function UseRightToLeftAlignmentForField(const AField: TField;
      Alignment: TAlignment): boolean;
    procedure UpdateScrollBar;
    Function IsValidCell(ACol, ARow: integer): boolean;
    function DbCol(col: integer): integer;
    function DbRow(row: integer): integer;
    procedure Draw3DLines(ARect: TRect; ACol, ARow: integer;
      AState: TGridDrawState);
    Function CellColor(ACol, ARow: integer): TColor; virtual;
    procedure DrawCheckBox(ARect: TRect; ACol, ARow: integer;
      val: boolean); virtual;
    procedure DrawCheckBox_Checkmark(ARect: TRect; ACol, ARow: integer;
      val: boolean);
    procedure RefreshBookmarkList; virtual;
    function CreateEditor: TInplaceEdit; override;
    procedure HideControls; virtual;
    property OnColWidthChanged: TColWidthChangedEvent read FOnColWidthChanged
      write FOnColWidthChanged;
    property OnAllowColResize: TAllowColResizeEvent read FOnAllowColResize
      write FOnAllowColResize;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved
      write FOnColumnMoved;
    Procedure UnselectAll; virtual;
    Function IsSelectedCheckbox(ACol: integer): boolean;
    procedure DataChanged; virtual;
    Function IsSelectedRow(DataRow: integer): boolean; dynamic;
    procedure DoTopRowChanged; virtual;
    procedure DoRowChanged; virtual;
    procedure DoCellChanged; virtual;
    procedure DoCheckRowChanged; virtual;
    { Renamed property for C++ Builder conflicts }
    property IndicatorButtonWidth: integer read FIndicatorWidth
      write SetIndicatorWidth;
{$IFNDEF wwDelphi2008Up}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    procedure TopLeftChanged; override;
    function GetClientRect: TRect; override;
    procedure Paint; override;

    function GetControlType: TStrings;
    procedure GetControlInfo(AFieldName: string; var AControlType: string;
      var AParameters: string); virtual;
    procedure DoFieldChanged(Field: TField); virtual;
    procedure DoUpdateFooter; virtual;
    Function GetFooterRect: TRect; virtual;
    procedure CheckFooterUpdate; virtual;
    procedure MouseMove(Shift: TShiftState; AX, AY: integer); override;
    procedure FreeHintWindow; virtual;
    Function CreateHintWindow(AField: TField): THintWindow; virtual;
    procedure ValidationErrorUsingMask(Field: TField;
      Msg: string = ''); virtual;
    procedure ChangeOrientation(RightToLeftOrientation: boolean);
    procedure DrawLines; virtual;
    procedure PaintClickedTitleButton; virtual;
    function AdjustBoundsRect(ACurrentCustomEdit: TWinControl): boolean;
    procedure CalcSizingState(X, Y: integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure InitCacheColInfo; virtual;
    Function UseThemesInTitle: boolean;
    function IsShortCut(var Message: TWMKey): boolean;
    function GetSearchRowHeight: integer; virtual;
    function CreateSearchEditor: TwwGridSearchEditor; virtual;
    procedure UpdateSearchEditor(ACol: integer); virtual;
    procedure GridUpdateData; virtual;
    Procedure WriteTextLines(ACanvas: TCanvas; const ARect: TRect;
      DX, DY: integer; s: PWideChar; Alignment: TAlignment;
      WriteOptions: TwwWriteTextOptions); virtual;
    Procedure WriteTitleLines(ACanvas: TCanvas; const ARect: TRect;
      DX, DY: integer; s: PWideChar; Alignment: TAlignment;
      WriteOptions: TwwWriteTextOptions); virtual;

    procedure DoOnAfterDrawCell(var DrawCellInfo
      : TwwCustomDrawGridCellInfo); virtual;
    procedure DoOnBeforeDrawCell(ATextWide: WideString;
      var DrawCellInfo: TwwCustomDrawGridCellInfo); virtual;
    function WideGetFieldValue(ACol: integer): WideString; dynamic;
    procedure PaintCellBackground(ACol: integer; ARow: integer; ARect: TRect;
      AState: TGridDrawState); virtual;
    Procedure DoOnCanShowCustomControl(
      control: TWinControl;
      tempField: TField;
      var canShow: boolean); virtual;
  public
    FormGridFilterTypes: TwwFormGridFilterTypes;
    AlternatePaintBuffering: boolean;
    SkipHideControls: boolean;
    { IP Internal - Set by TwwDBLookupCombo DropDown method }
    SkipDataChange: boolean; { IP Internal - Set by TwwDBLookupComboDlg }
    AlwaysShowControls: boolean;
    { Undocumented: when true controls will display even when grid is readonly }
    // DragImages: TImageList;
    // Indicators: TImageList;
    MinRowHeightPercent: integer;
    // Original rowheightpercent before user changes it
{$IFDEF wwDelphi2008Up}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    function EffectiveTitleImageList: TImageList; virtual;

    // New method for testing if row is painted with an altenrating color.
    // Only applicable if PaintOptions.AlternatingRowColor is used.
    function IsAlternatingRow(DbRow: integer): boolean;

    // Return true if the row is being painted with the alternating color. This method also checks
    // to see if the properties are enabled for alternating row, where IsAlternatingRow does not check this
    function UseAlternatingRow(CurRelRow: integer): boolean;
    function UseAlternatingRowFixed(CurRelRow: integer): boolean;

    // procedure OnAfterSort(Field: TField; descending: boolean); virtual;
    // procedure OnBeforeSort(Field: TField; descending: boolean; var doDefault: boolean); virtual;
    procedure Sort(FieldName: string; descending: boolean); virtual;

    property GroupFieldName: string read GetGroupFieldName
      write SetGroupFieldName;
    // Data value Grouping
    property RowOffset: integer read FRowOffset write SetRowOffset;
    property TitleOffset: Byte read FTitleOffset;
    property CompareBookmarksAltMethod: boolean read FCompareBookmarksAltMethod
      write FCompareBookmarksAltMethod default false;

    // OriginalCellText: string;

    procedure FormGridFilterTypesNeeded;
    procedure FillWithBlendBitmap(TempRect: TRect; CurRelRow: integer;
      FillColor: TColor = clNone); virtual;
    procedure FillWithFixedBitmap(TempRect: TRect; CurRelRow: integer;
      FillColor: TColor = clNone); virtual;
    procedure UpdateCustomEdit;
    procedure ResetProportionalWidths;
    Function ShouldShowCustomControls: boolean;
    function CanEditGrid: boolean; virtual;
    procedure ClearURLPaint;
    Function ActiveExpandButton: TWinControl;
    procedure CalcDrawInfo(var DrawInfo: TGridDrawInfo); virtual;
    function HasFocus: boolean;
    // Return true if we or a child of us has the focus;
    function IsActiveRowAlternatingColor: boolean;
    procedure CollapseChildGrid;
    procedure AddField(FieldName: string; Position: integer = -1;
      Redraw: boolean = True);
    procedure RemoveField(FieldName: string; Redraw: boolean = True);

    Function HaveAnyRowLines: boolean;
{$IFDEF wwdelphi4up}
    function ExecuteAction(Action: TBasicAction): boolean; override; { 8/24/98 }
    function UpdateAction(Action: TBasicAction): boolean; override; { 8/24/98 }
{$ENDIF}
    procedure GetURLLink(value: string; var URLDisplayString: string;
      var URLLinkAddress: string); virtual;
    Procedure InvalidateCurrentRow;
    procedure InvalidateFooter;
    procedure FlushChanges; virtual;
    procedure UpdateRowCount;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    { public to allow child to send keys to parent }
    Procedure SizeLastColumn;
    procedure BeginUpdate;
    procedure EndUpdate(Repaint: boolean = false);
    function IsCustomEditCell(col, row: integer;
      var customEdit: TWinControl): boolean;
    function TitleCellRect(ACol, ARow: Longint; EntireTitle: boolean = false)
      : TRect; virtual;
    function SearchCellRect(ACol, ARow: Longint): TRect; virtual;
    function GroupNameCellRect(ACol, ARow: Longint;
      var StartCol, EndCol: Longint; VisibleOnly: boolean = True)
      : TRect; virtual;
    function DragTitleCellRect(ACol, X, Y: Longint): TRect; virtual;
    function CellRect(ACol, ARow: integer): TRect; virtual;
    procedure RestoreRowHeights;
    procedure ApplySelected; virtual;

    procedure DoOnAddSelectColumn(Field: TField; var NodeGroups: string;
      var canAdd: boolean); virtual; // Called by wwgridselectcolumns

    Procedure PaintActiveRowBackground(ACanvas: TCanvas; ARect: TRect);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsCheckBox(col, row: integer;
      var checkboxon, checkboxoff: string): boolean;
    Function IsMemoField(ACol, ARow: integer): boolean; virtual;
    // 11/30/2001 - Made isMemoField virtual method.
    Function IsSelected: boolean; dynamic;
    function AllowPerfectFit: boolean;
    Function DoPerfectFit: boolean;
    Function DoShrinkToFit: boolean;
    Procedure SelectRecord; virtual;
    Procedure UnselectRecord; virtual;
    Procedure SetPictureMask(FieldName: string; Mask: string);
    Procedure SetPictureAutoFill(FieldName: string; AutoFill: boolean);

    Procedure SetRegex(FieldName: string; Mask: string; CaseSensitive: boolean;
      ErrorMsg: string);
    Procedure ClearLastBookmarks;
    { 5/2/00 - Add method to clear last bookmark values }
    Function FieldName(ACol: integer): string;
    Function GetHighlightColor: TColor;
    function DittoField(SelectedField: TField;
      Direction: TwwDittoDirection = wwDittoPrior): boolean; virtual;
    // New method
    procedure ShowPopupEditor(Column: TwwColumn; X, Y: integer); virtual;

    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState);
    // 4/19/2001 - PYW - Moved so Exporting unit can call these events.
    procedure DoCalcTitleAttributes(AFieldName: string; AFont: TFont;
      ABrush: TBrush; var FTitleAlignment: TAlignment); virtual;
    procedure DoCalcCellColors(Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush); virtual;
    procedure DoCalcCellColorsDetect(Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush); virtual;
    Function XIndicatorOffset: integer;
    Function GetComponent(thisName: string): TWinControl;

    function GetEffectiveFooterHeight: integer;
    function ExecuteSelectGridColumnsDialog(curField: string;
      insertBefore: boolean = True): boolean; virtual;
    procedure DoInitSelectColumnsDialog(Form: TCustomForm); virtual;
    // 7/5/01 - Inherited MouseCoord does not work for Bide mode with fixed-editable
    function MouseCoord(X, Y: integer): TGridCoord;
    Procedure AutoSizeColumn(ACol: integer); // virtual; // 5/15/03

    function GetPriorRecordText(AFieldName: string; var AText: string): boolean;
    function GetNextRecordText(AFieldName: string; var AText: string): boolean;

    property DataLink: TwwGridDataLink read FDataLink;
    property RowHeights;
    property ColWidthsPixels[Index: Longint]: integer read GetColWidthsPixels
      write SetColWidthsPixels;
    property EditorMode;
    property FieldCount: integer read GetFieldCount;
    property Fields[Index: integer]: TField read GetFields;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: integer read GetSelectedIndex
      write SetSelectedIndex;
    property IndicatorColor: TIndicatorColorType read FIndicatorColor
      write SetIndicatorColor;
    property IndicatorIconColor: TColor read FIndicatorIconColor
      write SetIndicatorIconColor default clBlack;
    property Options: TwwDBGridOptions read FOptions write SetOptions
      default [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap
    { , dgVariableRowHeight } ];
    property KeyOptions: TwwDBGridKeyOptions read FKeyOptions write FKeyOptions
      default [dgAllowInsert, dgAllowDelete];
    property TitleAlignment: TAlignment read FTitleAlignment
      write SetTitleAlignment;
    property TitleLines: integer read FTitleLines write SetTitleLines;
    property OnCalcCellColors: TCalcCellColorsEvent read FOnCalcCellColors
      write FOnCalcCellColors;
    property OnCalcTitleAttributes: TCalcTitleAttributesEvent
      read FOnCalcTitleAttributes write FOnCalcTitleAttributes;
    property OnDrawTitleCell: TwwDrawTitleCellEvent read FOnDrawTitleCell
      write FOnDrawTitleCell;
    property OnDrawGroupHeaderCell: TwwDrawGroupHeaderCellEvent
      read FOnDrawGroupHeaderCell write FOnDrawGroupHeaderCell;
    property OnCalcTitleImage: TwwCalcTitleImageEvent read FOnCalcTitleImage
      write FOnCalcTitleImage;
    property OnTitleButtonClick: TTitleButtonClickEvent read FOnTitleButtonClick
      write FOnTitleButtonClick;
    property RowHeightPercent: integer read FRowHeightPercent
      write SetRowHeightPercent Default 100;
    property ShowVertScrollBar: boolean read FShowVertScrollBar
      write SetShowVertScrollBar default True;
    property ShowHorzScrollBar: boolean read GetShowHorzScrollBar
      write SetShowHorzScrollBar;
    property OnCheckValue: TwwValidateEvent read FOnCheckValue
      write FOnCheckValue;
    property OnTopRowChanged: TNotifyEvent read FOnTopRowChanged
      write FOnTopRowChanged;
    property OnRowChanged: TNotifyEvent read FOnRowChanged write FOnRowChanged;
    property OnCellChanged: TNotifyEvent read FOnCellChanged
      write FOnCellChanged;
    property OnLeftColChanged: TwwLeftColChangedEvent read FOnLeftColChanged
      write FOnLeftColChanged;
    property OnFieldChanged: TwwFieldChangedEvent read FOnFieldChanged
      write FOnFieldChanged;
    property OnUpdateFooter: TNotifyEvent read FOnUpdateFooter
      write FOnUpdateFooter;
    property CalcCellRow: integer read GetCalcCellRow; { onCalcCellColor Row }
    property CalcCellCol: integer read FCalcCellCol; { onCalcCellColor Column }
    property TitleButtons: boolean read FTitleButtons write SetTitleButtons;
    property EditCalculated: boolean read FEditCalculated write FEditCalculated
      default false;
    property MultiSelectOptions: TwwMultiSelectOptions read FMultiSelectOptions
      write FMultiSelectOptions default [];
    property Selected: TStrings read GetSelectedFields write SetSelectedFields;
    property UseTFields: boolean read FUseTFields write SetUseTFields
      default True;
    property IndicatorButton: TwwIButton read FIndicatorButton
      write FIndicatorButton stored false;
    property ImageList: TImageList read FImageList write FImageList;
    property TitleImageList: TImageList read FTitleImageList
      write FTitleImageList;
    property LineColors: TwwGridLineColors read FLineColors write FLineColors;

    property Columns[Index: integer]: TwwColumn read GetColumn;
    // write SetColumn;
    property FastColumns[Index: integer]: TwwColumn read GetFastColumn;
    // write SetColumn;
    Function ColumnByName(Index: String): TwwColumn;
    // read GetColumnByName; // write SetColumn;
    property OnDrawFooterCell: TDrawFooterCellEvent read FOnDrawFooterCell
      write FOnDrawFooterCell;
    property OnCreateHintWindow: TwwCreateGridHintWindowEvent
      read FOnCreateHintWindow write FOnCreateHintWindow;
    property OnBeforePaint: TNotifyEvent read FOnBeforePaint
      write FOnBeforePaint;
    property OnURLOpen: TwwGridURLOpenEvent read FOnURLOpen write FOnURLOpen;
    // property OnValidationErrorUsingMask: TwwPictureValidationError read FOnValidationErrorUsingMask write FOnValidationErrorUsingMask;

    property Canvas: TCanvas read GetCanvas;
    property DragVertOffset: integer read FDragVertOffset write FDragVertOffset
      default 15;

    property ControlInfoInDataset: boolean read FControlInfoInDataset
      write FControlInfoInDataset default True;
    property ControlType: TStrings read FControlType write SetControlType;
    property PictureMaskFromDataSet: boolean read FPictureMaskFromDataSet
      write FPictureMaskFromDataSet default True;
    property PictureMasks: TStrings read FPictureMasks write SetPictureMasks;
    property RegexMasks: TStrings read FRegexMasks write SetRegexMasks;
    property LeftCol;
    property PadColumnStyle: TwwPadColumnStyle read FPadColumnStyle
      write FPadColumnStyle default pcsPadHeaderAndData;
    property EditControlOptions: TwwEditControlOptions read FEditControlOptions
      write FEditControlOptions default [ecoSearchOwnerForm];
{$IFNDEF GRIDESSENTIALS}
    property PaintOptions: TwwGridPaintOptions read FPaintOptions
      write FPaintOptions;
    // SetPaintOptions;
{$ENDIF}
    property LineStyle: TwwGridLineStyle read FLineStyle write FLineStyle
      default glsDynamic;
    property HideAllLines: boolean read FHideAllLines write FHideAllLines
      default false;
    property OnBeforeDrawCell: TwwCustomDrawCellEvent read FOnBeforeDrawCell
      write FOnBeforeDrawCell;
    property OnAfterDrawCell: TwwCustomDrawCellEvent read FOnAfterDrawCell
      write FOnAfterDrawCell;
    property OnDitto: TwwDittoEvent read FOnDitto write FOnDitto;

    property OnBeforeMenuSort: TwwBeforeSortEvent read FOnBeforeSort
      write FOnBeforeSort;
    property OnAfterMenuSort: TwwSortEvent read FOnAfterSort write FOnAfterSort;
    property OnCanGroup: TwwCanGroupEvent read FOnCanGroup write FOnCanGroup;
    property OnCanSort: TwwCanSortEvent read FOnCanSort write FOnCanSort;
    property OnCanFilter: TwwCanFilterEvent read FOnCanFilter
      write FOnCanFilter;
    property OnCanShowTitleDropDown: TwwCanShowTitleDropDownEvent
      read FOnCanShowTitleDropDown write FOnCanShowTitleDropDown;
    property OnQuerySortField: TwwQuerySortFieldEvent read FOnQuerySortField
      write FOnQuerySortField;
    property OnPopupTitleDropDown: TwwPopupTitleDropDownEvent
      read FOnPopupTitleDropDown write FOnPopupTitleDropDown;
    property OnBeforeMenuGroup: TwwBeforeTitleMenuEvent read FOnBeforeGroup
      write FOnBeforeGroup;
    property OnBeforeMenuClearGroup: TwwBeforeTitleMenuEvent
      read FOnBeforeClearGroup write FOnBeforeClearGroup;
    property OnBeforeMenuColumnRemove: TwwBeforeTitleMenuEvent
      read FOnBeforeColumnRemove write FOnBeforeColumnRemove;
    property OnBeforeMenuColumnAdd: TwwBeforeColumnAddEvent
      read FOnBeforeColumnAdd write FOnBeforeColumnAdd;
    property OnAddSelectColumn: TwwAddSelectColumnEvent read FOnAddSelectColumn
      write FOnAddSelectColumn;
    property OnInitSelectColumnsDialog: TwwOnInitSelectColumnsDialogEvent
      read FOnInitSelectColumnsDialog write FOnInitSelectColumnsDialog;
    property OnBeforeMenuGetFilterRange: TwwBeforeGetFilterRangeEvent
      read FOnBeforeGetFilterRange write FOnBeforeGetFilterRange;
    property OnBeforeMenuGetFilterValue: TwwBeforeGetFilterValueEvent
      read FOnBeforeGetFilterValue write FOnBeforeGetFilterValue;

    property OnCanShowCustomControl: TwwOnCanShowCustomControlEvent
      read FOnCanShowCustomControl write FOnCanShowCustomControl;

    property VisibleRowCount;
    property DittoAttributes: TwwDittoAttributes read FDittoAttributes
      write FDittoAttributes;
    property TitleMenuAttributes: TwwTitleMenuAttributes
      read FTitleMenuAttributes write FTitleMenuAttributes;
    property DisableThemesInTitle: boolean read FDisableThemesInTitle
      write FDisableThemesInTitle default false;
    property ShowSearchRow: boolean read FShowSearchRow write SetShowSearchRow
      default false;
    // property SortFilterInCaption: boolean read FSortFilterInCaption write
    // SetSortFilterInCaption default False;
    property SearchEditor: TwwGridSearchEditor read FSearchEditor;
    property SearchMode: boolean read FSearchMode write FSearchMode
      default false;
  end;

  // TwwDBGridStyleHook = class(TStyleHook)
  // TwwDBGridStyleHook = class(TScrollingStyleHook)

  TwwDBGridStyleHook = class(TScrollingStyleHook)
  strict private
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBkgnd;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;

  protected
    procedure PaintNC(Canvas: TCanvas); override;
    procedure PaintBackground(Canvas: TCanvas); override;
    procedure DrawHorzScroll(DC: HDC); override;
    procedure DrawVertScroll(DC: HDC); override;

  public
    constructor Create(AControl: TWinControl); override;
  end;

  TwwUpdateSelected = (sptUpdateField, sptUpdateWidth, sptUpdateLabel,
    sptUpdateReadOnly, sptUpdateGroup, sptUpdateIndex, sptUpdateVisible);

procedure UpdateSelectedProp(Selected: TStrings; FieldName: string; val: string;
  SelectedProperty: TwwUpdateSelected; Index: integer = -1);

procedure UpdateSelectedPropWithGrid(Grid: TwwCustomDBGrid; Selected: TStrings;
  FieldName: string; val: string; SelectedProperty: TwwUpdateSelected;
  Index: integer = -1);

function GetSelectedProp(Selected: TStrings; FieldName: string;
  SelectedProperty: TwwUpdateSelected): string;

Procedure wwWriteTextLines(ACanvas: TCanvas; const ARect: TRect;
  DX, DY: integer; s: PChar; Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions);

function wwGetIndicators: TImageList;
function wwGetDefaultTitleImages: TImageList;

implementation

uses DBConsts, wwdblook,
{$IFDEF wwDelphi6Up}
  VDBConsts,
{$ENDIF}
  Consts, Dialogs, wwcommon, wwpict, wwintl, wwdbgrid, math, variants,
{$IFDEF ThemeManager}
  thememgr, themesrv, uxtheme,
{$ENDIF}
{$IFNDEF GRIDESSENTIALS}
  wwcheckbox,
{$ENDIF}
  shellapi, imglist, imm, wwgridselectcolumns;

{$R WWDBI32.RES}

const
  bmArrow = 'WWDBGARROW';
  bmEdit = 'WWDBEDIT';
  bmInsert = 'WWDBINSERT';
  bmMultiSelect = 'WWDBMULTISELECT';
  bmMultiArrow = 'WWDBMULTIARROW';
  bmArrowYellow = 'WWDBGARROWYELLOW';
  bmEditYellow = 'WWDBEDITYELLOW';
  bmInsertYellow = 'WWDBINSERTYELLOW';
  bmMultiSelectYellow = 'WWDBMULTISELECTYELLOW';
  bmMultiArrowYellow = 'WWDBMULTIARROWYELLOW';

  bmDropDown = 'WWTMDROPDOWN';
  bmSortAscending = 'WWSORTASCENDING';
  bmSortDescending = 'WWSORTDESCENDING';
  bmFiltered = 'WWFILTERED';
  bmFilteredAscending = 'WWFILTEREDASCENDING';
  bmFilteredDescending = 'WWFILTEREDDESCENDING';

  MaxMapSize = 65520 div SizeOf(integer);
  // GridScrollSize = 200;

  NormalPad = 2;

  ctmdNone = 0;
  ctmdForward = 1;
  ctmdBackward = 2;
  wwDisableDrawBottomLine = 1;
  wwDisableDrawHorzTopLine = 2;

var
  DragImages: TImageList;
  Indicators: TImageList;
  DefaultTitleImages: TImageList;
  UserCount: integer;

function wwGetIndicators: TImageList;
begin
  result := Indicators;
end;

procedure InitDefaultTitleImages;
var
  Bmp: TBitmap;
  tc: TColor;
  tc2: TColor;
begin
  DefaultTitleImages.Free;
  DefaultTitleImages := TImageList.CreateSize(16, 16);
  tc := clFuchsia;
  tc2 := clFuchsia;
  // tc := clWhite;
  // tc2 := clWhite;
  DefaultTitleImages.BkColor := tc;
  DefaultTitleImages.DrawingStyle := TDrawingStyle.dsTransparent;

  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmDropDown);

    DefaultTitleImages.BlendColor := tc;

    DefaultTitleImages.AddMasked(Bmp, tc2);

    Bmp.LoadFromResourceName(HInstance, bmSortAscending);
    DefaultTitleImages.AddMasked(Bmp, tc2);
    Bmp.LoadFromResourceName(HInstance, bmSortDescending);
    DefaultTitleImages.AddMasked(Bmp, tc2);
    Bmp.LoadFromResourceName(HInstance, bmFiltered);
    DefaultTitleImages.AddMasked(Bmp, tc2);
    Bmp.LoadFromResourceName(HInstance, bmFilteredAscending);
    DefaultTitleImages.AddMasked(Bmp, tc2);
    Bmp.LoadFromResourceName(HInstance, bmFilteredDescending);
    DefaultTitleImages.AddMasked(Bmp, tc2);

    DefaultTitleImages.BkColor := tc;

  finally
    Bmp.Free;
  end;
end;

function wwGetDefaultTitleImages: TImageList;
begin
  if DefaultTitleImages = nil then
    InitDefaultTitleImages;
  result := DefaultTitleImages;
end;

{ Error reporting }
procedure RaiseGridError(const s: string);
begin
  raise EInvalidGridOperation.Create(s);
end;

procedure InitIndicators;
var
  Bmp: TBitmap;
begin
  Indicators.Free;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    // ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    // ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    // ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiSelect);
    // ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    // ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Indicators.BkColor := clWhite;
    // 8/20/04 - Need to set BkColor for XP Service Pack 2 and Windows 2003
  finally
    Bmp.Free;
  end;

end;

procedure UsesBitmap;
var
  Bmp: TBitmap;
begin
  if UserCount = 0 then
  begin
    InitIndicators;
    Bmp := TBitmap.Create;
    try
      Bmp.LoadFromResourceName(HInstance, 'WWRIGHT');
      DragImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
      DragImages.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, 'WWLEFT');
      DragImages.AddMasked(Bmp, clWhite);
      DragImages.BkColor := clWhite;
    finally
      Bmp.Free;
    end;
  end;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then
  begin
    Indicators.Free;
    Indicators := nil;
    DragImages.Free;
    DragImages := nil;
    DefaultTitleImages.Free; // 12/31/11 - Free DefaultTitleImages
    DefaultTitleImages:=nil;
  end;
end;

{ TBookmarkList }

constructor TwwBookmarkList.Create(AGrid: TwwCustomDBGrid);
begin
  inherited Create;
  SetLength(FList, 0);
  FGrid := AGrid;
end;

destructor TwwBookmarkList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TwwBookmarkList.DeleteSelection(Index: integer);
begin
  DeleteItem(Index);
end;

procedure TwwBookmarkList.Clear;
begin
  if Length(FList) = 0 then
    Exit;
  SetLength(FList, 0);
  FGrid.Invalidate;
end;

function TwwBookmarkList.Compare(const Item1, Item2: TBookmark): integer;
begin
  with FGrid.DataLink.DataSource.DataSet do
    result := CompareBookmarks(TBookmark(Item1), TBookmark(Item2));
end;

function TwwBookmarkList.CurrentRow: TBookmark;
begin
  if not FLinkActive then
    RaiseGridError(sDataSetClosed);
{$IFDEF wwDelphi2009Up}
  result := FGrid.DataLink.DataSource.DataSet.Bookmark;
{$ELSE}
  result := FGrid.DataLink.DataSource.DataSet.GetBookmark;
{$ENDIF}
end;

function TwwBookmarkList.GetCurrentRowSelected: boolean;
var
  Index: integer;
begin
  result := Find(CurrentRow, Index);
end;

function TwwBookmarkList.Find(const Item: TBookmark;
  var Index: integer): boolean;
var
  L, H, I, C: integer;
begin
  if (Item = FCache) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    result := FCacheFind;
    Exit;
  end;
  result := false;
  L := 0;
  H := Length(FList) - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(FList[I], Item);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := result;
end;

function TwwBookmarkList.GetCount: integer;
begin
  result := Length(FList);
end;

function TwwBookmarkList.GetItem(Index: integer): TBookmark;
begin
  result := FList[Index];
end;

function TwwBookmarkList.IndexOf(const Item: TBookmark): integer;
begin
  if not Find(Item, result) then
    result := -1;
end;

procedure TwwBookmarkList.LinkActive(value: boolean);
begin
  Clear;
  FLinkActive := value;
end;

procedure TwwBookmarkList.Delete;
var
  I: integer;
begin
  with FGrid.DataLink.DataSource.DataSet do
  begin
    DisableControls;
    try
      for I := Length(FList) - 1 downto 0 do
      begin
{$IFDEF wwDelphi2009Up}
        Bookmark := FList[I];
{$ELSE}
        Bookmark := FList[I];
//        Bookmark := TBookmarkStr(FList[I]);
{$ENDIF}
        Delete;
        DeleteItem(I);
      end;
    finally
      EnableControls;
    end;
  end;
end;

function TwwBookmarkList.Refresh: boolean;
var
  I: integer;
begin
  result := false;
  with FGrid.DataLink.DataSource.DataSet do
    try
      CheckBrowseMode;
      for I := Length(FList) - 1 downto 0 do
        if not BookmarkValid(TBookmark(FList[I])) then
        begin
          result := True;
          DeleteItem(I);
        end;
    finally
      UpdateCursorPos;
      if result then
        FGrid.Invalidate;
    end;
end;

procedure TwwBookmarkList.DeleteItem(Index: integer);
var
  Temp: Pointer;
begin
  if (Index < 0) or (Index >= Count) then
    raise EListError.Create(SListIndexError);
  Temp := FList[Index];
  // The Move below will overwrite this slot, so we need to finalize it first
  FList[Index] := nil;
  if Index < Count - 1 then
  begin
    System.Move(FList[Index + 1], FList[Index], (Count - Index - 1) *
      SizeOf(Pointer));
    // Make sure we don't finalize the item that was in the last position.
    PPointer(@FList[Count - 1])^ := nil;
  end;
  SetLength(FList, Count - 1);
  DataChanged(Temp);
end;

procedure TwwBookmarkList.InsertItem(Index: integer; Item: TBookmark);
begin
  if (Index < 0) or (Index > Count) then
    raise EListError.Create(SListIndexError);
  SetLength(FList, Count + 1);
  if Index < Count - 1 then
  begin
    Move(FList[Index], FList[Index + 1], (Count - Index - 1) * SizeOf(Pointer));
    // The slot we opened up with the Move above has a dangling pointer we don't want finalized
    PPointer(@FList[Index])^ := nil;
  end;
  FList[Index] := Item;
  DataChanged(TObject(Item));
end;

procedure TwwBookmarkList.SetCurrentRowSelected(value: boolean);
var
  Index: integer;
  Current: TBookmark;
begin
  Current := CurrentRow;
{$IFDEF wwDelphi2009Up}
  if (Length(Current) = 0) or (Find(Current, Index) = value) then
    Exit;
{$ELSE}
  if (Current = nil) or (Find(Current, Index) = value) then
    Exit;
{$ENDIF}
  if value then
    InsertItem(Index, Current)
  else
    DeleteItem(Index);
  // InvalidateRow(FGrid.row); 8/12/10 - (Invalidate entire row as fixed column not invalidated in some cases - all fixed columns with last column selected checkbox)
  FGrid.InvalidateCurrentRow;
end;

procedure TwwBookmarkList.DataChanged(Sender: TObject);
begin
  FCache := nil;
  FCacheIndex := -1;
end;


// var
// BrowseIndicatorBitmap, EditIndicatorBitmap,
// InsertIndicatorBitmap, MultiSelectBitmap, MultiArrowBitmap: TBitmap;

{ type
  TwwGridHintWindow=class(THintWindow)
  private
  Field: TField;
  WordWrap: boolean;
  protected
  procedure Paint; override;
  public
  HintText: string;
  end;
}

// Return next tabbed control
function FindNextControl(CurControl: TWinControl;
  GoForward, CheckTabStop, CheckParent: boolean): TWinControl;
var
  I, StartIndex: integer;
  List: TList;
begin
  result := nil;
  List := TList.Create;

  try
    begin
      with CurControl.parent do
      begin
        GetTabOrderList(List);
        if List.Count > 0 then
        begin
          StartIndex := List.IndexOf(CurControl);
          if StartIndex = -1 then
            if GoForward then
              StartIndex := List.Count - 1
            else
              StartIndex := 0;
          I := StartIndex;
          repeat
            if GoForward then
            begin
              Inc(I);
              if I = List.Count then
              begin
                // I := 0;
                result := nil;
                Exit;
              end
            end
            else
            begin
              if I = 0 then
              begin
                // I := List.Count;
                result := nil;
                Exit;
              end;
              Dec(I);
            end;
            CurControl := List[I];
            if CurControl.CanFocus and (not CheckTabStop or CurControl.TabStop)
              and (not CheckParent or (CurControl.parent = CurControl.parent))
            then
              result := CurControl;
          until (result <> nil) or (I = StartIndex);
        end;
      end
    end
  finally
    List.Free;
  end;
end;

var
  KeyHook: HHOOK;

function wwHookKeyProc(nCode: integer; wParam: integer; lParam: integer)
  : LResult; stdcall;
type
  TSelection = record
    StartPos, EndPos: integer;
  end;
var
  ac: TWinControl;
  Grid: TwwCustomDBGrid;
  KeyMsg: // TWMKey;
    TWMKeyDown;
  nextctl: TWinControl;

  Function IsImmediateChildOfGrid: boolean;
  var
    tc: TWinControl;
  begin
    tc := screen.activecontrol;
    result := tc.parent is TCustomGrid;
  end;

  Function GetwwDBgrid(var Grid: TwwCustomDBGrid): boolean;
  var
    tc: TWinControl;
  begin
    tc := screen.activecontrol;

    // 6/1/06 - Make sure assigned
    if not Assigned(tc) then
    begin
      Grid := nil;
      result := false;
      Exit;
    end;

    if not(tc is TwwCustomDBGrid) then
    begin
      repeat
        tc := tc.parent;
      until (tc = nil) or (tc is TwwCustomDBGrid);
    end;
    result := (tc is TwwCustomDBGrid);
    if result then
      Grid := TwwCustomDBGrid(tc)
    else
      Grid := nil;
  end;

  Function IsChildOfGrid(var Inspector: TwwCustomDBGrid): boolean;
  var
    tc: TWinControl;
    Grid: TwwCustomDBGrid;
  begin
    GetwwDBgrid(Grid);
    if (Grid = Nil) or Grid.IsDropDownGridFocused then
    begin
      result := false;
      Exit;
    end;
    tc := screen.activecontrol;
    if not(tc is TCustomGrid) then
    begin
      repeat
        tc := tc.parent;
      until (tc = nil) or (tc is TCustomGrid);
    end;
    result := (tc is TCustomGrid);
    if result and wwIsClass(tc.classtype, 'TwwCustomDBGrid') then
      Inspector := TwwCustomDBGrid(tc)
    else
    begin
      Inspector := nil;
      result := false;
    end
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
    // 4/18/08 - If cursor on right and dgAlwaysShowEditor is false, then don't treat as rightside
    with ac do
      with Selection do
        result := ((StartPos = 0) or ((EndPos = StartPos) and
          (dgAlwaysShowEditor in Grid.Options))) and (EndPos = GetTextLen);
  end;

  function LeftSide: boolean;
  begin
    // 4/18/08 - If cursor on left and dgAlwaysShowEditor is false, then don't treat as leftside
    with ac do
      with Selection do
        result := (StartPos = 0) and
          (((EndPos = 0) and (dgAlwaysShowEditor in Grid.Options)) or
          (EndPos = GetTextLen) { or (isMasked and (EndPos=1)) } );
    if ac is TwwDBCustomEdit then
      with TwwDBCustomEdit(ac) do
        if isMasked and (Selection.EndPos = 1) then
          result := True;
  end;

  function TrueFocusIsGrid: boolean;
  begin
    result := IsChild(Grid.Handle, GetFocus) or (GetFocus = Grid.Handle);
  end;

begin
  ac := screen.activecontrol;
  if ac is TCustomGrid then // inplaceeditor doesn't update ac
  begin
    if (TwwCustomDBGrid(ac).inplaceeditor <> nil) and
      (TwwCustomDBGrid(ac).inplaceeditor.Handle = GetFocus) then
    begin
      ac := TwwCustomDBGrid(ac).inplaceeditor;
    end
  end;

  // Is in drop-down panel then don't send tab if at first or last control so
  // that focus does not leave grid
  if GetwwDBgrid(Grid) and Grid.IsDropDownGridFocused then
  begin
    if ((ac.parent is TScrollBox) or (ac.parent is TCustomPanel)) and
      ((ac.parent <> nil) and (ac.parent.parent = Grid)) then
    begin
      if wParam = 9 then
      begin
      end;
      nextctl := FindNextControl(ac, GetKeyState(vk_shift) >= 0, True, false);
      if nextctl = nil then
      begin
        result := 1;
        Exit;
      end
    end
  end;

  result := CallNextHookEx(KeyHook, nCode, wParam, lParam);
  if ac = nil then
    Exit;
  if ImmGetOpenStatus(ImmGetContext(ac.Handle)) = True then
    Exit; // 4/17/03 - Allow IME editor to handle keystrokes

  KeyMsg.Msg := WM_KEYDOWN;
  KeyMsg.KeyData := lParam; // confirmed
  KeyMsg.CharCode := wParam;

  if ((wParam = 13) or (wParam = 9)) and not(GetKeyState(vk_control) < 0) and
    not(GetKeyState(vk_menu) < 0) and (GetFocus = ac.Handle) then
  begin
    if (lParam and $80000000) = 0 then
    begin
      if IsChildOfGrid(Grid) then
      begin
        if (dgEnterToTab in Grid.KeyOptions) or (wParam = vk_tab) then
        begin
          PostMessage(Grid.Handle, WM_KEYDOWN, wParam, 0);
          result := 1;
        end
      end
    end
    // 6/20/01
    else if not IsChildOfGrid(Grid) then // Another form is active
      result := 0
      // else result:=1
    else
      result := 0 // 9/27/01 - Allow KeyUp to fire for grid
  end
  else if GetwwDBgrid(Grid) and Grid.IsShortCut(KeyMsg) then
  // ar Message: TWMKey) then
  begin
    if ((lParam and $80000000) = 0) then // shortcut key pressed
    begin
      // showmessage('');
      result := 1; // Eat keystroke as its a shortcut
    end
  end
  { else if (wparam = vk_f2) and
    not (GetKeyState(vk_control)<0) and
    not (GetKeyState(vk_menu)<0) then
    begin
    if IsChildOfInspector(Inspector) then
    begin
    if (lparam and $80000000)=0 then
    Inspector.FCustomControlKeyMode:= not Inspector.FCustomControlKeyMode;
    end
    end }
  // Collapse expand button on Ctrl-left
  else if (wParam in [vk_left]) and ((lParam and $80000000) = 0) and
    (GetKeyState(vk_control) < 0) and GetwwDBgrid(Grid) and Grid.IsDropDownGridFocused
  then
  begin
    Grid.CollapseChildGrid;
    result := 1; // 9/18/02 - Eat keystroke so focus does not jump out of grid
  end
  // Need obj property to see if we should pass vk_down, vk_up, vk_next, and vk_prior to inspector
  // Always pass vk_left, vk_right
  else if (wParam in [vk_home, vk_end, vk_right, vk_left, vk_down, vk_up,
    vk_next, vk_prior, vk_delete]) and ((lParam and $80000000) = 0) and
    (GetKeyState(vk_control) < 0) then
  begin
    // So dropped-down combos get keystrokes, check if radio-group is still ok
    if wwHaveVisibleChild(ac) then
      Exit;

    // 4/10/08 - Ctrl-left, Ctrl-right go to edit control
    if GetwwDBgrid(Grid) and (ac is TCustomEdit) then
    begin
      if (wParam in [vk_home, vk_end, vk_left, vk_right])
      { and grid.EditorMode } then
        Exit;
    end;

    if IsChildOfGrid(Grid) and (ac <> Grid) then
    begin
      PostMessage(Grid.Handle, WM_KEYDOWN, wParam, 0);
      result := 1;
    end
  end
  else if (wParam in [vk_left, vk_right, vk_down, vk_up, vk_next, vk_prior,
    vk_insert, vk_home]) and
  // 1/21/00 - Allow home to go to first column if all selected
    not(GetKeyState(vk_control) < 0) and not(GetKeyState(vk_menu) < 0) then
  begin
    if wwHaveVisibleChild(ac) then
      Exit;

    if (lParam and $80000000) = 0 then
    begin
      // Immediate child used to support radiogroup in TwwDBGrid
      // if IsChildOfGrid(Inspector) and // Initialize inspector
      // IsImmediateChildOfGrid and (ac<>Inspector) then
      if IsChildOfGrid(Grid) then
      begin
        if not TrueFocusIsGrid then
          Exit;
        // if not IsImmediateChildOfGrid and (ac<>Grid) then
        if not IsImmediateChildOfGrid and (screen.activecontrol <> Grid) then
        // 1/21/02 RSW (If inplaceeditor then its not a radiogroiup item so don't geo into this path )
        begin
          if (wParam in [vk_left, vk_right, vk_up, vk_down]) then
            Exit; // radiogroup item has focus
        end;

        // Send to inspector navigation keys
        if (ac is TCustomEdit) then
        begin
          case wParam of
            vk_home:
              if not LeftSide then
                Exit;
            vk_left:
              if not LeftSide then
                Exit;
            vk_right:
              if not RightSide then
                Exit;
            vk_up:
              if not AllSelected then
                Exit; // 1/21/02 -
            vk_down:
              if not AllSelected then
                Exit; // 1/21/02
          end
        end;

        if Grid.Focused then
          Exit
        else
        begin
          PostMessage(Grid.Handle, WM_KEYDOWN, wParam, 0);
        end;

        result := 1;
      end
    end
    // 6/20/01
    else if not IsChildOfGrid(Grid) then // Another form is active
      result := 0
      // else result:=1
      // 9/12/01 - Allow KeyUp to fire for grid
    else
      result := 0
  end

end;

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
const
  cGradientDirections: array [TGradientDirection] of Cardinal =
    (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  StartColor, EndColor: Cardinal;
  Vertexes: array [0 .. 1] of TTriVertex;
  GradientRect: TGradientRect;
begin
  StartColor := ColorToRGB(AStartColor);
  EndColor := ColorToRGB(AEndColor);

  Vertexes[0].X := ARect.Left;
  Vertexes[0].Y := ARect.Top;
  Vertexes[0].Red := GetRValue(StartColor) shl 8;
  Vertexes[0].Blue := GetBValue(StartColor) shl 8;
  Vertexes[0].Green := GetGValue(StartColor) shl 8;
  Vertexes[0].Alpha := 0;

  Vertexes[1].X := ARect.Right;
  Vertexes[1].Y := ARect.Bottom;
  Vertexes[1].Red := GetRValue(EndColor) shl 8;
  Vertexes[1].Blue := GetBValue(EndColor) shl 8;
  Vertexes[1].Green := GetGValue(EndColor) shl 8;
  Vertexes[1].Alpha := 0;

  GradientRect.UpperLeft := 0;
  GradientRect.LowerRight := 1;

{$IF DEFINED(CLR)}
  GradientFill(ACanvas.Handle, Vertexes, 2, GradientRect, 1,
    cGradientDirections[Direction]);
{$ELSE}
  GradientFill(ACanvas.Handle, @Vertexes[0], 2, @GradientRect, 1,
    cGradientDirections[Direction]);
{$endif}
end;

procedure TwwGridHintWindow.Paint;
var
  R, ClipRect: TRect;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  LGradientStart, LGradientEnd, LTextColor: TColor;
  WriteOptions: TwwWriteTextOptions;
begin
  R := ClientRect;
  LStyle := StyleServices;
  LTextColor := screen.HintFont.Color;
  if LStyle.Enabled then
  begin
    ClipRect := R;
    InflateRect(R, 4, 4);
    if TOSVersion.Check(6) and LStyle.IsSystemStyle then
    begin
      // Paint Windows gradient background
      LStyle.DrawElement(Canvas.Handle,
        LStyle.GetElementDetails(tttStandardNormal), R, ClipRect);
    end
    else
    begin
      LDetails := LStyle.GetElementDetails(thHintNormal);
      if LStyle.GetElementColor(LDetails, ecGradientColor1, LColor) and
        (LColor <> clNone) then
        LGradientStart := LColor
      else
        LGradientStart := clInfoBk;
      if LStyle.GetElementColor(LDetails, ecGradientColor2, LColor) and
        (LColor <> clNone) then
        LGradientEnd := LColor
      else
        LGradientEnd := clInfoBk;
      if LStyle.GetElementColor(LDetails, ecTextColor, LColor) and
        (LColor <> clNone) then
        LTextColor := LColor
      else
        LTextColor := screen.HintFont.Color;
      GradientFillCanvas(Canvas, LGradientStart, LGradientEnd, R, gdVertical);
    end;
    R := ClipRect;
  end;
  Inc(R.Left, 1);
  Inc(R.Top, 2);
  Canvas.Font.Color := LTextColor;
  if WordWrap then
    WriteOptions := [wtoWordWrap, wtoTransparent];
  if not wwUseThemes(Grid) then
    WriteOptions := WriteOptions + [wtoDisableThemes];
  // 4/17/03 - Support righttoleft hint
  if (Field <> nil) and TwwCustomDBGrid(Owner).UseRightToLeftAlignmentForField
    (Field, Alignment) then
  begin
    R.Right := R.Right - 1;
    wwWriteTextLinesT(Canvas, R, 0, 0, PChar(Caption), taRightJustify,
      WriteOptions)
  end
  else
    wwWriteTextLinesT(Canvas, R, 0, 0, PChar(Caption), Alignment, WriteOptions);

end;

function TwwCustomDBGrid.UseAlternateBuffering: boolean;
begin
  result := AlternatePaintBuffering or UseRightToLeftAlignment or
    (wwInternational.GridPaintStyle = gpsDynamicDeviceContext);
  if result and (csPaintCopy in ControlState) then
    result := false;
end;

function TwwCustomDBGrid.GetCanvas: TCanvas;
begin
  if UseDragCanvas then
    result := CaptureTitleBitmap.Canvas
  else if not UseAlternateBuffering then
    result := FPaintCanvas
  else
    result := inherited Canvas;
  // result:= inherited Canvas;
end;

procedure UpdateSelectedProp(Selected: TStrings; FieldName: string; val: string;
  SelectedProperty: TwwUpdateSelected; Index: integer = -1);
begin
  UpdateSelectedPropWithGrid(nil, Selected, FieldName, val,
    SelectedProperty, Index);
end;

procedure UpdateSelectedPropWithGrid(Grid: TwwCustomDBGrid; Selected: TStrings;
  FieldName: string; val: string; SelectedProperty: TwwUpdateSelected;
  Index: integer = -1);
var
  APos: integer;
  FieldWidth, DisplayLabel, ReadOnly, GroupName: wwSmallString;
  newindex: integer;
  currentSelected: string;
  I: integer;
begin
  if Index = -1 then
  begin
    if (Grid <> nil) and (SelectedProperty = sptUpdateVisible) then
    begin
      if not wwFindSelected(Selected, FieldName, index) then
      begin
        if val = 'T' then
        begin
          FieldWidth := inttostr(Grid.ColumnByName(FieldName).DisplayWidth);
          DisplayLabel := Grid.ColumnByName(FieldName).DisplayLabel;
          if Grid.ColumnByName(FieldName).ReadOnly then
            ReadOnly := 'T'
          else
            ReadOnly := 'F';
          Selected.Add(FieldName + #9 + FieldWidth + #9 + DisplayLabel + #9 +
            ReadOnly);
          Exit;
        end;
      end
      else
      begin
        if val = 'F' then
        begin
          Selected.Delete(index);
          Exit;
        end;
      end
    end
    else if not wwFindSelected(Selected, FieldName, index) then
      Exit;
  end;

  if SelectedProperty = sptUpdateIndex then
  begin
    newindex := strtoint(val);
    if index = newindex then
      Exit;
    // selected[newindex]:= selected[index];
    if newindex < index then
    begin
      currentSelected := Selected[index];
      for I := index downto newindex + 1 do
      begin
        Selected[I] := Selected[I - 1];
      end;
      Selected[newindex] := currentSelected;
    end
    else
    begin
      currentSelected := Selected[index];
      for I := index to newindex - 1 do
      begin
        Selected[I] := Selected[I + 1];
      end;
      Selected[newindex] := currentSelected;
    end
  end
  else
  begin
    APos := 1;
    FieldName := strGetToken(Selected[index], #9, APos);
    FieldWidth := strGetToken(Selected[index], #9, APos);
    DisplayLabel := strGetToken(Selected[index], #9, APos);
    ReadOnly := strGetToken(Selected[index], #9, APos);
    if ReadOnly = '' then
      ReadOnly := 'F';
    GroupName := strGetToken(Selected[index], #9, APos);
    case SelectedProperty of
      sptUpdateGroup:
        GroupName := val;
      sptUpdateWidth:
        FieldWidth := val;
      sptUpdateLabel:
        DisplayLabel := val;
      sptUpdateReadOnly:
        ReadOnly := val;
    end;
    Selected[index] := FieldName + #9 + FieldWidth + #9 + DisplayLabel + #9
      + ReadOnly;
    if GroupName <> '' then
      Selected[index] := Selected[index] + #9 + GroupName;
  end;
end;

function GetSelectedProp(Selected: TStrings; FieldName: string;
  SelectedProperty: TwwUpdateSelected): string;
var
  APos, Index: integer;
  FieldWidth, DisplayLabel, ReadOnly, GroupName: wwSmallString;
begin
  if wwFindSelected(Selected, FieldName, index) then
  begin
    APos := 1;
    FieldName := strGetToken(Selected[index], #9, APos);
    FieldWidth := strGetToken(Selected[index], #9, APos);
    DisplayLabel := strGetToken(Selected[index], #9, APos);
    ReadOnly := strGetToken(Selected[index], #9, APos);
    if ReadOnly = '' then
      ReadOnly := 'F';
    GroupName := strGetToken(Selected[index], #9, APos);
    case SelectedProperty of
      sptUpdateGroup:
        result := GroupName;
      sptUpdateField:
        result := FieldName;
      sptUpdateWidth:
        result := FieldWidth;
      sptUpdateLabel:
        result := DisplayLabel;
      sptUpdateReadOnly:
        result := ReadOnly;
    end;
  end
end;

Function min(X, Y: integer): integer;
begin
  if X < Y then
    min := X
  else
    min := Y;
end;

{ procedure GridError(S: Word);
  begin
  RaiseGridError(LoadStr(S));
  end;

  procedure GridErrorFmt(S: Word; const Args: array of const);
  begin
  RaiseGridError(FmtLoadStr(S, Args));
  end;
}

{ TwwGridDataLink }
type
  TIntArray = array [0 .. MaxMapSize] of integer;
  PIntArray = ^TIntArray;

  TBitmapCacheType = class
    Bitmap: TBitmap;
    LookupValue: string;
    curField: TField;
  end;

constructor TwwGridDataLink.Create(AGrid: TwwCustomDBGrid);
begin
  inherited Create;
  FGrid := AGrid;
  VisualControl := True;
end;

destructor TwwGridDataLink.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TwwGridDataLink.GetDefaultFields: boolean;
begin
  result := True;
  if DataSet <> nil then
    result := DataSet.DefaultFields;
end;

function TwwGridDataLink.GetFields(I: integer): TField;
begin
  if I < FFieldCount then
    result := DataSet.Fields[PIntArray(FFieldMap)^[I]]
  else
    result := nil;
end;

function TwwGridDataLink.AddMapping(const FieldName: string): boolean;
var
  Field: TField;
  NewSize: integer;
  NewMap: Pointer;
begin
  if FFieldCount >= MaxMapSize then
{$IFDEF wwDelphi3Up}
    RaiseGridError(STooManyColumns);
{$ELSE}
    GridError(STooManyColumns);
{$ENDIF}
  Field := DataSet.FindField(FieldName);
  result := Field <> nil;
  if result then
  begin
    if FFieldMapSize = 0 then
    begin
      FFieldMapSize := 8;
      GetMem(FFieldMap, FFieldMapSize * SizeOf(integer));
    end
    else if FFieldCount = FFieldMapSize then
    begin
      NewSize := FFieldMapSize;
      Inc(NewSize, NewSize);
      if (NewSize > MaxMapSize) or (NewSize < FFieldCount) then
        NewSize := MaxMapSize;
      GetMem(NewMap, NewSize * SizeOf(integer));
      Move(FFieldMap^, NewMap^, SizeOf(integer) * FFieldCount);
      FreeMem(FFieldMap, SizeOf(integer) * FFieldCount);
      FFieldMapSize := NewSize;
      FFieldMap := NewMap;
    end;
    PIntArray(FFieldMap)^[FFieldCount] := Field.Index;
    { if FGrid.useTFields then
      PIntArray(FFieldMap)^[FFieldCount] := Field.Index
      else if wwFindSelected(FGrid.Selected, Field.FieldName, AIndex) then
      PIntArray(FFieldMap)^[FFieldCount] := AIndex; }
    Inc(FFieldCount);
  end;
end;

procedure TwwGridDataLink.ActiveChanged;
begin
  FGrid.LinkActive(Active);
end;

procedure TwwGridDataLink.ClearMapping;
begin
  if FFieldMap <> nil then
  begin
    FreeMem(FFieldMap, FFieldMapSize * SizeOf(integer));
    FFieldMap := nil;
    FFieldMapSize := 0;
    FFieldCount := 0;
  end;
end;

procedure TwwGridDataLink.Modified;
begin
  FModified := True;
end;

procedure TwwGridDataLink.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := false;
end;

procedure TwwGridDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
      { with FGrid do
        begin
        if (dgAlwaysShowEditor in Options) and (not isWWControl(SelectedIndex, 1)) and
        (not isMemoField(SelectedIndex, 1)) then
        ShowEditor;
        end }
      // FGrid.ShowEditor;
    end;
  end;
end;

procedure TwwGridDataLink.DataSetScrolled(Distance: integer);
begin
  FGrid.Scroll(Distance);
end;

procedure TwwGridDataLink.LayoutChanged;
begin
  { if FGrid.useTFields then } FGrid.LayoutChanged;
end;

procedure TwwGridDataLink.EditingChanged;
begin
  FGrid.EditingChanged;

  { Update footer later, when encountering edit or insert mode }
  if (DataSource <> nil) and { 10/7/98 }
    ((DataSource.State = dsInsert) or (DataSource.State = dsEdit)) then
  begin
    FGrid.ShouldUpdateFooter := True;
  end;
end;

procedure TwwGridDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) or not FInUpdateData then
  begin
    FGrid.RecordChanged(Field);
    FModified := false;
  end;

  if (Field <> Nil) and (DataSet.State in [dsEdit, dsInsert]) then
  begin
    FGrid.FieldChanged(Field);
    if (FGrid is TwwDBGrid) then
      TwwDBGrid(FGrid).Patch[0] := True;
  end
end;

procedure TwwGridDataLink.UpdateData;
begin
  FInUpdateData := True;
  try
    if FModified then
    begin
      FGrid.UpdateData;
      FGrid.GridUpdateData;
    end;
    FModified := false;
  finally
    FInUpdateData := false;
  end;
end;

procedure TwwGridDataLink.Reset;
begin
  if FModified then
    RecordChanged(nil)
  else
  begin
    if ((DataSource.DataSet.State = dsEdit) or
      (DataSource.DataSet.State = dsInsert)) and DataSet.Modified then
    begin
      if MessageDlg(wwInternational.UserMessages.wwDBGridDiscardChanges,
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    end;
    DataSet.Cancel;
  end
end;

{ TwwCustomDBGrid }

(*
  var
  //  DrawBitmap: TBitmap;
  UserCount: Integer;

  procedure UsesBitmap;
  begin
  exit;
  if UserCount = 0 then
  begin
  //    DrawBitmap := TBitmap.Create;
  end;
  Inc(UserCount);
  end;


  procedure ReleaseBitmap;
  begin
  Dec(UserCount);
  if UserCount = 0 then begin
  //     DrawBitmap.Free;
  //     DrawBitmap:= Nil;
  EditIndicatorBitmap.Free;
  BrowseIndicatorBitmap.Free;
  InsertIndicatorBitmap.Free;
  MultiSelectBitmap.Free;
  MultiArrowBitmap.Free;
  EditIndicatorBitmap:= Nil;
  BrowseIndicatorBitmap:= Nil;
  InsertIndicatorBitmap:= Nil;
  MultiSelectBitmap := Nil;
  MultiArrowBitmap := Nil;
  end;
  end;
*)

function Max(X, Y: integer): integer;
begin
  result := Y;
  if X > Y then
    result := X;
end;

(*
  procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
  const
  AlignFlags : array [TAlignment] of Integer =
  ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
  DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
  DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
  var
  B, R: TRect;
  Hold, Left: Integer;
  I: TColorRef;
  begin
  I := ColorToRGB(ACanvas.Brush.Color);
  //  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
  { In BiDi, because we changed the window origin, the text that does not
  change alignment, actually gets its alignment changed. }
  if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
  ChangeBiDiModeAlignment(Alignment);
  case Alignment of
  taLeftJustify:
  Left := ARect.Left + DX;
  taRightJustify:
  Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
  else { taCenter }
  Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
  - (ACanvas.TextWidth(Text) shr 1);
  end;
  ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
  end
  end;
*)
Procedure wwWriteTextLines(ACanvas: TCanvas; const ARect: TRect;
  DX, DY: integer; s: PChar; Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions);
const
  AlignFlags: array [TAlignment] of integer = (DT_LEFT or DT_EXPANDTABS or
    DT_NOPREFIX, DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array [boolean] of integer = (0, DT_RTLREADING);
  CNormalStates: array [boolean] of TThemedGrid = (tgCellNormal,
    tgCellSelected);
var
  R, DrawRect: TRect;
  Flags: integer;
  ADrawCanvas: TCanvas;
  Temp: integer;
  TempRect: TRect;
  NonWideStr: string;
  OrigRect, OrigRotateRect: TRect;
  parts: TStrings;
  I: integer;
  Details: TThemedElementDetails;
  Flags2: TTextFormatFlags;

  function wwSize(cx, cy: integer): TSize;
  begin
    result.cx := cx;
    result.cy := cy;
  end;

  function MultiLineTextSize(Canvas: TCanvas; Text: string;
    LineSpacing: integer; MaxWidth: integer; DrawFlags: integer): TSize;
  var
    s: string;
    R: TRect;
    I : integer;
    parts: TStringList;
  begin
    s := Text;
    result := wwSize(0, 0);
    parts := TStringList.Create;
    strBreakApart(Text, #13, parts);

    for I := 0 to parts.Count - 1 do
    begin
      s := parts[I];
      R := Rect(0, 0, MaxWidth, 0);
      DrawTextEx(Canvas.Handle, PChar(s), Length(s), R,
        DrawFlags or DT_CALCRECT, nil);
      Inc(result.cy, R.Height);;
      if R.Width > result.cx then
        result.cx := R.Width;
      if i<parts.count-1 then
        Inc(result.cy, LineSpacing);
    end;

    parts.Free;
  end;

  function GetTextSize(Canvas: TCanvas; TextRect: TRect; s: string;
    Flags: integer): TSize;
  const
    LineSpacing = 5;
    WordWrap = false;
  var
    R: TRect;
    //sz: TSize;
    //xoffset: integer;
    //yoffset: integer;
  begin
    R := Rect(TextRect.Left, TextRect.Top, TextRect.Right, TextRect.Bottom);
    //R.Right := R.Right - xoffset;
    //R.Bottom := R.Bottom - yoffset;
    Flags := 0;
    with MultiLineTextSize(Canvas, s, LineSpacing,
      ord(WordWrap) * R.Width, Flags) do
      result := wwSize(cx, cy);
    result.cx := result.cx + 1;
  end;

  function wwTrunc(val: Extended): Longint;
  begin
    result := Round(val - 0.4999); { Changed from -0.5 }
  end;

  procedure CalcRotatedRect(var Rect: TRect);
  var
    TextSize: TSize;
    Angle: Double; // TExtended;
  begin
    if ACanvas.Font.Orientation <> 0 then
    begin
      // Flags:= Flags   + dt_NoClip;
      Flags := dt_NoClip;
      R.Top := R.Top + (R.Height div 2); // + ACanvas.TextHeight('A') div 2;
      R.Left := R.Left + (R.Width div 2); // dead center.
      TextSize := GetTextSize(ACanvas, R, s, Flags);
      with TextSize do
      begin
        Angle := ACanvas.Font.Orientation;
        Dec(R.Left, wwTrunc(Cos(Angle) * cx) div 2);
        Inc(R.Top, wwTrunc(Sin(Angle) * cx) div 2);
        Dec(R.Top, wwTrunc(Cos(Angle) * cy) div 2);
        Dec(R.Left, wwTrunc(Sin(Angle) * cy) div 2);
      end;
      if R.Top > R.Bottom then
        R.Top := R.Bottom;

    end
  end;

begin

  ADrawCanvas := ACanvas;
  OrigRect := ARect;

  if (ACanvas.CanvasOrientation = coRightToLeft) then
    ChangeBiDiModeAlignment(Alignment);

  with ARect do
  begin { brush origin tics in painting / scrolling. }
    if Alignment = taRightJustify then
      R := Rect(DX, DY, Right - Left - 2, Bottom - Top - 1)
      { 7/10/98 - Make width 1 less }
    else if Alignment = taLeftJustify then
      R := Rect(DX, DY, Right - Left, Bottom - Top - 1)
    else
    { 3/31/98 - If CenterJustify then allow DrawText to properly center text }
    begin
      if DX >= 3 then
        R := Rect(2, DY, Right - Left, Bottom - Top - 1)
      else
        R := Rect(0, DY, Right - Left, Bottom - Top - 1)
    end;
    R.Left := R.Left + ARect.Left;
    R.Right := R.Right + ARect.Left;
    R.Top := R.Top + ARect.Top;
    R.Bottom := R.Bottom + ARect.Top;
  end;

  with ADrawCanvas do
  begin
    Font := ACanvas.Font;
    Font.Color := ACanvas.Font.Color;
    Brush := ACanvas.Brush;
    Brush.Style := bsSolid;
    if not(wtoTransparent in WriteOptions) then
    begin
      TempRect := ARect;
      FillRect(TempRect)
    end;

    SetBkMode(Handle, TRANSPARENT);
    Flags := AlignFlags[Alignment];
    if (ACanvas.CanvasOrientation = coRightToLeft) then
    { 9/25/98 - Support bidi mode }
    begin
      if wtoAmpersandToUnderline in WriteOptions then
        Flags := Flags and (not DT_NOPREFIX);
      if wtoWordWrap in WriteOptions then
        Flags := Flags or DT_WORDBREAK;

      Flags := Flags or DT_RTLREADING; // 8/20/04 - As suggested by Eyal
      DrawRect := ARect;
      DrawTextEx(Handle, PChar(s), Length(s), DrawRect,
        Flags or DT_CALCRECT, nil);
      if DrawRect.Left - DrawRect.Right > ARect.Right - ARect.Left then
      begin
        DrawRect.Left := DrawRect.Right + ARect.Right - ARect.Left;
      end;

      if DrawRect.Left < DrawRect.Right then
        DrawRect.Left := DrawRect.Right;

      If Alignment = taLeftJustify then
      begin
        Temp := R.Left;
        R.Left := R.Right - 2;
        R.Right := Temp;
      end
      else if Alignment = taRightJustify then
      begin
        Flags := AlignFlags[taLeftJustify] { or DT_RTLREADING };
        R.Left := ARect.Left + ACanvas.TextWidth(s) + 2;
        // 9/23/03 - Bidi - Presever right-side display when cell smaller than text
        R.Right := ARect.Left;
      end
      else
      begin
        Flags := AlignFlags[taLeftJustify] { or DT_RTLREADING };
        R.Right := ARect.Left +
          ((ARect.Right - ARect.Left) - (DrawRect.Left - DrawRect.Right)) div 2;
        R.Left := ARect.Right -
          ((ARect.Right - ARect.Left) - (DrawRect.Left - DrawRect.Right)) div 2;
      end;
      Flags := Flags or DT_RTLREADING; // 8/20/04 - As suggested by Eyal Zvi
    end;

    if wtoAmpersandToUnderline in WriteOptions then
      Flags := Flags and (not DT_NOPREFIX);

    if wtoWordWrap in WriteOptions then
      Flags := Flags or DT_WORDBREAK;

    { 3/31/98 - Check to see if this is a single line edit control to
      determine if we should or should not have word breaks }
    if wwIsSingleLineEdit(Handle, R, Flags) or (wtoEllipsis in WriteOptions)
    then
      Flags := Flags and not DT_WORDBREAK;

    if wtoEllipsis in WriteOptions then
      Flags := Flags or DT_END_ELLIPSIS;
    { If text does not fit then put ellipsis at end }

    if (wtoIsTitle in WriteOptions) and (Font.Orientation <> 0) then
    begin
      R := OrigRect;
      CalcRotatedRect(R);
      OrigRotateRect:= R;
    end;

    if (not wwIsCustomStyle(nil)) or (wtoDisableThemes in WriteOptions) then
    begin
      NonWideStr := s;
      DrawText(Handle, PChar(NonWideStr), Length(NonWideStr), R, Flags);
    end
    else if ACanvas.Font.Orientation <> 0 then
    // Themes may not support rotation so just call DrawText
    begin
      NonWideStr := s;

      parts := TStringList.Create;
      strBreakApart(NonWideStr, #13, parts);

      if parts.Count>1 then           
      begin
         if ACanvas.Font.Orientation>=1800 then
         begin
            R.Left:= R.Left + ADrawCanvas.TextHeight('A') div 2;
            R.Top:= OrigRect.Top;
         end
         else begin
            R.Left:= R.Left - ADrawCanvas.TextHeight('A') div 2;
         end
      end
      else
      begin
         if ACanvas.Font.Orientation>=1800 then
         begin
            R.Left:= R.Left + 4 -  ADrawCanvas.TextHeight('A') div 2;
            R.Top:= OrigRect.Top;
         end
         else
            R.Left:= R.Left -7 +  ADrawCanvas.TextHeight('A') div 2
      end;
      
      for I := 0 to parts.Count - 1 do
      begin
        NonWideStr := parts[I];
        ADrawCanvas.Font.Color := StyleServices.GetStyleFontColor
          (sfHeaderSectionTextNormal);
        if ACanvas.Font.Orientation>=1800 then
        begin
          if parts.Count>1 then begin           
              R.Left := R.Left - ADrawCanvas.TextHeight(NonWideStr);
              R.Top:= R.Top - 2 + (R.Height -ADrawCanvas.TextWidth(NonWideStr)) div 2;
          end
          else
             R.Top:= R.Top  + (OrigRect.Height -ADrawCanvas.TextWidth(NonWideStr)) div 2;
        end
        else if ACanvas.Font.Orientation<1800 then
        begin
          if parts.Count>1 then           
          begin
              R.Left := R.Left + ADrawCanvas.TextHeight(NonWideStr);
              R.Top:= R.Top + 5 -  (OrigRect.Height -ADrawCanvas.TextWidth(NonWideStr)) div 2;
          end;
          R.Top:= R.Top;// - (R.Height -ADrawCanvas.TextWidth(NonWideStr)) div 2;
        end;
        DrawText(Handle, PChar(NonWideStr), Length(NonWideStr), R, Flags);
      end;

      parts.Free;

      ADrawCanvas.Font.Color := StyleServices.GetStyleFontColor
        (sfHeaderSectionTextNormal);
        DrawText(Handle, PChar(NonWideStr), Length(NonWideStr), R, Flags);
    end
    else
    begin
      // 7/31/2013 - Clip for styles and not left-aligned as it doesn't clip otherwise
      if (Flags and (DT_CENTER OR DT_RIGHT))<>0 then
           ExcludeClipRect(ADrawCanvas.Handle, 0, 0, R.Left, r.Bottom);

      if (wtoIsTitle in WriteOptions) then
        wwDrawThemedTitleText(ADrawCanvas, s, R, Flags)
      else begin
        if wtoGridSelected in WriteOptions then
        begin
           Details := StyleServices.GetElementDetails(tgCellSelected);
           Flags2:= Flags;
           StyleServices.DrawText(ACanvas.Handle, Details, S, R, Flags2);
        end
        else
           wwDrawThemedText(ADrawCanvas, s, R, Flags);
      end;

      // 7/31/2013 - Restore normal clipping rectangle
      if (Flags and (DT_CENTER OR DT_RIGHT))<>0 then
        SelectClipRgn(ADrawCanvas.Handle, 0);

    end;
  end;

end;

procedure ChangeColorBitmap(Bitmap: TBitmap; NewColor, OldColor: TColor);
var
  R: TRect;
  b: TBitmap;
begin
  b := TBitmap.Create;
  try
    b.assign(Bitmap);

    { Substitute indicator color for black }
    Bitmap.Canvas.Brush.Color := NewColor;
    R := Rect(0, 0, Bitmap.Width, Bitmap.Height);
    Bitmap.Canvas.BrushCopy(R, b, R, OldColor);
  finally
    b.Free;
  end
end;

(* procedure TwwCustomDBGrid.InitIndicators;
  var Bmp: TBitmap;
  begin
  Indicators.Free;
  Bmp := TBitmap.Create;
  try
  Bmp.LoadFromResourceName(HInstance, bmArrow);
  ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
  Indicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
  Indicators.AddMasked(Bmp, clWhite);
  Bmp.LoadFromResourceName(HInstance, bmEdit);
  ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
  Indicators.AddMasked(Bmp, clWhite);
  Bmp.LoadFromResourceName(HInstance, bmInsert);
  ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
  Indicators.AddMasked(Bmp, clWhite);
  Bmp.LoadFromResourceName(HInstance, bmMultiSelect);
  ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
  Indicators.AddMasked(Bmp, clWhite);
  Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
  ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
  Indicators.AddMasked(Bmp, clWhite);
  //    Indicators.BkColor:= clWhite;
  finally
  Bmp.Free;
  end;

  end;
*)
constructor TwwCustomDBGrid.Create(AOwner: TComponent);
// var
// Bmp: TBitmap;
begin
  UsesBitmap;

  DrawCellInfo := TwwCustomDrawGridCellInfo.Create;
  OrigColWidths := nil;
  TempLastCol := -1;
  FSizingIndex := -1;
  FCacheColInfo := TList.Create;

  inherited Create(AOwner);
  inherited DefaultDrawing := false;
  FShowHorzScrollBar := True;
  LineStyle := glsDynamic;
  FAcquireFocus := True;
  // Bmp := TBitmap.Create;
  try
    { Bmp.Handle := LoadBitmap(HInstance, bmArrow);
      if BrowseIndicatorBitmap=Nil then begin
      BrowseIndicatorBitmap:= TBitmap.create;
      BrowseIndicatorBitmap.assign(Bmp);
      end;
      Bmp.Handle := LoadBitmap(HInstance, bmEdit);
      if EditIndicatorBitmap=Nil then begin
      EditIndicatorBitmap:=TBitmap.create;
      editIndicatorBitmap.assign(Bmp);
      end;
      Bmp.Handle := LoadBitmap(HInstance, bmInsert);
      if InsertIndicatorBitmap=Nil then begin
      InsertIndicatorBitmap:= TBitmap.create;
      InsertIndicatorBitmap.assign(Bmp);
      end;
      Bmp.Handle := LoadBitmap(HInstance, bmMultiSelect);
      if MultiSelectBitmap=Nil then begin
      MultiSelectBitmap:= TBitmap.create;
      MultiSelectBitmap.assign(Bmp);
      end;
      Bmp.Handle := LoadBitmap(HInstance, bmMultiArrow);
      if MultiArrowBitmap=Nil then begin
      MultiArrowBitmap:= TBitmap.create;
      MultiArrowBitmap.assign(Bmp);
      end;
    }
    FIndicatorColor := icBlack;
    FIndicatorIconColor := clBlack;

    { Bmp.LoadFromResourceName(HInstance, 'WWRIGHT');
      DragImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
      DragImages.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, 'WWLEFT');
      DragImages.AddMasked(Bmp, clWhite);
      DragImages.BkColor:= clWhite;
    }
    { Bmp.LoadFromResourceName(HInstance, bmArrow);
      Indicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
      Indicators.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, bmEdit);
      Indicators.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, bmInsert);
      Indicators.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, bmMultiSelect);
      Indicators.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
      Indicators.AddMasked(Bmp, clWhite); }
    // Indicators.BkColor:= clWhite;
  finally
    // Bmp.Free;
  end;

  // InitIndicators;
  FTitleOffset := 1;
  FIndicatorOffset := 1;
  FUpdateFields := True;
  FOptions := [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines,
    dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap
  { , dgVariableRowHeight } ];
  FKeyOptions := [dgAllowInsert, dgAllowDelete];
  // UsesBitmap;
  ScrollBars := ssHorizontal;
  inherited Options := [goFixedHorzLine, goFixedVertLine, goHorzLine,
    goVertLine, goColSizing, goColMoving, goTabs, goEditing];
  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := TwwGridDataLink.Create(Self);
  // FDataLink := CreateDataLink(Self);

  // FVDataLink := TwwGridDataLink.Create(Self);
  Color := clWindow;
  ParentColor := false;
  FTitleFont := TFont.Create;
  FTitleFont.OnChange := TitleFontChanged;
  FTitleColor := clBtnFace;
  FFooterColor := clBtnFace;
  FFooterCellColor := clBtnFace;
  FSaveCellExtents := false;
  FUserChange := True;
  FDefaultDrawing := True;
  HideEditor;

  FTitleAlignment := taLeftJustify;
  FRowHeightPercent := 100;
  MinRowHeightPercent := 100;

  FTitleLines := 1;
  ShowVertScrollBar := True;

  InUpdateRowCount := false;
  TitleClickColumn := -1;
  TitleClickGroupTitle := false;

  FSelected := TStringList.Create;
  UseTFields := True;
  FIndicatorWidth := 11;
  ColItems := TList.Create;
  SavedColItems := TList.Create;

  FDragVertOffset := 15;

  FControlType := TStringList.Create;
  FControlInfoInDataset := True;
  FPictureMasks := TStringList.Create;
  FRegexMasks := TStringList.Create;
  FPictureMaskFromDataSet := True;

  DummyColumn := TwwColumn.Create(Self, '');
  DummyColumn.FVisible := false;

  FPadColumnStyle := pcsPadHeaderAndData;
  // FPadColumnStyle:= pcsPadHeader;
  // FPadColumnStyle:= pcsPlain;

  FPaintBitmap := TBitmap.Create;
  FPaintCanvas := FPaintBitmap.Canvas;

  FEditControlOptions := [ecoSearchOwnerForm];
{$IFNDEF GRIDESSENTIALS}
  FPaintOptions := TwwGridPaintOptions.Create(Self, FPaintBitmap);
{$ENDIF}
  FLineColors := TwwGridLineColors.Create;
  FLineColors.FGrid := Self;
  FLineColors.DataColor := clSilver;
  FLineColors.HighlightColor := clBtnHighlight;
  FLineColors.ShadowColor := clBtnShadow;
  FLineColors.FixedColor := clBlack;
  FLineColors.GroupingColor := clBlack;
  // DoubleBuffered:=True;

  titleLastMouseX := -1;
  titleLastMouseY := -1;

  FDittoAttributes := TwwDittoAttributes.Create;
  FTitleMenuAttributes := TwwTitleMenuAttributes.Create(Self);

  // ControlStyle:= ControlStyle + [csOverrideStylePaint]; // 8/19/11 -  fGrid flickers otherwise with styles
end;

procedure TwwCustomDBGrid.FormGridFilterTypesNeeded;
begin
  if FormGridFilterTypes = nil then
  begin
    FormGridFilterTypes := TwwFormGridFilterTypes.Create(Self);
    FormGridFilterTypes.Grid := Self;
  end;
end;

destructor TwwCustomDBGrid.Destroy;
var
  I: integer;
begin
  FormGridFilterTypes.Free;

  if KeyHook <> 0 then
  begin
    UnhookWindowsHookEx(KeyHook);
    KeyHook := 0;
  end;

  FDittoAttributes.Free;
  FTitleMenuAttributes.Free;

  DrawCellInfo.Free;
  DrawCellInfo := nil;
  ReleaseBitmap;

  for I := 0 to FCacheColInfo.Count - 1 do
    TwwCacheColInfoItem(FCacheColInfo[I]).Free;
  FCacheColInfo.Free;
  FCacheColInfo := nil;
  FIndicatorButton.Free;

  FSelected.Free;
  FSelected := Nil;

  FDataLink.Free;
  FDataLink := nil;
  // FVDataLink.Free;
  // FVDataLink := nil;
  FTitleFont.Free;
  FTitleFont := Nil;

  for I := 0 to ColItems.Count - 1 do
    TwwColumn(ColItems[I]).Free;
  ColItems.Free;
  ColItems := nil;

  for I := 0 to SavedColItems.Count - 1 do
    TwwColumn(SavedColItems[I]).Free;
  SavedColItems.Free;
  SavedColItems := nil;

  CaptureTitleBitmap.Free;
  CaptureTitleBitmap := nil;
  FControlType.Free;
  FPictureMasks.Free;
  FRegexMasks.Free;

  ClearLastBookmarks;
{$IFNDEF GRIDESSENTIALS}
  FPaintOptions.Free;
{$ENDIF}
  ResetProportionalWidths;

  (* {$ifdef wwdelphi4up}
    if LastBookmark<>Nil then FreeMem(LastBookmark);
    LastBookmark:= nil;
    if LastMasterBookmark<>Nil then FreeMem(LastMasterBookmark);
    LastMasterBookmark:= nil;
    {$else}
    if LastBookmark<>Nil then StrDispose(LastBookmark);
    LastBookmark:= nil;
    if LastMasterBookmark<>Nil then StrDispose(LastMasterBookmark);
    LastMasterBookmark:= nil;
    {$endif}
  *)
  // DragImages.Free;
  // Indicators.Free;
  DummyColumn.Free;
  DummyColumn := nil;
  FPaintBitmap.Free;
  FPaintBitmap := nil;
  FLineColors.Free;

  inherited Destroy;
  // ReleaseBitmap;
end;

Procedure TwwCustomDBGrid.ClearLastBookmarks;
begin
//{$IFNDEF wwDelphi2008Up}
//  if LastBookmark <> Nil then
//    FreeMem(LastBookmark);
//{$ENDIF}
//  LastBookmark := nil;
//{$IFNDEF wwDelphi2008Up}
//  if LastMasterBookmark <> Nil then
//    FreeMem(LastMasterBookmark);
//{$ENDIF}
  LastMasterBookmark := nil;
end;

procedure TwwCustomDBGrid.DefineFieldMap;
var
  I: integer;
  APos: integer;
  FldName: string;
  TempList: TList;
  { ExistingColumn, } CurColumn: TwwColumn;
begin

  if FDataLink.DataSet = nil then
    Exit;

  with FDataLink.DataSet do
  begin
    if UseTFields then
    begin
      for I := 0 to FieldCount - 1 do
      begin
        with Fields[I] do
          if Visible then
            FDataLink.AddMapping(FieldName);
      end
    end
    else
    begin
      I := 0;
      while I <= Selected.Count - 1 do
      begin
        APos := 1;
        FldName := strGetToken(Selected[I], #9, APos);
        if FDataLink.Active and (FindField(FldName) = Nil) then
        begin
          Selected.Delete(I);
          continue;
        end
        else
        begin
          FDataLink.AddMapping(FldName);
        end;
        Inc(I);
      end
    end
  end;

  { Create templist for TwwColumns - saves existing properties }

  TempList := TList.Create;
  for I := 0 to FieldCount - 1 do
  begin
    CurColumn := TwwColumn.Create(Self, Fields[I].FieldName);
    CurColumn.FooterValue := ColumnByName(Fields[I].FieldName).FooterValue;
    CurColumn.DisableSizing := ColumnByName(Fields[I].FieldName).DisableSizing;
    // 8/13/09
    CurColumn.SearchValue := ColumnByName(Fields[I].FieldName).SearchValue;
    CurColumn.FVisible := True; // ColumnByName(Fields[I].FieldName).Visible;
    CurColumn.FDisplayWidth := ColumnByName(Fields[I].FieldName).DisplayWidth;
    CurColumn.FDisplayLabel := ColumnByName(Fields[I].FieldName).DisplayLabel;
    TempList.Add(CurColumn); // ! Visible is false because its a dummy column
  end;

  { Free prior column list - Do after creating new tempList }
  for I := 0 to ColItems.Count - 1 do
  begin
    TwwColumn(ColItems[I]).Free;
  end;
  ColItems.Clear;

  { Transfer tempitems over to Items }
  for I := 0 to TempList.Count - 1 do
  begin
    if TwwColumn(TempList[I]).Visible then
      ColItems.Add(TempList[I])
    else
      SavedColItems.Add(TempList[I]);
  end;
  TempList.Free;

end;

procedure TwwCustomDBGrid.DrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
begin
  if Assigned(FOnDrawDataCell) then
    FOnDrawDataCell(Self, Rect, Field, State);
end;

procedure TwwCustomDBGrid.ProportionalColWidths;
// (UpdateTrailing: boolean);
var
  TotalTempGridWidth: integer;
  GridLineWidth, ColSpace, AvailSpace, I: integer;
  StartCol: integer;
  // ACount: integer;
  ScrollBarOffset: integer;
  StartGroupCol, EndGroupCol: integer;
  TotalGroupWidth, ChangeWidth: integer;
  MinWidth: integer;
begin
  if OrigColWidths = nil then
    Exit;
  if OrigColWidthsCount < ColCount - 1 then
    Exit;
  if UseTFields then
    Exit;
  if Selected.Count = 0 then
    Exit;

  // ShowMessage(Selected[Selected.count-1]);

  // if dgIndicator in Options then ACount:= ColCount-1
  // else ACount:= ColCount;

  if dgColLines in Options then
    GridLineWidth := 1
  else
    GridLineWidth := 0;

  MinWidth := Canvas.TextWidth('0') * 2 + 4;

  if FSizingIndex >= 0 then
  begin
    TotalTempGridWidth := -1;
    StartCol := FSizingIndex;

    // Divide evenly the increase or decrease of the resized column with
    // its fellow group memebers
    // Still need to handle if resized column is in the middle of group.
    // If so, then we need to handle this
    if (Columns[DbCol(FSizingIndex)].GroupName <> '') then
    begin
      GroupNameCellRect(FSizingIndex, 0, StartGroupCol, EndGroupCol, false);
      ChangeWidth := ColWidths[FSizingIndex] - FPriorSizingWidth;
      // OrigColWidths[FSizingIndex]; // FOrigSizingWidth;
      TotalGroupWidth := 0;
      for I := StartGroupCol to EndGroupCol do
      begin
        if I = EndGroupCol then
          TotalGroupWidth := TotalGroupWidth + FPriorSizingWidth + GridLineWidth
        else
          TotalGroupWidth := TotalGroupWidth + OrigColWidths[I] + GridLineWidth;
      end;

      if (FSizingIndex = EndGroupCol) and
        (not(Self is TwwDBGrid) or (TwwDBGrid(Self).Patch[8] = false)) then
      begin
        for I := StartGroupCol to EndGroupCol do
        begin
          if I = EndGroupCol then
          begin
            ColWidths[I] := wwMax(MinWidth, FPriorSizingWidth + ChangeWidth);
          end
          else
          begin
            ColWidths[I] :=
              wwMax(MinWidth,
              (OrigColWidths[I] * (TotalGroupWidth + ChangeWidth))
              div TotalGroupWidth);
          end;
          ChangeWidth := ChangeWidth - (ColWidths[I] - OrigColWidths[I]);
          TotalGroupWidth := TotalGroupWidth - OrigColWidths[I];
        end
      end
    end;

    for I := StartCol + 1 to ColCount - 1 do
      TotalTempGridWidth := TotalTempGridWidth + OrigColWidths[I] +
        GridLineWidth;
    if TotalTempGridWidth <= 0 then
      Exit;
  end
  else
  begin
    StartCol := 0; // FIndicatorOffset;
    TotalTempGridWidth := -1;
    for I := FIndicatorOffset to ColCount - 1 do // Count - 1 do
      TotalTempGridWidth := TotalTempGridWidth + OrigColWidths[I] +
        GridLineWidth;
    if TotalTempGridWidth <= 0 then
      Exit;
  end;

  { if UseRightToLeftAlignment then
    IndicatorWidth:= CellRect(StartCol, 0).Right -
    CellRect(StartCol, 0).Left
    else begin
    IndicatorWidth:= CellRect(StartCol, 0).Right;
    IndicatorWidth:= CellRect(StartCol, 0).right-
    CellRect(StartCol, 0).Left
    end;
  }
  if (dgIndicator in Options) then
  begin
    if UseRightToLeftAlignment then
      AvailSpace := ClientWidth - (ClientWidth - CellRect(StartCol, 0).Left) - 2
    else
      AvailSpace := ClientWidth - CellRect(StartCol, 0).Right - 2
  end
  else
  begin
    if FSizingIndex >= 0 then
    begin
      if UseRightToLeftAlignment then
        AvailSpace := ClientWidth - (ClientWidth - CellRect(StartCol, 0)
          .Left) - 2
      else
        AvailSpace := ClientWidth - CellRect(StartCol, 0).Right - 2
    end
    else
      AvailSpace := ClientWidth - 2
  end;

  // If scrollbar not showing but it will be later then adjust
  // AvailSpace and ColWidths later.
  If ShowVertScrollBar and (Width - ClientWidth < 10) then
    ScrollBarOffset := GetSystemMetrics(SM_CXHThumb) + 1
  else
    ScrollBarOffset := 0;
  AvailSpace := AvailSpace - ScrollBarOffset;

  if FSizingIndex >= 0 then
    Inc(StartCol)
  else
    StartCol := StartCol + FIndicatorOffset;

  Inc(FUpdatingColWidths);

  try
    for I := StartCol to ColCount - 1 do
    begin
      if TotalTempGridWidth = 0 then
        continue;
      ColSpace := ((OrigColWidths[I] + 1) * AvailSpace) div TotalTempGridWidth;

      ColSpace := ((ColSpace - 4) div Canvas.TextWidth('0')) *
        Canvas.TextWidth('0') + 4;
      ColSpace := wwMax(MinWidth, ColSpace);

      if I = ColCount - 1 then
      begin
        // ColWidths[I]:= (ClientWidth-ScrollBarOffset)-1-CellRect(I, 0).Left;
        ColWidths[I] := wwMax(AvailSpace, 0);
      end
      else
        ColWidths[I] := ColSpace;

      UpdateSelectedProp(Selected, '',
        inttostr(((ColWidths[I] - 4) div Canvas.TextWidth('0'))),
        // inttostr(((ColSpace-4) div Canvas.TextWidth('0'))) ,
        sptUpdateWidth, I - FIndicatorOffset);

      AvailSpace := AvailSpace - ColSpace - GridLineWidth;
      TotalTempGridWidth := TotalTempGridWidth - OrigColWidths[I] -
        GridLineWidth;
      // OrigColWidths[I]:= ColWidths[I];
    end;
  finally
    Dec(FUpdatingColWidths);
  end
end;

procedure TwwCustomDBGrid.SetColumnAttributes;
var
  I: integer;
  CWidth: integer;
  parts: TStrings;
  tempField: TField;
  tempCount: integer;
  ResetWidths: boolean;
  AFieldName: string;

  Function GetTitleWidth(lbl: string): integer;
  var
    APos, currentTitleWidth, lineWidth: integer;
    line: string;
  begin
    APos := 1;
    lineWidth := 0;
    while True do
    begin
      line := strGetToken(lbl, '~', APos);
      if (line = '') and ((APos <= 0) or (APos >= Length(line))) then
        break;
      currentTitleWidth := Canvas.TextWidth(line);
      if currentTitleWidth > lineWidth then
        lineWidth := currentTitleWidth;
    end;
    result := lineWidth + 4;
  end;

  Function GetDisplayWidth: integer;
  begin
    result := 64; // Give some value
    if UseTFields then
    begin
      if (tempField <> nil) then
        result := tempField.DisplayWidth * Canvas.TextWidth('0') + 4
    end
    else
      result := strtoint(parts[1]) * Canvas.TextWidth('0') + 4;
  end;

  Function GetDisplayLabel(Index: integer): string;
  begin
    if UseTFields then
      result := Fields[I].DisplayLabel
    else if parts.Count > 2 then
      result := parts[2] { 7/31/97 }
    else if tempField <> nil then
      result := tempField.DisplayLabel;
  end;

  procedure CleanupControlCache;
  var
    I: integer;
  begin
    for I := 0 to FCacheColInfo.Count - 1 do
      TwwCacheColInfoItem(FCacheColInfo[I]).Free;
    FCacheColInfo.Clear;
  end;

begin
  if DataSource = nil then
    Exit;
  if DataSource.DataSet = nil then
    Exit; { 3/15/97 }

  if UseTFields then
    tempCount := FieldCount
  else
  begin
    tempCount := Selected.Count;
    parts := TStringList.Create;
  end;

  // 1/21/04 - Initialize cache colinfo earlier, as colwidths can fire paint
  // events where cachecol info is still old value
  CleanupControlCache;
  InitCacheColInfo;

  ResetWidths := True;

  if IsProportionalColumns then
  begin
    if (OrigColWidths <> nil) then
    begin
      ResetProportionalWidths;
      OrigColWidths := PWordArray(AllocMem(SizeOf(Word) * (tempCount + 1)));
      OrigColWidthsCount := tempCount + 1;
      ResetWidths := false;
      for I := FIndicatorOffset to tempCount - 1 + FIndicatorOffset do
      begin
        OrigColWidths[I] := ColWidthsPixels[I];
      end
    end
    else
    begin
      OrigColWidths := PWordArray(AllocMem(SizeOf(Word) * (tempCount + 1)));
      OrigColWidthsCount := tempCount + 1;
    end
  end;

  for I := 0 to tempCount - 1 do
  begin
    if UseTFields then
    begin
      tempField := Fields[I];
      AFieldName := tempField.FieldName;
    end
    else
    begin
      AFieldName := FieldName(I + FIndicatorOffset); // Pass absolute column
      strBreakApart(Selected[I], #9, parts);
      tempField := DataSource.DataSet.FindField(parts[0]);
      // if tempField=nil then continue;
    end;
    Canvas.Font := Font;
    CWidth := GetDisplayWidth;
    // { 10/26/98 - Truncate to character }
    // CWidth:= (GetDisplayWidth(i) div Canvas.TextWidth('0')) * Canvas.TextWidth('0');

    if not IsProportionalColumns and (dgTitles in Options) and
      not(dgNoLimitColSize in Options) then
    begin
      Canvas.Font := TitleFont;
      if CWidth < GetTitleWidth(GetDisplayLabel(I)) then
        CWidth := GetTitleWidth(GetDisplayLabel(I));
    end;
    if IsProportionalColumns and ResetWidths then
      OrigColWidths[I + FIndicatorOffset] := CWidth
    else
      ColWidths[I + FIndicatorOffset] := CWidth;

    if tempField <> nil then
    begin
      TabStops[I + FIndicatorOffset] := (not tempField.ReadOnly);
      if { (ColumnByName(TempField.FieldName)<>Nil) and }
        (ColumnByName(AFieldName).ReadOnly) then
        TabStops[I + FIndicatorOffset] := false;

      if TabStops[I + FIndicatorOffset] and (not EditCalculated) then
        TabStops[I + FIndicatorOffset] := (not tempField.Calculated);
    end;
  end;

  if IsProportionalColumns then
    if tempCount > 0 then
      ProportionalColWidths;

  { for I := 0 to TempCount - 1 do
    begin
    TabStops[I + FIndicatorOffset] := (not TempField.ReadOnly);
    if   (ColumnByName(TempField.FieldName).ReadOnly) then
    TabStops[I + FIndicatorOffset]:= False;

    if TabStops[I + FIndicatorOffset] and (not EditCalculated) then
    TabStops[I + FIndicatorOffset] := (not TempField.Calculated);
    end;
  }
  if not UseTFields then
    parts.Free;

  // 1/21/04 - Move following 2 lines earlier
  // CleanupControlCache;
  // InitCacheColInfo;
  FSavePrevGridWidth := ClientWidth;

  // FreeMem(TempColWidths);
end;

procedure TwwCustomDBGrid.CalcRowHeight;
var
  TempDefaultRowHeight: integer;
  RowHeight0: integer;
begin
{$IFNDEF GRIDESSENTIALS}
  if (CurrentCustomEdit is TwwExpandButton) then
    TwwExpandButton(CurrentCustomEdit).Expanded := false;
{$ENDIF}
  Canvas.Font := Font;

  // Don't set if not changed DefaultRowHeight so we don't have flicker
  TempDefaultRowHeight := Canvas.TextHeight('W') + NormalPad;
  if HaveAnyRowLines then
    TempDefaultRowHeight := TempDefaultRowHeight + 1;
  RowHeight0 := TempDefaultRowHeight;

  TempDefaultRowHeight := (TempDefaultRowHeight * RowHeightPercent) div 100;
  if DefaultRowHeight <> TempDefaultRowHeight then
    DefaultRowHeight := TempDefaultRowHeight;

  if dgTitles in Options then
  begin
    Canvas.Font := TitleFont;

    if parent is TCustomGrid then
      // Make rows a multiple of defaultRowHeight so rows fit evenly
      RowHeights[0] := RowHeight0 * TitleLines + (TitleLines - 1)
    else
      RowHeights[0] := Canvas.TextHeight('W') * TitleLines + 4;
    if ShowSearchRow then
    begin
      RowHeights[0] := RowHeights[0] + GetSearchRowHeight;
    end;

    { Increase by 1 in order to show 3D effects }
    if (not HaveAnyRowLines) { and Ctl3D } then
      RowHeights[0] := RowHeights[0] + 1;

  end;

  if (dgIndicator in Options) and (FIndicatorButton <> Nil) then
  begin
    TitleTextOffset := 2 + (Max(RowHeights[0], FIndicatorButton.Height) -
      RowHeights[0]) div 2;
    if HaveAnyRowLines then
      RowHeights[0] := Max(RowHeights[0], FIndicatorButton.Height) - 1
      { 5/09/97 Removed -1 }
    else
      RowHeights[0] := Max(RowHeights[0], FIndicatorButton.Height) + 1;
    { 5/09/97 Removed -1 }
  end
  else
    TitleTextOffset := 2;

end;

procedure TwwCustomDBGrid.SetIndicatorWidth(val: integer);
begin
  if FIndicatorWidth <> val then
  begin
    FIndicatorWidth := val;
  end
end;

procedure TwwCustomDBGrid.LayoutChanged;
var
  J: integer;
  PrevVisibleRowCount: integer;
begin
  if csLoading in ComponentState then
    Exit;
  if not HandleAllocated then
    Exit;
  if FUpdateLock <> 0 then
    Exit;
  Inc(FUpdateLock);
  try
    begin
      FSavePrevGridWidth := ClientWidth;
      Inc(FUpdatingColWidths);
      try
        begin
          FTitleOffset := 0;

          // Hide horizontal scrollbars in this special case
          if ShowHorzScrollBar and IsProportionalColumns and
            (ScrollBars in [ssBoth, ssHorizontal]) then
            ShowHorzScrollBar := ShowHorzScrollBar;

          if dgTitles in Options then
            FTitleOffset := 1;

          CalcRowHeight;

          FIndicatorOffset := 0;
          if dgIndicator in Options then
            FIndicatorOffset := 1;

          FDataLink.ClearMapping;
          if FDataLink.Active then
            DefineFieldMap;
          if not UseTFields and (FieldCount = 0) then
            J := Selected.Count
          else
            J := FieldCount;
          if J = 0 then
            J := 1;
          inherited ColCount := J + FIndicatorOffset;
          if dgIndicator in Options then
            ColWidths[0] := FIndicatorWidth;
          if (dgIndicator in Options) and (col = 0) then
            col := 1; { 5/31/95 - Avoid }

          HideControls; { 7/18/97 - in case of re-order }
          UpdateRowCount;

          PrevVisibleRowCount := VisibleRowCount;
          SetColumnAttributes;
          if VisibleRowCount <> PrevVisibleRowCount then
            UpdateRowCount; { 6/1/95 }
          CheckFooterUpdate;
        end;
      finally
        Dec(FUpdatingColWidths);
      end;
      UpdateActive;
      FSavedCursor := Cursor;
      // 4/9/2002 - PYW - Preserve Cursor before URLPaint
      ClearURLPaint; // Clear variables for highlight url address

      if AllowPerfectFit then
        DoPerfectFit;
      Invalidate;
{$IFNDEF GRIDESSENTIALS}
      if PaintOptions <> nil then
      begin
        PaintOptions.Column1Color := TitleColor;
        PaintOptions.Row1Color := TitleColor;
      end
{$ENDIF}
    end;
  finally
    Dec(FUpdateLock);
  end;
end;

procedure TwwCustomDBGrid.LinkActive(value: boolean);
begin

  if not value then
    HideEditor;

  if value then
  begin
    if not(dgIndicator in Options) then
      LeftCol := FixedCols;
    // 8/19/11 - avoid index out of range when re-activating dataset
    LayoutChanged;
  end
  else
    LayoutChanged;

  UpdateScrollBar;

  { 1/28/98 - Clear multi-select last record }
  { 4/21/99 - Free ShiftSelectBookmark first }
{$IFDEF wwdelphi4up}
  If value then
  begin
//{$IFNDEF wwDelphi2008Up}
//    if ShiftSelectBookmark <> Nil then
//      FreeMem(ShiftSelectBookmark);
//{$ENDIF}
    ShiftSelectBookmark := nil;
    ShiftSelectMode := false;
  end;
//{$IFNDEF wwDelphi2008Up}
//  if LastBookmark <> Nil then
//    FreeMem(LastBookmark);
//{$ENDIF}
  LastBookmark := nil;
//{$IFNDEF wwDelphi2008Up}
//  if LastMasterBookmark <> Nil then
//    FreeMem(LastMasterBookmark);
//{$ENDIF}
  LastMasterBookmark := nil;
{$ELSE}
  If value then
  begin
    if ShiftSelectBookmark <> Nil then
      StrDispose(ShiftSelectBookmark);
    ShiftSelectBookmark := nil;
    ShiftSelectMode := false;
  end;
  if LastBookmark <> Nil then
    StrDispose(LastBookmark);
  LastBookmark := nil;
  if LastMasterBookmark <> Nil then
    StrDispose(LastMasterBookmark);
  LastMasterBookmark := nil;
{$ENDIF}
  if value then
  begin
    if (not HandleAllocated) then
      CallColEnter := True
    else
    begin
      if col <> TempLastCol then
        ColEnter;
      TempLastCol := col;
    end;
    ShouldUpdateFooter := True; { Update footer first time after active }
  end
  else
    TempLastCol := -1;
end;

procedure TwwCustomDBGrid.CreateWnd;
// var SINew: TScrollInfo;
begin
  inherited CreateWnd;

  LayoutChanged;
  UpdateScrollBar;
  DoCheckRowChanged;

  // SINew.cbSize := sizeof(SINew);
  // SINew.fMask:= SIF_DISABLENOSCROLL;
  // SetScrollInfo(Self.Handle, SB_VERT, SINew, False);

  // Support recursive grids
  // if (parent<>nil) and wwIsClass(parent.classtype, 'TCustomGrid') then
  // windows.setparent(self.handle, GetParentForm(self).handle);

end;

function TwwCustomDBGrid.GetDataSource: TDataSource;
begin
  result := FDataLink.DataSource;
end;

function TwwCustomDBGrid.CanEditAcceptKey(Key: Char): boolean;
begin
  result := FDataLink.Active and (FieldCount > 0) and Fields[SelectedIndex]
    .IsValidChar(Key);
end;

function TwwCustomDBGrid.GetEditLimit: integer;
begin
  result := 0;
  if (FieldCount > 0) and (SelectedField is TStringField) then
    result := TStringField(SelectedField).Size;
end;

function TwwCustomDBGrid.CanEditModify: boolean;
var
  colInfo: TwwColumn;
begin
  result := false;

  { 8/24/98 - Don't allow insert/edit if no records and dgallowinsert is false }
  { 10/2/98 - Fix this fix.  Allow editing if editing. }
  if (DataSource <> nil) and (DataSource.DataSet <> nil) and
    (not(dgAllowInsert in KeyOptions)) and DataSource.DataSet.BOF and
    DataSource.DataSet.EOF and (DataSource.State = dsBrowse) then
  begin
    Exit;
  end;

  if not ReadOnly and FDataLink.Active and not FDataLink.ReadOnly and
    (FieldCount > 0) and (Fields[SelectedIndex].CanModify or
    (FEditCalculated and wwisNonPhysicalField(Fields[SelectedIndex])
    { 5/9/97 }
    and not(Fields[SelectedIndex].ReadOnly))) then
  begin
    colInfo := ColumnByName(Fields[SelectedIndex].FieldName);
    if { (colInfo<>nil) and } (colInfo.ReadOnly) then
      Exit;

    FDataLink.Edit;
    result := FDataLink.Editing;
    if result then
      FDataLink.Modified;
  end;
end;

function TwwCustomDBGrid.GetEditMask(ACol, ARow: Longint): string;
begin
  result := '';
  if FDataLink.Active and (ACol - FIndicatorOffset < FieldCount) then
    result := Fields[ACol - FIndicatorOffset].EditMask;
end;

function TwwCustomDBGrid.GetEditText(ACol, ARow: Longint): string;
begin
  result := '';
  if FDataLink.Active and (ACol - FIndicatorOffset < FieldCount) then
    result := Fields[ACol - FIndicatorOffset].Text;
  FEditText := result;
end;

procedure TwwCustomDBGrid.SetEditText(ACol, ARow: Longint; const value: string);
begin
  FEditText := value;
end;

function TwwCustomDBGrid.GetFieldCount: integer;
begin
  result := FDataLink.FieldCount;
  { if Result=0 then
    result:= Selected.count }
end;

function TwwCustomDBGrid.GetFields(Index: integer): TField;
begin
  result := FDataLink.Fields[Index];
end;

procedure TwwCustomDBGrid.SetDataSource(value: TDataSource);
begin
  FDataLink.DataSource := value;
  // FVDataLink.DataSource:= Value;
  LinkActive(FDataLink.Active);
end;

function TwwCustomDBGrid.GetSelectedField: TField;
begin
  result := nil;
  if SelectedIndex < FieldCount then
    result := Fields[SelectedIndex];
end;

function TwwCustomDBGrid.GetSelectedIndex: integer;
begin
  result := col - FIndicatorOffset;
end;

procedure TwwCustomDBGrid.SetSelectedField(value: TField);
var
  I: integer;
begin
  for I := 0 to FieldCount - 1 do
    if Fields[I] = value then
      SelectedIndex := I;
end;

procedure TwwCustomDBGrid.SetSelectedIndex(value: integer);
begin
  if value < FixedCols - FIndicatorOffset then
  begin
    FDataLink.UpdateData; // 9/17/02 Allow fixed column to update
    HideControls;
    MoveColRow(value + FIndicatorOffset, row, True, false);
    InvalidateEditor;
    ColEnter;
  end
  else
    MoveCol(value);
end;

procedure TwwCustomDBGrid.CheckFooterUpdate;
var
  MasterBookmark: TBookmark;
  MasterSource: TDataSource;
  res: integer; // CmpBkmkRslt;
begin
  if not Assigned(FOnUpdateFooter) then
    Exit;

  if not HandleAllocated then
    Exit;
  if (DataSource <> nil) and (DataSource.State = dsBrowse) then
  { 10/21/98 - Check datsource<>nil }
  begin
    { If child dataset then update when master moves to a new record }
    if not ShouldUpdateFooter then
    begin
      MasterSource := wwGetControlDataSource(DataSource.DataSet);
      if MasterSource = nil then
        MasterSource := wwGetControlMasterSource(DataSource.DataSet);
      if (MasterSource <> Nil) and (MasterSource.DataSet <> Nil) then
      begin
        MasterBookmark := MasterSource.DataSet.GetBookmark;
        if MasterBookmark <> nil then { 1/9/98 - Check for nil bookmark }
        begin
          res := wwDataSetCompareBookmarks(MasterSource.DataSet, MasterBookmark,
            LastMasterBookmark);
          if CompareBookmarksAltMethod then
          begin
            if (res <> 0) then
              ShouldUpdateFooter := True;
          end
          else
          begin
            if (res <> CMPKeyEql) and (res <> CMPEql) then
              ShouldUpdateFooter := True;
          end;
          MasterSource.DataSet.FreeBookmark(LastMasterBookmark);
          LastMasterBookmark := MasterBookmark;
        end
      end;
    end;

    { Handles record deletions }
    if not ShouldUpdateFooter then
    begin
      // 10/31/02 - Avoid ADO bug in BookmarkValid generating exception when no records
      if (LastBookmark <> nil) and DataSource.DataSet.EOF and
        DataSource.DataSet.BOF then
        ShouldUpdateFooter := True
      else if (LastBookmark <> nil) and
        (not DataSource.DataSet.BookmarkValid(LastBookmark)) then
        ShouldUpdateFooter := True;
    end;

    if ShouldUpdateFooter then
      DoUpdateFooter;
    ShouldUpdateFooter := false;
  end;

end;

procedure TwwCustomDBGrid.DataChanged;
// var OldLeftCol: integer;
begin
  // if dgVariableRowHeight in Options then CalcRowHeight;
  if not HandleAllocated then
    Exit;
  if SkipDataChange then
    Exit;

  CheckFooterUpdate;

  { Fix - (8/25/96) Required when canceling insert with navigator }
  { 2/12/97 - This line used to be after the call to InvalidateEditor }
  { By putting it before UpdateRowCount then screen painting is more optimized }
  { 2/17/99 - Include dsInsert as Hidecontrols case }
  { 3/30/99 - Only include Insert if the dataset is not empty }
  if (not SkipHideControls) and (DataSource.State = dsInsert) and
    not(DataSource.DataSet.BOF and DataSource.DataSet.EOF) then
    HideControls;
  if (not SkipHideControls) and (DataSource.State in [dsBrowse]) then
    HideControls;

  { if (dgRowSelect in Options) then
    begin
    OldLeftCol:= LeftCol;
    BeginUpdate;
    UpdateRowCount;
    if OldLeftCol<ColCount then LeftCol:= OldLeftCol;
    EndUpdate(False);
    end
    else }
  UpdateRowCount;

  UpdateScrollBar;
  UpdateActive;
  InvalidateEditor;

  { Fix - (8/25/96) Required when canceling insert with navigator }
  { if (not SkipHideControls) and (DataSource.state=dsBrowse) then HideControls; }

  ValidateRect(Handle, nil);
  Invalidate;
  // scrollbars should be repainted too - this invalidates nc area, without this
  // code scrollbars are not updated with custom styles
  if wwIsCustomStyle(Self) then
    RedrawWindow(Self.Handle, ClientRect, 0, RDW_Frame or rdw_invalidate);

  DoCheckRowChanged;
end;

procedure TwwCustomDBGrid.EditingChanged;
begin
  if dgIndicator in Options then
    InvalidateCell(0, FSelRow);
end;

procedure TwwCustomDBGrid.RecordChanged(Field: TField);
var
  R: TRect;
  InvBegin, InvEnd: integer;
begin
  if not HandleAllocated then
    Exit;

  InvBegin := 0;
  if Field = nil then
    InvEnd := ColCount - 1
  else
  begin
    for InvBegin := 0 to FieldCount - 1 do
      if Fields[InvBegin] = Field then
        break;
    InvEnd := InvBegin;
  end;
  R := BoxRect(InvBegin + FIndicatorOffset, row,
    InvEnd + FIndicatorOffset, row);
  InvalidateRect(Handle, @R, false);
  if ((Field = nil) or (SelectedField = Field)) and (SelectedIndex < FieldCount)
    and { 6/17/97 }
    (Fields[SelectedIndex].Text <> FEditText) then
  begin
    InvalidateEditor;
    if inplaceeditor <> nil then
      inplaceeditor.Deselect;
  end;

end;

procedure TwwCustomDBGrid.FieldChanged(Field: TField);
begin
  DoFieldChanged(Field);
end;

procedure TwwCustomDBGrid.DoFieldChanged(Field: TField);
begin
  if Assigned(FOnFieldChanged) then
  begin
    if wwGridEssentials then
      DisplayProfessionalVersionOnlyMessage(Self,
        'OnFieldChanged only supported in InfoPower Professional');

    FOnFieldChanged(Self, Field);
  end;
end;

{ function TwwCustomDBGrid.Edit: Boolean;
  begin
  Result := False;
  if not ReadOnly then
  begin
  FDataChanged := False;
  FEditRequest := True;
  try
  FDataLink.Edit;
  finally
  FEditRequest := False;
  end;
  Result := FDataChanged;
  end;
  end;
}
procedure TwwCustomDBGrid.Scroll(Distance: integer);
var
  OldRect, NewRect: TRect;
  RowHeight: integer;
begin
  if not HandleAllocated then
    Exit; { 6/2/97 }
  { if dgVariableRowHeight in Options then UpdateRowCount;
    if (Distance<>0) then
    begin
    if dgVariableRowHeight in Options then CalcRowHeight;
    end;
  }
  // Adjust for child grid
  // Row:= FDataLink.ActiveRecord+FTitleOffset;
  // RowOffset:= 0;

  OldRect := BoxRect(0, row, ColCount - 1, row);
  UpdateScrollBar;
  UpdateActive;
  NewRect := BoxRect(0, row, ColCount - 1, row);
  // NewRect.Bottom:= NewRect.Bottom + 1;  // In case of scrolling
  ValidateRect(Handle, @OldRect);

  // 8/18/04
  if (GroupFieldName <> '') and (dgRowSelect in Options) then
  begin
    OldRect.Top := OldRect.Top - 1;
  end;
  InvalidateRect(Handle, @OldRect, false);
  if wwIsCustomStyle(Self)
  { and ((dgRowSelect in Options) or HaveActiveRecordColor) } then
    NewRect.Bottom := NewRect.Bottom + 1;
  // Otherwise with dgRowSelect bottom of rectangle is not correct when scrolling uip one record
  InvalidateRect(Handle, @NewRect, false);
  HideEditor; { 10/20/96 - Always hide editor if this method is called }
  if Distance <> 0 then
  begin
    HideControls;
    try
      if Abs(Distance) > VisibleRowCount then
      begin
        // 4/2/03 - Check toprow and rowchanged
        if (Distance <> 0) then
          DoTopRowChanged;
        DoCheckRowChanged;

        Invalidate;
        Exit;
      end
      else
      begin
        RowHeight := DefaultRowHeight;
        if HaveAnyRowLines then
          Inc(RowHeight);

        if odd(Distance) then
          AlternatingEven := not AlternatingEven;
{$IFNDEF GRIDESSENTIALS}
        if not PaintOptions.FastRecordScrolling then
        begin
          if not(dgTitles in Options) then
          begin
            NewRect := BoxRect(0, 0, ClientWidth, ClientHeight);
          end
          else
            NewRect := BoxRect(0, FTitleOffset, ClientWidth, ClientHeight);
          InvalidateRect(Handle, @NewRect, false);
        end
        else {$ENDIF}begin
          // Include Indicator Column.
          NewRect := BoxRect(0, FTitleOffset, ColCount - 1, 1000);
          ScrollWindowEx(Handle, 0, -RowHeight * Distance, @NewRect, @NewRect,
            0, nil, SW_Invalidate);
          if dgIndicator in Options then
          begin
            OldRect := BoxRect(0, FSelRow, ColCount - 1, FSelRow);
            InvalidateRect(Handle, @OldRect, false);
            NewRect := BoxRect(0, row, ColCount - 1, row);
            InvalidateRect(Handle, @NewRect, false);
          end;
        end
      end;
    finally { 1/2/96 - Don't show editor for memo }
      if (dgAlwaysShowEditor in Options) and (not IsWWControl(col, row)) and
        (not IsMemoField(col, row)) then
        ShowEditor;
    end;
  end;
  // if (not SuppressShowEditor) and visible then Update;
  if (Distance <> 0) then
    DoTopRowChanged;
  DoCheckRowChanged;
end;

procedure TwwCustomDBGrid.DoTopRowChanged;
begin
  if Assigned(FOnTopRowChanged) then
    FOnTopRowChanged(Self);
  if GroupFieldName <> '' then
    Invalidate;
end;

procedure TwwCustomDBGrid.DoRowChanged;
begin
  if Assigned(FOnRowChanged) then
    FOnRowChanged(Self);
  DoCellChanged;
end;

procedure TwwCustomDBGrid.DoCheckRowChanged;
var
  curBookmark: TBookmark;
  res: integer; // CmpBkmkRslt;
  tempDisable: boolean;

  function SpecialCellChanged: boolean;
  begin
    result := false;
    if Self is TwwDBGrid then
    begin
      if (TwwDBGrid(Self).Patch[7] <> row) then
        result := True;
      if GroupFieldName <> '' then
        result := True;
    end
  end;

{ function SpecialCellChanged: boolean;
  begin
  result:= False;
  if self is TwwDBGrid then
  if (TwwDBGrid(self).Patch[7]<>Row) then result:= True;
  end;
}
begin
  // if GetColField(dbCol(Col))<>Nil then
  // OriginalCellText:= GetColField(dbCol(Col)).asString
  // else OriginalCellText:= '';

  tempDisable := DisableCellChangedEvent;
  try
    if (DataSource <> nil) and (DataSource.DataSet <> Nil) and
      (DataSource.DataSet.Active) and
      (Assigned(FOnRowChanged) or Assigned(FOnCellChanged) or
      Assigned(FOnUpdateFooter) or SpecialCellChanged) then
    begin
      curBookmark := DataSource.DataSet.GetBookmark;
      if LastBookmark = nil then
      begin
        DoRowChanged;
        DisableCellChangedEvent := True;
      end
      else if curBookmark <> nil then
      begin
        { 11/24/98 - Check for nil curbookmark }
        res := wwDataSetCompareBookmarks(DataSource.DataSet, curBookmark,
          LastBookmark);
        if CompareBookmarksAltMethod then
        begin
          if (res <> 0) then
          begin
            DoRowChanged;
            DisableCellChangedEvent := True;
          end
        end
        else if (res <> CMPKeyEql) and (res <> CMPEql) then
        begin
          DoRowChanged;
          DisableCellChangedEvent := True;
        end
      end
      else if (DataSource.State = dsInsert) then
      begin
        { 1/31/99 - Support OnRowChanged for insert }
        if (LastBookmark <> nil) then
        begin
          DoRowChanged;
          DisableCellChangedEvent := True;
        end
      end;

      if LastBookmark <> nil then
        DataSource.DataSet.FreeBookmark(LastBookmark);
      LastBookmark := curBookmark;
    end;

    if CallColEnter then
    begin
      CallColEnter := false;
      ColEnter;
      DoUpdateFooter;
    end;
  finally
    DisableCellChangedEvent := tempDisable;
  end;

  FreeHintWindow;

end;

procedure TwwCustomDBGrid.TitleFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not(csLoading in ComponentState) then
    ParentFont := false;
  if dgTitles in Options then
    LayoutChanged;
end;

procedure TwwCustomDBGrid.UpdateData;
var
  NewDate, NewTime: TDateTime;
  editor: TwwInplaceEdit;
  FOnInvalidValue: TwwInvalidValueEvent;
  curField: TField;
  FloatValue: Extended;
  IsDateTime: boolean;
begin
  if (inplaceeditor <> nil) then
  begin
    editor := TwwInplaceEdit(inplaceeditor);
    if FDataLink.isFieldModified then
    begin
      if (editor.RegexMask.Mask <> '') then
      begin
        if not RegexMatch(editor.RegexMask.Mask,
          not editor.RegexMask.CaseSensitive, editor.Text) then
        begin
          ValidationErrorUsingMask(GetColField(DbCol(col)),
            editor.RegexMask.ErrorMessage);
        end;
      end
      else if (editor.HavePictureMask) then
      begin
        if (not editor.IsValidPictureValue(editor.Text)) and
          (not editor.Picture.AllowInvalidExit) then
        begin
          editor.DoRefreshValidationDisplay(false);

          { 7/3/97 - Use OnInvalidValue }
          FOnInvalidValue := wwGetOnInvalidValue(FDataLink.DataSet);
          if Assigned(FOnInvalidValue) then
          begin
            FOnInvalidValue(FDataLink.DataSet, GetColField(DbCol(col)));
          end
          else
            ValidationErrorUsingMask(GetColField(DbCol(col)));
          Exit; // 10/24/08
        end
        else
        begin
          editor.DoRefreshValidationDisplay(True); // DoOnCheckValue(true);
        end;
        // exit;//  10/24/08 - should not exit or data is not flushed to field
      end
    end;
  end;

  if FieldCount > 0 then
    with Fields[SelectedIndex] do
    begin
      curField := Fields[SelectedIndex];

      { Handle 2 digit year logic }
      if (Self is TwwDBGrid) then
        TwwDBGrid(Self).Patch[0] := (Text = FEditText);
      { 9/24/98 - Prevent recursion by comparing text }

      // 3/17/06
      IsDateTime := (Fields[SelectedIndex] is TDateTimeField) or
        ((Fields[SelectedIndex] <> nil) and (Fields[SelectedIndex].DataType
        in [ftDate, ftDateTime, ftTimeStamp, ftTime]));

      if (IsDateTime) and
      // if (Fields[SelectedIndex] is TDateTimeField) and
        wwStrToDate(FEditText) then
      begin
        { Uses 1950 as Epoch Date for 2 digt years }
        if wwScanDate(FEditText, NewDate) then
        { 10/12/98 - Avoid converting 4 digit years }
        begin
          NewTime := Frac(StrToDateTime(FEditText));
          TDateTimeField(Fields[SelectedIndex]).asDateTime := NewDate + NewTime;
        end;
      end
      else
      begin
        { if JustHaveLiteralTemplate then
          Clear
          else }
        if ((curField is TIntegerField) or (curField is TFloatField)) and
          (FEditText <> '') and
        // If text is blank then don't do formatting code
          (TNumericField(curField).DisplayFormat <> '') then
        begin
          if wwStrToFloat2(FEditText, FloatValue, TNumericField(curField)
            .DisplayFormat) then
          begin
            if curField is TFloatField then
              curField.asFloat := FloatValue
            else if curField is TIntegerField then
            begin
              curField.asInteger := Round(FloatValue)
            end
          end
          else
            Text := FEditText;
        end
        else
          Text := FEditText;
      end;

      if (Self is TwwDBGrid) and (TwwDBGrid(Self).Patch[0] = false) then
        FieldChanged(Fields[SelectedIndex]); { 9/2/98 }
    end
end;

procedure TwwCustomDBGrid.UpdateActive;
var
  NewRow: integer;
begin
  if FDataLink.Active then
  begin
    NewRow := FDataLink.ActiveRecord + FTitleOffset + RowOffset;
    if row <> NewRow then
    begin
      if not(dgAlwaysShowEditor in Options) then
        HideEditor;
      if NewRow > VisibleRowCount then
      begin
        UpdateRowCount; { Avoid index out of range }
        NewRow := VisibleRowCount + FTitleOffset - 1;
        { 12/7/96 - Subtract 1 }
      end;
      if (NewRow >= 0) and (NewRow < VisibleRowCount + FTitleOffset) and
        (NewRow < RowCount) then // 1/20/11 - Avoid index out of range
        MoveColRow(col, NewRow, false, false);
    end;
    { 2/21/2000 - Fix bug introduced by Delphi 5 Patch 1 - Need to make sure this code is not executed for lookupcombo }
    if not wwIsClass(parent.classtype, 'TwwDBCustomLookupcombo') then
    begin
      if (SelectedIndex >= 0) and (FieldCount > 0) and
         (not datasource.DataSet.Eof) and (not Datasource.DataSet.Bof) and // 8/24/12 - Check this in case of ADODataSet yielding EOF or BOF
        (Fields[SelectedIndex].Text <> FEditText) then
        InvalidateEditor;
    end
  end;
end;

function TwwCustomDBGrid.GetColField(ACol: integer): TField;
begin
  result := nil;
  if (ACol >= 0) and FDataLink.Active and (ACol < FDataLink.FieldCount) then
    result := FDataLink.Fields[ACol];
end;

function TwwCustomDBGrid.GetFieldValue(ACol: integer): string;
var
  Field: TField;
begin
  result := '';
  Field := GetColField(ACol);
  if Field <> nil then
    result := Field.DisplayText;
end;

function TwwCustomDBGrid.WideGetFieldValue(ACol: integer): WideString;
var
  Field: TField;
begin
  result := '';
  Field := GetColField(ACol);
  if Field <> nil then
    result := Field.DisplayText;
end;

{
  function TwwCustomDBGrid.DefaultTitleImageList: TImageList;
  begin
  if FDefaultTitleImageList=nil then
  begin
  InitDefaultTitleImages;
  FDefaultTitleImageList:= TImageList.Create(nil);
  end
  else
  end;
}
function TwwCustomDBGrid.EffectiveTitleImageList: TImageList;
begin
  if FTitleImageList = nil then
  begin
    if DefaultTitleImages = nil then
      InitDefaultTitleImages;
    result := DefaultTitleImages;
  end
  else
    result := FTitleImageList;
end;

function TwwCustomDBGrid.RecordCountIsValid: boolean;
begin
  result := (FDataLink <> nil) and FDataLink.Active and
    (FDataLink.DataSet <> nil) and FDataLink.DataSet.Active;
end;

procedure TwwCustomDBGrid.UpdateScrollBar;
var
  sequencable: boolean;
  SIOld, SINew: TScrollInfo;
begin
  if not FShowVertScrollBar then
    Exit;

  // 2/1/2001 - Add check to see if dataset is active as well. (PYW)
  if FDataLink.Active and FDataLink.DataSet.Active and HandleAllocated then
  begin
    { Set scroll bar precisely }
    sequencable := FDataLink.DataSet.isSequenced;
    if sequencable then
      FDataLink.DataSet.UpdateCursorPos;

    { Support proportional scrollbar }
    SIOld.cbSize := SizeOf(SIOld);
    SIOld.fMask := SIF_ALL;
    GetScrollInfo(Self.Handle, SB_VERT, SIOld);
    SINew := SIOld;

    if sequencable then
      with FDataLink.DataSet do
      begin
        SINew.nMin := 1;
        SINew.nPage := Self.VisibleRowCount;
        SINew.nMax := integer(DWORD(RecordCount) + SINew.nPage - 1);
        if State in [dsInactive, dsBrowse, dsEdit] then
          SINew.nPos := RecNo; // else keep old pos
      end
    else
    begin
      SINew.nMin := 0;
      SINew.nPage := 0;
      SINew.nMax := 4;
      if FDataLink.BOF then
        SINew.nPos := 0
      else if FDataLink.EOF then
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
      SetScrollInfo(Self.Handle, SB_VERT, SINew, True);
    end
  end

end;
{
  function TwwCustomDBGrid.CalcVariableRowCount: integer;
  var TotalRowHeight: integer;
  i: Integer;
  NewActiveRecord, OldActiveRecord, shiftamount: integer;
  begin
  if dgVariableRowHeight in Options then
  begin
  TotalRowHeight:= RowHeights[0];
  if FVDataLink.Active then begin
  OldActiveRecord:= DataLink.ActiveRecord;
  NewActiveRecord:= FVDataLink.ActiveRecord;
  ShiftAmount:= NewActiveRecord-OldActiveRecord;

  // Increase buffercount so that later rows can be checked.
  FVDataLink.BufferCount:=
  FVDataLink.BufferCount + ShiftAmount;
  NewActiveRecord:= FVDataLink.ActiveRecord;
  ShiftAmount:= NewActiveRecord-OldActiveRecord;

  for i:= 0 to FVDataLink.RecordCount-1 do begin
  FVDataLink.ActiveRecord:= i+ShiftAmount;
  if odd(datasource.dataset.fieldbyname('customer no').asinteger) then
  TotalRowHeight:= TotalRowHeight + 15 + 2
  else
  TotalRowHeight:= TotalRowHeight + 45 + 2;
  if TotalRowHeight>ClientHeight then break;
  if i+ShiftAmount>=FVDataLink.RecordCount then break;
  end;
  FVDataLink.ActiveRecord:= NewActiveRecord;
  result:= i+1;
  end
  else result:= RowCount;


  end;
  end;
}

procedure TwwCustomDBGrid.UpdateRowCount;
var
  OldLeftCol: integer;
  // 6/17/10 - Fix problem with phantom column appearing because of EndUpdate being called without matching BeginUpdate
  BeginUpdateCalled: boolean;
begin
  if InUpdateRowCount then
    Exit; { Prevent recursion }
  InUpdateRowCount := True;
  OldLeftCol := 1; { Make compiler happy }
  BeginUpdateCalled := false;

  if not(csDesigning in ComponentState) then
  // 10/30/08 - Can paint wrong at design time
  begin
    if (dgRowSelect in Options) or ((dgFixedEditable in Options) and
      (LeftCol <= FixedCols)) then
    begin
      OldLeftCol := LeftCol;
      // Windows.GetUpdateRect(Handle, tempUpdateRect, false);
      BeginUpdate;
      BeginUpdateCalled := True;
    end;
  end;

  if RowCount <= FTitleOffset then
    RowCount := FTitleOffset + 1;
  FixedRows := FTitleOffset;
  with FDataLink do
    // 12/12/01 - Set rowcount to 1+FTitleOffset if recordcount is not valid
    // Otherwise can set rowcount to 0, which is not desirable in this case.
    if (not Active) or (not RecordCountIsValid) or (RecordCount = 0) then
      // if (not Active) or (RecordCountIsValid and (RecordCount = 0)) then
      RowCount := 1 + FTitleOffset
    else
    begin
      RowCount := 1000;

      { 6/23/97 - Toprow has changed so repaint grid }
      if (FDataLink.Buffercount > VisibleRowCount) and
        (row >= VisibleRowCount + FTitleOffset) then
      begin
        Invalidate;
        DoTopRowChanged;
      end;

      { if dgVariableRowHeight in Options then
        begin
        FVDataLink.BufferCount:= ClientHeight div DefaultRowHeight;
        FDataLink.BufferCount := CalcVariableRowCount -1;
        RowCount := RecordCount + 1 + FTitleOffset;
        end
        else begin
      }
      FDataLink.Buffercount := VisibleRowCount;
      RowCount := RecordCount + FTitleOffset { -RowOffset };
      { end; }
      UpdateActive;
    end;

  if not(csDesigning in ComponentState) then
  // 10/30/08 - Can paint wrong at design time
  begin
    if (dgRowSelect in Options) or ((dgFixedEditable in Options) and
      BeginUpdateCalled and (OldLeftCol <= FixedCols)) then
    // 5/29/09 - Use OldLeftCol so that EndUpdate always gets called
    begin
      UpdateRowCount;
      if OldLeftCol < ColCount then
        LeftCol := OldLeftCol;
      EndUpdate(false);
      // InvalidateRect(Handle, @TempUpdateRect, False);
      Invalidate;
    end;
  end;

  InUpdateRowCount := false;
end;

function TwwCustomDBGrid.AcquireFocus: boolean;
begin
  result := True;
  if FAcquireFocus and CanFocus and not(csDesigning in ComponentState) then
  begin
    SetFocus;
    result := Focused or (inplaceeditor <> nil) and inplaceeditor.Focused;
  end;
end;

procedure TwwCustomDBGrid.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      TitleFont := Font;
    finally
      FSelfChangingTitleFont := false;
    end;
    LayoutChanged;
  end;
end;

Function TwwCustomDBGrid.AllowCancelOnExit: boolean;
begin
  result := True;
end;

procedure TwwCustomDBGrid.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FFocused := True;
  if (HaveActiveRecordColor) and not(dgAlwaysShowSelection in Options) then
    InvalidateCurrentRow;
  if KeyHook = 0 then
    KeyHook := SetWindowsHookEx(WH_KEYBOARD, @wwHookKeyProc, HInstance,
      GetCurrentThreadID);

end;

procedure TwwCustomDBGrid.CMExit(var Message: TMessage);
var
  oldcol, oldrow: integer;
  TempRect: TRect;
begin
  if (KeyHook <> 0) and not(parent is TCustomGrid) then
  begin
    UnhookWindowsHookEx(KeyHook);
    KeyHook := 0;
  end;

  try
    if FDataLink.Active then
      with FDataLink.DataSet do
        if (dgCancelOnExit in Options) and (State = dsInsert) and
          not Modified and not FDataLink.FModified and AllowCancelOnExit then
          Cancel
        else
          FDataLink.UpdateData;
    if not(dgAlwaysShowSelection in Options) then
      InvalidateCurrentRow;
  except
    SetFocus;
    // 1/9/2002 - Call raise when patch variable set to allow messages from onvalidate to fire when focus exits grid.
    if (FDataLink.FGrid <> nil) and (FDataLink.FGrid is TwwDBGrid) and
      TwwDBGrid(FDataLink.FGrid).Patch[5] then
      raise
    else
      Exit;
    { Raise causes problems with Delphi being confused on who has focus }
    // raise;
  end;
  inherited;
  FFocused := false;

  // 9/3/03 - Fix line for grouping where top line was left
  if GroupFieldName <> '' then
  begin
    oldcol := TwwDBGrid(Self).Patch[6];
    oldrow := TwwDBGrid(Self).Patch[7];

    TempRect := CellRect(oldcol, oldrow);
    TempRect.Top := TempRect.Top - 1;
    InvalidateRect(Handle, @TempRect, false);
    TempRect := CellRect(col, row);
    TempRect.Top := TempRect.Top - 1;
    InvalidateRect(Handle, @TempRect, false);
  end;

end;

procedure TwwCustomDBGrid.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TwwCustomDBGrid.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  inherited;
  if Msg.result = 0 then
    with MouseCoord(Msg.Pos.X, Msg.Pos.Y) do
      if (X >= FIndicatorOffset) and (Y < FTitleOffset) then
        Msg.result := 1;
  if (Msg.result = 1) and ((FDataLink = nil) or FDataLink.DefaultFields or
    not FDataLink.Active) then
    Msg.result := 0;
end;

procedure TwwCustomDBGrid.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (csDesigning in ComponentState) and
    ((FDataLink = nil) or not FDataLink.Active) then
    Windows.SetCursor(LoadCursor(0, IDC_ARROW))
  else
    inherited;
end;

procedure TwwCustomDBGrid.WMSize(var Message: TWMSize);
begin
  CollapseChildGrid; // Don't show child grid when resizing grid

  if IsProportionalColumns then
  begin
    if ColCount - FIndicatorOffset > 0 then
    begin
      // 6/13/2001- PYW-Add ability to keep FixedColumns to remain the same width when resizing grid.
      if (dgFixedProportionalResize in Options) and (FixedCols > 1) then
      begin
        if Self is TwwDBGrid then
          TwwDBGrid(Self).Patch[8] := True;
        FSizingIndex := FixedCols - 1;
        ProportionalColWidths; // Called too often!
        if Self is TwwDBGrid then
          TwwDBGrid(Self).Patch[8] := false;
        FSizingIndex := -1;
      end
      else
        ProportionalColWidths; // Called too often!
    end;
  end;
  {
    if (FSavePrevGridWidth <> ClientWidth) and (FieldCount > 0) then begin
    if dgIndicator in Options then begin
    startcol := 1;
    sFactor := (ClientWidth-4-ColWidthsPixels[0])/(FSavePrevGridWidth-4-ColWidthspixels[0]);
    end
    else begin
    startcol := 0;
    sFactor := (ClientWidth-4)/(FSavePrevGridWidth-4);
    end;
    for i:= startcol to ColCount-1 do
    ColWidthsPixels[i]:=Trunc((ColWidthsPixels[i]*sFactor)+0.5);
    end;
    FSavePrevGridWidth := ClientWidth;
    end
    else ProportionalColWidths(ColCount-FIndicatorOffset);  // Called too often!
  }

  inherited;
  if FUpdateLock = 0 then
  begin
    HideControls; { 10/9/96 - in case of resize }
    HideEditor; { 10/9/96 - in case of resize }
    UpdateRowCount;
    if AllowPerfectFit then
      DoPerfectFit;

    { 9/2/98 - Fix bug where footer is not cleared when maximizing }
    if (DataSource <> nil) and (DataSource.DataSet <> nil) and
      (FDataLink <> Nil) and (FDataLink.Active) and
      (DataSource.DataSet.BOF and DataSource.DataSet.EOF) then
      Invalidate;
  end;
{$IFNDEF GRIDESSENTIALS}
  PaintOptions.InitBlendBitmapsFlag := True;
{$ENDIF}
  if UseRightToLeftAlignment then
  begin
    if IndicatorButton <> nil then
      with IndicatorButton do
        SetBounds(Left, Top, Width, Height);
  end;

end;

Function TwwCustomDBGrid.IsScrollBarVisible: boolean;
  function getWidth: integer;
  var
    I: integer;
    CWidth: integer;
    tempGridLineWidth: integer;
  begin
    if dgColLines in Options then
      tempGridLineWidth := GridLineWidth
    else
      tempGridLineWidth := 0;

    CWidth := 1;
    if ShowVertScrollBar then
      CWidth := GetSystemMetrics(SM_CXHThumb) + 1;
    for I := 0 to ColCount - 1 do
      CWidth := CWidth + ColWidths[I] + tempGridLineWidth;
    result := CWidth;
  end;

begin
  if (getWidth > Width) then
  begin
    if ScrollBars in [ssBoth, ssHorizontal] then
      // if ShowHorzScrollBar then
      result := True
    else
      result := false;
  end
  else
    result := false;
end;

Function TwwCustomDBGrid.AllowPerfectFit: boolean;
begin
  result := false;
  if not(Align in [alTop, alBottom, alClient]) and (dgPerfectRowFit in Options)
  then
    if (csDesigning in ComponentState) and not(csLoading in ComponentState) then
      result := True;
end;

Function TwwCustomDBGrid.DoPerfectFit: boolean;
var
  newHeight: integer;
  NextToBottomCell: TRect;
  BottomCellTop: integer;
  offset: integer;
  ScrollBarVisible: boolean;
begin
  // if dgVariableRowHeight in Options then exit;
  NextToBottomCell := CellRect(0, RowCount - 1);
  BottomCellTop := NextToBottomCell.Top + DefaultRowHeight + 1;
  newHeight := Height;
  ScrollBarVisible := IsScrollBarVisible;
  if ScrollBarVisible then
    offset := 5
  else
    offset := 4;
  if not Ctl3D then
    offset := offset - 3;
  if (ScrollBarVisible) then
  begin
    if ((BottomCellTop + GetSystemMetrics(SM_CYHSCROLL) + DefaultRowHeight +
      offset - 1) > Self.Height) then
    begin
      newHeight := BottomCellTop + GetSystemMetrics(SM_CYHSCROLL) + offset - 1;
    end
  end
  else
  begin
    if ((BottomCellTop + DefaultRowHeight + offset) > Self.Height) then
    begin
      newHeight := BottomCellTop + offset;
    end
  end;

  { Auto-shrink grid height }
  if (newHeight <> Height) then
  begin
    Height := newHeight;
    result := True;
  end
  else
    result := false;
end;

Function TwwCustomDBGrid.DoShrinkToFit: boolean;
var
  newHeight: integer;
  NextToBottomCell: TRect;
  BottomCellTop: integer;
  // offset: integer;
  ScrollBarVisible: boolean;
begin
  // if dgVariableRowHeight in Options then exit;
  NextToBottomCell := CellRect(0, RowCount - 1);
  BottomCellTop := NextToBottomCell.Top + DefaultRowHeight + 1;
  ScrollBarVisible := IsScrollBarVisible;
  // if ScrollBarVisible then offset:= 5
  // else offset:= 4;
  if (ScrollBarVisible) then
  begin
    newHeight := BottomCellTop + GetSystemMetrics(SM_CYHSCROLL) + 1;
  end
  else
  begin
    newHeight := BottomCellTop + 1;
  end;

  newHeight := newHeight + GetEffectiveFooterHeight;

  { Auto-shrink grid height }
  if (newHeight < Height) then
  begin
    Height := newHeight;
    result := True;
  end
  else
    result := false;
end;

procedure TwwCustomDBGrid.WMVScroll(var Message: TWMVScroll);
  procedure NextRow;
  begin
    with FDataLink.DataSet do
    begin
      if (State = dsInsert) and not Modified and not FDataLink.FModified then
        if EOF then
          Exit
        else
          Cancel
      else
      begin
        { Already pointing to end of table but active record is before this. 10/15/96 - dsInsert should not increment }
        if EOF and (FDataLink.ActiveRecord >= 0) and
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
    with FDataLink.DataSet do
      if (State = dsInsert) and not Modified and EOF and not FDataLink.FModified
      then
        Cancel
      else
      begin
        if BOF and (FDataLink.ActiveRecord > 0) then
          FDataLink.ActiveRecord := FDataLink.ActiveRecord - 1
        else
          Prior;
      end
  end;

  Function sequencable: boolean;
  begin
    result := FDataLink.DataSet.isSequenced;
  end;

  procedure ParadoxPosition;
  var
    SI: TScrollInfo;
    flag: boolean;
  begin
    flag := false;
    with FDataLink.DataSet do
    begin
      { Support proportional scrollbar }
      SI.cbSize := SizeOf(SI);
      SI.fMask := SIF_ALL;
      GetScrollInfo(Self.Handle, SB_VERT, SI);
      CheckBrowseMode;

      if SI.nTrackPos <> RecNo then
        flag := True;
      if SI.nTrackPos <= 1 then
        First
      else if SI.nTrackPos >= RecordCount then
        Last
      else
        RecNo := SI.nTrackPos;

      // 10/16/11 - It does not seem like we need resync.
      // In custom styles it actually causes a problem in that it doesn't scroll continually
      // Resync([]);
      if flag then
        DoTopRowChanged;
    end;
  end;

begin
  if CurrentCustomEdit <> nil then
    CurrentCustomEdit.Left := ClientWidth + 10;

  if not AcquireFocus then
    Exit;
  if FDataLink.Active then
    with Message, FDataLink.DataSet, FDataLink do
      case ScrollCode of
        SB_LINEUP:
          PriorRow;
        SB_LINEDOWN:
          NextRow;
        SB_PAGEUP:
          MoveBy(-VisibleRowCount);
        SB_PAGEDOWN:
          MoveBy(VisibleRowCount);
        SB_THUMBPOSITION:
          begin
            if sequencable then
            begin
              ParadoxPosition;
            end
            else
            begin
              case Pos of
                0:
                  First;
                1:
                  MoveBy(-VisibleRowCount);
                2:
                  Exit;
                3:
                  MoveBy(VisibleRowCount);
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
end;

function TwwCustomDBGrid.HighlightCell(DataCol, DataRow: integer;
  const value: string; AState: TGridDrawState): boolean;
begin
  result := (gdSelected in AState) or
    ((DataRow = DbRow(row)) and (HaveActiveRecordColor));
  // (dgRowSelectEditable in Options));
  if result then
  begin
    if not((dgAlwaysShowSelection in Options) or
      (FFocused and not IsDropDownGridFocused)) then
      result := false;
  end;
  // Result := (gdSelected in AState) and ((dgAlwaysShowSelection in Options) or
  // (FFocused and not IsDropDownGridFocused));
  if (dgMultiSelect in Options) and not(gdFixed in AState) then
  { 2/21/99 - RSW, Don't highlight if fixed }
  begin
    result := IsSelectedRow(DataRow);
  end
end;

function TwwCustomDBGrid.UseRightToLeftAlignmentForField(const AField: TField;
  Alignment: TAlignment): boolean;
begin
  result := false;
  if IsRightToLeft then
    result := OkToChangeFieldAlignment(AField, Alignment);
end;

procedure TwwCustomDBGrid.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
// const
// Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT,
// DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  Alignment: TAlignment;
  value: WideString;
  ACol: integer;
  curField: TField;
  WriteOptions: TwwWriteTextOptions;
  CustomControl: TWinControl;
begin
  for ACol := 0 to ColCount - 1 do
  begin
    curField := GetColField(ACol);
    if curField = Nil then
      continue;
    if curField = Field then
      break;
  end;
  // if TwwCacheColInfoItem(FCacheColInfo[ACol+FIndicatorOffset]).ControlType<>'' then exit;
  if (TwwCacheColInfoItem(FCacheColInfo[ACol + FIndicatorOffset]).ControlType
    <> '') then
  begin
    CustomControl := TwwCacheColInfoItem(FCacheColInfo[ACol + FIndicatorOffset])
      .CustomControl;

    if (CustomControl = nil) then
      Exit; // i.e. imageindex, checkbox, etc.

    // 3/14/02 - Only exit for alwayspaints or in all cases for certain Infopower controls
    if wwIsClass(CustomControl.classtype, 'TwwExpandButton') or
      wwIsClass(CustomControl.classtype, 'TwwRadioGroup') or
      wwIsClass(CustomControl.classtype, 'TwwButton') or
      wwIsClass(CustomControl.classtype, 'TwwCheckbox') or
      wwIsClass(CustomControl.classtype, 'TwwMonthCalendar') then
      Exit;
  end;

  Alignment := taLeftJustify;
  value := '';
  if Field <> nil then
  begin
    Alignment := Field.Alignment;
    value := Field.DisplayText;
  end;
  WriteOptions := [];
  WriteTextLines(Canvas, Rect, 2, 2, PWideChar(value), Alignment, WriteOptions);
end;

Function TwwCustomDBGrid.CellColor(ACol, ARow: integer): TColor;
begin
  result := Color;
end;

procedure TwwCustomDBGrid.DrawCheckBox_Checkmark(ARect: TRect;
  ACol, ARow: integer; val: boolean);
const
  ItemChecked: array [boolean] of integer = (0, DFCS_CHECKED);
  CheckBoxFlat: array [boolean] of integer = (0, DFCS_FLAT);
  CheckboxDisabled: array [boolean] of integer = (0, DFCS_INACTIVE);
var
  Temp: integer;
{$IFDEF wwUseThemeManager}
  Details: TThemedElementDetails;
  CheckboxStyle: TThemedButton;
  PaintRect: TRect;
{$ENDIF}
begin
  ARect.Left := ARect.Left - 1;
  ARect.Top := ARect.Top - 1;
  ARect.Right := ARect.Right + 2;
  if not wwIsCustomStyle(Self) then
    ARect.Bottom := ARect.Bottom + 2
  else
    ARect.Bottom := ARect.Bottom + 1;

  if UseRightToLeftAlignment then
  // 6/29/02 - Workaround bug in DrawFrameControl with bidi mode
  begin
    Temp := ARect.Left;
    ARect.Left := ARect.Right - 1;
    ARect.Right := ARect.Right + ARect.Right - Temp - 1;
  end;

  // tbCheckBoxUncheckedNormal, tbCheckBoxUncheckedHot, tbCheckBoxUncheckedPressed, tbCheckBoxUncheckedDisabled,
  // tbCheckBoxCheckedNormal, tbCheckBoxCheckedHot, tbCheckBoxCheckedPressed, tbCheckBoxCheckedDisabled,
  // tbCheckBoxMixedNormal, tbCheckBoxMixedHot, tbCheckBoxMixedPressed, tbCheckBoxMixedDisabled,

  if wwUseThemes(Self) then
  begin
{$IFDEF wwUseThemeManager}
    if ColumnByName(GetColField(DbCol(ACol)).FieldName).ReadOnly then
    begin
      if val then
        CheckboxStyle := tbCheckboxCheckedDisabled
      else
        CheckboxStyle := tbCheckboxUnCheckedDisabled
    end
    else
    begin
      if val then
        CheckboxStyle := tbCheckboxCheckedNormal
      else
        CheckboxStyle := tbCheckboxUnCheckedNormal
    end;
    Details := StyleServices.GetElementDetails(CheckboxStyle);
    PaintRect := ARect;
    StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
    StyleServices.GetElementContentRect(Canvas.Handle, Details, PaintRect,
      PaintRect);
{$ENDIF}
  end
  else
  begin
    DrawFrameControl(Canvas.Handle, ARect, DFC_BUTTON, DFCS_BUTTONCHECK or
      ItemChecked[val] or CheckBoxFlat
      [wwInternational.CheckBoxInGridStyle = cbStyleCheckmarkFlat] or
      CheckboxDisabled[ColumnByName(GetColField(DbCol(ACol)).FieldName)
      .ReadOnly]);
  end
end;

procedure TwwCustomDBGrid.DrawCheckBox(ARect: TRect; ACol, ARow: integer;
  val: boolean);
const
  CheckboxDisabled: array [boolean] of integer = (0, DFCS_INACTIVE);
var
  ACanvas: TCanvas;
  TempRect: TRect;
  Temp: integer;
begin
  if (wwInternational.CheckBoxInGridStyle in [cbStyleCheckmark,
    cbStyleCheckmarkFlat]) or
    (NewStyleControls and (wwInternational.CheckBoxInGridStyle = cbStyleAuto))
  then
  begin
    DrawCheckBox_Checkmark(ARect, ACol, ARow, val);
    Exit;
  end;

  TempRect := Rect(ARect.Left - 1, ARect.Top - 1, ARect.Right + 2,
    ARect.Bottom + 2);

  if wwIsCustomStyle(Self) then
    TempRect.Bottom := TempRect.Bottom - 1;

  if UseRightToLeftAlignment then
  // 6/29/02 - Workaround bug in DrawFrameControl with bidi mode
  begin
    Temp := TempRect.Left;
    TempRect.Left := TempRect.Right - 1;
    TempRect.Right := TempRect.Right + (TempRect.Right - Temp - 1);
  end;

  DrawFrameControl(Canvas.Handle, TempRect, DFC_BUTTON, DFCS_BUTTONCHECK or
    CheckboxDisabled[ColumnByName(GetColField(DbCol(ACol)).FieldName)
    .ReadOnly]);

  ACanvas := Canvas;
  ACanvas.Pen.Width := 1;
  if val then
  begin
    ACanvas.Pen.Color := clBlack;

    { Draw checkbox lines }
    ACanvas.MoveTo(ARect.Right - 2, ARect.Top + 2);
    ACanvas.LineTo(ARect.Left + 1, ARect.Bottom - 1);
    ACanvas.MoveTo(ARect.Right - 3, ARect.Top + 2);
    ACanvas.LineTo(ARect.Left + 1, ARect.Bottom - 2);
    ACanvas.MoveTo(ARect.Right - 2, ARect.Top + 3);
    ACanvas.LineTo(ARect.Left + 2, ARect.Bottom - 1);

    ACanvas.MoveTo(ARect.Left + 2, ARect.Top + 2);
    ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    ACanvas.MoveTo(ARect.Left + 3, ARect.Top + 2);
    ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 2);
    ACanvas.MoveTo(ARect.Left + 2, ARect.Top + 3);
    ACanvas.LineTo(ARect.Right - 2, ARect.Bottom - 1);
  end;
end;

procedure TwwCustomDBGrid.FillWithAlternatingRowBitmap(TempRect: TRect);
var
  OldBrushColor: TColor;
  IsCustomStyle: boolean;
begin
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  if (not IsCustomStyle) and (PaintOptions.AlternatingColorBitmap <> nil) then
    Canvas.CopyRect(TempRect,
      PaintOptions.AlternatingColorBitmap.Canvas, TempRect)
  else
  begin
    OldBrushColor := Canvas.Brush.Color;
    Canvas.Brush.Color := PaintOptions.AlternatingRowColor;
    Canvas.FillRect(TempRect);
    Canvas.Brush.Color := OldBrushColor;
  end
end;

function TwwCustomDBGrid.UseAlternatingRow(CurRelRow: integer): boolean;
begin
  if (PaintOptions.AlternatingRowColor <> clNone) and
    (arrDataColumns in PaintOptions.AlternatingRowRegions) and (CurRelRow >= 0)
    and (odd(CurRelRow) xor AlternatingEven) then
    result := True
  else
    result := false;
end;

function TwwCustomDBGrid.UseAlternatingRowFixed(CurRelRow: integer): boolean;
begin
  if (PaintOptions.AlternatingRowColor <> clNone) and
    (arrFixedColumns in PaintOptions.AlternatingRowRegions) and (CurRelRow >= 0)
    and (odd(CurRelRow) xor AlternatingEven) then
    result := True
  else
    result := false;
end;

procedure TwwCustomDBGrid.FillWithBlendBitmap(TempRect: TRect;
  CurRelRow: integer; FillColor: TColor = clNone);
var
  IsCustomStyle: boolean;
begin
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  if UseAlternatingRow(CurRelRow) then
  begin
    if not(dgColLinesDisableFixed in Options) then
      TempRect.Left := TempRect.Left - 1;
    if not(dgRowLines in Options) and not(dgHideBottomDataLine in Options) then
      TempRect.Bottom := TempRect.Bottom + 1;
    FillWithAlternatingRowBitmap(TempRect);
  end
  else if (not IsCustomStyle) and PaintOptions.HaveBackgroundForDataCells then
  begin
    // Don't expand rectangle, as it makes focusrect miss some lines when other cells draw
    // TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    if not(dgRowLines in Options) and not(dgHideBottomDataLine in Options) then
      TempRect.Bottom := TempRect.Bottom + 1;
    Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.Canvas, TempRect);
  end
  else if Assigned(FOnBeforePaint) then
    Exit
  else if FillColor = clNone then
  begin
    Canvas.FillRect(TempRect);
  end
  else
  begin
    Canvas.Brush.Color := FillColor;
    Canvas.FillRect(TempRect);
  end;
end;

procedure TwwCustomDBGrid.FillWithFixedBitmap(TempRect: TRect;
  CurRelRow: integer; FillColor: TColor = clNone);
var
  IsCustomStyle: boolean;
begin
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  if UseAlternatingRowFixed(CurRelRow) then
  begin
    FillWithAlternatingRowBitmap(TempRect);
  end
  else if (not IsCustomStyle) and (PaintOptions.Column1Bitmap <> nil) then
  begin
    Canvas.CopyRect(TempRect, PaintOptions.Column1Bitmap.Canvas, TempRect);
  end
  else if FillColor = clNone then
  begin
    Canvas.FillRect(TempRect);
  end
  else
  begin
    Canvas.Brush.Color := FillColor;
    Canvas.FillRect(TempRect);
  end;
end;

Function TwwCustomDBGrid.UseThemesInTitle: boolean;
begin
  result := false;
  if wwUseThemes(Self) and (not DisableThemesInTitle) then
  begin
    if wwIsCustomStyle(Self) or (PaintOptions.Row1Bitmap = nil) then
    // if custom style, ignore bitmap
    begin
      result := True;
    end
  end
end;

procedure TwwCustomDBGrid.DoOnBeforeDrawCell(ATextWide: WideString;
  var DrawCellInfo: TwwCustomDrawGridCellInfo);
var
  AText: string;
begin
  AText := ATextWide;

  if GroupFieldName <> '' then
    with DrawCellInfo do
    begin
      // 9/3/03 - Make case insensitive for GroupFieldName
      if (Field <> nil) and
        (AnsiUpperCase(Field.FieldName) = AnsiUpperCase(FGroupFieldName)) and
        (DrawCellInfo.DataRow >= 0) then
      begin
        if GetNextRecordText(Field.FieldName, AText) and (AText = Field.asstring)
        then
          DrawCellInfo.DefaultDrawHorzBottomLine := false;

        if GetPriorRecordText(Field.FieldName, AText) and
          (AText = Field.asstring) then
        begin
          DrawCellInfo.DefaultDrawContents := false;
          DrawCellInfo.DefaultDrawHorzTopLine := false;
        end
      end
    end;
end;

procedure TwwCustomDBGrid.DoOnAfterDrawCell(var DrawCellInfo
  : TwwCustomDrawGridCellInfo);
var
  curField: TField;
  AText: String;
  OldActive: integer;
begin
  OldActive := 0; // Make compiler happy

  if Assigned(OnAfterDrawCell) or (GroupFieldName <> '') then
  begin
    if DrawCellInfo.DataRow >= 0 then
    begin
      OldActive := FDataLink.ActiveRecord;
      FDataLink.ActiveRecord := DrawCellInfo.DataRow;
    end;
    try
      // 7/8/04 - Check datasource is valid first
      if (GroupFieldName <> '') and (DataSource <> nil) and
        (DataSource.DataSet <> nil) then
        with DrawCellInfo do
        begin
          curField := DataSource.DataSet.FindField(GroupFieldName);
          if (curField <> nil) and (DrawCellInfo.DataRow >= 0) then
          begin
            if GetNextRecordText(curField.FieldName, AText) and
              (AText <> curField.asstring) then
            begin
              Canvas.Pen.Color := LineColors.GroupingColor; // clBlack;
              Canvas.PolyLine([Point(DrawCellInfo.Rect.Left,
                DrawCellInfo.Rect.Bottom), Point(DrawCellInfo.Rect.Right,
                DrawCellInfo.Rect.Bottom)]);
            end
          end
        end;

      if Assigned(OnAfterDrawCell) then
      begin
        if wwGridEssentials then
          DisplayProfessionalVersionOnlyMessage(Self,
            'OnAfterDrawCell only supported in InfoPower Professional');
        FOnAfterDrawCell(Self, DrawCellInfo);
      end;
    finally
      if DrawCellInfo.DataRow >= 0 then
        FDataLink.ActiveRecord := OldActive;
    end;
  end
end;

function TwwCustomDBGrid.HaveActiveRecordColor: boolean;
begin
  result := (PaintOptions.ActiveRecordColor <> clNone);
end;

function TwwCustomDBGrid.HaveAlternatingRowColor: boolean;
begin
{$IFNDEF GRIDESSENTIALS}
  result := (PaintOptions.AlternatingRowColor <> clNone);
{$ELSE}
  result := false;
{$ENDIF}
end;
(*
  // Called only by styles - so paint transapently
  procedure TwwCustomDBGrid.InheritedDrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
  const
  StyleFontColors: array [boolean] of TStyleFont = (sfGridItemNormal,
  sfGridItemSelected);
  var
  FrameOffs: Byte;
  xoffset: integer;

  function RowIsMultiSelected: boolean;
  var
  Index: integer;
  begin
  result := (dgMultiSelect in Options) and DataLink.Active and IsSelected
  // FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

  var
  OldActive: integer;
  Indicator: TThemedGrid;
  value: string;
  DrawColumn: TwwColumn;
  MultiSelected: boolean;
  ALeft: integer;
  IsCustomStyle: boolean;
  Style: TCustomStyleServices;
  Field: TField;
  Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions;
  begin
  Style := StyleServices;
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  if csLoading in ComponentState then
  begin
  if IsCustomStyle then
  Canvas.Brush.Color := Style.GetStyleColor(scGrid)
  else
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ARect);
  Exit;
  end;

  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options = [dgRowLines,
  dgColLines]) then
  begin
  InflateRect(ARect, -1, -1);
  FrameOffs := 1;
  end
  else
  FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
  DrawCellBackground(ARect, FixedColor, AState, ACol, ARow);
  if Assigned(DataLink) and DataLink.Active then
  begin
  MultiSelected := false;
  if ARow >= 0 then
  begin
  OldActive := FDataLink.ActiveRecord;
  try
  FDataLink.ActiveRecord := ARow;
  MultiSelected := RowIsMultiSelected;
  finally
  FDataLink.ActiveRecord := OldActive;
  end;
  end;
  if (ARow = FDataLink.ActiveRecord) or MultiSelected then
  begin
  Indicator := tgIndicatorArrow;
  if FDataLink.DataSet <> nil then
  case FDataLink.DataSet.State of
  dsEdit:
  Indicator := tgIndicatorEdit;
  dsInsert:
  Indicator := tgIndicatorInsert;
  dsBrowse:
  if MultiSelected then
  if (ARow <> FDataLink.ActiveRecord) then
  Indicator := tgIndicatorMultiDot
  else
  Indicator := tgIndicatorMultiArrow;
  // multiselected and current row
  end;
  Indicators.BkColor := FixedColor;
  ALeft := ARect.Right - Indicators.Width - FrameOffs;
  if Canvas.CanvasOrientation = coRightToLeft then
  Inc(ALeft);

  if Style.Enabled and not Style.IsSystemStyle then
  Style.DrawElement(Canvas.Handle,
  Style.GetElementDetails(Indicator), ARect)
  else
  Indicators.Draw(Canvas, ALeft,
  (ARect.Top + ARect.Bottom - Indicators.Height) shr 1,
  integer(Indicator) - integer(tgIndicatorArrow), True);
  if ARow = FDataLink.ActiveRecord then
  FSelRow := ARow + FTitleOffset;
  end;
  end;
  end
  else
  with Canvas do
  begin
  if dgIndicator in Options then
  Field := GetColField(DbCol(ACol) + 1)
  else
  Field := GetColField(DbCol(ACol));

  DrawColumn := Columns[ACol];
  // if not DrawColumn.Showing then Exit;
  if not(gdFixed in AState) then
  begin
  // Font := DrawColumn.Font;
  // Brush.Color := DrawColumn.Color;
  Font := Self.Font;
  Brush.Color := Self.Color;
  if IsCustomStyle then
  begin
  Font.Color := Style.GetStyleFontColor
  (StyleFontColors[gdSelected in AState]);
  Brush.Color := Style.GetStyleColor(scGrid);
  end;
  end;
  if ARow < 0 then
  // DrawTitleCell(ACol, ARow + FTitleOffset, DrawColumn, AState)
  else if (FDataLink = nil) or not FDataLink.Active then
  FillRect(ARect)
  else
  begin
  value := '';
  OldActive := FDataLink.ActiveRecord;
  try
  FDataLink.ActiveRecord := ARow;
  if Assigned(Field) then
  value := Field.DisplayText;
  //          if HighlightCell(ACol, ARow, value, AState) and DefaultDrawing then
  //            DrawCellHighlight(ARect, AState, ACol, ARow);
  if not Enabled then
  Font.Color := clGrayText;

  Alignment := taLeftJustify;
  if ACol < FieldCount then
  Alignment := Fields[ACol].Alignment;
  if FieldMappedText then
  Alignment := taLeftJustify;

  if IsCustomStyle then
  WriteOptions := WriteOptions + [wtoTransparent];

  if FDefaultDrawing then
  begin
  if IsCustomStyle then
  xoffset:= 2
  else xoffset:= 3;
  wwWriteTextLines(Canvas, ARect, xoffset, 2, PChar(value), Alignment,
  WriteOptions);
  end;
  // if Columns.State = csDefault then
  // DrawDataCell(ARect, DrawColumn.Field, AState);
  // DrawColumnCell(ARect, ACol, DrawColumn, AState);
  finally
  FDataLink.ActiveRecord := OldActive;
  end;
  Canvas.Brush.Style := bsSolid;
  if FDefaultDrawing and (gdSelected in AState) and
  ((dgAlwaysShowSelection in Options) or Focused) and
  not(csDesigning in ComponentState) and not(dgRowSelect in Options)
  // and (UpdateLock = 0)
  and (ValidParentForm(Self).activecontrol = Self) then
  begin
  if (FInternalDrawingStyle = gdsThemed) and (Win32MajorVersion >= 6)
  then
  InflateRect(ARect, -1, -1);
  if not IsCustomStyle then
  Windows.DrawFocusRect(Handle, ARect);
  end;
  end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options = [dgRowLines,
  dgColLines]) and (FInternalDrawingStyle = gdsClassic) and
  not(gdPressed in AState) then
  begin
  InflateRect(ARect, 1, 1);
  if not IsCustomStyle then
  begin
  DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
  DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
  end;
  end;
  end;
*)

procedure TwwCustomDBGrid.PaintCellBackground(ACol: integer; ARow: integer;
  ARect: TRect; AState: TGridDrawState);
var
  R: TRect;
  tempField: TField;
  IsCustomStyle: boolean;
  TempRect: TRect;
  useAlt: boolean;
  OldRect: TRect;
begin
  IsCustomStyle := wwIsCustomStyle(Self);
  if not IsValidCell(ACol, ARow) then
    Exit;
  tempField := GetColField(DbCol(ACol));
  if tempField = Nil then
    Exit;
  if IsCustomStyle then
  begin
    if DefaultDrawing or (csDesigning in ComponentState) then
    begin
      if DrawCellInfo.DefaultDrawBackground then
      begin
        Canvas.Font := Self.Font;
        if not(dgAlwaysShowEditor in Options) and
          HighlightCell(DbCol(ACol), DbRow(ARow), '', AState) then
        begin
          if (dgRowSelect in Options) then
          begin
            ARect.Right := ARect.Right + 1; // so line is overwritten
            ARect.Bottom := ARect.Bottom + 1;
            // Make sure we invalidate this bottom rect when scrolling
            DrawCellHighlight(ARect, AState, ACol, ARow)
          end
          else if HaveActiveRecordColor then
          begin
            ARect.Left := ARect.Left - 1; // so line is overwritten
            ARect.Right := ARect.Right + 1; // so line is overwritten
            ARect.Bottom := ARect.Bottom + 1;
            // Make sure we invalidate this bottom rect when scrolling
            DrawCellHighlight(ARect, AState, ACol, ARow)
          end
          else
          begin
            OldRect := ARect;
            // if {(dgIndicator in Options) and }(ACol=inherited FixedCols+1)then
            // ARect.Left := ARect.Left-1;
            // ARect.Right := ARect.Right+1; // so line is overwritten
            // ARect.Bottom := ARect.Bottom+1; // Make sure we invalidate this bottom rect when scrolling
            InflateRect(ARect, 1, 1);
            DrawCellHighlight(ARect, AState, ACol, ARow);
            ARect := OldRect;
          end;
        end
        else
        begin
          TempRect := ARect;
          if ACol < FixedCols then
          begin
            useAlt := UseAlternatingRowFixed(DbRow(ARow));
            { if IsCustomStyle then
              begin
              TempRect.Bottom:= TempRect.Bottom-1;
              TempRect.Top:= TempRect.Top -1;
              end }
          end
          else
            useAlt := UseAlternatingRow(DbRow(ARow));

          if useAlt then
          begin
            // if IsCustomStyle then
            // TempRect.Bottom:= TempRect.Bottom +1;
            FillWithAlternatingRowBitmap(TempRect)
          end
          else
            DrawCellBackground(TempRect, Canvas.Brush.Color, AState,
              ACol, ARow);
        end;
      end;
    end;
    Exit;
  end;

  if ACol < FixedCols then
  begin
    R := ARect;
    R.Left := R.Left - 1;
    if (dgRowLinesDisableFixed in Options) and (dgRowLines in Options) then
      R.Top := R.Top - 1;

    if DrawCellInfo.DefaultDrawBackground then
      FillWithFixedBitmap(R, DbRow(ARow), TitleColor);
  end
  else if DrawCellInfo.DefaultDrawBackground then
  begin
    FillWithBlendBitmap(ARect, DbRow(ARow), clNone);
  end;
end;


Procedure TwwCustomDBGrid.DoOnCanShowCustomControl(
  control: TWinControl;
  tempField: TField;
  var canShow: boolean);
begin
   if Assigned(FOnCanShowCustomControl) then
      FOnCanShowCustomControl(self, control, tempField, canShow);
end;

Procedure TwwCustomDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
type
  TLineOption = (loNoVertLine);
  TLineOptions = Set of TLineOption;
var
  OldActive: integer;
  Alignment: TAlignment;
  Highlight: boolean;
  value: WideString;
  ATitleAlignment: TAlignment;
  TempDisplayLabel: string;
  APos, Index: integer;
  DrawInfo: TGridDrawInfo;

  defaultTitleDrawing: boolean;
  AImageRect, ATextRect, TempRect: TRect;
  TitleImageAttributes: TwwTitleImageAttributes;
  TitleOffset: integer;
  CurRelRow: integer;
  TempFieldName: string;
  SkipDefaultDrawing: boolean;
  pressed: boolean;
  AText: WideString;
  clearRect: TRect;
  OrigACol, OrigARow: integer;
  OrigARect: TRect;
  IsCustomStyle: boolean;
  TempTitleImageList: TImageList;
  Bmp: TBitmap;
  styleColor: TColor;

  procedure showHighlight(ACanvas: TCanvas; const ARect: TRect;
    DX, DY: integer);
  var
    Text: string;
    s: array [0 .. 1] of Char;
  begin
    Text := '';
    s[0] := #0;
    with ACanvas do
      ExtTextOut(Handle, ARect.Right - TextWidth(Text) - 3, ARect.Top + DY,
        ETO_OPAQUE or ETO_CLIPPED, @ARect, s, Length(Text), nil)
  end;

  procedure Display(s: WideString; Alignment: TAlignment;
    TRANSPARENT: boolean = True);
  const
    Formats: array [TAlignment] of Word = (DT_LEFT, DT_RIGHT,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
  var
    ButtonOffset: integer;
    NumLines, startOffset: integer;
    WriteOptions: TwwWriteTextOptions;
    TempRect: TRect;
  begin
    if not DrawCellInfo.DefaultDrawContents then
      Exit;

    { 11/26/97 - Only for title row }
    { 2/9/98 - Only depress currently clicked column }
    ButtonOffset := 0;

    if FTitleButtons and (not UseDragCanvas) and (TitleClickColumn >= 0) and
      (ARow < 0) and (not PaintingSearchCell) then
    begin
      if (TitleClickGroupTitle) then
      begin
        // Paint group or sub-group button
        if (TitleClickGroupTitle and (ARect.Top = 0)) then
          ButtonOffset := 1;
      end
      else if (ACol + FIndicatorOffset = TitleClickColumn) then
      begin
        if (ARect.Top > 0) or (Columns[ACol].GroupName = '') then
          ButtonOffset := 1
      end;
    end;

    WriteOptions := [];

    // 11/16/11 - if clhighlight then don't use style
    { if (ARow>=0) and (Canvas.Font.Color=clHighlightText) and (not IsCustomStyle)  then
      WriteOptions:= WriteOptions + [wtoDisableThemes];

      if (ARow>=0) and (ACol + FIndicatorOffset<FixedCols) and (not IsCustomStyle)  then
      WriteOptions:= WriteOptions + [wtoDisableThemes];
    }
    if ChangedFontColor then
    begin
      WriteOptions := WriteOptions + [wtoDisableThemes];
    end;

    if (ARow < 0) then
    begin
      if FTitleLines = 1 then
        NumLines := 1
      else
        NumLines := strCount(s, '~') + 1;
      startOffset := Trunc(((ATextRect.Bottom - ATextRect.Top) / 2) -
        (0.5 * NumLines * Canvas.TextHeight(s)));
      s := strReplaceChar(s, '~', #13);
      WriteOptions := WriteOptions + [wtoEllipsis];
      WriteOptions := WriteOptions + [wtoTransparent];
      If Assigned(FOnDrawTitleCell) then
        WriteOptions := WriteOptions + [wtoMergeCanvas];
      If Assigned(FOnDrawGroupHeaderCell) then
        WriteOptions := WriteOptions + [wtoMergeCanvas];
      if not UseTFields then
        WriteOptions := WriteOptions + [wtoAmpersandToUnderline];

      // 1/4/02 - Don't paint data columns to the left of data area.
      // Group case where 1st part of group is not visible
      if (ARect.Left < 0) or ((ACol + FIndicatorOffset >= LeftCol) and
        (ARect.Left < CellRect(LeftCol, 0).Left) and (not UseDragCanvas)) then
      begin
        ExcludeClipRect(Canvas.Handle, 0, 0, CellRect(LeftCol, 0).Left,
          ClientHeight); // Don't paint before leftcol
        WriteTitleLines(Canvas, ATextRect, 2 + ButtonOffset,
          startOffset + ButtonOffset, PWideChar(s), Alignment, WriteOptions);
        SelectClipRgn(Canvas.Handle, 0);
        // Restore normal clipping rectangle
      end
      else
        WriteTitleLines(Canvas, ATextRect, 2 + ButtonOffset,
          startOffset + ButtonOffset, PWideChar(s), Alignment, WriteOptions);

    end
    else
    begin
      if TRANSPARENT then
        WriteOptions := WriteOptions + [wtoTransparent];
      { Ellipsis only supported for single line }
      if (dgTrailingEllipsis in Options) and wwIsSingleLineEdit(Canvas.Handle,
        ARect, DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX) then
        WriteOptions := WriteOptions + [wtoEllipsis];

      // 1/22/13 - Paint highlighted text correctly with styles
      if Highlight then
        WriteOptions:= WriteOptions + [wtoGridSelected];

      if not(dgWordWrap in Options) then
      begin
        TempRect := ARect;
        if (dgTrailingEllipsis in Options) then
          WriteOptions := WriteOptions + [wtoEllipsis];

        { 12/4/98 - Fix problem when descenders cutoff when dgRowLines=False }
        if HaveAnyRowLines then
          ButtonOffset := 1;
        WriteTextLines(Canvas, TempRect, 2 { +ButtonOffset }
          { 2/20/99 - Comment out ButtonOffset, Text too far to right before }
          , (NormalPad div 2) + ButtonOffset, PWideChar(s), Alignment,
          WriteOptions); { 5/21/98 }
      end
      else
      begin
        WriteOptions := WriteOptions + [wtoWordWrap];
        TempRect := ARect;
        if not(HaveAnyRowLines) then
          { 1/8/99 - Fix descendor cutoff problem when wordwrap is true }
          WriteTextLines(Canvas, TempRect, 2 + ButtonOffset,
            (NormalPad div 2) + ButtonOffset, PWideChar(s), Alignment,
            WriteOptions)
        else
          WriteTextLines(Canvas, TempRect, 2 + ButtonOffset,
            (NormalPad div 2) + 1 + ButtonOffset, PWideChar(s), Alignment,
            WriteOptions);
      end;
    end;
  end;

  procedure SaveToBitmap(Bitmap: TBitmap; tempField: TField);
  type
    TGraphicHeader = record
      Count: Word; { Fixed at 1 }
      HType: Word; { Fixed at $0100 }
      Size: Longint; { Size not including header }
    end;

  var
{$IFDEF wwDelphi3Up}
    BlobStream: TStream;
{$ELSE}
    BlobStream: TwwMemoStream;
{$ENDIF}
    Size: Longint;
    Header: TGraphicHeader;
  begin
{$IFDEF wwDelphi3Up}
    { Support TClientDataSet by using CreateBlobStream instead }
    BlobStream := tempField.DataSet.CreateBlobStream(tempField, bmRead);
{$ELSE}
    BlobStream := TwwMemoStream.Create(tempField as TBlobField);
{$ENDIF}
    try { Use try/except instead of try/finally for efficiency }
      Size := BlobStream.Size;
      if Size >= SizeOf(TGraphicHeader) then
      begin
        BlobStream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          BlobStream.Position := 0;
      end;
      Bitmap.LoadFromStream(BlobStream);
      BlobStream.Free;
    except
      BlobStream.Free;
    end;
  end;

  procedure DrawCellColors(tempField: TField; DrawFocus: boolean);
  var
    pf: TCustomForm;
  begin
    with Canvas do
    begin
      if gdFixed in AState then
        Brush.Color := TitleColor
      else
        Brush.Color := Color;

      FCalcCellRow := ARow;
      if dgTitles in Options then
        Dec(FCalcCellRow, 1);
      FCalcCellCol := ACol;
      if dgIndicator in Options then
        Dec(FCalcCellCol, 1);

      Highlight := HighlightCell(ACol, FCalcCellRow, value, AState);
      if Highlight then
      begin
        Brush.Color := GetHighlightColor;
        if not(dgRowSelect in Options) and (ARow = row) and (ACol = col) then
          Brush.Color := clHighlight;
        Font.Color := clHighlightText;
      end;

      DoCalcCellColorsDetect(tempField, AState, Highlight, Font, Brush);

      if Highlight then
      begin
        if (not IsDropDownGridFocused) or
          ((dgRowSelect in Options) or HaveActiveRecordColor) then
          if not IsCustomStyle then
            showHighlight(Canvas, ARect, 2, 2)
            { Call after brush and font are set }
      end;

      if Highlight then
      begin
        pf := GetParentForm(Self);
        if not(csDesigning in ComponentState) and (pf <> nil) and
          (pf.activecontrol = Self) then
        begin
          if not(dgRowSelect in Options) then
          begin
            isDrawFocusRect := True;
          end
        end
      end;
    end;
  end;

  procedure DisplayBitMap(tempField: TField; Parameters: string);
  var
    myBitmap: TBitmap;
    SRect, DRect: TRect;
    tempBitmapField: TField; { win95 }
    tempLookupValue: string;
    tempHeight, tempWidth: Longint;
    bitmapSubsetWidth, bitmapSubsetHeight: integer;
    PrevCopyMode: TCopyMode;
    bitmapSize, rasterOperation: string;
    APos: integer;
    cellWidth, cellHeight: integer;
    rowlineoffset, collineoffset: integer;

    Function GetCopyMode(cm: string): TCopyMode;
    begin
      result := cmSrcCopy;
      if cm = 'Source Copy' then
        result := cmSrcCopy
      else if cm = 'Source Paint' then
        result := cmSrcPaint
      else if cm = 'Source And' then
        result := cmSrcAnd
      else if cm = 'Source Invert' then
        result := cmSrcInvert
      else if cm = 'Source Erase' then
        result := cmSrcErase
      else if cm = 'Not Source Copy' then
        result := cmNotSrcCopy
      else if cm = 'Not Source Erase' then
        result := cmNotSrcErase
      else if cm = 'Merge Paint' then
        result := cmMergePaint
    end;

  begin
    APos := 1;
    bitmapSize := strGetToken(Parameters, ';', APos);
    rasterOperation := strGetToken(Parameters, ';', APos);
    cellWidth := ARect.Right - ARect.Left;
    cellHeight := ARect.Bottom - ARect.Top;

    if tempField.Calculated then
    begin
      if not wwDataSetLookupDisplayField(tempField, tempLookupValue,
        tempBitmapField) then
      begin
        DrawCellColors(tempField, True); { Lookup failed }
        Exit;
      end
    end

    { 7/10/97 - Support bitmaps with lookup fields - Only 1 field lookups supported }
    else if tempField.lookup then
    begin
      if not wwDataSetFindRecord(tempField.LookupDataSet,
        tempField.DataSet.fieldByName(tempField.KeyFields).asstring,
        tempField.LookupKeyFields, mtExactMatch, false) then
      begin
        DrawCellColors(tempField, True); { Lookup failed }
        Exit;
      end
      else
        tempBitmapField := tempField.LookupDataSet.fieldByName
          (tempField.LookupResultField);
    end
    else
    begin
      tempBitmapField := tempField;
    end;

    myBitmap := TBitmap.Create;

    { 7/23/97 - Display bitmaps even in insert mode if lookup bitmap }
    if tempField.Calculated or tempField.lookup or
      not((DataSource.DataSet.State = dsInsert) and
      (DbRow(row) = DataLink.ActiveRecord + RowOffset)) then
      SaveToBitmap(myBitmap, tempBitmapField);

    if (myBitmap.Height <= 0) or (myBitmap.Width <= 0) then
    begin
      DrawCellColors(tempField, True);
      myBitmap.Free;
      Exit;
    end;

    SRect := Classes.Rect(0, 0, myBitmap.Width, myBitmap.Height);

    PrevCopyMode := Canvas.CopyMode;
    Canvas.CopyMode := GetCopyMode(rasterOperation);
    DrawCellColors(tempField, True);

    // 2/20/2002-PYW-When displaying bitmap take into account colline and rowlines.
    if dgColLines in Options then
      collineoffset := 1
    else
      collineoffset := 0;
    if dgRowLines in Options then
      rowlineoffset := 1
    else
      rowlineoffset := 0;

    if bitmapSize = 'Original Size' then
    begin
      tempHeight := cellHeight;
      tempWidth := cellWidth;
      SRect := Classes.Rect(0, 0, min(myBitmap.Width, tempWidth - 1),
        min(myBitmap.Height, tempHeight - 1));
      DRect := Classes.Rect(ARect.Left + collineoffset,
        ARect.Top + rowlineoffset, ARect.Left + 1 + (SRect.Right - SRect.Left),
        ARect.Top + 1 + (SRect.Bottom - SRect.Top));

      Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);
    end
    else if bitmapSize = 'Stretch To Fit' then
    begin
      Canvas.StretchDraw(ARect, myBitmap);
    end
    else if bitmapSize = 'Fit Height' then
    begin
      { Paint bitmap portion that is shown. }
      { BitmapSubsetWidth is portion of bitmap that is drawn }
      tempHeight := cellHeight;
      tempWidth := (myBitmap.Width * tempHeight) div myBitmap.Height;
      if tempWidth > cellWidth then
      begin
        bitmapSubsetWidth := (myBitmap.Width * cellWidth) div tempWidth;
        tempWidth := cellWidth; { Limit to cell's width }
      end
      else
        bitmapSubsetWidth := myBitmap.Width;

      if (tempWidth > 2) and (tempHeight > 2) then
      begin
        DRect := Classes.Rect(ARect.Left + collineoffset, ARect.Top,
          ARect.Left + tempWidth, ARect.Top + tempHeight - rowlineoffset);
        SRect := Classes.Rect(0, 0, bitmapSubsetWidth, myBitmap.Height);
        Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);
      end
    end
    else if bitmapSize = 'Fit Width' then
    begin
      { Paint bitmap portion that is shown. }
      { BitmapSubsetHeight is portion of bitmap that is drawn }
      tempWidth := cellWidth;
      tempHeight := (myBitmap.Height * tempWidth) div myBitmap.Width;
      if tempHeight > cellHeight then
      begin
        bitmapSubsetHeight := (myBitmap.Height * cellHeight) div tempHeight;
        tempHeight := cellHeight; { Limit to cell's height }
      end
      else
        bitmapSubsetHeight := myBitmap.Height;

      if (tempWidth > 2) and (tempHeight > 2) then
      begin
        DRect := Classes.Rect(ARect.Left + collineoffset, ARect.Top,
          ARect.Left + tempWidth, ARect.Top + tempHeight - rowlineoffset);
        SRect := Classes.Rect(0, 0, myBitmap.Width, bitmapSubsetHeight);
        Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);
      end
    end;

    if Highlight then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.FrameRect(ARect);
      SkipLineDrawing := True;
    end;
    Canvas.CopyMode := PrevCopyMode;

    myBitmap.Free;
  end;

  procedure DisplayBitmapFromImageList(tempField: TField; Parameters: string;
    CurRelRow: integer);
  var
    myBitmap: TBitmap;
    SRect, DRect, bitmapRect: TRect;
    APos: integer;
    bitmapSize: string;
  begin
    DrawCellColors(tempField, false);
    myBitmap := TBitmap.Create;
    myBitmap.Width := ImageList.Width;
    myBitmap.Height := ImageList.Height;
    bitmapRect := Classes.Rect(0, 0, ImageList.Width, ImageList.Height);

    // 10/22/02 - Fix problem with imagelist painting in alternating rows
{$IFNDEF GRIDESSENTIALS}
    if (HaveAlternatingRowColor) and
    // PaintOptions.AlternatingRowColor<>clNone) and
      (arrDataColumns in PaintOptions.AlternatingRowRegions) and
      (CurRelRow >= 0) and (odd(CurRelRow) xor AlternatingEven) then
    begin
      if (gdSelected in AState) then
        myBitmap.Canvas.Brush.Color := Canvas.Brush.Color
      else
        myBitmap.Canvas.Brush.Color := PaintOptions.AlternatingRowColor;
    end
    else {$ENDIF}
      myBitmap.Canvas.Brush.Color := Canvas.Brush.Color;

    myBitmap.Canvas.Brush.Color := Canvas.Brush.Color;
    SRect := Classes.Rect(0, 0, min(ARect.Right - ARect.Left - 2,
      myBitmap.Width), min(ARect.Bottom - ARect.Top - 2, myBitmap.Height));

    // 6/17/02 - Initialize earlier
    DRect.Left := Max(ARect.Left,
      (ARect.Left + ARect.Right - ImageList.Width) div 2);
    DRect.Top := Max(ARect.Top,
      (ARect.Top + ARect.Bottom - ImageList.Height) div 2);
    DRect.Right := DRect.Left + min(myBitmap.Width, ARect.Right - ARect.Left);
    DRect.Bottom := DRect.Top + min(myBitmap.Height, ARect.Bottom - ARect.Top);

    // 6/17/02 - Allow transparent image when using alternating colors in grid
    if ImageList.DrawingStyle = dsTransparent then
      myBitmap.Canvas.CopyRect(SRect, Canvas, DRect)
    else
      myBitmap.Canvas.FillRect(bitmapRect);

    if (not tempField.isNull) then
    begin
      if (tempField is TIntegerField) and (tempField.asInteger >= 0) then
        ImageList.Draw(myBitmap.Canvas, 0, 0, tempField.asInteger)
      else if (tempField is TFloatField) and (tempField.asFloat >= 0) then
        ImageList.Draw(myBitmap.Canvas, 0, 0, Trunc(tempField.asFloat))
    end;

    APos := 1;
    bitmapSize := strGetToken(Parameters, ';', APos);

    if (bitmapSize = 'Shrink To Fit') then
      Canvas.StretchDraw(DRect, myBitmap)
    else
      Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);

    if isDrawFocusRect then
      wwDrawFocusRect(Canvas, ARect);

    myBitmap.Free;
  end;

  procedure PaintInactiveCustomControl(customEdit: TWinControl;
    tempField: TField);

    procedure PaintControl(Control: TWinControl; ARect: TRect);
    var
      I: integer;
      SaveIndex: integer;
      canShow: boolean;
    begin

      canShow:= true;
      DoOnCanShowCustomControl(control, tempField, canShow);
      if not canShow then exit;


      Control.ControlState := Control.ControlState + [csPaintCopy];
      SaveIndex := SaveDC(Canvas.Handle);
      if UseRightToLeftAlignment then
      begin
        ChangeOrientation(false);
        if wwGetBorder(Control) then // if border then add 1 offset
          MoveWindowOrg(Canvas.Handle, ClientWidth - ARect.Right + 1,
            ARect.Top + 1)
        else
          MoveWindowOrg(Canvas.Handle, ClientWidth - ARect.Right, ARect.Top);
      end
      else
      begin
        if wwGetBorder(Control) then // if border then add 1 offset
          MoveWindowOrg(Canvas.Handle, ARect.Left + 1, ARect.Top + 1)
        else
          MoveWindowOrg(Canvas.Handle, ARect.Left, ARect.Top);
      end;

      IntersectClipRect(Canvas.Handle, 0, 0, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top);
      Control.Perform(WM_PAINT, Canvas.Handle, ARect.Bottom - ARect.Top);

      // Don't paint children of inspector, as it already does this on its own
      if not(wwIsClass(Control.classtype, 'TwwDataInspector')) then
        with Control do
        begin
          for I := 0 to ControlCount - 1 do
          begin
            if Controls[I] is TWinControl then
              with TWinControl(Controls[I]) do
                if Visible then
                  PaintTo(Canvas.Handle, Left, Top);
          end
        end;
      RestoreDC(Canvas.Handle, SaveIndex);
      Control.ControlState := Control.ControlState - [csPaintCopy];
    end;

  var
    abortflag: boolean;
  begin
    if (customEdit.Width <> ARect.Right - ARect.Left) or
      (customEdit.Height <> ARect.Bottom - ARect.Top) then
    begin
      if Columns[DbCol(ACol)].DisableSizing then
      begin
        if Abs(ARect.Right - ARect.Left) > customEdit.Width then
          customEdit.Width := ARect.Right - ARect.Left;

        if Abs(ARect.Bottom - ARect.Top) > customEdit.Height then
        begin
          customEdit.Height := ARect.Bottom - ARect.Top;
        end;
      end
      else
      begin
        customEdit.Width := ARect.Right - ARect.Left;
        customEdit.Height := ARect.Bottom - ARect.Top;
      end
    end;

    Canvas.Lock();
    try
      SetBkMode(Canvas.Handle, TRANSPARENT);
      DrawCellColors(tempField, True);
      abortflag := false;
      // 7/26/2001 - PYW - Added code to handle abort in OnDrawDataCell event to prevent default customcontrol painting.
      try
        DrawDataCell(ARect, GetColField(DbCol(ACol)), AState);
      except
        abortflag := True;
      end;

      if not abortflag then
      begin
        if ChangedBrushColor then
        begin
          Canvas.FillRect(ARect);
        end;
        PaintControl(customEdit, ARect);
      end;

    finally
      Canvas.UnLock();
      SetBkMode(Canvas.Handle, OPAQUE);
    end;

  end;

  procedure FillWithTitleBitmaps(ARect: TRect; FillColor: TColor = clNone);
  begin
    TempRect := Rect(ARect.Left - 1, ARect.Top, ARect.Right, ARect.Bottom);
{$IFNDEF GRIDESSENTIALS}
    if PaintOptions.Row1Bitmap <> nil then
    begin
      Canvas.CopyRect(TempRect, PaintOptions.Row1Bitmap.Canvas, TempRect);
    end
    else {$ENDIF} if FillColor = clNone then
      begin
        Canvas.FillRect(TempRect);
      end
      else
      begin
        Canvas.Brush.Color := FillColor; // PaintOptions.Row1Color;
        Canvas.FillRect(TempRect);
      end
  end;

  Function HandleWWControls: boolean;
  var
    tempField: TField;
    Rect: TRect;
    ControlType, Parameters: string;
    checkboxon, checkboxoff: string;
    APos: integer;
    customEdit: TWinControl;
    valueBool: boolean;
  begin
    result := false;
    if not IsValidCell(ACol, ARow) then
      Exit;
    tempField := GetColField(DbCol(ACol));
    if tempField = Nil then
      Exit;

    ARect := CellRect(ACol, ARow);
    ControlType := TwwCacheColInfoItem(FCacheColInfo[ACol]).ControlType;
    Parameters := TwwCacheColInfoItem(FCacheColInfo[ACol]).ControlData;

    { Bitmap support }
    if ControlType = 'Bitmap' then
    begin
      OldActive := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := DbRow(ARow) + RowOffset;
        if DrawCellInfo.DefaultDrawContents then // 5/17/03
          DisplayBitMap(tempField, Parameters);
      finally
        DataLink.ActiveRecord := OldActive;
      end;

      Draw3DLines(ARect, ACol, ARow, AState);

      result := True;
      Exit;
    end
    else if ControlType = 'ImageIndex' then
    begin
      OldActive := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := DbRow(ARow) + RowOffset;
        DrawCellColors(tempField, True);
        if ChangedBrushColor then
          Canvas.FillRect(ARect);

        if (tempField is TIntegerField) or (tempField is TFloatField) or
          (tempField is TLargeIntField) then
        begin
          if (FImageList <> Nil) then
            if DrawCellInfo.DefaultDrawContents then // 5/17/03
              DisplayBitmapFromImageList(tempField, Parameters, CurRelRow)
        end
      finally
        DataLink.ActiveRecord := OldActive;
      end;

      Draw3DLines(ARect, ACol, ARow, AState);

      result := True;
      Exit;
    end
    else if ControlType = 'CheckBox' then
    begin
      APos := 1;
      checkboxon := strGetToken(Parameters, ';', APos);
      checkboxoff := strGetToken(Parameters, ';', APos);
      OldActive := DataLink.ActiveRecord;
      value := '';
      valueBool := false;
      try
        DataLink.ActiveRecord := DbRow(ARow) + RowOffset;
        if tempField.Calculated and (lowercase(tempField.FieldName) = 'selected')
        then
        begin
          if IsSelected then
            value := checkboxon
          else
            value := checkboxoff;
        end
        else
        begin
          value := WideGetFieldValue(DbCol(ACol));
          if (tempField.DataType = ftBoolean) then
            valueBool := tempField.AsBoolean;
        end;

        DrawCellColors(tempField, True);
        if ChangedBrushColor then
        begin
          Canvas.FillRect(ARect);
        end;

      finally
        DataLink.ActiveRecord := OldActive;
      end;

      Rect.Left := (ARect.Right + ARect.Left - 10) div 2;
      Rect.Right := Rect.Left + 10;

      Rect.Top := ((ARect.Top + ARect.Bottom - 10) div 2);
      Rect.Bottom := Rect.Top + 10;

      if DrawCellInfo.DefaultDrawContents then // 5/17/03
      begin
        if (tempField.DataType = ftBoolean) and not IsSelectedCheckbox(ACol)
        then // 9/8/08
        begin
          if lowercase(checkboxon) = lowercase(STextFalse) then // 12/1/09
            DrawCheckBox(Rect, ACol, ARow, not valueBool)
          else
            DrawCheckBox(Rect, ACol, ARow, valueBool);
          // 10/24/08 - Fix ftBoolean type bug where it was using wrong record
        end
        else
          DrawCheckBox(Rect, ACol, ARow, wwEqualStr(value, checkboxon));
        { 2/11/97 Case insensitive check }
      end;

      Draw3DLines(ARect, ACol, ARow, AState);
      result := True;
      Exit;
    end
    else if (ControlType = 'CustomEdit') or (ControlType = 'RichEdit') then
    begin
      if IsCustomEditCell(ACol, ARow, customEdit) and
        (customEdit <> FDateTimePicker) then
      begin
        if TwwCacheColInfoItem(FCacheColInfo[ACol]).AlwaysPaints or
          wwIsClass(customEdit.classtype, 'TwwExpandButton') or
          wwIsClass(customEdit.classtype, 'TwwRadioGroup') or
          wwIsClass(customEdit.classtype, 'TwwCheckbox') or
          wwIsClass(customEdit.classtype, 'TwwMonthCalendar') then
        begin
          OldActive := DataLink.ActiveRecord;
          try
            DataLink.ActiveRecord := DbRow(ARow) + RowOffset;

            // This code fixes problem where the expand icon
            // was not painting as expanded for expanded active row
            if DrawCellInfo.DefaultDrawContents and // 5/17/03
              ((not customEdit.Visible) or ((row <> ARow) or (col <> ACol)))
            then
            begin
              if (customEdit is TwwExpandButton) and IsDropDownGridShowing and
                ((row = ARow) and (col = ACol)) then
              begin
                TwwExpandButton(customEdit).PaintAsExpanded := True;
                PaintInactiveCustomControl(customEdit, tempField);
                TwwExpandButton(customEdit).PaintAsExpanded := false;
              end
              else
                PaintInactiveCustomControl(customEdit, tempField);
            end;
          finally
            DataLink.ActiveRecord := OldActive;
          end;
          Draw3DLines(ARect, ACol, ARow, AState);
          result := True;
        end;
      end;
    end
  end;

{ 4/31/97 - Use extra temp bitmap due to bug in Delphi 3 BrushCopy method }
  procedure ShowIndicator;
  var
    TempIndicators: TImageList;
    Bmp: TBitmap;
    Indicator: TThemedGrid;
    Style: TCustomStyleServices;
  begin
    Style := StyleServices;
    Index := -1;
    if FDataLink.DataSet = nil then
      Index := 0
    else
    begin
      case FDataLink.DataSet.State of
        dsEdit:
          if ARow = FDataLink.ActiveRecord - RowOffset then
            Index := 1;
        dsInsert:
          if ARow = FDataLink.ActiveRecord - RowOffset then
            Index := 2;
      else
        begin
          if ARow = FDataLink.ActiveRecord - RowOffset then
          begin
            if (dgMultiSelect in Options) and IsSelectedRow(ARow) then
              Index := 4
            else
              Index := 0
          end
          else if (dgMultiSelect in Options) and IsSelectedRow(ARow) then
            Index := 3
        end
      end
    end;
    if Index >= 0 then
    begin
      Indicator := tgIndicatorArrow;
      if FDataLink.DataSet <> nil then
        case FDataLink.DataSet.State of
          dsEdit:
            Indicator := tgIndicatorEdit;
          dsInsert:
            Indicator := tgIndicatorInsert;
          dsBrowse:
            if (Index = 3) or (Index = 4) then // Multi-selected
              if (ARow <> FDataLink.ActiveRecord) then
                Indicator := tgIndicatorMultiDot
              else
                Indicator := tgIndicatorMultiArrow;
          // multiselected and current row
        end;

      TempIndicators := TImageList.CreateSize(Indicators.Width,
        Indicators.Height);
      Bmp := TBitmap.Create;
      try
        Indicators.GetBitmap(Index, Bmp);
        ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
        TempIndicators.AddMasked(Bmp, clWhite);

        if wwIsCustomStyle(Self) then
          Style.DrawElement(Canvas.Handle,
            Style.GetElementDetails(Indicator), ARect)
        else
          TempIndicators.Draw(Canvas, ((ARect.Right - Indicators.Width) div 2) +
            1, (ARect.Top + ARect.Top + DefaultRowHeight - Indicators.Height)
            div 2, 0, True);
      finally
        Bmp.Free;
        TempIndicators.Free;
      end;
    end;
  end;

  procedure DoThemeBackground(pressed: boolean; Options: TLineOptions;
    TempRect: TRect; IsDropDown: boolean = false);
{$IFDEF wwUseThemeManager}
  var
    Details: TThemedElementDetails;
    tempClipRect: TRect;
    // Hot: boolean;

    Function InGroupRange: boolean;
    var
      AbsCol: integer;
      StartCol, EndCol: integer;
    begin
      result := false;
      if MouseOverGroupTitle and (ACol >= 0) and (Columns[ACol].GroupName <> '')
      then
      begin
        if titleLastMouseX = ACol + FIndicatorOffset then
          result := True;
        if titleLastMouseX >= FIndicatorOffset then
        begin
          GroupNameCellRect(titleLastMouseX, 0, StartCol, EndCol);
          AbsCol := ACol + FIndicatorOffset;
          if (AbsCol >= StartCol) and (AbsCol <= EndCol) then
            result := True;
        end
      end
    end;
{$ENDIF}

  begin
{$IFDEF wwUseThemeManager}
    TempRect.Right := TempRect.Right + 1;
    tempClipRect := TempRect;
    // Hot:=false;

    if pressed then
      Details := StyleServices.GetElementDetails(thHeaderItemPressed)
    else
    begin
      if loNoVertLine in Options then
      begin
        TempRect.Bottom := TempRect.Bottom + 1; // 5/1/03
        if IsCustomStyle then
          TempRect.Right := TempRect.Right
        else
          TempRect.Right := TempRect.Right;
        // + 5; // 9/18/11 - It seems that there should be no +5 increment, but we leave it here for now

        // Match title color - but don't show vertical line
        Details := StyleServices.GetElementDetails(thHeaderItemNormal)
      end
      else if (TitleButtons or TitleMenuAttributes.TitleMenuEnabled) and
        (titleLastMouseY = 0) and ((titleLastMouseX - FIndicatorOffset = ACol)
        or InGroupRange) and (not UseDragCanvas) then
      begin
        if (ACol < 0) or (Columns[ACol].GroupName <> '') then
        // 5/9/03 - Prevent index out of range if ACol<0
        begin
          Details := StyleServices.GetElementDetails(thHeaderItemHot);

          if MouseOverGroupTitle and (ARect.Top > 0) then
            Details := StyleServices.GetElementDetails(thHeaderItemNormal)
          else if not MouseOverGroupTitle and (ARect.Top <= 0) then
            Details := StyleServices.GetElementDetails(thHeaderItemNormal)
          else if (not MouseOverGroupTitle) and (not MouseOverGroupChild) then
            Details := StyleServices.GetElementDetails(thHeaderItemNormal)
            // else Hot:=true;
        end
        else
        begin
          if MouseOverGroupChild or MouseOverGroupTitle then
          begin
            Details := StyleServices.GetElementDetails(thHeaderItemHot);
            // Hot:=true;
          end
          else
            Details := StyleServices.GetElementDetails(thHeaderItemNormal)
        end
      end
      else
      begin
        Details := StyleServices.GetElementDetails(thHeaderItemNormal);
      end
    end;
    // if IsDropDown and (not Hot) then
    // exit;

    StyleServices.DrawElement(Canvas.Handle, Details, TempRect, @tempClipRect);
{$ENDIF}
  end;

  function CanShowTitleDropDown(Field: TField): boolean;
  var
    CanShow: boolean;
  begin
    CanShow := ([sfoGrouping, sfoSortAscending, sfoSortDescending, sfoFilter,
      sfoSelectColumns] * TitleMenuAttributes.Options <> []);
    if (Field is TBlobField) and (sfoFilter in TitleMenuAttributes.Options) then
    begin
      if (Field.DataType in [ftString, ftWideString, ftMemo, ftWideMemo]) then
        CanShow := True
      else if TwwCacheColInfoItem(FCacheColInfo[ACol + FIndicatorOffset])
        .ControlType = 'RichEdit' then
        CanShow := True
      else
        CanShow := false;
    end;
    if Assigned(FOnCanShowTitleDropDown) then
      FOnCanShowTitleDropDown(Self, Field.FieldName, CanShow);
    result := CanShow;
  end;

  procedure UpdateTitleImageIndex(var TitleImageAttributes
    : TwwTitleImageAttributes; Field: TField);
  var
    indexFieldName: string;
    haveFilter: boolean;
    IsDescendingIndex: boolean;
  begin
    if not CanShowTitleDropDown(Field) then
      Exit;

    TitleImageAttributes.Margin := 1;
    haveFilter := (FormGridFilterTypes <> nil) and
      (FormGridFilterTypes.FindItem(Field.FieldName) <> nil);

    if not TitleImageAttributes.IsGroupHeader then
    begin
      indexFieldName := wwGetIndexFieldName(DataSource.DataSet);
      IsDescendingIndex := wwDataSetIsDescendingIndex(DataSource.DataSet);

      if Assigned(FOnQuerySortField) then
      begin
        FOnQuerySortField(Self, indexFieldName, IsDescendingIndex);
      end;

      if (AnsiUpperCase(Field.FieldName) = AnsiUpperCase(indexFieldName)) then
      begin
        if IsDescendingIndex then
        begin
          if haveFilter then
            TitleImageAttributes.ImageIndex := 5
            // Sorted descending with filter
          else
            TitleImageAttributes.ImageIndex := 2 // Sorted descending
        end
        else
        begin
          if haveFilter then
            TitleImageAttributes.ImageIndex := 4
            // Sorted ascending with filter
          else
            TitleImageAttributes.ImageIndex := 1 // Sorted ascending
        end
      end
      else
      begin
        if haveFilter then
          TitleImageAttributes.ImageIndex := 3
        else
          TitleImageAttributes.ImageIndex := 0 // Just show drop-down
      end
    end;
  end;
{
  procedure PaintCellBackground2;
  var
  R: TRect;
  tempField: TField;
  useAlt: boolean;
  begin
  //  exit;
  if not IsValidCell(ACol, ARow) then
  Exit;
  tempField := GetColField(DbCol(ACol));
  if tempField = Nil then
  Exit;

  if IsCustomStyle then
  begin
  if DefaultDrawing or (csDesigning in ComponentState) then
  begin
  if DrawCellInfo.DefaultDrawBackground then
  begin
  Canvas.Font := Self.Font;
  if HighlightCell(ACol, ARow, '', AState) then
  DrawCellHighlight(OrigARect, AState, OrigACol, OrigARow)
  else
  begin
  if ACol < FixedCols then
  useAlt:= UseAlternatingRowFixed(CurRelRow)
  else
  useAlt:= UseAlternatingRow(CurRelRow);

  if useAlt then
  begin
  TempRect := OrigARect;
  InflateRect(TempRect, 0, 0);
  FillWithAlternatingRowBitmap(TempRect)
  end
  else
  DrawCellBackground(OrigARect, Canvas.Brush.Color, AState,
  OrigACol, OrigARow);
  end;
  end;
  end;
  Exit;
  end;

  if ACol < FixedCols then
  begin
  R := ARect;
  R.Left := R.Left - 1;
  if (dgRowLinesDisableFixed in Options) and (dgRowLines in Options) then
  R.Top := R.Top - 1;
  if DrawCellInfo.DefaultDrawBackground then
  FillWithFixedBitmap(R, CurRelRow, TitleColor);
  end
  else if DrawCellInfo.DefaultDrawBackground then
  FillWithBlendBitmap(ARect, CurRelRow, clNone);
  end;
}
{
  if IsCustomStyle then
  begin
  if DefaultDrawing or (csDesigning in ComponentState) then
  begin
  if DrawCellInfo.DefaultDrawBackground then
  begin
  Canvas.Font := Self.Font;
  if HighlightCell(ACol, ARow, '', AState) then
  DrawCellHighlight(OrigARect, AState, OrigACol, OrigARow)
  else begin
  if UseAlternatingRow(CurRelRow) then
  begin
  tempRect:= OrigARect;
  InflateRect(tempRect, -4, -1);
  FillWithAlternatingRowBitmap(tempRect)
  end
  else
  DrawCellBackground(OrigARect, Canvas.Brush.Color, AState, OrigACol,
  OrigARow);
  end;
  end;
  end;
  end;

  end;
}

  function CustomTitleImageList: boolean;
  begin
    result := FTitleImageList <> nil;
  end;

begin { .DrawCell }
  OrigARow := ARow;
  OrigACol := ACol;
  OrigARect := ARect;
  CurRelRow := ARow;
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  if dgTitles in Options then
    Dec(CurRelRow, 1);
  CalcDrawInfo(DrawInfo);
  if ARow > DrawInfo.Vert.LastFullVisibleCell then
    Exit;
  if RecordCountIsValid then
  begin
    if (DbRow(ARow) >= FDataLink.RecordCount - RowOffset) and
      (FDataLink.RecordCount > 0) then
      Exit; // If no records, then still display
  end;

  // Don't paint rows unless completely visible
  isDrawFocusRect := false;
  SkipLineDrawing := false;
  if (ARect.Right > 2 * Width) then
    ARect.Right := 2 * Width;
  { 2/24/00 - Limit display rectangle's right border }
  { 3/1/00 - Use 10*width in case of horizontal scolling }
  ATextRect := ARect;

  if gdFixed in AState then
  begin
    Canvas.Font := TitleFont;
  end
  else
    Canvas.Font := Font;

  with DrawCellInfo do
  begin
    Rect := ARect;
    State := AState;
    DataRow := ARow;
    DataCol := ACol;
    if dgIndicator in Options then
      DataCol := DataCol - 1;
    if dgTitles in Options then
      Dec(DataRow, 1);

    if DataCol < 0 then
      DrawCellInfo.Field := nil
    else
      DrawCellInfo.Field := Fields[DataCol];

    DefaultDrawBackground := True;
    DefaultDrawHorzBottomLine := True;
    DefaultDrawHorzTopLine := True;
    DefaultDrawContents := True;
  end;

  if (GroupFieldName <> '') or Assigned(OnBeforeDrawCell) then
  begin
    if DrawCellInfo.DataRow >= 0 then
    begin
      OldActive := FDataLink.ActiveRecord;
      FDataLink.ActiveRecord := DrawCellInfo.DataRow;
    end;

    try
      DoOnBeforeDrawCell(AText, DrawCellInfo);

      // 8/23/09 - Make sure we call FOnBeforeDrawCell
      if Assigned(OnBeforeDrawCell) then
      begin
        FOnBeforeDrawCell(Self, DrawCellInfo);
      end;
      if (DrawCellInfo.DataCol <= ColItems.Count - 1) and
        (DrawCellInfo.DataCol >= 0) then
        with DrawCellInfo do
        begin
          if Columns[DataCol].ColumnFlags = nil then
          begin
            Columns[DataCol].ColumnFlags :=
              PByteArray(AllocMem(SizeOf(Byte) * (256)));
          end
        end;

      if (DrawCellInfo.DataRow >= 0) and (DrawCellInfo.DataRow < 256) and
        (DrawCellInfo.DataCol < ColItems.Count - 1) and
        (DrawCellInfo.DataCol >= 0) and
        (FastColumns[DrawCellInfo.DataCol].ColumnFlags <> nil) then
        with DrawCellInfo do
        begin
          if not DefaultDrawHorzBottomLine then
            FastColumns[DataCol].ColumnFlags[DataRow] := FastColumns[DataCol]
              .ColumnFlags[DataRow] or wwDisableDrawBottomLine
          else
            FastColumns[DataCol].ColumnFlags[DataRow] := FastColumns[DataCol]
              .ColumnFlags[DataRow] and not wwDisableDrawBottomLine;
          if not DrawCellInfo.DefaultDrawHorzTopLine then
            FastColumns[DataCol].ColumnFlags[DataRow] := FastColumns[DataCol]
              .ColumnFlags[DataRow] or wwDisableDrawHorzTopLine
          else
            FastColumns[DataCol].ColumnFlags[DataRow] := FastColumns[DataCol]
              .ColumnFlags[DataRow] and not wwDisableDrawHorzTopLine;
        end;

    finally

      if DrawCellInfo.DataRow >= 0 then
        FDataLink.ActiveRecord := OldActive;
    end
  end;

  with Canvas do
  begin
    if gdFixed in AState then
      Brush.Color := TitleColor
    else
      Brush.Color := Color;
    PaintCellBackground(OrigACol, OrigARow, OrigARect, AState);
    // PaintCellBackground2;//(OrigARow, OrigACol, OrigARect, AState);

    if HandleWWControls then
    begin
      DoOnAfterDrawCell(DrawCellInfo);
      Exit;
    end;

    if dgTitles in Options then
      Dec(ARow, 1);
    if dgIndicator in Options then
      Dec(ACol, 1);

    if (ARow < 0) and (ACol >= 0) and PaintingSearchCell then
    begin
      Display(Columns[ACol].SearchValue, taLeftJustify, True);
      // (not Highlight) and (not ChangedBrushColor));
      Draw3DLines(ARect, ACol + FIndicatorOffset, ARow + FTitleOffset, AState);
    end
    else if (ARow < 0) { and (ACol>=0) } then
    begin
      ATitleAlignment := FTitleAlignment;
      if (ACol >= 0) and ((ACol < FieldCount) or (not UseTFields)) then
      begin
        { 12/15/97 - Paint indicator button now so blank space isn't displayed too long }
        if (ACol = 0) and (dgIndicator in Options) then
          if (IndicatorButton <> Nil) and IndicatorButton.Visible then
            IndicatorButton.Paint;
        { 7/31/97 - Don't use displaylabel property when useTFields=False }
        if ACol < FieldCount then
          TempDisplayLabel := Fields[ACol].DisplayLabel
        else
          TempDisplayLabel := '';

        if not UseTFields then
        begin
          if FieldCount = 0 then
          begin
            if (ACol >= 0) and (ACol < Selected.Count) then
            begin
              APos := 1;
              TempFieldName := strGetToken(Selected[ACol], #9, APos);
            end;
          end
          else
            TempFieldName := Fields[ACol].FieldName;
          if wwFindSelected(Selected, TempFieldName, index) then
          begin
            APos := 1;
            strGetToken(Selected[Index], #9, APos);
            { 11/11/98 - Changed ACol to Index }
            strGetToken(Selected[Index], #9, APos);
            { Changed ACol to Index }
            TempDisplayLabel := strGetToken(Selected[index], #9, APos);
          end;
        end
        else
          TempFieldName := Fields[ACol].FieldName;
        // ARect:= TitleCellRect(OrigACol, OrigARow);
        ATextRect := ARect;
        TitleImageAttributes.ImageIndex := -1;
        TitleImageAttributes.IsGroupHeader := (Columns[ACol].GroupName <> '')
          and (ARect.Top = 0);
        TitleImageAttributes.Alignment := taRightJustify;
        TitleImageAttributes.Margin := 3;

        if TitleImageAttributes.IsGroupHeader then
        begin
          TempFieldName := Columns[ACol].GroupName;
          ATitleAlignment := taCenter;
        end;
        DoCalcTitleAttributes(TempFieldName, Font, Brush, ATitleAlignment);

        // Canvas.FillRect(ARect);
        TempRect := ARect;
        if (not UseDragCanvas) and
          (TempRect.Right > DrawInfo.Horz.FixedBoundary) and
          (TempRect.Left < DrawInfo.Horz.FixedBoundary) then
          TempRect.Left := wwMax(TempRect.Left, DrawInfo.Horz.FixedBoundary);

        if DrawCellInfo.DefaultDrawBackground then
        begin

          if UseThemesInTitle then // StyleServices.ThemesEnabled then
          begin
            pressed := FTitleButtons and (not UseDragCanvas) and
              (TitleClickColumn >= 0);

            if pressed then
            begin
              if (TitleClickGroupTitle) then
              begin
                pressed := (TitleClickGroupTitle and (ARect.Top = 0));
              end
              else if (ACol + FIndicatorOffset = TitleClickColumn) then
              begin
                pressed := (ARect.Top > 0) or (Columns[ACol].GroupName = '');
              end;
            end;

            DoThemeBackground(pressed, [], TempRect);
          end
          else if ChangedBrushColor then
            Canvas.FillRect(TempRect)
          else
            FillWithTitleBitmaps(TempRect);
        end;

        if (ACol < FieldCount) then
        begin
          if TitleMenuAttributes.TitleMenuEnabled then
          begin
            UpdateTitleImageIndex(TitleImageAttributes, Fields[ACol]);
          end;
          DoCalcTitleImage(Self, Fields[ACol], TitleImageAttributes);
        end;
        TitleOffset := 0;
        if FTitleButtons and (not UseDragCanvas) and (TitleClickColumn >= 0)
        then
        begin
          if (TitleClickGroupTitle) then
          begin
            // Paint group or sub-group button
            if (TitleClickGroupTitle and (ARect.Top = 0)) then
              TitleOffset := 1;
          end
          else if (ACol + FIndicatorOffset = TitleClickColumn) then
          begin
            if (ARect.Top > 0) or (Columns[ACol].GroupName = '') then
              TitleOffset := 1
          end;
        end;

        if (TitleImageAttributes.ImageIndex >= 0) and
          (EffectiveTitleImageList <> Nil) and DrawCellInfo.DefaultDrawBackground
        then
        begin
          TempTitleImageList := nil;
          Bmp := nil;
          try
            if IsCustomStyle and (not CustomTitleImageList) then
            begin
              TempTitleImageList := TImageList.CreateSize
                (EffectiveTitleImageList.Width, EffectiveTitleImageList.Height);
              Bmp := TBitmap.Create;
              EffectiveTitleImageList.DrawingStyle := TDrawingStyle.dsNormal;
              EffectiveTitleImageList.GetBitmap
                (TitleImageAttributes.ImageIndex, Bmp);
              EffectiveTitleImageList.DrawingStyle :=
                TDrawingStyle.dsTransparent;
              if not StyleServices.GetElementColor
                (StyleServices.GetElementDetails(tgFixedCellNormal),
                ecTextColor, styleColor) or (styleColor = clNone) then
                styleColor := clBlack;
              // Can't determine style font color for title

              ChangeColorBitmap(Bmp, styleColor, clBlack);
              TempTitleImageList.AddMasked(Bmp, clFuchsia);
            end;

            case TitleImageAttributes.Alignment of
              taRightJustify:
                begin
                  AImageRect := Rect(ARect.Right - EffectiveTitleImageList.Width
                    - TitleImageAttributes.Margin + TitleOffset,
                    (ARect.Top + ARect.Bottom - EffectiveTitleImageList.Height)
                    div 2 + TitleOffset, 0, 0);
                  AImageRect.Right := AImageRect.Left +
                    EffectiveTitleImageList.Width;
                  AImageRect.Bottom := ARect.Bottom;

                  if IsCustomStyle and (not CustomTitleImageList) then
                    TempTitleImageList.Draw(Canvas, AImageRect.Left,
                      AImageRect.Top, 0, True)
                  else
                  begin
                    EffectiveTitleImageList.Draw(Canvas, AImageRect.Left,
                      AImageRect.Top, TitleImageAttributes.ImageIndex);
                  end;
                  ATextRect := ARect;
                  ATextRect.Right :=
                    wwMax(ARect.Right - EffectiveTitleImageList.Width -
                    TitleImageAttributes.Margin, ARect.Left)
                end;
              taLeftJustify:
                begin
                  AImageRect := Rect(ARect.Left + TitleImageAttributes.Margin +
                    TitleOffset,
                    (ARect.Top + ARect.Bottom - EffectiveTitleImageList.Height)
                    div 2 + TitleOffset, 0, 0);
                  AImageRect.Right := AImageRect.Left +
                    EffectiveTitleImageList.Width;
                  AImageRect.Bottom := AImageRect.Top +
                    EffectiveTitleImageList.Height;
                  // DoThemeBackground(false, [], AImageRect, true);

                  if IsCustomStyle then
                    TempTitleImageList.Draw(Canvas, AImageRect.Left,
                      AImageRect.Top, 0, True)
                  else
                    EffectiveTitleImageList.Draw(Canvas, AImageRect.Left,
                      AImageRect.Top, TitleImageAttributes.ImageIndex);
                  ATextRect := ARect;
                  ATextRect.Left :=
                    wwmin(ARect.Left + EffectiveTitleImageList.Width +
                    TitleImageAttributes.Margin, ARect.Right)
                end;
              taCenter:
                begin
                  AImageRect :=
                    Rect((ARect.Left + ARect.Right -
                    EffectiveTitleImageList.Width) div 2 + TitleOffset,
                    (ARect.Top + ARect.Bottom - EffectiveTitleImageList.Height)
                    div 2 + TitleOffset, EffectiveTitleImageList.Width,
                    EffectiveTitleImageList.Height);
                  if IsCustomStyle and (not CustomTitleImageList) then
                    TempTitleImageList.Draw(Canvas, AImageRect.Left,
                      AImageRect.Top, 0, True)
                  else
                    EffectiveTitleImageList.Draw(Canvas, AImageRect.Left,
                      AImageRect.Top, TitleImageAttributes.ImageIndex);
                  ATextRect := ARect;
                end;
            end

          finally
            Bmp.Free;
            TempTitleImageList.Free;
          end;

        end;

        defaultTitleDrawing := True;

        if ACol < FieldCount then
        begin
          if (ARect.Top > 0) or (Columns[ACol].GroupName = '') then
            DoDrawTitleCell(Canvas, Fields[ACol], ARect, defaultTitleDrawing)
          else
            DoDrawGroupHeaderCell(Canvas, Columns[ACol].GroupName, ARect,
              defaultTitleDrawing)
        end;
        if defaultTitleDrawing and (TitleImageAttributes.Alignment <> taCenter)
        then
        begin
          // 3/30/2001 - PYW - Change DisplayLabel to the GroupName if we are drawing a group Title Cell.
          if (ACol >= 0) and (Columns[ACol].GroupName <> '') then
          begin
            if (not(UseDragCanvas and ClickedOnGroupChild)) and (ARect.Top = 0)
            then
              TempDisplayLabel := Columns[ACol].GroupName;
          end;

          Display(TempDisplayLabel, ATitleAlignment, (not ChangedBrushColor));
        end;
      end
      else
      begin
        if UseThemesInTitle then
        begin
          DoThemeBackground(false, [ { loNoVertLine } ], ARect)
          // 5/1/03 - Don't use loNoVertLine style
        end
        else if DrawCellInfo.DefaultDrawBackground then
          FillWithTitleBitmaps(ARect);
      end
    end
    else if ACol < 0 then
    begin
      TempRect := Rect(ARect.Left - 1, ARect.Top - 1, ARect.Right,
        ARect.Bottom + 1);
      if (dgHideBottomDataLine in Options) then
        TempRect.Bottom := TempRect.Bottom - 1;

      if UseThemesInTitle then
      begin
        TempRect := Rect(ARect.Left - 1, ARect.Top, ARect.Right,
          ARect.Bottom + 1); // 5/1/03
        { if IsCustomStyle then
          begin
          TempRect.Bottom:= TempRect.Bottom -1;
          TempRect.Top:= TempRect.Top -1;
          end;
        }
        DoThemeBackground(false, [loNoVertLine], TempRect)
      end
      else if DrawCellInfo.DefaultDrawBackground then
        FillWithFixedBitmap(TempRect, -1, { CurRelRow, } TitleColor);
      // 3/30/2001 - PYW - Always Call ShowIndicator to support MultiSelect indicators in indicator column.
      if (DataLink <> nil) and DataLink.Active then
      begin
        ShowIndicator;
        if ARow = FDataLink.ActiveRecord - RowOffset then
        begin
          FSelRow := ARow + FTitleOffset;
        end;
      end
    end
    else if (DataLink = nil) or not DataLink.Active then
    begin
      // if not PaintOptions.HaveBackgroundForDataCells then FillRect(ARect)
    end
    else
    begin
      {
        if IsCustomStyle then
        begin
        InheritedDrawCell(OrigACol, OrigARow, ARect, AState);
        Exit;
        end;
      }
      value := '';
      OldActive := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := ARow + FTopRecord + RowOffset;
        FCalcCellRow := ARow;
        FCalcCellCol := ACol;

        FieldMappedText := false;
        value := WideGetFieldValue(ACol);

        Highlight := HighlightCell(ACol, ARow, value, AState);
        if TwwCacheColInfoItem(FCacheColInfo[ACol + FIndicatorOffset])
          .ControlType = 'URL-Link' then
        begin
          if (ACol + FIndicatorOffset = URLLinkActiveCol) and
            (ARow + FTitleOffset = URLLinkActiveRow) then
          begin
            Font.Color := clRed;
            Font.Style := Canvas.Font.Style + [fsUnderline];
          end
          else
          begin
            Font.Color := clBlue;
            Font.Style := Canvas.Font.Style + [fsUnderline];
          end
        end;

        SkipDefaultDrawing := false;
        if Highlight then
        begin
          // 7/24/02 - Don't paint highlight background for cell with focus control if have themes
          // 4/30/07 - Fix multi-select paint bug with themes enabled (when control has focus).
          if wwUseThemes(Self) and IsChild(Self.Handle, GetFocus) and
            (not IsSelected) and (ARow = DbRow(row)) and (ACol = DbCol(col))
          // 11/15/07 - Only skip if active cell
          then
            SkipDefaultDrawing := True
            // Don't paint cell as control is painting itself
            // else if (not wwUseThemes(self)) or
            // (not IsChild(self.handle, GetFocus))  then
          else
          begin
            Brush.Color := GetHighlightColor;
            if not(dgRowSelect in Options) and (ARow = DbRow(row)) and
              (ACol = DbCol(col)) then
              Brush.Color := clHighlight;

            Font.Color := clHighlightText;
          end
        end;

        DoCalcCellColorsDetect(GetColField(ACol), AState, Highlight,
          Font, Brush);

        Alignment := taLeftJustify;
        if ACol < FieldCount then
          Alignment := Fields[ACol].Alignment;
        if FieldMappedText then
          Alignment := taLeftJustify;

        if DrawCellInfo.DefaultDrawBackground then
        begin
          if (ACol < FixedCols - FIndicatorOffset) then
          begin
            TempRect := Rect(ARect.Left, ARect.Top, ARect.Right,
              ARect.Bottom + 1);
            if (dgHideBottomDataLine in Options) then
              TempRect.Bottom := TempRect.Bottom - 1;
            FillWithFixedBitmap(TempRect, CurRelRow);
          end
          else if (not IsCustomStyle) and PaintOptions.HaveBackgroundForDataCells
          then
          begin
            FillWithBlendBitmap(ARect, CurRelRow);
          end
          else
          begin
            if DefaultDrawing and (not SkipDefaultDrawing) then
            begin
              // 12/20/02 - Fill background since display does not paint anything in
              // this case
              if not DrawCellInfo.DefaultDrawContents then
              begin
                clearRect := ARect;
                // 4/3/08 - Don't suspend line drawing unless drawcellinfo.horzline properties are false
                if not DrawCellInfo.DefaultDrawHorzTopLine then
                  clearRect.Top := clearRect.Top - 1;
                if not DrawCellInfo.DefaultDrawHorzBottomLine then
                  clearRect.Bottom := clearRect.Bottom + 1;

                FillWithBlendBitmap(clearRect, CurRelRow)
                // Overwrites lines!
              end
            end
          end
        end;

        if DefaultDrawing and (not SkipDefaultDrawing) and DrawCellInfo.DefaultDrawContents
        then
        begin
          // 9/10/03 - Support bidi-mode with special handling for numerics being reversed
          if UseRightToLeftAlignment then
          begin
            if OkToChangeFieldAlignment(Fields[ACol], Alignment) then
            begin
              Display(value, Alignment, (not Highlight) and
                (not ChangedBrushColor));
            end
            else
            begin // Numeric so ignore bidi issues
              if Alignment = taLeftJustify then
                Alignment := taRightJustify
              else if Alignment = taRightJustify then
                Alignment := taLeftJustify;
              Display(value, Alignment, (not Highlight) and
                (not ChangedBrushColor));
            end
          end
          else
            Display(value, Alignment,
              // (not Highlight) and (not ChangedBrushColor));
              (IsCustomStyle or (not Highlight)) and (not ChangedBrushColor));
        end;

        try
          DrawDataCell(ARect, GetColField(ACol), AState);
        except
          // Do nothing if there was an exception.
        end;
      finally
        DataLink.ActiveRecord := OldActive;
      end;

      // Only Required if want row lines in drop-down list
      // if DrawCellInfo.DefaultDrawHorzLines then
      Draw3DLines(ARect, ACol + FIndicatorOffset, ARow + FTitleOffset, AState);
    end;

    DoOnAfterDrawCell(DrawCellInfo);

  end;

end;

procedure TwwCustomDBGrid.ValidationErrorUsingMask(Field: TField; Msg: string);
// var msg: string;
// doDefault: boolean;
begin
  wwInternational.ValidationErrorUsingMask(Self, Field, Msg);
  { msg:= Format(SMaskEditErr, ['']);
    DoDefault:= True;
    if Assigned(FOnValidationErrorUsingMask) then
    FOnValidationErrorUsingMask(self, Field, msg, doDefault);
    if doDefault then
    begin
    MessageBeep(0);
    raise EInvalidOperation.create(Format(SMaskEditErr, ['']));
    end }
end;

{ Will move LeftCol so that Col is in view }
function TwwCustomDBGrid.CalcMaxTopLeft(const Coord: TGridCoord;
  const DrawInfo: TGridDrawInfo): TGridCoord;

  function CalcMaxCell(const Axis: TGridAxisDrawInfo; Start: integer): integer;
  var
    line: integer;
    I, Extent: Longint;
  begin
    result := Start;
    with Axis do
    begin
      line := GridExtent + EffectiveLineWidth;
      for I := Start downto FixedCellCount do
      begin
        Extent := GetExtent(I);
        if Extent > 0 then
        begin
          Dec(line, Extent);
          Dec(line, EffectiveLineWidth);
          if line < FixedBoundary then
          begin
            if (result = Start) and (GetExtent(Start) <= 0) then
              result := I;
            break;
          end;
          result := I;
        end;
      end;
    end;
  end;

begin
  result.X := CalcMaxCell(DrawInfo.Horz, Coord.X);
  result.Y := CalcMaxCell(DrawInfo.Vert, Coord.Y);
end;

// Update LeftCol in case of fixed editable rows
procedure TwwCustomDBGrid.UpdateLeftCol(ACol: integer);
var
  DrawInfo: TGridDrawInfo;
  MaxTopLeft: TGridCoord;
  OldTopLeft: TGridCoord;
  Coord: TGridCoord;
begin
  if not HandleAllocated then
    Exit;
  CalcDrawInfo(DrawInfo);
  Coord.X := ACol;
  Coord.Y := row;
  with DrawInfo, Coord do
  begin
    if (X > Horz.LastFullVisibleCell) or (Y > Vert.LastFullVisibleCell) or
      (X < LeftCol) or (Y < TopRow) then
    begin
      OldTopLeft.X := LeftCol;
      OldTopLeft.Y := TopRow;
      MaxTopLeft := CalcMaxTopLeft(Coord, DrawInfo);
      // Update;  // Complete painting
      if (X < LeftCol) and (X >= inherited FixedCols) then
      begin
        BeginUpdate;
        LeftCol := X;
        EndUpdate;
        TopLeftChanged;
        Invalidate;
      end
      else if X > Horz.LastFullVisibleCell then
      begin
        BeginUpdate;
        LeftCol := MaxTopLeft.X;
        EndUpdate;
        TopLeftChanged;
        Invalidate;
      end;
    end;
  end;
end;

procedure TwwCustomDBGrid.MoveCol(ACol: integer);
var
  oldcol: integer;
  DrawInfo: TGridDrawInfo;
  OldTopLeft, NewTopleft, Delta: TGridCoord;
  R: TRect;
  // editor: TwwInplaceEdit;
  // FOnInvalidValue: TwwInvalidValueEvent;

  function CalcScroll(const AxisInfo: TGridAxisDrawInfo;
    OldPos, CurrentPos: integer; var Amount: Longint): boolean;
  var
    Start, Stop: Longint;
    I: Longint;
  begin
    result := false;
    with AxisInfo do
    begin
      if OldPos < CurrentPos then
      begin
        Start := OldPos;
        Stop := CurrentPos;
      end
      else
      begin
        Start := CurrentPos;
        Stop := OldPos;
      end;
      Amount := 0;
      for I := Start to Stop - 1 do
      begin
        Inc(Amount, GetExtent(I) + EffectiveLineWidth);
        if Amount > (GridBoundary - FixedBoundary) then
          Exit;
      end;
      if OldPos < CurrentPos then
        Amount := -Amount;
    end;
    result := True;
  end;

begin

  FDataLink.UpdateData;
  if ACol >= FieldCount then
    ACol := FieldCount - 1;
  if ACol < 0 then
    ACol := 0;
  if not(dgFixedEditable in Options) and (ACol < (FixedCols - FIndicatorOffset))
  then
  begin
    { Don't allow movement to a fixed column }
    ACol := FixedCols - FIndicatorOffset;
  end;

  oldcol := col - FIndicatorOffset;
  if ACol <> oldcol then
  begin
    OldTopLeft.X := LeftCol;
    OldTopLeft.Y := TopRow;

    if not FInColExit then
    begin
      FInColExit := True;
      try
        ColExit;
      finally
        FInColExit := false;
      end;
      if col - FIndicatorOffset <> oldcol then
        Exit;
    end;

    HideEditor;
    if (not SuppressShowEditor) and (dgAlwaysShowEditor in Options) and
      not IsWWControl(ACol + FIndicatorOffset, row) then
    begin
      HideControls;
    end;

    if (dgFixedEditable in Options) then
    begin
      CalcDrawInfo(DrawInfo);
      if (ACol + FIndicatorOffset > DrawInfo.Horz.LastFullVisibleCell) or
        (ACol + FIndicatorOffset < LeftCol) then
      begin
        inherited DefaultDrawing := True;
        // Prevent background from erasing when horizontal scrolling
        // By calling MoveColRow, LeftCol is not automatically reset
        // We avoid LeftCol assignment so that we can move to a fixed
        // column without LeftCol changing
        MoveColRow(ACol + FIndicatorOffset, row, True, false);

        // Now we need to set LeftCol in case the active column is not visible
        UpdateLeftCol(col);
        // If Column not in view then Set LeftCol so it is in view

        inherited DefaultDrawing := false;
      end
      else
        col := ACol + FIndicatorOffset;
    end
    else
      col := ACol + FIndicatorOffset;

    if (not SuppressShowEditor) and (dgAlwaysShowEditor in Options) and
      not IsWWControl(ACol + FIndicatorOffset, row) then
    begin
      { 12/19/96 - Don't call showeditor if going to memo field }
      if (not IsMemoField(ACol + FIndicatorOffset, row)) then
      begin
        if not(ecoDisableEditorIfReadOnly in EditControlOptions) or
          (not Columns[ACol].ReadOnly) then
          inherited ShowEditor;
      end
    end;

    ColEnter;

    // Fix Scrolling painting bug with vertical line
    begin
      NewTopleft.X := LeftCol;
      NewTopleft.Y := TopRow;
      CalcDrawInfo(DrawInfo);
      if (NewTopleft.X <> OldTopLeft.X) then
      begin
        if CalcScroll(DrawInfo.Horz, OldTopLeft.X, NewTopleft.X, Delta.X) then
        begin
          if UseRightToLeftAlignment then
          begin
            R := Rect(-Delta.X, 0, -Delta.X + 1, ClientHeight);
            InvalidateRect(Handle, @R, false);
          end
          else
          begin
            // 7/11/01 - White fixed line is scrolled into data area, so remove by repainting.
            R := Rect(DrawInfo.Horz.FixedBoundary + Delta.X, 0,
              DrawInfo.Horz.FixedBoundary + Delta.X + 1, ClientHeight);
            if Delta.X > 0 then
              InvalidateRect(Handle, @R, false);
          end
        end
      end
    end
  end;
end;

function TwwCustomDBGrid.IsWWControl(ACol, ARow: integer): boolean;
begin
  result := false;
end;

function TwwCustomDBGrid.CreateEditor: TInplaceEdit;
begin
  result := TwwInplaceEdit.wwCreate(Self, 0);
end;

function TwwCustomDBGrid.DittoField(SelectedField: TField;
  Direction: TwwDittoDirection = wwDittoPrior): boolean; // New method
var
  AllowDitto: boolean;
  value: string;

  Function GetFieldValue(SelectedField: TField; var value: string): boolean;
  begin
    result := false;
    value := '';
    if (wwdoSkipReadOnlyFields in DittoAttributes.Options) then
    begin
      if SelectedField.ReadOnly then
        Exit;
      if ColumnByName(SelectedField.FieldName).ReadOnly then
        Exit;
    end;

    if (wwdoSkipBlobFields in DittoAttributes.Options) and
      (SelectedField is TBlobField) then
      Exit;

    if Direction = wwDittoPrior then
      result := GetPriorRecordText(SelectedField.FieldName, value)
    else if Direction = wwDittoNext then
      result := GetNextRecordText(SelectedField.FieldName, value)
    else
    begin
      result := GetPriorRecordText(SelectedField.FieldName, value);
      if not result then
        result := GetNextRecordText(SelectedField.FieldName, value);
    end
  end;

begin
  result := false;
  if SelectedField <> nil then
  begin
    if GetFieldValue(SelectedField, value) then
    begin
      if Assigned(FOnDitto) then
      begin
        AllowDitto := True;
        try
          FOnDitto(Self, FDataLink.DataSet, SelectedField, value, AllowDitto);
          if not AllowDitto then
            Exit;
        finally
        end;
      end;

      if CanEditModify then
      begin
        if wwGridEssentials then
          DisplayProfessionalVersionOnlyMessage(Self,
            'Ditto Capabilities only supported in InfoPower Professional');

        SelectedField.asstring := value;
      end;
      result := True;
    end
  end;
end;

function TwwCustomDBGrid.IsShortCut(var Message: TWMKey): boolean;
var
  I: integer;
  ShortCut: TShortCut;
  ShiftState: TShiftState;
begin
  result := false;
  ShiftState := KeyDataToShiftState(Message.KeyData);
  ShortCut := Menus.ShortCut(Message.CharCode, ShiftState);
  if ShortCut <> scNone then
  begin
    if ShortCut = DittoAttributes.ShortCutDittoRecord then
    begin
      result := True;
      if wwdoSkipHiddenFields in DittoAttributes.Options then
      begin
        for I := 0 to FieldCount - 1 do
        begin // 4/25/03 - Ditto direction not previously passed
          if DittoField(Fields[I], DittoAttributes.DittoDirection) then
          begin
          end
        end
      end
      else
      begin
        with FDataLink.DataSet do
        begin
          for I := 0 to FieldCount - 1 do
          begin
            if DittoField(Fields[I], DittoAttributes.DittoDirection) then
            begin
            end
          end
        end
      end
    end
    else if ShortCut = DittoAttributes.ShortCutDittoField then
    begin
      if DittoField(SelectedField, DittoAttributes.DittoDirection) then
        result := True;
    end
  end;
end;

procedure TwwCustomDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;
  editor: TwwInplaceEdit;
  DrawInfo: TGridDrawInfo;
  ResultFocus: boolean;

  procedure NextRow;
  begin
    with FDataLink.DataSet do
    begin
      if (State = dsInsert) and not Modified and not FDataLink.FModified then
        if EOF then
          Exit
        else
          Cancel
      else
      begin
        { Already pointing to end of table but active record is before this. 10/15/96 - dsInsert should not increment }
        if EOF and (FDataLink.ActiveRecord >= 0) and
        { IP2 - Used to be >0, now >=0 }
          (FDataLink.ActiveRecord < FDataLink.RecordCount - 1) and
          not(State = dsInsert) then
          FDataLink.ActiveRecord := FDataLink.ActiveRecord + 1
        else
        begin
          Next;
        end
      end;
      if EOF and CanModify and (dgEditing in Options) and
        (dgAllowInsert in KeyOptions) then
      begin
        HideControls;
        Append;
      end;
    end
  end;

  procedure PriorRow;
  begin
    with FDataLink.DataSet do
      if (State = dsInsert) and not Modified and EOF and not FDataLink.FModified
      then
        Cancel
      else
      begin
        if BOF and (FDataLink.ActiveRecord > 0) then
          FDataLink.ActiveRecord := FDataLink.ActiveRecord - 1
        else
          Prior;
      end
  end;

  procedure Tab(GoForward: boolean);
  var
    ACol, Original: integer;
    ParentForm: TCustomForm;
  begin

    ACol := SelectedIndex;
    Original := ACol;
    ParentForm := GetParentForm(Self) as TCustomForm;
    { 12/6/99 - tab to next control in form }
    if SearchMode then
    begin
      if GoForward then
      begin
        if SearchEditor.Column >= FieldCount - 1 then
          Exit;
        Inc(SearchEditor.Column);
      end
      else
      begin
        if SearchEditor.Column = 0 then
          Exit;
        Dec(SearchEditor.Column);
      end;
      // MoveCol(ACol);
      UpdateSearchEditor(SearchEditor.Column);
      Exit;
    end;
    while True do
    begin

      if GoForward then
        Inc(ACol)
      else
        Dec(ACol);
      if ACol >= FieldCount then
      begin
        HideControls; { Necessary when all columns fit in grid's view }
        if (dgTabExitsOnLastCol in Options) then
        begin
          if ParentForm <> nil then
            ParentForm.Perform(wm_nextdlgctl, 0, 0);
          break;
        end
        else
        begin
          if (Original = 0) and TabStops[FIndicatorOffset] then
            SuppressShowEditor := True;
          NextRow;
          ACol := 0;
        end
      end
      { 9/15/98 - Test for GoFoward when going back to previous row }
      else if (dgFixedEditable in Options) and (not GoForward) and (ACol < 0)
      then
      begin
        HideControls;
        if (dgTabExitsOnLastCol in Options) then
        begin
          if ParentForm <> nil then
            ParentForm.Perform(wm_nextdlgctl, 1, 0);
          break;
        end
        else
        begin
          if (FieldCount - 1 <> Original) and
            TabStops[(FieldCount - 1) + FIndicatorOffset] then
            SuppressShowEditor := True;
          PriorRow;
          ACol := FieldCount - 1;
        end
      end
      else if not(dgFixedEditable in Options) and (not GoForward) and
        (ACol < (FixedCols - FIndicatorOffset)) then
      { 7/10/98 - Support fixed columns }
      begin
        HideControls;
        if (dgTabExitsOnLastCol in Options) then
        begin
          if ParentForm <> nil then
            ParentForm.Perform(wm_nextdlgctl, 1, 0);
          break;
        end
        else
        begin
          if (FieldCount - 1 <> Original) and
            TabStops[(FieldCount - 1) + FIndicatorOffset] then
            SuppressShowEditor := True;
          PriorRow;
          ACol := FieldCount - 1;
        end
      end;
      if ACol = Original then
        Exit;
      if TabStops[ACol + FIndicatorOffset] then
      begin
        SuppressShowEditor := false;
        if (ACol = FixedCols - FIndicatorOffset) and GoForward and
          (dgFixedEditable in Options) then
          // ACol := DrawInfo.Horz.FirstGridCell - FIndicatorOffset;
          ACol := DrawInfo.Horz.FixedCellCount - FIndicatorOffset;
        // 6/28/10 (Need to move to first column after fixed)

        if (ACol < FixedCols - FIndicatorOffset) and (dgFixedEditable in Options)
        then
        begin
          FDataLink.UpdateData; // 9/17/02 Allow fixed column to update
          HideControls;
          MoveColRow(ACol + FIndicatorOffset, row, True, false);
          ColEnter; // Make sure event is fired
          InvalidateEditor;
          LeftCol := FixedCols;
          Exit;
        end
        else
        begin
          MoveCol(ACol);
          Exit;
        end
      end;

      SuppressShowEditor := false;
    end;
  end;

  function DeletePrompt: boolean;
  begin
    result := not(dgConfirmDelete in Options) or (MessageDlg(
{$IFDEF wwDelphi3Up}
      SDeleteRecordQuestion,
{$ELSE}
      LoadStr(SDeleteRecordQuestion),
{$ENDIF}
      mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

  Function ShouldShowEditor: boolean;
  var
    tempField: TField;
  begin
    result := false;
    tempField := GetColField(DbCol(col));
    if tempField = Nil then
      Exit;
    if (tempField is TBlobField) then
      Exit; { Changed to TBlobField }
    if IsWWControl(col, row) then
      Exit; { 10/12/96 - Don't show editor for any customEdit }

    result := True;
  end;

  function CustomEditChildHasFocus: boolean;
  begin
    if (CurrentCustomEdit <> nil) and (screen.activecontrol <> nil) and
      (screen.activecontrol.parent = CurrentCustomEdit) then
      result := True
    else
      result := false
  end;

begin
  if IsDropDownGridFocused then
    Exit;

  KeyDownEvent := OnKeyDown;

  if Assigned(KeyDownEvent) then
    KeyDownEvent(Self, Key, Shift);
  if not FDataLink.Active or not CanGridAcceptKey(Key, Shift) then
    Exit;

  CalcDrawInfo(DrawInfo);

  if Key in [vk_up, vk_down, vk_next, vk_prior] then // Prevent flicker
  begin
    Update; // 3/9/01 - Allow previous scroll to complete
    if CurrentCustomEdit <> nil then
      CurrentCustomEdit.Left := ClientWidth + 10;
    if not AcquireFocus then
      Exit;
  end;

  if not(ssCtrl in Shift) and UseRightToLeftAlignment then
  begin
    if Key = vk_left then
      Key := vk_right
    else if Key = vk_right then
      Key := vk_left;
  end;

  with FDataLink.DataSet do
    if ssCtrl in Shift then
    begin
      case Key of
        vk_up, vk_prior:
          MoveBy(-FDataLink.ActiveRecord);
        vk_down, vk_next:
          MoveBy(FDataLink.Buffercount - FDataLink.ActiveRecord - 1);
        vk_left:
          if parent is TwwDBGrid then
          begin
            TwwDBGrid(parent).CollapseChildGrid;
          end
{$IFNDEF GRIDESSENTIALS}
          else if (CurrentCustomEdit is TwwExpandButton) then
          begin
            CollapseChildGrid;
          end
{$ENDIF}
          else
            MoveCol(0);

        vk_right:
          if wwIsClass(CurrentCustomEdit, 'TwwExpandButton') then
          begin
{$IFNDEF GRIDESSENTIALS}
            if not(IsDropDownGridShowing) then
            begin
              TwwExpandButton(CurrentCustomEdit).Expanded := True;
            end
{$ENDIF}
          end
          else
            MoveCol(FieldCount - 1);
        vk_home:
          First;
        vk_end:
          Last;
        vk_delete:
          begin
            if (dgAllowDelete in KeyOptions) and (not ReadOnly) and
              CanModify and (dgEditing in Options) and DeletePrompt then
            begin
              Delete;
              HideEditor; { 10/3/96 }
            end;
            Key := 0; { 10/3/96 }
          end;
      end
    end
    else
    begin
      if (Key in [vk_up, vk_down, vk_left, vk_right, vk_home, vk_end, vk_next,
        vk_prior, vk_delete, vk_insert, vk_tab, vk_return]) and CustomEditChildHasFocus
      then
      begin
        SetFocus;

        // 9/28/08
        ResultFocus := True;
        if FAcquireFocus and CanFocus and not(csDesigning in ComponentState)
        then
        begin
          ResultFocus := Focused or (inplaceeditor <> nil) and
            inplaceeditor.Focused;
        end;
        if not ResultFocus then
          Exit;
      end;

      case Key of
        vk_up:
          PriorRow;
        vk_down:
          NextRow;
        vk_left:
          if dgRowSelect in Options then
            PriorRow
          else
          begin
            MoveCol(SelectedIndex - 1);
          end;
        vk_right:
          if dgRowSelect in Options then
            NextRow
          else
          begin
            if (dgFixedEditable in Options) and
              (SelectedIndex < FixedCols - FIndicatorOffset) then
            begin
              if SelectedIndex = FixedCols - FIndicatorOffset - 1 then
                MoveCol(DrawInfo.Horz.FirstGridCell - FIndicatorOffset)
              else
                MoveCol(SelectedIndex + 1);
            end
            else
              MoveCol(SelectedIndex + 1);
          end;
        vk_home:
          if (FieldCount = 1) or (dgRowSelect in Options) then
            First
          else
          begin
            MoveCol(0);
          end;
        vk_end:
          if (FieldCount = 1) or (dgRowSelect in Options) then
            Last
          else
            MoveCol(FieldCount - 1);
        vk_next:
          MoveBy(VisibleRowCount);
        vk_prior:
          MoveBy(-VisibleRowCount);
        vk_insert:
          if not ReadOnly and (dgEditing in Options) and
            (dgAllowInsert in KeyOptions) then
            Insert;
        vk_tab:
          if not(ssAlt in Shift) then
            Tab(not(ssShift in Shift));
        vk_return:
          if dgEnterToTab in KeyOptions then
            Tab(not(ssShift in Shift));
        VK_ESCAPE:
          begin
            FDataLink.Reset;
            if not(dgAlwaysShowEditor in Options) then
              HideEditor
            else if Assigned(FOnCheckValue) then
            begin
              if (inplaceeditor <> nil) then
              begin
                editor := TwwInplaceEdit(inplaceeditor);
                editor.IsValidPictureValue(editor.Text);
              end
            end
          end;
        VK_F2:
          if ShouldShowEditor then
            EditorMode := True;
      end;
    end;
end;

// type
// TCheatCast = class(TwwCustomDBGrid);

procedure TwwCustomDBGrid.KeyPress(var Key: Char);

var
  OrigKey: Char;
begin
  OrigKey := Key;
  if (dgEnterToTab in KeyOptions) and (ord(Key) = vk_return) then
    Key := #9;
  if not(dgAlwaysShowEditor in Options) and (Key = #13) then
    FDataLink.UpdateData;

  inherited KeyPress(Key);

  if not(dgAlwaysShowEditor in Options) and (OrigKey = #13) then
  begin
    if (not CanEditShow) and EditorMode then
      EditorMode := false;
    if (not CanEditShow) or ((Self.CurrentCustomEdit <> nil) and
      wwGetWantReturns(Self.CurrentCustomEdit)) then
      // if (not CanEditShow) or ((TCheatCast(Self).CurrentCustomEdit <> nil)
      // and wwGetWantReturns(TCheatCast(Self).CurrentCustomEdit)) then
      Key := OrigKey;
  end
end;

procedure TwwCustomDBGrid.InvalidateTitle;

var
  I: integer;
begin
  for I := FIndicatorOffset to LeftCol + VisibleColCount do
  begin
    InvalidateCell(I, 0);
  end
end;

procedure TwwCustomDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);

var
  Temp: integer;
  Field: TField;
  Cell: TGridCoord;
  tempSizing: boolean;
  curgridstate: TGridState;
  newHeight, DefaultRowHeight: integer;
  temppercent: integer;
  TempRect: TRect;
  StartCol, EndCol: integer;

  { procedure InvalidateTitle;
    var i: Integer;
    begin
    for i:= FIndicatorOffset to LeftCol + VisibleColCount do
    begin
    InvalidateCell(i, 0);
    end
    end;
  }
begin
  curgridstate := FGridState;
  tempSizing := Sizing(X, Y);
  inherited MouseUp(Button, Shift, X, Y);

  if tempSizing and (curgridstate = gsColSizing) and Assigned(FOnColWidthChanged)
  then
  begin
    { 12/7/98 - Correct OnColWidthChanged event passing the wrong column }
    if (Self is TwwDBGrid) then
      FOnColWidthChanged(Self, TwwDBGrid(Self).Patch[2]);
  end;

  if (curgridstate = gsRowSizing) and tempSizing and (dgRowResize in Options)
    and (FSizingIndex >= 0) then
  begin
    if (Self is TwwDBGrid) then
    begin
      Canvas.Font := Font;
      DefaultRowHeight := Canvas.TextHeight('W') + NormalPad;
      if HaveAnyRowLines then
        DefaultRowHeight := DefaultRowHeight + 1;

      newHeight := RowHeights[FSizingIndex];
      if dgTitles in Options then
        newHeight := wwmin(newHeight, Trunc((ClientHeight - RowHeights[0] - 1)))
      else
        newHeight := wwmin(newHeight, Trunc((ClientHeight - 1)));

      // RowHeightPercent := Trunc((NewHeight*100.0) / DefaultRowHeight);

      temppercent := wwMax(Trunc((newHeight * 100.0) / DefaultRowHeight),
        MinRowHeightPercent);
      if temppercent <> FRowHeightPercent then
      begin
        RowHeights[FSizingIndex] := newHeight;
        FRowHeightPercent := temppercent;
        LayoutChanged;
      end
      else
      begin // 10/01/2001 - Don't allow setting smaller than defaultrowheight. -PYW
        RowHeights[FSizingIndex] :=
          Trunc((DefaultRowHeight * MinRowHeightPercent) / 100.0);
        FRowHeightPercent := temppercent;
        LayoutChanged;
      end;
    end;
    // FSizingIndex:= -1;
  end;

  if (TitleClickColumn >= 0) then
  begin
    Cell := MouseCoord(X, Y);
    Temp := TitleClickColumn;
    TitleClickColumn := -1;
    TitleClickGroupTitle := false;

    { if (dbCol(Cell.x)>=0) then begin
      if (Columns[dbCol(Cell.X)].GroupName = '') then
      InvalidateCell(Temp, 0)
      else begin
      TempRect := GroupNameCellRect(Cell.X,0,StartCol,EndCol);
      TempRect.Bottom := RowHeights[0]+1;
      TempRect.Right := TempRect.Right+1;
      InvalidateRect(Handle,@TempRect,False);
      end;
      end
      else begin
      InvalidateCell(Temp, 0)
      end; }
    InvalidateTitle; // 8/2/01

    if (Cell.X = Temp) and (Cell.Y = TitleClickRow) and (Y >= 0) then
    begin
      Field := GetColField(DbCol(Cell.X));
      if (Field <> nil) and (not SkipTitleButtonClick) then
      begin
        // 3/30/2001 - PYW - Call OnTitleButtonClick
        TempRect := TitleCellRect(Cell.X, 0);
        if (DbCol(Cell.X) >= 0) and (Columns[DbCol(Cell.X)].GroupName <> '')
        then
        begin
          TempRect := GroupNameCellRect(Cell.X, 0, StartCol, EndCol);
          if PtInRect(TempRect, Point(X, Y)) then
            DoTitleButtonClick(Columns[DbCol(Cell.X)].GroupName)
          else
          begin
            if ShowSearchRow then
            begin
              if PtInRect(TitleCellRect(Cell.X, 0), Point(X, Y)) then
                DoTitleButtonClick(Field.FieldName)
              else
              begin
                // !!! Set focus to search editor
              end;
            end
            else
              DoTitleButtonClick(Field.FieldName)
          end;
        end
        else
        begin
          if ShowSearchRow then
          begin
            if PtInRect(TitleCellRect(Cell.X, 0), Point(X, Y)) then
              DoTitleButtonClick(Field.FieldName)
            else
            begin
              // !!! Set focus to search editor
            end;
          end
          else
            DoTitleButtonClick(Field.FieldName)
        end;
      end;
    end;
  end;
  // Clear Title Click Flags.
  ResetTitleClick;

  { 4/28/99 - Fix problem where fixed column didn't fire event after drag operation }
  SkipTitleButtonClick := false;

  FSizingIndex := -1;
end;

procedure TwwCustomDBGrid.DoTitleButtonClick(AFieldName: string);
begin
  if Assigned(FOnTitleButtonClick) then
    FOnTitleButtonClick(Self, AFieldName)
end;

procedure TwwCustomDBGrid.MouseLoop_DragColumn(HitTest: integer; X, Y: integer);

var
  ACursor: TPoint;
  DrawInfo: TGridDrawInfo;
  Msg: TMsg;
  FirstTime: boolean;
  RootRect, ATitleCellRect: TRect;
  DestRect { , TempRect } : TRect;
  tempx: integer;
  dragTo: integer;
  Cell, OrigCell: TGridCoord;
  Scrolled: boolean;

  CaptureTitleXOffset: integer;
  CaptureTitleMouseDirection: integer;
  CaptureTitleLastMovedPosition: integer;
  LastDestRect: TRect;
  DragFrom: integer;

  MaxWidth: integer;
  GridDisplayWidth: integer;
  ExtraDragOffset: integer;
  I, StartCol, EndCol: integer;
  LastDragTo: integer;
  DragHorzTolerance: integer;

  procedure InvalidateThisRow;

  var
    I: integer;
  begin
    for I := LeftCol to LeftCol + VisibleColCount do
    begin
      InvalidateCell(I, 0);
    end
  end;
  procedure UpdateDestRect;
  begin
    DestRect := Rect(tempx, ExtraDragOffset + DragVertOffset,
      tempx + CaptureTitleBitmap.Width, ExtraDragOffset + DragVertOffset +
      CaptureTitleBitmap.Height);
  end;

  function ValidRect(ACol, ARow: integer): boolean;

  var
    R: TRect;
  begin
    R := CellRect(ACol, ARow);
    result := not((R.Left = 0) and (R.Right = 0) and (R.Top = 0) and
      (R.Bottom = 0))
  end;

  procedure DrawDragLines(offsetleft: integer = 0);
  begin
    if CaptureTitleBitmap = nil then
      Exit;

    CaptureTitleBitmap.Canvas.Pen.Color := clBlack;
    CaptureTitleBitmap.Canvas.MoveTo(RootRect.Right - 1, RootRect.Top);
    CaptureTitleBitmap.Canvas.LineTo(RootRect.Right - 1, RootRect.Bottom - 1);
    CaptureTitleBitmap.Canvas.LineTo(RootRect.Left, RootRect.Bottom - 1);

    CaptureTitleBitmap.Canvas.Pen.Color := clBtnHighlight;
    CaptureTitleBitmap.Canvas.MoveTo(RootRect.Right - 1, RootRect.Top);
    CaptureTitleBitmap.Canvas.LineTo(RootRect.Left + offsetleft, RootRect.Top);
    CaptureTitleBitmap.Canvas.LineTo(RootRect.Left + offsetleft,
      RootRect.Bottom);
  end;

  procedure GroupMove;

  var
    curGroupName, destGroupName: string;
    // ClickedOnGroupName:boolean;
    // ClickedOnGroupChild:boolean;
    I, J: integer;
    // TempDragTo: integer;
  begin
    if ClickedOnGroupName or ClickedOnGroupChild then
    begin
      curGroupName := Columns[DbCol(OrigCell.X)].GroupName;
      if (ClickedOnGroupName) then
      begin
        // Update Drag to so that its not in middle of group
        destGroupName := Columns[DbCol(dragTo)].GroupName;
        if (destGroupName <> '') then
        begin
          if not ClickedOnGroupChild then
          begin
            GroupNameCellRect(dragTo, 0, StartCol, EndCol);
            if (dragTo < DragFrom) then
              dragTo := StartCol
            else
              dragTo := EndCol;
          end
        end;

        GroupNameCellRect(DragFrom, 0, StartCol, EndCol, false);
        // Drag all group columns
        { startcol := 0;
          for i:=FIndicatorOffset to colcount-1 do begin
          if (dbcol(i)>=0) and (Columns[dbcol(i)].GroupName = curgroupname) then begin
          if startcol = 0 then startcol := i;
          endcol := i;
          end;
          end;
        }
        if dragTo > DragFrom then
        begin // Dragging later
          J := 0;
          if (dragTo > EndCol) then
          begin
            for I := EndCol downto StartCol do
            begin
              MoveColumn(I, dragTo - J);
              Inc(J);
            end;
          end
        end
        else
        begin // Dragging before
          J := 0;
          if dragTo < StartCol then
          begin
            for I := StartCol to EndCol do
            begin
              MoveColumn(I, dragTo + J);
              Inc(J);
            end;
          end
        end;
      end
      else
      begin
        // !!!! Still need to restrict cell.x to valid group range
        if (Cell.X >= FIndicatorOffset) and (ATitleCellRect.Top > 0) and
          (curGroupName = Columns[DbCol(Cell.X)].GroupName) then
          MoveColumn(DragFrom, dragTo)
      end;
    end
    else
    begin
      if (ATitleCellRect.Top = 0) or
        ((DragFrom > dragTo) and (TitleCellRect(Cell.X - 1, 0).Top = 0)) or
        ((DragFrom < dragTo) and (TitleCellRect(Cell.X + 1, 0).Top = 0)) then
      begin
        GroupNameCellRect(dragTo, 0, StartCol, EndCol, false);
        if (dragTo >= StartCol) and (dragTo <= EndCol) then
        begin
          if DragFrom > dragTo then // backwards movement to before group
            dragTo := StartCol
          else
            dragTo := EndCol;
        end;
        MoveColumn(DragFrom, dragTo);
        UpdateLeftCol(dragTo);
      end
      else if (TitleCellRect(dragTo, 0).Top > 0) then
      begin
        GroupNameCellRect(dragTo, 0, StartCol, EndCol, false);
        if (CaptureTitleMouseDirection = ctmdBackward) then
          MoveColumn(DragFrom, StartCol)
        else if (CaptureTitleMouseDirection = ctmdForward) then
          MoveColumn(DragFrom, EndCol);
      end;
    end;

    // InvalidateThisRow;
  end;

// Paint drag icon here
  procedure PaintDragIcon(ForceRefresh: boolean = false);

  var
    TempDragTo: integer;
    TempRect: TRect;
    DragIconWidth: integer;
    // i: integer;
    curGroupName: string;
    TempTop: integer;

    function DragBefore: boolean;
    begin
      if UseRightToLeftAlignment then
        result := (TempDragTo > DragFrom)
      else
        result := (TempDragTo < DragFrom)
    end;

    function DragAfter: boolean;
    begin
      if UseRightToLeftAlignment then
        result := (TempDragTo < DragFrom)
      else
        result := (TempDragTo > DragFrom)
    end;

  begin
    if UseRightToLeftAlignment then
      ChangeOrientation(True);
    Cell := MouseCoord(ACursor.X, 0); // ACursor.Y);
    DragIconWidth := DragImages.Width;

    if UseRightToLeftAlignment then // 7/31/09
    begin
      if (LeftCol + VisibleColCount >= ColCount) and
        (ClientWidth - ACursor.X > CellRect(ColCount - 1, 0).Right) then
        TempDragTo := ColCount - 1
      else
      begin
        TempDragTo := min(Cell.X, ColCount - 1);
        TempDragTo := Max(TempDragTo, inherited FixedCols);
      end;
    end
    else
    begin
      if (LeftCol + VisibleColCount >= ColCount) and
        (ACursor.X > CellRect(ColCount - 1, 0).Right) then
        TempDragTo := ColCount - 1
      else
      begin
        TempDragTo := min(Cell.X, ColCount - 1);
        TempDragTo := Max(TempDragTo, inherited FixedCols);
      end;
    end;

    // Don't allow painting in any group header because we
    // started from a group child
    curGroupName := Columns[DbCol(TempDragTo)].GroupName;
    if (curGroupName <> '') then
    begin
      if not ClickedOnGroupChild then
      begin
        GroupNameCellRect(TempDragTo, 0, StartCol, EndCol);
        if (TempDragTo < DragFrom) then
        begin
          TempDragTo := StartCol;
        end
        else
          TempDragTo := EndCol;
      end
    end;

    if ClickedOnGroupChild then
    begin
      // Force to be in group
      GroupNameCellRect(DragFrom, 0, StartCol, EndCol, false);
      if (TempDragTo < StartCol) then
        TempDragTo := StartCol
      else if (TempDragTo > EndCol) then
        TempDragTo := EndCol;
    end;

    if (TempDragTo <> LastDragTo) or ForceRefresh then
    begin
      CalcDrawInfo(DrawInfo);

      if dgIndicator in Options then // Don't repaint indicator header
      begin
        if UseRightToLeftAlignment then
          TempRect := Rect(0, 0, ClientWidth - ColWidths[0] - 1, RowHeights[0])
        else
          TempRect := Rect(ColWidths[0] + 1, 0, ClientWidth, RowHeights[0])
      end
      else
        TempRect := Rect(0, 0, ClientWidth, RowHeights[0]);
      InvalidateRect(Handle, @TempRect, false);

      // Leave title drag box validated so it does not flicker
      tempx := ACursor.X - CaptureTitleXOffset;
      UpdateDestRect;
      ValidateRect(Handle, @DestRect);

      Update;

      // Need to be dragging before group to show arrows
      if ClickedOnGroupName and
        (Columns[DbCol(DragFrom)].GroupName = Columns[DbCol(TempDragTo)
        ].GroupName) then
        Exit;

      TempTop := 0;
      if ClickedOnGroupChild then
        TempTop := TitleCellRect(DragFrom, 0).Top;

      if DragBefore then
      begin
        if Not ValidRect(TempDragTo, 0) then
          Exit;
        // Need to be dragging in group to show arrows

        if TempDragTo > FIndicatorOffset then
          DragImages.Draw(inherited Canvas, CellRect(TempDragTo, 0).Left -
            DragIconWidth, TempTop, 0, True);
        DragImages.Draw(inherited Canvas, CellRect(TempDragTo, 0).Left + 1,
          TempTop, 1, True);
      end
      else if DragAfter then
      begin
        if Not ValidRect(TempDragTo, 0) then
          Exit;

        if TempDragTo > DrawInfo.Horz.LastFullVisibleCell + 1 then
        begin
          DragImages.Draw(inherited Canvas, ClientWidth - DragIconWidth,
            TempTop, 0, True);
        end
        else
        begin
          DragImages.Draw(inherited Canvas, wwmin(CellRect(TempDragTo, 0).Right,
            ClientWidth) - DragIconWidth, TempTop, 0, True);
          DragImages.Draw(inherited Canvas, CellRect(TempDragTo, 0).Right,
            TempTop, 1, True);
        end
      end
    end;
    LastDragTo := TempDragTo;
    if UseRightToLeftAlignment then
      ChangeOrientation(false);
  end;

begin
  SetCapture(Handle);
  FirstTime := True;
  // if useRightToLeftAlignment then ChangeOrientation(True);

  { Make compiler happy with the following 3 assignments }
  CaptureTitleMouseDirection := ctmdNone;
  CaptureTitleLastMovedPosition := 0;
  CaptureTitleXOffset := 0;
  ClickedOnGroupName := false;
  ClickedOnGroupChild := false;

  DragFrom := 0;
  GridDisplayWidth := Width;
  SkipTitleButtonClick := false;

  try
    while GetCapture = Handle do
    begin
      GetCursorPos(ACursor);
      ACursor := ScreenToClient(ACursor);

      // Force to be within grid's boundaries
      ACursor.X := wwLimit(ACursor.X, 0, ClientWidth);
      ACursor.Y := wwLimit(ACursor.Y, 0, ClientHeight);

      case integer(GetMessage(Msg, 0, 0, 0)) of
        - 1:
          break;
        0:
          begin
            PostQuitMessage(Msg.wParam);
            break;
          end;
      end;

      case Msg.Message of
        WM_TIMER:
          begin
            if (Msg.hwnd <> Handle) then
            begin
              TranslateMessage(Msg);
              DispatchMessage(Msg);
              continue;
            end;

            if CaptureTitleBitmap = nil then
              continue;

            Scrolled := false;
            // if (ACursor.x-CaptureTitleXOffset+CaptureTitleBitmap.Width>GridDisplayWidth) and
            DragHorzTolerance := 10;
            if (ACursor.X > GridDisplayWidth - DragHorzTolerance) and
              (CaptureTitleMouseDirection = ctmdForward) then
            begin
              // Don't scroll if end of group is already fully visible
              if ClickedOnGroupChild then
              begin
                GroupNameCellRect(DragFrom, 0, StartCol, EndCol, false);
                if (EndCol <= DrawInfo.Vert.LastFullVisibleCell) then
                  continue;
              end;

              if LeftCol + VisibleColCount >= ColCount then
                continue;
              BeginUpdate;
              LeftCol := LeftCol + 1;
              EndUpdate;
              Invalidate;
              Scrolled := True;
            end
            else if ((ACursor.X - DragHorzTolerance) < CellRect(LeftCol,
              0).Left) and
            // else if (ACursor.x-CaptureTitleXOffset<CellRect(LeftCol, 0).Left) and
              (CaptureTitleMouseDirection = ctmdBackward) then
            begin
              if LeftCol <= inherited FixedCols then
                continue;
              // Don't scroll if end of group is already fully visible
              if ClickedOnGroupChild then
              begin
                GroupNameCellRect(DragFrom, 0, StartCol, EndCol, false);
                if (StartCol < LeftCol) then
                  continue;
              end;
              BeginUpdate;
              LeftCol := LeftCol - 1;
              EndUpdate;
              Invalidate;
              Scrolled := True;
              // Update;
              // PaintDragIcon(True);
            end;
            if Scrolled then
            begin
              tempx := ACursor.X - CaptureTitleXOffset;
              UpdateDestRect;
              // InvalidateRect(Handle, @LastDestRect, False);
              ValidateRect(Handle, @DestRect);
              Update;
              PaintDragIcon(True);
            end;

            (* if Scrolled then
              begin
              tempx:= ACursor.x - CaptureTitleXOffset;
              UpdateDestRect;
              ValidateRect(Handle, @DestRect);
              Update;
              // Use inherited canvas as don't need temp canvas for drag
              inherited Canvas.CopyRect(DestRect, CaptureTitleBitmap.Canvas, RootRect);
              LastDestRect:= DestRect;
              Update;
              end
            *)
          end;

        WM_MOUSEMOVE:
          begin
            if FirstTime then
            begin
              if (Abs(X - ACursor.X) <= 2) and (Abs(Y - ACursor.Y) <= 2) then
                continue;

              // Clear Title Click Flags.
              ResetTitleClick;

              SkipTitleButtonClick := True;
              Cell := MouseCoord(X, Y);
              OrigCell := Cell;
              // ATitleCellRect:= TitleCellRect(Cell.X, Cell.Y);
              ATitleCellRect := DragTitleCellRect(Cell.X, ACursor.X, ACursor.Y);

              // Set flags based on where the initial click was.
              if (ATitleCellRect.Top = 0) then
              begin
                if (DbCol(Cell.X) >= 0) and
                  (Columns[DbCol(Cell.X)].GroupName <> '') then
                  ClickedOnGroupName := True
              end
              else if (ATitleCellRect.Top > 0)
              { and PtInRect(ATitleCellRect, ACursor) } then
                ClickedOnGroupChild := True;

              ExtraDragOffset := ATitleCellRect.Top -
                CellRect(Cell.X, Cell.Y).Top;
              CaptureTitleBitmap := TBitmap.Create;
              CaptureTitleBitmap.Width :=
                Max(ATitleCellRect.Right - ATitleCellRect.Left,
                ColWidths[Cell.X]);
              MaxWidth := Width - 10;

              if ShowVertScrollBar then
                MaxWidth := MaxWidth - GetSystemMetrics(SM_CXHThumb) + 1;
              if dgIndicator in Options then
                MaxWidth := MaxWidth - ColWidths[0] - 2;

              CaptureTitleBitmap.Width := min(CaptureTitleBitmap.Width,
                MaxWidth);
              CaptureTitleBitmap.Height := ATitleCellRect.Bottom -
                ATitleCellRect.Top;
              CaptureTitleXOffset := X - ATitleCellRect.Left;
              RootRect := Rect(0, 0, CaptureTitleBitmap.Width,
                CaptureTitleBitmap.Height);
              UseDragCanvas := True;

              if ClickedOnGroupName then
              begin
                // Paint Group and its sub-items
                GroupNameCellRect(Cell.X, Cell.Y, StartCol, EndCol, false);
                RootRect.Bottom := CaptureTitleBitmap.Height div 2;
                DrawCell(Cell.X, Cell.Y, RootRect, [gdFixed]);
                DrawDragLines;
                RootRect.Top := (CaptureTitleBitmap.Height div 2);
                RootRect.Bottom := CaptureTitleBitmap.Height;
                for I := StartCol to EndCol do
                begin
                  RootRect.Right := RootRect.Left + TitleCellRect(I, Cell.Y)
                    .Right - TitleCellRect(I, Cell.Y).Left;
                  DrawCell(I, Cell.Y, RootRect, [gdFixed]);
                  DrawDragLines(-1);
                  RootRect.Left := RootRect.Right + 1;
                end;
                RootRect := Rect(0, 0, CaptureTitleBitmap.Width,
                  CaptureTitleBitmap.Height);
              End
              else
              begin
                DrawCell(Cell.X, Cell.Y, RootRect, [gdFixed]);
              end;

              UseDragCanvas := false;

              DrawDragLines;

              DragFrom := Cell.X;
              // GroupDrag:= TitleCellRect(Cell.Y, 0).Top=0;
              CaptureTitleMouseDirection := ctmdNone;
              CaptureTitleLastMovedPosition := X;
              LastDestRect := Rect(0, 0, 0, 0);

              SetTimer(Handle, 1, 100, nil);
              if IsScrollBarVisible then
                GridDisplayWidth := Width - GetSystemMetrics(SM_CXHThumb)
              else
                GridDisplayWidth := Width;

              FirstTime := false;
              LastDragTo := -1;
            end
            else
            begin // Not first time
              tempx := ACursor.X - CaptureTitleXOffset;
              UpdateDestRect;
              InvalidateRect(Handle, @LastDestRect, false);
              ValidateRect(Handle, @DestRect);
              Update;

              // Use inherited canvas as don't need temp canvas for drag
              inherited Canvas.CopyRect(DestRect, CaptureTitleBitmap.Canvas,
                RootRect);
              LastDestRect := DestRect;
              if ACursor.X > CaptureTitleLastMovedPosition then
                CaptureTitleMouseDirection := ctmdForward
              else if ACursor.X < CaptureTitleLastMovedPosition then
                // 1/21/01
                CaptureTitleMouseDirection := ctmdBackward;
              CaptureTitleLastMovedPosition := ACursor.X;

              PaintDragIcon;
            end;
          end;

        WM_LBUTTONUP:
          begin
            if not FirstTime then
            begin
              if UseRightToLeftAlignment then
                ChangeOrientation(True);

              KillTimer(Handle, 1);
              InvalidateRect(Handle, @LastDestRect, false);
              CaptureTitleBitmap.Free;
              CaptureTitleBitmap := nil;
              Cell := MouseCoord(ACursor.X, 5); // ACursor.Y);
              LastDestRect := Rect(0, 0, 0, 0);

              { 7/31/09 - Make sure that DragTo isn't more than last column }
              if UseRightToLeftAlignment then
              begin
                if (LeftCol + VisibleColCount >= ColCount) and
                  (ClientWidth - ACursor.X > CellRect(ColCount - 1, 0).Right)
                then
                  dragTo := ColCount - 1
                else
                begin
                  dragTo := min(Cell.X, ColCount - 1);
                  dragTo := Max(dragTo, inherited FixedCols);
                end;
              end
              else
              begin
                if (LeftCol + VisibleColCount >= ColCount) and
                  (ACursor.X > CellRect(ColCount - 1, 0).Right) then
                  dragTo := ColCount - 1
                else
                begin
                  dragTo := min(Cell.X, ColCount - 1);
                  dragTo := Max(dragTo, inherited FixedCols);
                end;
              end;
              {
                if (LeftCol+VisibleColCount>=ColCount) and
                (ACursor.X>CellRect(ColCount-1, 0).Right) then
                DragTo:= ColCount-1
                else begin
                DragTo:= Min(Cell.X, ColCount-1);
                DragTo:= Max(DragTo, inherited FixedCols);
                end;
              }
              TitleClickColumn := -1;
              if DragFrom <> dragTo then
              begin
                // If group is involved in drag operation
                if ClickedOnGroupName or
                // RSW - TitleCellRect not valid for non-visible columns
                // if (TitleCellRect(DragFrom,0).Top>0) or
                  ClickedOnGroupChild or (TitleCellRect(dragTo, 0).Top > 0) then
                begin
                  GroupMove;
                end
                else
                  MoveColumn(DragFrom, dragTo)
              end;
              if UseRightToLeftAlignment then
                ChangeOrientation(false);
              InvalidateThisRow;
              // else InvalidateCell(OrigCell.X, 0);
            end;
            if GetCapture = Handle then
              ReleaseCapture;
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end
      else
        begin
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end
      end { Case }
    end;
  finally
    if GetCapture = Handle then
      ReleaseCapture;
  end;
end;

procedure TwwCustomDBGrid.DoCellChanged;

var
  oldcol, oldrow: integer;
  TempRect: TRect;
begin
  if not DisableCellChangedEvent then
  begin
    if (Self is TwwDBGrid) then
    begin
      oldcol := TwwDBGrid(Self).Patch[6];
      oldrow := TwwDBGrid(Self).Patch[7];

      if GroupFieldName <> '' then
      begin
        TempRect := CellRect(oldcol, oldrow);
        TempRect.Top := TempRect.Top - 1;
        InvalidateRect(Handle, @TempRect, false);
        TempRect := CellRect(col, row);
        TempRect.Top := TempRect.Top - 1;
        InvalidateRect(Handle, @TempRect, false);
      end;

      TwwDBGrid(Self).Patch[6] := col;
      TwwDBGrid(Self).Patch[7] := row;
    end;

    CollapseChildGrid;
    if Assigned(FOnCellChanged) then
      FOnCellChanged(Self);
  end;
end;

procedure TwwCustomDBGrid.DoURLOpen(var URLLink: string; Field: TField;
  var UseDefault: boolean);
begin
  if Assigned(FOnURLOpen) then
    FOnURLOpen(Self, URLLink, Field, UseDefault);
end;

function TwwCustomDBGrid.CreateSearchEditor: TwwGridSearchEditor;
begin
  result := TwwGridSearchEditor.Create(Self);
end;

procedure TwwGridSearchEditor.DoExit;
begin
  inherited DoExit;
  (parent as TwwCustomDBGrid).ColumnByName(FieldName).SearchValue := Text;
  (parent as TwwCustomDBGrid).SearchMode := false;
end;

procedure TwwCustomDBGrid.UpdateSearchEditor(ACol: integer);
// var ACol: integer;
begin
  // ACol:= Col;
  if SearchMode then
  begin
    ColumnByName(SearchEditor.FieldName).SearchValue := SearchEditor.Text;
    SearchMode := false;
  end;

  MoveCol(ACol); // -FIndicatorOffset);
  If SearchEditor = nil then
  begin
    FSearchEditor := CreateSearchEditor;
    SearchEditor.Visible := false;
    SearchEditor.parent := Self;
    SearchEditor.BorderStyle := bsNone;
  end;
  SearchEditor.FieldName := Columns[ACol].FieldName;
  SearchEditor.Column := ACol;
  SearchEditor.BoundsRect := SearchCellRect(ACol + FIndicatorOffset, 0);
  SearchEditor.Visible := True;
  SearchEditor.Text := Columns[ACol].SearchValue;
  SearchEditor.SetFocus;
  SearchEditor.SelectAll;
  SearchMode := True;
end;

function TwwCustomDBGrid.TitleImageRect(ACol: integer): TRect;

var
  // ATextRect: TRect;
  TitleImageAttributes: TwwTitleImageAttributes;
  ARect, AImageRect: TRect;
  TitleOffset: integer;
begin
  TitleImageAttributes.IsGroupHeader := false;
  TitleImageAttributes.ImageIndex := -1;
  TitleImageAttributes.Alignment := taRightJustify;
  TitleImageAttributes.Margin := 3;
  TitleOffset := 0;

  ARect := TitleCellRect(ACol, 0, false);
  case TitleImageAttributes.Alignment of
    taRightJustify:
      begin
        AImageRect.Left := ARect.Right - EffectiveTitleImageList.Width -
          TitleImageAttributes.Margin + TitleOffset;
        AImageRect.Top :=
          (ARect.Top + ARect.Bottom - EffectiveTitleImageList.Height) div 2 +
          TitleOffset;

      end;
    taLeftJustify:
      begin
        AImageRect.Left := ARect.Left + TitleImageAttributes.Margin +
          TitleOffset;
        AImageRect.Top :=
          (ARect.Top + ARect.Bottom - EffectiveTitleImageList.Height) div 2 +
          TitleOffset;

      end;
    taCenter:
      begin
        AImageRect.Left :=
          (ARect.Left + ARect.Right - EffectiveTitleImageList.Width) div 2 +
          TitleOffset;
        AImageRect.Top :=
          (ARect.Top + ARect.Bottom - EffectiveTitleImageList.Height) div 2 +
          TitleOffset;

      end;
  end;
  AImageRect.Right := AImageRect.Left + EffectiveTitleImageList.Width;
  AImageRect.Bottom := AImageRect.Top + EffectiveTitleImageList.Height;
  result := AImageRect;

end;

procedure TwwCustomDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);

var
  Cell: TGridCoord;
  CellChanged: boolean;
  TempOnMouseDown: TMouseEvent;
  NewRow: boolean;
  TempShiftSelectBookmark: TBookmark;
  SendMouseMessage: boolean;
  OldLeftCol: integer;
  pt: TPoint;
  MouseControl: TControl;
  OrigRowOffset, OrigRow: integer;
  SaveUpdateRect: TRect;
  DrawInfo: TGridDrawInfo;
  adummy: integer;
  curgridstate: TGridState;
  TempCustomEdit: TWinControl;
  GlyphRect: TRect;
  UseDefault: boolean;
  LinkAddress: string;
  URLDisplay: string;
  pos1, pos2: integer;
  customEdit: TWinControl;
  lastPos: integer;
  InTitle: boolean;
  InSearchRow: boolean;
  processed: boolean;

  Procedure CallMouseDown;
  begin
    TempOnMouseDown := OnMouseDown;
    if Assigned(TempOnMouseDown) then
    begin
      Update;
      TempOnMouseDown(Self, Button, Shift, X, Y);
    end
  end;
{
  procedure ProcessTitleClick;
  begin
  if TitleButtons and (ssLeft in Shift) and not (csDesigning in ComponentState) then
  begin
  Cell := MouseCoord(X, Y);
  if (Cell.Y < FTitleOffset) then
  begin
  TitleClickColumn:= Cell.X;
  TitleClickRow:= Cell.y;
  InvalidateCell(Cell.X, 0);
  end
  end;
  end;
}
  procedure ProcessTitleClick(var processed: boolean);

  var
    StartCol, EndCol: integer;
    TempRect: TRect;
    clientPt: TPoint;
  begin
    processed := false;
    if (TitleButtons or TitleMenuAttributes.TitleMenuEnabled) and
      (ssLeft in Shift) and not(csDesigning in ComponentState) then
    begin
      Cell := MouseCoord(X, Y);
      clientPt := ClientToScreen(Point(0, 0));
      if (Cell.Y < FTitleOffset) and (Cell.X >= FIndicatorOffset) then
      // 9/16/02 (Ignore Title buttons for indicator column)
      begin
        if TitleMenuAttributes.TitleMenuEnabled and DataLink.Active and
          PtInRect(TitleImageRect(Cell.X), Point(X, Y)) then
        begin
          FormGridFilterTypesNeeded;
          FormGridFilterTypes.Column := Columns[DbCol(Cell.X)];
          FormGridFilterTypes.PopupFilterMenu.Popup
            (clientPt.X + TitleImageRect(Cell.X).Left,
            clientPt.Y + Self.TitleCellRect(Cell.X, 0).Bottom - 1);
          ControlState := ControlState - [cslButtonDown];
          // Maybe should do this when closing up instead of now
          processed := True;
          Exit;
        end;
        TitleClickColumn := Cell.X;
        TitleClickRow := Cell.Y;
        InvalidateCell(Cell.X, 0);

        TitleClickGroupTitle := false;
        if (DbCol(Cell.X) >= 0) then
        begin
          if (Columns[DbCol(Cell.X)].GroupName <> '') then
          begin
            TempRect := GroupNameCellRect(Cell.X, 0, StartCol, EndCol);
            if Y <= TempRect.Bottom then
            begin
              TitleClickGroupTitle := True;
            end
            else
              TempRect := TitleCellRect(Cell.X, 0);
            TempRect.Right := TempRect.Right + 1;
            TempRect.Bottom := TempRect.Bottom + 1;
            InvalidateRect(Handle, @TempRect, false);
          end;
        end
      end
    end;
  end;

  function CheckAutoSizeColumn: boolean;

  // Return true if auto-sized column
  var
    gc: TGridCoord;
    pt: TPoint;
  begin
    result := (dgDblClickColSizing in Options);
    if not result then
      Exit;
    result := false;

    pt := ScreenToClient(Mouse.CursorPos);
    pt.X := pt.X - 5;
    gc := MouseCoord(pt.X, pt.Y);
    if (gc.Y >= FTitleOffset) then
      Exit;
    if pt.X < TitleCellRect(gc.X, 0).Right - 8 then
      Exit;
    if (gc.Y < 0) then
      Exit; // 2/24/03

    result := True;
    AutoSizeColumn(gc.X);
  end;

begin
  // 3/8/00 - AcquireFocus not blindly called as it causes currentcustomedit to repaint
  // which may cause slight flicker for active cell
  // if not AcquireFocus then Exit;
  FSizingIndex := -1;
  FPriorSizingWidth := 0;
  FreeHintWindow;
  OrigRow := row;
  OrigRowOffset := 0;
  NewRow := false;
{$IFNDEF GRIDESSENTIALS}
  if (CurrentCustomEdit is TwwExpandButton) then
    OrigRowOffset := RowOffset;
{$ENDIF}
  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    if not AcquireFocus then
      Exit;
    if not CheckAutoSizeColumn then
      DblClick;
    Exit;
  end;
  if Sizing(X, Y) then
  begin
    if (dgRowResize in Options) or (IsProportionalColumns) then
    begin
      CalcDrawInfo(DrawInfo);
      CalcSizingState(X, Y, curgridstate, FSizingIndex, adummy, adummy,
        DrawInfo);
      if curgridstate = gsColSizing then
        FPriorSizingWidth := ColWidths[FSizingIndex];
    end;
    { 12/7/98 - Correct OnColWidthChanged event passing the wrong column }
    Cell := MouseCoord(X - 8, Y);
    if Self is TwwDBGrid then
      TwwDBGrid(Self).Patch[2] := Cell.X;

    FDataLink.UpdateData; { 2/7/97 - Flush data to TField if modified }
    inherited MouseDown(Button, Shift, X, Y)
  end
  else
  begin
    Cell := MouseCoord(X, Y);
    SendMouseMessage := ((row <> Cell.Y) or (col <> Cell.X)) and
      (Cell.X >= FIndicatorOffset);
    OldLeftCol := LeftCol;

    // if Cell.Y<FTitleOffset then begin  // 5/18/01 - Use FTitleOffset intead
    if Cell.Y < 0 then
    begin
      if not AcquireFocus then
        Exit;
      CallMouseDown;
      Exit;
    end;
    { 12/21/97 - Use goColMoving instead of dgColumnResize.  Developer can
      then progmatically set goColMoving to False, while leaving the column
      sizing as True. }
    InTitle := (Cell.Y < FTitleOffset) and
      (PtInRect(TitleCellRect(Cell.X, Cell.Y, True), Point(X, Y)));
    InSearchRow := (not InTitle) and (Cell.Y < FTitleOffset) and
      (PtInRect(SearchCellRect(Cell.X, Cell.Y), Point(X, Y))) and ShowSearchRow;
    if ((csDesigning in ComponentState) or (goColMoving in inherited Options))
      and (Cell.Y < FTitleOffset) and InTitle then
    begin
      if not AcquireFocus then
        Exit;

      { 10/15/97 - Allow resize even if titlebuttons is True }
      ProcessTitleClick(processed);
      if (processed) then
        Exit;

      { Copy title snapshot to bitmap - Use when mouse moves }
      if Cell.X >= inherited FixedCols then
      begin
        if ssLeft in Shift then
          MouseLoop_DragColumn(0, X, Y);
        CallMouseDown;
        Exit;
      end;

      inherited MouseDown(Button, Shift, X, Y);
    end
    else if (not(goColMoving in inherited Options)) and (Cell.Y < FTitleOffset)
      and InTitle then
    begin
      if not AcquireFocus then
        Exit;
      ProcessTitleClick(processed);
      if (processed) then
        Exit;
    end
    else if (Cell.Y < FTitleOffset) and InSearchRow then
    begin
      if not AcquireFocus then
        Exit;
      HideControls;
      UpdateSearchEditor(Cell.X - FIndicatorOffset);
    end
    else
    begin
      if FDataLink.Active then
        with Cell do
        begin
          if (X = col) and (Y = row) and not IsWWControl(col, row) and
            (not IsMemoField(col, row)) then
            // 3/3/2002-PYW-Don't showeditor if this is the right mouse button.
            if Button <> mbRight then
              ShowEditor; { Don't show internal editor if memo field }
          NewRow := (Y >= FTitleOffset) and (Y - row <> 0);
          if NewRow then
            SuppressShowEditor := True;

          CellChanged := (Y <> row) or (X <> col);
          DisableCellChangedEvent := True;
          if CellChanged and (CurrentCustomEdit <> nil) then
            CurrentCustomEdit.Left := ClientWidth + 10;
          if not AcquireFocus then
            Exit;

          if not(dgRowSelect in Options) then
          { 9/3/99 - Don't reset LeftCol }
          begin
            if (X >= inherited FixedCols) then
              MoveCol(X - FIndicatorOffset)
            else if (dgFixedEditable in Options) then
            begin
              MoveCol(X - FIndicatorOffset);
            end
          end;
          SuppressShowEditor := false;

          if NewRow then
          begin
            // 2/10/11 - Make sure grid is on correct row after record is auto-deleted
            // Record gets automatically deleted by delphi so we need to move to one row less
            if (FDataLink.DataSet <> nil) and
              (dsInsert = FDataLink.DataSet.State) and not FDataLink.DataSet.Modified
            then
            begin
              if (Self is TwwDBGrid) and (TwwDBGrid(Self).Patch[12] = false) and
                (Y > OrigRow) then
                FDataLink.DataSet.MoveBy(Y - OrigRow - 1)
              else
                FDataLink.DataSet.MoveBy(Y - OrigRow)
            end
            else
              FDataLink.DataSet.MoveBy(Y - OrigRow)

          end;
          DisableCellChangedEvent := false;

          if CellChanged then
            DoCellChanged;

          // Support url links
          if (X >= 0) and (Button = mbLeft) and (X <= FCacheColInfo.Count - 1)
            and // 10/4/04
            (TwwCacheColInfoItem(FCacheColInfo[X]).ControlType = 'URL-Link')
          then
          begin
            UseDefault := True;
            if Fields[X - FIndicatorOffset] <> nil then
            begin
              GetURLLink(FDataLink.DataSet.fieldByName
                (Fields[X - FIndicatorOffset].FieldName).asstring, URLDisplay,
                LinkAddress);
              DoURLOpen(LinkAddress, Fields[X - FIndicatorOffset], UseDefault);
              if UseDefault then
              begin
                if AnsiPos('MAILTO:', AnsiUpperCase(LinkAddress)) <= 0 then
                begin
                  pos1 := AnsiPos('@', LinkAddress);
                  pos2 := AnsiPos('.', LinkAddress);
                  if (strCount(LinkAddress, '.') >= 1) then // 1/4/09
                  begin
                    lastPos := Length(LinkAddress);
                    while (lastPos >= 1) do // Find last position of '.'
                    begin
                      if LinkAddress[lastPos] = '.' then
                      begin
                        pos2 := lastPos;
                        break;
                      end;
                      Dec(lastPos);
                    end;
                  end;

                  if (pos1 > 1) and (pos2 > pos1) then
                    LinkAddress := 'MailTo:' + LinkAddress;
                end;

                screen.Cursor := crHourGlass;
                ShellExecute(Handle, 'OPEN', PChar(LinkAddress), nil, nil,
                  sw_shownormal);
                screen.Cursor := crDefault;
                { 10/30/98 - Restore to default cursor }
              end
            end
          end;

          TempShiftSelectBookmark := ShiftSelectBookmark; { 5/13/98 }

          if (dgMultiSelect in Options) and not IsSelectedCheckbox(X) then
          begin
            if ((ssCtrl in Shift) or (ssShift in Shift)) then
            begin
              if IsSelected then
                UnselectRecord
              else
                SelectRecord;
            end
            else
            begin
              { 7/10/97 - Unselect all only if left button is clicked - Allows popupmenu }
              if (msoAutoUnselect in MultiSelectOptions) and (ssLeft in Shift)
              then
              begin
                UnselectAll;
                SelectRecord;
              end
            end
          end;

          if (dgMultiSelect in Options) and
            ((ssShift in Shift) or (ssCtrl in Shift) or
            (msoAutoUnselect in MultiSelectOptions)) then
          begin
            if (msoShiftSelect in MultiSelectOptions) then
            begin
              ShiftSelectMode := True;
              FDataLink.DataSet.CheckBrowseMode;

              { 5/13/98 - Only Getbookmark one time as SelectRecord can get bookmark }
              if TempShiftSelectBookmark = ShiftSelectBookmark then
                ShiftSelectBookmark := FDataLink.DataSet.GetBookmark;
            end
          end

        end;

      // Send mouse message to control that has just become visible
      InvalidateCell(col, row);

      // Don't call Update until later if expandbutton collapsing and expanding
      // Update currentCustomEdit manually instead of by calling update
      if (not(ecoDisableCustomControls in EditControlOptions)) and
        IsCustomEditCell(col, row, customEdit) and
        wwIsClass(customEdit, 'TwwExpandButton') then
      begin
        // Following code prevents flicker when collapsing and expanding
        UpdateCustomEdit;
      end
      else
      begin
        // Following code prevents flicker when collapsing and expanding
        Windows.GetUpdateRect(Handle, SaveUpdateRect, false);
        ValidateRect(Handle, nil);
        InvalidateCell(col, row);
        Update; // Allows CurrentCustomEdit to be assigned correctly
        InvalidateRect(Handle, @SaveUpdateRect, false);
      end;

      if SendMouseMessage and (CurrentCustomEdit <> nil) and
        not wwIsClass(CurrentCustomEdit.classtype, 'TCustomEdit') and
        (LeftCol = OldLeftCol) and not(ssCtrl in Shift) then
      begin
        pt := Point(X - CurrentCustomEdit.Left, Y - CurrentCustomEdit.Top);
        MouseControl := CurrentCustomEdit.ControlAtPos(pt, false, True);

        if (MouseControl <> nil) and (MouseControl is TWinControl) then
        begin
          MouseControl.ScreenToClient(pt);
          SendMessage(TWinControl(MouseControl).Handle, WM_LBUTTONDOWN, 0,
            MakeLParam(pt.X - MouseControl.Left, pt.Y - MouseControl.Top));

          // 2/10/01 - Sending up as well to take care of problem of combo-button
          // remaining down if clicked when it is not visible.
          SendMessage(TWinControl(MouseControl).Handle, WM_LBUTTONUP, 0,
            MakeLParam(pt.X - MouseControl.Left, pt.Y - MouseControl.Top));
          // MouseControl.ControlState:=MouseControl.ControlState-[cslButtonDown];
        end
        else
        begin
          // 1. Get Control for Cell.X column
          // 2. If expand button and on left-side then try to expand
          if IsCustomEditCell(Cell.X, Cell.Y, TempCustomEdit) and
            (TempCustomEdit = CurrentCustomEdit) and
            wwIsClass(CurrentCustomEdit, 'TwwExpandButton') and NewRow then
          // and (OrigRowOffset>0) then
          begin
{$IFNDEF GRIDESSENTIALS}
            TwwExpandButton(CurrentCustomEdit).ComputeGlyphRect(GlyphRect);
            InflateRect(GlyphRect, 4, 3);
            GlyphRect.Top := 0;
            pt := Point(X - CurrentCustomEdit.Left, 7);
            if PtInRect(GlyphRect, pt) then
            begin
              if NewRow and (OrigRow + OrigRowOffset > row) and
                (OrigRowOffset > 0) then
                TwwExpandButton(CurrentCustomEdit).DesiredRow := Cell.Y
              else
                TwwExpandButton(CurrentCustomEdit).DesiredRow := -1;

              RowOffset := OrigRowOffset;
              try
                TwwExpandButton(CurrentCustomEdit).Expanded := True;
              finally
                TwwExpandButton(CurrentCustomEdit).DesiredRow := -1;
              end
            end
{$ENDIF}
          end
          else
          begin
            // ! Don't want to send message unless its a button kind of control
            if not(CurrentCustomEdit is TCustomEdit) then
              SendMessage(CurrentCustomEdit.Handle, WM_LBUTTONDOWN, 0,
                MakeLParam(X - CurrentCustomEdit.Left,
                Y - CurrentCustomEdit.Top));
          end;
        end
      end;
    end;
    CallMouseDown;
  end;
{$IFNDEF GRIDESSENTIALS}
  if (CurrentCustomEdit <> nil) and wwIsClass(CurrentCustomEdit.classtype,
    'TwwDBRichEdit') then
    TwwDBRichEdit(CurrentCustomEdit).ClickTime := GetMessageTime;
{$ENDIF}
  // Save last MouseDown time
  // Use in custom control if it wants to
  // send dbl-click to the grid

end;

procedure TwwCustomDBGrid.InvalidateFooter;

var
  FooterRect: TRect;
begin
  FooterRect := GetFooterRect;
  InvalidateRect(Handle, @FooterRect, false);
end;

procedure TwwCustomDBGrid.ColEnter;
begin
  // if GetColField(dbCol(Col))<>Nil then
  // OriginalCellText:= GetColField(dbCol(Col)).asString
  // else OriginalCellText:= '';

  if Assigned(FOnColEnter) then
  begin
    FOnColEnter(Self);
  end;
  DoCellChanged;
end;

procedure TwwCustomDBGrid.ColExit;
begin
  if Assigned(FOnColExit) then
    FOnColExit(Self);
end;

procedure TwwCustomDBGrid.ColumnMoved(FromIndex, ToIndex: Longint);

var
  Temp: string;
  FooterRect: TRect;
begin
  FromIndex := FromIndex - FIndicatorOffset;
  ToIndex := ToIndex - FIndicatorOffset;

  if UseTFields then
  begin
    if FDataLink.Active and (FieldCount > 0) then
      Fields[FromIndex].Index := Fields[ToIndex].Index;
  end
  else
  begin
    { 12/11/97 - Insert in front instead of switching columns }
    Temp := Selected[FromIndex];
    Selected.Delete(FromIndex);
    Selected.Insert(ToIndex, Temp);
    LayoutChanged;
  end;
  FooterRect := GetFooterRect;
  Windows.InvalidateRect(Canvas.Handle, @FooterRect, false);

  if Assigned(FOnColumnMoved) then
    FOnColumnMoved(Self, FromIndex, ToIndex);

end;

procedure TwwCustomDBGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource) then
      DataSource := nil
    else if (FIndicatorButton = AComponent) then
      FIndicatorButton := nil
    else if (FImageList = AComponent) then
      FImageList := nil
    else if (FTitleImageList = AComponent) then
      FTitleImageList := nil
  end;
end;

procedure TwwCustomDBGrid.TimedScroll(Direction: TGridScrollDirection);
begin
  if FDataLink.Active then
  begin
    with FDataLink do
    begin
      if sdUp in Direction then
      begin
        DataSet.MoveBy(-ActiveRecord - 1);
        Exclude(Direction, sdUp);
      end;
      if sdDown in Direction then
      begin
        DataSet.MoveBy(RecordCount - ActiveRecord);
        Exclude(Direction, sdDown);
      end;
    end;
    if Direction <> [] then
      inherited TimedScroll(Direction);
  end;
end;

procedure TwwCustomDBGrid.ColWidthsChanged;

var
  I: integer;
  CWidth: integer;
  ParentForm: TCustomForm;
  tempSelected, parts: TStrings;
begin
  inherited ColWidthsChanged;
  if (FUpdatingColWidths = 0) and FUpdateFields and FDataLink.Active and HandleAllocated
  then
  begin
    Inc(FUpdateLock);
    tempSelected := nil;
    parts := nil;

    // if dgProportionalColResize in Options then
    // ProportionalColWidths(False);  // Update colWidths

    try
      begin
        Canvas.Font := Font;
        CWidth := Canvas.TextWidth('0');

        { 10/28/98 - Substract 4 from ColWidths to be consistent with setting of ColWidths }
        if UseTFields then
        begin
          for I := 0 to FieldCount - 1 do
            { 6/11/99 - Make sure adding never subtracting }
            Fields[I].DisplayWidth :=
              ((ColWidths[I + FIndicatorOffset] - 4) + wwMax(0,
              CWidth div 2 - 3)) div CWidth;
        end
        else
        begin
          tempSelected := TStringList.Create;
          parts := TStringList.Create;
          tempSelected.assign(Selected);
          Selected.Clear;
          for I := 0 to tempSelected.Count - 1 do
          begin
            strBreakApart(tempSelected[I], #9, parts);
            { 6/11/99 - Make sure adding never subtracting }
            Selected.Add(parts[0] + #9 +
              inttostr(((ColWidths[I + FIndicatorOffset] - 4) + wwMax(0,
              CWidth div 2 - 3)) div CWidth) + #9 + parts[2]);
            // Selected.Add(parts[0] + #9 +
            // inttostr(((ColWidths[I + FIndicatorOffset]-4) {+ wwMax(0, CWidth div 2 - 3)}) div CWidth)
            // +#9 + parts[2]);
            if parts.Count > 3 then
              Selected[I] := Selected[I] + #9 + parts[3];
            if parts.Count > 4 then
              Selected[I] := Selected[I] + #9 + parts[4];
          end;
        end;

        ParentForm := GetParentForm(Self) as TCustomForm; { -ksw (6/22/98) }
        if (ParentForm <> nil) and (TForm(ParentForm).Designer <> nil) then
        begin
          ParentForm.Designer.Modified;
        end
      end
    finally
      Dec(FUpdateLock);
      tempSelected.Free;
      parts.Free;
    end;
    LayoutChanged;
    { SizelastColumn; {!!! 4/7/97 }
  end;
end;

procedure TwwCustomDBGrid.Loaded;
begin
  inherited Loaded;
  LayoutChanged;
{$IFNDEF GRIDESSENTIALS}
  if parent <> nil then
  begin // 2/13/2002 - Don't call InitBlendBitmaps if no background bitmap loaded.
    if (PaintOptions.BackgroundBitmap.Width <> 0) then
      PaintOptions.InitBlendBitmaps;
    // PaintOptions.InitBlendBitmaps;  //10/04/2001-InitBlendBitmaps will fail if Parent is nil.(PYW)
  end;
{$ENDIF}
end;

procedure TwwCustomDBGrid.SetOptions(value: TwwDBGridOptions);

const
  LayoutOptions = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgPerfectRowFit,
    dgShowFooter
  { , dgVariableRowHeight } , dgProportionalColResize];

var
  NewGridOptions: TGridOptions;
  ChangedOptions: TwwDBGridOptions;
begin
  if FOptions <> value then
  begin
    NewGridOptions := [];
    if dgColLines in value then
      NewGridOptions := NewGridOptions + [goFixedVertLine, goVertLine];
    if dgRowLines in value then
      NewGridOptions := NewGridOptions + [
      { goFixedHorzLine, } goHorzLine];
    if not(dgRowLinesDisableFixed in value) then
      NewGridOptions := NewGridOptions + [goFixedHorzLine
      { , goHorzLine } ];
    if dgColumnResize in value then
    begin
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
      if dgDisableColumnReorder in value then
        // 12/28/10 - New property to disable column reordering
        NewGridOptions := NewGridOptions - [goColMoving];
    end;

    if dgRowResize in value then
      NewGridOptions := NewGridOptions + [goRowSizing];
    if dgTabs in value then
      Include(NewGridOptions, goTabs);
    if dgRowSelect in value then
      Include(NewGridOptions, goRowSelect);
    if (dgEditing in value) and not(dgRowSelect in value) then
      { edit not allowed if RowSelect }
      Include(NewGridOptions, goEditing);
    if dgAlwaysShowEditor in value then
      Include(NewGridOptions, goAlwaysShowEditor);
    inherited Options := NewGridOptions;
    ChangedOptions := (FOptions + value) - (FOptions * value);
    // if dgProportionalColResize in ChangedOptions then
    // begin
    // ShowHorzScrollBar:= ShowHorzScrollBar; // Refreshes based on proportional property
    // end;

    if (dgWordWrap in value) <> (dgWordWrap in FOptions) then
    begin
      if (inplaceeditor <> Nil) then
        (inplaceeditor as TwwInplaceEdit).WordWrap := (dgWordWrap in value);
      Invalidate; { if wordwrap changed }
    end;
    FOptions := value;
    if ChangedOptions * [dgIndicator] <> [] then
      ResetProportionalWidths;
    if ChangedOptions * LayoutOptions <> [] then
      LayoutChanged;
  end;

end;

procedure TwwCustomDBGrid.SetTitleFont(value: TFont);
begin
  FTitleFont.assign(value);
  LayoutChanged;
end;

procedure TwwCustomDBGrid.SetIndicatorIconColor(value: TColor);

var
  I: integer;
begin
  FIndicatorIconColor := value;
  // InitIndicators;
  for I := 0 to ColCount - 1 do
    InvalidateCell(I, row);
end;

procedure TwwCustomDBGrid.SetTitleAlignment(sel: TAlignment);
begin
  if sel <> FTitleAlignment then
  begin
    FTitleAlignment := sel;
    LayoutChanged;
  end
end;

procedure TwwCustomDBGrid.SetTitleLines(sel: integer);
begin
  if sel <= 0 then
    Exit;
  if sel <> FTitleLines then
  begin
    FTitleLines := sel;
    LayoutChanged;
  end
end;

procedure TwwCustomDBGrid.SetRowHeightPercent(sel: integer);
begin
  if sel <= 0 then
  begin
    FRowHeightPercent := 100;
    Exit;
  end;

  if sel <> FRowHeightPercent then
  begin
    FRowHeightPercent := sel;
    LayoutChanged;
  end;
  MinRowHeightPercent := FRowHeightPercent;
end;

procedure TwwCustomDBGrid.DoCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if Assigned(FOnCalcTitleImage) then
    FOnCalcTitleImage(Sender, Field, TitleImageAttributes);
end;

procedure TwwCustomDBGrid.DoDrawTitleCell(ACanvas: TCanvas; Field: TField;
  ARect: TRect; var DefaultDrawing: boolean);
begin
  if Assigned(FOnDrawTitleCell) then
    FOnDrawTitleCell(Self, ACanvas, Field, ARect, DefaultDrawing);
end;

procedure TwwCustomDBGrid.DoDrawGroupHeaderCell(ACanvas: TCanvas;
  GroupHeaderName: string; ARect: TRect; var DefaultDrawing: boolean);
begin
  if Assigned(FOnDrawGroupHeaderCell) then
    FOnDrawGroupHeaderCell(Self, ACanvas, GroupHeaderName, ARect,
      DefaultDrawing);
end;

procedure TwwCustomDBGrid.DoCalcTitleAttributes(AFieldName: string;
  AFont: TFont; ABrush: TBrush; var FTitleAlignment: TAlignment);

var
  OldBrushColor: TColor;
  OldFontColor: TColor;
begin
  OldBrushColor := Canvas.Brush.Color;
  OldFontColor := Canvas.Font.Color;
  if Assigned(FOnCalcTitleAttributes) then
  begin
    FOnCalcTitleAttributes(Self, AFieldName, AFont, ABrush, FTitleAlignment);
  end;
  ChangedBrushColor := OldBrushColor <> Canvas.Brush.Color;
  ChangedFontColor := OldFontColor <> Canvas.Font.Color;
end;

procedure TwwCustomDBGrid.DoCalcCellColors(Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
// var OldBrushColor: TColor;
begin
  // OldBrushColor:= Canvas.Brush.Color;
  { if dgRowSelectEditable in Options then
    begin
    if (CalcCellRow=dbRow(Row)) and not (gdFixed in State) then
    begin
    ABrush.Color:= clHighlight;
    AFont.Color:= clHighlightText;
    end
    end;
  }
  if Assigned(FOnCalcCellColors) then
  begin
    if wwGridEssentials then
      DisplayProfessionalVersionOnlyMessage(Self,
        'OnCalcCellColors only supported in InfoPower Professional');

    FOnCalcCellColors(Self, Field, State, Highlight, AFont, ABrush);
  end;
  // isWhiteBackground:= ColorToRGB(Canvas.Brush.Color)=clWhite;
  // ChangedBrushColor:= OldBrushColor<>Canvas.Brush.Color;
end;

procedure TwwCustomDBGrid.DoCalcCellColorsDetect(Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);

var
  OldBrushColor: TColor;
  OldFontColor: TColor;
begin
  OldBrushColor := Canvas.Brush.Color;
  OldFontColor := Canvas.Font.Color;
  DoCalcCellColors(Field, State, Highlight, AFont, ABrush);
  IsWhiteBackground := ColorToRGB(Canvas.Brush.Color) = clWhite;
  ChangedBrushColor := OldBrushColor <> Canvas.Brush.Color;
  ChangedFontColor := OldFontColor <> Canvas.Font.Color;
end;

Function TwwCustomDBGrid.GetShowHorzScrollBar: boolean;
begin
  result := FShowHorzScrollBar;
  // result:= (ScrollBars in [ssBoth, ssHorizontal]) and
  // (not IsProportionalColumns);
end;

Procedure TwwCustomDBGrid.SetShowHorzScrollBar(val: boolean);
begin
  if (val and (not IsProportionalColumns)) then
    ScrollBars := ssHorizontal
  else
    ScrollBars := ssNone;
  FShowHorzScrollBar := val;
end;

Procedure TwwCustomDBGrid.SetShowVertScrollBar(val: boolean);
begin
  FShowVertScrollBar := val;
  UpdateScrollBar;
  if (IndicatorButton <> nil) and UseRightToLeftAlignment then
    with IndicatorButton do
      SetBounds(Left, Top, Width, Height);
  Invalidate;
end;

Function TwwCustomDBGrid.IsMemoField(ACol, ARow: integer): boolean;

var
  Field: TField;
begin
  result := false;
  if DbRow(ARow) < 0 then
    Exit;
  Field := GetColField(DbCol(ACol));
  if (Field = nil) then
    Exit;
  if not(Field is TBlobField) then
    Exit;
  if (not(Field.DataType in [ftMemo, ftOraBlob, ftOraclob
{$IFDEF wwDelphi2006Up}
    , ftWideMemo
{$ENDIF}
    ])) and { 6/8/98 - return true if richedit field }
    (not wwIsRichEditField(Field, false)) then
    Exit;

  result := True;
end;

function TwwCustomDBGrid.IsCheckBox(col, row: integer;
  var checkboxon, checkboxoff: string): boolean;

var
  FldName: string;
  I: integer;
  parts: TStrings;
  ControlType: TStrings;
begin
  result := false;
  if not IsValidCell(col, row) then
    Exit;

  FldName := DataLink.Fields[DbCol(col)].FieldName;
  parts := TStringList.Create;

  ControlType := GetControlType;
  for I := 0 to ControlType.Count - 1 do
  begin
    strBreakApart(ControlType[I], ';', parts);
    if parts.Count < 4 then
      continue;
    if parts[0] <> FldName then
      continue;
    if parts[1] = 'CheckBox' then
    begin
      checkboxon := parts[2];
      checkboxoff := parts[3];
      result := True;
      break;
    end
  end;

  parts.Free;
end;

Function TwwCustomDBGrid.IsValidCell(ACol, ARow: integer): boolean;
begin
  result := false;
  if DataSource = Nil then
    Exit;
  if DataSource.DataSet = Nil then
    Exit;
  ACol := DbCol(ACol);
  ARow := DbRow(ARow);
  if (ACol < 0) or (ACol >= DataLink.FieldCount) then
    Exit;
  if (ARow < 0) then
    Exit;
  if not(wwDataSet(DataSource.DataSet)) then
    Exit;
  result := True;
end;

function TwwCustomDBGrid.DbCol(col: integer): integer;
begin
  result := col;
  if dgIndicator in Options then
    result := col - 1;
end;

function TwwCustomDBGrid.DbRow(row: integer): integer;
begin
  result := row;
  if dgTitles in Options then
    result := row - 1;
end;

Function TwwCustomDBGrid.IsSelected: boolean;
begin
  result := false;
end;

Function TwwCustomDBGrid.IsSelectedRow(DataRow: integer): boolean;
begin
  result := false;
end;

procedure TwwCustomDBGrid.RefreshBookmarkList;
begin
end;

procedure TwwCustomDBGrid.HideControls;
begin
end;

constructor TwwInplaceEdit.wwCreate(AOwner: TComponent; dummy: integer);
begin
  Create(AOwner);
  FwwPicture := TwwDBPicture.Create(Self);
  FRegexMask := TwwRegexMask.Create(Self);

  ParentGrid := Owner as TwwCustomDBGrid;
  FWordWrap := dgWordWrap in ParentGrid.Options;
{$IFDEF wwDelphi3Up}
  ImeMode := ParentGrid.ImeMode;
  ImeName := ParentGrid.ImeName;
{$ENDIF}
  OrigForeColor := clNone;
  OrigBackColor := clNone;

end;

destructor TwwInplaceEdit.Destroy;
begin
  FwwPicture.Free;
  FRegexMask.Free;
  inherited Destroy;
end;

procedure TwwInplaceEdit.DoRefreshValidationDisplay(input: string = '');

var
  valid: boolean;
begin
  if input = '' then
    input := Text;
  valid := True;
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

procedure TwwInplaceEdit.ResetValidationColors(ForeColor: TColor = clNone;
  BackColor: TColor = clNone);
begin
  if ForeColor = clNone then
  begin
    if OrigForeColor <> clNone then
      Self.Font.Color := OrigForeColor
  end
  else
    Self.Font.Color := ForeColor;

  if ForeColor = clNone then
  begin
    if OrigBackColor <> clNone then
      Self.Color := OrigBackColor
  end
  else
    Self.Color := BackColor;

  OrigBackColor := clNone;
  OrigForeColor := clNone;
end;

procedure TwwInplaceEdit.ApplyValidationColors(valid: boolean);
begin
  if csDesigning in ComponentState then
    Exit;

  if wwInternational.ValidationFeedback.ErrorForeColor <> clNone then
  begin
    if not valid then
    begin
      if (OrigForeColor = clNone) then
      begin
        OrigForeColor := Self.Font.Color;
        Self.Font.Color := wwInternational.ValidationFeedback.ErrorForeColor
      end;
    end
    else if OrigForeColor <> clNone then
    begin
      Self.Font.Color := OrigForeColor;
      OrigForeColor := clNone;
    end;
  end;

  if wwInternational.ValidationFeedback.ErrorBackColor <> clNone then
  begin
    if not valid then
    begin
      if (OrigBackColor = clNone) then
      begin
        OrigBackColor := Self.Color;
        Self.Color := wwInternational.ValidationFeedback.ErrorBackColor
      end;
    end
    else if OrigBackColor <> clNone then
    begin
      Self.Color := OrigBackColor;
      OrigBackColor := clNone;
    end;
  end;

end;

procedure TwwInplaceEdit.DoRefreshValidationDisplay(valid: boolean);
begin
  // DoOnCheckValue(valid);

  ApplyValidationColors(valid); // Change colors here
  if Assigned(ParentGrid.FOnCheckValue) then
    ParentGrid.FOnCheckValue(Self, valid);

end;

procedure TwwInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

type
  TSelection = record
    StartPos, EndPos: integer;
  end;

  procedure SendToParent;
  begin
    ParentGrid.SetFocus;
    ParentGrid.KeyDown(Key, Shift);
    Key := 0;
    Update;
  end;

  procedure SendToParent2;
  begin
    ParentGrid.KeyDown(Key, Shift);
    Key := 0;
  end;

  function Ctrl: boolean;
  begin
    result := ssCtrl in Shift;
  end;

  function ForwardMovement: boolean;
  begin
    result := dgAlwaysShowEditor in ParentGrid.Options;
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
      result := (StartPos = 0) and ((EndPos = 0) or (EndPos = GetTextLen));
  end;

begin
  if UseRightToLeftAlignment then
  begin
    case Key of
      vk_left:
        if ForwardMovement and (Ctrl or LeftSide) then
          SendToParent2;
      vk_right:
        if ForwardMovement and (Ctrl or RightSide) then
          SendToParent2;
    end
  end;

  case Key of
    vk_return:
      if dgEnterToTab in ParentGrid.KeyOptions then
      begin
        SendToParent;
      end;

    vk_delete:
      if (Ctrl) then
        SendToParent;
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TwwInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (dgEnterToTab in ParentGrid.KeyOptions) and (Key = vk_return) then
    Key := 9;
  inherited KeyUp(Key, Shift);
  if (Key = vk_delete) then
  begin
    DoRefreshValidationDisplay;
    // if Assigned(parentGrid.FOnCheckValue) then
    // IsValidPictureValue(Text);
  end
end;

procedure TwwInplaceEdit.KeyPress(var Key: Char);

var
  pict: TwwPictureValidator;
  s: string;
  res: TwwPicResult;
  padlength, OldSelStart, Oldlen, OldSelLen: integer;
  DisplayTextIsInvalid, skipInvalidValueTest: boolean;
  Delphi2: boolean;
  valid: boolean;

  Function NewText(Key: Char): string;

  var
    curStr: string;
  begin
    curStr := Text;
    if (ord(Key) = vk_back) then
    begin
      if (Length(curStr) >= 1) then
        Delete(curStr, selStart, 1);
      result := curStr;
    end
    else
      result := copy(curStr, 1, selStart + 1 - 1) + Char(Key) +
        copy(curStr, selStart + 1 + Length(SelText), 32767);
  end;

begin
  if (dgEnterToTab in ParentGrid.KeyOptions) and (ord(Key) = vk_return) then
    Key := #9;

  inherited KeyPress(Key);
  DisplayTextIsInvalid := false;
  skipInvalidValueTest := false;

  // 1/31/01 - Don't allow Control-Enter
  with ParentGrid do
    if (Key = #10) and (GetColField(DbCol(col)) is TFloatField) then
      Key := #0;

  valid := True;
  if (RegexMask.Mask <> '') then
  begin
    s := NewText(Key);
    if (Maxlength > 0) and (Length(s) > Maxlength) and (Length(s) > Length(Text))
    then
      Exit; { Limit to maxlength }
    valid := RegexMatch(RegexMask.Mask, not RegexMask.CaseSensitive, s);
    // EnableEdit; // Otherwise readonly can still be true
    DisplayTextIsInvalid := not valid;
    if wwGridEssentials then
    begin
      DisplayProfessionalVersionOnlyMessage(Self,
        'Regular expression editing masks are only supported in the professional version.');
    end;

  end;

  if valid and HavePictureMask then
  begin
    s := NewText(Key);
    if (ord(Key) = vk_back) then
    begin
      if s = '' then
        DoRefreshValidationDisplay(True)
      else
        DoRefreshValidationDisplay(s);

      // if Assigned(parentGrid.FOnCheckValue) then IsValidPictureValue(NewText(Key));
      Exit;
    end;
    if (ord(Key) < VK_SPACE) then
      Exit;

    if (Maxlength > 0) and (Length(s) > Maxlength) and (Length(s) > Length(Text))
    then
      Exit; { Limit to maxlength }

    pict := TwwPictureValidator.Create(FwwPicture.PictureMask,
      FwwPicture.AutoFill);
    res := pict.Picture(s, FwwPicture.AutoFill);

    OldSelStart := selStart;
    Oldlen := Length(Text);
    OldSelLen := SelLength;

    if FwwPicture.AutoFill and (parent is TwwDBGrid) and
      (not TwwDBGrid(parent).Patch[3]) then
    begin { Autofill prefix }
      if (res = prError) { and
        ((selStart = selLength) or (SelText=Text)) } then
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
          if (selStart + Length(SelText) >= Length(Text)) then
          begin
            Key := Char(0);
            MessageBeep(0);
            skipInvalidValueTest := True;
            { 2/4/98 - Rely upon previous call }
          end
          else
            DisplayTextIsInvalid := True;
        end;

      prIncomplete:
        begin
          padlength := Length(s) - Length(Text);
          Text := s;
          (Owner as TwwCustomDBGrid).FEditText := Text;
          if (OldSelLen = Oldlen) then
            selStart := Length(s)
          else
            selStart := OldSelStart + padlength;
          Key := Char(0);
          DisplayTextIsInvalid := True;
        end;

      prComplete:
        begin
{$IFNDEF wwDelphi3Up}
          Delphi2 := True;
{$ELSE}
          Delphi2 := false;
{$ENDIF}
          { 11/21/96 - Workaround for Delphi 2 bug in scrolling in unbordered control }
          if Delphi2 then
          begin
            if (Length(s) > 1) then
              Text := copy(s, 1, OldSelStart) + copy(s, OldSelStart + 2,
                Length(s) - 1)
            else
              Text := '';
            selStart := OldSelStart;
            (Owner as TwwCustomDBGrid).FEditText := s;
            if (Length(s) > 0) then
              Key := s[OldSelStart + 1];
          end
          else
          begin
            Text := s;
            (Owner as TwwCustomDBGrid).FEditText := s;
            if (OldSelLen = Oldlen) then
              selStart := Length(s)
            else if (Length(s) > Oldlen) then
              selStart := OldSelStart + (Length(s) - Oldlen)
              { Move caret to the right }
            else
              selStart := OldSelStart + 1; { 11/26/96 }
            SelLength := 0; { 8/12/97 }

            Key := Char(0);
          end
        end;

    end;
    pict.Free;

    {
      if (not SkipInvalidValueTest) and
      Assigned(parentGrid.FOnCheckValue) then
      parentGrid.FOnCheckValue(self, not DisplayTextIsInvalid);
    }
  end;

  if HavePictureMask or (RegexMask.Mask <> '') then
  begin
    if (not skipInvalidValueTest) then
    begin
      DoRefreshValidationDisplay(not DisplayTextIsInvalid);
      // DoOnCheckValue(not DisplayTextIsInvalid);
      // if Assigned(parentGrid.FOnCheckValue) then
      // parentGrid.FOnCheckValue(self, not DisplayTextIsInvalid);
    end
  end;

end;

{ Allow paste to change text - 10/29/96 }
procedure TwwInplaceEdit.WMPaste(var Message: TMessage);
begin
  inherited;
  if not ParentGrid.CanEditModify then
    Exit;
  // ParentGrid.edit;
  // ParentGrid.DataLink.modified;
  DoRefreshValidationDisplay; // 7/22/08
end;

procedure TwwInplaceEdit.WMCut(var Message: TMessage);
begin
  inherited;
  if not ParentGrid.CanEditModify then
    Exit;
  DoRefreshValidationDisplay; // 7/22/08
end;

procedure TwwInplaceEdit.SetWordWrap(val: boolean);
begin
  FWordWrap := val;
  RecreateWnd;
end;

procedure TwwInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not(ES_AUTOVSCROLL or ES_WANTRETURN);
  if (BorderStyle = bsNone) or WordWrap then
    Params.Style := Params.Style or ES_MULTILINE;
  if WordWrap then
    Params.Style := (Params.Style or ES_AUTOVSCROLL) and not ES_AUTOHSCROLL;
end;

function TwwInplaceEdit.IsValidPictureValue(s: string): boolean;

var
  pict: TwwPictureValidator;
  res: TwwPicResult;
begin
  if s = '' then
    result := True
  else if not HavePictureMask then
    result := True
  else
  begin
    pict := TwwPictureValidator.Create(FwwPicture.PictureMask,
      FwwPicture.AutoFill);;
    res := pict.Picture(s, false);
    result := res = prComplete;
    pict.Free;
  end;
  if Assigned(ParentGrid.FOnCheckValue) then
    ParentGrid.FOnCheckValue(Self, result);
end;

procedure TwwInplaceEdit.UpdateContents;
begin
  inherited;
  if TwwCacheColInfoItem(ParentGrid.FCacheColInfo[ParentGrid.col]).ControlType = 'URL-Link'
  then
    WordWrap := false
  else
    WordWrap := dgWordWrap in ParentGrid.Options;
  // RecreateWnd;
end;

procedure TwwInplaceEdit.WMSetFocus(var Message: TWMSetFocus);

var
  tempMask: string;
  tempAutoFill, tempCaseSensitive: boolean;
  tempErrorMessage: string;
begin
  ResetValidationColors;

  inherited;
  if (ParentGrid.DataSource = nil) or (ParentGrid.DataSource.DataSet = nil) then
    Exit;
  with ParentGrid do
  begin
    if GetColField(DbCol(col)) = nil then
      Exit;
    wwPictureByField(ParentGrid.GetPictureControl, GetColField(DbCol(col))
      .FieldName, True, tempMask, tempAutoFill, FUsePictureMask);
    FwwPicture.PictureMask := tempMask;
    FwwPicture.AutoFill := tempAutoFill;
    FwwPicture.AllowInvalidExit := false;
    IsValidPictureValue(GetColField(DbCol(col)).Text);

    // 7/23/08 - Update regular expression
    wwRegexByField(ParentGrid, GetColField(DbCol(col)).FieldName, tempMask,
      tempCaseSensitive, tempErrorMessage);
    FRegexMask.Mask := tempMask;
    FRegexMask.CaseSensitive := tempCaseSensitive;
    FRegexMask.ErrorMessage := tempErrorMessage;
    FRegexMask.AllowInvalidExit := false;

  end
end;

Function TwwInplaceEdit.HavePictureMask: boolean;
begin
  result := FUsePictureMask and (FwwPicture.PictureMask <> '');

  if result then
  begin
    if wwGridEssentials then
    begin
      DisplayProfessionalVersionOnlyMessage(Self,
        'Picture masks are only supported in the professional version.');
    end;
  end;

end;

procedure TwwInplaceEdit.CMFontChanged(var Message: TMessage);

var
  Loc: TRect;
begin
  inherited;
  Loc.Bottom := ClientHeight;
  Loc.Right := ClientWidth - 1;
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

Procedure TwwCustomDBGrid.SelectRecord;
begin
end;

Procedure TwwCustomDBGrid.UnselectRecord;
begin
end;

Procedure TwwCustomDBGrid.SetTitleButtons(val: boolean);
begin
  if (FTitleButtons <> val) then
  begin
    FTitleButtons := val;
    Invalidate;
  end
end;

Function TwwCustomDBGrid.GetPictureControl: TComponent;
begin
  result := wwGetPictureControl(Self);
  // if (Datasource=nil) then
  // result:= wwGetPictureControl(self, nil)
  // else
  // result:= wwGetPictureControl(self, DataSource.DataSet)
end;

Procedure TwwCustomDBGrid.SetRegex(FieldName: string; Mask: string;
  CaseSensitive: boolean; ErrorMsg: string);
begin
  wwSetRegexMasks(Self, FieldName, Mask, CaseSensitive, ErrorMsg);
end;

Procedure TwwCustomDBGrid.SetPictureMask(FieldName: string; Mask: string);
begin
  if DataSource = nil then
    Exit;
  wwSetPictureMask(GetPictureControl, FieldName, Mask, True, True, True,
    false, false);
end;

Procedure TwwCustomDBGrid.SetPictureAutoFill(FieldName: string;
  AutoFill: boolean);
begin
  if DataSource = nil then
    Exit;
  wwSetPictureMask(GetPictureControl, FieldName, '', AutoFill, True, false,
    True, false);
end;

Procedure TwwCustomDBGrid.UnselectAll;
begin
end;

function TwwCustomDBGrid.GetSelectedFields: TStrings;
begin
  result := FSelected;
end;

procedure TwwCustomDBGrid.SetPictureMasks(val: TStrings);
begin
  FPictureMasks.assign(val);
end;

procedure TwwCustomDBGrid.SetRegexMasks(val: TStrings);
begin
  FRegexMasks.assign(val);
end;

procedure TwwCustomDBGrid.SetControlType(val: TStrings);
begin
  ControlType.assign(val);
end;

procedure TwwCustomDBGrid.SetSelectedFields(sel: TStrings);
begin
  FSelected.assign(sel);
end;

Function TwwCustomDBGrid.IsSelectedCheckbox(ACol: integer): boolean;

var
  tempField: TField;
begin
  if IsCheckBox(ACol, 1, dummy1, dummy2) then
  begin
    tempField := GetColField(DbCol(ACol));
    if tempField = nil then
      result := false // 10/16/04 - make sure is calculated
    else
      result := (lowercase(tempField.FieldName) = 'selected') and
        tempField.Calculated;
  end
  else
    result := false;
end;

Procedure TwwCustomDBGrid.SizeLastColumn;

var
  I, FieldsSize: integer;
begin
  if csLoading in ComponentState then
    Exit;
  if not HandleAllocated then
    Exit;

  Inc(FUpdatingColWidths);
  try
    SetColumnAttributes;
  finally
    Dec(FUpdatingColWidths);
  end;

  if ShowVertScrollBar then
    FieldsSize := GetSystemMetrics(SM_CXHThumb) + 5
  else
    FieldsSize := 0;

  if dgIndicator in Options then
    FieldsSize := FieldsSize + ColWidths[0] + GridLineWidth;

  for I := LeftCol to ColCount - 2 do
    FieldsSize := FieldsSize + ColWidths[I] + GridLineWidth;
  if FieldsSize > Width then
    Exit; { Last column is not visble }

  FieldsSize := FieldsSize + ColWidths[ColCount - 1] + GridLineWidth;

  Inc(FUpdatingColWidths);
  try
    if Width - FieldsSize > 0 then
      ColWidths[ColCount - 1] := ColWidths[ColCount - 1] + (Width - FieldsSize);
  finally
    Dec(FUpdatingColWidths);
  end
end;

function TwwCustomDBGrid.GetColWidthsPixels(Index: Longint): integer;
begin
  result := inherited ColWidths[Index];
end;

procedure TwwCustomDBGrid.SetColWidthsPixels(Index: Longint; value: integer);
begin
  Inc(FUpdatingColWidths);
  try
    ColWidths[Index] := value;
  finally
    Dec(FUpdatingColWidths);
  end
end;

procedure TwwCustomDBGrid.FlushChanges;
begin
  DataLink.UpdateData;
end;

procedure TwwIButton.Loaded;
begin
  inherited Loaded;
  if parent is TwwCustomDBGrid then
  begin
    (parent as TwwCustomDBGrid).FIndicatorButton := Self;
    (parent as TwwCustomDBGrid).FIndicatorWidth := Width - 1;
  end;
end;

procedure TwwIButton.Paint;
begin
  inherited Paint;
  { if parent is TwwDBGrid then
    with (parent as TwwDBGrid) do begin
    InvalidateCell(0,1);
    Update;
    end }
end;

procedure TwwIButton.SetBounds(ALeft, ATop, AWidth, AHeight: integer);

var
  SizeChanging: boolean;
begin
  if ALeft > 0 then
    ALeft := 0;
  if ATop > 0 then
    ATop := 0;

  SizeChanging := (AWidth <> Width) or (AHeight <> Height);
{$IFDEF wwdelphi4up}
  if (parent is TwwCustomDBGrid) and parent.UseRightToLeftAlignment then
    with (parent as TwwCustomDBGrid) do
      inherited SetBounds(ClientWidth - AWidth + 1, ATop, AWidth, AHeight)
  else
{$ENDIF}
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (parent = nil) then
    Exit;

  if SizeChanging and (not(csLoading in ComponentState)) then
  begin
    with (parent as TwwCustomDBGrid) do
    begin
      FIndicatorWidth := Self.Width - 1;
      LayoutChanged;
    end
  end;

end;

procedure TwwCustomDBGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  if FIndicatorButton <> Nil then
  begin
    Proc(FIndicatorButton);
  end;
end;

procedure TwwColumn.SetDisplayLabel(val: string);
begin
  if Self = Grid.DummyColumn then
    Exit;
  try
    Inc(Grid.FUpdateLock);
    UpdateSelectedProp(Grid.Selected, FFieldName, val, sptUpdateLabel);
    if Grid.UseTFields then
      Grid.DataSource.DataSet.fieldByName(FFieldName).DisplayLabel := val;
    Grid.SetColumnAttributes;
    Grid.Invalidate;
    FDisplayLabel := val;
  finally
    Dec(Grid.FUpdateLock);
  end
end;

procedure TwwColumn.SetGroupName(val: string);
begin
  if Self = Grid.DummyColumn then
    Exit;
  try
    Inc(Grid.FUpdateLock);
    UpdateSelectedProp(Grid.Selected, FFieldName, val, sptUpdateGroup);
    Grid.Invalidate;
  finally
    Dec(Grid.FUpdateLock);
  end
end;

procedure TwwColumn.SetFooterValue(val: string);
begin
  if Self = Grid.DummyColumn then
    Exit;
  if FFooterValue <> val then
  begin
    FFooterValue := val;
    Grid.InvalidateFooter;
  end;
end;

function TwwColumn.GetIndex: integer;

var
  Index: integer;
begin
  if not wwFindSelected(Grid.Selected, FFieldName, index) then
    result := -1
  else
    result := index;
end;

function TwwColumn.GetVisible: boolean;
begin
  // remove from selected, but save TwwColumn for later
  result := FVisible;
end;

procedure TwwColumn.InsertBeforeColumn(FieldName: string);
begin
  Grid.AddField(FieldName, index);
end;

procedure TwwColumn.InsertAfterColumn(FieldName: string);
begin
  Grid.AddField(FieldName, index + 1);
end;

procedure TwwColumn.MakeVisible(val: boolean);
var
  valstr: string;
begin
  // bring back to selected
  if Self = Grid.DummyColumn then
    Exit;
  try
    Inc(Grid.FUpdateLock);
    FVisible := val;
    if val then
    begin // move from savecolitems to colitems
      Grid.ColItems.Add(Self);
      Grid.SavedColItems.Remove(Self)
    end
    else
    begin // move from colitems to savecolitems
      Grid.SavedColItems.Add(Self);
      Self.FDisplayWidth := Self.DisplayWidth;
      // Force TwwColumn DisplayWidth, DisplayLabgel properties to be accurate
      Self.FDisplayLabel := Self.DisplayLabel;
      Grid.ColItems.Remove(Self);
    end;
    if val then
      valstr := 'T'
    else
      valstr := 'F';
    UpdateSelectedPropWithGrid(Grid, Grid.Selected, FFieldName, valstr,
      sptUpdateVisible);

  finally
    Dec(Grid.FUpdateLock);
  end;

end;

procedure TwwColumn.SetVisible(val: boolean);
begin
  MakeVisible(val);
  Grid.ApplySelected;
end;

procedure TwwColumn.SetIndex(val: integer);
// var
// s: string;
begin
  if Self = Grid.DummyColumn then
    Exit;
  try
    Inc(Grid.FUpdateLock);
    UpdateSelectedProp(Grid.Selected, FFieldName, inttostr(val),
      sptUpdateIndex);
    if Grid.UseTFields then
      Grid.DataSource.DataSet.fieldByName(FFieldName).Index := val;

    Inc(Grid.FUpdatingColWidths);
    try
      Grid.SetColumnAttributes;
    finally
      Dec(Grid.FUpdatingColWidths);
    end;

    // Grid.SetColumnAttributes;
  finally
    Dec(Grid.FUpdateLock);
  end;

end;

procedure TwwColumn.SetSearchValue(val: string);
begin
  if Self = Grid.DummyColumn then
    Exit;
  if FSearchValue <> val then
  begin
    FSearchValue := val;
  end;
end;

procedure TwwColumn.SetDisplayWidth(val: integer);

var
  s: string;
begin
  if Self = Grid.DummyColumn then
    Exit;
  s := inttostr(val);
  try
    Inc(Grid.FUpdateLock);
    UpdateSelectedProp(Grid.Selected, FFieldName, s, sptUpdateWidth);
    if Grid.UseTFields then
      Grid.DataSource.DataSet.fieldByName(FFieldName).DisplayWidth := val;
    Grid.SetColumnAttributes;
    FDisplayWidth := val;
  finally
    Dec(Grid.FUpdateLock);
  end;

end;

procedure TwwColumn.SetReadOnly(val: boolean);

var
  s: string;
begin
  if Self = Grid.DummyColumn then
    Exit;
  if val then
    s := 'T'
  else
    s := 'F';
  UpdateSelectedProp(Grid.Selected, FFieldName, s, sptUpdateReadOnly);
end;

function TwwColumn.GetReadOnly: boolean;
begin
  if Self = Grid.DummyColumn then
    result := false
  else
    result := (GetSelectedProp(Grid.Selected, FFieldName,
      sptUpdateReadOnly) = 'T')
end;

function TwwColumn.GetGroupName: string;
begin
  if Self = Grid.DummyColumn then
    result := ''
  else
    result := GetSelectedProp(Grid.Selected, FFieldName, sptUpdateGroup);
  if result <> '' then
  begin
    if wwGridEssentials then
      DisplayProfessionalVersionOnlyMessage(Grid,
        'Hierarchical titles are only supported in InfoPower Professional');
  end;
end;

function TwwColumn.GetDisplayLabel: string;
var
  Index: integer;
begin
  if Self = Grid.DummyColumn then
    result := ''
  else
  begin
    // 8/24/2001 - If UseTFields is True, then have column return the fields displaylabel. {PYW}
    if (Grid.UseTFields) and (Grid.FDataLink <> Nil) and
      (Grid.FDataLink.DataSet <> Nil) and
      (Grid.FDataLink.DataSet.fieldByName(FFieldName) <> nil) then
      result := Grid.FDataLink.DataSet.fieldByName(FFieldName).DisplayLabel
    else
    begin
      if not wwFindSelected(Grid.Selected, FFieldName, index) then
      begin
        result := FDisplayLabel;
        if result = '' then
          result := Grid.FDataLink.DataSet.fieldByName(FFieldName).DisplayLabel;
      end
      else
        result := GetSelectedProp(Grid.Selected, FFieldName, sptUpdateLabel);
    end;
  end;
end;

function TwwColumn.GetDisplayWidth: integer;
var
  Index: integer;
begin
  if Self = Grid.DummyColumn then
    result := 0
  else
  begin
    // 9/24/2001 - If UseTFields is True, then have column return the fields displaywidth. {PYW}
    if (Grid.UseTFields) and (Grid.FDataLink <> Nil) and
      (Grid.FDataLink.DataSet <> Nil) and
      (Grid.FDataLink.DataSet.fieldByName(FFieldName) <> nil) then
      result := Grid.FDataLink.DataSet.fieldByName(FFieldName).DisplayWidth
    else
    begin
      if not wwFindSelected(Grid.Selected, FFieldName, index) then
      begin
        result := FDisplayWidth;
        if result = 0 then
          result := Grid.FDataLink.DataSet.fieldByName(FFieldName).DisplayWidth;
      end
      else
        result := strtoint(GetSelectedProp(Grid.Selected, FFieldName,
          sptUpdateWidth));
    end;
  end;
end;

function TwwCustomDBGrid.GetColumn(Index: integer): TwwColumn;

var
  APos: integer;
  FieldName: string;
begin
  if FieldCount = 0 then
  begin
    if Index >= Selected.Count then
      result := DummyColumn
    else
    begin
      APos := 1;
      FieldName := strGetToken(Selected[index], #9, APos);
      result := ColumnByName(FieldName);
    end
  end
  else
  begin
    if Index >= FieldCount then
      result := DummyColumn
    else
      result := ColumnByName(Fields[index].FieldName)
  end
end;

function TwwCustomDBGrid.GetFastColumn(Index: integer): TwwColumn;
begin
  if FieldCount = 0 then
  begin
    if Index >= Selected.Count then
      result := DummyColumn
    else
    begin
      if Index < ColItems.Count then
        result := TwwColumn(ColItems[index])
      else
        result := DummyColumn
    end
  end
  else
  begin
    if Index >= FieldCount then
      result := DummyColumn
    else if Index < ColItems.Count then
      result := TwwColumn(ColItems[index])
    else
      result := DummyColumn
  end
end;

function TwwCustomDBGrid.ColumnByName(Index: string): TwwColumn;

var
  I: integer;
  // curField: TField;
begin
  result := DummyColumn;
  for I := 0 to ColItems.Count - 1 do
  begin
    if wwEqualStr(TwwColumn(ColItems[I]).FFieldName, Index) then
    begin
      result := TwwColumn(ColItems[I]);
      Exit;
    end
  end;
  if result = DummyColumn then
  begin
    for I := 0 to SavedColItems.Count - 1 do
    begin
      if wwEqualStr(TwwColumn(SavedColItems[I]).FFieldName, Index) then
      begin
        result := TwwColumn(SavedColItems[I]);
        Exit;
      end
    end;
  end;

  // Dummy column so let us
  {
    curField:= DataSource.DataSet.FindField(index);
    if curfield=nil then exit;
    result := TwwColumn.Create(self, Index);
    result.FDisplayLabel:= curfield.DisplayLabel;
    result.FDisplayWidth:= curfield.DisplayWidth;
    result.FVisible:=false;
    SavedColItems.Add(result);
  }
end;

destructor TwwColumn.Destroy;
begin
  if ColumnFlags <> nil then
    FreeMem(ColumnFlags);
  ColumnFlags := nil;
  inherited;
end;

constructor TwwColumn.Create(AOwner: TComponent; AFieldName: string);
begin
  Grid := AOwner as TwwCustomDBGrid;
  FFieldName := AFieldName;
  FGroupName := '';
  ColumnFlags := nil;
  FVisible := True;
end;

procedure TwwCustomDBGrid.TopLeftChanged;

var
  FooterRect: TRect;
{$IFDEF wwdelphi4up}
  PatchRect: TRect;
  DrawInfo: TGridDrawInfo;
{$ENDIF}
  R: TRect;
begin
  FreeHintWindow;
  CollapseChildGrid;

  inherited TopLeftChanged;
  if Assigned(FOnLeftColChanged) then
    FOnLeftColChanged(Self, LeftCol);

  // Invalidate TitleRect to handle horizontal scroll painting issues.
  R := Rect(0, 0, Width, RowHeights[0]);
  InvalidateRect(Handle, @R, false);

  if dgShowFooter in Options then
  begin
    FooterRect := GetFooterRect;
    FooterRect.Bottom := FooterRect.Bottom + 1;
    Windows.InvalidateRect(Handle, @FooterRect, false);
  end;

  { 8/5/98 - Delphi 4 patch for bug in TCustomGrid }
{$IFDEF wwdelphi4up}
  CalcDrawInfo(DrawInfo);
  PatchRect := Rect(DrawInfo.Horz.GridExtent - 1, 0,
    DrawInfo.Horz.GridExtent, Height);
  Windows.InvalidateRect(Handle, @PatchRect, false);
{$ENDIF}
end;

function TwwCustomDBGrid.GetClientRect: TRect;

var
  OldFontSize: integer;
begin
  result := inherited GetClientRect;
  if dgShowFooter in Options then
  begin
    if FooterHeight = 0 then
    begin
      OldFontSize := Canvas.Font.Size;
      // 8/25/03 - Don't rely upon unknown font height
      Canvas.Font.Size := Font.Size;
      result.Bottom := result.Bottom - (Canvas.TextHeight('W') + NormalPad + 4);
      Canvas.Font.Size := OldFontSize;
    end
    else
      result.Bottom := result.Bottom - FooterHeight;
    if dgFooter3DCells in Options then
      result.Bottom := result.Bottom - 2;
  end
end;

Function TwwCustomDBGrid.GetFooterRect: TRect;

var
  FooterRect: TRect;
  DrawInfo: TGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  FooterRect.Top := DrawInfo.Vert.FullVisBoundary + 1;
  FooterRect.Bottom := ClientHeight;
  FooterRect.Left := 0;
  FooterRect.Right := DrawInfo.Horz.FullVisBoundary + 1;
{$IFDEF wwdelphi4up}
  (* if UseRightToLeftAlignment then
    begin
    FooterRect.Left:= FooterRect.Right;
    FooterRect.right:= 0;
    end
    else *)
{$ENDIF}
  FooterRect.Right := ClientWidth;
  if dgShowFooter in Options then
    FooterRect.Top := ClientRect.Bottom
  else
    FooterRect.Top := FooterRect.Bottom + 3; // 1/19/01;

  if FooterHeight = 0 then
    FooterRect.Bottom := FooterRect.Top + Canvas.TextHeight('W') + NormalPad + 4
    // DefaultRowHeight+3
  else
    FooterRect.Bottom := FooterRect.Top + FooterHeight - 1;
  if dgFooter3DCells in Options then
    FooterRect.Bottom := FooterRect.Bottom + 2;
  result := FooterRect;
end;

function TwwCustomDBGrid.GetEffectiveFooterHeight: integer;

var
  b: integer;
begin
  if dgShowFooter in Options then
  begin
    if FooterHeight = 0 then
    begin
      b := Canvas.TextHeight('W') + NormalPad + 4;
    end
    else
      b := FooterHeight - 1;
    if dgFooter3DCells in Options then
      b := b + 2;
    result := b + 2;
  end
  else
    result := 0;
end;

procedure TwwCustomDBGrid.InitCacheColInfo;

var
  APos, I: integer;
  TempControlType, TempControlData: string;
  customEdit: TWinControl;
  TempControlInfo: TwwCacheColInfoItem;
  tempCol: integer;
begin
  FCacheColInfo.Clear;

  for I := 0 to ColCount - 1 do
  begin
    TempControlInfo := TwwCacheColInfoItem.Create;
    with TempControlInfo do
    begin
      CustomControl := nil;
      ControlType := '';
      ControlData := '';
      AlwaysPaints := false;
      IsWhiteBackground := True;
      // PaintedBrushColor:= clWindow;
    end;
    FCacheColInfo.Add(TempControlInfo);

    tempCol := DbCol(I);

    if (tempCol < 0) then
      continue;
    if tempCol >= FieldCount then
      continue;
    if Fields[tempCol] = nil then
      continue;

    GetControlInfo(Fields[tempCol].FieldName, TempControlType, TempControlData);

    with TempControlInfo do
    begin
      ControlType := TempControlType;
      ControlData := TempControlData;
    end;

    if IsWWEditControl(TempControlType) then
    begin
      with TempControlInfo do
      begin
        // ControlType:= TempControlType;
        // ControlData:= TempControlData;
        APos := 1;
        strGetToken(ControlData, ';', APos);
        AlwaysPaints := (strGetToken(ControlData, ';', APos) = 'T');
        if IsCustomEditCell(I, 1, customEdit) and (customEdit <> FDateTimePicker)
        then
          CustomControl := customEdit
        else
        begin
          AlwaysPaints := false;
          if (ControlType <> 'RichEdit') then // 9/16/09 - Save ControlType
            ControlType := '';
        end;
      end;
    end
  end
end;

Procedure TwwCustomDBGrid.Paint;

const
  AlignFlags: array [TAlignment] of integer = (DT_LEFT or DT_WORDBREAK or
    DT_EXPANDTABS or DT_NOPREFIX, DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or
    DT_NOPREFIX, DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);

var
  FooterRect: TRect;
  TempRect, FooterCellRect, LastFooterCellRect: TRect;
  ACol: integer;
  ACanvas: TCanvas;
  // UpdateRect: TRect;
  DrawInfo: TGridDrawInfo;
  IsCustomStyle: boolean;
  // LColor: TColor;
  LDetails: TThemedElementDetails;
  SaveIndex: integer;

  Function GetFooterCellRect(col: integer): TRect;
  var
    FooterCellRect: TRect;
  begin
    // FooterCellRect:= CellRect(ACol, RowCount-1);
    FooterCellRect := CellRect(ACol, 0);
    if FooterCellRect.Left <> FooterCellRect.Right then
    begin
      FooterCellRect.Top := FooterRect.Top;
      FooterCellRect.Bottom := FooterRect.Bottom;
    end;
    // InflateRect(FooterCellRect, -2, -2);
    result := FooterCellRect;
  end;

  procedure DrawFooterLines(Rect: TRect; col, row: integer);
  begin
    with ACanvas do
    begin
      // Pen.color:= clBtnShadow;
      Pen.Color := LineColors.ShadowColor;
      MoveTo(Rect.Left + 1, Rect.Bottom - 2);
      LineTo(Rect.Left + 1, Rect.Top + 1);
      LineTo(Rect.Right - 1, Rect.Top + 1);

      if dgFooter3DCells in Options then
      // (ColorToRGB(Brush.Color)=clWhite) then
      begin
        Pen.Color := clBlack;
        MoveTo(Rect.Left + 2, Rect.Bottom - 2);
        LineTo(Rect.Left + 2, Rect.Top + 2);
        LineTo(Rect.Right - 1, Rect.Top + 2);

        // Pen.color:= clBtnHighlight;
        Pen.Color := LineColors.HighlightColor;
        MoveTo(Rect.Left + 2, Rect.Bottom - 2);
        LineTo(Rect.Right - 1, Rect.Bottom - 2);
        LineTo(Rect.Right - 1, Rect.Top + 1);

        Pen.Color := clBtnFace;
        MoveTo(Rect.Left + 3, Rect.Bottom - 3);
        LineTo(Rect.Right - 2, Rect.Bottom - 3);
        LineTo(Rect.Right - 2, Rect.Top + 1);
      end
      else
      begin
        // Pen.color:= clBtnHighlight;
        Pen.Color := LineColors.HighlightColor;
        MoveTo(Rect.Left + 2, Rect.Bottom - 2);
        LineTo(Rect.Right - 1, Rect.Bottom - 2);
        LineTo(Rect.Right - 1, Rect.Top + 1);
      end
    end
  end;

  procedure ProcessFooterCell(ACol: integer);

  var
    FooterText: string;
    Flags: integer;
    DefaultDrawing: boolean;
    Temp: integer;
    LColor: TColor;
    LDetails: TThemedElementDetails;
    WriteOptions: TwwWriteTextOptions;
  begin
    // FooterCellRect:= CellRect(ACol, RowCount-1);
    FooterCellRect := CellRect(ACol, 0);
    // RowCount-1 may return 0,0,0,0

    // 4/21/05 - Don't paint if footer is not visible
    if (inherited FixedCols > 0) then
    begin
      if ((ACol > 0) and (FooterCellRect.Left < CellRect(0, 0).Right)) then
        Exit;
    end;

    if FooterCellRect.Left <> FooterCellRect.Right then
    begin
      FooterText := Columns[DbCol(ACol)].FooterValue;
      DefaultDrawing := True;
      ACanvas.Brush.Color := FFooterCellColor;
      ACanvas.Font.assign(Font);
      ACanvas.Refresh;
      // ACanvas.Font.Color:= ColorToRGB(Font.Color); // Refresh font color to canvas handle

      FooterCellRect := GetFooterCellRect(ACol);
      InflateRect(FooterCellRect, 0, -2);

      If Assigned(FOnDrawFooterCell) then
      begin
        FOnDrawFooterCell(Self, ACanvas, FooterCellRect, Fields[DbCol(ACol)],
          FooterText, DefaultDrawing);
      end;

      if not DefaultDrawing then
        Exit;
      if FooterText = '' then
        Exit;

      if wwIsCustomStyle(Self) then
      begin
        LDetails := StyleServices.GetElementDetails(tgCellNormal);
        if StyleServices.GetElementColor(LDetails, ecFillColor, LColor) and
          (LColor <> clNone) then
          ACanvas.Brush.Color := LColor;
      end;

      { Fill with brush color for cell }
      FillWithFixedBitmap(FooterCellRect, -1);

      FooterCellRect.Top := FooterRect.Top + 1;
      FooterCellRect.Bottom := FooterRect.Bottom - 1;
      FooterCellRect.Left := FooterCellRect.Left - 1;
      { 9/12/2000 - Adjust last cell's footer rect to be wider. }
      if (ACol = ColCount - 1) and (PadColumnStyle <> pcsPlain) then
        if FooterCellRect.Right + 1 <= ClientWidth - 1 then
          FooterCellRect.Right := FooterCellRect.Right + 1;
      DrawFooterLines(FooterCellRect, ACol, RowCount);

      Flags := AlignFlags[Fields[DbCol(ACol)].Alignment];
      FooterCellRect.Top := FooterCellRect.Top +
        (FooterCellRect.Bottom - FooterCellRect.Top -
        ACanvas.TextHeight('A')) div 2;
      FooterCellRect.Left := FooterCellRect.Left + 5;
      { 9/12/2000 - Adjusted Right part of text rect from -9 to -7 }
      FooterCellRect.Right := FooterCellRect.Left + ColWidths[ACol] - 7;

      // ACanvas.Font.Color:= clBlack;
      // SetTextColor(ACanvas.Handle, ACanvas.Font.Color);
      SetBkMode(ACanvas.Handle, TRANSPARENT);
      if UseRightToLeftAlignment then
      // 4/15/03 - Fix bidi mode alignment problem
      begin
        if (DbCol(ACol) < FieldCount) and
          (Fields[DbCol(ACol)].Alignment = taRightJustify) then
        begin
          Temp := FooterCellRect.Left;
          Flags := AlignFlags[taLeftJustify] { or DT_RTLREADING };
          FooterCellRect.Left := FooterCellRect.Right;
          FooterCellRect.Right := Temp;
        end
        else
        begin
          FooterCellRect.Left := GetFooterCellRect(ACol).Left;
          FooterCellRect.Right := GetFooterCellRect(ACol).Right;
          Temp := FooterCellRect.Left;
          FooterCellRect.Left := wwmin(FooterCellRect.Right,
            FooterCellRect.Left + ACanvas.TextWidth(FooterText) + 2);
          FooterCellRect.Right := Temp;
        end;

      end;

      if wwIsCustomStyle(Self) then
      begin
        WriteOptions := [wtoTransparent];
        wwWriteTextLines(ACanvas, FooterCellRect, 0, 0, PChar(FooterText),
          Fields[DbCol(ACol)].Alignment, WriteOptions);
      end
      else
      begin
        DrawText(ACanvas.Handle, PChar(FooterText), Length(FooterText),
          FooterCellRect, Flags);
      end
    end
  end;

  procedure DrawPadColumn;

  var
    R, TempRect: TRect;
  begin
    if wwIsCustomStyle(Self) then
      Exit;

    if DrawInfo.Horz.LastFullVisibleCell <> ColCount - 1 then
      Exit;
    R := CellRect(ColCount - 1, 0);
    R.Left := R.Right + 1;
    R.Right := ClientWidth;
    if (PadColumnStyle = pcsPadHeaderAndData) or
      (PaintOptions.HaveBackgroundForDataCells) then
    begin
      R.Bottom := ClientHeight;
    end
    else if (PadColumnStyle = pcsPadHeader) then
    begin
      if HaveAnyRowLines then
        R.Bottom := R.Bottom + 1;
      if not(dgTitles in Options) then
        Exit;
    end
    else
      Exit;

    if not(dgColLines in Options) then
      R.Left := R.Left - 1;

    if PadColumnStyle = pcsPadHeaderAndData then
    begin
      if HideAllLines then
        FillWithFixedBitmap(Rect(R.Left - 1, R.Top, R.Right, R.Bottom), -1,
          TitleColor)
      else
        FillWithFixedBitmap(R, -1, TitleColor)
    end
    else if PadColumnStyle = pcsPadHeader then
    begin
      if HideAllLines then
        FillWithFixedBitmap(Rect(R.Left - 1, R.Top, R.Right,
          CellRect(ColCount - 1, 0).Bottom), -1, TitleColor)
      else
        FillWithFixedBitmap(Rect(R.Left, R.Top, R.Right, CellRect(ColCount - 1,
          0).Bottom + 1), -1, TitleColor);
      FillWithBlendBitmap(Rect(R.Left, CellRect(ColCount - 1, 0).Bottom + 1,
        R.Right, R.Bottom), -1, Color);
    end
    else
    begin
      Windows.GetClientRect(Handle, TempRect);
      FillWithBlendBitmap(Rect(R.Left, R.Top, R.Right, TempRect.Bottom),
        -1, Color);
    end;
    Canvas.Pen.Color := LineColors.HighlightColor;
    // looks more 3D with this line
    if PadColumnStyle = pcsPadHeaderAndData then
    begin
      if (not HideAllLines) then
        Canvas.PolyLine([Point(R.Left, R.Top), Point(R.Left, R.Bottom)])
    end
    else if (dgColLines in Options) then
    begin
      if (not HideAllLines) then
        Canvas.PolyLine([Point(R.Left, R.Top),
          Point(R.Left, DrawInfo.Vert.GridBoundary + 1)]);
    end
  end;

  procedure EndPainting;

  var
    sourceRect: TRect;
    PaintClipRect: TRect;
    TempRect: TRect;
    customEdit: TWinControl;
    R: TRect;
    // tempCanvas: TCanvas;
  begin
    if (inherited Canvas = Canvas) then
      Exit;

    // (inherited Canvas).CopyMode:= cmSrcCopy;
    // Sourcerect:= ClientRect;
    // inherited Canvas.CopyRect(SourceRect, FPaintCanvas, SourceRect);
    // exit;

    PaintClipRect := (inherited Canvas).ClipRect;
    if PaintClipRect.Right > ClientRect.Right then
    begin
      PaintClipRect.Right := ClientRect.Right;
    end;
    if UpdateRect.Bottom > inherited GetClientRect.Bottom then
    begin
      UpdateRect.Bottom := inherited ClientRect.Bottom;
    end;

    if (UpdateRect.Top = 0) and (UpdateRect.Bottom = 0) and
      (UpdateRect.Left = 0) and (UpdateRect.Right = 0) then
      UpdateRect := PaintClipRect;
    sourceRect := UpdateRect;
    // SourceRect:= Rect(0,UpdateRect.Top,
    // PaintClipRect.Right, UpdateRect.Bottom );

    { Remove painting of currently edited cell }
    if not(csDesigning in ComponentState) and (FFocused) then
    begin
      TempRect := CellRect(col, row);
      TempRect.Left := TempRect.Left + 1;
      { Used to be +2, but richedit gray line would show after resizing }

      { 7/19/00 - RSW - Don't remove inplaceeditor painting if it has the focus }
      if FFocused and IsCustomEditCell(col, row, customEdit) and
        (not IsDropDownGridFocused) and (ShouldShowCustomControls
        { or (customEdit is TwwExpandButton) } ) then
        FPaintCanvas.CopyRect(TempRect, inherited Canvas, TempRect);
      {
        if IsDropDownGridShowing then // Leave current screen intact in pop-up grid area
        begin
        with TwwExpandButton(CustomEdit) do
        begin
        r:= Rect(Grid.Left, Grid.Top, Grid.Left + Grid.Width, Grid.Top+Grid.Height);
        FPaintCanvas.CopyRect(r, inherited Canvas, r);
        end
        end;
      }
    end;

    // Leave current screen intact in pop-up grid area
    if not(csDesigning in ComponentState) and IsDropDownGridShowing then
    begin
      with TwwExpandButton(CurrentCustomEdit) do
      begin
        R := Rect(Grid.Left, Grid.Top, Grid.Left + Grid.Width,
          Grid.Top + Grid.Height);
        FPaintCanvas.CopyRect(R, inherited Canvas, R);
      end
    end;

    inherited Canvas.CopyRect(sourceRect, FPaintCanvas, sourceRect);
  end;

begin
  // GetUpdateRect(Handle, UpdateRect, False);
  // InitCacheColInfo;

  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);

  if not UseAlternateBuffering then
  begin
    if dgShowFooter in Options then
    begin
      FPaintBitmap.Width := Width;
      FPaintBitmap.Height := Height;
    end
    else
    begin
      FPaintBitmap.Width := ClientWidth;
      FPaintBitmap.Height := ClientHeight;
    end;
  end;

  // 2/13/2002 - Don't call InitBlendBitmaps if no background bitmap loaded.
  if PaintOptions.InitBlendBitmapsFlag and
    (PaintOptions.BackgroundBitmap.Width <> 0) then
    PaintOptions.InitBlendBitmaps;
  if (IsCustomStyle) or (not PaintOptions.HaveBackgroundForDataCells) then
  begin
    if not IsCustomStyle then
    begin // 9/16/11
      Canvas.Brush.Color := Color;
      Canvas.FillRect(UpdateRect)
    end
    else
    begin
      wwPaintGridCellBackgroundColor(Self, Canvas, UpdateRect);;
      // Bug in pop-up dialog as its white in pad column area!
    end
  end
  else
  begin
    FillWithBlendBitmap(UpdateRect, -1);
    // 5/16/01 - Clear old data area
  end;

  if (DataLink = nil) or not(DataLink.Active) then
  begin
    TempRect := inherited ClientRect;
    FillWithFixedBitmap(TempRect, -1, TitleColor);

    TempRect := CellRect(LeftCol, FTitleOffset);
    TempRect.Right := ClientWidth;
    TempRect.Bottom := ClientHeight;
    FillWithBlendBitmap(TempRect, -1, Color);
  end;

  if Assigned(FOnBeforePaint) then
  begin
    FOnBeforePaint(Self);
  end;

  InheritedPaint;
  FCalcCellRow := DbRow(row);
  // Set to row in case CalcCellColors called by different control
  FCalcCellCol := DbRow(col);
  ACanvas := Canvas;
  CalcDrawInfo(DrawInfo);
  if UseRightToLeftAlignment then
    ChangeOrientation(True);
  DrawPadColumn;
  DrawLines;

  // Draw focus rect for inplaceeditor
  if not(csDesigning in ComponentState) and (GetParentForm(Self) <> nil) and
    (GetParentForm(Self).activecontrol = Self) and (not IsCustomStyle) then
  begin
    if (DataLink <> nil) and DataLink.Active and
    // CustomEdit is showing
      ((CurrentCustomEdit = nil) or (not CurrentCustomEdit.Visible)) and
      Focused and not(dgAlwaysShowEditor in Options) and
      not(dgRowSelect in Options) then
    begin
      if (col >= LeftCol) and (col <= DrawInfo.Horz.LastFullVisibleCell) then
        wwDrawFocusRect(Canvas, CellRect(col, row))

        // Draw focus rect for fixed column
        // else if (dgRowLinesDisableFixed in Options) and
      else if (dgFixedEditable in Options) and (col < LeftCol) and
        (col >= FIndicatorOffset) then
        wwDrawFocusRect(Canvas, CellRect(col, row))
    end
  end;

  for ACol := LeftCol to ColCount - 1 do
  begin
    FooterCellRect := CellRect(ACol, RowCount - 1);
    if FooterCellRect.Left = FooterCellRect.Right then
      break;
    LastFooterCellRect := FooterCellRect;
  end;

  if not(dgShowFooter in Options) then
  begin
    if UseRightToLeftAlignment then
      ChangeOrientation(false);
    EndPainting;
    Exit;
  end;

  { Fill with Footer color, up to right-most visible cell }
  FooterRect := GetFooterRect;

  { 9/12/2000 - Changed FooterRect to be the Entire ClientWidth when padding columns }
  if (PadColumnStyle = pcsPlain) then
    FooterRect.Right := LastFooterCellRect.Right // +1
  else
  begin
    // Don't change left as it then paints left footer area with wrong lines
    // if PadColumnStyle = pcsPadHeaderAndData then
    // inc(FooterRect.Left);
    FooterRect.Right := ClientWidth;
  end;

  if wwIsCustomStyle(Self) then
  begin
    SaveIndex := SaveDC(Canvas.Handle);
    try
      LDetails := StyleServices.GetElementDetails(tgFixedCellNormal);
      FooterRect.Left := FooterRect.Left - 1;
      StyleServices.DrawElement(ACanvas.Handle, LDetails, FooterRect,
        FooterRect);
    finally
      RestoreDC(Canvas.Handle, SaveIndex);
    end;
  end
  else
    FillWithFixedBitmap(FooterRect, -1, FFooterColor);

  ACanvas.Pen.Color := LineColors.HighlightColor;
  ACanvas.MoveTo(FooterRect.Left, FooterRect.Top - 1);
  ACanvas.LineTo(FooterRect.Left, FooterRect.Bottom);

  if (PadColumnStyle = pcsPlain) or ((PadColumnStyle = pcsPadHeader) and
    (BorderStyle <> bsNone)) then
  begin
    ACanvas.Pen.Color := clBlack;
    ACanvas.MoveTo(FooterRect.Left, FooterRect.Top - 1);
    ACanvas.LineTo(FooterRect.Right, FooterRect.Top - 1);
    ACanvas.LineTo(FooterRect.Right, FooterRect.Bottom + 1);

    // FillWithFixedBitmaps(FooterRect, -1, FFooterColor);

    ACanvas.Pen.Color := LineColors.HighlightColor;
    ACanvas.MoveTo(FooterRect.Left, FooterRect.Top);
    ACanvas.LineTo(FooterRect.Right, FooterRect.Top);
    ACanvas.MoveTo(FooterRect.Left, FooterRect.Top);
    ACanvas.LineTo(FooterRect.Left, FooterRect.Bottom);

    ACanvas.Pen.Color := clBlack;
    ACanvas.MoveTo(FooterRect.Left, FooterRect.Bottom - 1);
    ACanvas.LineTo(FooterRect.Right, FooterRect.Bottom - 1);
  end;

  ACanvas.Pen.Color := clBlack;
  ACanvas.MoveTo(FooterRect.Left, FooterRect.Bottom);
  ACanvas.LineTo(FooterRect.Right, FooterRect.Bottom);

  if FDataLink.Active then
  begin
    for ACol := FIndicatorOffset to (inherited FixedCols) - FIndicatorOffset do
      ProcessFooterCell(ACol);
    for ACol := LeftCol to ColCount - 1 do
      ProcessFooterCell(ACol);
  end;

  if UseRightToLeftAlignment then
    ChangeOrientation(false);
  EndPainting;
end;

procedure TwwCustomDBGrid.SetFooterColor(sel: TColor);
begin
  if sel <> FFooterColor then
  begin
    FFooterColor := sel;
    LayoutChanged;
  end;
end;

procedure TwwCustomDBGrid.SetFooterCellColor(sel: TColor);
begin
  if sel <> FFooterCellColor then
  begin
    FFooterCellColor := sel;
    LayoutChanged;
  end;
end;

procedure TwwCustomDBGrid.SetFooterHeight(val: integer);
begin
  if (val <> FFooterHeight) then
  begin
    if FFooterHeight < 0 then
      FFooterHeight := 0
    else
      FFooterHeight := val;
    LayoutChanged;
  end;
end;

procedure TwwCustomDBGrid.GetControlInfo(AFieldName: string;
  var AControlType: string; var AParameters: string);

var
  TempComponent: TComponent;
begin
  if ControlInfoInDataset then
  begin
    // 8/24/06 - Check if datasource is nil
    if DataSource = nil then
    begin
      TempComponent := Self
    end
    else
    begin
      TempComponent := DataSource.DataSet;
      if (DataSource.DataSet = nil) or
        (wwGetControlType(DataSource.DataSet) = nil) then
        TempComponent := Self;
    end
  end
  else
    TempComponent := Self;
  WWDataSet_GetControl(TempComponent, AFieldName, AControlType, AParameters);
end;

function TwwCustomDBGrid.GetControlType: TStrings;
begin
  result := nil;
  if ControlInfoInDataset then
    result := wwGetControlType(DataSource.DataSet);
  if result = nil then { Delphi5 }
    result := ControlType;
end;

procedure TwwCustomDBGrid.DoUpdateFooter;
begin
  if Assigned(FOnUpdateFooter) then
    FOnUpdateFooter(Self);
end;

procedure TwwCustomDBGrid.WMRButtonDown(var Message: TWMRButtonDown);

var
  ParentForm: TCustomForm;
begin
  if not(csDesigning in ComponentState) then
  begin
    ParentForm := GetParentForm(Self) as TCustomForm;
    if (ParentForm <> Nil) and (TForm(ParentForm).FormStyle = fsMDIChild) then
    begin
      { 7/2/2000 - Check for nil Screen.ActiveControl }
      if (screen.activecontrol = nil) or
        (GetParentForm(screen.activecontrol) <> ParentForm) then
      begin
        Windows.SetFocus(Handle);
        { 9/22/98 - Don't call inherited if fail to set focus as this would
          lead to OnValidate getting called twice }
        if Windows.GetFocus <> Self.Handle then
          Exit;
      end
    end
  end;
  inherited;
end;

procedure TwwCustomDBGrid.WMLButtonDown(var Message: TWMLButtonDown);

var
  ParentForm: TCustomForm;
begin
  if not(csDesigning in ComponentState) then
  begin
    ParentForm := GetParentForm(Self) as TCustomForm;
    if (ParentForm <> Nil) and (TForm(ParentForm).FormStyle = fsMDIChild) then
    begin
      { 7/2/2000 - Check for nil Screen.ActiveControl }
      if (screen.activecontrol = nil) or
        (GetParentForm(screen.activecontrol) <> ParentForm) then
      begin
        { 9/22/98 - Don't call inherited if fail to set focus as this would
          lead to OnValidate getting called twice }
        Windows.SetFocus(Handle);
        if Windows.GetFocus <> Self.Handle then
          Exit;
      end
    end
  end;
  inherited;
end;

// 8/8/2001- PYW - Make sure Datalink is active before going to next or prior record with mouse wheel.
{$IFDEF wwdelphi4up}

function TwwCustomDBGrid.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): boolean;
begin
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    if (FDataLink <> nil) and FDataLink.Active then
      DataSource.DataSet.Next;
  result := True;
end;

function TwwCustomDBGrid.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): boolean;
begin
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    if (FDataLink <> nil) and FDataLink.Active then
      DataSource.DataSet.Prior;
  result := True;
end;

function TwwCustomDBGrid.ExecuteAction(Action: TBasicAction): boolean;
begin
  result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TwwCustomDBGrid.UpdateAction(Action: TBasicAction): boolean;
begin
  result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TwwCustomDBGrid.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing and ((Height = 0) or (Width = 0)) and (Align <> alNone) and
  { 11/11/98 - Check width too }
    (Self is TwwDBGrid) and (TwwDBGrid(Self).Patch[1] = false) then
  begin
    RequestAlign; { 10/21/98 }
  end;
  // if not Showing then CollapseChildGrid;

end;
{$ENDIF}

procedure TwwCustomDBGrid.DoCreateHintWindow(HintWindow: TwwGridHintWindow;
  AField: TField; R: TRect; var WordWrap: boolean;
  var MaxWidth, MaxHeight: integer; var DoDefault: boolean);
begin
  if Assigned(FOnCreateHintWindow) then
    FOnCreateHintWindow(Self, HintWindow, AField, R, WordWrap, MaxWidth,
      MaxHeight, DoDefault);
end;

procedure TwwCustomDBGrid.ClearURLPaint;
begin
  URLLinkActive := false;
  if (URLLinkActiveRow >= 0) then
  begin
    Cursor := FSavedCursor;
    // 4/9/2002 -PYW - Restore saved Cursor.  Preserve Cursor before URLPaint
    if IsValidCell(URLLinkActiveCol, URLLinkActiveRow) then
    begin
      InvalidateCell(URLLinkActiveCol, URLLinkActiveRow);
    end;
  end;
  URLLinkActiveRow := -1;
  URLLinkActiveCol := -1;
end;

procedure TwwCustomDBGrid.MouseMove(Shift: TShiftState; AX, AY: integer);

var
  PriorRow: integer;
  indicatoroffset, TitleOffset: integer;
  R: TRect;
  sp: TPoint;
  AHintText: string;
  DrawRect: TRect;
  DrawFlags: integer;
  oldmaxheight, MaxWidth, MaxHeight, hintwidth: integer;
  DoDefault: boolean;
  VerticalFits, HorizontalFits: boolean;
  curField: TField;
  StartCol, EndCol: integer;
  checkHot: boolean;
  Column, tempFixedCols: integer;
begin
  inherited;
  // form1.edit1.text:= form1.edit1.text + '1';
  with MouseCoord(AX, AY) do
  begin

    // Support url links
    if (X >= 0) and (Y >= FTitleOffset) and (X < FCacheColInfo.Count) and
      (TwwCacheColInfoItem(FCacheColInfo[X]).ControlType = 'URL-Link') then
    begin
      if (URLLinkActiveCol <> X) or (URLLinkActiveRow <> Y) then
      begin
        // 4/9/2002 -PYW - Preserve current Cursor.
        if Cursor <> crHandPoint then
          FSavedCursor := Cursor;
        Cursor := crHandPoint;
        URLLinkActive := True;
        if URLLinkActiveRow <> 0 then
          InvalidateCell(URLLinkActiveCol, URLLinkActiveRow);
        URLLinkActiveRow := Y;
        URLLinkActiveCol := X;
        R := CellRect(URLLinkActiveCol, URLLinkActiveRow);
        InvalidateRect(Handle, @R, false);
      end
    end
    else if (Cursor = crHandPoint) and URLLinkActive then
    begin
      Cursor := FSavedCursor; // 4/9/2002 -PYW - Restore saved cursor
      URLLinkActive := false;
      if URLLinkActiveRow <> 0 then
      // Don't use InvalidateCell as it repaints the entire cell
      // instead of just the top part.
      // InvalidateCell(URLLinkActiveCol, URLLinkActiveRow);
      begin
        R := CellRect(URLLinkActiveCol, URLLinkActiveRow);
        InvalidateRect(Handle, @R, false);
      end;
      URLLinkActiveRow := -1;
      URLLinkActiveCol := -1;
    end;

    checkHot := false;
    if (X >= FIndicatorOffset) and (Columns[DbCol(X)].GroupName <> '') then
    begin
      R := GroupNameCellRect(X, 0, StartCol, EndCol);
      if AY <= R.Bottom then
      begin
        if not MouseOverGroupTitle then
          checkHot := True;
      end
      else if MouseOverGroupTitle then
        checkHot := True
    end;

    if (Y < FTitleOffset) and ShowSearchRow then
    begin
      // Don't show title in hot state if its below title
      R := TitleCellRect(X, Y);
      if (AY >= R.Bottom) then
      begin
        if MouseOverGroupChild then
          checkHot := True;
        if (titleLastMouseX >= 0) and (titleLastMouseY >= 0) then
        begin
          InvalidateCell(titleLastMouseX, titleLastMouseY);
          titleLastMouseX := -1;
          titleLastMouseY := -1;
          Exit;
        end;
      end
      else if not MouseOverGroupChild then
        checkHot := True
    end;

    if ((X <> titleLastMouseX) or (Y <> titleLastMouseY)) or checkHot then
    begin

      if wwUseThemes(Self) and not(cslButtonDown in ControlState) then
      begin
        if (Y < FTitleOffset) then
        begin
          InvalidateCell(X, Y);
        end;
        if titleLastMouseY < FTitleOffset then
        begin
          InvalidateCell(titleLastMouseX, titleLastMouseY);
        end;

        MouseOverGroupTitle := false;
        MouseOverGroupChild := false;
        if (DbCol(X) >= 0) and (DbRow(Y) < 0) then
        begin
          if (Columns[DbCol(X)].GroupName <> '') then
          begin
            R := GroupNameCellRect(X, 0, StartCol, EndCol);
            if AY <= R.Bottom then
            begin
              MouseOverGroupTitle := True;
            end
            else if AY <= TitleCellRect(X, Y).Bottom then
              MouseOverGroupChild := True;
          end
          else if AY <= TitleCellRect(X, Y).Bottom then
            MouseOverGroupChild := True;
        end;

        InvalidateTitle;

        titleLastMouseX := X;
        titleLastMouseY := Y;
      end;
    end;

    if not(dgShowCellHint in Options) then
      Exit;
    if wwGridEssentials then
      DisplayProfessionalVersionOnlyMessage(Self,
        'Cell level hints are only supported in InfoPower Professional');

    if not DataLink.Active then
      Exit; // 7/26/2001-PYW-Make sure datalink is active if showing hints.

    if ((X <> lastMouseX) or (Y <> lastMouseY)) then
    begin
      R := inherited CellRect(X, Y);
      // 12/21/01 - Fix hint not showing bug

      lastMouseX := X;
      lastMouseY := Y;
      FreeHintWindow;
      HintTimer.Free;
      HintTimer := nil;

      if (X = col) and (Y = row) then
      begin
        if (inplaceeditor <> nil) and (inplaceeditor.Visible) then
          Exit;
        if Self is TwwDBGrid then
        begin
          if (Self.CurrentCustomEdit <> nil) and (Self.CurrentCustomEdit.Visible)
          then
            Exit;

        end
      end;

      indicatoroffset := 0;
      TitleOffset := 0;
      if dgIndicator in Options then
        indicatoroffset := 1;
      if dgTitles in Options then
        TitleOffset := 1;
      if (Y >= TitleOffset) and (X >= indicatoroffset) then
      begin
        curField := Fields[X - indicatoroffset];
        PriorRow := DataLink.ActiveRecord;
        // Recursive grids should rely on prior activerecord
        DataLink.ActiveRecord := Y - TitleOffset + RowOffset;
        AHintText := '';
        try
          if X - indicatoroffset < ColCount then
          begin
            if curField is TBlobField then
            begin
              if curField.DataType in [ftMemo, ftOraBlob, ftOraclob
{$IFDEF wwDelphi2006Up}
                , ftWideMemo
{$ENDIF}
                ] then // 10/5/06
                AHintText := GetFieldValue(X - indicatoroffset)
            end
            else
            begin
              AHintText := GetFieldValue(X - indicatoroffset)
            end;
          end;
        finally
          DataLink.ActiveRecord := PriorRow;
        end;

        if AHintText = '' then
          Exit;

        DrawRect := Rect(0, 0, R.Right - R.Left - 4, 0);
        DrawFlags := DT_NOPREFIX;
        if dgWordWrap in Options then
          DrawFlags := DrawFlags or DT_EDITCONTROL or DT_WORDBREAK;
        if Pos(#9, AHintText) > 0 then
          DrawFlags := DrawFlags or DT_EXPANDTABS; // 9/7/00

        Column := X;
        tempFixedCols := inherited FixedCols;
        if (Column >= tempFixedCols) then
          // 11/23/08 - Respect fixed column font
          Canvas.Font.assign(Font)
          { 8/24/00 - Set default before calling calccellcolors }
        else
          Canvas.Font.assign(TitleFont);

        DoCalcCellColorsDetect(curField, [], false, Canvas.Font, Canvas.Brush);

        DrawTextEx(Canvas.Handle, PChar(AHintText), Length(AHintText), DrawRect,
          DrawFlags or DT_CALCRECT, nil);

        VerticalFits := (DrawRect.Bottom - DrawRect.Top <= R.Bottom - R.Top);
        HorizontalFits := (DrawRect.Right - DrawRect.Left < R.Right -
          R.Left - 1);
        if VerticalFits and HorizontalFits then
        begin
          if (Self is TwwDBGrid) then
          begin
            if (TwwDBGrid(Self).Patch[11] = false) then
              Exit; // 4/30/09 - patch[11] - dgAlwaysShowCellHint
          end
          else
            Exit;
        end;

        HintWindow := CreateHintWindow(Fields[X - indicatoroffset]);
        HintWindow.Canvas.Font.assign(Canvas.Font);
        { Default to current cell's font }
        HintTimer := TTimer.Create(Self);
        HintTimer.OnTimer := HintTimerEvent;
        HintTimer.Interval := 250;
        HintTimer.Enabled := True;

        sp := Self.ClientToScreen(Point(0, 0));
        with TwwGridHintWindow(HintWindow) do
        begin
          if FieldMappedText or (curField.Alignment = taLeftJustify) then
            Alignment := taLeftJustify
          else
            Alignment := curField.Alignment;

          DoDefault := True;
          WordWrap := True;
          MaxHeight := R.Bottom - R.Top - 2;
          oldmaxheight := MaxHeight;
          MaxWidth := screen.Width;
          Caption := AHintText; // 9/7/00
          DoCreateHintWindow(TwwGridHintWindow(HintWindow),
            Fields[X - indicatoroffset], R, WordWrap, MaxWidth, MaxHeight,
            DoDefault);
          AHintText := Caption; // 4/30/09 - Allow hint to be updated in event

          { 2/29/00 - subtract 4 to be consistent with above calculation }
          MaxWidth := Max((R.Right - R.Left - 4), MaxWidth);

          if not DoDefault then
            Exit;

          R.Bottom := R.Bottom - 2;

          // MaxWidth:= wwmax(r.Right-r.left, MaxWidth);
          DrawRect := Rect(0, 0, MaxWidth, MaxHeight);
          DrawFlags := DT_NOPREFIX;
          if WordWrap then
            DrawFlags := DrawFlags or DT_EDITCONTROL or DT_WORDBREAK;
          if Pos(#9, AHintText) > 0 then
            DrawFlags := DrawFlags or DT_EXPANDTABS; // 9/7/00
          DrawTextEx(Canvas.Handle, PChar(AHintText), Length(AHintText),
            DrawRect, DrawFlags or DT_CALCRECT, nil);
          hintwidth := DrawRect.Right - DrawRect.Left;
          if DrawRect.Right > MaxWidth then
            DrawRect.Right := MaxWidth;
          if DrawRect.Bottom > MaxHeight then
            DrawRect.Bottom := MaxHeight;

          if MaxHeight <> oldmaxheight then
            R.Bottom := wwMax(R.Top + DrawRect.Bottom, R.Bottom);

          { FieldMappedText set to True by GetFieldValue if its mapped }
          if (Alignment = taLeftJustify) then
          begin
            if R.Left + DrawRect.Right + 8 <= MaxWidth then
              R.Right := R.Left + DrawRect.Right + 8
            else if MaxWidth <> 0 then
            begin
              // r.right := r.Left + MaxWidth + 8
              // 6/29/2000 - PYW - Compute hint position correctly in different screen resolutions
              // like 800x600 and when setting MaxLength in event.
              if R.Left + DrawRect.Right + 8 > screen.Width then
                R.Left := R.Right - DrawRect.Right - 8
              else
                R.Right := R.Left + hintwidth + 8;
            end;
          end
          else
            R.Left := R.Right - DrawRect.Right - 8;

          OffsetRect(R, sp.X, sp.Y - 1);
          ActivateHint(R, AHintText);
        end;
      end;
    end
  end
end;

procedure TwwCustomDBGrid.FreeHintWindow;
begin
  HintTimerCount := 0;
  SkipErase := True;
  HintWindow.Free;
  SkipErase := false;
  HintWindow := nil;
  if HintTimer <> nil then
    HintTimer.Enabled := false;
end;

Function TwwCustomDBGrid.CreateHintWindow(AField: TField): THintWindow;
begin
  HintWindow := TwwGridHintWindow.Create(Self);
  TwwGridHintWindow(HintWindow).Grid := Self;
  HintWindow.Color := GetSysColor(COLOR_INFOBK);
  HintWindow.Canvas.Brush.Color := GetSysColor(COLOR_INFOBK);
  HintWindow.Canvas.Font := Self.Font;
  HintWindow.Canvas.Font.Color := GetSysColor(COLOR_INFOTEXT);
  HintWindow.Canvas.Pen.Color := clBlack;
  TwwGridHintWindow(HintWindow).Field := AField;
  result := HintWindow;
end;

procedure TwwCustomDBGrid.HintTimerEvent(Sender: TObject);

var
  sp, cp: TPoint;
  OutsideClient: boolean;
  cr: TRect;
  hintTimerInterval: integer;
begin
  if not(HintWindow <> nil) then
    Exit;

  GetCursorPos(cp);

  sp := Self.ScreenToClient(cp);
  cr := CellRect(lastMouseX, lastMouseY);
  InflateRect(cr, 1, 1);
  if not(PtInRect(cr, sp)) then
  begin
    FreeHintWindow;
    lastMouseX := 0;
    lastMouseY := 0;
    Exit;
  end;

  sp := Self.ClientToScreen(Point(0, 0));

  if (cp.X < sp.X) or (cp.X > sp.X + ClientRect.Right - ClientRect.Left) or
    (cp.Y < sp.Y) or (cp.Y > sp.Y + ClientRect.Bottom - ClientRect.Top) then
  begin
    OutsideClient := True;
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
    Inc(HintTimerCount);
    hintTimerInterval := HintTimer.Interval;
    if HintTimerCount >
      wwMax(Application.HintHidePause div hintTimerInterval, 16) then
    begin
      FreeHintWindow;
    end
  end

end;

procedure TwwCustomDBGrid.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  message.result := 1;
end;

procedure TwwCustomDBGrid.BeginUpdate;
begin
  if not HandleAllocated then
    Exit;
  if not Showing then
    Exit;
  if FUpdateCount = 0 then
    SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TwwCustomDBGrid.SetUpdateState(Updating: boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, ord(not Updating), 0);
end;

procedure TwwCustomDBGrid.EndUpdate(Repaint: boolean = false);
begin
  if not HandleAllocated then
    Exit;
  if not Showing then
    Exit;

  if FUpdateCount > 0 then
    Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    SetUpdateState(false);
    if Repaint then
      Invalidate;
  end
end;

Procedure TwwCustomDBGrid.InvalidateCurrentRow;

var
  I: integer;
begin
  for I := 0 to ColCount - 1 do
    InvalidateCell(I, row);
end;

{ TCustomGrid }
function PointInGridRect(col, row: Longint; const Rect: TGridRect): boolean;
begin
  result := (col >= Rect.Left) and (col <= Rect.Right) and (row >= Rect.Top) and
    (row <= Rect.Bottom);
end;

{$IF NOT DEFINED(CLR)}

procedure FillDWord(var Dest; Count, value: integer);
// {$IFDEF PUREPASCAL}
{$IFDEF WIN64}
{$POINTERMATH ON}
var
  I: integer;
  P: PInteger;
begin
  P := PInteger(@Dest);
  for I := 0 to Count - 1 do
    P[I] := value;
end;
{$POINTERMATH OFF}
{$ELSE !PUREPASCAL}
{$IFDEF CPUX86}
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;
{$ENDIF CPUX86}
{$ENDIF !PUREPASCAL}
{$ENDIF}
{$IF NOT DEFINED(CLR)}

function StackAlloc(Size: integer): Pointer; {$IFNDEF PUREPASCAL} register;
{$ENDIF}
{$IFDEF WIN64}
// {$IFDEF PUREPASCAL}
begin
  GetMem(result, Size);
end;
{$ELSE !PUREPASCAL}
{$IFDEF CPUX86}
asm
  POP   ECX          { return address }
  MOV   EDX, ESP
  ADD   EAX, 3
  AND   EAX, not 3   // round up to keep ESP dword aligned
  CMP   EAX, 4092
  JLE   @@2
@@1:
  SUB   ESP, 4092
  PUSH  EAX          { make sure we touch guard page, to grow stack }
  SUB   EAX, 4096
  JNS   @@1
  ADD   EAX, 4096
@@2:
  SUB   ESP, EAX
  MOV   EAX, ESP     { function result = low memory address of block }
  PUSH  EDX          { save original SP, for cleanup }
  MOV   EDX, ESP
  SUB   EDX, 4
  PUSH  EDX          { save current SP, for sanity check  (sp = [sp]) }
  PUSH  ECX          { return to caller }
end;
{$ENDIF CPUX86}
{$ENDIF !PUREPASCAL}
{$ENDIF}
{ StackFree pops the memory allocated by StackAlloc off the stack.
  - Calling StackFree is optional - SP will be restored when the calling routine
  exits, but it's a good idea to free the stack allocated memory ASAP anyway.
  - StackFree must be called in the same stack context as StackAlloc - not in
  a subroutine or finally block.
  - Multiple StackFree calls must occur in reverse order of their corresponding
  StackAlloc calls.
  - Built-in sanity checks guarantee that an improper call to StackFree will not
  corrupt the stack. Worst case is that the stack block is not released until
  the calling routine exits. }

{$IF NOT DEFINED(CLR)}

procedure StackFree(P: Pointer); {$IFNDEF PUREPASCAL}register; {$ENDIF}
// {$IFDEF PUREPASCAL}
{$IFDEF WIN64}
begin
  FreeMem(P);
end;
{$ELSE !PUREPASCAL}
{$IFDEF CPUX86}
asm
  POP   ECX                     { return address }
  MOV   EDX, DWORD PTR [ESP]
  SUB   EAX, 8
  CMP   EDX, ESP                { sanity check #1 (SP = [SP]) }
  JNE   @@1
  CMP   EDX, EAX                { sanity check #2 (P = this stack block) }
  JNE   @@1
  MOV   ESP, DWORD PTR [ESP+4]  { restore previous SP }
@@1:
  PUSH  ECX                     { return to caller }
end;
{$ENDIF CPUX86}
{$ENDIF !PUREPASCAL}
{$ENDIF}

procedure TwwCustomDBGrid.InheritedPaint;
type
  PIntArray = ^TIntArray;
  TIntArray = array [0 .. MaxCustomExtents] of integer;
var
  DrawInfo: TGridDrawInfo;
  sel: TGridRect;
  FColOffset: integer;
  PointsList: PIntArray;
  MaxStroke: integer;
  StrokeList: PIntArray;
  IsCustomStyle: boolean;

  procedure DrawLines(DoHorz, DoVert: boolean; col, row: Longint;
    const CellBounds: array of integer; OnColor, OffColor: TColor);

  { Cellbounds is 4 integers: StartX, StartY, StopX, StopY
    Horizontal lines:  MajorIndex = 0
    Vertical lines:    MajorIndex = 1 }

  const
    FlatPenStyle = PS_Geometric or PS_Solid or PS_EndCap_Flat or PS_Join_Miter;

    procedure DrawAxisLines(const AxisInfo: TGridAxisDrawInfo;
      Cell, MajorIndex: integer; UseOnColor: boolean);
    var
      line: integer;
      LogBrush: TLOGBRUSH;
      Index: integer;
{$IF DEFINED(CLR)}
      Points: array of TPoint;
{$ELSE}
      Points: PIntArray;
{$ENDIF}
      StopMajor, StartMinor, StopMinor, StopIndex: integer;
      LineIncr: integer;
    begin
      with Canvas, AxisInfo do
      begin
        if EffectiveLineWidth <> 0 then
        begin
          Pen.Width := GridLineWidth;
          if UseOnColor then
            Pen.Color := OnColor
          else
            Pen.Color := OffColor;
          if Pen.Width > 1 then
          begin
            LogBrush.lbStyle := BS_Solid;
            LogBrush.lbColor := Pen.Color;
            LogBrush.lbHatch := 0;
            Pen.Handle := ExtCreatePen(FlatPenStyle, Pen.Width,
              LogBrush, 0, nil);
          end;
          Points := PointsList;
          line := CellBounds[MajorIndex] + (EffectiveLineWidth shr 1) +
            AxisInfo.GetExtent(Cell);
          // !!! ??? Line needs to be incremented for RightToLeftAlignment ???
          if UseRightToLeftAlignment and (MajorIndex = 0) then
            Inc(line);
          StartMinor := CellBounds[MajorIndex xor 1];
          StopMinor := CellBounds[2 + (MajorIndex xor 1)];
          StopMajor := CellBounds[2 + MajorIndex] + EffectiveLineWidth;
{$IF DEFINED(CLR)}
          StopIndex := MaxStroke * 2;
{$ELSE}
          StopIndex := MaxStroke * 4;
{$ENDIF}
          Index := 0;
          repeat
{$IF DEFINED(CLR)}
            if MajorIndex <> 0 then
            begin
              Points[Index].Y := line;
              Points[Index].X := StartMinor;
            end
            else
            begin
              Points[Index].X := line;
              Points[Index].Y := StartMinor;
            end;
            Inc(Index);
            if MajorIndex <> 0 then
            begin
              Points[Index].Y := line;
              Points[Index].X := StopMinor;
            end
            else
            begin
              Points[Index].X := line;
              Points[Index].Y := StopMinor;
            end;
            Inc(Index);
{$ELSE}
            Points^[Index + MajorIndex] := line; { MoveTo }
            Points^[Index + (MajorIndex xor 1)] := StartMinor;
            Inc(Index, 2);
            Points^[Index + MajorIndex] := line; { LineTo }
            Points^[Index + (MajorIndex xor 1)] := StopMinor;
            Inc(Index, 2);
{$ENDIF}
            // Skip hidden columns/rows.  We don't have stroke slots for them
            // A column/row with an extent of -EffectiveLineWidth is hidden
            repeat
              Inc(Cell);
              LineIncr := AxisInfo.GetExtent(Cell) + EffectiveLineWidth;
            until (LineIncr > 0) or (Cell > LastFullVisibleCell);
            Inc(line, LineIncr);
          until (line > StopMajor) or (Cell > LastFullVisibleCell) or
            (Index > StopIndex);
{$IF DEFINED(CLR)}
          { 2 points per line -> Index div 2 }
          PolyPolyLine(Canvas.Handle, Points, StrokeList, Index shr 1);
{$ELSE}
          { 2 integers per point, 2 points per line -> Index div 4 }
          PolyPolyLine(Canvas.Handle, Points^, StrokeList^, Index shr 2);
{$ENDIF}
        end;
      end;
    end;

  begin
    if (CellBounds[0] = CellBounds[2]) or (CellBounds[1] = CellBounds[3]) then
      Exit;
    if not DoHorz then
    begin
      DrawAxisLines(DrawInfo.Vert, row, 1, DoHorz);
      DrawAxisLines(DrawInfo.Horz, col, 0, DoVert);
    end
    else
    begin
      DrawAxisLines(DrawInfo.Horz, col, 0, DoVert);
      DrawAxisLines(DrawInfo.Vert, row, 1, DoHorz);
    end;
  end;

  procedure DrawAllLines;
  var
    LStyle: TCustomStyleServices;
    LColor: TColor;
    LineColor: TColor;
    LFixedColor: TColor;
    LFixedBorderColor: TColor;
  begin
    FInternalColor := Color;
    LStyle := StyleServices;
    if (FInternalDrawingStyle = gdsThemed) then
    begin
      LStyle.GetElementColor(LStyle.GetElementDetails(tgCellNormal),
        ecBorderColor, LineColor);
      LStyle.GetElementColor(LStyle.GetElementDetails(tgCellNormal),
        ecFillColor, FInternalColor);
      LStyle.GetElementColor(LStyle.GetElementDetails(tgFixedCellNormal),
        ecBorderColor, LFixedBorderColor);
      LStyle.GetElementColor(LStyle.GetElementDetails(tgFixedCellNormal),
        ecFillColor, LFixedColor);
    end
    else
    begin
      { if FInternalDrawingStyle = gdsGradient then
        begin
        LineColor := $F0F0F0;
        LFixedColor := Color;
        LFixedBorderColor := GetShadowColor($F0F0F0, -45);

        if LStyle.Enabled then
        begin
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientCellNormal),
        ecBorderColor, LColor) and (LColor <> clNone) then
        LineColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientCellNormal),
        ecFillColor, LColor) and (LColor <> clNone) then
        FInternalColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientFixedCellNormal),
        ecBorderColor, LColor) and (LColor <> clNone) then
        LFixedBorderColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientFixedCellNormal),
        ecFillColor, LColor) and (LColor <> clNone) then
        LFixedColor := LColor;
        end;
        end
        else }
      begin
        LineColor := clSilver;
        LFixedColor := FixedColor;
        LFixedBorderColor := clBlack;

        if LStyle.Enabled then
        begin
          if LStyle.GetElementColor
            (LStyle.GetElementDetails(tgClassicCellNormal), ecBorderColor,
            LColor) and (LColor <> clNone) then
            LineColor := LColor;
          if LStyle.GetElementColor
            (LStyle.GetElementDetails(tgClassicCellNormal), ecFillColor, LColor)
            and (LColor <> clNone) then
            FInternalColor := LColor;
          if LStyle.GetElementColor
            (LStyle.GetElementDetails(tgClassicFixedCellNormal), ecBorderColor,
            LColor) and (LColor <> clNone) then
            LFixedBorderColor := LColor;
          if LStyle.GetElementColor
            (LStyle.GetElementDetails(tgClassicFixedCellNormal), ecFillColor,
            LColor) and (LColor <> clNone) then
            LFixedColor := LColor;
        end;
      end;
    end;

    // UpdateRect := Canvas.ClipRect;
    CalcDrawInfo(DrawInfo);
    with DrawInfo do
    begin
      if (Horz.EffectiveLineWidth > 0) or (Vert.EffectiveLineWidth > 0) then
      begin
        { Draw the grid line in the four areas (fixed, fixed), (variable, fixed),
          (fixed, variable) and (variable, variable) }
        MaxStroke := Max(Horz.LastFullVisibleCell - LeftCol + FixedCols,
          Vert.LastFullVisibleCell - TopRow + FixedRows) + 3;
        PointsList := StackAlloc(MaxStroke * SizeOf(TPoint) * 2);
        StrokeList := StackAlloc(MaxStroke * SizeOf(integer));
        FillDWord(StrokeList^, MaxStroke, 2);

        if ColorToRGB(FInternalColor) = clSilver then
          LineColor := clGray;
        DrawLines(goFixedHorzLine in inherited Options, goFixedVertLine
          in inherited Options, 0, 0, [0, 0, Horz.FixedBoundary,
          Vert.FixedBoundary], LFixedBorderColor, LFixedColor);
        DrawLines(goFixedHorzLine in inherited Options, goFixedVertLine
          in Inherited Options, LeftCol, 0, [Horz.FixedBoundary, 0,
          Horz.GridBoundary, Vert.FixedBoundary], LFixedBorderColor,
          LFixedColor);
        DrawLines(goFixedHorzLine in inherited Options, goFixedVertLine
          in inherited Options, 0, TopRow, [0, Vert.FixedBoundary,
          Horz.FixedBoundary, Vert.GridBoundary], LFixedBorderColor,
          LFixedColor);
        DrawLines(goHorzLine in inherited Options,
          goVertLine in inherited Options, LeftCol, TopRow,
          [Horz.FixedBoundary, Vert.FixedBoundary, Horz.GridBoundary,
          Vert.GridBoundary], LineColor, FInternalColor);

        StackFree(StrokeList);
        StackFree(PointsList);
      end;

    end;
  end;

  procedure DrawCells(ACol, ARow: Longint;
    StartX, StartY, StopX, StopY: integer; Color: TColor;
    IncludeDrawState: TGridDrawState);

  var
    CurCol, CurRow: Longint;
    Where, curRect, GroupTitleRect: TRect;
    DrawState: TGridDrawState;
    curGroupName: String;
    StartCol, EndCol: integer;
    TempRect: TRect;

    function IntersectingRects(r1, r2: TRect): boolean;
    var
      R: TRect;
    begin
      result := IntersectRect(R, r1, r2);
    end;

  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < RowCount) do
    begin
      CurCol := ACol;
      GroupTitleRect := Rect(0, 0, 0, 0);
      curGroupName := '';
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
        Where.Right := Where.Left + ColWidths[CurCol];
        TempRect := UpdateRect;
        if (Canvas.CanvasOrientation = coRightToLeft) then
        begin
          TempRect.Right := ClientWidth - UpdateRect.Left;
          TempRect.Left := ClientWidth - UpdateRect.Right;
        end;

        if (Where.Right > Where.Left) and RectVisible((inherited Canvas).Handle,
          Where) and ((not UseAlternateBuffering) or IntersectingRects(TempRect,
          Where)) then
        begin
          DrawState := IncludeDrawState;
          if Focused and (CurRow = row) and (CurCol = col) then
            Include(DrawState, gdFocused);
          if PointInGridRect(CurCol, CurRow, sel) then
            Include(DrawState, gdSelected);
          if not((gdFocused in DrawState) and (CurCol = col)) or
            not(goEditing in inherited Options) or not EditorMode or
            (csDesigning in ComponentState) or
            (TwwCacheColInfoItem(FCacheColInfo[ACol]).ControlType = 'CheckBox')
          then
          // 3/23/04 - Still paint for checkbox
          begin
            // Support styles
            {
              if DefaultDrawing or (csDesigning in ComponentState) then
              begin
              Canvas.Font := Self.Font;
              if (gdSelected in DrawState) and
              (not (gdFocused in DrawState) or
              ([goDrawFocusSelected, goRowSelect] * (inherited Options) <> [])) then
              DrawCellHighlight(Where, DrawState, CurCol, CurRow)
              else
              DrawCellBackground(Where, Canvas.Brush.Color, DrawState, CurCol, CurRow);
              end;
            }
            curRect := Where;
            if (CurRow = 0) and (dgTitles in Options) and ShowSearchRow then
            // Support hierarchical titles
            begin
              Canvas.Font := TitleFont;
              curRect.Bottom := curRect.Bottom - GetSearchRowHeight;
            end;
            // !!! Later optimize so called just for one group
            if (CurRow = 0) and (dgTitles in Options) then
            // Support hierarchical titles
            begin
              curRect := TitleCellRect(CurCol, CurRow);
              // override rectangle for sub-group headings
              if (DbCol(CurCol) >= 0) and
                (Columns[DbCol(CurCol)].GroupName <> '') then
              begin
                GroupTitleRect := GroupNameCellRect(CurCol, CurRow, StartCol,
                  EndCol, false);
                DrawCell(CurCol, CurRow, GroupTitleRect, DrawState);
              end;
            end;
            DrawCell(CurCol, CurRow, curRect, DrawState);

            if (CurRow = 0) and (dgTitles in Options) and ShowSearchRow then
            begin
              curRect.Top := curRect.Bottom + 1;
              curRect.Bottom := Where.Bottom;
              PaintingSearchCell := True;
              try
                DrawCell(CurCol, CurRow, curRect, DrawState);
                // Check in draw cell if its painting the search row
              finally
                PaintingSearchCell := false;
              end;
            end
          end;
        end;
        Where.Left := Where.Right + DrawInfo.Horz.EffectiveLineWidth;
        Inc(CurCol);
      end;
      Where.Top := Where.Bottom + DrawInfo.Vert.EffectiveLineWidth;
      Inc(CurRow);
    end;
  end;

begin
  if UseRightToLeftAlignment then
    ChangeOrientation(True);

  { Draw the cells in the four areas }
  CalcDrawInfo(DrawInfo);
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  if IsCustomStyle then
    DrawAllLines;

  with DrawInfo do
  begin
    sel := Selection;

    FColOffset := 0;
    DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.FixedBoundary, FixedColor,
      [gdFixed]);
    DrawCells(LeftCol, 0, Horz.FixedBoundary - FColOffset, 0, Horz.GridBoundary,
      // !! clip
      Vert.FixedBoundary, FixedColor, [gdFixed]);

    if (DataLink <> nil) and (DataLink.Active) then
    begin
      DrawCells(0, TopRow, 0, Vert.FixedBoundary, Horz.FixedBoundary,
        Vert.GridBoundary, FixedColor, [gdFixed]);
      DrawCells(LeftCol, TopRow, Horz.FixedBoundary - FColOffset,
        // !! clip
        Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary, Color, []);
    end
    else
    begin
      // R:= CellRect(LeftCol, FTitleOffset);
      // R.Right:= ClientWidth;
      // R.Bottom:= ClientHeight;
      // FillWithBlendBitmap(R, -1, Color);
    end;
  end;

  if UseRightToLeftAlignment then
    ChangeOrientation(false);
end;

procedure TwwCustomDBGrid.ChangeOrientation(RightToLeftOrientation: boolean);

var
  Org: TPoint;
  Ext: TPoint;
  cr: TRect;
begin
  cr := inherited GetClientRect;

  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth, 0);
    Ext := Point(-1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, cr.Bottom, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * ClientWidth, Ext.Y * cr.Bottom, nil);
  end
  else
  begin
    Org := Point(0, 0);
    Ext := Point(1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, cr.Bottom, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * ClientWidth, Ext.Y * cr.Bottom, nil);
  end;
end;

function TwwCustomDBGrid.IsCustomEditCell(col, row: integer;
  var customEdit: TWinControl): boolean;

var
  FldName: string;
  I, APos: integer;
  ControlType: TStrings;
  IsDateTime: boolean;
begin
  result := false;
  if ecoDisableCustomControls in EditControlOptions then
    Exit;
  if not IsValidCell(col, row) then
    Exit;
  FldName := DataLink.Fields[DbCol(col)].FieldName;

  { 8/14/97 - Optimized logic to speed painting of grid }
  ControlType := GetControlType;
  for I := 0 to ControlType.Count - 1 do
  begin
    APos := 1;
    if strGetToken(ControlType[I], ';', APos) <> FldName then
      continue;
    if IsWWEditControl(strGetToken(ControlType[I], ';', APos)) then
    begin
      customEdit := GetComponent(strGetToken(ControlType[I], ';', APos));
      if customEdit = Nil then
        break;

      if GetParentForm(customEdit) <> nil then
        { 1/20/2000 - Check if have parent form }
        if wwIsClass(GetParentForm(customEdit).classtype, 'TwwRecordViewForm')
        then
          break;
      result := True;
      break;
    end
  end;

  // 3/17/06 - Support TimeStamp type
  IsDateTime := (DataLink.Fields[DbCol(col)] is TDateTimeField) or
    ((DataLink.Fields[DbCol(col)] <> nil) and
    (DataLink.Fields[DbCol(col)].DataType in [ftDate, ftDateTime, ftTimeStamp,
    ftTime]));

  if (FDateTimePicker <> Nil) and
    (not(ecoDisableDateTimePicker in EditControlOptions)) and
  // (not result) and (DataLink.Fields[dbcol(col)] is TDateTimeField) then
    (not result) and IsDateTime then
  begin
    customEdit := FDateTimePicker;
    result := True;
  end;

end;

Function TwwCustomDBGrid.GetComponent(thisName: string): TWinControl;

var
  component: TComponent;
  Form: TComponent;
  frameComponent: TComponent;
begin
  result := Nil;
  if ecoSearchOwnerForm in EditControlOptions then
    Form := wwGetOwnerFrameOrForm(Self)
  else
    Form := GetParentForm(Self) as TCustomForm; { -ksw (6/22/98) }
  if Form = nil then
    Exit; { 5/2/97 }

  { 5/2/97 - Also search owner of dataset form }
  component := nil;
  if (Pos('.', thisName) > 0) then
  begin
    if (Length(StrTrailing(thisName, '.')) > 0) then
    begin
      frameComponent := Form.FindComponent(strPreceding(thisName, '.'));
      if wwIsClass(frameComponent.classtype, 'TCustomFrame') then
        component := frameComponent.FindComponent(StrTrailing(thisName, '.'))
      else
      begin
        if (DataSource = nil) or (DataSource.DataSet = Nil) or
          (DataSource.DataSet.Owner = nil) then
          Exit;
        component := DataSource.DataSet.Owner.FindComponent
          (StrTrailing(thisName, '.'));
      end
    end
  end
  else
    component := Form.FindComponent(thisName);
  if (component <> Nil) and (component is TWinControl) then
    result := TWinControl(component);

end;

// Don't use default horizontal scrolling as it is flickery
procedure TwwCustomDBGrid.WMHScroll(var Msg: TWMHScroll);
begin
{$IFNDEF GRIDESSENTIALS}
  if (not PaintOptions.HaveBackgroundForDataCells) and
    (not UseRightToLeftAlignment) then
  begin
    // 6/5/01 - old behavior if not background blend
    inherited;
    Exit;
  end;
{$ELSE}
  if (not UseRightToLeftAlignment) then
  begin
    // 6/5/01 - old behavior if not background blend
    inherited;
    Exit;
  end;
{$ENDIF}
  if Msg.ScrollCode = SB_ThumbTrack then
  begin
    inherited;
    Exit;
  end;
  if (CurrentCustomEdit <> nil) then // Hide custom edit
  begin
    CurrentCustomEdit.Visible := false;
    CurrentCustomEdit := nil;
  end;

  // RSW - Give focus now so that child grid's hiding of inplaceeditor completes
  // Otherwise hiding it may fail and leave white cell
  if not AcquireFocus then
    Exit;
  // inherited;
  // exit;

  BeginUpdate;
  inherited;

  // 1/20/01 - Hides inplaceeditor in case is still shown for some reason
  if (inplaceeditor <> nil) and (CellRect(col, row).Left < CellRect(col - 1,
    row).Left) or (col < LeftCol) then
  begin
    if inplaceeditor <> nil then
      inplaceeditor.Left := Width + 10;
  end;

  EndUpdate;

  Invalidate;

end;

procedure TwwCustomDBGrid.PaintClickedTitleButton;

var
  ARect: TRect;
  TempY, StartCol, EndCol: integer;
begin
  if (TitleClickColumn >= 0) and FTitleButtons and (dgTitles in Options) and
    (not UseDragCanvas) then
  begin
    with Canvas do
    begin
      if TitleClickGroupTitle then
      begin
        ARect := GroupNameCellRect(TitleClickColumn, 0, StartCol, EndCol);
        ARect.Bottom := ARect.Bottom - 1;
      end
      else
      begin
        ARect := TitleCellRect(TitleClickColumn, 0);
      end;
      TempY := ARect.Bottom;
      // if not (dgRowLines in Options) then TempY:= TempY-2;
      if not(HaveAnyRowLines) then
        TempY := TempY - 2;
      if UseThemesInTitle then
        Exit;
      // if StyleServices.ThemesEnabled then exit;

      Pen.Color := clBlack;
      with ARect do
      begin
        PolyLine([Point(Left, Top), Point(Left, TempY)]);
        PolyLine([Point(Left, Top), Point(Right, Top)]);
      end;
      Pen.Color := clGray;
      with ARect do
      begin
        PolyLine([Point(Left + 1, Top + 1), Point(Left + 1, TempY - 1)]);
        if not TitleClickGroupTitle then
          PolyLine([Point(Left + 1, TempY - 1), Point(Right, TempY - 1)])
      end;

      // Makes look more 3d buttons
      { Pen.Color:= clWhite;
        with ARect do begin
        PolyLine([Point(Right, Top), Point(Right, TempY)]);
        PolyLine([Point(Left, TempY), Point(Right, TempY)]);
        end;
      }
      // Pen.Color:= clBtnFace;
      // with ARect do begin
      // PolyLine([Point(Left+1, TempY-1), Point(Right, TempY-1)])
      // end;

    end
  end
end;

procedure TwwCustomDBGrid.Draw3DLines(ARect: TRect; ACol, ARow: integer;
  AState: TGridDrawState);

var
  OrigPenColor: TColor;
  R: TRect;
begin
  if wwUseThemes(Self) and TStyleManager.IsCustomStyleActive then
    Exit;

  OrigPenColor := Canvas.Pen.Color;

  { if RowOffset>0 then
    ARect:= inherited CellRect(ACol, ARow)
    else begin
    ARect:= ARect;
    end;
  }
  if not PaintingSearchCell then
  begin
    R := ARect;
    ARect.Bottom := ARect.Top + RowHeights[ARow];
    if UseThemesInTitle then
    begin
      Canvas.Pen.Color := LineColors.DataColor;
      // LineColors.ShadowColor;
      Canvas.PolyLine([Point(R.Right, R.Top), Point(R.Right, R.Bottom)]);
    end
    // exit;
  end
  else
  begin
    R := ARect;
    Canvas.Pen.Width := 1;
    Canvas.Pen.Color := LineColors.DataColor;
    // LineColors.ShadowColor;
    if DrawCellInfo.DefaultDrawHorzBottomLine then
      Canvas.PolyLine([Point(R.Left, R.Bottom), Point(R.Right, R.Bottom)]);
    // if DrawCellInfo.DefaultDrawHorzBottomLine then
    Canvas.PolyLine([Point(R.Right, R.Top - 1), Point(R.Right, R.Bottom)]);

    if (ARow = row) and (FFocused or (dgAlwaysShowEditor in Options)) and
      ((dgRowSelect in Options) or (HaveActiveRecordColor)) then
      Exit;

    Canvas.Pen.Color := LineColors.HighlightColor;
    if DrawCellInfo.DefaultDrawHorzTopLine then
      Canvas.PolyLine([Point(R.Left, R.Top), Point(R.Right, R.Top)]);
    Exit;
    // DrawVertLine(ARect.top, Bottom+1)
  end;

  if SkipLineDrawing then
    Exit;

  // Always paint row lines in title area
  if (gdFixed in AState) and (ARow >= FTitleOffset) and
    (dgRowLinesDisableFixed in Options) then
    Exit;

  if not(gdFixed in AState) and not(dgRowLines in Options) then
    Exit;
  SkipLineDrawing := True;

  { 4/16/97 - Treat as non-3d when white background }
  { Exit if highlighted cell, and background color is same as highlight }
  if (LineStyle = glsDynamic) then
    IsWhiteBackground := ColorToRGB(Canvas.Brush.Color) = clWhite
  else
    IsWhiteBackground := ColorToRGB(Color) = clWhite;

  if (DbRow(ARow) = 0) then // Do just for first row
    TwwCacheColInfoItem(FCacheColInfo[ACol]).IsWhiteBackground :=
      IsWhiteBackground;
{$IFNDEF GRIDESSENTIALS}
  if PaintOptions.HaveBackgroundForDataCells then
    IsWhiteBackground := True;
{$ENDIF}

  // 3/4/01 - Highlighted row should not have white lines on top so treat as non-3d line
  // if (Row=Arow) and (dgRowSelect in Options) then IsWhiteBackground:= True;

  if DbRow(ARow) < 0 then
    if not PaintingSearchCell then
      Exit;
  if DbCol(ACol) < 0 then
    Exit;

  if (ACol >= FIndicatorOffset) and (ARow >= FTitleOffset) and
    (ColorToRGB(Color) = clWhite) then
  begin
    if HighlightCell(ACol, DbRow(ARow), '', AState) then
    begin
{$IFNDEF GRIDESSENTIALS}
      if (ColorToRGB(Canvas.Brush.Color) = ColorToRGB(clHighlight)) or
        (HaveActiveRecordColor) and
        (ColorToRGB(Canvas.Brush.Color)
        = ColorToRGB(PaintOptions.ActiveRecordColor)) then
{$ELSE}
      if (ColorToRGB(Canvas.Brush.Color) = ColorToRGB(clHighlight)) then
{$ENDIF}
      begin
        IsWhiteBackground := True;
        TwwCacheColInfoItem(FCacheColInfo[ACol]).IsWhiteBackground :=
          IsWhiteBackground;
      end
    end
  end;

  with Canvas do
  begin
    Pen.Width := 1;
    if (dgRowLines in Options) then
    begin
      R := ARect; // CellRect(ARow, ACol);
      if (LineStyle = glsSingle) or
        ((LineStyle = glsDynamic) and IsWhiteBackground) then
      begin
        Canvas.Pen.Color := LineColors.DataColor;
        if DrawCellInfo.DefaultDrawHorzBottomLine then
          Canvas.PolyLine([Point(R.Left, R.Bottom), Point(R.Right, R.Bottom)]);
      end
      else
      begin
        Canvas.Pen.Color := LineColors.ShadowColor;
        if DrawCellInfo.DefaultDrawHorzBottomLine then
          Canvas.PolyLine([Point(R.Left, R.Bottom), Point(R.Right, R.Bottom)]);

        if (ARow = row) and (FFocused or (dgAlwaysShowEditor in Options)) and
          ((dgRowSelect in Options) or (HaveActiveRecordColor)) then
          Exit;

        Canvas.Pen.Color := LineColors.HighlightColor;
        if DrawCellInfo.DefaultDrawHorzTopLine then
          Canvas.PolyLine([Point(R.Left, R.Top), Point(R.Right, R.Top)]);
      end;
    end;
    Pen.Color := OrigPenColor;
  end;
end;

procedure TwwCustomDBGrid.DrawLines;

var
  I: integer;
  Right, Bottom: integer;
  currowheight, titleheight: integer;
  DrawInfo: TGridDrawInfo;
  IsWhiteBackground: boolean;
  TempY, tempx, TempLeft, TempLeft2, TempTop, Tempbottom: integer;
  ARect: TRect;
  R: TRect;
  // curField: TField;
  FldName, GroupName, curGroupName: string;
  GroupOffset: integer;
  bidioffset: integer;

  tempCol, StartX, EndX: integer;
  StartY: integer;
  CustomLineDrawing: boolean;
  IsCustomStyle: boolean;
  OrigPenColor: TColor;

  // line drawing uses inherited cell rect
  function CellRect(ACol, ARow: integer): TRect;
  begin
    result := inherited CellRect(ACol, ARow);
  end;

  procedure DrawVertLines;

  var
    I: integer;
    // TempRect:TRect;
    procedure DrawVertLine(StartY, EndY: integer);
    begin
      if (FDataLink = nil) or (not FDataLink.Active) then
        Exit;

      if (LineStyle = glsSingle) or
        ((LineStyle = glsDynamic) and IsWhiteBackground) then
      begin
        Canvas.Pen.Color := LineColors.DataColor;
        Canvas.PolyLine([Point(CellRect(I, 0).Right, StartY),
          Point(CellRect(I, 0).Right, EndY)]);
      end
      else
      begin
        // Canvas.Pen.Color:= clBtnShadow;
        Canvas.Pen.Color := LineColors.ShadowColor;
        Canvas.PolyLine([Point(CellRect(I, 0).Right + bidioffset, StartY),
          Point(CellRect(I, 0).Right + bidioffset, EndY)]);
        // Canvas.Pen.Color:= clBtnHighlight;
        Canvas.Pen.Color := LineColors.HighlightColor;
        Canvas.PolyLine([Point(CellRect(I, 0).Right + 1 - bidioffset, StartY),
          Point(CellRect(I, 0).Right + 1 - bidioffset, EndY)]);
      end
    end;

  begin
    if (IsCustomStyle) then
      Exit;

    if (dgColLines in Options) then
    begin
      for I := LeftCol to LeftCol + VisibleColCount do
      begin
        if I >= ColCount then
          continue; // 5/21/01 - Fixes problem with 1 column grid
        if dgTitles in Options then
        begin
          DrawVertLine(CellRect(I, 0).Bottom, Bottom + 1);
        end
        else
        begin
          DrawVertLine(0, Bottom + 1);
        end;
        // 6/10/01-if Column width greater than grid width then need to skip reamainder of line drawing
        // Fixes problem with long field
        if CellRect(I, 0).Left + ColWidths[I] > ClientWidth then
          break;
      end;
    end;
  end;

  function IsCustomLineDrawing: boolean;
  var
    tempCol, TempRow: integer;
  begin
    result := false;
    for TempRow := 0 to VisibleRowCount - 1 do
    begin
      for tempCol := 0 to ColCount - 1 do
      begin
        if (tempCol < ColItems.Count) and
          (FastColumns[tempCol].ColumnFlags <> nil) and (TempRow < 256) and
          (FastColumns[tempCol].ColumnFlags[TempRow] <> 0) then
        begin
          result := True;
          Exit;
        end
      end
    end
  end;

begin
  IsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(Self);
  CalcDrawInfo(DrawInfo);
  IsWhiteBackground := (ColorToRGB(Color) = clWhite);
  OrigPenColor := Canvas.Pen.Color;

  if PaintOptions.HaveBackgroundForDataCells then
    IsWhiteBackground := True;
  if UseRightToLeftAlignment then
    bidioffset := 1
  else
    bidioffset := 0;

  // Determine Height Of Titles
  titleheight := TitleCellRect(0, 0).Bottom; // 8/17/09
  if titleheight = 0 then
    titleheight := DrawInfo.Vert.FixedBoundary - 1;

  // Determine the far right column.
  Right := ClientWidth;
  // Set right to the last visible cell if at end of the grid.
  if PadColumnStyle <> pcsPadHeader then
    if DrawInfo.Horz.LastFullVisibleCell = ColCount - 1 then
      Right := CellRect(ColCount - 1, 0).Right;

  // Determine bottom of the grid (not including footer).
  // 7/16/02 - Previously receiving one extra set of vertical lines if
  // only 1 row of data with dgTitles=false
  Bottom := CellRect(0, wwMax(0, VisibleRowCount + TitleOffset - 1)).Bottom;
  if Bottom = 0 then
    Bottom := DrawInfo.Vert.GridBoundary;

  // Draw all of the vertical Grid cell lines.
  if not HideAllLines then
    DrawVertLines;

  CustomLineDrawing := IsCustomLineDrawing;

  // Draw the bottom horizontal grid line for the active cell
  if (not HideAllLines) and (DataLink <> nil) and (DataLink.Active) and
    (dgRowLines in Options) and not(dgRowSelect in Options) then
  begin
    ARect := CellRect(col, row);
    currowheight := ARect.Bottom;
    if (LineStyle = glsSingle) or
      ((LineStyle = glsDynamic) and (TwwCacheColInfoItem(FCacheColInfo[col])
      .IsWhiteBackground)) then
      Canvas.Pen.Color := LineColors.DataColor
    else
      Canvas.Pen.Color := LineColors.ShadowColor; // clBtnShadow;

    if CustomLineDrawing then
    begin
      // 8/20/03 - Don't draw bottom line for active cell when it doesn't have the focus
      // 7/20/10 - Make sure columnflags is not nil
      if FFocused or ((Columns[col - FIndicatorOffset].ColumnFlags <> nil) and
        ((Columns[col - FIndicatorOffset].ColumnFlags[row - FTitleOffset] and
        wwDisableDrawBottomLine) = 0)) then
        if (GroupFieldName = '') and (not IsCustomStyle) then
          // 5/11/06 - Group line missing for active cell before when it loses focus
          Canvas.PolyLine([Point(ARect.Left, currowheight), Point(ARect.Right,
            currowheight)])
    end
    else
    begin
      if (GroupFieldName = '') and (not IsCustomStyle) then
        // 5/11/06 - Group line missing for active cell before when it loses focus
        Canvas.PolyLine([Point(ARect.Left, currowheight), Point(ARect.Right,
          currowheight)]);
    end
  end;

  if (not HideAllLines) and (DataLink <> nil) and (DataLink.Active) and
    (FixedCols > 0) then
  begin
    // Draw 3D - horizontal line for fixed columns
    if (not UseThemesInTitle) and (not(dgRowLinesDisableFixed in Options) or
      (dgTitles in Options)) then
    begin
      for I := 0 to VisibleRowCount do
      begin
        if (dgRowLinesDisableFixed in Options) and (I < VisibleRowCount) then
          continue; // Draw for only 1st row

        Tempbottom := inherited CellRect(0, I).Bottom;
        Canvas.Pen.Color := LineColors.FixedColor;
        TempLeft := CellRect(FixedCols - 1, 0).Right + 1;
        // 3/10/01 - Tweak as not far enough to the right before
        TempLeft2 := TempLeft;
        if (dgRowLinesDisableFixed in Options) then
        begin
          TempLeft := Right;
          TempLeft2 := TempLeft;
        end;

        if CustomLineDrawing then
        begin
          // 8/21/03 - Draw line under bottom indicator and fixed columns
          if (not UseThemesInTitle) or (not IsCustomStyle) then
          begin
            if (I = VisibleRowCount) and (I >= TitleOffset) and
              (dgIndicator in Options) then
            begin
              if not(dgHideBottomDataLine in Options) then
              begin
                if (TitleOffset > 0) or (I < VisibleRowCount) then
                  Canvas.PolyLine([Point(0, Tempbottom),
                    Point(TempLeft, Tempbottom)])
              end
            end;
          end;

          Canvas.Pen.Color := LineColors.HighlightColor;
          if (I < VisibleRowCount) or (PadColumnStyle = pcsPadHeaderAndData)
          then
          begin
            for tempCol := 0 to FixedCols - 1 do
            begin
              if (I < TitleOffset) or (tempCol < FIndicatorOffset) or
                ((Columns[tempCol - FIndicatorOffset].ColumnFlags
                [I - FTitleOffset] and wwDisableDrawBottomLine) = 0) then
              begin
                StartX := 0;
                if tempCol >= FIndicatorOffset then
                  StartX := CellRect(tempCol, I).Left;
                EndX := CellRect(tempCol, I).Right;

                Canvas.Pen.Color := LineColors.FixedColor;
                if (I >= TitleOffset) and not(dgHideBottomDataLine in Options)
                then
                  if (TitleOffset > 0) or (I < VisibleRowCount) then
                    Canvas.PolyLine([Point(StartX, Tempbottom),
                      Point(EndX, Tempbottom)]);

                Canvas.Pen.Color := LineColors.HighlightColor;

                if (I < VisibleRowCount) or
                  (PadColumnStyle = pcsPadHeaderAndData) then
                  Canvas.PolyLine([Point(StartX, Tempbottom + 1),
                    Point(EndX, Tempbottom + 1)]);

              end
            end
          end
        end
        else
        begin
          if (I >= TitleOffset) then
          // 7/16/02 - Missing 1st column fixed col horizontal line before
          begin
            if not(dgHideBottomDataLine in Options) then
            begin
              if (TitleOffset > 0) or (I < VisibleRowCount) then
                // 7/16/02
                Canvas.PolyLine([Point(0, Tempbottom),
                  Point(TempLeft, Tempbottom)])
            end
          end;

          Canvas.Pen.Color := LineColors.HighlightColor;
          if (I < VisibleRowCount) or (PadColumnStyle = pcsPadHeaderAndData)
          then
            Canvas.PolyLine([Point(0, Tempbottom + 1),
              Point(TempLeft2, Tempbottom + 1)]);
        end
      end;
    end;

    // Draw 3D - Vertical line in fixed area
    for I := 0 to FixedCols - 1 do
    begin
      if (dgColLinesDisableFixed in Options) then
        continue;
      if (IsCustomStyle) then
        continue;

      // 6/30/07 - Don't draw dark vertical line to the right of indicator column when themes are enabled
      if (UseThemesInTitle) then
      begin
        if (LineStyle = glsSingle) or
          ((LineStyle = glsDynamic) and (TwwCacheColInfoItem(FCacheColInfo[col])
          .IsWhiteBackground)) then
          Canvas.Pen.Color := LineColors.DataColor
        else
          Canvas.Pen.Color := LineColors.ShadowColor;
      end
      else
        Canvas.Pen.Color := LineColors.FixedColor;

      tempx := CellRect(I, 0).Right;
      if not(dgColLines in Options) then
        tempx := tempx - 1;
      if dgRowLines in Options then
        TempY := GetGridDataBottom(DrawInfo) - 1
      else
        TempY := GetGridDataBottom(DrawInfo);

      // 4/16/03 Start offset at bottom of grouping label in fixed area
      if dgTitles in Options then
      begin
        StartY := CellRect(I, 0).Bottom;
      end
      else
        StartY := 0;
      Canvas.PolyLine([Point(tempx + bidioffset, StartY),
        Point(tempx + bidioffset, TempY)]);
      Canvas.Pen.Color := LineColors.HighlightColor;
      Canvas.PolyLine([Point(tempx + 1 - bidioffset, StartY),
        Point(tempx + 1 - bidioffset, TempY)]);

      if (I = 0) and (dgIndicator in Options) then
      begin
        Canvas.Pen.Color := LineColors.HighlightColor;
        TempLeft := CellRect(I, 0).Left;
        Canvas.PolyLine([Point(TempLeft - bidioffset, 0),
          Point(TempLeft - bidioffset, TempY)]);
      end
    end;

  end;

  if (dgTitles in Options) and (not HideAllLines) then
  begin
    for I := 0 to LeftCol + VisibleColCount do
    begin
      if I >= ColCount then
        continue; // 5/22/01
      if UseThemesInTitle and (I >= FIndicatorOffset) then
        continue;
      if (I >= FixedCols) and (I < LeftCol) then
        continue;
      if UseThemesInTitle then
        continue; // 5/1/03 - Indicator column should not paint lines with themes

      TempLeft := CellRect(I, 0).Left;
      if (TempLeft = 0) and (I > LeftCol) then
        continue; // Special border case where inherited CellRect is wrong.
      Tempbottom := titleheight;

      if not(HaveAnyRowLines) then
        Tempbottom := Tempbottom - 1;

      tempx := CellRect(I, 0).Right;
      if not(dgColLines in Options) then
        tempx := tempx - 1;

      Canvas.Pen.Color := LineColors.HighlightColor;
      Canvas.PolyLine([Point(TempLeft + bidioffset, 0),
        Point(CellRect(I, 0).Right, 0)]);

      TempTop := 0;
      if (DbCol(I) >= 1) and (Columns[DbCol(I)].GroupName = Columns[DbCol(I - 1)
        ].GroupName) and (TitleCellRect(I, 0).Top <> 0) and
        (TitleCellRect(I - 1, 0).Top <> 0) then
      begin
        TempTop := TitleCellRect(I, 0).Top;
      end;

      Canvas.Pen.Color := LineColors.HighlightColor;
      Canvas.PolyLine([Point(TempLeft - bidioffset, TempTop),
        Point(TempLeft - bidioffset, Tempbottom)]);
      /// /***
      // Paint Title Group Headings and SubHeading Lines.
      FldName := FieldName(I);
      GroupName := '';
      if FldName <> '' then
        GroupName := ColumnByName(FldName).GroupName;

      if GroupName <> '' then
      begin
        TempTop := 0;
        if (DbCol(I) >= 0) and (TitleCellRect(I, 0).Top <> 0) then
        begin
          TempTop := TitleCellRect(I, 0).Top;
        end;
        curGroupName := GroupName;

        FldName := FieldName(I + 1); // Next field
        GroupName := '';
        if FldName <> '' then
          GroupName := ColumnByName(FldName).GroupName;

        if (GroupName = curGroupName) then
          GroupOffset := 1
        else
          GroupOffset := 0;
        Canvas.PolyLine([Point(TempLeft, 0),
          Point(CellRect(I, 0).Right + GroupOffset, 0)]);
        Canvas.PolyLine([Point(TempLeft, TempTop),
          Point(CellRect(I, 0).Right + GroupOffset, TempTop)]);
        Canvas.Pen.Color := LineColors.FixedColor;
        Canvas.PolyLine([Point(TempLeft, TempTop - 1),
          Point(CellRect(I, 0).Right + GroupOffset, TempTop - 1)]);

      end;
      TempTop := 0;
      if (I < ColCount - 1) and (curGroupName = GroupName) and
        (TitleCellRect(I, 0).Top <> 0) and (TitleCellRect(I + 1, 0).Top <> 0)
      then
      begin
        TempTop := TitleCellRect(I, 0).Top;
      end;
      Canvas.Pen.Color := LineColors.FixedColor;
      // Canvas.PolyLine([Point(TempX+bidiOffset, tempTop),
      // Point(TempX+bidiOffset, tempBottom)]);
      Canvas.PolyLine([Point(tempx, TempTop), Point(tempx, Tempbottom)]);
      if (I = ColCount - 1) then
      begin
        if (PadColumnStyle in [pcsPadHeaderAndData, pcsPadHeader])
{$IFNDEF GRIDESSENTIALS} or (PaintOptions.HaveBackgroundForDataCells){$ENDIF}
        then
        begin
          Canvas.Pen.Color := LineColors.HighlightColor;
          Canvas.PolyLine([Point(tempx + bidioffset, 0),
            Point(ClientWidth, 0)]);
        end;

        Canvas.Pen.Color := clBlack;
        Canvas.Pen.Color := LineColors.FixedColor;
        if (PadColumnStyle in [pcsPadHeader]) then
          Canvas.PolyLine([Point(tempx, Tempbottom), Point(ClientWidth,
            Tempbottom)]);
      end;

      Canvas.Pen.Color := LineColors.FixedColor;
      Canvas.PolyLine([Point(CellRect(I, 0).Left - 1, Tempbottom),
        Point(CellRect(I, 0).Right, Tempbottom)]);
      if ShowSearchRow and (I < inherited FixedCols) then
      begin
        Canvas.Pen.Color := LineColors.FixedColor;
        Canvas.PolyLine([Point(CellRect(I, 0).Left - 1, CellRect(I, 0).Bottom),
          Point(CellRect(I, 0).Right, CellRect(I, 0).Bottom)]);
        Canvas.PolyLine([Point(CellRect(I, 0).Right, TitleCellRect(I,
          0).Bottom), Point(CellRect(I, 0).Right, CellRect(I, 0).Bottom)]);
      end;
      if TitleButtons then
      begin
        // Canvas.Pen.Color:= clBtnShadow;
        Canvas.Pen.Color := LineColors.ShadowColor;
        if I <= DrawInfo.Horz.LastFullVisibleCell then
        // not last visible column
        begin
          if (TitleClickColumn < 0) or
            (SkipTitleButtonClick and (I <> TitleClickColumn)) then
          begin
            Canvas.PolyLine([Point(tempx - 1 + bidioffset, TempTop),
              Point(tempx - 1 + bidioffset, Tempbottom)]);
          end;
        end;
        Canvas.PolyLine([Point(CellRect(I, 0).Left - 1, Tempbottom - 1),
          Point(CellRect(I, 0).Right, Tempbottom - 1)]);
      end;

    end;

  end;

  if (DataLink = nil) or (not DataLink.Active) then
    Exit;

  // Draw OutsideGrid edges when either dgRowLines or dgColLines is not in Options.

  if (not HideAllLines) and (DrawInfo.Horz.LastFullVisibleCell = ColCount - 1)
  then
  begin
    Canvas.Pen.Color := LineColors.FixedColor;
    if (not(dgRowLines in Options)) or (not(dgColLines in Options)) then
      Canvas.PolyLine([Point(Right, 0), Point(Right, titleheight)]);
    if PadColumnStyle <> pcsPadHeaderAndData then
      if IsWhiteBackground then
        Canvas.Pen.Color := LineColors.DataColor
      else
        Canvas.Pen.Color := LineColors.ShadowColor; // clBtnShadow;

    TempTop := titleheight;
    if not(HaveAnyRowLines) then
      TempTop := TempTop - 1;
    if (PadColumnStyle <> pcsPlain) and
    // if (PadColumnStyle=pcsPadHeaderAndData) and
      ((not(dgRowLines in Options)) or (not(dgColLines in Options))) then
    begin
      Canvas.PolyLine([Point(Right, TempTop + 1), Point(Right, Bottom)]);
      // Canvas.pen.color:= clBtnHighlight;
      Canvas.Pen.Color := LineColors.HighlightColor;
      Canvas.PolyLine([Point(Right + 1, 0), Point(Right + 1, Bottom)])
    end;
  end;

  PaintClickedTitleButton;

  if not(IsCustomStyle) then
  begin

    // Draw area below data
    if (PadColumnStyle = pcsPadHeaderAndData) or
      (PaintOptions.HaveBackgroundForDataCells) then
    begin
      R.Bottom := ClientHeight;
      R.Left := 0;
      R.Top := GetGridDataBottom(DrawInfo);
      if (PadColumnStyle = pcsPadHeaderAndData) or
        (PaintOptions.HaveBackgroundForDataCells) then
        R.Right := ClientWidth
      else
        R.Right := CellRect(LeftCol, 0).Left;

      if RecordCountIsValid and (FDataLink.RecordCount > 0) and
        ((FDataLink.RecordCount - RowOffset - 1 + TitleOffset) <
        DrawInfo.Vert.LastFullVisibleCell) then
        R.Top := inherited CellRect(0, FDataLink.RecordCount - RowOffset +
          TitleOffset).Top;

      // Draw horizontal separator line above footer or empty bottom area
      Canvas.Pen.Color := LineColors.FixedColor;
      if (not HideAllLines) and (not UseThemesInTitle) then // 5/1/03
        Canvas.PolyLine([Point(R.Left, R.Top - 1),
          Point(CellRect(LeftCol, 0).Left, R.Top - 1)]);

      if IsWhiteBackground then
        Canvas.Pen.Color := LineColors.DataColor
      else
        Canvas.Pen.Color := LineColors.ShadowColor; // clBtnShadow;

      if not HideAllLines then
        Canvas.PolyLine([Point(CellRect(LeftCol, 0).Left, R.Top - 1),
          Point(Right, R.Top - 1)]);

      Canvas.Pen.Color := LineColors.HighlightColor;
      // Draw Left Pad Line
      if not HideAllLines then
      begin
        Canvas.PolyLine([Point(R.Left, R.Top),
          Point(R.Left, ClientHeight - 1)]);
        // Draw Bottom of Grid Pad Line
        Canvas.PolyLine([Point(R.Left, R.Top), Point(Right, R.Top)]);
      end;

      if not HideAllLines then
        R.Top := R.Top + 1;
      R.Left := R.Left + 1;
      if PadColumnStyle = pcsPadHeaderAndData then
        FillWithFixedBitmap(R, -1, TitleColor)
    end;
  end;
  Canvas.Pen.Color := OrigPenColor;
end;

procedure TwwCustomDBGrid.WMPaint(var Message: TWMPaint);

var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  PaintClipRect: TRect;
  R: TRect;
  customEdit: TWinControl;
  BitmapEmpty: boolean;
begin
  Windows.GetUpdateRect(Handle, UpdateRect, false);
  if not UseAlternateBuffering then
  begin
    if csPaintCopy in ControlState then
    begin
      BitmapEmpty := FPaintBitmap.Empty;
      inherited;
      if BitmapEmpty then
      begin
        FPaintBitmap.Free;
        FPaintBitmap := nil;
        FPaintBitmap := TBitmap.Create;
        FPaintCanvas := FPaintBitmap.Canvas;
      end;
    end
    else
      inherited;
    Exit;
  end;

  PaintClipRect := (inherited Canvas).ClipRect;

  if HaveAnyRowLines then
    UpdateRect.Top := UpdateRect.Top - 1;
  // 3/18/2002 - Make sure top line is drawn.

  if PaintClipRect.Right > ClientRect.Right then
    PaintClipRect.Right := ClientRect.Right;
  if UpdateRect.Bottom > ClientRect.Bottom then
    UpdateRect.Bottom := (inherited GetClientRect).Bottom;

  if (UpdateRect.Top = 0) and (UpdateRect.Bottom = 0) and (UpdateRect.Left = 0)
    and (UpdateRect.Right = 0) then
    UpdateRect := PaintClipRect;

  if (Message.DC <> 0) then
  begin
    if not(csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right,
      inherited GetClientRect.Bottom);
    ReleaseDC(0, DC);

    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Message.DC := MemDC;

      // 10/16/11 - Seems to reduce flicker in drop-down lookupcombo when using styles - enable for now
      if wwIsCustomStyle(Self) and wwIsClass(Self, 'TwwPopupGrid') then
      begin
        if TwwPopupGrid(Self).FirstPaint then
        begin
          Canvas.Brush.Color := ColorToRGB(StyleServices.GetStyleColor(scGrid));
          Windows.FillRect(DC, UpdateRect, Canvas.Brush.Handle);
          TwwPopupGrid(Self).FirstPaint := false;
        end
      end;

      if not(csCustomPaint in ControlState) and (ControlCount = 0) then
        inherited
      else
        PaintHandler(Message);
      Message.DC := 0;

      // Remove custom control from painting
      R := CellRect(col, row);
      R.Left := R.Left + 1;
      { Used to be +2, but richedit gray line would show after resizing }
      if FFocused and IsCustomEditCell(col, row, customEdit) and
        (not IsDropDownGridFocused) and (ShouldShowCustomControls) then
        BitBlt(MemDC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
          (inherited Canvas).Handle, R.Left, R.Top, SRCCOPY);

      // Leave current screen intact in pop-up grid area
      if not(csDesigning in ComponentState) and IsDropDownGridShowing then
      begin
        with TwwExpandButton(CurrentCustomEdit) do
        begin
          R := Rect(Grid.Left, Grid.Top, Grid.Left + Grid.Width,
            Grid.Top + Grid.Height);
          // FPaintCanvas.CopyRect(r, inherited Canvas, r);
          BitBlt(MemDC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
            (inherited Canvas).Handle, R.Left, R.Top, SRCCOPY);
        end
      end;

      BitBlt(DC, UpdateRect.Left, UpdateRect.Top,
        UpdateRect.Right - UpdateRect.Left, UpdateRect.Bottom - UpdateRect.Top,
        MemDC, UpdateRect.Left, UpdateRect.Top, SRCCOPY);
      EndPaint(Handle, PS);

    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

Function TwwCustomDBGrid.XIndicatorOffset: integer;
begin
  if dgIndicator in Options then
    result := 1
  else
    result := 0;
end;

procedure TwwCustomDBGrid.SetIndicatorColor(value: TIndicatorColorType);
begin
  if value = icYellow then
    IndicatorIconColor := clYellow
  else
    IndicatorIconColor := clBlack
end;

function TwwCustomDBGrid.GetCalcCellRow: integer;
begin
  result := FCalcCellRow;
end;

function TwwCustomDBGrid.GetSearchRowHeight: integer;
begin
  Canvas.Font := TitleFont;
  result := Canvas.TextHeight('W') + 2;
end;

function TwwCustomDBGrid.TitleCellRect(ACol, ARow: Longint;
  EntireTitle: boolean = false): TRect;

var
  FldName: string;
begin
  result := CellRect(ACol, ARow);
  if ShowSearchRow then
  begin
    Canvas.Font := TitleFont;
    result.Bottom := result.Bottom - GetSearchRowHeight;
  end;
  // Need to have rectangle be consistent, even if on right edge
  result.Right := result.Left + ColWidths[ACol];

  if DbCol(ACol) < 0 then
    Exit;

  // Need to take into account no fields, so need another way to find
  // fieldname
  FldName := FieldName(ACol);
  if (not EntireTitle) and (FldName <> '') and
    (ColumnByName(FldName).GroupName <> '') then
  begin
    result.Top := (result.Bottom - result.Top) div 2;
  end;
end;

function TwwCustomDBGrid.SearchCellRect(ACol, ARow: Longint): TRect;
// var
// FldName: string;
begin
  result := TitleCellRect(ACol, ARow, True);
  if ShowSearchRow then
  begin
    // Canvas.Font:= TitleFont;
    result.Top := result.Bottom;
    result.Bottom := CellRect(ACol, ARow).Bottom;
  end;

end;

function TwwCustomDBGrid.AdjustBoundsRect(ACurrentCustomEdit
  : TWinControl): boolean;
begin
  // !!!!   result:= wwIsClass(ACurrentCustomEdit.classType, 'TwwDataInspector');
  result := false;
end;

Procedure TwwCustomDBGrid.PaintActiveRowBackground(ACanvas: TCanvas;
  ARect: TRect);

var
  sourceRect: TRect;
  IsCustomStyle: boolean;
begin
  IsCustomStyle := wwIsCustomStyle(Self);
  sourceRect := CellRect(col, row);
  sourceRect.Right := sourceRect.Left + ARect.Right - ARect.Left;
  sourceRect.Bottom := sourceRect.Top + ARect.Bottom - ARect.Top;

  if (HaveAlternatingRowColor) and (DbRow(row) >= 0) and
    (odd(DbRow(row)) xor AlternatingEven) and
    ((col < FixedCols) and (arrFixedColumns
    in PaintOptions.AlternatingRowRegions) or (col >= FixedCols) and
    (arrDataColumns in PaintOptions.AlternatingRowRegions)) then
  begin
    if (not IsCustomStyle) and (PaintOptions.AlternatingColorBitmap <> nil) then
      ACanvas.CopyRect(ARect, PaintOptions.AlternatingColorBitmap.Canvas,
        sourceRect)
    else
    begin
      ACanvas.Brush.Color := PaintOptions.AlternatingRowColor;
      ACanvas.FillRect(ARect);
    end
  end
  else if (not IsCustomStyle) and PaintOptions.HaveBackgroundForDataCells then
  begin
    ACanvas.CopyRect(ARect, PaintOptions.OrigBitmap.Canvas, sourceRect);
  end
  else
  begin // 8/15/02 - Paint non-alternating active record
    if IsCustomStyle then
    begin
      // Don't call DrawCellBackground as it paints to the wrong canvas
      // Don't seem to actually need to paint background with themes
      // DrawCellBackground(ARect, ACanvas.Brush.Color, [], Col, Row)
    end
    else
    begin
      if HaveActiveRecordColor then
        ACanvas.Brush.Color := PaintOptions.ActiveRecordColor
      else
        ACanvas.Brush.Color := Color;
      ACanvas.FillRect(ARect);
    end;
  end;
end;

procedure TwwInplaceEdit.BoundsChanged;

var
  R: TRect;
  TopOffset, LeftOffset: integer;
  EditWidth: integer;
begin
  { if dgRowLines in ParentGrid.Options then inherited
    else } begin
    { Inplaceeditor is not correct position }
    if not(dgRowLinesDisableFixed in ParentGrid.Options) then
      TopOffset := 0
    else
      TopOffset := 1;

    EditWidth := Width;
    if ParentGrid.col < ParentGrid.LeftCol then
    begin
      if (dgColLinesDisableFixed in ParentGrid.Options) then
        LeftOffset := 1
      else
      begin
        LeftOffset := 0;
        if dgColLines in ParentGrid.Options then
          EditWidth := EditWidth - 1
        else
          EditWidth := EditWidth - 2
      end
    end
    else if dgColLines in ParentGrid.Options then
    begin
      LeftOffset := 1;
      EditWidth := EditWidth;
    end
    else
      LeftOffset := 1;

    // if TwwCustomDBGrid(Owner).UseRightToLeftAlignment then
    SetWindowPos(Handle, HWND_TOP, Left + 1 - LeftOffset, Top, EditWidth,
      Height, SWP_SHOWWINDOW or SWP_NOREDRAW);
    // else
    // SetWindowPos(Handle, HWND_TOP, Left+1-LeftOffset, Top,
    // EditWidth, Height,
    // SWP_SHOWWINDOW or SWP_NOREDRAW);
    R := Rect(1, 2 - TopOffset, Width - 2, Height);

    SendMessage(Handle, EM_SETRECTNP, 0, Longint(@R));
    SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  end
end;

procedure TwwCustomDBGrid.CalcSizingState(X, Y: integer; var State: TGridState;
  var Index: Longint; var SizingPos, SizingOfs: integer;
  var FixedInfo: TGridDrawInfo);

var
  gc: TGridCoord;
  StartCol, EndCol: integer;
  // accept:boolean;
begin
  State := gsNormal;

  if UseRightToLeftAlignment then
    gc := MouseCoord(X + 5, Y) // add 5 so gc.x is always previous column
  else
    gc := MouseCoord(X - 5, Y); // subtract 5 so gc.x is always previous column

  // Don't show sub-group sizing in group title
  if (dgTitles in Options) and (gc.Y = 0) then
  begin
    // Get group range, and must not be in middle columns
    GroupNameCellRect(gc.X, 0, StartCol, EndCol, false);
    if (gc.X >= FIndicatorOffset) and (Columns[DbCol(gc.X)].GroupName <> '')
    then
    begin
      if UseRightToLeftAlignment then
      begin
        if (gc.X < EndCol) and (gc.X >= StartCol) and
          (Y < TitleCellRect(gc.X, gc.Y).Top) then
          Exit;
      end
      else
      begin
        if (gc.X < EndCol) and (gc.X >= StartCol) and
          (Y < TitleCellRect(gc.X, gc.Y).Top) then
          Exit;
      end;
    end;
  end;

  // Don't show sub-group sizing in group title
  if (IsProportionalColumns) and (gc.Y < FTitleOffset) and
    ((gc.X = ColCount - 1) or (gc.X < 0)) then
    Exit;

  { // !!!! - Uncomment to allow onAllowColResize event.
    if (Assigned(FOnAllowColResize)) then begin
    try
    accept := true;
    FOnAllowColResize(Self, gc.x, accept);
    if not accept then exit;
    except
    exit;
    end;
    end;
  }

  inherited;
end;

Function TwwCustomDBGrid.HaveAnyRowLines;
begin
  result := (dgRowLines in Options) or not(dgRowLinesDisableFixed in Options);
end;

procedure TwwCustomDBGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  if parent is TCustomGrid then
  begin
    // Params.Style := WS_POPUP or WS_BORDER;
    // Params.ExStyle := WS_EX_TOOLWINDOW;
    // Params.Style:= Params.Style + WS_POPUP;
    // Params.ExStyle := WS_EX_TOOLWINDOW;
    // Params.Style:= Params.Style + WS_EX_TOOLWINDOW
  end;

end;

procedure TwwCustomDBGrid.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
end;

// Returns just rectangle for control.  Do not return whole rectangle, as
// we wish to leave this area unpainted when record is expanded.
Function TwwCustomDBGrid.CellRect(ACol, ARow: integer): TRect;
begin
  result := inherited CellRect(ACol, ARow);
  // Empty rectangle so don't modify
  if result.Left + result.Right + result.Top + result.Bottom = 0 then
    Exit;

  // 4/9/01 - Need to have rectangle be consistent, even if on right edge
  result.Right := result.Left + ColWidths[ACol];

  if DbRow(ARow) < 0 then
    Exit;

  result.Bottom := result.Top + DefaultRowHeight;
end;

Function TwwCustomDBGrid.IsDropDownGridFocused: boolean;

var
  Control: TWinControl;
begin
{$IFDEF GRIDESSENTIALS}
  result := false;
{$ELSE}
  result := IsDropDownGridShowing;
  if result then
  begin
    Control := TwwExpandButton(CurrentCustomEdit).Grid;
    if Control is TwwDBGrid then
    begin
      if not TwwDBGrid(Control).FFocused then
        result := false
    end
    else
    begin
      result := (Control <> nil) and (Control.HandleAllocated) and
        (IsChild(Control.Handle, GetFocus) or
        // 7/25/02 - Return true if control (i.e. inspector) has focus
        // Fixes bug where drop-down inspector would close-up in some cases
        // when arrowing at last or first
        (Control.Handle = GetFocus))
    end;
  end
{$ENDIF}
end;

Function TwwCustomDBGrid.IsDropDownGridShowing: boolean;
begin
  result := false;
  if (CurrentCustomEdit = nil) then
    Exit;
  if not wwIsClass(CurrentCustomEdit, 'TwwExpandButton') then
    Exit;
  if TwwExpandButton(CurrentCustomEdit).Grid = nil then
    Exit;
  result := TwwExpandButton(CurrentCustomEdit).Grid.Visible;
end;

Function TwwCustomDBGrid.ActiveExpandButton: TWinControl;
begin
  result := nil;
{$IFNDEF GRIDESSENTIALS}
  if (CurrentCustomEdit = nil) then
    Exit;
  if not(CurrentCustomEdit is TwwExpandButton) then
    Exit;
  result := CurrentCustomEdit;
{$ENDIF}
end;

procedure TwwCustomDBGrid.CollapseChildGrid;
{$IFNDEF GRIDESSENTIALS}
var
  I: integer;
  expandButton: TwwExpandButton;
{$ENDIF}
begin
{$IFNDEF GRIDESSENTIALS}
  for I := 0 to ControlCount - 1 do
  begin
    if (Controls[I] is TwwExpandButton) then
    begin
      expandButton := TwwExpandButton(Controls[I]);
      if expandButton.InToggle then
        Exit;

      if (expandButton.Grid <> nil) and (expandButton.Grid.Visible) then
      begin
        // 5/9/2002 - PYW - Need to handle exception or hook raises it and it closes form.
        try
          if expandButton.Expanded then
          begin
            expandButton.Expanded := false;
          end
          else
          begin
            expandButton.Expanded := false;
            expandButton.Click; // Force our code to execute for expand/collapse
          end;
          break;
        except
        end;
      end
    end
  end;
{$ENDIF}
end;

// Updates CurrentCustomEdit manually
// This prevents flicker when calling from MouseDown so that
// we don't paint expand button before moving to the child grid.
procedure TwwCustomDBGrid.UpdateCustomEdit;

var
  customEdit: TWinControl;
  OrigRect, TempRect: TRect;
begin
  if IsCustomEditCell(col, row, customEdit) and
    (ShouldShowCustomControls or wwIsClass(customEdit, 'TwwExpandButton')) then
  // (not (ecoDisableCustomControls in EditControlOptions)) and
  // (canEditGrid or AlwaysShowControls) and
  // not (csDesigning in ComponentState) and
  // not (dgRowSelect in Options) then
  begin
    CurrentCustomEdit := customEdit;
    with Canvas do
    begin
      if (not(csDesigning in ComponentState)) then
      begin
        if (CurrentCustomEdit <> Nil) and (CurrentCustomEdit.parent = Self) then
        begin
          TempRect := CellRect(col, row);
          OrigRect := TempRect;
          if
          // 5/18/01 - Top check required as we are left/right already accurate from ColEnter updating
            (CurrentCustomEdit.BoundsRect.Top <> TempRect.Top) or
            (CurrentCustomEdit.BoundsRect.Left <> TempRect.Left) or
            (CurrentCustomEdit.BoundsRect.Right <> TempRect.Right) then
          begin
            if Columns[DbCol(col)].DisableSizing then
            begin
              if TempRect.Right - TempRect.Left < CurrentCustomEdit.Width then
                TempRect.Right := TempRect.Left + CurrentCustomEdit.Width;
              if TempRect.Bottom - TempRect.Top < CurrentCustomEdit.Height then
                TempRect.Bottom := TempRect.Top + CurrentCustomEdit.Height;
              if TempRect.Top + CurrentCustomEdit.Height > parent.ClientHeight
              then
              begin
                TempRect.Top := OrigRect.Bottom - CurrentCustomEdit.Height;
                TempRect.Bottom := OrigRect.Bottom;
              end;
            end;

            if (Canvas.CanvasOrientation = coRightToLeft) then
            { 9/25/98 - Support bidi mode }
            begin
              TempRect.Right := ClientWidth - TempRect.Left;
              TempRect.Left := TempRect.Right -
                (TempRect.Right - TempRect.Left) + 1;
            end;

            CurrentCustomEdit.BoundsRect := TempRect;
          end
        end
      end;
    end;
  end;
end;

function TwwCustomDBGrid.IsAlternatingRow(DbRow: integer): boolean;
begin
  if AlternatingEven then
  begin
    result := not odd(DbRow)
  end
  else
  begin
    result := odd(DbRow)
  end;
end;

function TwwCustomDBGrid.IsActiveRowAlternatingColor: boolean;
begin
  if AlternatingEven then
  begin
    result := not odd(DbRow(row))
  end
  else
  begin
    result := odd(DbRow(row))
  end;
end;

procedure TwwCustomDBGrid.SetRowOffset(value: integer);
begin
  // FRowOffset:= Value;
  // if odd(FRowOffset) then AlternatingEven:= not AlternatingEven
  if (odd(value) and (not odd(FRowOffset))) or
    (not odd(value) and (odd(FRowOffset))) then
    AlternatingEven := not AlternatingEven;
  FRowOffset := value;
  // Showmessage('Exception');
end;

procedure TwwCustomDBGrid.CalcDrawInfo(var DrawInfo: TGridDrawInfo);
begin
  inherited CalcDrawInfo(DrawInfo);
  // DrawInfo.Vert.FullVisBoundary:= CellRect(0, DrawInfo.Vert.LastFullVisibleCell).Bottom + 1;
  if (RowOffset > 0) then
  begin
    // DrawInfo.Vert.LastFullVisibleCell:=
    // FDataLink.RecordCount-DataLink.ActiveRecord-1;
    // FDataLink.RecordCount - RowOffset -1;
    // DrawInfo.Vert.FullVisBoundary:= CellRect(0, DrawInfo.Vert.LastFullVisibleCell).Bottom + 1;
  end;

end;

function TwwCustomDBGrid.HasFocus: boolean;
// Return true if we or a child of us has the focus;
begin
  result := FFocused;
end;

procedure TwwCustomDBGrid.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
end;

function TwwCustomDBGrid.GroupNameCellRect(ACol, ARow: Longint;
  var StartCol, EndCol: Longint; VisibleOnly: boolean = True): TRect;

var
  // ACursor : TPoint;
  GroupLeft, GroupRight: integer;
  I: integer;
  StartIndex, lastindex: integer;
  GroupName: string;
  lineWidth: integer;
begin
  result := CellRect(ACol, 0);
  if ShowSearchRow then
  begin
    Canvas.Font := TitleFont;
    result.Bottom := result.Bottom - GetSearchRowHeight;
  end;
  StartCol := ACol;
  EndCol := ACol;
  if DbCol(ACol) < 0 then
    Exit;

  GroupName := Columns[DbCol(ACol)].GroupName;

  if GroupName <> '' then
  begin

    // Only go as far as the Left Visible Column.
    if VisibleOnly then
    begin
      StartIndex := LeftCol;
      lastindex := LeftCol + VisibleColCount;
    end
    else
    begin
      StartIndex := FIndicatorOffset;
      lastindex := ColCount - 1;
    end;

    StartCol := ACol;
    for I := ACol - 1 downto StartIndex do
    begin
      if Columns[DbCol(I)].GroupName = GroupName then
        StartCol := I
      else
        break;
    end;
    EndCol := ACol;
    for I := ACol + 1 to lastindex do
    begin
      if Columns[DbCol(I)].GroupName = GroupName then
        EndCol := I
      else
        break;
    end;

    if dgColLines in Options then
      lineWidth := 1
    else
      lineWidth := 0;

    if StartCol < LeftCol then
    begin
      GroupLeft := CellRect(LeftCol, 0).Left;
      GroupRight := GroupLeft;
      // 1/22/04 - Start scanning from last fixed column instead of non-fixed column before leftcol
      for I := FixedCols - FIndicatorOffset downto StartCol do
      // for i:= LeftCol-1 downto StartCol do
      begin
        GroupLeft := GroupLeft - ColWidths[I] - lineWidth;
      end;
      for I := LeftCol to EndCol do
      begin
        GroupRight := GroupRight + ColWidths[I] + lineWidth;
      end;

      { GroupRight:= CellRect(EndCol, 0).Right;
        GroupLeft:= GroupRight+LineWidth;
        for i:= EndCol downto StartCol do begin
        GroupLeft:= GroupLeft - ColWidths[i] - LineWidth;
        end;
      }
    end
    else
    begin
      GroupLeft := CellRect(StartCol, 0).Left;
      GroupRight := GroupLeft - lineWidth;
      for I := StartCol to EndCol do
      begin
        GroupRight := GroupRight + ColWidths[I] + lineWidth;
      end;
    end;
    result := Rect(GroupLeft, result.Top, GroupRight,
      result.Top + ((result.Bottom - result.Top) div 2));
  end;
end;

function TwwCustomDBGrid.DragTitleCellRect(ACol, X, Y: Longint): TRect;

var
  curField: TField;
  // DrawInfo: TGridDrawInfo;
  // curGroupName:String;
  StartCol, EndCol: integer;
begin
  if not(dgTitles in Options) then
  begin
    result := Rect(0, 0, 0, 0);
    Exit;
  end;

  result := CellRect(ACol, 0);
  // Only concerned about the active column's title.
  if DbCol(ACol) < 0 then
    Exit; // Exit if the current col is < 0

  if ShowSearchRow then
  begin
    Canvas.Font := TitleFont;
    result.Bottom := result.Bottom - GetSearchRowHeight;
  end;

  // Get activefield and the associated groupname to see if the current column being dragged
  // is a subgroup or the grouptitle and returns the effective drag rectangle.
  curField := Fields[DbCol(ACol)];
  if (curField <> nil) and (ColumnByName(curField.FieldName).GroupName <> '')
  then
  begin
    if Y < result.Top + ((result.Bottom - result.Top) div 2) then
    begin
      // Clicked on GroupTitle so need to get the effective drag rectangle that contains the entire rectangle.
      result := GroupNameCellRect(ACol, 0, StartCol, EndCol, false);
      // RSW!
      if ShowSearchRow then
      begin
        result.Bottom := CellRect(ACol, 0).Bottom - Canvas.TextHeight('W');
      end
      else
        result.Bottom := CellRect(ACol, 0).Bottom;
    end
    else
      result.Top := (result.Bottom - result.Top) div 2;
  end;
end;

procedure TwwCustomDBGrid.ShowEditor;
begin
  // if (TwwCacheColInfoItem(FCacheColInfo[Col]).ControlType='URL-Link') and
  if (ecoDisableEditorIfReadOnly in EditControlOptions) and
    Columns[col - FIndicatorOffset].ReadOnly then
    Exit;
  inherited ShowEditor;

end;

(*
  procedure TwwCustomDBGrid.TopLeftMoved(const OldTopLeft: TGridCoord);
  var DrawInfo: TGridDrawInfo;
  begin
  CalcDrawInfo(DrawInfo);
  // Fix case where inherited grid gets confused on fixed columns
  if LeftCol<DrawInfo.Horz.FixedCellCount then
  begin
  LeftCol:= DrawInfo.Horz.FixedCellCount;
  Invalidate;
  sysutils.Abort;
  end;
  inherited;
  end;
*)

function TwwCustomDBGrid.CanEditGrid: boolean;
begin
  result := (dgEditing in Options) and (not ReadOnly)
end;

procedure TwwCustomDBGrid.ResetTitleClick;
begin
  // MouseOverGroupTitle := False;
  TitleClickGroupTitle := false;
  TitleClickColumn := -1;
  TitleClickRow := -1;
end;

Function TwwCustomDBGrid.FieldName(ACol: integer): string;

var
  APos: integer;
  Field: TField;
begin
  result := '';
  if (DataLink <> nil) and (DataLink.Active) then
  begin
    Field := GetColField(DbCol(ACol));
    if (Field = nil) then
      Exit;
    result := Field.FieldName;
  end
  else
  begin
    APos := 1;
    if DbCol(ACol) < 0 then
      Exit;
    if DbCol(ACol) >= Selected.Count then
      Exit;
    result := strGetToken(Selected[DbCol(ACol)], #9, APos);
  end;
end;

procedure TwwCustomDBGrid.CMMouseLeave(var Message: TMessage);
begin
  ClearURLPaint;
  if (titleLastMouseX >= 0) and (titleLastMouseY = 0) then
  begin
    InvalidateCell(titleLastMouseX, titleLastMouseY);
    if MouseOverGroupTitle then
      InvalidateTitle;
  end;
  titleLastMouseX := -1;
  titleLastMouseY := -1;

  inherited;
end;

procedure TwwCustomDBGrid.RestoreRowHeights;
begin
  FRowHeightPercent := MinRowHeightPercent;
  LayoutChanged;
end;

Function TwwCustomDBGrid.IsProportionalColumns: boolean;
begin
  result := (not UseTFields) and (dgProportionalColResize in Options)
end;

procedure TwwCustomDBGrid.SetUseTFields(val: boolean);
begin
  if FUseTFields <> val then
  begin
    FUseTFields := val;
    ResetProportionalWidths;
    LayoutChanged;
  end;
end;

procedure TwwCustomDBGrid.GetURLLink(value: string;
  var URLDisplayString: string; var URLLinkAddress: string);

var
  APos: integer;
begin
  APos := 1;
  URLDisplayString := strGetToken(value, '#', APos);
  URLLinkAddress := strGetToken(value, '#', APos);
  if URLLinkAddress = '' then
    URLLinkAddress := URLDisplayString;
end;

Function TwwCustomDBGrid.ShouldShowCustomControls: boolean;
begin
  result := (not(ecoDisableCustomControls in EditControlOptions)) and
    (CanEditGrid or AlwaysShowControls or

    // 11/24/02 - If AlwaysPaints then show custom control even if
    // can't edit grid
    ((col < FCacheColInfo.Count) and TwwCacheColInfoItem(FCacheColInfo[col])
    .AlwaysPaints))

    and not(csDesigning in ComponentState) and not(dgRowSelect in Options);
end;

procedure TwwCustomDBGrid.ResetProportionalWidths;
begin
  if OrigColWidths <> nil then
    FreeMem(OrigColWidths);
  OrigColWidths := nil;
end;

Function TwwCustomDBGrid.GetHighlightColor: TColor;
begin
{$IFNDEF GRIDESSENTIALS}
  if (HaveActiveRecordColor) then
    result := PaintOptions.ActiveRecordColor
  else {$ENDIF}
    result := clHighlight;

end;

procedure TwwCustomDBGrid.AddField(FieldName: string; Position: integer = -1;
  Redraw: boolean = True);

var
  APos: integer;
  Found: boolean;
  TempFieldName, TempStr: string;
  curField: TField;
  I: integer;
  addColumn: TwwColumn;
begin
  if false and UseTFields then
  // 3/31/11 - Make the usetfields case be the same as the (not usetfields case)
  // This fixes a problem where the end-user removes a field, adds it back in, and then removes it again.
  begin
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    begin
      curField := DataSource.DataSet.FindField(FieldName);
      if curField <> nil then
      begin
        curField.Visible := True;
        curField.Index := Position;
        // 10/18/10 - Position not being set before with usetfields=true
      end;
    end
  end
  else
  begin
    Found := false;
    for I := 0 to Selected.Count - 1 do
    begin
      APos := 1;
      TempFieldName := strGetToken(Selected[I], #9, APos);
      if wwEqualStr(TempFieldName, FieldName) then
      begin
        // found:= true;
        Exit;
      end;
    end;
    if not Found then
    begin
      // curField := nil;
      addColumn := ColumnByName(FieldName);
      if addColumn <> DummyColumn then
      begin
        TempStr := FieldName + #9 + inttostr(addColumn.DisplayWidth) + #9 +
          addColumn.DisplayLabel

      end
      else if (DataSource <> nil) and (DataSource.DataSet <> nil) then
      begin
        curField := DataSource.DataSet.FindField(FieldName);
        if curField <> nil then
          TempStr := FieldName + #9 + inttostr(curField.DisplayWidth) + #9 +
            curField.DisplayLabel
        else
          TempStr := FieldName + #9 + '10' + #9 + FieldName;
      end;
      if Position >= 0 then
      begin
        if (Position >= Selected.Count) then
          Selected.Add(TempStr)
        else
          Selected.Insert(wwmin(Position, Selected.Count), TempStr)
      end
      else
        Selected.Add(TempStr);
      if Redraw then
        ApplySelected;
    end
  end
end;

procedure TwwCustomDBGrid.RemoveField(FieldName: string;
  Redraw: boolean = True);

var
  APos: integer;
  TempFieldName: string;
  curField: TField;
  I: integer;
begin
  if UseTFields then
  begin
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    begin
      curField := DataSource.DataSet.FindField(FieldName);
      if curField <> nil then
        curField.Visible := false;
    end
  end
  else
  begin
    for I := 0 to Selected.Count - 1 do
    begin
      APos := 1;
      TempFieldName := strGetToken(Selected[I], #9, APos);
      if wwEqualStr(TempFieldName, FieldName) then
      begin
        Selected.Delete(I);
        if Redraw then
          ApplySelected;
        Exit;
      end
    end;
  end
end;

procedure TwwCustomDBGrid.ApplySelected;
begin
end;

function TwwCustomDBGrid.GetGridDataBottom(DrawInfo: TGridDrawInfo): integer;

var
  Temp: integer;
begin
  // temp := DrawInfo.Vert.FullVisBoundary;
  Temp := inherited CellRect(LeftCol, DrawInfo.Vert.LastFullVisibleCell)
    .Bottom + 1;
  result := Temp;
end;

function TwwCustomDBGrid.CalcCoordFromPoint(X, Y: integer;
  const DrawInfo: TGridDrawInfo): TGridCoord;

  function DoCalc(const AxisInfo: TGridAxisDrawInfo; N: integer): integer;

  var
    I, Start, Stop: Longint;
    line: integer;
  begin
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop := FixedCellCount - 1;
        line := 0;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        line := FixedBoundary;
      end;
      result := -1;
      for I := Start to Stop do
      begin
        Inc(line, GetExtent(I) + EffectiveLineWidth);
        if N < line then
        begin
          result := I;
          Exit;
        end;
      end;
    end;
  end;

  function DoCalcRightToLeft(const AxisInfo: TGridAxisDrawInfo;
    N: integer): integer;

  var
    I, Start, Stop: Longint;
    line: integer;
  begin
    N := ClientWidth - N;
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop := FixedCellCount - 1;
        line := 0;
        // Line := ClientWidth;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        line := FixedBoundary;
      end;
      result := -1;
      for I := Start to Stop do
      begin
        Inc(line, GetExtent(I) + EffectiveLineWidth);
        if N < line then
        begin
          result := I;
          Exit;
        end;
      end;
    end;
  end;

begin
  if not UseRightToLeftAlignment then
    result.X := DoCalc(DrawInfo.Horz, X)
  else
    result.X := DoCalcRightToLeft(DrawInfo.Horz, X);
  result.Y := DoCalc(DrawInfo.Vert, Y);
end;

function TwwCustomDBGrid.MouseCoord(X, Y: integer): TGridCoord;

var
  DrawInfo: TGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  result := CalcCoordFromPoint(X, Y, DrawInfo);
  if result.X < 0 then
    result.Y := -1
  else if result.Y < 0 then
    result.X := -1;
end;

function TwwCustomDBGrid.GetPriorRecordText(AFieldName: string;
  var AText: string): boolean;

var
  TempRecord: integer;
  tempField: TField;
begin
  result := false;
  AText := '';
  if FDataLink.ActiveRecord <= 0 then
    Exit;
  if (DataSource = nil) or (DataSource.DataSet = nil) or
    (not DataSource.DataSet.Active) then
    Exit;

  TempRecord := FDataLink.ActiveRecord;
  FDataLink.ActiveRecord := FDataLink.ActiveRecord - 1;

  try
    begin
      tempField := DataSource.DataSet.FindField(AFieldName);
      if tempField = nil then
        Exit;

      if tempField <> nil then
      begin
        AText := tempField.asstring;
        result := True;
      end
    end
  finally
    FDataLink.ActiveRecord := TempRecord;
  end
end;

function TwwCustomDBGrid.GetNextRecordText(AFieldName: string;
  var AText: string): boolean;

var
  TempRecord: integer;
  tempField: TField;
begin
  AText := '';
  result := false;
  if (DataSource = nil) or (DataSource.DataSet = nil) or
    (not DataSource.DataSet.Active) then
    Exit;

  if FDataLink.ActiveRecord < 0 then
    Exit;
  if FDataLink.ActiveRecord >= FDataLink.RecordCount - 1 then
    Exit;

  TempRecord := FDataLink.ActiveRecord;
  FDataLink.ActiveRecord := FDataLink.ActiveRecord + 1;

  try
    begin
      tempField := DataSource.DataSet.FindField(AFieldName);
      if tempField = nil then
        Exit;

      if tempField <> nil then
      begin
        AText := tempField.asstring;
        result := True;
      end
    end;
  finally
    FDataLink.ActiveRecord := TempRecord;
  end;
end;

Procedure TwwCustomDBGrid.AutoSizeColumn(ACol: integer);
var
  I, priorrecord: integer;
  str: String;
  MaxWidth, tempMaxWidth: integer;
begin
  str := '';
  priorrecord := DataLink.ActiveRecord;

  MaxWidth := 0;
  for I := 0 to VisibleRowCount - 1 do
  begin
    DataLink.ActiveRecord := I;
    str := DataSource.DataSet.fieldByName(Columns[ACol - FIndicatorOffset]
      .FieldName).DisplayText;
    tempMaxWidth := Canvas.TextWidth(str);
    if tempMaxWidth > MaxWidth then
      MaxWidth := tempMaxWidth;
  end;
  MaxWidth := MaxWidth + 4;

  DataLink.ActiveRecord := priorrecord;
  if MaxWidth > ColWidthsPixels[ACol] then // Growing
  begin
    // Previously already more than max width so ignoer
    if ColWidths[ACol] > (Width div 2) then
      Exit;
    if MaxWidth > (Width div 2) then
      Exit;

    Columns[ACol - FIndicatorOffset].DisplayWidth :=
      MaxWidth div Canvas.TextWidth('0');
  end
  else
  begin
    Columns[ACol - FIndicatorOffset].DisplayWidth :=
      MaxWidth div Canvas.TextWidth('0');
  end;
end;

function TwwCustomDBGrid.GetGroupFieldName: string;
begin
  result := FGroupFieldName
end;

procedure TwwCustomDBGrid.SetShowSearchRow(value: boolean);
begin
  FShowSearchRow := value;
  LayoutChanged;
end;

procedure TwwCustomDBGrid.SetGroupFieldName(value: string);
var
  I: integer;
begin
  if FGroupFieldName <> value then
  begin
    FGroupFieldName := value;
    If value = '' then
    begin
      if Columns[0].ColumnFlags <> nil then
        for I := 0 to 255 do
          Columns[0].ColumnFlags[I] := 0;
    end;
    Invalidate;
  end
end;

Procedure TwwCustomDBGrid.WriteTextLines(ACanvas: TCanvas; const ARect: TRect;
  DX, DY: integer; s: PWideChar; Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions);
var
  NonWideStr: string;
begin
  NonWideStr := s;
  if not wwUseThemes(Self) then
    WriteOptions := WriteOptions + [wtoDisableThemes];
  wwWriteTextLines(ACanvas, ARect, DX, DY, PChar(NonWideStr), Alignment,
    WriteOptions);
end;

Procedure TwwCustomDBGrid.WriteTitleLines(ACanvas: TCanvas; const ARect: TRect;
  DX, DY: integer; s: PWideChar; Alignment: TAlignment;
  WriteOptions: TwwWriteTextOptions);
var
  NonWideStr: string;
begin
  NonWideStr := s;
  WriteOptions := WriteOptions + [wtoIsTitle];
  if not UseThemesInTitle then
    WriteOptions := WriteOptions + [wtoDisableThemes];
  wwWriteTextLines(ACanvas, ARect, DX, DY, PChar(NonWideStr), Alignment,
    WriteOptions);
end;

Procedure TwwCustomDBGrid.GridUpdateData;
begin
  // UpdateData;
end;

procedure TwwCustomDBGrid.Sort(FieldName: string; descending: boolean);
var
  DataSet: TDataSet;
  DoDefault: boolean;
begin

  if Assigned(FOnBeforeSort) then
  begin
    DoDefault := false;
    try
      begin
        FOnBeforeSort(Self, FieldName, descending, DoDefault);
      end;
    finally
    end;
    if not DoDefault then
      Exit;
  end;

  if DataSource = nil then
    Exit;
  DataSet := DataSource.DataSet;
  if DataSet = nil then
    Exit;

  wwDataSetSort(DataSet, FieldName, descending, sfoCreateIndexes
    in Self.TitleMenuAttributes.Options);

  if Assigned(FOnAfterSort) then
  begin
    try
      begin
        FOnAfterSort(Self, FieldName, descending);
      end;
    finally
    end;
  end;

end;

procedure TwwGridLineColors.SetDataColor(val: TColor);
begin
  FDataColor := val;
  FGrid.Invalidate;
end;

procedure TwwGridLineColors.SetHighlightColor(val: TColor);
begin
  FHighlightColor := val;
  FGrid.Invalidate;
end;

procedure TwwGridLineColors.SetShadowColor(val: TColor);
begin
  FShadowColor := val;
  FGrid.Invalidate;
end;

procedure TwwGridLineColors.SetFixedColor(val: TColor);
begin
  FFixedColor := val;
  FGrid.Invalidate;
end;

procedure TwwGridLineColors.SetGroupingColor(val: TColor);
begin
  FGroupingColor := val;
  FGrid.Invalidate;
end;

procedure TwwCustomDBGrid.DoInitSelectColumnsDialog(Form: TCustomForm);
var
  I: integer;
  DataSet: TDataSet;
  node: TwwSelectColumnsTreeNode;
  Column: TwwColumn;
  NodeGroups: string;
  canAdd: boolean;
  curNode, parentNode: TwwSelectColumnsTreeNode;
  TreeView: TwwSelectColumnsTreeView;
  DoDefault: boolean;
begin
  TreeView := (Form as TwwGridSelectColumnsForm).TreeView1;
  TreeView.Grid := Self;

  DoDefault := True;
  if Assigned(FOnInitSelectColumnsDialog) then
    FOnInitSelectColumnsDialog(Form, TreeView, DoDefault);
  if not DoDefault then
    Exit;

  if (DataSource = nil) or (DataSource.DataSet = nil) then
    Exit;

  DataSet := DataSource.DataSet;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Column := ColumnByName(DataSet.Fields[I].FieldName);
    if not Column.Visible then
    begin
      DoOnAddSelectColumn(DataSet.Fields[I], NodeGroups, canAdd);
      if canAdd then
      begin
        if NodeGroups <> '' then
        begin
          curNode := TwwSelectColumnsTreeNode(TreeView.TopItem);
          parentNode := nil;
          while (curNode <> nil) do
          begin
            if curNode.IsCategory and wwEqualStr(curNode.Text, NodeGroups) then
            begin
              parentNode := curNode;
              break;
            end;
            curNode := curNode.getNextSibling as TwwSelectColumnsTreeNode;
          end;
          if (parentNode <> nil) then
          begin
            node := TwwSelectColumnsTreeNode(TreeView.Items.AddChild(parentNode,
              DataSet.Fields[I].DisplayLabel));
            node.FieldName := DataSet.Fields[I].FieldName;
            node.CheckboxType := wwtvctCheckbox;
          end
          else
          begin
            parentNode := TwwSelectColumnsTreeNode
              (TreeView.Items.Add(nil, NodeGroups));
            parentNode.IsCategory := True;
            parentNode.StateIndex := -1;
            parentNode.CheckboxType := wwtvctCheckbox;
            node := TwwSelectColumnsTreeNode(TreeView.Items.AddChild(parentNode,
              DataSet.Fields[I].DisplayLabel));
            node.FieldName := DataSet.Fields[I].FieldName;
            node.CheckboxType := wwtvctCheckbox;
          end;
          TreeView.Options := TreeView.Options + [wwtvoShowRoot];
        end
        else
        begin
          node := TwwSelectColumnsTreeNode(TreeView.Items.Add(nil,
            DataSet.Fields[I].DisplayLabel));
          node.FieldName := DataSet.Fields[I].FieldName;
          node.CheckboxType := wwtvctCheckbox;
        end;
      end;
    end;

    // checklistbox1.items.add( dataSet.Fields[i].Displaylabel);
  end;

  if ((TreeView.SortType in [wwtstData, wwtstBoth]) and
    Assigned(TreeView.OnCompare)) or
    (TreeView.SortType in [wwtstText, wwtstBoth]) then
    TreeView.AlphaSort; // (True)
end;

function TwwCustomDBGrid.ExecuteSelectGridColumnsDialog(curField: string;
  insertBefore: boolean = True): boolean;
var
  Form: TwwGridSelectColumnsForm;
  catChildNode, node: TwwSelectColumnsTreeNode;
begin
  Form := TwwGridSelectColumnsForm.Create(Self);
  with Form do
  begin
    DoInitSelectColumnsDialog(Form);

    result := Form.ShowModal = mrOK;
    if result then
    begin
      node := TreeView1.TopItem as TwwSelectColumnsTreeNode;
      while (node <> nil) do
      begin
        if (not node.IsCategory) and node.Checked then
        begin
          if insertBefore then
            ColumnByName(curField).InsertBeforeColumn(node.FieldName)
          else
            ColumnByName(curField).InsertAfterColumn(node.FieldName)
        end;

        if (node.IsCategory) and node.Checked then
        begin
          catChildNode := node.GetFirstChild as TwwSelectColumnsTreeNode;

          // Add all children of category node
          while catChildNode <> nil do
          begin
            if insertBefore then
              ColumnByName(curField).InsertBeforeColumn(catChildNode.FieldName)
            else
              ColumnByName(curField).InsertAfterColumn(catChildNode.FieldName);
            catChildNode := catChildNode.getNextSibling as
              TwwSelectColumnsTreeNode;
          end;
        end;

        node := node.getNextSibling as TwwSelectColumnsTreeNode;

      end;
    end;

    Free;
  end;
end;

procedure TwwCustomDBGrid.DoOnAddSelectColumn(Field: TField;
  var NodeGroups: string; var canAdd: boolean);
begin
  canAdd := True;
  NodeGroups := '';
  if Assigned(OnAddSelectColumn) then
  begin
    FOnAddSelectColumn(Self, Field, NodeGroups, canAdd);
  end;
end;

procedure TwwCustomDBGrid.ShowPopupEditor(Column: TwwColumn; X, Y: integer);
var
  SubGrid: TwwCustomDBGrid;
  DS: TDataSource;
  I: integer;
  FloatRect: TRect;
  CMP: TControl;
  Fld: TField;
begin
  if (DataSource = nil) or (DataSource.DataSet = nil) then
    Exit;

  with DataSource.DataSet do
    Fld := fieldByName(Column.FieldName);
  if not((Fld <> nil) and (Fld is TDataSetField)) then
    Exit;

  // find existing popup for this column field, if any, and show it
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TwwCustomDBGrid then
    begin
      SubGrid := TwwCustomDBGrid(Components[I]);
      if (SubGrid.DataSource <> nil) and
        (SubGrid.DataSource.DataSet = (Fld as TDataSetField).NestedDataset) and
        SubGrid.CanFocus then
      begin
        SubGrid.parent.Show;
        SubGrid.SetFocus;
        Exit;
      end;
    end;

  // create another instance of this kind of grid
  SubGrid := TwwCustomDBGrid(TComponentClass(Self.classtype).Create(Self));
  try
    DS := TDataSource.Create(SubGrid); // incestuous, but easy cleanup
    DS.DataSet := (Fld as TDataSetField).NestedDataset;
    DS.DataSet.CheckBrowseMode;
    SubGrid.DataSource := DS;
    // SubGrid.Columns.State := Columns.State;
    // SubGrid.Columns[0].Expanded := True;
    SubGrid.Visible := false;
    SubGrid.FloatingDockSiteClass := TCustomDockForm;
    FloatRect.TopLeft := ClientToScreen(CellRect(col, row).BottomRight);
    if X > Low(integer) then
      FloatRect.Left := X;
    if Y > Low(integer) then
      FloatRect.Top := Y;
    FloatRect.Right := FloatRect.Left + Width;
    FloatRect.Bottom := FloatRect.Top + Height;
    SubGrid.ManualFloat(FloatRect);
    SubGrid.parent.BiDiMode := Self.BiDiMode; { This carries the BiDi setting }
    I := SubGrid.CellRect(SubGrid.ColCount - 1, 0).Right;
    if (I > 0) and (I < screen.Width div 2) then
      SubGrid.parent.ClientWidth := I
    else
      SubGrid.parent.Width := screen.Width div 4;
    SubGrid.parent.Height := screen.Height div 4;
    SubGrid.Align := alClient;
    SubGrid.DragKind := dkDock;
    SubGrid.Color := Color;
    SubGrid.Ctl3D := Ctl3D;
    SubGrid.Cursor := Cursor;
    SubGrid.Enabled := Enabled;
    SubGrid.FixedColor := FixedColor;
    SubGrid.Font := Font;
    SubGrid.HelpContext := HelpContext;
    SubGrid.ImeMode := ImeMode;
    SubGrid.ImeName := ImeName;
    SubGrid.Options := Options;
    CMP := Self;
    while (CMP <> nil) and (TwwCustomDBGrid(CMP).PopupMenu = nil) do
      CMP := CMP.parent;
    if CMP <> nil then
      SubGrid.PopupMenu := TwwCustomDBGrid(CMP).PopupMenu;
    SubGrid.TitleFont := TitleFont;
    SubGrid.Visible := True;
    SubGrid.parent.Show;
  except
    SubGrid.Free;
    raise;
  end;
end;

procedure TwwTitleMenuAttributes.SetMenuEnabled(value: boolean);
begin
  FMenuEnabled := value;
  FGrid.Invalidate;
end;

function TwwTitleMenuAttributes.TitleMenuEnabled: boolean;
begin
  result := MenuEnabled and
    (([sfoSortAscending, sfoSortDescending, sfoFilter, sfoGrouping,
    sfoSelectColumns] * Options) <> []);
end;

procedure TwwTitleMenuAttributes.SetOptions(value: TwwSortFilterOptions);
begin
  if value <> FOptions then
  begin
    FOptions := value;
    FGrid.Invalidate;
  end;
end;

constructor TwwTitleMenuAttributes.Create(AGrid: TCustomGrid);
begin
  inherited Create;
  FGrid := AGrid;
  FOptions := [sfoSortAscending, sfoFilter, sfoCreateIndexes,
    sfoAutoTitleButtonSort];

end;

function TwwSelectColumnsTreeView.CreateNode: TwwTreeNode;
begin
  result := TwwSelectColumnsTreeNode.Create(Self.Items);
  if Assigned(OnItemChange) then
    OnItemChange(Self, result, icaAdd, NULL);
end;

procedure TwwSelectColumnsTreeView.AddField(NodeGroups: string;
  FieldName: string);
var
  node: TwwSelectColumnsTreeNode;
  DisplayLabel: string;
  // DataSet: TDataSet;
  dbgrid: TwwCustomDBGrid;
  curNode, parentNode: TwwSelectColumnsTreeNode;

  function AddFieldNode(parentNode: TwwSelectColumnsTreeNode)
    : TwwSelectColumnsTreeNode;
  var
    Found: boolean;
    node: TwwSelectColumnsTreeNode;
  begin
    Found := false;
    node := nil;
    result := nil;
    curNode := TwwSelectColumnsTreeNode(TopItem);
    while (curNode <> nil) do
    begin
      if not curNode.IsCategory and wwEqualStr(curNode.FieldName, FieldName)
      then
      begin
        Found := True;
        // Already added so do nothing
        break;
      end;
      curNode := curNode.getNextSibling as TwwSelectColumnsTreeNode;
    end;

    if not Found then
    begin
      if dbgrid.ColumnByName(FieldName).Visible then
        Exit;
      node := Items.AddChild(parentNode, DisplayLabel)
        as TwwSelectColumnsTreeNode;
      node.FieldName := FieldName;
      node.CheckboxType := wwtvctCheckbox;
    end;
    result := node;
  end;

begin
  dbgrid := Grid as TwwCustomDBGrid;
  if dbgrid = nil then
    Exit;

  if (dbgrid.DataSource = nil) or (dbgrid.DataSource.DataSet = nil) then
    Exit;

  DisplayLabel := dbgrid.ColumnByName(FieldName).DisplayLabel;
  if DisplayLabel = '' then
    DisplayLabel := dbgrid.DataSource.DataSet.fieldByName(FieldName)
      .DisplayLabel;

  if NodeGroups = '' then
  begin
    AddFieldNode(nil);
  end
  else
  begin
    curNode := TwwSelectColumnsTreeNode(TopItem);

    // Find parentNode correlating with nodeGroups
    parentNode := nil;
    while (curNode <> nil) do
    begin
      if curNode.IsCategory and wwEqualStr(curNode.Text, NodeGroups) then
      begin
        parentNode := curNode;
        break;
      end;
      curNode := curNode.getNextSibling as TwwSelectColumnsTreeNode;
    end;

    if (parentNode <> nil) then
    begin
      AddFieldNode(parentNode);
    end
    else
    begin
      parentNode := TwwSelectColumnsTreeNode(Items.Add(nil, NodeGroups));
      parentNode.IsCategory := True;
      parentNode.StateIndex := -1;
      parentNode.CheckboxType := wwtvctCheckbox;
      node := AddFieldNode(parentNode);
      if node = nil then
        parentNode.Free;
    end;
    Options := Options + [wwtvoShowRoot];
  end;
end;

class constructor TwwCustomDBGrid.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TwwCustomDBGrid, TwwDBGridStyleHook);
end;

procedure TwwDBGridStyleHook.WMEraseBkgnd(var Message: TMessage);
begin
  inherited;
  // message.Result:=1;
end;

procedure TwwDBGridStyleHook.PaintNC(Canvas: TCanvas);
begin
  inherited;
end;

constructor TwwDBGridStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  // Control:= AControl;
  // OverrideEraseBkgnd := True;
  // OverridePaint:=true;
end;

procedure TwwDBGridStyleHook.DrawHorzScroll(DC: HDC);
begin
  if Control.Visible then
    inherited;
end;

procedure TwwDBGridStyleHook.DrawVertScroll(DC: HDC);
begin
  if Control.Visible then
    inherited;
end;

procedure TwwDBGridStyleHook.PaintBackground(Canvas: TCanvas);
begin
end;

procedure TwwDBGridStyleHook.WMNCPaint(var Message: TMessage);
begin
  inherited;
end;

function HasBorder(Control: TWinControl): boolean;
begin
  with Control do
    result := (GetWindowLong(Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) or
      (GetWindowLong(Handle, GWL_EXSTYLE) and
      WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE);
end;

function HasClientEdge(Control: TWinControl): boolean;
begin
  with Control do
    result := GetWindowLong(Handle, GWL_EXSTYLE) and
      WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE;
end;

function GetScrollRect(Control: TWinControl; IsVertScroll: boolean): TRect;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  BarInfo.cbSize := SizeOf(BarInfo);
  if IsVertScroll then
    GetScrollBarInfo(Control.Handle, integer(OBJID_VSCROLL), BarInfo)
  else
    GetScrollBarInfo(Control.Handle, integer(OBJID_HSCROLL), BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] <> 0 then
    result := Rect(0, 0, 0, 0)
  else
  begin
    P := BarInfo.rcScrollBar.TopLeft;
    ScreenToClient(Control.Handle, P);
    result.TopLeft := P;
    P := BarInfo.rcScrollBar.BottomRight;
    ScreenToClient(Control.Handle, P);
    result.BottomRight := P;
    if HasBorder(Control) then
      if HasClientEdge(Control) then
        OffsetRect(result, 2, 2)
      else
        OffsetRect(result, 1, 1);
  end;
end;

function GetVertScrollRect(Control: TWinControl): TRect;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  BarInfo.cbSize := SizeOf(BarInfo);
  GetScrollBarInfo(Control.Handle, integer(OBJID_VSCROLL), BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] <> 0 then
    result := Rect(0, 0, 0, 0)
  else
  begin
    P := BarInfo.rcScrollBar.TopLeft;
    ScreenToClient(Control.Handle, P);
    result.TopLeft := P;
    P := BarInfo.rcScrollBar.BottomRight;
    ScreenToClient(Control.Handle, P);
    result.BottomRight := P;
    if HasBorder(Control) then
      if HasClientEdge(Control) then
        OffsetRect(result, 2, 2)
      else
        OffsetRect(result, 1, 1);
  end;
end;

// Work around style bug where hittest returning vert scroll even though it is inclient
procedure TwwCustomDBGrid.WMNCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
begin
  inherited;
  if wwIsCustomStyle(Self) then
  // peculiar bug in styles where it is returning wrong hittest
  begin
    P := Point(Msg.XPos, Msg.YPos);
    P := ScreenToClient(P);
    if (Msg.result = HTVSCROLL) then
    begin
      // Verify that it is in scrollbar
      if not PtInRect(GetScrollRect(Self, True), P) then
        Msg.result := HTCLIENT;
    end;
    if (Msg.result = HTHSCROLL) then
    begin
      // Verify that it is in scrollbar
      if not PtInRect(GetScrollRect(Self, false), P) then
        Msg.result := HTCLIENT;
    end;
  end
end;

procedure TwwDBGridStyleHook.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
end;

end.
