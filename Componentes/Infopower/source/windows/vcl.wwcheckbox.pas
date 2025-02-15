{
  //
  // Components : TwwCheckbox
  //
  // Copyright (c) 2001 by Woll2Woll Software
  // 8/25/01 - Check grid's rowselect for expand button coloring in grid
  // 10/10/01 - Use Leftcol instead of 0 in case indicator column is not visible
  // 10/15/01 - Don't set row if datalink.dataset is nil. Fixes problem when closing expanded grid with frames.
  // 3/30/2002 - In some cases we only wish to check for rowselect so focusrect will still show.  Also preserved canvas color when
  //             focusrect being drawn.
  // 5/29/2002 - If Databound and not active then use NullAndBlankState.
  // 6/10/02 - Add new event OnCheckVisibleButton to allow
  //           expand button to be hidden progmatically without calculated field
  // 6/14/02 - Add new property FCenterTextVertically - Developer
  //           can now disable this automatic centering mechnanism
  // 6/29/02 - FCenterTextVertically default is wrong in constructor
  // 6/24/04 - Support RightToLeft
  // 6/29/04 - Toggle inherited moved after setting datalink so state is accurate when event is fired
}
unit vcl.wwcheckbox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwframe, dbctrls, db, wwcommon, imglist, wwradiobutton, grids,
  wwdbgrid, wwintl,
  system.Types, system.UITypes;
{$I wwIfDef.pas}
{$C PRELOAD}

type
  TwwCustomCheckBox = class(TCustomCheckBox)
  private
    FCanvas: TControlCanvas;
    FFrame: TwwEditFrame;
    FIndents: TwwWinButtonIndents;
    FAlwaysTransparent: boolean;
    FValueChecked: string;
    FValueUnchecked: string;
    FDisplayValueChecked: string;
    FDisplayValueUnchecked: string;
    FShowFocusRect: boolean;
    FShowBoxAroundGlyph: boolean;
    FDynamicCaption: boolean;
    FImages: TCustomImageList;
    FWordWrap: boolean;

    FPaintBitmap: TBitmap;
    FPaintCanvas: TCanvas;
    // UseTempCanvas: Boolean;
    SpaceKeyPressed: boolean;
    FModified: boolean;
    // PaintCopyState: TCheckBoxState;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FShowAsButton: boolean;
    FNullAndBlankState: TCheckBoxState;
    FShowText: boolean;
    FCenterTextVertically: boolean;
    FDisableThemes: boolean;
{$IFNDEF GRIDESSENTIALS}
    FController: TwwController;
{$ENDIF}
    FTextAlignment: TLeftRight;

    procedure SetController(Value: TwwController);
    function isTransparentEffective: boolean;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct); virtual;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure EMGetModify(var Message: TMessage); message EM_GETMODIFY;

    procedure SetValueChecked(const Value: string);
    procedure SetValueUnchecked(const Value: string);
    function GetDisplayValueChecked: string;
    function GetDisplayValueUnchecked: string;
    procedure SetDisplayValueChecked(const Value: string);
    procedure SetDisplayValueUnchecked(const Value: string);
    procedure ComputeTextRect(var DrawRect: TRect);
    function GetModified: boolean;
    procedure SetModified(Value: boolean);
    procedure SetColor(Value: TColor);
    Function GetColor: TColor;
    function IsColorStored: boolean;

  protected
    Function GetDisplayText: string; virtual;
    Function GetExtraIndentX: integer; virtual;
    Function IsMouseInControl(CheckAreaOnly: boolean = False): boolean; virtual;
    function FillBackground: boolean; virtual;
    function GetFieldState: TCheckBoxState; virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; virtual;
    procedure PaintBorder;
    procedure DataChange(Sender: TObject); virtual;
    Function GetCanvas: TCanvas; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    { Protected declarations }
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    function GetImageList: TImageList; virtual;
    function HideExpand: boolean; virtual;

    function GetField: TField; virtual;
    function GetAlignment: TAlignment; virtual;
    function GetDrawFlags: integer; virtual;
//    procedure PaintActiveGridCellBackgroundColor;
    function DrawHighlightForRowSelect(CheckBoth: boolean = true): boolean;
    function DrawHighlight: boolean;
    procedure PaintFocusRect;

    // 8/13/02 - Don't display prefix when using TwwExpandButton
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure ComputeGlyphRect(var DrawRect: TRect); virtual;
    property Canvas: TCanvas read GetCanvas;
    property Images: TCustomImageList read FImages write FImages;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property Modified: boolean read GetModified write SetModified;

  public
    property Controller: TwwController read FController write SetController;
    property DisableThemes: boolean read FDisableThemes write FDisableThemes;
    property TextAlignment: TLeftRight read FTextAlignment write FTextAlignment
      default taLeftJustify;
    property AlwaysTransparent: boolean read FAlwaysTransparent
      write FAlwaysTransparent;
    property Frame: TwwEditFrame read FFrame write FFrame;
    property Indents: TwwWinButtonIndents read FIndents write FIndents;
    property DynamicCaption: boolean read FDynamicCaption write FDynamicCaption
      default False;
    property ValueChecked: string read FValueChecked write SetValueChecked;
    property ValueUnchecked: string read FValueUnchecked
      write SetValueUnchecked;
    property DisplayValueChecked: string read GetDisplayValueChecked
      write SetDisplayValueChecked;
    property DisplayValueUnchecked: string read GetDisplayValueUnchecked
      write SetDisplayValueUnchecked;
    property ShowFocusRect: boolean read FShowFocusRect write FShowFocusRect
      default true;
    property WordWrap: boolean read FWordWrap write FWordWrap default False;
    property NullAndBlankState: TCheckBoxState read FNullAndBlankState
      write FNullAndBlankState;
    property ShowText: boolean read FShowText write FShowText default true;
    property ShowAsButton: boolean read FShowAsButton write FShowAsButton
      default False;
    property ShowBoxAroundGlyph: boolean read FShowBoxAroundGlyph
      write FShowBoxAroundGlyph default False;
    property CenterTextVertically: boolean read FCenterTextVertically
      write FCenterTextVertically default true;
    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    // No clWindow default for this control as it makes clWindow ignored
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    // property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
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
    property OnStartDock;
    property OnStartDrag;
  end;

  { TDBCheckBox }

  TwwDBCustomCheckBox = class(TwwCustomCheckBox)
  private
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: boolean);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): boolean;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    Function IsDataBound: boolean;
    procedure DataChange(Sender: TObject); override;
    procedure Toggle; override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
    function GetField: TField; override;
    function GetFieldState: TCheckBoxState; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): boolean; override;
    function UpdateAction(Action: TBasicAction): boolean; override;
    function UseRightToLeftAlignment: boolean; override;
    property Field: TField read GetField;
    // published
    // property AlwaysTransparent: boolean read FAlwaysTransparent write FAlwaysTransparent;
    // property Frame: TwwEditFrame read FFrame write FFrame;
    // property DynamicCaption: boolean read FDynamicCaption write FDynamicCaption default False;
    // property ValueChecked: string read FValueChecked write SetValueChecked;
    // property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
    // property DisplayValueChecked: string read FDisplayValueChecked write SetDisplayValueChecked;
    // property DisplayValueUnchecked: string read FDisplayValueUnchecked write SetDisplayValueUnchecked;
    // property ShowFocusRect: boolean read FShowFocusRect write FShowFocusRect default true;
    // property NullAndBlankState: TCheckBoxState read FNullAndBlankState write FNullAndBlankState;

    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    // property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
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
    property OnMouseEnter;
    property OnMouseLeave;

    property OnStartDock;
    property OnStartDrag;

    property ReadOnly: boolean read GetReadOnly write SetReadOnly default False;
  end;

  TwwCheckBox = class(TwwDBCustomCheckBox)
  published
    property Controller;
    property DisableThemes;
    property AlwaysTransparent;
    property Frame;
    property DynamicCaption;
    property ValueChecked;
    property ValueUnchecked;
    property DisplayValueChecked;
    property DisplayValueUnchecked;
    property ShowFocusRect;
    property NullAndBlankState;
    property Indents;

    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property CenterTextVertically;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowText;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
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
    property OnMouseEnter;
    property OnMouseLeave;

    property OnStartDock;
    property OnStartDrag;

    {$ifdef wwDELPHI2013Up}
    property Align;
    property StyleElements;
    property DoubleBuffered;
    property ParentDoubleBuffered;
    {$endif}

    property ReadOnly;
  end;

  TwwExpandGridIndents = class(TPersistent)
  private
    FWinControl: TWinControl;
    FIndentX: integer;
    FIndentY: integer;
    // procedure SetIndentX(Value: integer);
    // procedure SetIndentY(Value: integer);
  public
    constructor Create(AOwner: TComponent);
    // Procedure Assign(Source: TPersistent); override;
  published
    property X: integer read FIndentX write FIndentX default 0;
    property Y: integer read FIndentY write FIndentY default 0;
  end;

  // TwwExpandAutoShrink = (easDisabled, easTerminalGrid, easAllGrids);
  TwwExpandButton = class;

  TwwCheckVisibleButton = procedure(Sender: TwwExpandButton; DataSet: TDataSet;
    var AShowExpand: boolean) of object;

  TwwExpandButton = class(TwwDBCustomCheckBox)
  private
    FButtonAlignment: TAlignment;
    FGrid: TWinControl;
    FExpandImages: TImageList;
    FAutoShrink: boolean; // TwwExpandAutoShrink;
    // FExpanded: boolean;
    FOnBeforeExpand: TNotifyEvent;
    FOnBeforeCollapse: TNotifyEvent;
    FOnAfterExpand: TNotifyEvent;
    FOnAfterCollapse: TNotifyEvent;
    FAutoHideExpand: boolean;
    InClickEvent: boolean;
    FGridIndents: TwwExpandGridIndents;
    FOnCheckVisibleButton: TwwCheckVisibleButton;
    BeforeExpandHeightOfParentGrid, BeforeExpandRowHeight: integer;

    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMShowingChanged(var Message: TMessage);
      message CM_SHOWINGCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure SetGrid(Value: TWinControl);
    procedure SetExpanded(val: boolean);
    function GetExpanded: boolean;
  protected
    OriginalHeight: integer;
    procedure WndProc(var Message: TMessage); override;
    function GetAlignment: TAlignment; override;
    Function GetDisplayText: string; override;
    Function GetExtraIndentX: integer; override;
    function GetImageList: TImageList; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Toggle; override;
    procedure DataChange(Sender: TObject); override;
    function GetFieldState: TCheckBoxState; override;
    function FillBackground: boolean; override;
    procedure DoBeforeExpand; virtual;
    procedure DoBeforeCollapse; virtual;
    procedure DoAfterExpand; virtual;
    procedure DoAfterCollapse; virtual;
    function HideExpand: boolean; override;
    function GetDrawFlags: integer; override;
  public
    PaintAsExpanded: boolean;
    DesiredRow: integer;
    ExpandedGridRow: integer;
    InRefreshCalcField: boolean;
    InToggle: boolean;
    // ftest: integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetHeight;
    procedure Click; override;
    property Expanded: boolean read GetExpanded write SetExpanded;
    procedure RefreshCalcField;
    procedure ExpandAfterDelay;
  published
    property DisableThemes;
    property Grid: TWinControl read FGrid write SetGrid;
    property AutoShrink: boolean read FAutoShrink write FAutoShrink
      default true;
    property TextAlignment;

    property AutoHideExpand: boolean read FAutoHideExpand write FAutoHideExpand
      default False;
    property ShowFocusRect;
    property OnBeforeExpand: TNotifyEvent read FOnBeforeExpand
      write FOnBeforeExpand;
    property OnBeforeCollapse: TNotifyEvent read FOnBeforeCollapse
      write FOnBeforeCollapse;
    property OnAfterExpand: TNotifyEvent read FOnAfterExpand
      write FOnAfterExpand;
    property OnAfterCollapse: TNotifyEvent read FOnAfterCollapse
      write FOnAfterCollapse;
    property OnCheckVisibleButton: TwwCheckVisibleButton
      read FOnCheckVisibleButton write FOnCheckVisibleButton;
    property GridIndents: TwwExpandGridIndents read FGridIndents
      write FGridIndents;
    // property Alignment;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    // property test: integer read FTest write FTest;
    property DataField;
    property DataSource;
    property Enabled;
    property Font;
    property Images;
    property ParentBiDiMode;
    property ParentColor;
    property Indents;
    property ShowAsButton;
    property ShowText default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property ButtonAlignment: TAlignment read FButtonAlignment
      write FButtonAlignment default taLeftJustify;
    property OnContextPopup;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;

    {$ifdef wwDELPHI2013Up}
    property Align;
    property StyleElements;
    property DoubleBuffered;
    property ParentDoubleBuffered;
    {$endif}

    property ReadOnly;
  end;

