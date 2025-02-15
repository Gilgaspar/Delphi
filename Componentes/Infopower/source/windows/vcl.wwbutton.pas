unit vcl.wwbutton;
{
//
// Components : TwwButton
//
// Copyright (c) 2012 by Woll2Woll Software
//
}
interface

{$i wwIfDef.pas}

uses Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls,
  CommCtrl, Buttons, Dialogs, Math, Consts, SysUtils, wwcommon, wwBitmap, wwChangeLink,
  TypInfo, dbctrls, db, system.Types, system.UITypes,
  Themes, Grids,
  ImgList, ActnList,
  variants,
  wwframe, wwstr,
  wwText;

const DESIGN_KEY = VK_MENU;
      WWDEFUNUSECOLOR = clRed;
      WWDEFUNUSECOLOR2 = clBlue;

type
  TwwDitherStyle = (wwdsDither, wwdsBlendDither, wwdsFill);
  TwwShadeStyle = (wwbsNormal, wwbsRaised, wwbsHighlight, wwbsFlat);
  TwwButtonShape = (wwbsRoundRect, wwbsEllipse, wwbsTriangle, wwbsArrow, wwbsDiamond,
    wwbsRect, wwbsStar, wwbsTrapezoid, wwbsCustom, wwbsSystemStyle);
  TwwShapeOrientation = (wwsoLeft, wwsoRight, wwsoUp, wwsoDown);
  PwwPolyGonPoints = ^TwwPolyGonPoints;
  TwwPolyGonPoints = array[0..20] of TPoint;

  TwwButtonOption = (boFocusable, boOverrideActionGlyph, boToggleOnUp,
    boFocusRect, boAutoBold);
  TwwButtonOptions = set of TwwButtonOption;

  TwwCustomBitBtn = class;
  TwwCustomBitBtnClass = class of TwwCustomBitBtn;
  TwwButtonGetCaptionEvent = procedure(Sender: TObject; var ACaption: string)
    of object;

  TwwRegionData = record
    dwSize: Integer;
    rgnData: PRgnData;
  end;
  PwwRegionData = ^TwwRegionData;

  TwwOffsets =  class(TPersistent)
  private
    // Property Storage Variables
    FControl: TWinControl;
    FGlyphX: Integer;
    FGlyphY: Integer;
    FTextX: Integer;
    FTextY: Integer;
    FTextDownX: Integer;
    FTextDownY: Integer;
    procedure SetGlyphX(Value: Integer);
    procedure SetGlyphY(Value: Integer);
    procedure SetTextX(Value: Integer);
    procedure SetTextY(Value: Integer);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    property Control: TWinControl read FControl;
  public
    constructor Create(Button: TwwCustomBitBtn);
  published
    property GlyphX: Integer read FGlyphX write SetGlyphX default 0;
    property GlyphY: Integer read FGlyphY write SetGlyphY default 0;
    property TextX: Integer read FTextX write SetTextX default 0;
    property TextY: Integer read FTextY write SetTextY default 0;
    property TextDownX: Integer read FTextDownX write FTextDownX default 1;
    property TextDownY: Integer read FTextDownY write FTextDownY default 1;
  end;

  TwwShadeColors = class(TPersistent)
  private
    FButton: TwwCustomBitBtn;
    FBtnHighlight: TColor;
    FBtn3dLight: TColor;
    FBtnShadow: TColor;
    FBtnBlack: TColor;
    FBtnFocus: TColor;
    FShadow: TColor;
    procedure SetBtn3DLight(Value: TColor);
    procedure SetBtnBlack(Value: TColor);
    procedure SetBtnHighlight(Value: TColor);
    procedure SetBtnShadow(Value: TColor);
    procedure SetBtnFocus(Value: TColor);
    procedure SetShadow(Value: TColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Button: TwwCustomBitBtn);
  published
    property Btn3DLight: TColor read FBtn3DLight write SetBtn3DLight default cl3DLight;
    property BtnHighlight: TColor read FBtnHighlight write SetBtnHighlight default clBtnHighlight;
    property BtnShadow: TColor read FBtnShadow write SetBtnShadow default clBtnShadow;
    property BtnBlack: TColor read FBtnBlack write SetBtnBlack default clBlack;
    property BtnFocus: TColor read FBtnFocus write SetBtnFocus default clBlack;
    property Shadow: TColor read FShadow write SetShadow default clBlack;
  end;

  TwwCustomBitBtn = class(TWinControl)
  private
    // Property Storage Variables
    FPointList: TStringList;
    FActive: Boolean;
    FAllowAllUp: Boolean;
    FCancel: Boolean;
    FDefault: Boolean;
    FDown: Boolean;
    FGlyph: TBitmap;
    FGroupIndex: Integer;
    FInMouseSendForMouseActivate:Boolean;
    FKind: TBitBtnKind;
    FLayout: TButtonLayout;
    FMargin: Integer;
    FModalResult: TModalResult;
    FNumGlyphs: TNumGlyphs;
    FRegion, FLastRegion: HRgn;
    FShadeColors: TwwShadeColors;
    FShadeStyle: TwwShadeStyle;  // Published
    FShowFocusRect: Boolean;
    FSpacing: Integer;
    FStyle: TButtonStyle;
    FTextOptions: TwwCaptionText;
    FSmoothFont: boolean;
    FOnGetCaption: TwwButtonGetCaptionEvent;
    FGlyphRect: TRect;
    FTextRect: TRect;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnSelChange: TNotifyEvent;
    FOnSetName: TNotifyEvent;

    FCanvas: TCanvas;
    FOffsets: TwwOffsets;
    FModifiedGlyph: Boolean;
    FOptions: TwwButtonOptions;
    FChangeLinks: TList;
    FChangeLink: TwwChangeLink;
    FClicked: Boolean;
    FInitialDown: Boolean;
    FEvents: TStringList;
    FUseHalftonePalette: boolean;
    FShowDownAsUp:boolean;
    FHot: boolean;
    FDataLink: TFieldDataLink;
    FDisableThemes: boolean;
    FStaticCaption: boolean;
    FShape: TwwButtonShape;
    FOrientation: TwwShapeOrientation;

    FDitherColor: TColor;
    FDitherStyle: TwwDitherStyle;
    FRoundRectBias: Integer;


    // Property Access Methods
    procedure SetOrientation(Value: TwwShapeOrientation);
    procedure SetPointList(Value: TStringList);
    procedure SetRoundRectBias(Value: Integer);
    procedure SetDitherColor(Value: TColor);
    procedure SetDitherStyle(Value: TwwDitherStyle);
    procedure SetShape(Value: TwwButtonShape);
    function GetKind: TBitBtnKind;
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetButtonDown(Value: Boolean; CheckAllowAllUp: Boolean; DoUpdateExclusive: Boolean; DoInvalidate: Boolean);
    procedure SetDefault(Value: Boolean);
    procedure SetDown(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGroupIndex(Value: Integer);
    procedure SetKind(Value: TBitBtnKind);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure SetOptions(Value: TwwButtonOptions);
    procedure SetSpacing(Value: Integer);
    procedure SetShadeStyle(Value: TwwShadeStyle);
    procedure SetStyle(Value: TButtonStyle);

    // Message Handlers
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure ProcessMouseUp(X, Y: Integer; AMouseInControl: Boolean; AClicked: Boolean);
    procedure ProcessMouseDown;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure DoComputeCanvasAttributes(ACanvas: TCanvas); virtual;
  protected
    FDownRegionData: TwwRegionData;
    FRegionData: TwwRegionData;
    FSelected: Boolean;
    DisableButton: boolean;

    procedure SetPointToOrientation(Points: PwwPolygonPoints;
      NumPoints: Integer; Orientation: TwwShapeOrientation; Size: TSize);
    function GetCustomPoints(var Points: PwwPolygonPoints; Size: TSize): Integer;
    function GetStarPoints(var Points: PwwPolygonPoints; Size: TSize): Integer;
    function CorrectedColor: TColor;
    function UnusableColor: TColor;
    function RoundShape: Boolean; virtual;
    function GetField: TField;
    function GetDBCaption: string; virtual;
//    procedure SetCaption(val: string); virtual;
    // Overriden Methods
    function GetPalette: HPALETTE; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetName(const Value: TComponentName); override;

    // Virtual Methods
    procedure GetEvents(const s: string);
    function CreateOffsets: TwwOffsets; virtual;
    function CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn; virtual;
    function CalcButtonLayout(Canvas: TCanvas; Client: TRect; var TextRect: TRect;
      var GlyphRect: TRect; TextSize: TSize): TRect; virtual;
    function GlyphWidth: Integer; virtual;
    function IsCustom: Boolean; virtual;
    function IsCustomCaption: Boolean; virtual;
    function MouseInControl(X, Y: Integer; AndClicked: Boolean): Boolean;
    function StoreRegionData: Boolean; virtual;
    procedure ChangeButtonDown; virtual;
    procedure CleanUp; virtual;
    procedure ClearRegion(ARgnData: PwwRegionData); virtual;
    procedure DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint); virtual;
    procedure DrawButtonText(Canvas: TCanvas; TextBounds: TRect); virtual;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct); virtual;
//    procedure GetDrawBitmap(ACanvas: TCanvas; ForRegion: Boolean;
//      ShadeStyle: TwwShadeStyle; Down: Boolean; InPaint: boolean = false); overload; virtual;
    procedure GetDrawBitmap(DrawBitmap: TwwBitmap; ForRegion: Boolean;
      ShadeStyle: TwwShadeStyle; Down: Boolean; InPaint: boolean = false); overload; virtual;
    procedure GlyphChanged(Sender: TObject); virtual;
    procedure NotifyChange; virtual;
    procedure NotifyChanging; virtual;
    procedure NotifyLoaded; virtual;
    procedure Paint; virtual;
    procedure Redraw; virtual;
    procedure ReadRegionData(Stream: TStream); virtual;
    procedure ReadDownRegionData(Stream: TStream); virtual;
    procedure SaveRegion(NewRegion: Longword; Down: Boolean); virtual;
    procedure SelChange; virtual;