implementation

uses
{$IFDEF wwDelphi7Up}
  themes,
{$ENDIF}
{$IFDEF ThemeManager}
  thememgr, themesrv, uxtheme,
{$ENDIF}
  wwdbigrd;

type
  EwwExpandError = class(Exception);

Function TwwCustomCheckBox.GetColor: TColor;
begin
  result := inherited Color;
end;

procedure TwwCustomCheckBox.SetColor(Value: TColor);
begin
  inherited Color := Value;
end;

Function TwwCustomCheckBox.IsColorStored;
begin
  result := not ParentColor;
end;

procedure TwwCustomCheckBox.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct^);
end;

procedure TwwCustomCheckBox.DrawItem(const DrawItemStruct: TDrawItemStruct);
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;

begin
  CanvasNeeded;
  FCanvas.Handle := DrawItemStruct.hDC;
  FCanvas.Font := Font;
  Paint;
  PaintBorder;
  FCanvas.Handle := 0;
end;

procedure TwwCustomCheckBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  r: TRect;
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;

begin
  if IsInwwObjectViewPaint(Self) or ((isTransparentEffective and not Focused) or
    AlwaysTransparent) then
  begin
    if not(csDesigning in ComponentState) then
      Message.result := 1
    else
      inherited;
  end
  else if wwUseThemes(Self) then
  begin
    if (parent is TCustomGrid) then
    begin
      r := ClientRect;

      if TStyleManager.IsCustomStyleActive and wwUseThemes(Self) then
      begin
        // paint grid active cell background for styles
        CanvasNeeded; // 9/25/12
        wwPaintActiveGridCellBackgroundColor(self, FCanvas);
      end
      else if (FCanvas <> nil) then
      begin
        FCanvas.Brush.Color := Color;
        Windows.FillRect(message.dc, r, FCanvas.Brush.Handle);
      end;
      message.result := 1
    end
    else
    begin
      { Get the parent to draw its background into the control's background. }
      StyleServices.DrawParentBackground(Handle, Message.dc, nil, False);
      message.result := 1;
    end
  end
  else
    inherited;
end;

procedure TwwCustomCheckBox.CreateParams(var Params: TCreateParams);
const
  Alignments: array [boolean, TLeftRight] of DWORD = ((BS_LEFTTEXT, 0),
    (0, BS_LEFTTEXT));
begin
  inherited;
  CreateSubClass(Params, 'BUTTON');
  if isTransparentEffective then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT; // For transparency

  // Following 2 lines may not be necessary
  // if StyleServices.ThemesEnabled then
  // Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;  // For transparency

  with Params do
  begin
    Style := Style and not BS_3STATE;
    Style := Style or BS_ownerdraw;
    // Style:= Style or ws_border;
    WindowClass.Style := WindowClass.Style and not(CS_HREDRAW or CS_VREDRAW);
  end;

end;

procedure TwwCustomCheckBox.CreateWnd;
  procedure DisableParentClipping;
  begin
    SetWindowLong(GetParent(Handle), GWL_STYLE, GetWindowLong(GetParent(Handle),
      GWL_STYLE) and not WS_CLIPCHILDREN);
  end;

begin
  inherited;
  if isTransparentEffective then
  begin
    DisableParentClipping;
  end;
  Modified := FModified;
end;

destructor TwwCustomCheckBox.Destroy;
begin
  FIndents.Free;
  FCanvas.Free;
  FFrame.Free;
  inherited;
end;
{
  procedure TwwCustomCheckBox.PaintGlyph(drawrect: TRect; b: TBitmap);
  var TempRect: TRect;
  FGlyphs: TImageList;
  i: integer;
  begin
  for i:= 1 to 1 do
  begin
  FGlyphs:= TImageList.createsize(b.Width, b.Height);
  FGlyphs.AddMasked(b, b.Canvas.Pixels[0, b.Height-1]);
  Canvas.Lock;
  TempRect:= Rect(0, 0, b.Width, b.Height);
  try
  FGlyphs.Draw(Canvas, drawrect.left, drawrect.top,
  0, True);
  //      FCanvas.Brush.Style:= bsClear;
  //      FCanvas.BrushCopy(DrawRect, b, TempRect,
  //          b.Canvas.Pixels[0, b.Height-1]);
  finally
  Canvas.Unlock;
  FGlyphs.Free;
  end;
  end
  end;
}

procedure TwwCustomCheckBox.ComputeGlyphRect(var DrawRect: TRect);
var
  offsetx, offsety: integer;
  checkboxSizeX, checkboxSizeY: integer;
  pt: TPoint;
  TempIndentCheckboxX: integer;
begin
  if (GetImageList <> nil) and (GetImageList.count > 0) then
  begin
    checkboxSizeX := GetImageList.Width;
    checkboxSizeY := GetImageList.Height;
  end
  else
  begin
    checkboxSizeX := 13;
    checkboxSizeY := 13;
  end;

  offsetx := checkboxSizeX div 2;
  offsety := checkboxSizeY div 2;

  TempIndentCheckboxX := Indents.ButtonX + 1 + GetExtraIndentX;
  if parent is TCustomGrid then
    inc(TempIndentCheckboxX);

  if Frame.Enabled and (efLeftBorder in Frame.FocusBorders) then
  begin
    TempIndentCheckboxX := wwmax(TempIndentCheckboxX, 3);
  end;

  if GetAlignment = taRightJustify then
    pt.X := offsetx + TempIndentCheckboxX
  else if GetAlignment = taLeftJustify then
    pt.X := ClientWidth - TempIndentCheckboxX - offsetx - 2
  else
    pt.X := (ClientWidth - offsetx) div 2;
  pt.Y := Height div 2;

  DrawRect.Left := pt.X - offsetx;
  DrawRect.Right := pt.X + offsetx + 1;
  DrawRect.Top := pt.Y - offsety + Indents.ButtonY;
  DrawRect.Bottom := pt.Y + offsety + 1 + Indents.ButtonY;

end;

procedure TwwCustomCheckBox.ComputeTextRect(var DrawRect: TRect);
var
  TempIndentTextX: integer;
  pt: TPoint;
  NewDrawRect: TRect;
  DrawFlags: integer;
  TempCaption: string;
begin
  ComputeGlyphRect(DrawRect);

  TempIndentTextX := Indents.TextX;
  if Frame.Enabled and (efLeftBorder in Frame.FocusBorders) then
    TempIndentTextX := wwmax(TempIndentTextX, 3);
  // if FShowAsButton then TempIndentTextX:= wwmax(TempIndentTextX, 3);

  pt.Y := Height div 2;
  if GetAlignment = taRightJustify then
    NewDrawRect := Rect(DrawRect.Right + 4 + TempIndentTextX, 0, Width, Height)
  else
    NewDrawRect := Rect(TempIndentTextX + 2, 0, DrawRect.Left, Height);
  DrawFlags := GetDrawFlags;
  if WordWrap then
    DrawFlags := DrawFlags or DT_EDITCONTROL or DT_WORDBREAK;
  if DynamicCaption then
  begin
    TempCaption := DisplayValueChecked;
    if length(TempCaption) < length(DisplayValueUnchecked) then
      TempCaption := DisplayValueUnchecked;
    // if length(TempCaption) < length(Caption) then TempCaption := Caption; !! Uncomment?
  end
  else
    TempCaption := GetDisplayText; // Caption;

  DrawTextEx(Canvas.Handle, PChar(TempCaption), length(TempCaption),
    NewDrawRect, DrawFlags or DT_CALCRECT, nil);
  DrawRect := NewDrawRect;

  if CenterTextVertically then
    DrawRect.Top := Indents.TextY +
      (ClientHeight - (NewDrawRect.Bottom - NewDrawRect.Top)) div 2
  else
    DrawRect.Top := Indents.TextY + 1;

  DrawRect.Bottom := DrawRect.Top + NewDrawRect.Bottom;
  // DrawRect.Bottom - (NewDrawRect.Bottom-NewDrawRect.Top) div 2;
  if wwIsClass(parent.classtype, 'TwwDBGrid') and
    (dgRowLines in TwwDBGrid(parent).Options) then
    DrawRect.Top := DrawRect.Top + 1;

end;

type
  TwwCheatGridCast = class(TwwDBGrid);

  // 8/25/01 -   If rowselect is True for grid then
  // if dgAlwaysshowSelection is true, then paint highlight
  // else if expandbutton has focus then override painting to paint as highlight
  // 3/30/2002 - In some cases we only wish to check for rowselect so focusrect will still show.
function TwwCustomCheckBox.DrawHighlightForRowSelect
  (CheckBoth: boolean = true): boolean;
begin
  result := False;
  if (wwIsClass(classtype, 'TwwExpandbutton')) then
  begin
    if (wwIsClass(parent.classtype, 'TwwCustomDBGrid')) then
    begin
      if (dgRowSelect in TwwCheatGridCast(parent).Options) or
        (CheckBoth and (TwwCheatGridCast(parent).PaintOptions.ActiveRecordColor
        <> clNone)) then
      begin
        if (dgAlwaysShowSelection in TwwCheatGridCast(parent).Options) or Focused
        then
        begin
          result := true;
        end
      end;
    end;
  end
end;

function TwwCustomCheckBox.DrawHighlight: boolean;
begin
  result := False;
  if wwIsClass(parent.classtype, 'TwwDBGrid') then
  begin
    result := parent.Focused or Focused;
    // 8/25/01
    if (not result) and DrawHighlightForRowSelect then
      result := true;
  end
end;

procedure TwwCustomCheckBox.PaintFocusRect;
var
  r: TRect;
begin
  if DrawHighlight and not DrawHighlightForRowSelect(False) and
    (not(csPaintCopy in ControlState)) then
  begin
    r := ClientRect;
    Canvas.Brush.Color := clHighlight;
    Canvas.Font.Color := clHighlightText;
    Canvas.Pen.Color := clHighlight;
    Canvas.FrameRect(r);
    SetTextColor(Canvas.Handle, ColorToRGB(clHighlightText));
    SetBkColor(Canvas.Handle, ColorToRGB(clHighlight));
    Canvas.DrawFocusRect(r);
  end
end;

{procedure TwwCustomCheckBox.PaintActiveGridCellBackgroundColor;
var
  LDetails: TThemedElementDetails;
  LColor: TColor;
  LRect: TRect;
  r: TRect;

begin
  r := ClientRect;
  Canvas.Brush.Style := TBrushStyle.bsSolid;
  Canvas.Brush.Color := StyleServices.GetStyleColor(scGrid);
  Canvas.FillRect(r);
  // LRect := r;

  StyleServices.DrawElement(Canvas.Handle,
    StyleServices.GetElementDetails(tgCellSelected), r, r);
  if not StyleServices.GetElementColor
    (StyleServices.GetElementDetails(tgCellSelected), ecTextColor, LColor) or
    (LColor = clNone) then
    LColor := clHighlightText;

  Canvas.Font.Color := LColor;
  Canvas.Brush.Style := bsClear;
end;
}
procedure TwwCustomCheckBox.Paint;
var
  r: TRect;
  IsCustomStyle: boolean;

{$IFDEF wwUseThemeManager}
  function GetCheckboxThemeStyle(Pressed: boolean): TThemedButton;
  var
    TempState: TCheckBoxState;
  begin
    if csPaintCopy in ControlState then
      TempState := GetFieldState
    else
      TempState := State;

    if (TempState = cbGrayed) or (not Enabled) then
    begin
      if TempState = cbChecked then
        result := tbCheckboxCheckedDisabled
      else
        result := tbCheckboxUnCheckedDisabled
    end
    else
    begin
      if TempState = cbChecked then
      begin
        if Pressed then
          result := tbCheckboxCheckedPressed
        else
        begin
          if IsMouseInControl and not(csPaintCopy in ControlState) then
            result := tbCheckboxCheckedHot
          else
            result := tbCheckboxCheckedNormal
        end
      end
      else
      begin
        if Pressed then
          result := tbCheckboxUncheckedPressed
        else
        begin
          if IsMouseInControl and not(csPaintCopy in ControlState) then
            result := tbCheckboxUncheckedHot
          else
            result := tbCheckboxUncheckedNormal
        end
      end;
    end;
  end;
{$ENDIF}
  procedure PaintText;
  var
    ARect, FocusRect: TRect;
    Flags: integer;
    HaveText: boolean;
    TempCaption: string;
    SaveColorbg, savecolorfont: TColor;
    temp: integer;
    tempRect: TRect;
{$IFDEF wwUseThemeManager}
    Details: TThemedElementDetails;
    CheckboxStyle: TThemedButton;
    FormatFlags: TTextFormatFlags;
{$ENDIF}
  begin
    SaveColorbg := Canvas.Brush.Color;
    savecolorfont := Canvas.Font.Color;

    ComputeTextRect(ARect);

    // 6/29/02 - Bidi mode
    if UseRightToLeftAlignment then
    begin
      temp := ARect.Left;
      ARect.Left := ClientWidth - ARect.Right;
      ARect.Right := ClientWidth - temp;
    end;

    TempCaption := GetDisplayText;
    HaveText := DynamicCaption or (TempCaption <> '');
    if Focused and ShowFocusRect and HaveText and
      (not(csPaintCopy in ControlState)) then
    // {and not (parent is TCustomGrid) }then
    begin
      if parent is TCustomGrid then
        FocusRect := Rect(ARect.Left - 2, ARect.Top - 1,
          wwMin(ARect.Right + 2, ARect.Left + Canvas.TextWidth(TempCaption) +
          2), ARect.Bottom + 1)
      else
        FocusRect := Rect(ARect.Left - 2, wwmax(ARect.Top - 2, 0),
          // 6/29/02 - Changed from ARect.Top - 2 as focusrect cutoff from top in default case
          wwMin(ARect.Right + 2, ARect.Left + Canvas.TextWidth(TempCaption) +
          2), ARect.Bottom + 2);
      Canvas.Brush.Color := Color;
      Canvas.Font.Color := clBlack;
      Canvas.FrameRect(FocusRect);
      // 3/30/2002-PYW-If Highlight then focusrect colors were wrong.
      if DrawHighlight then
      begin
        Canvas.Brush.Color := clBlack;
        Canvas.Font.Color := clWhite;
      end
      else
      begin
        Canvas.Brush.Color := clWhite;
        Canvas.Font.Color := clBlack;
      end;
      Canvas.DrawFocusRect(FocusRect);
      // 3/30/2002-PYW-Restore Saved Canvas and Font Colors.
      Canvas.Font.Color := savecolorfont;
      Canvas.Brush.Color := SaveColorbg;
    end;

    SetBkMode(Canvas.Handle, TRANSPARENT);
    Flags := GetDrawFlags;
    if WordWrap then
      Flags := Flags or DT_EDITCONTROL or DT_WORDBREAK;

    InflateRect(ARect, 0, 2);
    ARect.Top := ARect.Top + 2;
    if DrawHighlight then
    begin
      // Canvas.Font.Color := clHighlightText;
    end
    else if not(csPaintCopy in ControlState) then
      Canvas.Font.Color := Font.Color;

    if (not Focused) and isTransparentEffective and
      (Frame.NonFocusTransparentFontColor <> clNone) then
      Canvas.Font.Color := Frame.NonFocusTransparentFontColor
      // 4/15/01
    else if (not Focused) and (Frame.Enabled) and
      (Frame.NonFocusFontColor <> clNone) then
      Canvas.Font.Color := Frame.NonFocusFontColor;

    if (not Enabled) and not wwUseThemes(Self) then
    begin
      OffsetRect(ARect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      if TextAlignment = taRightJustify then
      begin
        tempRect := ARect;
        tempRect.Right := ClientWidth - 2;
        DrawTextEx(Canvas.Handle, PChar(TempCaption), length(TempCaption),
          tempRect, DT_RIGHT + Flags, nil);
      end
      else
        DrawTextEx(Canvas.Handle, PChar(TempCaption), length(TempCaption),
          ARect, Flags, nil);
      Canvas.Font.Color := clGrayText;
      OffsetRect(ARect, -1, -1);
    end;

    if wwUseThemes(Self) then
    begin
{$IFDEF wwUseThemeManager}
      CheckboxStyle := GetCheckboxThemeStyle(False);
      Details := StyleServices.GetElementDetails(CheckboxStyle);

      if TempCaption <> '' then
      begin
        if TextAlignment = taRightJustify then
        begin
          ARect.Right := ClientWidth - 2;
          FormatFlags:= DT_RIGHT;
          StyleServices.DrawText(Canvas.Handle, Details, TempCaption, ARect, FormatFlags);
          //StyleServices.DrawText(Canvas.Handle, Details, TempCaption, ARect,
          //  DT_RIGHT, 0);
        end
        else begin
          FormatFlags:= DT_RIGHT;
          StyleServices.DrawText(Canvas.Handle, Details, TempCaption, ARect, FormatFlags);
          //StyleServices.DrawText(Canvas.Handle, Details, TempCaption, ARect,
          //  DT_LEFT, 0);
        end;
      end
{$ENDIF}
    end
    else
    begin
      if TextAlignment = taRightJustify then
      begin
        ARect.Right := ClientWidth - 2;
        DrawTextEx(Canvas.Handle, PChar(TempCaption), length(TempCaption),
          ARect, DT_RIGHT + Flags, nil);
      end
      else
        DrawTextEx(Canvas.Handle, PChar(TempCaption), length(TempCaption),
          ARect, Flags, nil);
    end
  end;

  procedure PaintCheckbox;
  var
    DrawRect, tempRect: TRect;
    FrameStateFlags, StateFlags: integer;
    TempState: TCheckBoxState;
{$IFDEF wwUseThemeManager}
    Details: TThemedElementDetails;
    ExpandStyle: TThemedTreeview;
    CheckboxStyle: TThemedButton;
    PaintRect: TRect;
{$ENDIF}
    UseThemesForExpandButton: boolean;
  begin
    ComputeGlyphRect(DrawRect);

    // 6/29/02 - Bidi mode
    if UseRightToLeftAlignment then
    begin
      DrawRect.Right := ClientWidth - DrawRect.Left;
      DrawRect.Left := DrawRect.Right - 13;
    end;

    if csPaintCopy in ControlState then
      TempState := GetFieldState
    else
      TempState := State;

    if TempState = cbChecked then
      StateFlags := DFCS_BUTTONCHECK
    else
      StateFlags := DFCS_BUTTON3STATE;

    if (cslbuttondown in ControlState) and Focused and
      not(csPaintCopy in ControlState) then
    begin
      if IsInGrid(Self) then
      begin
        if IsMouseInControl(true) then
          StateFlags := StateFlags or DFCS_PUSHED;
      end
      else
      begin
        if IsMouseInControl then
          StateFlags := StateFlags or DFCS_PUSHED;
      end
    end;

    if SpaceKeyPressed and (GetKeyState(vk_space) < 0) and Focused then
      StateFlags := StateFlags or DFCS_PUSHED;

    if TempState = cbChecked then
      StateFlags := StateFlags or DFCS_CHECKED
    else if TempState = cbGrayed then
      StateFlags := StateFlags or DFCS_CHECKED;

    UseThemesForExpandButton := wwUseThemes(Self) and (GetImageList <> Images);

    if UseThemesForExpandButton then
    begin
{$IFDEF wwUseThemeManager}
      if TempState = cbChecked then
        ExpandStyle := ttGlyphOpened
      else
        ExpandStyle := ttGlyphClosed;
      Details := StyleServices.GetElementDetails(ExpandStyle);
      tempRect := DrawRect;
      InflateRect(tempRect, 1, 1);
      StyleServices.DrawElement(Canvas.Handle, Details, tempRect);
      exit;
{$ENDIF}
    end
    else if (GetImageList <> nil) and (GetImageList.count > 0) then
    begin
      FrameStateFlags := DFCS_BUTTONPUSH;
      if (StateFlags and DFCS_PUSHED <> 0) then
        FrameStateFlags := FrameStateFlags or DFCS_PUSHED;

      if ShowBoxAroundGlyph then
      begin
        tempRect := DrawRect;
        InflateRect(tempRect, 1, 1);
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(tempRect);
        Canvas.Brush.Color := clBlack;
        Canvas.FrameRect(tempRect);
      end;

      if (FShowAsButton) then
      begin
        tempRect := DrawRect;
        InflateRect(tempRect, 2, 2);
        if not Enabled then
          FrameStateFlags := FrameStateFlags + DFCS_INACTIVE;
        with DrawRect do
          DrawFrameControl(Canvas.Handle, tempRect, DFC_BUTTON,
            FrameStateFlags);
      end;

      if TempState = cbChecked then
      begin
        if (GetImageList <> nil) and (GetImageList.count > 1) then
        begin
          GetImageList.Draw(Canvas, DrawRect.Left, DrawRect.Top, 1, true);
          exit;
        end
      end
      else if TempState = cbUnchecked then
      begin
        if (GetImageList <> nil) and (GetImageList.count > 0) then
        begin
          GetImageList.Draw(Canvas, DrawRect.Left, DrawRect.Top, 0, true);
          exit;
        end
      end
      else
      begin
        if (GetImageList <> nil) and (GetImageList.count > 2) then
        begin
          GetImageList.Draw(Canvas, DrawRect.Left, DrawRect.Top, 2, true);
          exit;
        end
      end;
    end;

    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(DrawRect);
    Canvas.Brush.Color := clBtnShadow;

    if GetImageList = nil then
    begin
      if not Enabled then
        StateFlags := StateFlags + DFCS_INACTIVE;

      if wwUseThemes(Self) then
      begin
        // PerformEraseBackground(Self, Canvas.Handle);
{$IFDEF wwUseThemeManager}
        CheckboxStyle := GetCheckboxThemeStyle
          ((StateFlags and DFCS_PUSHED) <> 0);
        Details := StyleServices.GetElementDetails(CheckboxStyle);
        PaintRect := DrawRect;
        StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
        //PaintRect := StyleServices.ContentRect(Canvas.Handle, Details, PaintRect);
        StyleServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
{$ENDIF}
      end
      else
      begin
        with DrawRect do
          DrawFrameControl(Canvas.Handle, DrawRect, DFC_BUTTON, StateFlags);
      end
    end
  end;

  Function Max(X, Y: integer): integer;
  begin
    if X > Y then
      result := X
    else
      result := Y
  end;

  procedure EndPainting;
  begin
    if (FCanvas = Canvas) then
      exit;
    r := ClientRect;
    FCanvas.CopyRect(r, FPaintCanvas, r);
  end;

begin
  IsCustomStyle := wwIsCustomStyle(Self);

  if False and Focused and (not AlwaysTransparent) then
  begin
    FPaintBitmap := TBitmap.Create;
    FPaintCanvas := FPaintBitmap.Canvas;
    FPaintBitmap.Width := ClientWidth;
    FPaintBitmap.Height := ClientHeight;
  end;

  try
    if (not(Frame.Enabled and Frame.TRANSPARENT)) or (not AlwaysTransparent) and
      (Focused) then
    begin
      if not(IsInGridPaint(Self)) then
      begin
        r := ClientRect;
        Canvas.Brush.Color := Color;

        // 4/15/01 - Back-color support
        if (not isTransparentEffective) then
        begin
          if Frame.Enabled and (not Focused) and (Frame.NonFocusColor <> clNone)
          then
          begin
            Canvas.Brush.Color := Frame.NonFocusColor;
          end
        end;

        if DrawHighlight then
        begin
          Canvas.Brush.Color := clHighlight;
          Canvas.Font.Color := clHighlightText;
        end;

        { Honor grid's colors when painting cell }
        if DrawHighlight and (wwIsClass(parent.classtype, 'TwwCustomDBGrid'))
        then
        begin
          if IsCustomStyle then
          begin
            wwPaintActiveGridCellBackgroundColor(self, Canvas);
          end
          else
          begin
            if TwwCustomDBGrid(parent).PaintOptions.ActiveRecordColor <> clNone
            then
              Canvas.Brush.Color := TwwCustomDBGrid(parent)
                .PaintOptions.ActiveRecordColor;

            if (GetField <> nil) then
              TwwCheatGridCast(parent).DoCalcCellColors(GetField, [], true,
                Canvas.Font, Canvas.Brush);
            Canvas.FillRect(r);
          end;
        end
        else
        begin
          if FillBackground and not(wwUseThemes(Self)) then
            Canvas.FillRect(r);
        end;
      end
    end;
    if not HideExpand then
      PaintCheckbox;
    if ShowText then
      PaintText;

    // 8/25/01 - Check grid's rowselect
    // 3/30/2002 - Only check for rowselect so focusrect will still show.
    PaintFocusRect;
    { if DrawHighlight and not DrawHighlightForRowSelect(False) and
      ((parent.Focused or self.Focused) and not(csPaintCopy in ControlState)) then
      begin
      r := ClientRect;
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
      Canvas.Pen.Color := clHighlight;
      Canvas.FrameRect(r);
      SetTextColor(Canvas.Handle, ColorToRGB(clHighlightText));
      SetBkColor(Canvas.Handle, ColorToRGB(clHighlight));
      Canvas.DrawFocusRect(r);
      end
    }
  finally
    EndPainting;
    FPaintBitmap.Free;
    FPaintBitmap := nil;
  end
end;

procedure TwwCustomCheckBox.WMLButtonUp(var Message: TWMLButtonUp);
var
  r: TRect;
begin
  inherited;
  if not IsInGrid(Self) then
  begin
     // 11/20/12 - Perform toggle in cncommand again (for non-grid cases),
     // so we comment out the following code
     // if PtInRect(ClientRect, Point(Message.xpos, Message.ypos)) then
     //   Toggle;
  end
  else
  begin
    ComputeGlyphRect(r);
    InflateRect(r, 3, 3);
    if PtInRect(r, Point(Message.xpos, Message.ypos)) then
      if not wwIsClass(Self.classtype, 'TwwExpandButton') or Focused or
        (not Checked) then
        Toggle;
  end
end;

procedure TwwCustomCheckBox.BMSetCheck(var Message: TMessage);
var
  r: TRect;
begin
  inherited;
  if DynamicCaption then
  begin
    if State = cbChecked then
      Caption := DisplayValueChecked
    else if State = cbUnchecked then
      Caption := DisplayValueUnchecked
    else
      Caption := ''
  end
  else
  begin
    if isTransparentEffective and ((not Focused) or AlwaysTransparent) then
    begin
      ComputeGlyphRect(r);
      r := Rect(r.Left + Left, r.Top + Top, r.Right + Left, r.Bottom + Top);
      InvalidateRect(parent.Handle, @r, False);
      // Frame.RefreshTransparentText(False, False);
    end
  end;

  invalidate;
end;

procedure TwwCustomCheckBox.PaintBorder;
begin
  if HandleAllocated then
  begin
    if not Frame.Enabled then
      exit;
    Frame.Ncpaint(Focused, AlwaysTransparent);
  end;
end;

procedure TwwCustomCheckBox.WMKillFocus(var Message: TWMKillFocus);
var
  ExStyle, origStyle: longint;
  // r: TRect;
begin
  inherited;

  if isTransparentEffective then
  begin
    origStyle := Windows.GetWindowLong(Handle, GWL_EXSTYLE);
    ExStyle := origStyle or WS_EX_TRANSPARENT;
    Windows.SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
    Frame.RefreshTransparentText(true, true, true);
    // r:= BoundsRect;
    // InvalidateRect(Parent.handle, @r, False);
  end;

  invalidate;
  // InvalidateBorder;
end;

procedure TwwExpandButton.WMKillFocus(var Message: TWMKillFocus);
var
  r: TRect;
begin
  if parent is TCustomGrid then
  begin
    r := Rect(Left, Top, Left + Width, Top + Height);
    InvalidateRect(parent.Handle, @r, False);
  end;
end;

procedure TwwDBCustomCheckBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if (FDataLink.Field <> nil) then
    Modified := False;
end;

procedure TwwCustomCheckBox.WMSetFocus(var Message: TWMSetFocus);
var
  r: TRect;
  ExStyle, origStyle: longint;
begin
  inherited;

  SpaceKeyPressed := False;

  if isTransparentEffective and (not AlwaysTransparent) then
  begin
    origStyle := Windows.GetWindowLong(Handle, GWL_EXSTYLE);
    ExStyle := origStyle and not WS_EX_TRANSPARENT;
    Windows.SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
    invalidate;
  end;

  { if Frame.enabled then begin
    if IsTransparentEffective then begin
    r:= BoundsRect;
    InvalidateRect(Parent.Handle, @r, False);
    end;
    invalidate;
    end;
  }

  if isTransparentEffective and AlwaysTransparent then
  begin
    r := BoundsRect;
    InvalidateRect(parent.Handle, @r, False);
  end;
  invalidate;

  // if Frame.Enabled then {(not AlwaysTransparent) then }InvalidateBorder;
end;

procedure TwwCustomCheckBox.WMNCPaint(var Message: TMessage);
begin
  inherited;
  { if not Frame.Enabled then exit;
    Frame.Ncpaint(Focused, AlwaysTransparent);
    message.result:= 0;
  }
end;

constructor TwwCustomCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FShowText := true;
  // FShowAsButton:= True;
  FFrame := TwwEditFrame.Create(Self);
  FIndents := TwwWinButtonIndents.Create(Self);
  FValueChecked := 'True';
  FValueUnchecked := 'False';
  FShowFocusRect := true;
  FCenterTextVertically := true;
  FTextAlignment := taLeftJustify;

  if wwGridEssentials and not(csDesigning in ComponentState) then
  begin
    DisplayProfessionalVersionOnlyMessage(Self,
      'TwwCheckbox an TwwExpandButton are only supported in the professional version');
  end;

end;

function TwwCustomCheckBox.isTransparentEffective: boolean;
begin
  result := Frame.TRANSPARENT and Frame.IsFrameEffective
end;

Function TwwCustomCheckBox.IsMouseInControl(CheckAreaOnly
  : boolean = False): boolean;
var
  p: TPoint;
  AHandle: HWND;
  // c: TControl;
  r: TRect;
begin
  GetCursorPos(p);
  p := ScreenToClient(p);
  p.X := p.X + Left;
  p.Y := p.Y + Top;
  AHandle := ChildWindowFromPointEx(parent.Handle, p, CWP_SKIPINVISIBLE);
  // c:= FindControl(AHandle);
  result := FindControl(AHandle) = Self;
  if CheckAreaOnly then
  begin
    ComputeGlyphRect(r);
    InflateRect(r, 3, 3);
    GetCursorPos(p);
    p := ScreenToClient(p);
    if not PtInRect(r, p) then
      result := False;
  end;
end;

procedure TwwCustomCheckBox.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
end;

procedure TwwCustomCheckBox.DataChange(Sender: TObject);
begin
end;

procedure TwwCustomCheckBox.CMTextChanged(var Message: TMessage);
begin
  if isTransparentEffective and ((not Focused) or AlwaysTransparent) then
    Frame.RefreshTransparentText(False, False);

  inherited;
end;

procedure TwwCustomCheckBox.SetValueChecked(const Value: string);
begin
  FValueChecked := Value;
  DataChange(Self);
end;

procedure TwwCustomCheckBox.SetValueUnchecked(const Value: string);
begin
  FValueUnchecked := Value;
  DataChange(Self);
end;

procedure TwwCustomCheckBox.SetDisplayValueChecked(const Value: string);
begin
  FDisplayValueChecked := Value;
  invalidate;
end;

procedure TwwCustomCheckBox.SetDisplayValueUnchecked(const Value: string);
begin
  FDisplayValueUnchecked := Value;
  invalidate;
end;

function TwwCustomCheckBox.GetDisplayValueChecked: string;
begin
  if FDisplayValueChecked <> '' then
    result := FDisplayValueChecked
  else
    result := ValueChecked;
end;

function TwwCustomCheckBox.GetDisplayValueUnchecked: string;
begin
  if FDisplayValueUnchecked <> '' then
    result := FDisplayValueUnchecked
  else
    result := ValueUnchecked;
end;

constructor TwwDBCustomCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  // ControlStyle:= ControlStyle + [csCustomThemePaint];
  ControlStyle := ControlStyle + [csOverrideStylePaint];
  State := cbUnchecked;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  // FPaintControl := TPaintControl.Create(Self, 'BUTTON');
  // FPaintControl.Ctl3DButton := True;
end;

destructor TwwDBCustomCheckBox.Destroy;
begin
  // FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TwwDBCustomCheckBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource)
  then
    DataSource := nil;

end;

function TwwDBCustomCheckBox.UseRightToLeftAlignment: boolean;
begin
  result := DBUseRightToLeftAlignment(Self, Field);
end;

function TwwCustomCheckBox.GetFieldState: TCheckBoxState;
begin
  result := State;
end;

function TwwDBCustomCheckBox.GetFieldState: TCheckBoxState;
var
  Text: string;
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsNull then
      result := NullAndBlankState
    else if FDataLink.Field.DataType = ftBoolean then
      if FDataLink.Field.AsBoolean then
        result := cbChecked
      else
        result := cbUnchecked
    else
    begin
      // Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueChecked, Text) then
        result := cbChecked
      else if ValueMatch(FValueUnchecked, Text) then
        result := cbUnchecked
      else
        result := NullAndBlankState;

    end
  else
  begin
    // 5/29/2002 - If Databound and not active then use NullAndBlankState.
    if IsDataBound then
      result := NullAndBlankState
    else
      result := State;
  end;

  // Result := cbUnchecked;
end;

procedure TwwDBCustomCheckBox.DataChange(Sender: TObject);
begin
  State := GetFieldState;
  if (DataSource <> nil) and (DataSource.State = dsBrowse) then
    FModified := False;
end;

procedure TwwDBCustomCheckBox.UpdateData(Sender: TObject);
var
  Pos: integer;
  S: string;
begin
  if State = cbGrayed then
    FDataLink.Field.Clear
  else if FDataLink.Field.DataType = ftBoolean then
    FDataLink.Field.AsBoolean := Checked
  else
  begin
    if Checked then
      S := FValueChecked
    else
      S := FValueUnchecked;
    Pos := 1;
{$WARNINGS Off}
    FDataLink.Field.Text := ExtractFieldName(S, Pos);
{$WARNINGS On}
  end;
end;

function TwwDBCustomCheckBox.ValueMatch(const ValueList, Value: string)
  : boolean;
var
  Pos: integer;
begin
  result := False;
  Pos := 1;
  while Pos <= length(ValueList) do
{$WARNINGS Off}
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
{$WARNINGS On}
    begin
      result := true;
      Break;
    end;
end;

Function TwwDBCustomCheckBox.IsDataBound: boolean;
begin
  result := (DataSource <> nil) and (DataField <> '');
end;

function TwwCustomCheckBox.GetModified: boolean;
begin
  result := FModified;
end;

procedure TwwCustomCheckBox.SetModified(Value: boolean);
begin
  FModified := Value;
end;

procedure TwwDBCustomCheckBox.Toggle;
begin
  if IsDataBound then
  begin
    if FDataLink.Edit then
    begin
      FDataLink.Modified;
      Modified := true;
      inherited Toggle;
      // 6/29/04 - Move after setting datalink so state is accurate when event is fired
      // if not (csPaintCopy in ControlState) then modified:=True;
    end;
  end
  else if not ReadOnly then
    inherited Toggle
end;

function TwwDBCustomCheckBox.GetDataSource: TDataSource;
begin
  result := FDataLink.DataSource;
end;

procedure TwwDBCustomCheckBox.SetDataSource(Value: TDataSource);
begin
  if not(FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

function TwwDBCustomCheckBox.GetDataField: string;
begin
  result := FDataLink.FieldName;
end;

procedure TwwDBCustomCheckBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TwwDBCustomCheckBox.GetReadOnly: boolean;
begin
  result := FDataLink.ReadOnly;
end;

procedure TwwDBCustomCheckBox.SetReadOnly(Value: boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TwwDBCustomCheckBox.GetField: TField;
begin
  result := FDataLink.Field;
end;

procedure TwwDBCustomCheckBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        Modified := False;
      end
  end;
end;

procedure TwwDBCustomCheckBox.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TwwDBCustomCheckBox.WMPaint(var Message: TWMPaint);
// var OldState: TCheckboxState;
var
  tc: TColor;
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;

begin
  if not(csPaintCopy in ControlState) then
  begin
    inherited;
    PaintBorder;
  end
  else
  begin
    // OldState:= State;
    ClicksDisabled := true;
    Try
      // This code works for inspector
      tc := Font.Color; // Make compiler happy
      if IsInGridPaint(Self) and (message.dc <> 0) then
      begin
        tc := GetTextColor(message.dc);
        // bc:= GetBkColor(message.dc);
      end;
      CanvasNeeded;
      FCanvas.Handle := Message.dc;
      FCanvas.Font := Font;
      if IsInGridPaint(Self) and (message.dc <> 0) then
      begin
        FCanvas.Font.Color := tc;
        // FCanvas.Brush.Color:= bc;
      end;
      Paint;
      FCanvas.Handle := 0;

    finally
      ClicksDisabled := False;
    end;
  end;
end;

procedure TwwDBCustomCheckBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TwwDBCustomCheckBox.CMGetDataLink(var Message: TMessage);
begin
  Message.result := integer(FDataLink);
end;

function TwwDBCustomCheckBox.ExecuteAction(Action: TBasicAction): boolean;
begin
  result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TwwDBCustomCheckBox.UpdateAction(Action: TBasicAction): boolean;
begin
  result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

Function TwwCustomCheckBox.GetCanvas: TCanvas;
begin
  if Focused and (FPaintBitmap <> nil) then
    result := FPaintCanvas
  else
    result := FCanvas;
end;

procedure TwwCustomCheckBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_space then
  begin
    if SpaceKeyPressed then // 4/9/2013 - Don't toggle if parent is not grid
    begin
      if parent is TCustomGrid then
        Toggle;
    end;
    SpaceKeyPressed := False;
  end
end;

procedure TwwCustomCheckBox.KeyDown(var Key: Word; Shift: TShiftState);
  procedure SendToParent;
  begin
    parent.SetFocus;
    { If grid does not have focus then SetFocus raised exception }
    if parent.Focused then
      TwwDBGrid(parent).KeyDown(Key, Shift);
    Key := 0;
  end;

begin
  inherited;
  case Key of
    VK_ESCAPE:
      if (parent is TCustomGrid) then
      begin
        if not Modified then
          SendToParent;
      end;
    vk_space:
      begin
        SpaceKeyPressed := true;
      end
  end;
end;

procedure TwwCustomCheckBox.CNKeyDown(var Message: TWMKeyDown);
begin
  if not(csDesigning in ComponentState) then
  begin
    with Message do
      if (charcode = vk_space) then
        SpaceKeyPressed := true;
  end;

  inherited;
end;

procedure TwwCustomCheckBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then
      Images := nil;
    if (AComponent = FController) then
      FController := nil;
  end;
end;

procedure TwwCustomCheckBox.CNCommand(var Message: TWMCommand);
begin
  // Handle toggling ourselves instead of control
  // as when control is in inspector it does not work otherwise
  // Therefore we do not call inherited CNCommand

  // 11/20/12 - Ignore message only if we are in grid, instead of always
  // Handling through mouse up can cause issues since we could be opening a form up
  // and when the mouse is released it ends up being a toggle
  if not (parent is TCustomGrid) and
     (Message.NotifyCode = BN_CLICKED) then Toggle;

end;

procedure TwwCustomCheckBox.DoMouseEnter;
begin
  try
    If Assigned(FOnMouseEnter) Then
      FOnMouseEnter(Self);
  except
    exit;
  end;

  if wwUseThemes(Self) then
  begin
    invalidate;
  end;

  if Frame.IsFrameEffective and (not Focused) and Frame.MouseEnterSameAsFocus
  then
    wwDrawEdge(Self, Frame, GetCanvas, true);
end;

procedure TwwCustomCheckBox.DoMouseLeave;
begin
  try
    If Assigned(FOnMouseLeave) Then
      FOnMouseLeave(Self);
  except
    exit;
  end;
  if wwUseThemes(Self) then
  begin
    invalidate;
  end;

  if Frame.IsFrameEffective and (not Focused) and Frame.MouseEnterSameAsFocus
  then
  begin
    wwDrawEdge(Self, Frame, GetCanvas, False);
    if isTransparentEffective then
      Frame.CreateTransparent := true;
    RecreateWnd;
  end;
end;

procedure TwwCustomCheckBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoMouseEnter;
  // if cslButtonDown in ControlState then
  // Invalidate;
end;

procedure TwwCustomCheckBox.CMMouseLeave(var Message: TMessage);
var
  r: TRect;
  pt: TPoint;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  r := ClientRect;
  if (PtInRect(r, pt)) then
    exit;

  inherited;
  DoMouseLeave;

  // if cslButtonDown in ControlState then Invalidate;
end;

function TwwCustomCheckBox.GetField: TField;
begin
  result := nil;
end;

procedure TwwCustomCheckBox.EMGetModify(var Message: TMessage);
begin
  If FModified then
    message.result := 1
  else
    message.result := 0;
end;

procedure TwwExpandButton.CMExit(var Message: TCMExit);
begin
  inherited;
end;

procedure TwwExpandButton.CMShowingChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TwwExpandButton.DataChange(Sender: TObject);
begin
  if (DataSource <> nil) and (DataSource.State = dsBrowse) and
    not InClickEvent and not InRefreshCalcField then
  begin
    if State <> cbUnchecked then
      Toggle;
  end
  // state:= cbUnchecked;
end;

function TwwExpandButton.GetFieldState: TCheckBoxState;
begin
  result := inherited GetFieldState;
  if (csPaintCopy in ControlState) then
  begin
    result := cbUnchecked;
    if (parent is TCustomGrid) and (Grid <> nil) and Grid.Visible and PaintAsExpanded
    then
      result := cbChecked;
  end;

  // Return cbChecked if child grid is visible and
  // this is the active column, row
end;

procedure TwwExpandButton.Toggle;
var
  OrigChecked: boolean;
  // TempCol, TempRow: integer;
begin
  if InToggle then
    exit;

  OrigChecked := Checked;
  InToggle := true;
  try
    // 6/1/01 - Prevent grid's custom edit from moving beyond grid boundaries
    if wwIsClass(parent.classtype, 'TwwDBGrid') then
      TwwDBGrid(parent).SkipHideControls := true;

    if Checked then
      DoBeforeCollapse
    else
      DoBeforeExpand;

    if (OrigChecked = Checked) then
    begin
      case State of
        cbUnchecked:
          if AllowGrayed then
            State := cbGrayed
          else
          begin
            if parent is TwwDBGrid then
              with TwwDBGrid(parent) do
              begin
                if RowHeightPercent <> MinRowHeightPercent then
                begin
                  RestoreRowHeights;
                  Update; // Updates our position
                end
              end;
            State := cbChecked;
          end;
        cbChecked:
          State := cbUnchecked;
        cbGrayed:
          State := cbChecked;
      end;
    end;

    if Checked then
      DoAfterExpand
    else
      DoAfterCollapse;

  finally
    InToggle := False;
    TwwDBGrid(parent).SkipHideControls := False;
  end
end;

procedure TwwExpandButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FGrid <> nil) and (AComponent = FGrid) then
    FGrid := nil;
end;

function TwwCustomCheckBox.FillBackground: boolean;
begin
  result := true;
end;

function TwwExpandButton.FillBackground: boolean;
begin
  result := not Checked;
end;

procedure TwwExpandButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if (parent is TCustomGrid) then
  begin
    if (not Focused) then
      message.result := 1
    else if TStyleManager.IsCustomStyleActive and wwUseThemes(Self) then
    begin
      // paint grid active cell background for styles
      wwPaintActiveGridCellBackgroundColor(self, Canvas);
      message.result := 1 // let theme handle it
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TwwExpandButton.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
end;

procedure TwwExpandButton.Click;
var
  parentGrid: TwwDBGrid;
  p: TPoint;
  // RowsNeeded: integer;
  SpaceAvailable, SpaceNeeded: integer;
  ShiftAmount: integer;
  DefaultRowHeight: integer;
  // BorderOffset, TitleOffset: integer;
  TerminalNode: boolean;
  i: integer;
  TrueScrollAmount: integer;
  // OrigShiftAmount: integer;
  OrigDesiredRow: integer;
  SkipSetTop: boolean;
  ParentParentGrid: TwwDBGrid;
  DesiredRowHeightParent: integer;
  r: TRect;
  TempDesiredRow: integer;
  OrigActiveRecord: integer;
  ParentForm: TCustomForm;
  // NegativeScrollAmount: integer;
  // OldRowCount: integer;

  procedure ClearHorzRange;
  begin
    if TDrawGrid(Grid).ScrollBars in [ssHorizontal, ssBoth] then
      SetScrollRange(Grid.Handle, SB_HORZ, 0, 0, true);
  end;

  procedure SetRow(val: integer);
  var
    DrawInfo: TGridDrawInfo;
    OldLeft: integer;
  begin
    OldLeft := Left; // In case control's left is changed by grid
    if (Grid <> nil) and (not wwIsClass(Grid.classtype, 'TwwDBGrid')) then
      Grid.Update;
    with parentGrid do
    begin
      BeginUpdate;
      CalcDrawInfo(DrawInfo);
      TDrawGrid(parentGrid).row := val;
      // Fix case where inherited grid gets confused on fixed columns
      if LeftCol < DrawInfo.Horz.FixedCellCount then
      begin
        LeftCol := DrawInfo.Horz.FixedCellCount;
      end;
      EndUpdate;
      invalidate;
    end;
    Left := OldLeft;
  end;

begin
  if InRefreshCalcField then
    exit; // Don't collapse if refreshing
  if InClickEvent then
    exit;
  if Grid = nil then
    exit;
  // screen.cursor:= crarrow;

  inherited Click;
  if not(parent is TCustomGrid) then
    exit;
  if Grid = nil then
    exit;

  SkipSetTop := False;

  parentGrid := TwwDBGrid(parent);
  DefaultRowHeight := TDrawGrid(parentGrid).DefaultRowHeight;
  OrigDesiredRow := DesiredRow;

  // Check if gird has any expandbuttons.  If so, then
  // we don't allow shrinkage as we need to accomodate embedded grid.
  TerminalNode := true;
  for i := 0 to Grid.ControlCount - 1 do
    if Grid.Controls[i] is TwwExpandButton then
      TerminalNode := False;
  // TempAutoShrink:= AutoShrink;

  InClickEvent := true;

  try
    if Checked then
    begin
      BeforeExpandHeightOfParentGrid := 0;
      if OriginalHeight = 0 then
        OriginalHeight := Grid.Height;

      if (Grid is TwwDBGrid) then
        with TwwDBGrid(Grid) do
        begin
          // if TerminalNode and (AutoShrink = easTerminalGrid) or
          // (AutoShrink = easAllGrids) then
          Grid.parent := Self.parent;
          // Set parent now so RowHeights are accurate

          if { TerminalNode and } AutoShrink then
          begin
            ClearHorzRange; // So UpdateRowCount works accurately
            Height := OriginalHeight;
            UpdateRowCount;
            // OldRowCount:= GetRowCount;
            DoShrinkToFit;
            // if GetRowCount<OldRowCount then
            // SetScrollRange(Handle, SB_VERT, 0, 0, False);
            // UpdateRowCount;
            // Height:= Height;
          end
        end
      else
        Grid.parent := Self.parent; // Set parent now so RowHeights are accurate

      // ! increase parentgrid height if its also a childgrid
      // Not easily done, as then we need to recompute parent's rowoffset
      // Instead let us just allow AutoShrink only for terminal nodes
      with parentGrid do
      begin
        // SpaceAvailable:= ClientHeight - CellRect(0, TDrawGrid(parentGrid).Row).Bottom;
        // 10/10/01 - Use Leftcol instead of 0 in case indicator column is not visible
        SpaceAvailable := ClientHeight - CellRect(LeftCol,
          TDrawGrid(parentGrid).row).Bottom;
        if TerminalNode then
          SpaceNeeded := Grid.Height - 1 - SpaceAvailable
        else
          SpaceNeeded := OriginalHeight - 1 - SpaceAvailable;
        if SpaceNeeded > 0 then
        begin
          if parentGrid.haveanyrowlines then
            ShiftAmount := SpaceNeeded div (DefaultRowHeight + 1) + 1
          else
            ShiftAmount := SpaceNeeded div (DefaultRowHeight) + 1
        end
        else
          ShiftAmount := 0;

        if (parentGrid is TwwDBGrid) then
        begin
          // Compute desired row based on having enough
          // space to display the entire original grid
          // Note: Make desired row smaller, never make larger
          if (dgTitles in Options) and (AutoShrink) and (not TerminalNode) then
          begin
            TempDesiredRow := (ClientHeight - (OriginalHeight + Self.Height + 1)
              - (RowHeights[0] + 2 { +Grid.GetEffectiveFooterHeight } ))
              div DefaultRowHeight + 1;
            if DesiredRow = -1 then
            begin
              DesiredRow := wwMin(TempDesiredRow, TDrawGrid(parentGrid).row -
                ShiftAmount);
            end
            else
              DesiredRow := wwMin(DesiredRow, TempDesiredRow);
          end
        end;
        if (DesiredRow >= 0) and (ShiftAmount > 0) then
        begin
          // Update desired row based on new shift amount
          // Never make DesiredRow larger as we don't need to do this to help the space issue
          DesiredRow := wwMin(DesiredRow, TDrawGrid(parentGrid).row -
            ShiftAmount);
        end;
        // OrigShiftAmount:= ShiftAmount;
        if DesiredRow < 0 then
        begin
          ShiftAmount := wwMin(ShiftAmount, GetActiveRow);
          // DesiredRow:= 1;
        end
        else
        begin
          // Force current record to top if changing rows to something earlier

          // Need to get more records in buffer so taht there can be
          // records after auto-shrinked grid
          ShiftAmount := 0;

          if DataLink.BufferCount - DesiredRow <> 0 then
            with DataSource.DataSet do
              try
                OrigActiveRecord := DataLink.ActiveRecord;

                // Scrolls forward
                TrueScrollAmount := MoveBy(DataLink.BufferCount - (DesiredRow));
                // -DataLink.ActiveRecord);
                if TrueScrollAmount < DataLink.BufferCount - (DesiredRow) then
                // reached eof
                begin
                  MoveBy(-TrueScrollAmount); // Move back
                  ShiftAmount := DataLink.ActiveRecord + 1 - DesiredRow;
                  if ShiftAmount < 0 then
                  begin
                    raise EwwExpandError.Create
                      ('Shift Amount: ' + inttostr(ShiftAmount) + #13 +
                      'True Scroll Amount: ' + inttostr(TrueScrollAmount) + #13
                      + 'OrigActiveRecord: ' + inttostr(OrigActiveRecord) + #13
                      + 'DesiredRow: ' + inttostr(DesiredRow) + #13 +
                      'OrigDesiredRow: ' + inttostr(OrigDesiredRow) + #13);
                    // ShiftAmount:= 0;
                  end;
                end
                else
                begin
                  MoveBy(-TrueScrollAmount); // Scroll back
                  // ShiftAmount:= RowOffset;
                  // DataLink.ActiveRecord:=RowOffset;
                end

              finally
              end;

          SetRow(DesiredRow);
          ExpandedGridRow := DesiredRow;
          Self.Top := parentGrid.CellRect(TDrawGrid(parentGrid).Col,
            TDrawGrid(parentGrid).row).Top;
          SkipSetTop := true;
          Self.Visible := true;
        end
      end;

      if not SkipSetTop then
      begin
        if parentGrid.haveanyrowlines then
          Top := Top - ShiftAmount * (DefaultRowHeight + 1)
        else
          Top := Top - ShiftAmount * DefaultRowHeight;
      end;
      if wwIsClass(Grid.classtype, 'TwwDBGrid') then
        TDrawGrid(FGrid).Ctl3D := False;
      Grid.parent := Self.parent;

      // 6/24/04 - Support RightToLeft
      if parentGrid.UseRightToLeftAlignment then
      begin
        p := Point(Left - 11, Top + Height);
        Grid.Top := p.Y + GridIndents.Y;
        Grid.Left := p.X - Grid.Width + GridIndents.X;
      end
      else
      begin
        p := Point(Left + 11, Top + Height);
        Grid.Top := p.Y + GridIndents.Y;
        Grid.Left := p.X + GridIndents.X;
      end;
{$IFDEF wwDelphi7Up}
      if wwUseThemes(Self) then
        Grid.ControlStyle := Grid.ControlStyle - [csParentBackground];
{$ENDIF}
      Grid.Visible := true;
      Grid.SetFocus;
      // Expand parent grid if it has been auto-shrinked
      with parentGrid do
      begin
        if (parentGrid.parent is TwwDBGrid) then
        begin
          ParentParentGrid := TwwDBGrid(parentGrid.parent);

          if (ParentParentGrid.ActiveExpandButton <> nil) and
            (TwwExpandButton(ParentParentGrid.ActiveExpandButton).AutoShrink)
          then
          begin
            DesiredRowHeightParent :=
              wwMin(TwwExpandButton(ParentParentGrid.ActiveExpandButton)
              .OriginalHeight, Height + Grid.Height);
            BeforeExpandHeightOfParentGrid := Height;
            BeforeExpandRowHeight := ParentParentGrid.RowHeights
              [TDrawGrid(ParentParentGrid).row];
            Height := DesiredRowHeightParent;
            ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).row] :=
              DesiredRowHeightParent + TDrawGrid(ParentParentGrid)
              .DefaultRowHeight - 1; // RSW Added -1 to make grid fit better
          end
        end
      end;

      with parentGrid do
      begin

        RowOffset := ShiftAmount;
        if not SkipSetTop then
          ExpandedGridRow := DataLink.ActiveRecord + parentGrid.TitleOffset -
            RowOffset;
        RowHeights[ExpandedGridRow] := RowHeights[ExpandedGridRow] + Grid.Height
          - 1 { +1 }; // Subtract 1 instead of adding 1 for better fit

        // Expand parent grid
        { if (ParentGrid.Parent is TwwDBGrid) then
          begin
          ParentParentGrid:= TwwDBGrid(ParentGrid.Parent);

          if (ParentParentGrid.ActiveExpandButton<>nil) then
          begin
          DesiredRowHeightParent:=
          wwMin(TwwExpandButton(ParentParentGrid.ActiveExpandButton).OriginalHeight, Height + Grid.Height);
          BeforeExpandHeightOfParentGrid:= Height;
          Height:= DesiredRowHeightParent;
          ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).Row]:=
          DesiredRowHeightParent + TDrawGrid(ParentParentGrid).DefaultRowHeight;
          end
          end
        }
      end;
      { if wwdbigrd.dgTitles in ParentGrid.Options then
        TDrawGrid(ParentGrid).Row:= ParentGrid.DataLink.ActiveRecord+1-ParentGrid.RowOffset
        else
        TDrawGrid(ParentGrid).Row:= ParentGrid.DataLink.ActiveRecord-ParentGrid.RowOffset;
      }
      // parentGrid.BeginUpdate;
      // TDrawGrid(parentGrid).row:= ExpandedGridRow;
      SetRow(ExpandedGridRow);
      // parentGrid.EndUpdate;
      // parentGrid.invalidate;
      // DoAfterExpand;
    end
    else
    begin
      // Collapse grid's expanded grids
      for i := 0 to Grid.ControlCount - 1 do
        if Grid.Controls[i] is TwwExpandButton then
        begin
          if TwwExpandButton(Grid.Controls[i]).Expanded then
            TwwExpandButton(Grid.Controls[i]).Expanded := False;
        end;

      Grid.Visible := False;

      ParentForm := GetParentForm(parentGrid);
      // 4/19/05 - Check if parent is visible before setting focus

      if (ParentForm <> nil) and (ParentForm.Visible) and // 4/19/05
        parentGrid.CanFocus and not(csDestroying in ComponentState) then
        // 8/1/02 - Don't set focus if destroying
        parentGrid.SetFocus;

      if ExpandedGridRow < parentGrid.GetRowCount then
        parentGrid.RowHeights[ExpandedGridRow] := DefaultRowHeight;
      // ParentGrid.Rowheights[ParentGrid.getactiverow+1]:=
      // DefaultRowHeight;
      // 10/15/01-Don't set row if datalink.dataset is nil.
      if parentGrid.DataLink.DataSet <> nil then
        SetRow(parentGrid.DataLink.ActiveRecord + parentGrid.TitleOffset);
      parentGrid.RowOffset := 0;

      if parent.parent is TCustomGrid then // Prevent flicker when collapsing
      begin
        ValidateRect(parent.parent.Handle, nil);
        r := Rect(parentGrid.Left, parentGrid.Top,
          parentGrid.Left + parentGrid.Width,
          parentGrid.Top + parentGrid.Height);
        if dgTitles in parentGrid.Options then
          r.Top := r.Top + parentGrid.RowHeights[0] + 2;

        InvalidateRect(parent.parent.Handle, @r, False);
      end;

      // Restore previous height before expanding parentparentgrid
      if (BeforeExpandHeightOfParentGrid <> 0) then
      begin
        ParentParentGrid := parent.parent as TwwDBGrid;
        parentGrid.Height := BeforeExpandHeightOfParentGrid;
        ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).row] :=
          BeforeExpandRowHeight;
      end;
      // ParentGrid.UpdateRowCount;
    end;

  finally
    InClickEvent := False;
    DesiredRow := -1;
  end;
end;

constructor TwwExpandGridIndents.Create(AOwner: TComponent);
begin
  if AOwner is TWinControl then
    FWinControl := TWinControl(AOwner)
end;

constructor TwwExpandButton.Create(AOwner: TComponent);
var
  Bmp: TBitmap;
begin
  inherited;
  FShowText := False;
  ShowBoxAroundGlyph := true;
  // FShowAsButton:= True;
  FGridIndents := TwwExpandGridIndents.Create(Self);
  FAutoShrink := true; // easAllGrids;
  DesiredRow := -1;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, 'WWEXPAND');
    FExpandImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FExpandImages.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, 'WWCOLLAPSE');
    FExpandImages.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end
end;

destructor TwwExpandButton.Destroy;
begin
  FExpandImages.Free;
  FGridIndents.Free;
  inherited;
end;

function TwwCustomCheckBox.GetImageList: TImageList;
begin
  result := TImageList(Images);
end;

function TwwExpandButton.GetImageList: TImageList;
begin
  result := inherited GetImageList;
  if result = nil then
    result := FExpandImages;
end;

Function TwwCustomCheckBox.GetExtraIndentX: integer;
begin
  result := 0;
end;

Function TwwExpandButton.GetExtraIndentX: integer;
begin
  result := 2;
end;