//    procedure WriteState(Writer: TWriter); override;
    procedure WndProc(var Message: TMessage); override;
    procedure WriteRegionData(Stream: TStream); virtual;
    procedure WriteDownRegionData(Stream: TStream); virtual;
    procedure UpdateExclusive; virtual;
    function UseRegions: boolean; virtual;

    // Protected Properties
    property Active: Boolean read FActive;
    property Canvas: TCanvas read FCanvas;
    property GlyphRect: TRect read FGlyphRect;
    property TextRect: TRect read FTextRect;
    property InitalDown: Boolean read FInitialDown;
    property Clicked: Boolean read FClicked;
    procedure DataChange(Sender: TObject); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure Draw3dLines(Bitmap: TwwBitmap; PointList: array of TPoint;
      NumPoints: Integer; TransColor: TColor; PaintBitmap: TwwBitmap = nil); overload; virtual;
    procedure Draw3DLines(SrcBitmap, DstBitmap: TwwBitmap; TransColor: TColor; Down: Boolean); overload; virtual;
    function GetPolygonPoints(var Points: PwwPolyGonPoints): Integer;
  public
    BasePatch: Variant;
    property Region: HRGN read FRegion;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Virtual Methods
    procedure ApplyRegion; virtual;
    procedure InvalidateNotRegion(const Erase: Boolean); virtual;

    function Draw(Canvas: TCanvas): TRect; virtual;
    function IsMultipleRegions: Boolean; virtual;
    procedure Click; override;
    procedure SizeToDefault; virtual;
    procedure UpdateShadeColors(Color: TColor); virtual;

    procedure RegisterChanges(Value: TwwChangeLink); virtual;
    procedure UnRegisterChanges(Value: TwwChangeLink); virtual;

    function GetTextEnabled: Boolean; virtual;
    procedure AdjustBounds; virtual;

    // Public Properties
    property PointList: TStringList read FPointList write SetPointList;
    property Orientation: TwwShapeOrientation read FOrientation write SetOrientation default wwsoUp;
    property RoundRectBias: Integer read FRoundRectBias write SetRoundRectBias default 0;
    property Shape: TwwButtonShape read FShape write SetShape default wwbsSystemStyle;
    property ShowDownAsUp: Boolean read FShowDownAsUp write FShowDownAsUp default False;
    property DitherColor: TColor read FDitherColor write SetDitherColor;
    property DitherStyle: TwwDitherStyle read FDitherStyle write SetDitherStyle;

    property StaticCaption: boolean read FStaticCaption write FStaticCaption default False;
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Caption {: string read GetCaption write SetCaption }stored IsCustomCaption;
    property Color;
    property Default: Boolean read FDefault write SetDefault default False;
    property Down: Boolean read FDown write SetDown default False;
    property Font;
    property Offsets: TwwOffsets read FOffsets write FOffsets;
    property Glyph: TBitmap read FGlyph write SetGlyph stored IsCustom;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Kind: TBitBtnKind read GetKind write SetKind default bkCustom;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs stored IsCustom default 1;
    property Options: TwwButtonOptions read FOptions write SetOptions default [];
    property Selected: Boolean read FSelected;
    property ShadeColors: TwwShadeColors read FShadeColors write FShadeColors;
    property ShadeStyle: TwwShadeStyle read FShadeStyle write SetShadeStyle;
    property SmoothFont: boolean read FSmoothFont write FSmoothFont default false;
    property Style: TButtonStyle read FStyle write SetStyle default bsAutoDetect;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property TabStop; // 8/18/00 - Remove default as inconsistent with constructor
    property TextOptions: TwwCaptionText read FTextOptions write FTextOptions;
    property OnClick;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnSelChange: TNotifyEvent read FOnSelChange write FOnSelChange;
    property OnSetName: TNotifyEvent read FOnSetName write FOnSetName;
    property UseHalftonePalette: Boolean read FUseHalftonePalette write FUseHalftonePalette;
    property Hot : boolean read FHot write FHot;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataLink: TFieldDataLink read FDataLink;
    property Field: TField read GetField;
    property DisableThemes : boolean read FDisableThemes write FDisableThemes default False;
    property OnGetCaption: TwwButtonGetCaptionEvent read FOnGetCaption write FOnGetCaption;
  end;

  TwwButton = class(TwwCustomBitBtn)
  published
    property Action;
    property Anchors;
    property Constraints;
    property AllowAllUp;
    property Cancel;
    property Caption;
    property Color;
    property Default;
    property DataSource;
    property DataField;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Down;
    property Font;
    property Enabled;
    property DitherColor;
    property DitherStyle;
    property Glyph;
    property GroupIndex;
    property Kind;
    property Layout;
    property Margin;
    property ModalResult;
    property NumGlyphs;
    property Offsets;
    property Options;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShadeColors;
    property ShadeStyle;
    property ShowHint;
    property SmoothFont;
    property Style;
    property Spacing;
    property TabOrder;
    property TabStop;
    property TextOptions;
    property Visible;
    property StaticCaption;

    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelChange;
    property OnStartDrag;
    property DisableThemes; // default true;

    {$ifdef wwDELPHI2013Up}
    property Align;
    property StyleElements;
    property DoubleBuffered;
    property ParentDoubleBuffered;
    {$endif}
  end;


implementation

{$r wwButtns.RES}
//uses fclabel;
uses wwdbgrid;

const
  BITBTNMODALRESULTS: array[TBitBtnKind] of TModalResult = (
    0, mrOk, mrCancel, 0, mrYes, mrNo, 0, mrAbort, mrRetry, mrIgnore,
    mrAll);

var
  BitBtnResNames: array[TBitBtnKind] of PChar = (
    nil, 'WWWOK', 'WWWCANCEL', 'WWWHELP', 'WWWYES', 'WWWNO', 'WWWCLOSE',
    'WWWABORT', 'WWWRETRY', 'WWWIGNORE', 'WWWALL');
  BitBtnCaptions: array[TBitBtnKind] of Pointer = (nil, nil, nil,
    nil, nil, nil, nil, nil, nil, nil, nil);
  BitBtnGlyphs: array[TBitBtnKind] of TBitmap;

procedure GetBitBtnGlyph(Kind: TBitBtnKind; Bitmap: TBitmap);
begin
  if BitBtnGlyphs[Kind] = nil then
  begin
    BitBtnGlyphs[Kind] := TBitmap.Create;
    BitBtnGlyphs[Kind].LoadFromResourceName(HInstance, BitBtnResNames[Kind]);
  end;
  Bitmap.Assign(BitBtnGlyphs[Kind]);
end;

// TwwDownOffsets
var GoodVideoDriverVar: Integer = -1;

function GoodVideoDriver: Boolean;
var TmpBm: TwwBitmap;
    TmpBitmap: TBitmap;
begin
  if GoodVideoDriverVar = -1 then
  begin
    TmpBm := TwwBitmap.Create;
    TmpBm.LoadBlank(1, 1);
    TmpBm.Pixels[0, 0] := wwGetColor(RGB(192, 192, 192));
    TmpBitmap := TBitmap.Create;
    TmpBitmap.Width := 1;
    TmpBitmap.Height := 1;
    TmpBitmap.Canvas.Draw(0, 0, TmpBm);
    with wwGetColor(TmpBitmap.Canvas.Pixels[0, 0]) do
      GoodVideoDriverVar := ord((r < 200) and (g < 200) and (b < 200));
    TmpBitmap.Free;
    TmpBm.Free;
  end;
  result := GoodVideoDriverVar = 1;
end;

type
  TOperator = (opMultiply, opDivide, opAdd, opSubtract);
  TOperators = set of TOperator;

  TwwEvaluator = class
  protected
    class function GetOperands(s: string; Operators: TOperators;
      var LOperand, ROperand: string; var FoundOp: TOperator): Boolean;
    class procedure ValidateString(s: String);
    class procedure FixString(var s: String);
  public
    class function Evaluate(s: string): Integer;
  end;

const
  OPERATORSCHAR: array[TOperator] of Char = ('*', '/', '+', '-');

class function TwwEvaluator.GetOperands(s: string; Operators: TOperators;
  var LOperand, ROperand: string; var FoundOp: TOperator): Boolean;
var OpIndex, CurOpIndex: Integer;
    CurOp: TOperator;
begin
  OpIndex := -1;
  for CurOp := Low(TOperator) to High(TOperator) do
    if (CurOp in Operators) then
    begin
      CurOpIndex := wwFindToken(s, ' ', OPERATORSCHAR[CurOp]);
      if (CurOpIndex <> -1) and ((OpIndex = -1) or (CurOpIndex < OpIndex)) then
      begin
        OpIndex := CurOpIndex;
        FoundOp := CurOp;
      end;
    end;
  if OpIndex = -1 then
  begin
    result := False;
    Exit;
  end;
  LOperand := wwGetToken(s, ' ', OpIndex - 1);
  ROperand := wwGetToken(s, ' ', OpIndex + 1);
  result := True;
end;

class procedure TwwEvaluator.ValidateString(s: String);
var i: Integer;
begin
  for i := 1 to Length(s) do
    if (not CharInSet(s[i], ['+', '-', '*', '/', ',', ' '])) and
       (not ((ord(s[i])>=48) and (ord(s[i])<=57))) then
    //if (not (s[i] in ['+', '-', '*', '/', ',', ' '])) and (not (ord(s[i]) in [48..57])) then
      raise EInvalidOperation.Create('Only alpha characters "+", "-", "x", and "/" are allowed.');
end;

class procedure TwwEvaluator.FixString(var s: String);
var CurOp: TOperator;
begin
  for CurOp := Low(TOperator) to High(TOperator) do
    s := strReplace(s, OPERATORSCHAR[CurOp], ' ' + OPERATORSCHAR[CurOp] + ' ');
  while Pos('  ', s) > 0 do
    s := strReplace(s, '  ', ' ');
end;

class function TwwEvaluator.Evaluate(s: string): Integer;
var LOperand, ROperand: string;
    IntLOperand, IntROperand: Integer;
    FoundOp: TOperator;
    CurResult: Integer;
begin
  ValidateString(s);
  FixString(s);
  CurResult := -1;
  while GetOperands(s, [opMultiply, opDivide], LOperand, ROperand, FoundOp) or
        GetOperands(s, [opAdd, opSubtract], LOperand, ROperand, FoundOp) do
  begin
    IntLOperand := StrtoInt(LOperand);
    IntROperand := StrtoInt(ROperand);
    case FoundOp of
      opMultiply: CurResult := IntLOperand * IntROperand;
      opDivide: if IntROperand <> 0 then CurResult := IntLOperand div IntROperand
                else raise EInvalidOperation.Create('Divide By Zero Error');
      opAdd: CurResult := IntLOperand + IntROperand;
      opSubtract: CurResult := IntLOperand - IntROperand;
    end;
    s := strReplace(s, LOperand + ' ' + OPERATORSCHAR[FoundOp] + ' ' + ROperand, InttoStr(CurResult));
  end;
  result := StrToInt(s);
end;


constructor TwwOffsets.Create(Button: TwwCustomBitBtn);
begin
  inherited Create;
  FControl := Button;
  FTextDownX := 1;
  FTextDownY := 1;
end;

procedure TwwOffsets.AssignTo(Dest: TPersistent);
begin
  if Dest is TwwOffsets then
    with Dest as TwwOffsets do
  begin
    GlyphX := self.GlyphX;
    GlyphY := self.GlyphY;
    TextX := self.TextX;
    TextY := self.TextY;
    TextDownX := self.TextDownX;
    TextDownY := self.TextDownY;
  end else inherited;
end;

procedure TwwOffsets.SetGlyphX(Value: Integer);
begin
  if FGlyphX <> Value then
  begin
    FGlyphX := Value;
    Control.Invalidate;
  end;
end;

procedure TwwOffsets.SetGlyphY(Value: Integer);
begin
  if FGlyphY <> Value then
  begin
    FGlyphY := Value;
    Control.Invalidate;
  end;
end;

procedure TwwOffsets.SetTextX(Value: Integer);
begin
  if FTextX <> Value then
  begin
    FTextX := Value;
    Control.Invalidate;
  end;
end;

procedure TwwOffsets.SetTextY(Value: Integer);
begin
  if FTextY <> Value then
  begin
    FTextY := Value;
    Control.Invalidate;
  end;
end;

// TwwShadeColors

constructor TwwShadeColors.Create(Button: TwwCustomBitBtn);
begin
  inherited Create;
  FButton := Button;

  FBtnHighlight := clBtnHighlight;
  FBtn3DLight := cl3DLight;
  FBtnShadow := clBtnShadow;
end;

procedure TwwShadeColors.AssignTo(Dest: TPersistent);
begin
  if Dest is TwwShadeColors then
    with Dest as TwwShadeColors do
  begin
    Btn3dLight := self.Btn3dLight;
    BtnHighlight := self.BtnHighlight;
    BtnShadow := self.BtnShadow;
    BtnBlack := self.BtnBlack;
    BtnFocus := self.BtnFocus;
    Shadow := self.Shadow;
  end else inherited;
end;

procedure TwwShadeColors.SetBtn3DLight(Value: TColor);
begin
  if Value <> FBtn3DLight then
  begin
    FBtn3DLight := Value;
    FButton.Invalidate;
  end;
end;

procedure TwwShadeColors.SetBtnBlack(Value: TColor);
begin
  if FBtnBlack <> Value then
  begin
    FBtnBlack := Value;
    FButton.Invalidate;
  end;
end;

procedure TwwShadeColors.SetBtnHighlight(Value: TColor);
begin
  if Value <> FBtnHighlight then
  begin
    FBtnHighlight := Value;
    FButton.Invalidate;
  end;
end;

procedure TwwShadeColors.SetBtnShadow(Value: TColor);
begin
  if Value <> FBtnShadow then
  begin
    FBtnShadow := Value;
    FButton.Invalidate;
  end;
end;

procedure TwwShadeColors.SetBtnFocus(Value: TColor);
begin
  if Value <> FBtnFocus then
  begin
    FBtnFocus := Value;
    FButton.Invalidate;
  end;