procedure TwwExpandButton.SetGrid(Value: TWinControl);
begin
  FGrid := Value;
  if FGrid <> nil then
  begin
    FGrid.Visible := False;
    if wwIsClass(Grid.classtype, 'TwwDBGrid') then
      TDrawGrid(FGrid).Ctl3D := False;
  end
end;

procedure TwwExpandButton.SetExpanded(val: boolean);
begin
  if GetExpanded <> val then
  begin
    // FExpanded:= Val;
    // 5/29/01
    if val and wwIsClass(parent.classtype, 'TwwDBGrid') then
      TwwDBGrid(parent).UpdateCustomEdit;
    Toggle;
  end
end;

procedure TwwExpandButton.DoAfterExpand;
begin
  if Assigned(FOnAfterExpand) then
    FOnAfterExpand(Self);
end;

procedure TwwExpandButton.DoAfterCollapse;
begin
  if Assigned(FOnAfterCollapse) then
    FOnAfterCollapse(Self);
end;

procedure TwwExpandButton.DoBeforeExpand;
begin
  if Assigned(FOnBeforeExpand) then
    FOnBeforeExpand(Self);
end;

procedure TwwExpandButton.DoBeforeCollapse;
begin
  if Assigned(FOnBeforeCollapse) then
    FOnBeforeCollapse(Self);
end;

Function TwwExpandButton.GetDisplayText: string;
begin
  if (FDataLink <> nil) and (FDataLink.Field <> nil) and
    (FDataLink.DataSet <> nil) and (FDataLink.DataSet.Active) then
    result := FDataLink.Field.DisplayText
  else
    result := ''
end;

Function TwwCustomCheckBox.GetDisplayText: string;
var
  PaintFieldState: TCheckBoxState;
begin
  if DynamicCaption then
  begin
    if csPaintCopy in ControlState then
    begin
      PaintFieldState := GetFieldState;
      if (PaintFieldState = cbChecked) then
        result := DisplayValueChecked
      else if PaintFieldState = cbUnchecked then
        result := DisplayValueUnchecked
      else
        result := ''
    end
    else
      result := Caption
  end
  else
    result := Caption;
end;

function TwwCustomCheckBox.HideExpand: boolean;
begin
  result := False;
end;

function TwwExpandButton.HideExpand: boolean;
var
  AShowExpand: boolean;
begin
  result := False;

  if (not(csDesigning in ComponentState)) and AutoHideExpand then
  begin
    if (FDataLink.Field = nil) or (FDataLink.DataSet = nil) or
      (not FDataLink.DataSet.Active) or FDataLink.Field.IsNull or
      (FDataLink.Field.asString = '0') then

      if (IsInGridPaint(Self)) or (not IsInGridPaint(Self)) and (Grid <> nil)
        and (not Grid.Visible) then
        result := true;
  end;

  // Add new event to allow customization of expand button's visibility.
  if Assigned(FOnCheckVisibleButton) and Assigned(FDataLink.DataSet) then
  begin
    AShowExpand := not result;
    FOnCheckVisibleButton(Self, FDataLink.DataSet, AShowExpand);
    result := not AShowExpand;
  end;