end;

procedure TwwShadeColors.SetShadow(Value: TColor);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    FButton.Invalidate;
  end;
end;

// TwwCustomBitBtn

function TwwCustomBitBtn.GetTextEnabled: Boolean;
begin
  result := Enabled;
end;

procedure TwwCustomBitBtn.AdjustBounds;
begin
end;

constructor TwwCustomBitBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csOpaque, csReflector];
  //FStaticCaption:=true;
  FPointList := TStringList.Create;
  FShowDownAsUp:=False;
  FCanvas := TCanvas.Create;
  FChangeLinks := TList.Create;
  Color := clBtnFace;
  FChangeLink := TwwChangeLink.Create;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChanged;
  Height := 25;
  FKind := bkCustom;
  FLayout := blGlyphLeft;
  FMargin := -1;
  FOffsets := CreateOffsets;
  FShadeColors := TwwShadeColors.Create(self);
  FShowFocusRect := True;
  FSpacing := 4;
  FShadeStyle := wwbsNormal;
  FStyle := bsAutoDetect;
  TabStop := True;
  FTextOptions := TwwLabelText.Create(MakeCallbacks(Invalidate, AdjustBounds, GetTextEnabled),
    FCanvas, Font);
  TwwLabelText(FTextOptions).Control:= self;

  FTextOptions.Alignment := taCenter;
  FTextOptions.VAlignment := vaVCenter;
  FEvents := TStringList.Create;
  Width := 75;

  BasePatch:= VarArrayCreate([0, 1], varVariant);
  BasePatch[0]:= False; { 6/8/99 - Internal use to support painting issues with flat buttons }
  BasePatch[1]:= False; { 6/19/2000 - PYW - Internal use to solve MouseDown problems with nonfocus buttons.  Set to True to preserve old behavior.}

  FUseHalftonePalette:= False;

  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;

  FShape := wwbsSystemStyle;
  FOrientation := wwsoUp;
  FDitherColor := clWhite;
  FRoundRectBias := 25;
  //FOrientation := soUp;

end;

destructor TwwCustomBitBtn.Destroy;
begin
  FPointList.Free;
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  FDataLink := nil;

  CleanUp;
  if FRegionData.rgnData <> nil then FreeMem(FRegionData.rgnData);
  if FDownRegionData.rgnData <> nil then FreeMem(FDownRegionData.rgnData);
  FCanvas.Free;
  FChangeLinks.Free;
  FChangeLinks:= nil;
  FChangeLink.Free;
  FGlyph.Free;
  FOffsets.Free;
  FShadeColors.Free;
  FTextOptions.Free;
  FEvents.Free;
  inherited Destroy;
end;

procedure TwwCustomBitBtn.CleanUp;
begin
  if FRegion <> 0 then
  begin
    if not (csDestroying in ComponentState) and HandleAllocated then SetWindowRgn(Handle, 0, False);
    DeleteObject(FRegion);
    DeleteObject(FLastRegion);
    FRegion := 0;
    FLastRegion := 0;
  end;
end;

procedure TwwCustomBitBtn.SetOrientation(Value: TwwShapeOrientation);
begin
  if FOrientation<> Value then
  begin
    FOrientation:= Value;
    Recreatewnd;
  end
end;

procedure TwwCustomBitBtn.SetPointList(Value: TStringList);
begin
  FPointList.Assign(Value);
  RecreateWnd;
end;

procedure TwwCustomBitBtn.SetShape(Value: TwwButtonShape);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Recreatewnd;

    // Ensures that the control's rectangle gets invalidated even in a transparent button group
    if (Parent <> nil) and wwIsClass(Parent.ClassType, 'TfcCustomButtonGroup') then
      wwParentInvalidate(Parent, True);
  end
end;

procedure TwwCustomBitBtn.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TwwCustomBitBtn.AssignTo(Dest: TPersistent);
begin
  if Dest is TwwCustomBitBtn then
    with Dest as TwwCustomBitBtn do
  begin
    Color := self.Color;
    Offsets.Assign(self.Offsets);
    Layout := self.Layout;
    Margin := self.Margin;
    NumGlyphs := self.NumGlyphs;
    Options := self.Options;
    ShadeColors.Assign(self.ShadeColors);
    Spacing := self.Spacing;
    TabStop := self.TabStop;
    TextOptions.Assign(self.TextOptions);
  end else inherited;
end;

procedure TwwCustomBitBtn.CreateParams(var Params: TCreateParams);
const
  ButtonStyles: array[Boolean] of UINT = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);

  CreateSubClass(Params, 'BUTTON');
  with Params do Style := Style or BS_OWNERDRAW;
end;

procedure TwwCustomBitBtn.Createwnd;
begin
  inherited;
  FActive := FDefault;
  ApplyRegion;
end;

procedure TwwCustomBitBtn.DestroyWnd;
begin
  CleanUp;
  inherited;
end;

procedure TwwCustomBitBtn.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('RegionData', ReadRegionData, WriteRegionData, StoreRegionData);
  Filer.DefineBinaryProperty('DownRegionData', ReadDownRegionData, WriteDownRegionData, StoreRegionData);
end;

function TwwCustomBitBtn.GetPalette: HPALETTE;
begin
  result := Glyph.Palette;
end;

function TwwCustomBitBtn.CreateOffsets: TwwOffsets;
begin
  result := TwwOffsets.Create(self);
end;

function TwwCustomBitBtn.Draw(Canvas: TCanvas): TRect;
var
  TextSize: TSize;
  r: TRect;
begin
  result := ClientRect;
  InflateRect(result, -2, -2);

  TextOptions.Canvas := Canvas;
  TextOptions.Text := GetDBCaption;
  TextOptions.TextRect := result;

  with TextOptions.CalcDrawRect(True) do
    TextSize := wwSize(Right - Left, Bottom - Top);
  CalcButtonLayout(Canvas, result, FTextRect, FGlyphRect, TextSize);

  // 5/25/05 - Code added to handle glyph left alignment taking text space
  if (Layout=blGlyphLeft) then
  begin
     r:= TextOptions.TextRect;
     r.Left := GlyphRect.Right;
     TextOptions.TextRect:= r;
     with TextOptions.CalcDrawRect(True) do
       TextSize := wwSize(Right - Left, Bottom - Top);
     CalcButtonLayout(Canvas, result, FTextRect, FGlyphRect, TextSize);
  end;


  with FTextRect do FTextRect := Rect(
    wwMax(0, Left), wwMax(0, Top), wwMin(ClientWidth, Right), wwMin(ClientHeight, Bottom));

  if not Glyph.Empty then DrawButtonGlyph(Canvas, FGlyphRect.TopLeft);
  if Down then
    screen.Cursor:= crarrow;
  DrawButtonText(Canvas, FTextRect);

  if (boFocusRect in Options) and (boFocusable in Options) and Focused then
  begin
    UnionRect(r, TextRect, GlyphRect);
    InflateRect(r, 2, 2);
    Canvas.Brush.Color := clWhite;
    Canvas.Font.Color := clBlack;
    wwDrawFocusRect(Canvas, r);
  end;
end;

function TwwCustomBitBtn.CalcButtonLayout(Canvas: TCanvas; Client: TRect;
  var TextRect: TRect; var GlyphRect: TRect; TextSize: TSize): TRect;
var GlyphSize: TSize;
    TopLeft: TPoint;
    Spacing: Integer;
    EffectiveMargin: Integer;
    DownFlag:boolean;
begin
  DownFlag := Down and not (csPaintCopy in ControlState); // 6/17/02
  if ShowDownAsUp then begin
     if Down then DownFlag := False;
     if FClicked and MouseInControl(-1,-1,False) and not Selected then
        DownFlag := True;
  end;

  InflateRect(Client, -Margin, -Margin);
  if Margin = -1 then EffectiveMargin := 4 else EffectiveMargin := Margin;
  SetRectEmpty(GlyphRect);
  GlyphSize := wwSize(0, 0);
  if not Glyph.Empty then GlyphSize := wwSize(GlyphWidth, Glyph.Height);
  Spacing := 0;
  if (GetDBCaption <> '') and (not Glyph.Empty) then Spacing := self.Spacing;
  case TextOptions.Alignment of
    taLeftJustify: TopLeft := Point(EffectiveMargin + (TextSize.cx + GlyphSize.cx + Spacing) div 2, Height div 2);
    taRightJustify: TopLeft := Point(-EffectiveMargin + Width - (TextSize.cx + GlyphSize.cx + Spacing) div 2, Height div 2);
    taCenter: TopLeft := Point(Width div 2, Height div 2);
  end;

  wwCalcButtonLayout(TopLeft, @TextRect, @GlyphRect, TextSize, GlyphSize, Layout, Spacing);

  OffsetRect(TextRect, Offsets.TextX, Offsets.TextY);
  OffsetRect(GlyphRect, Offsets.GlyphX, Offsets.GlyphY);

  // Offset if down
  if DownFlag then
  begin
    if not ((Shape in [wwbsSystemStyle]) or StyleServices.Enabled) then
    begin
      OffsetRect(TextRect, Offsets.TextDownX, Offsets.TextDownY);
      OffsetRect(GlyphRect, Offsets.TextDownX, Offsets.TextDownY);
    end;
  end;
  result := Client;
end;

procedure TwwCustomBitBtn.ReadRegionData(Stream: TStream);
begin
  Stream.ReadBuffer(FRegionData.dwSize, SizeOf(FRegionData.dwSize));
  if FRegionData.dwSize <> 0 then
  begin
    ClearRegion(@FRegionData); // 9/8/03 - Free previous memory

    GetMem(FRegionData.rgnData, FRegionData.dwSize);
    Stream.ReadBuffer(FRegionData.rgnData^, FRegionData.dwSize);
  end;
end;

procedure TwwCustomBitBtn.ReadDownRegionData(Stream: TStream);
begin
  Stream.ReadBuffer(FDownRegionData.dwSize, SizeOf(FDownRegionData.dwSize));
  if FDownRegionData.dwSize <> 0 then
  begin
    ClearRegion(@FDownRegionData); // 9/8/03 -Free previous memory

    GetMem(FDownRegionData.rgnData, FDownRegionData.dwSize);
    Stream.ReadBuffer(FDownRegionData.rgnData^, FDownRegionData.dwSize);
  end;
end;

procedure TwwCustomBitBtn.WriteRegionData(Stream: TStream);
begin
  if FRegionData.rgnData <> nil then
  begin
    Stream.WriteBuffer(FRegionData.dwSize, SizeOf(FRegionData.dwSize));
    Stream.WriteBuffer(FRegionData.rgnData^, FRegionData.dwSize);
  end else begin
    FRegionData.dwSize := 0;
    Stream.WriteBuffer(FRegionData.dwSize, SizeOf(FRegionData.dwSize));
  end;
end;

procedure TwwCustomBitBtn.WriteDownRegionData(Stream: TStream);
begin
  if FDownRegionData.rgnData <> nil then
  begin
    Stream.WriteBuffer(FDownRegionData.dwSize, SizeOf(FDownRegionData.dwSize));
    Stream.WriteBuffer(FDownRegionData.rgnData^, FDownRegionData.dwSize);
  end else begin
    FDownRegionData.dwSize := 0;
    Stream.WriteBuffer(FDownRegionData.dwSize, SizeOf(FDownRegionData.dwSize));
  end;
end;

procedure TwwCustomBitBtn.ApplyRegion;
var CurParent: TWinControl;
    DownFlag:Boolean;
begin
  if not HandleAllocated then Exit;
  if not UseRegions then exit;
  if parent is TCustomGrid then exit; // Let grid paint instead of transparency

  DownFlag := Down and not (csPaintCopy in ControlState); // 6/17/02
  if ShowDownAsUp then begin
     if Down then DownFlag := False;
     if FClicked and MouseInControl(-1,-1,False) and not Selected then
        DownFlag := True;
  end;

  SetWindowRgn(Handle, 0, False);
  if FRegion <> 0 then DeleteObject(FRegion);
  FRegion := CreateRegion(True, DownFlag);

  if (FLastRegion <> 0) and (FRegion <> 0) and IsMultipleRegions then
  begin
    CombineRgn(FLastRegion, FLastRegion, FRegion, RGN_XOR);

    CurParent := self;
    while (CurParent <> GetParentForm(self)) and (CurParent <> nil) do
    begin
      OffsetRgn(FLastRegion, CurParent.Left, CurParent.Top);
      InvalidateRgn(CurParent.Parent.Handle, FLastRegion, True);
      CurParent := CurParent.Parent;
    end;
  end;

  if IsMultipleRegions then
  begin
    if FLastRegion <> 0 then DeleteObject(FLastRegion);
    FLastRegion := CreateRectRgn(0, 0, 10, 10);
    CombineRgn(FLastRegion, FRegion, 0, RGN_COPY);
  end;

  SetWindowRgn(Handle, FRegion, False);
  if IsMultipleRegions and (Parent <> nil) then wwInvalidateOverlappedWindows(Parent.Handle, Handle);
end;

procedure TwwCustomBitBtn.ChangeButtonDown;
begin
  if IsMultipleRegions then ApplyRegion;
end;

procedure TwwCustomBitBtn.GetEvents(const s: string);
begin
  FEvents.Add(s);
end;

procedure TwwCustomBitBtn.SelChange;
begin
  FSelected := Down;
  if Assigned(FOnSelChange) then FOnSelChange(self);
  NotifyChange;
end;


procedure TwwCustomBitBtn.SaveRegion(NewRegion: Longword; Down: Boolean);
var ARgnData: ^TwwRegionData;
begin
  if not Down then ARgnData := @FRegionData else ARgnData := @FDownRegionData;
  if ARgnData^.rgnData <> nil then FreeMem(ARgnData^.rgnData);
  ARgnData^.rgnData := nil;
  ARgnData^.dwSize := GetRegionData(NewRegion, 0, nil);
  GetMem(ARgnData^.rgnData, ARgnData^.dwSize);
  GetRegionData(NewRegion, ARgnData^.dwSize, ARgnData^.rgnData);
end;

function TwwCustomBitBtn.CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn;
var ARgnData: PRgnData;
    DrawBitmap: TwwBitmap;
begin
  if (not Down and (FRegionData.rgnData <> nil)) or (Down and (FDownRegionData.rgnData <> nil)) then
  begin
    if Down then ARgnData := FDownRegionData.rgnData else ARgnData := FRegionData.rgnData;
    result := ExtCreateRegion(nil, ARgnData.rdh.dwSize + ARgnData.rdh.nRgnSize, ARgnData^);
  end else result := 0;

  if not DoImplementation or (result <> 0) then Exit;
  if ((wwbsRect = Shape) or (wwbsRect = wwbsSystemStyle)) and (parent<>nil) and
     wwIsClass(parent.classtype, 'TCustomGrid') then exit; // No shape region needed

  DrawBitmap := TwwBitmap.Create;
  try
    GetDrawBitmap(DrawBitmap, True, ShadeStyle, Down);
    result := wwRegionFromBitmap(DrawBitmap, UnusableColor);
  finally
    SaveRegion(result, Down);
    DrawBitmap.Free;
  end;
end;

procedure TwwCustomBitBtn.ClearRegion(ARgnData: PwwRegionData);
begin
  if ARgnData^.rgnData <> nil then
  begin
    FreeMem(ARgnData^.rgnData);
    ARgnData^.rgnData := nil;
  end;
end;


procedure TwwCustomBitBtn.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint);
var
  ImageList: TImageList;
  TempGlyph: TBitmap;
  Offset: Integer;
  DownFlag:Boolean;
begin
  Offset := 0;
  DownFlag := Down and not (csPaintCopy in ControlState); // 6/17/02
  if ShowDownAsUp then begin
     if Down then DownFlag := False;
     if FClicked and MouseInControl(-1,-1,False) and not Selected then
        DownFlag := True;
  end;

  if not Enabled and (NumGlyphs > 1) then Offset := GlyphWidth
  else if Downflag and (NumGlyphs > 2) then Offset := 2 * GlyphWidth
  else if MouseInControl(-1, -1, False) and (NumGlyphs > 3) then Offset := 3 * GlyphWidth;

  ImageList := TImageList.Create(self);

// RSW - 7/6/00 - Resolve redline problem with some environments
  if ((Enabled) or (NumGlyphs > 1)) and odd(GlyphPos.x) then
    ImageList.Width := GlyphWidth+1
  else
    ImageList.Width := GlyphWidth;
  ImageList.Height := Glyph.Height;
  TempGlyph := TBitmap.Create;

  try
    TempGlyph.Width := ImageList.Width;
    TempGlyph.Height := Glyph.Height;

    if (not Enabled) and (NumGlyphs <= 1) then
    begin
       wwCreateDisabledBitmap(Glyph, TempGlyph);
       TempGlyph.Transparent := True;
       ImageList.AddMasked(TempGlyph, TempGlyph.TransparentColor);
       with GlyphPos do begin
         wwImageListDraw(ImageList, 0, Canvas, x, y, ILD_NORMAL, True)
       end
    end
    else begin
      if odd(GlyphPos.x) then begin
        TempGlyph.Canvas.CopyRect(Rect(0, 0, GlyphWidth, Glyph.Height),
           Glyph.Canvas, Rect(Offset, 0, Offset + GlyphWidth, Glyph.Height));
        TempGlyph.Canvas.Brush.Color:= TempGlyph.TransparentColor;
        TempGlyph.Canvas.FillRect(Rect(0, 0, 1, Glyph.Height));
        TempGlyph.Canvas.CopyRect(Rect(1, 0, GlyphWidth+1, Glyph.Height),
           Glyph.Canvas, Rect(Offset, 0, Offset + GlyphWidth, Glyph.Height));
      end
      else begin
        TempGlyph.Canvas.CopyRect(Rect(0, 0, TempGlyph.Width, TempGlyph.Height),
           Glyph.Canvas, Rect(Offset, 0, Offset + GlyphWidth, Glyph.Height));
      end;
      TempGlyph.Transparent := True;
      ImageList.AddMasked(TempGlyph, TempGlyph.TransparentColor);
      with GlyphPos do begin
        wwImageListDrawFixBug(ImageList, 0, Canvas, x, y, ILD_NORMAL, True)
      end
    end;
  finally
    ImageList.Free;
    TempGlyph.Free;
  end;
end;

procedure TwwCustomBitBtn.DrawButtonText(Canvas: TCanvas; TextBounds: TRect);
begin
  Canvas.Brush.Style := bsClear;
  TextOptions.TextRect := TextBounds;
  TextOptions.Draw;
end;

procedure TwwCustomBitBtn.DrawItem(const DrawItemStruct: TDrawItemStruct);
begin
  if csDestroying in ComponentState then exit;  // 7/2/02 - Exit if destroying
  if ( width < 1 ) or ( height < 1 ) then exit; // 7/3/02 - No space to draw

  FCanvas.Handle := DrawItemStruct.hDC;
  Paint;
  FCanvas.Handle := 0;
end;

procedure TwwCustomBitBtn.GetDrawBitmap(DrawBitmap: TwwBitmap; ForRegion: Boolean;
  ShadeStyle: TwwShadeStyle; Down: Boolean; InPaint: boolean = false);
type TfcDirection = (sbLeft, sbRight, sbUp, sbDown);
var PointList: PwwPolyGonPoints;
    NumPoints: Integer;
    DoDraw3d: Boolean;
    OldBrush, ABrush: HBRUSH;
    IsSystemStyleButton: boolean;
    TempBitmap: TwwBitmap;

    {$ifdef wwUseThemeManager}
    Button: TThemedButton;
    Details: TThemedElementDetails;
    r: TRect;
    {$endif}


    procedure PaintBackground(var ARect: TRect);
    var  r: TRect;
    begin
       r:= ARect;

         if not Enabled then
            Button := tbPushButtonDisabled
         else if Down then
            Button := tbPushButtonPressed
         else if MouseInControl(-1,-1, False) and not (csPaintCopy in ControlState) then
            Button := tbPushButtonHot
         else if Focused {or IsDefault } then
            Button := tbPushButtonDefaulted
         else
            Button := tbPushButtonNormal;
         Details := StyleServices.GetElementDetails(Button);
         // Inflate button if custom shape in case its rounded as it might not paint edges correctly otherwise
         if not IsSystemStyleButton then
            InflateRect(r, 10, 10);


       StyleServices.DrawElement(DrawBitmap.Canvas.Handle, Details, r);

    end;

begin
  DrawBitmap.SetSizeInternal(Width, Height);
  if csPaintCopy in ControlState then
    DrawBitmap.Canvas.CopyRect(ClientRect, FCanvas, ClientRect);
//  GetDrawBitmap(DrawBitmap.Canvas, ForRegion, ShadeStyle, Down, InPaint);
//exit;
  DoDraw3d := True;
  case ShadeStyle of
    wwbsFlat: DoDraw3d := (csDesigning in ComponentState) or (MouseInControl(-1, -1, False) and Enabled) or Down;
  end;

  ABrush := 0;
  OldBrush := 0;
  DrawBitmap.SetSizeInternal(Width, Height);

  if (Width <=0) or (Height<=0) then exit;
  IsSystemStyleButton:= (Shape in [wwbsSystemStyle]) and StyleServices.Enabled;
  if (not IsSystemStyleButton) or (not InPaint) then
  begin
    DrawBitmap.Canvas.Brush.Color := UnusableColor;
    DrawBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
  end
  else begin
     // Fill with background unless parent is transparent
     if (parent is TCustomGrid) and wwUseThemes(self) and {wwIsCustomStyle(self) and} not (csPaintCopy in ControlState) then
     begin
        wwPaintActiveGridCellBackgroundColor(self, DrawBitmap.Canvas);
        if (parent is TwwDBGrid) then
        begin
           r:= Rect(0, 1, Width, Height);
           TwwDBGrid(parent).PaintActiveRowBackground(Drawbitmap.Canvas, r); // Handle alternating colors
        end;
     end

     else if not wwIsTransparentParent(self) then
     begin
        r:= Rect(0, 0, Width, Height);
        PaintBackground(r);
     end
  end;

  DrawBitmap.Canvas.Brush.Color := CorrectedColor;
  DoComputeCanvasAttributes(DrawBitmap.Canvas);
  if DoDraw3d then DrawBitmap.Canvas.Pen.Color := ColorToRGB(DitherColor)
  else DrawBitmap.Canvas.Pen.Color := DrawBitmap.Canvas.Brush.Color;

  if Down and (DitherColor <> clNone) and (GroupIndex <> 0) then
  begin
    ABrush := wwGetDitherBrush;
    SetBkColor(DrawBitmap.Canvas.Handle, ColorToRGB(DitherColor));
    SetTextColor(DrawBitmap.Canvas.Handle, ColorToRGB(Color));
    OldBrush := SelectObject(DrawBitmap.Canvas.Handle, ABrush);
  end;

  try
    PointList := nil;
    if RoundShape then
    begin
      DrawBitmap.Canvas.Pen.Color := CorrectedColor;
      if (not InPaint) or not wwIsCustomStyle(self) then
      begin
        case Shape of
          wwbsRoundRect: DrawBitmap.Canvas.RoundRect(
            0, 0, Width - 1, Height - 1, RoundRectBias, RoundRectBias);
          wwbsEllipse: DrawBitmap.Canvas.Ellipse(
            0, 0, Width - 1, Height - 1);
        end;
        if not ForRegion and DoDraw3d then { 5/2/99 - RSW - Support flat for RoundShape }
           Draw3dLines(DrawBitmap, [Point(0, 0)], 0, UnusableColor);
      end
      else begin
         if not ForRegion and DoDraw3d then
         begin
           TempBitmap:= TwwBitmap.Create;
           try
             TempBitmap.SetSizeInternal(Width, Height);
             TempBitmap.Canvas.Brush.Color := UnusableColor;
             TempBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
             TempBitmap.Canvas.Brush.Color := CorrectedColor;
             DoComputeCanvasAttributes(TempBitmap.Canvas);

             case Shape of
               wwbsRoundRect: TempBitmap.Canvas.RoundRect(
                 0, 0, Width - 1, Height - 1, RoundRectBias, RoundRectBias);
               wwbsEllipse: TempBitmap.Canvas.Ellipse(
                 0, 0, Width - 1, Height - 1);
             end;

             r:= Rect(0, 0, Width, Height);
             PaintBackground(r);
             Draw3dLines(TempBitmap, [Point(0, 0)], 0, UnusableColor, DrawBitmap);
           finally
             TempBitmap.Free;
           end;
         end
         else begin
           r:= Rect(0, 0, Width, Height);
           PaintBackground(r);
         end;
      end;
    end
    else begin
      NumPoints := GetPolygonPoints(PointList);
      if (PointList <> nil) then
      begin
         if not IsSystemStyleButton then
         begin
           if (not InPaint) or not wwIsCustomStyle(self) then
           begin
             Polygon(DrawBitmap.Canvas.Handle, PointList^, NumPoints);
           end
           else begin
             r:= Rect(0, 0, Width, Height);
             PaintBackground(r);
           end
         end
      end;

      if IsSystemStyleButton then
      begin
         if (parent is TCustomGrid) then
            r:= Rect(0, 0, Width, Height)
         else
            r:= Rect(0, 0, Width-1, Height-1);
         PaintBackground(r);
      end
      else if (Shape in [wwbsRect, wwbsSystemStyle]) and wwUseThemes(self) and not wwIsCustomStyle(self) then
      begin
         r:= Rect(0, 0, Width-1, Height-1);
         PaintBackground(r);
      end;

      if not ForRegion and DoDraw3d and (PointList <> nil) then
         if (not wwUseThemes(self)) or  (not IsSystemStyleButton) then // 6/8/12 - Still draw lines if not styles (Shape <> bsSystemStyle) then
            Draw3dLines(DrawBitmap, Slice(PointList^, NumPoints), NumPoints, UnusableColor);


    end;

    if OldBrush <> 0 then SelectObject(DrawBitmap.Canvas.Handle, OldBrush);
    if ABrush <> 0 then DeleteObject(ABrush);
  finally
    if not RoundShape then FreeMem(PointList);
  end;