end;

type
  TCheatDataset = class(TDataSet);

procedure TwwExpandButton.RefreshCalcField;

  procedure CalcFieldRefresh;
  var
    ParentDataSet: TDataSet;
  begin
    if not(parent is TwwDBGrid) then
      exit;
    if TwwDBGrid(parent).DataSource = nil then
      exit;

    ParentDataSet := TwwDBGrid(parent).DataSource.DataSet;
    if (ParentDataSet = nil) or (not ParentDataSet.Active) then
      exit;

    if FDataLink.Field.Calculated or FDataLink.Field.lookup then
    begin
      InRefreshCalcField := true;
      try
        TCheatDataset(ParentDataSet).GetCalcFields(TCheatDataset(ParentDataSet)
          .ActiveBuffer);
        TCheatDataset(ParentDataSet).DataEvent(deRecordChange, 0);
      finally
        ValidateRect(parent.Handle, nil);
        // Don't repaint as it will flicker entire parent grid
        InRefreshCalcField := False;
      end;
    end;

  end;

begin
  // InRefreshCalc:= True;
  CalcFieldRefresh;
  // inherited Refresh;
  // InRefreshCalc:= False;
end;

function TwwExpandButton.GetExpanded: boolean;
begin
  result := Checked;
end;

procedure TwwExpandButton.BMSetCheck(var Message: TMessage);
begin
  inherited;
end;

function TwwExpandButton.GetAlignment: TAlignment;
begin
  if ButtonAlignment = taLeftJustify then
    result := taRightJustify
  else if ButtonAlignment = taRightJustify then
    result := taLeftJustify
  else
    result := taCenter
end;

function TwwCustomCheckBox.GetAlignment: TAlignment;
begin
  result := Alignment;
end;

procedure TwwExpandButton.ResetHeight;
begin
  OriginalHeight := 0;
end;

var
  WM_EXPANDBUTTONDROPDOWN: UINT = 0;

procedure TwwExpandButton.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_EXPANDBUTTONDROPDOWN then
  begin { 6/8/00 }
    Expanded := true;
  end
  else
    inherited;
end;

procedure TwwExpandButton.ExpandAfterDelay;
begin
  PostMessage(Handle, WM_EXPANDBUTTONDROPDOWN, 0, 0);
end;

function TwwExpandButton.GetDrawFlags: integer;
begin
  result := DT_NOPREFIX;
end;

function TwwCustomCheckBox.GetDrawFlags: integer;
begin
  result := 0;
end;

procedure TwwCustomCheckBox.SetController(Value: TwwController);
begin
  if FController <> Value then
  begin
    wwUpdateController(TComponent(FController), Value, Self);
    if FController <> nil then
    begin
      FFrame.Assign(FController.Frame);
      if HandleAllocated then
        RecreateWnd;
    end
  end
end;

initialization

WM_EXPANDBUTTONDROPDOWN := RegisterWindowMessage('IPEXPANDBUTTONDROPDOWN');

end.