end;

procedure TwwCustomBitBtn.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

function TwwCustomBitBtn.GlyphWidth: Integer;
begin
  result := Glyph.Width;
  if NumGlyphs <> 0 then
    result := Glyph.Width div NumGlyphs;
end;

function TwwCustomBitBtn.IsMultipleRegions: Boolean;
begin
  result := False;
end;

function TwwCustomBitBtn.StoreRegionData: Boolean;
begin
  result := False;
end;

procedure TwwCustomBitBtn.NotifyLoaded;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do
    with TwwChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Loaded;
  end;
end;

procedure TwwCustomBitBtn.NotifyChange;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do
    with TwwChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Change;
  end;
end;

procedure TwwCustomBitBtn.NotifyChanging;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do
    with TwwChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Changing;
  end;
end;

procedure TwwCustomBitBtn.Paint;
var DrawBitmap: TwwBitmap;
    DownFlag:Boolean;
begin
  DownFlag := Down and not (csPaintCopy in ControlState); // 6/17/02
  if ShowDownAsUp then begin
     if Down then DownFlag := False;
     if MouseInControl(-1,-1,False) and (not Selected) and (FClicked) then
        DownFlag := True;
  end;
  DrawBitmap := TwwBitmap.Create;
  DrawBitmap.UseHalftonePalette:= FUseHalftonePalette;
  try
    if false and (csPaintCopy in ControlState) then
    begin
       //GetDrawBitmap(FCanvas, False, ShadeStyle, DownFlag, true);
       //DrawBitmap.SetSizeInternal(Width, Height);
       GetDrawBitmap(DrawBitmap, False, ShadeStyle, DownFlag, true);
       Draw(DrawBitmap.Canvas);
       Canvas.Draw(0, 0, DrawBitmap);       // Paint TempBitmap to Canvas
    end
    else begin
       if (ShadeStyle=wwbsFlat) and (BasePatch[0]=True) then
          GetDrawBitmap(DrawBitmap, False, wwbsNormal, DownFlag, true)
       else
          GetDrawBitmap(DrawBitmap, False, ShadeStyle, DownFlag, true);
       Draw(DrawBitmap.Canvas);
       Canvas.Draw(0, 0, DrawBitmap);       // Paint TempBitmap to Canvas
    end;

    if SmoothFont then begin
       TextOptions.Canvas:= Canvas;
       DrawButtonText(Canvas, TextRect); { Repaint text of button }
    end
  finally
    DrawBitmap.Free;
  end;
end;

procedure TwwCustomBitBtn.Redraw;
begin
  FCanvas.Handle := GetDC(Handle);
  Paint;
  ReleaseDC(Handle, FCanvas.Handle);
  FCanvas.Handle := 0;
end;

procedure TwwCustomBitBtn.SetButtonDown(Value: Boolean; CheckAllowAllUp: Boolean; DoUpdateExclusive: Boolean; DoInvalidate: Boolean);
begin
  if Value <> FDown then
  begin
    FDown := Value;
    ChangeButtonDown;
    if FDown then NotifyChanging;
    if DoUpdateExclusive then UpdateExclusive;
    if DoInvalidate then Invalidate;
  end;
  if (GroupIndex > 0) and (boAutoBold in Options) then
  begin
    if FDown then Font.Style := Font.Style + [fsBold] else Font.Style := Font.Style - [fsBold];
  end;
end;

procedure TwwCustomBitBtn.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TwwCustomBitBtn.SizeToDefault;
begin
end;

procedure TwwCustomBitBtn.UpdateShadeColors(Color: TColor);
begin
  ShadeColors.BtnShadow := wwModifyColor(Color, -50, True);
  ShadeColors.BtnBlack := wwModifyColor(ShadeColors.BtnShadow, -50, True);
  ShadeColors.Btn3dLight := wwModifyColor(Color, 50, True);
  ShadeColors.BtnHighlight := wwModifyColor(ShadeColors.Btn3dLight, 50, True);
end;

procedure TwwCustomBitBtn.RegisterChanges(Value: TwwChangeLink);
begin
   if FChangeLinks<>nil then { RSW - 3/5/99 }
      FChangeLinks.Add(Value);
end;

procedure TwwCustomBitBtn.UnRegisterChanges(Value: TwwChangeLink);
begin
   if FChangeLinks<>nil then { RSW - 3/5/99 }
      FChangeLinks.Remove(Value);
end;

procedure TwwCustomBitBtn.ActionChange(Sender: TObject; CheckDefaults: Boolean);
  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with Glyph do
    begin
      Width := ImageList.Width;
      Height := ImageList.Height;
      Canvas.Brush.Color := clFuchsia;  // !!! Why clFuchsia?  Is this going to cause problems? -ksw
      Canvas.FillRect(Rect(0,0, Width, Height));
      ImageList.Draw(Canvas, 0, 0, Index);
    end;
  end;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not (Glyph.Empty) then begin
        // Put Somethign Here
      end;
      // Copy image from action's imagelist
      if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        CopyImage(ActionList.Images, ImageIndex);
    end;
end;

procedure TwwCustomBitBtn.Click;
var
  Form: TCustomForm;
  Control: TWinControl;
begin
  if DisableButton then exit;
  BasePatch[0]:= True;

  case FKind of
    bkClose: begin
      Form := GetParentForm(Self);
      if Form <> nil then Form.Close
      else inherited Click;
    end;
    bkHelp: begin
      Control := Self;
      while (Control <> nil) and (Control.HelpContext = 0) do
        Control := Control.Parent;
      if Control <> nil then Application.HelpContext(Control.HelpContext)
      else inherited Click;
    end;
    else begin
      Form := GetParentForm(Self);
      if Form <> nil then Form.ModalResult := ModalResult;
      inherited Click;
    end;
  end;
  BasePatch[0]:= False;
  invalidate;
end;

procedure TwwCustomBitBtn.Loaded;
begin
  inherited;
  if not (boFocusable in Options) then TabStop := False;
  ApplyRegion;

  NotifyLoaded;
end;

procedure TwwCustomBitBtn.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
  begin
    ProcessMouseDown;
    ProcessMouseUp(-1, -1, True, True);
    Click; { 7/26/99 - Call click on space }
  end;
end;

procedure TwwCustomBitBtn.ProcessMouseDown;
begin
  if DisableButton then exit;
  FInitialDown := Down;
  if not (boToggleOnUp in Options) or (GroupIndex = 0) then
  begin
    if (boFocusable in Options) then
    begin
       SetFocus; { 7/26/99 - Set focus when mouse is pressed on button }

      // 5/16/04 - Only set button down if its still depressed - Fixes problem
      // when showmessage is used on onexit event of tedit and button is clicked
      if (csLButtonDown in ControlState) then
         SetButtonDown(True, True, False, False);
    end
    else
       SetButtonDown(True, True, False, False);
  end;
  if FInitialDown <> Down then Redraw;
end;

procedure TwwCustomBitBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  { 3/9/00 - Don't check key state as mouse could already be released }
  if (Button = mbLeft) {and (GetKeyState(VK_LBUTTON) < 0) }then
  begin
    FClicked := True;
    SetCaptureControl(self);
//    MouseCapture:= True; { Equivalent - Perhaps change to this in the future }

    ProcessMouseDown;

    // 5/16/04 - Remove capture if button is not depressed
    if (boFocusable in Options) and
      not (csLButtonDown in ControlState) then
       SetCaptureControl(nil);

  end;
  { 5/1/00 - Added flag because sendmessage in MouseActivate causes some recursion when using the OnMouseDown.  Specifically the MenuForm example project}
  if (not FInMouseSendForMouseActivate) or (BasePatch[1] = True) then
     inherited;
//  else inherited
end;

procedure TwwCustomBitBtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var IsMouseInControl: Boolean;
begin
  if DisableButton then exit;

  inherited;

  if ((boToggleOnUp in Options)) or not FClicked or (GetKeyState(VK_LBUTTON) >= 0) then Exit;

  IsMouseInControl := MouseInControl(x, y, True);

  if (IsMouseInControl and not Down) or
     ((not IsMouseInControl and Down) and not FInitialDown) then
  begin
    SetButtonDown(IsMouseInControl, False, False, False);
    Redraw;
  end;
end;

procedure TwwCustomBitBtn.ProcessMouseUp(X, Y: Integer; AMouseInControl: Boolean; AClicked: Boolean);
begin
  if DisableButton then exit;
  if (GroupIndex = 0) then
  begin
    SetButtonDown(False, False, False, False);
    Redraw;
  end else begin
    UpdateExclusive;
    if AMouseInControl or (boToggleOnUp in Options) then
    begin
      if ((FInitialDown and AllowAllUp) or (not FInitialDown)) then
      begin
        SetButtonDown(not FInitialDown, True, True, False);
        Redraw;
        SelChange;
      end;
    end;
  end;
end;

procedure TwwCustomBitBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  ProcessMouseUp(x, y, MouseInControl(x, y, True), FClicked);
  SetCaptureControl(nil);

  //2/26/99 - Check for ToggleOnUp so that Click will be fired when button has
  //          different up/down regions.
  if MouseInControl(x, y, True) or (boToggleOnUp in Options) then Click;

  FClicked := False;
end;

procedure TwwCustomBitBtn.SetName(const Value: TComponentName);
begin
  inherited;
  if Assigned(FOnSetName) then FOnSetName(self);
end;

procedure TwwCustomBitBtn.CMButtonPressed(var Message: TMessage);
var
  Sender: TwwCustomBitBtn;
begin
  if Integer(Message.WParam) = FGroupIndex then
  begin
    if not (TObject(Message.LParam) is TwwCustomBitBtn) then Exit;
    Sender := TwwCustomBitBtn(Message.LParam);
    if (Sender.Down) then
    begin
       if Sender<>Self then
          SetButtonDown(False, False, False, True);
       if Sender<>Self then
          SelChange // 7/22/01 Call SelChange so that is selected
       else
          FSelected := Down; // 9/20/01 - Don't call SelChange if Sender=Self, but just set FSelected
                             // This corrects slowness when outlookbar is changning pages
    end;

  end;
end;

procedure TwwCustomBitBtn.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
  begin
    if  (((CharCode = VK_RETURN) and FActive) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end else if IsAccel(CharCode, GetDBCaption) and CanFocus then begin
      //Down := not Down;
      // 1/3/2000 - Use SetButtonDown procedure so AllowAllUp is considered.
      if GroupIndex > 0 then  // 10/15/2001- Only set this if groupindex > 0.
         SetButtonDown(True, True, True, False);

      Click;
      Invalidate;
      Result := 1;
    end else inherited;
  end;
end;

procedure TwwCustomBitBtn.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TwwCustomBitBtn.CMFocusChanged(var Message: TCMFocusChanged);
begin
  with Message do
    if Sender is TwwCustomBitBtn then
      FActive := Sender = Self
    else
      FActive := FDefault;
  inherited;
end;

procedure TwwCustomBitBtn.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (ShadeStyle = wwbsFlat) or (NumGlyphs = 4) then Invalidate;
  if wwUseThemes(self) then Invalidate;
  if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
  FHot:= True;
end;

procedure TwwCustomBitBtn.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (ShadeStyle = wwbsFlat) or (NumGlyphs = 4) then Invalidate;
  if wwUseThemes(self) then Invalidate;
//  if ThemeServices.ThemesEnabled then Invalidate;
  if Assigned(FOnMouseLeave) then FOnMouseLeave(self);
  FHot:= False;
end;

procedure TwwCustomBitBtn.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do
  begin
    ItemWidth := Width;
    ItemHeight := Height;
  end;
end;

procedure TwwCustomBitBtn.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct^);
end;

procedure TwwCustomBitBtn.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TwwCustomBitBtn.WMLButtonDown(var Message: TWMLButtonDown);
begin
  SendCancelMode(Self);
  if csCaptureMouse in ControlStyle then MouseCapture := True;
  if csClickEvents in ControlStyle then ControlState := ControlState + [csClicked];
  with Message do
    MouseDown(mbLeft, KeysToShiftState(Keys) + [], XPos, YPos);
end;

procedure TwwCustomBitBtn.WMMouseActivate(var Message: TWMMouseActivate);
var Button: TMouseButton;
    Shift: TShiftState;

  function GetShiftState: TShiftState;
  begin
    Result := [];
    if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  end;

  function ShiftStateToKeys(State: TShiftState): Word;
  begin
     Result := 0;
     if ssShift in State then Result:= Result + MK_SHIFT;
     if ssCtrl in State then Result:= Result + MK_CONTROL;
     if ssLeft in State then Result:= Result + MK_LBUTTON;
     if ssRight in State then Result:= Result + MK_RBUTTON;
  end;

begin
  { 6/19/2000 - PYW -  Solve mousedown problems with nonfocusable buttons.}
  if BasePatch[1] = False then begin
     inherited;
     exit;
  end;

  if (csDesigning in ComponentState) or (boFocusable in Options) then inherited
  else begin
    Message.result := MA_NOACTIVATEANDEAT;
    if Message.MouseMsg = WM_LBUTTONDOWN then Button := mbLeft else Button := mbRight;
    Shift := GetShiftState;
    if Button = mbLeft then include(Shift, ssLeft) else include(Shift, ssRight);

    GetParentForm(self).BringToFront; // Added to make sure form is shown when user clicks on button. (Avoid IE5 scroll button problems) -ksw (2/19/99)

    with ScreenToClient(wwGetCursorPos) do
      if (x>=0) and (y>=0) then { RSW - 4/16/99 }
      begin
         if Button=mbLeft then begin
            { 3/9/00 - Changed to SendMessage to ensure button down processed before button up }
            { 5/1/00 - Added flag because sendmessage causes some recursion when using the OnMouseDown.  Specifically the MenuForm example project}
            FInMouseSendForMouseActivate := True;
            SendMessage(Handle, WM_LBUTTONDOWN, ShiftStateToKeys(Shift), MAKELPARAM(x, y));
            FInMouseSendForMouseActivate := False;
//             {4/12/00 - Added back the postmessage because sendmessage causes some recursion when using the OnMouseDown.  Specifically the MenuForm example project}
//              PostMessage(Handle, WM_LBUTTONDOWN, ShiftStateToKeys(Shift), MAKELPARAM(x, y))
         end
         else
            PostMessage(Handle, WM_RBUTTONDOWN, ShiftStateToKeys(Shift), MAKELPARAM(x, y))
      end
  end;
end;

function TwwCustomBitBtn.GetKind: TBitBtnKind;
begin
  if FKind <> bkCustom then
    if ((FKind in [bkOK, bkYes]) xor Default) or
       ((FKind in [bkCancel, bkNo]) xor Cancel) or
       (ModalResult <> BITBTNMODALRESULTS[FKind]) or
       FModifiedGlyph then
      FKind := bkCustom;
  Result := FKind;
end;

procedure TwwCustomBitBtn.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TwwCustomBitBtn.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TwwCustomBitBtn.SetDown(Value: Boolean);
begin
  if (FGroupIndex = 0) and (not (csLoading in ComponentState)) then Value := False;
  if FDown <> Value then
  begin
    SetButtonDown(Value, True, True, True);
    if FDown = Value then SelChange;
  end;
end;

procedure TwwCustomBitBtn.SetGlyph(Value: TBitmap);
begin
  Glyph.Assign(Value);
  Invalidate;
end;

procedure TwwCustomBitBtn.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TwwCustomBitBtn.SetKind(Value: TBitBtnKind);
begin
  if Value <> FKind then
  begin
    if Value <> bkCustom then
    begin
      Default := Value in [bkOK, bkYes];
      Cancel := Value in [bkCancel, bkNo];

      if ((csLoading in ComponentState) and (GetDBCaption = '')) or
        (not (csLoading in ComponentState)) then
      begin
        if BitBtnCaptions[Value] <> nil then
          Caption := LoadResString(BitBtnCaptions[Value]);
      end;

      ModalResult := BITBTNMODALRESULTS[Value];
      GetBitBtnGlyph(Value, FGlyph);
      NumGlyphs := 2;
      FModifiedGlyph := False;
    end;
    FKind := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= - 1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetNumGlyphs(Value: TNumGlyphs);
begin
  Value := wwMin(wwMax(Value, 1), 4);
  if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetOptions(Value: TwwButtonOptions);
var ChangedOptions: TwwButtonOptions;
begin
  if FOptions <> Value then
  begin
    ChangedOptions := (FOptions - Value) + (Value - FOptions);
    FOptions := Value;
    if not (boFocusable in FOptions) then TabStop := False;
    if boAutoBold in ChangedOptions then SetButtonDown(Down, False, False, True);
  end;
end;

procedure TwwCustomBitBtn.SetShadeStyle(Value: TwwShadeStyle);
begin
  if FShadeStyle <> Value then
  begin
    FShadeStyle := Value;
    Recreatewnd;
  end;
end;

procedure TwwCustomBitBtn.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetStyle(Value: TButtonStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

function TwwCustomBitBtn.IsCustom: Boolean;
begin
  Result := Kind = bkCustom;
end;

function TwwCustomBitBtn.IsCustomCaption: Boolean;
begin
  Result := CompareStr(Caption, LoadResString(BitBtnCaptions[FKind])) <> 0;
end;

function TwwCustomBitBtn.MouseInControl(X, Y: Integer; AndClicked: Boolean): Boolean;
var p: TPoint;
    AHandle: HWND;
    Control: TWinControl;
    ParentForm:TCustomForm;
begin
  //11/17/99 - Make sure that only active window is hot-tracked.
  //2/22/00 - Disregard parent test if MDI form }
  ParentForm := GetParentForm(self);
  if (ParentForm<>nil) and (ParentForm.handle<>GetActiveWindow) then begin
    if not (TForm(ParentForm).formstyle in [fsMDIChild, fsMDIForm]) and
       not (wwIsClass(ParentForm.classType, 'TActiveForm')) then // 7/31/00 - Disregard parent test for ActiveX forms
      // 5/18/2000 - PYW - Don't exit if ParentForm was created using CreateParented.
      if false and (ParentForm.ParentWindow = 0) or (GetParent(ParentForm.ParentWindow) <> GetActiveWindow) then
      begin
        result := False;
        exit;
      end;
  end;

  // 1/16/08 - Return false if mouse is not over us - This bug was reported when using mdi windows
  // and is probably not necessary in other cases
  if (ParentForm<>nil) and (TForm(ParentForm).formstyle in [fsMDIChild, fsMDIForm]) then
  begin
     p:= wwGetCursorPos;
     AHandle:= Windows.WindowFromPoint(p);
     if (AHandle <> Handle) then
     begin
       result:=false;
       exit;
     end;
  end;

  if IsMultipleRegions then Control := self else Control := Parent;
  if (x = -1) and (y = -1) then p := Control.ScreenToClient(wwGetCursorPos)
  else p := Control.ScreenToClient(ClientToScreen(Point(x, y)));

  if IsMultipleRegions then begin
    result:=false;
  end else begin
    //12/20/2001 - Skip invisible controls. {PYW}
    AHandle := ChildWindowFromPointEx(Parent.Handle, p, CWP_SKIPINVISIBLE);
    control := FindControl(AHandle);
    result := control = self;
  end;
  if AndClicked then result := result and FClicked;
end;

procedure Initialize;
begin
  FillChar(BitBtnGlyphs, SizeOf(BitBtnGlyphs), 0);
  BitBtnCaptions[bkOK] := @SOKButton;
  BitBtnCaptions[bkCancel] := @SCancelButton;
  BitBtnCaptions[bkHelp] := @SHelpButton;
  BitBtnCaptions[bkYes] := @SYesButton;
  BitBtnCaptions[bkNo] := @SNoButton;
  BitBtnCaptions[bkClose] := @SCloseButton;
  BitBtnCaptions[bkAbort] := @SAbortButton;
  BitBtnCaptions[bkRetry] := @SRetryButton;
  BitBtnCaptions[bkIgnore] := @SIgnoreButton;
  BitBtnCaptions[bkAll] := @SAllButton;
end;

procedure Finalize;
var i: TBitBtnKind;
begin
  for i := Low(TBitBtnKind) to High(TBitBtnKind) do
    BitBtnGlyphs[I].Free;
end;

procedure TwwCustomBitBtn.WMSize(var Message: TWMSize);
//var r: TRect;
begin
  inherited;
{  ClearRegion(@FRegionData);
  ClearRegion(@FDownRegionData);
  SetWindowRgn(Handle, 0, True);
  ApplyRegion;}
  Invalidate;
//  r := BoundsRect;
//  if Parent <> nil then InvalidateRect(Parent.Handle, @r, True);}
end;

{ RSW - 3/9/99 - Process default button when carriage return or Cancel entered }
procedure TwwCustomBitBtn.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if  (((CharCode = VK_RETURN) and FActive) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TwwCustomBitBtn.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if csLButtonDown in ControlState then Perform(WM_LBUTTONUP, 0, Integer($FFFFFFFF));
end;


procedure TwwCustomBitBtn.InvalidateNotRegion(const Erase: Boolean);
var Rgn, TmpRgn: HRGN;
  DownFlag:Boolean;
begin
  DownFlag := Down and not (csPaintCopy in ControlState); // 6/17/02
  if False and ShowDownAsUp then begin
     if Down then DownFlag := False;
     if FClicked and MouseInControl(-1,-1,False) and not Selected then
        DownFlag := True;
  end;

  with ClientRect do Rgn := CreateRectRgn(Left, Top, Right, Bottom);
  with ClientRect do TmpRgn := CreateRegion(False, DownFlag);

  try
    CombineRgn(Rgn, Rgn, TmpRgn, RGN_DIFF);
    OffsetRgn(Rgn, Left, Top);
    InvalidateRgn(Parent.Handle, Rgn, Erase);
  finally
    DeleteObject(Rgn);
    DeleteObject(TmpRgn);
  end;
end;

function TwwCustomBitBtn.UseRegions: boolean;
begin
   result:= true;
end;

// 6/17/02 - Support button painting in grid
procedure TwwCustomBitBtn.WMPaint(var Message: TWMPaint);
var tc: TColor;
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      TControlCanvas(FCanvas).Control := Self;
    end;
  end;

begin
  if not (csPaintCopy in ControlState) then
  begin
     inherited;
  end
  else begin
     tc:= Font.Color;
     if IsInwwGridPaint(self) and (message.dc<>0) then tc:= GetTextColor(message.dc);
     CanvasNeeded;
     FCanvas.Handle := Message.dc;
     FCanvas.Font:= Font;
     if IsInwwGridPaint(self) and (message.dc<>0) then FCanvas.Font.Color:= tc;
     Paint;
     FCanvas.Handle := 0;
  end;
end;

procedure TwwCustomBitBtn.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TwwCustomBitBtn.GetDataSource: TDataSource;
begin
  if (FDataLink<>Nil) and (FDataLink.DataSource is TDataSource) then begin
     Result := FDataLink.DataSource as TDataSource
  end
  else Result:= Nil;
end;

procedure TwwCustomBitBtn.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

function TwwCustomBitBtn.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TwwCustomBitBtn.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{procedure TwwCustomBitBtn.SetCaption(val: string);
begin
   if FDataLink.Field<>nil then
   begin
      if (DataSource<>Nil) and (DataSource.autoEdit) then
         if not (DataSource.state in [dsEdit, dsInsert]) then
            FDataLink.Edit;
      FDataLink.Field.Text:= val;
   end
   else inherited Caption:= val
end;
}

function TwwCustomBitBtn.GetDBCaption: string;
var myCaption: string;
begin
   if (not StaticCaption) and (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
   begin
      if (FDataLink.Field is TBlobField) then
         myCaption:= FDataLink.Field.asString
      else
         myCaption:= FDataLink.Field.DisplayText
   end
   else myCaption:= inherited Caption;

   if Assigned(FOnGetCaption) then
   begin
      FOnGetCaption(self, myCaption);
   end;
   result:= myCaption;

end;

procedure TwwCustomBitBtn.DataChange(Sender: TObject);
var myCaption: string;
begin
  if (FDataLink.Field <> nil) and (not StaticCaption) then
  begin
    if (FDataLink.Field is TBlobField) then
       myCaption := FDataLink.Field.asString
    else myCaption := FDataLink.Field.DisplayText;

    if Assigned(FOnGetCaption) then
    begin
       FOnGetCaption(self, myCaption);
    end;
    inherited Caption:= myCaption;
  end
end;

procedure TwwCustomBitBtn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TwwCustomBitBtn.GetField: TField;
begin
  Result := FDataLink.Field;
end;

type TBooleanArray = array[0..0] of Boolean;
     PBooleanArray = ^TBooleanArray;

procedure TwwCustomBitBtn.Draw3DLines(SrcBitmap, DstBitmap: TwwBitmap; TransColor: TColor; Down: Boolean);
var WorkingBm{, DstBm}: TwwBitmap;
    DstPixels, SrcPixels: PwwPLines;
    StartPt, EndPt, OldEndPt: TPoint;
    Col, Row: Integer;
    ABtnHighlight, ABtn3DLight, ABtnShadow, ABtnBlack: TwwColor;
    BitmapSize: TSize;
    IsCustomStyle: boolean;

  function CheckPoint(p: TPoint): TPoint;
  begin
    result := p;
    if result.x < 0 then result.x := 0;
    if result.y < 0 then result.y := 0;
    if result.x > BitmapSize.cx - 1 then result.x := BitmapSize.cx - 1;
    if result.y > BitmapSize.cy - 1 then result.y := BitmapSize.cy - 1;
  end;
  function PointValid(x, y: Integer): Boolean;
  begin
    result := not ((x < 0) or (y < 0) or
      (x >= BitmapSize.cx) or (y >= BitmapSize.cy));
  end;
  procedure GetFirstPixelColor(CurrentCol, CurrentRow: Integer; var ResultPt: TPoint; AColor: TColor; NotColor: Boolean; SearchForward: Boolean);
  var i, MaxIncr: Integer;
      CurColor: TColor;
  begin
    if SearchForward then MaxIncr := wwMin(BitmapSize.cx - CurrentCol, BitmapSize.cy - CurrentRow)
    else MaxIncr := wwMin(CurrentCol, CurrentRow);
    for i := 0 to MaxIncr - 1 do
    begin
      with SrcPixels[CurrentRow, CurrentCol] do CurColor := RGB(r, g, b);
      if ((CurColor = AColor) and not NotColor) or
         ((CurColor <> AColor) and NotColor) then
      begin
        ResultPt.x := CurrentCol;
        ResultPt.y := CurrentRow;
        if not NotColor then ResultPt := CheckPoint(Point(ResultPt.x - 1, ResultPt.y - 1));
        Break;
      end;
      if SearchForward then inc(CurrentCol) else dec(CurrentCol);
      if SearchForward then inc(CurrentRow) else dec(CurrentRow);
    end;
  end;

  procedure DrawHighlights(ABtnBlack, ABtnShadow, ABtn3dLight, ABtnHighlight: TwwColor);
  var AEndPt, AStartPt: TPoint;
  begin
    AEndPt := EndPt;
    AStartPt := StartPt;
    if (not IsCustomStyle) and ((boFocusable in Options) and (Focused)) then
      AStartPt := Point(AStartPt.x + 1, AStartPt.y + 1);

    if not (IsCustomStyle and (boFocusable in Options) and (Focused)) then
    begin
    with Point(AEndPt.x - 1, AEndPt.y - 1) do
      if PointValid(x, y) then DstPixels[y, x] := ABtnShadow;
    with Point(AStartPt.x + 1, AStartPt.y + 1) do
      if PointValid(x, y) then DstPixels[y, x] := ABtn3dLight;
    end;

    with Point(AEndPt.x, AEndPt.y) do
      if PointValid(x, y) then DstPixels[y, x] := ABtnBlack;
    with Point(AStartPt.x, AStartPt.y) do
      if PointValid(x, y) then DstPixels[y, x] := ABtnHighlight;

    if ((boFocusable in Options) and (Focused) and Down) then
      with Point(AStartPt.x - 1, AStartPt.y - 1) do
        if PointValid(x, y) then DstPixels[y, x] := wwGetColor(clBlack);
  end;
begin
  if SrcBitmap.Empty or (SrcBitmap.Width <> DstBitmap.Width) or (SrcBitmap.Height <> DstBitmap.Height) then
    Exit;
  IsCustomStyle:= wwIsCustomStyle(self);

  // Must convert to BGR values because apparantly that's what PixBuf is...
  ABtnHighlight := wwGetColor(ColorToRGB(ShadeColors.BtnHighlight));
  ABtn3dLight := wwGetColor(ColorToRGB(ShadeColors.Btn3dLight));
  ABtnShadow := wwGetColor(ColorToRGB(ShadeColors.BtnShadow));
  ABtnBlack := wwGetColor(ColorToRGB(ShadeColors.BtnBlack));

  BitmapSize.cx := SrcBitmap.Width;
  BitmapSize.cy := SrcBitmap.Height;

  WorkingBm := TwwBitmap.Create;
  WorkingBm.Assign(SrcBitmap);
  SrcPixels := WorkingBm.Pixels;
  DstPixels := DstBitmap.Pixels;

  if TransColor = -1 then TransColor := wwGetStdColor(WorkingBm.Pixels[0, 0]);

  try
    // Work Diagonally from top right of image to Top left of image
    Col := BitmapSize.cx - 1;
    Row := 0;
    while Row < WorkingBm.Height do
    begin
      // Find the first non transparent pixel
      EndPt := Point(Col - 1, Row - 1);

      repeat
        StartPt := Point(-1, -1);

        GetFirstPixelColor(EndPt.x + 1, EndPt.y + 1, StartPt, TransColor, True, True);
        if (StartPt.x <> -1) and (StartPt.y <> -1) then
        begin
          OldEndPt := EndPt;
          EndPt := CheckPoint(Point(Col + wwMin(BitmapSize.cx - 1 - Col, BitmapSize.cy - 1 - Row),
            Row + wwMin(BitmapSize.cx - 1 - Col, BitmapSize.cy - 1 - Row)));
          GetFirstPixelColor(StartPt.x + 1, StartPt.y + 1, EndPt, TransColor, False, True);


          if (not IsCustomStyle) and (Focused or Default) then
          begin
            StartPt := Point(StartPt.x + 1, StartPt.y + 1);
            EndPt := Point(EndPt.x - 1, EndPt.y - 1);
          end;

          if not Down then DrawHighlights(ABtnBlack, ABtnShadow, ABtn3dLight, ABtnHighlight)
          else DrawHighlights(ABtnHighlight, ABtn3dLight, ABtnShadow, ABtnBlack);

          if (not IsCustomStyle) and (Focused or Default) then
          begin
            StartPt := Point(StartPt.x - 1, StartPt.y - 1);
            EndPt := Point(EndPt.x + 1, EndPt.y + 1);
            DstPixels[StartPt.y, StartPt.x] := ABtnBlack;
            DstPixels[EndPt.y, EndPt.x] := ABtnBlack;
          end;
        end;
      until (StartPt.x = -1) and (StartPt.y = -1);
      if Col > 0 then dec(Col) else inc(Row);
    end;
  finally
    WorkingBm.Free;
  end;
end;

{
function TwwCustomImageBtn.ColorAtPoint(APoint: TPoint): TColor;
var Bitmap: TfcBitmap;
begin
  Bitmap := TfcBitmap.Create;
  try
    GetDrawBitmap(Bitmap, False, ShadeStyle, Down);
    result := Bitmap.Canvas.Pixels[APoint.x, APoint.y];
  finally
    Bitmap.Free;
  end;
end;

}
procedure TwwCustomBitBtn.Draw3dLines(Bitmap: TwwBitmap; PointList: array of TPoint;
  NumPoints: Integer; TransColor: TColor; PaintBitmap: TwwBitmap);

  function MidPoint(p1, p2: TPoint): TPoint;
  begin
    result := Point(p1.x + (p2.x - p1.x) div 2, p1.y + (p2.y - p1.y) div 2);
  end;
var PolyRgn: HRGN;
    i: Integer;
    Difference: TSize;
    OutsideColor, InsideColor: TColor;
    Highlights: PBooleanArray;
    Offsets: PwwPolygonPoints;
    Focused: Integer;
    ACanvas: TCanvas;
    DownFlag:boolean;

    // 6/17/02
    Function DrawDarkBorder: boolean;
    begin
       result:= not (csPaintCopy in ControlState) and
               (self.Focused or Default);
    end;

begin
  if (ShadeStyle = wwbsFlat) and wwIsCustomStyle(self) then exit;// Don't draw 3d lines if flat and customstyle

  DownFlag := Down and not (csPaintCopy in ControlState); // 6/17/02
  if ShowDownAsUp then begin
     DownFlag := False;
     if Clicked and MouseInControl(-1,-1,False) and not Selected then
        DownFlag := True;
  end;
  ACanvas := Bitmap.Canvas;
  if RoundShape then
  begin
    if PaintBitmap=nil then
      Draw3dLines(Bitmap, Bitmap, TransColor, DownFlag)
    else
      Draw3dLines(Bitmap, PaintBitmap, TransColor, DownFlag);
    Exit;
  end;

  PolyRgn := CreatePolygonRgn(PointList, NumPoints, WINDING);
  if PolyRgn = 0 then Exit;

  Highlights := AllocMem(SizeOf(Boolean) * NumPoints);
  Offsets := AllocMem(SizeOf(TPoint) * NumPoints);

  try
    for i := 0 to NumPoints - 2 do
    begin
      Highlights[i] := False;
      Difference := wwSize(Abs(PointList[i + 1].x - PointList[i].x),
                           Abs(PointList[i + 1].y - PointList[i].y));
      with MidPoint(PointList[i], PointList[i + 1]) do
        if (Difference.cx > Difference.cy) then
        begin
          if PtInRegion(PolyRgn, x, y + 1) then
          begin
            Highlights[i] := True;
            Offsets[i] := Point(0, 1);
          end else Offsets[i] := Point(0, -1);
        end else
        begin
          if PtInRegion(PolyRgn, x + 1, y) then
          begin
            Highlights[i] := True;
            Offsets[i] := Point(1, 0);
          end else Offsets[i] := Point(-1, 0);
        end;
      if (Difference.cx = 0) then
      begin
        Offsets[i] := Point(Offsets[i].x, -1);
        if PtInRegion(PolyRgn, PointList[i].x, wwMax(PointList[i].y, PointList[i + 1].y) + 1) then Offsets[i].y := 1;
      end else if (Difference.cy = 0) then
      begin
        Offsets[i] := Point(-1, Offsets[i].y);
        if PtInRegion(PolyRgn, wwMax(PointList[i].x, PointList[i + 1].x), PointList[i].y) then Offsets[i].x := 1;
      end;
    end;

    if DrawDarkBorder then Focused := 1 else Focused := 0;


    for i := 0 to NumPoints - 2 do
    begin
      if Highlights[i] xor DownFlag then InsideColor := ColorToRGB(ShadeColors.Btn3dLight)
      else InsideColor := ColorToRGB(ShadeColors.BtnShadow);

      ACanvas.Pen.Color := InsideColor;
      ACanvas.PolyLine([
        Point(PointList[i].x + Offsets[i].x * (1 + Focused), PointList[i].y + Offsets[i].y * (1 + Focused)),
        Point(PointList[i + 1].x + Offsets[i].x * (1 + Focused), PointList[i + 1].y + Offsets[i].y * (1 + Focused))
      ]);
    end;

    for i := 0 to NumPoints - 2 do
    begin
      if Highlights[i] xor DownFlag then OutsideColor := ColorToRGB(ShadeColors.BtnHighlight)
      else OutsideColor := ColorToRGB(ShadeColors.BtnBlack);

      ACanvas.Pen.Color := OutsideColor;
      ACanvas.Polyline([
        Point(PointList[i].x + Offsets[i].x * Focused, PointList[i].y + Offsets[i].y * Focused),
        Point(PointList[i + 1].x + Offsets[i].x * Focused, PointList[i + 1].y + Offsets[i].y * Focused)
      ]);
    end;

    if DrawDarkBorder then
      for i := 0 to NumPoints - 2 do
      begin
        ACanvas.Pen.Color := ShadeColors.BtnFocus;
        ACanvas.PolyLine([PointList[i], PointList[i + 1]]);
      end;
  finally
    DeleteObject(PolyRgn);
    FreeMem(Highlights);
    FreeMem(Offsets);
  end;
end;
function TwwCustomBitBtn.UnusableColor: TColor;
begin
  //11/28/00 - Fix bug when 3dColor is set to clRed
  if ColorToRGB(Color) <> WWDEFUNUSECOLOR then
    result := WWDEFUNUSECOLOR else result := WWDEFUNUSECOLOR2;
end;

function TwwCustomBitBtn.CorrectedColor: TColor;
var fcColor: TwwColor;  // 9/3/09 - Delphi 2010 Change
begin
  fcColor:= wwGetColor(Color);
  with fcColor do
  begin
    if not GoodVideoDriver then
    begin
      // 5/10/99 - PYW - Fixed Flat Style painting bug in High Color mode.
      if (r > 0) and (r mod 8 = 0) then dec(fccolor.r);
      if (g > 0) and (g mod 8 = 0) then dec(fccolor.g);
      if (b > 0) and (b mod 8 = 0) then dec(fccolor.b);
    end;
    result := RGB(fccolor.r, fccolor.g, fccolor.b);
  end;
end;

function TwwCustomBitBtn.RoundShape: Boolean;
begin
  result := Shape in [wwbsRoundRect, wwbsEllipse];
end;

procedure TWWCustomBitBtn.DoComputeCanvasAttributes(ACanvas: TCanvas);
begin
//  if Assigned(FOnComputeCanvasAttributes) then
//     FOnComputeCanvasAttributes(Self, ACanvas);
end;

procedure TwwCustomBitBtn.SetDitherColor(Value: TColor);
begin
  if FDitherColor <> Value then
  begin
    FDitherColor := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetDitherStyle(Value: TwwDitherStyle);
begin
  if FDitherStyle <> Value then
  begin
    FDitherStyle := Value;
    Invalidate;
  end;
end;

procedure TwwCustomBitBtn.SetRoundRectBias(Value:Integer);
begin
  if Value <> FRoundRectBias then
  begin
    FRoundRectBias := Value;
    RecreateWnd;
  end;
end;

procedure SetupPointList(var PointList: PwwPolygonPoints; NumPoints: Integer);
begin
  PointList := AllocMem((NumPoints + 1) * SizeOf(TPoint));
  FillChar(PointList^, (NumPoints + 1) * SizeOf(TPoint), 0);
end;

function GetNum(Num: Integer): Integer;
begin
  result := Num;
end;

function TwwCustomBitBtn.GetCustomPoints(var Points: PwwPolygonPoints; Size: TSize): Integer;
var i: Integer;
    CurPoint, x, y: string;
begin
  result := PointList.Count;
  if result <= 2 then
  begin
    result := 0;
    Exit;
  end;

  SetupPointList(Points, result);

  try
    for i := 0 to result - 1 do
    begin
      CurPoint := UpperCase(PointList[i]);
      if Pos(',', CurPoint) = 0 then
        raise EInvalidOperation.Create('Invalid Custom Points Format.  X and Y ' +
          'Coordinates must be separated by a comma and space.');
      CurPoint := strReplace(CurPoint, ',', ', ');
      CurPoint := strReplace(CurPoint, ',  ', ', ');
      CurPoint := strReplace(CurPoint, 'WIDTH', InttoStr(Size.cx));
      CurPoint := strReplace(CurPoint, 'HEIGHT', InttoStr(Size.cy));
      x := wwGetToken(CurPoint, ', ', 0);
      y := wwGetToken(CurPoint, ', ', 1);
      with Point(TwwEvaluator.Evaluate(x), TwwEvaluator.Evaluate(y)) do
        Points[i] := Point(x, y);
    end;
  except
    FreeMem(Points);
    Points := nil;
    FShape := wwbsSystemStyle;
    raise;
  end;
end;

function TwwCustomBitBtn.GetStarPoints(var Points: PwwPolygonPoints; Size: TSize): Integer;
var BottomOff: Integer;
    BaseTri, SideTri, HeightTri: Integer;
    Side: Integer;
begin
  result := 10;
  SetupPointList(Points, result);

  Side := Trunc(Size.cy / Cos(DegToRad(18)));
  SideTri := Trunc(Side / (2 + 2 * Sin(DegToRad(18))));
  BaseTri := Side - 2 * SideTri;
  HeightTri := Trunc(SideTri * Cos(DegToRad(18)));
  BottomOff := Trunc(Tan(DegToRad(18)) * Size.cy);
  Points[GetNum(0)] := Point(Size.cx div 2, 0);
  Points[GetNum(1)] := Point(Size.cx div 2 + BaseTri div 2, HeightTri);
  Points[GetNum(2)] := Point(Size.cx, Points[GetNum(1)].y);
  Points[GetNum(3)] := Point(Points[GetNum(1)].x + Trunc(Sin(DegToRad(18)) * BaseTri),
                     Points[GetNum(1)].y + Trunc(Cos(DegToRad(18)) * BaseTri));
  Points[GetNum(4)] := Point(Size.cx div 2 + BottomOff, Size.cy);
  Points[GetNum(5)] := Point(Size.cx div 2, Size.cy - Trunc(Sin(DegToRad(36)) * SideTri));
  Points[GetNum(6)] := Point(Size.cx div 2 - BottomOff, Size.cy);
  Points[GetNum(7)] := Point(Size.cx - Points[GetNum(3)].x, Points[GetNum(3)].y);
  Points[GetNum(8)] := Point(0, Points[GetNum(2)].y);
  Points[GetNum(9)] := Point(Size.cx - Points[GetNum(1)].x, Points[GetNum(1)].y);
end;

function TwwCustomBitBtn.GetPolygonPoints(var Points: PwwPolygonPoints): Integer;
var Size: TSize;
begin
  result := 0;
  Size := wwSize(Width - 1, Height - 1);
  case Shape of
    wwbsTriangle: begin
      result := 3;
      SetupPointList(Points, result);
      // Default Up, SetPointToOrientation adjusts for orientation
      Points[GetNum(0)] := Point(Size.cx div 2, 0);
      Points[GetNum(1)] := Point(Size.cx, Size.cy);
      Points[GetNum(2)] := Point(0, Size.cy);
    end;
    wwbsTrapezoid: begin
      result := 4;
      SetupPointList(Points, result);
      // Default Up, SetPointToOrientation adjusts for orientation
      Points[GetNum(0)] := Point(wwMin(Size.cy div 2, Size.cx div 2 div 2), 0);
      Points[GetNum(1)] := Point(Size.cx - wwMin(Size.cy div 2, Size.cx div 2 div 2), 0);
      Points[GetNum(2)] := Point(Size.cx, Size.cy);
      Points[GetNum(3)] := Point(0, Size.cy);
    end;
    wwbsArrow: begin
      result := 7;
      SetupPointList(Points, result);
      // Default Up, SetPointToOrientation adjusts for orientation
      Points[GetNum(0)] := Point(0, Size.cy div 3);
      Points[GetNum(1)] := Point(Size.cx div 2, 0);
      Points[GetNum(2)] := Point(Size.cx, Size.cy div 3);
      Points[GetNum(3)] := Point(Size.cx - Size.cx div 4, Size.cy div 3);
      Points[GetNum(4)] := Point(Size.cx - Size.cx div 4, Size.cy);
      Points[GetNum(5)] := Point(Size.cx div 4, Size.cy);
      Points[GetNum(6)] := Point(Size.cx div 4, Size.cy div 3);
    end;
    wwbsDiamond: begin
      result := 4;
      SetupPointList(Points, result);
      Points[GetNum(0)] := Point(Size.cx div 2, 0);
      Points[GetNum(1)] := Point(Size.cx, Size.cy div 2);
      Points[GetNum(2)] := Point(Size.cx div 2, Size.cy);
      Points[GetNum(3)] := Point(0, Size.cy div 2);
    end;
    wwbsRect, wwbsSystemStyle: begin
      result := 4;
      SetupPointList(Points, result);
      Points[GetNum(0)] := Point(0, 0);
      Points[GetNum(1)] := Point(Size.cx, 0);
      Points[GetNum(2)] := Point(Size.cx, Size.cy);
      Points[GetNum(3)] := Point(0, Size.cy);
    end;
    wwbsStar: result := GetStarPoints(Points, Size);
    wwbsCustom: result := GetCustomPoints(Points, Size);
  end;
  if result > 0 then
  begin
    Points[result] := Points[0];
    inc(result);
    SetPointToOrientation(Points, result, Orientation, Size);
  end;
end;

procedure TwwCustomBitBtn.SetPointToOrientation(Points: PwwPolygonPoints;
  NumPoints: Integer; Orientation: TwwShapeOrientation; Size: TSize);
var i: Integer;
    RepeatInc, RepCount: Integer;
begin
  RepCount := 0;
  case Orientation of
    wwsoLeft: RepCount := 3;
    wwsoRight: RepCount := 1;
    wwsoUp: RepCount := 0;
    wwsoDown: RepCount := 2;
  end;
  for RepeatInc := 1 to RepCount do
    for i := 0 to NumPoints - 1 do with Points[i] do
      Points[i] := Point(Size.cx - (y * Size.cx div Size.cy), (x * Size.cy div Size.cx));
end;


initialization
  Initialize;
finalization
  Finalize;
end.
