unit vcl.wwtext;
{
//
// Common Text handling routines
//
// Copyright (c) 2012 by Woll2Woll Software
//
}

interface

//uses Classes, Graphics, Windows, SysUtils, Messages, Math, fcCommon, Dialogs, Forms;
uses SysUtils, Windows, Messages, Classes, Controls, Forms, Math, Dialogs,
    Graphics, Menus, StdCtrls, buttons, extctrls, wwCommon,
    system.Types, system.uitypes, wwtypes,
    vcl.themes, wwstr;

type
  TwwVAlignment = (vaTop, vaVCenter, vaBottom);

  TwwTextStyle = (fclsDefault, fclsLowered, fclsRaised,
    fclsOutline);

  TwwOrientation = (fcTopLeft, fcTopRight, fcBottomLeft, fcBottomRight,
    fcTop, fcRight, fcLeft, fcBottom);

  TwwTextOption = (toShowAccel, toShowEllipsis, toFullJustify);
  TwwTextOptions = set of TwwTextOption;

type
  {
  // Any component that uses TwwText MUST implement this interface.
  // The Invalidate method can just be the one defined in TControl, so
  // it does not need to be redefined.
  //
  // If the component is Delphi 4 only, then GetTextEnabled can be
  // implemented as:
  //
  // function IfcTextControl.GetTextEnabled = GetEnabled;
  //
  // This works, because Delphi 4 declares a GetEnabled access method
  // that is available to descendant classes.  Otherwise, just implement
  // a method that returns the state of the Enabled property
  // (i.e. "result := Enabled;").
  //
 // AdjustBounds will be called whenever a property of TwwText is
  // manipulated such that the rect that the text uses changes.
  // TwwCustomLabel uses this method in conjunction with the AutoSize
  // property to resize the label if neccessary.
  }
{
  IfcTextControl = interface
    procedure Invalidate;
    procedure AdjustBounds;
    function GetTextEnabled: Boolean;
  end;
}
  TwwTextCallbacks = record
    Invalidate: TwwProcMeth;
    AdjustBounds: TwwProcMeth;
    GetTextEnabled: TwwBoolFunc;
  end;

  TwwText = class;

  {
  // Properties related to the Shadow effects of TwwText.
  //
  // Properties:
  // - Color:   The color of the shadow.
  //
  // - Enabled: Determines whether or not to actually display the
  //            shadow.
  //
  // - XOffset, YOffset: Determines how much and in what direction,
  //            the shadow is offset from the main text.  Negative
  //            values are valid.
  //
  // Methods:
  // - EffectiveOffset: Returns an empty point (x: 0, y: 0) if shadows
  //            are disabled, otherwise returns Point(XOffset, YOffset).
  }

  TwwShadowEffects = class(TPersistent)
  private
    FText: TwwText;

    // Property Storage Variables
    FColor: TColor;
    FEnabled: Boolean;
    FXOffset: Integer;
    FYOffset: Integer;

    // Property Access Methods
    procedure SetColor(Value: TColor);
    procedure SetEnabled(Value: Boolean);
    procedure SetXOffset(Value: Integer);
    procedure SetYOffset(Value: Integer);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Text: TwwText);
    function EffectiveOffset: TPoint;
  published
    // Published Properties
    property Color: TColor read FColor write SetColor default clBtnShadow;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property XOffset: Integer read FXOffset write SetXOffset default 10;
    property YOffset: Integer read FYOffset write SetYOffset default 10;
  end;

  {
  // Properties related to 3d text effects such as embossing, extrusion,
  // etc.
  //
  // Properties:
  // - Color:    The color of the extrusion nearest to the actual
  //             text.
  //
  // - Depth:    How many pixels (layers) the extrusion is.  The larger
  //             this value, the more layers need to be painted and,
  //             therefore, the slower the algorithm.
  //
  // - Enabled:  Determines whether or not to paint the extrusion.
  //
  // - Orientation: Determines the direction that the extrusion points away from
  //             from the text.
  }

  TwwExtrudeEffects = class(TPersistent)
  private
    FText: TwwText;

    // Property Storage Variables
    FDepth: Integer;
    FEnabled: Boolean;
    FFarColor: TColor;
    FNearColor: TColor;
    FOrientation: TwwOrientation;
    FStriated: Boolean;

    // Property Access Methods
    procedure SetDepth(Value: Integer);
    procedure SetEnabled(Value: Boolean);
    procedure SetFarColor(Value: TColor);
    procedure SetNearColor(Value: TColor);
    procedure SetOrientation(Value: TwwOrientation);
    procedure SetStriated(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Text: TwwText);
    function EffectiveDepth(CheckOrient: Boolean): TSize;
  published
    // Published Properties
    property Depth: Integer read FDepth write SetDepth default 10;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property FarColor: TColor read FFarColor write SetFarColor default clBlack;
    property NearColor: TColor read FNearColor write SetNearColor default clBlack;
    property Orientation: TwwOrientation read FOrientation write SetOrientation default fcBottomRight;
    property Striated: Boolean read FStriated write SetStriated default False;
  end;

  TwwDisabledColors = class(TPersistent)
  private
    FText: TwwText;
    FHighlightColor: TColor;
    FShadeColor: TColor;
    procedure SetHighlightColor(Value: TColor);
    procedure SetShadeColor(Value: TColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Text: TwwText);
  published
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor default clBtnHighlight;
    property ShadeColor: TColor read FShadeColor write SetShadeColor default clBtnShadow;
  end;

  TwwText = class(TPersistent)
  private
    FRect: TRect;

    // Property storage variables
    FAlignment: TAlignment;
    FCanvas: TCanvas;
    FPaintCanvas:TCanvas;

    FDisabledColors: TwwDisabledColors;
    FExtrudeEffects: TwwExtrudeEffects;
    FHighlightColor: TColor;
    FFlags: UINT;
    FFont: TFont;
    FLineSpacing: Integer;
    FOptions: TwwTextOptions;
    FOutlineColor: TColor;
    FRotation: Integer;
    FScaledFont: Boolean;
    FShadeColor: TColor;
    FShadow: TwwShadowEffects;
    FStyle: TwwTextStyle;
    FText: string;
    FCallbacks: TwwTextCallbacks;
    FTextRect: TRect;
    FVAlignment: TwwVAlignment;
    FWordWrap: Boolean;
    FDoubleBuffered: boolean;
    InDraw:Boolean;

    // Property access methods
    function GetAngle: Extended;
    procedure SetAlignment(Value: TAlignment);
    procedure SetHighlightColor(Value: TColor);
    procedure SetLineSpacing(Value: Integer);
    procedure SetOptions(Value: TwwTextOptions);
    procedure SetOutlineColor(Value: TColor);
    procedure SetRotation(Value: Integer);
    procedure SetScaledFont(Value: Boolean);
    procedure SetShadeColor(Value: TColor);
    procedure SetStyle(Value: TwwTextStyle);
    procedure SetText(Value: string);
    procedure SetTextRect(Value: TRect);
    procedure SetVAlignment(Value: TwwVAlignment);
    procedure SetWordWrap(Value: Boolean);
  protected
    FPaintBitmap:TBitmap;
    // Protected methods
    function GetCanvas: TCanvas; virtual;
    function GetLogFont: TLogFont; virtual;
    function GetTextSize: TSize; virtual;
    function CalcTextSize(IgnoreRect: Boolean): TSize; virtual;
    function CalcRect(IgnoreRect: Boolean): TRect; virtual;
    procedure DrawHighlight; virtual;
    procedure DrawOutline; virtual;
    procedure DrawShadow(r: TRect); virtual;
    procedure DrawEmbossed(Raised: Boolean);
    procedure DrawText(r: TRect); virtual;

    procedure AssignTo(Dest: TPersistent); override;
    function GetTextColor: TColor; virtual;

    property Angle: Extended read GetAngle;
    property Font: TFont read FFont;
  public
    Patch: Variant;

    constructor Create(ACallbacks: TwwTextCallbacks; ACanvas: TCanvas; AFont: TFont);
    destructor Destroy; override;

    // Fancy Text Routines
    function CalcDrawRect(IgnoreRect: Boolean): TRect; virtual;
    procedure CallInvalidate; virtual;
    procedure Draw; virtual;
    procedure DrawStandardText; virtual;
    procedure DrawOutlineText; virtual;
    procedure DrawEmbossedText(Raised: Boolean); virtual;
    procedure DrawExtrusion;
    procedure PrepareCanvas; virtual;
    procedure UpdateFont(Value: TFont); virtual;

    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Canvas: TCanvas read GetCanvas write FCanvas;
    property Callbacks: TwwTextCallbacks read FCallbacks write FCallbacks;
    property DisabledColors: TwwDisabledColors read FDisabledColors write FDisabledColors;
    property ExtrudeEffects: TwwExtrudeEffects read FExtrudeEffects write FExtrudeEffects;
    property Flags: UINT read FFlags write FFlags;
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor default clBtnHighlight;
    property LineSpacing: Integer read FLineSpacing write SetLineSpacing default 5;
    property Options: TwwTextOptions read FOptions write SetOptions default [toShowAccel];
    property OutlineColor: TColor read FOutlineColor write SetOutlineColor default clBlack;
    property Rotation: Integer read FRotation write SetRotation default 0;
    property ScaledFont: Boolean read FScaledFont write SetScaledFont;
    property ShadeColor: TColor read FShadeColor write SetShadeColor default clBtnShadow;
    property Shadow: TwwShadowEffects read FShadow write FShadow;
    property Style: TwwTextStyle read FStyle write SetStyle default fclsDefault;
    property Text: string read FText write SetText;
    property TextRect: TRect read FTextRect write SetTextRect;
    property VAlignment: TwwVAlignment read FVAlignment write SetVAlignment;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property DoubleBuffered: boolean read FDoubleBuffered write FDoubleBuffered default False;
  end;

  TwwCaptionText = class(TwwText)
  protected
    function GetTextColor: TColor; override;
  published
    property Alignment;
    property DisabledColors;
    property ExtrudeEffects;
    property HighlightColor;
    property LineSpacing;
    property Options;
    property OutlineColor;
    property Rotation;
    property ShadeColor;
    property Shadow;
    property Style;
    property VAlignment;
    property WordWrap;
    property DoubleBuffered;
  end;

  TwwLabelText = class(TwwCaptionText)
  protected
    function GetTextColor: TColor; override;
  public
    Control: TControl;
  end;

  function MakeCallbacks(InvalidateProc, AdjustBoundsProc: TwwProcMeth;
    GetTextEnabledProc: TwwBoolFunc): TwwTextCallbacks;

implementation

const
  OFFSETCOORD: array[TwwOrientation] of TPoint = (
    (x: 1; y: 1) {TopLeft}, (x: -1; y: 1) {TopRight},
    (x: 1; y: -1) {BottomLeft}, (x: -1; y: -1) {BottomRight},
    (x: 0; y: 1) {Top}, (x: -1; y: 0) {Right},
    (x: 1; y: 0) {Left}, (x: 0; y: -1) {Bottom}
  );

{ RSW - Trunc has problems in C++ Builder during compile time }
function fcTrunc(val: Extended): Longint;
begin
   result:= Round(Val-0.4999); { Changed from -0.5 }
end;

function MakeCallbacks(InvalidateProc, AdjustBoundsProc: TwwProcMeth;
  GetTextEnabledProc: TwwBoolFunc): TwwTextCallbacks;
begin
  result.Invalidate := InvalidateProc;
  result.AdjustBounds := AdjustBoundsProc;
  result.GetTextEnabled := GetTextEnabledProc;
end;

constructor TwwDisabledColors.Create(Text: TwwText);
begin
  inherited Create;
  FText := Text;
  FHighlightColor := clBtnHighlight;
  FShadeColor := clBtnShadow;
end;

procedure TwwDisabledColors.SetHighlightColor(Value: TColor);
begin
  if FHighlightColor <> Value then
  begin
    FHighlightColor := Value;
    FText.Callbacks.Invalidate;
  end;
end;

procedure TwwDisabledColors.SetShadeColor(Value: TColor);
begin
  if FShadeColor <> Value then
  begin
    FShadeColor := Value;
    FText.Callbacks.Invalidate;
  end;
end;

// TwwShadowEffects

procedure TwwShadowEffects.AssignTo(Dest: TPersistent);
begin
  with Dest as TwwShadowEffects do
  begin
    Color := self.Color;
    Enabled := self.Enabled;
    XOffset := self.XOffset;
    YOffset := self.YOffset;
  end;
end;

constructor TwwShadowEffects.Create(Text: TwwText);
begin
  inherited Create;

  FText := Text;

  FColor := clBtnShadow;
  FXOffset := 10;
  FYOffset := 10;
end;

function TwwShadowEffects.EffectiveOffset: TPoint;
begin
  result := Point(0,0);
  if Enabled then result := Point(XOffset, YOffset);
  if FText.ExtrudeEffects.Enabled then
    with OFFSETCOORD[FText.ExtrudeEffects.Orientation] do begin
      if not ((x >= 0) = (result.x > 0)) then
        result.x := 0
      else if not ((x <= 0) = (result.x < 0)) then
        result.x := 0;

      if not ((y >= 0) = (result.y > 0)) then
        result.y := 0
      else if not ((y <= 0) = (result.y < 0)) then
        result.y := 0;
    end;
end;

procedure TwwShadowEffects.SetColor(Value:TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FText.CallInvalidate;
  end;
end;

procedure TwwShadowEffects.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TwwShadowEffects.SetXOffset(Value: Integer);
begin
  if FXOffset <> Value then
  begin
    FXOffset := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TwwShadowEffects.SetYOffset(Value: Integer);
begin
  if FYOffset <> Value then
  begin
    FYOffset := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

// TwwExtrudeEffects

constructor TwwExtrudeEffects.Create(Text: TwwText);
begin
  inherited Create;
  FText := Text;

  FDepth := 10;
  FOrientation := fcBottomRight;
end;

procedure TwwDisabledColors.AssignTo(Dest: TPersistent);
begin
  with Dest as TwwDisabledColors do
  begin
     HighlightColor:= self.HighlightColor;
     ShadeColor:= self.ShadeColor;
  end;
end;

procedure TwwExtrudeEffects.AssignTo(Dest: TPersistent);
begin
  with Dest as TwwExtrudeEffects do
  begin
    Depth := self.Depth;
    Enabled := self.Enabled;
    FarColor := self.FarColor;
    NearColor := self.NearColor;
    Orientation := self.Orientation;
    Striated := self.Striated;
  end;
end;

function TwwExtrudeEffects.EffectiveDepth(CheckOrient: Boolean): TSize;
begin
  result := wwSize(Depth, Depth);
  if Enabled then with OFFSETCOORD[FText.ExtrudeEffects.Orientation] do
  begin
    if CheckOrient then
      result := wwSize(Depth * Abs(x), Depth * Abs(y));
  end else result := wwSize(0,0);
end;

procedure TwwExtrudeEffects.SetDepth(Value: Integer);
begin
  if FDepth <> Value then
  begin
    FDepth := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TwwExtrudeEffects.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TwwExtrudeEffects.SetFarColor(Value: TColor);
begin
  if FFarColor <> Value then
  begin
    FFarColor := Value;
    FText.CallInvalidate;
  end;
end;

procedure TwwExtrudeEffects.SetNearColor(Value: TColor);
begin
  if FNearColor <> Value then
  begin
    FNearColor := Value;
    FText.CallInvalidate;
  end;
end;

procedure TwwExtrudeEffects.SetOrientation(Value: TwwOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TwwExtrudeEffects.SetStriated(Value: Boolean);
begin
  if FStriated <> Value then
  begin
    FStriated := Value;
    FText.CallInvalidate;
  end;
end;

constructor TwwText.Create(ACallbacks: TwwTextCallbacks; ACanvas: TCanvas; AFont: TFont);
begin
  inherited Create;
  FCallbacks := ACallbacks;

  FCanvas := ACanvas;
  FFont := AFont;
  FPaintBitmap := nil;
  FPaintCanvas:= nil;

  FExtrudeEffects := TwwExtrudeEffects.Create(self);
  FHighlightColor := clBtnHighlight;
  FLineSpacing := 5;
  FOptions := [toShowAccel];
  FShadeColor := clBtnShadow;
  FShadow := TwwShadowEffects.Create(self);
  FDisabledColors := TwwDisabledColors.Create(self);

  FFlags := DT_NOCLIP;
end;

destructor TwwText.Destroy;
begin
  FExtrudeEffects.Free;
  FShadow.Free;
  FDisabledColors.Free;
  FPaintBitmap.Free;
  FPaintBitmap := nil;
  FPaintCanvas := nil;
  inherited;
end;

procedure TwwText.AssignTo(Dest: TPersistent);
begin
  with Dest as TwwText do
  begin
    // 4/16/03 - Following items Missing preoviuosly
    Alignment:= self.Alignment;
    DisabledColors.Assign(self.DisabledColors);
    DoubleBuffered:= self.DoubleBuffered;
    WordWrap:= self.WordWrap;
    VAlignment:= self.VAlignment;
    /// End missing items

    ExtrudeEffects.Assign(self.ExtrudeEffects);
    HighlightColor := self.HighlightColor;
    LineSpacing := self.LineSpacing;
    Options := self.Options;
    OutlineColor := self.OutlineColor;
    Rotation := self.Rotation;
    ShadeColor := self.ShadeColor;
    Shadow.Assign(self.Shadow);
    Style := self.Style;
    Text := self.Text;
  end;
end;

function TwwText.GetAngle: Extended;
begin
  result := DegToRad(Rotation);
end;

procedure TwwText.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    CallInvalidate;
  end;
end;

procedure TwwText.SetLineSpacing(Value: Integer);
begin
  if Value <> FLineSpacing then
  begin
    FLineSpacing := Value;
    Callbacks.AdjustBounds;
    CallInvalidate;
  end;
end;

procedure TwwText.SetHighlightColor(Value: TColor);
begin
  if FHighlightColor <> Value then
  begin
    FHighlightColor := Value;
    CallInvalidate;
  end;
end;

procedure TwwText.SetOptions(Value: TwwTextOptions);
begin
  if Value <> FOptions then
  begin
    FOptions := Value;
    wwAdjustFlag(not (toShowAccel in FOptions), FFlags, DT_NOPREFIX);
    wwAdjustFlag(toShowEllipsis in FOptions, FFlags, DT_END_ELLIPSIS);
    Callbacks.AdjustBounds;
    CallInvalidate;
  end;
end;

procedure TwwText.SetOutlineColor(Value: TColor);
begin
  if Value <> FOutlineColor then
  begin
    FOutlineColor := Value;
    CallInvalidate;
  end;
end;

procedure TwwText.SetRotation(Value: Integer);
begin
  if (Value < 0) then FRotation := 360 - (Abs(Value) mod 360)
  else FRotation := Value mod 360;
  Callbacks.AdjustBounds;
  CallInvalidate;
end;

procedure TwwText.SetScaledFont(Value: Boolean);
begin
  if FScaledFont <> Value then
  begin
    FScaledFont := Value;
    CallInvalidate;
  end;
end;

procedure TwwText.SetShadeColor(Value: TColor);
begin
  if FShadeColor <> Value then
  begin
    FShadeColor := Value;
    CallInvalidate;
  end;
end;

procedure TwwText.SetStyle(Value: TwwTextStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Callbacks.AdjustBounds;
    CallInvalidate;
  end;
end;

procedure TwwText.SetText(Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
//    CallInvalidate;
  end;
end;

procedure TwwText.SetTextRect(Value: TRect);
begin
  FTextRect := Value;
end;

procedure TwwText.SetVAlignment(Value: TwwVAlignment);
begin
  if FVAlignment <> Value then
  begin
    FVAlignment := Value;
    CallInvalidate;
  end;
end;

procedure TwwText.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    wwAdjustFlag(WordWrap, FFlags, DT_WORDBREAK);
    CallInvalidate;
  end;
end;

function TwwText.GetLogFont: TLogFont;
const TRUETYPE: array[Boolean] of Integer = (OUT_TT_PRECIS, OUT_TT_ONLY_PRECIS);
begin
  with result do begin
    lfHeight := Font.Height;
    if ScaledFont then lfHeight := fcTrunc(lfHeight * (Screen.PixelsPerInch / 96));
    lfWidth := 0;
    lfEscapement := Rotation * 10;
    lfOrientation := Rotation * 10;

    if fsBold in Font.Style then lfWeight := FW_BOLD else lfWeight := FW_NORMAL;
    if fsItalic in Font.Style then lfItalic := 1 else lfItalic := 0;
    if fsUnderline in Font.Style then lfUnderline := 1 else lfUnderline := 0;
    if fsStrikeOut in Font.Style then lfStrikeout := 1 else lfStrikeout := 0;

    lfCharSet := ANSI_CHARSET;              {Default}

    if Font.CharSet <> DEFAULT_CHARSET then
       lfCharSet := Font.CharSet; { 6/4/99 - Use font's charset }

    lfOutPrecision := TRUETYPE[Rotation <> 0];
    lfClipPrecision := CLIP_DEFAULT_PRECIS; {Default}
    lfQuality := PROOF_QUALITY;             {Windows gets a better one if available}
    lfPitchAndFamily := VARIABLE_PITCH;     {Default}
    StrPCopy(lfFaceName, Font.Name);        {Canvas's font name}
  end;
end;

function TwwText.CalcTextSize(IgnoreRect: Boolean): TSize;
var Angle: Extended;
    TextSize: TSize;
begin
  Angle := self.Angle;
  TextSize := GetTextSize;

  // Correct for Extrusion
  with ExtrudeEffects.EffectiveDepth(False) do
    result := wwSize(
    TextSize.cx + cx,
    TextSize.cy + cy);

  with Shadow.EffectiveOffset do begin
    inc(result.cx, x);
    inc(result.cy, y);
  end;

  // Correct for Outline
  if Style = fclsOutline then begin
    inc(result.cx, 2);
    inc(result.cy, 2);
  end;

  // Correct for Rotation
  with result do
    result := wwSize(
      fcTrunc(cx * Abs(Cos(Angle)) + cy * Abs(Sin(Angle))),
      fcTrunc(cx * Abs(Sin(Angle)) + cy * Abs(Cos(Angle))));

//  IgnoreRect := False;

  // Correct for TextRect
  if not IgnoreRect then
    with result do result := wwSize(
      wwMin(cx, wwRectWidth(TextRect)),
      wwMin(cy, wwRectHeight(TextRect)));
end;

function TwwText.CalcRect(IgnoreRect: Boolean): TRect;
var Angle: Extended;
    TextSize: TSize;
begin
  Angle := Self.Angle;

  result.Left := TextRect.Left + wwRectWidth(TextRect) div 2;   // Place initial position in
  result.Top := TextRect.Top + wwRectHeight(TextRect) div 2;    // dead center.

  with Shadow.EffectiveOffset do
  begin
    dec(result.Left, x div 2);                 // Correct for shadow offsets.
    dec(result.Top, y div 2);
  end;

  with ExtrudeEffects.EffectiveDepth(False) do begin
    dec(result.Left, cx div 2); // Correct for extrusion
    dec(result.Top, cy div 2);
  end;

  // Now correct for rotation
  TextSize := GetTextSize;//CalcTextSize(IgnoreRect);
  with TextSize do
  begin
    dec(result.Left, fcTrunc(Cos(Angle) * cx) div 2);
    inc(result.Top, fcTrunc(Sin(Angle) * cx) div 2);
    dec(result.Top, fcTrunc(Cos(Angle) * cy) div 2);
    dec(result.Left, fcTrunc(Sin(Angle) * cy) div 2);
  end;

  with CalcTextSize(IgnoreRect), result do
    result := Rect(Left, Top, Left + cx, Top + cy);

  // Make sure the point is at least at (0, 0);
//  with result do
//    OffsetRect(result, Abs(fcMin(0, Left)), Abs(fcMin(0, Top)));
  with TextRect do
    OffsetRect(result, Abs(wwMin(0, result.Left - Left)), Abs(wwMin(0, result.Top - Top)));
end;

function TwwText.GetTextSize: TSize;
var s: string;
  r:TRect;
  sz:TSize;
  xoffset:integer;
  yoffset:integer;
begin
  if toShowAccel in Options then
    s := wwStripAmpersands(Text)
  else s := Text;
  r:=Rect(TextRect.Left,TextRect.Top,TextRect.Right,TextRect.Bottom);
  sz := ExtrudeEffects.EffectiveDepth(False);
  xoffset := Max(Shadow.effectiveoffset.x,sz.cx);
  yoffset := Max(Shadow.effectiveoffset.y,sz.cy);
  r.Right := r.right-xoffset;
  r.Bottom := r.Bottom-yoffset;
  with wwMultiLineTextSize(Canvas, s, LineSpacing, ord(WordWrap) * wwRectWidth(r), Flags) do
    result := wwSize(cx, cy);
  result.cx:= result.cx+1; // 11/9/01 RSW - Fix boldface problem where it was showing trailing ellipsis even when it fit
end;

procedure TwwText.DrawHighlight;
var r: TRect;
begin
  r := FRect;
  with OFFSETCOORD[ExtrudeEffects.Orientation] do OffsetRect(r, -x, -y);

  Canvas.Font.Color := HighlightColor;
  DrawText(r);
  Canvas.Font.Color := Font.Color;
  DrawText(FRect);
end;

procedure TwwText.DrawShadow(r: TRect);
begin
  if not Shadow.Enabled then Exit;
  OffsetRect(r, Shadow.XOffset, Shadow.YOffset);
  Canvas.Font.Color := wwThisThat(Callbacks.GetTextEnabled, Shadow.Color, DisabledColors.ShadeColor);
  DrawText(r);
end;

procedure TwwText.DrawOutline;
var i: TwwOrientation;
    r: TRect;
begin
  for i := Low(OFFSETCOORD) to HIGH(OFFSETCOORD) do with OFFSETCOORD[i] do
  begin
    r := FRect;
    OffsetRect(r, x, y);
    Canvas.Font.Color := wwThisThat(Callbacks.GetTextEnabled, OutlineColor, DisabledColors.ShadeColor);
    DrawText(r);
  end;
  r := FRect;
  Canvas.Font.Color := wwThisThat(Callbacks.GetTextEnabled, Font.Color, DisabledColors.HighlightColor);
  DrawText(r);
end;

procedure TwwText.DrawEmbossed(Raised: Boolean);
var r: TRect;
    HighlightColor, ShadeColor: TColor;
begin
  HighlightColor := wwThisThat(Callbacks.GetTextEnabled, self.HighlightColor, DisabledColors.HighlightColor);
  ShadeColor := wwThisThat(Callbacks.GetTextEnabled, self.ShadeColor, DisabledColors.ShadeColor);//clBtnShadow);

  if Callbacks.GetTextEnabled and not
    (((ShadeColor = clNone) and not Raised) or
     ((HighlightColor = clNone) and Raised)) then
  begin
    r := FRect;
    OffsetRect(r, -1, -1);
    Canvas.Font.Color := wwThisThat(Raised, HighlightColor, ShadeColor);
    DrawText(r);
  end;

  if not (((HighlightColor = clNone) and not Raised) or
      ((ShadeColor = clNone) and Raised)) then
  begin
    r := FRect;
    OffsetRect(r, 1, 1);
    Canvas.Font.Color := wwThisThat(Raised, ShadeColor, HighlightColor);
    DrawText(r);
  end;

  r := FRect;
  Canvas.Font.Color := wwThisThat(Callbacks.GetTextEnabled, Font.Color, DisabledColors.ShadeColor);
  DrawText(r);
end;

procedure TwwText.DrawText(r: TRect);
var i: Integer;
    s: string;
    Angle: Extended;
    CurLineHeight: Integer;
    tempr:TRect;

    n, extra, blanks: Integer;
    juststr: string;
    linecount:integer;
    curpos,priorpos,curwidth:integer;
    tokenword:string;
    paragraphend:boolean;
    k:integer;
    oldbkmode:integer;
    Delimiter:string;
begin
  Angle := self.Angle;

  CurLineHeight := wwLineHeight(Canvas, Flags, max(5,wwRectWidth(r){-10}), 'AgTpjW');// + LineSpacing -2;
  if CurLineHeight=0 then
  begin
     exit;
  end;
  LineCount := (wwRectHeight(r) div CurLineHeight) + 1;
  OldBkMode := SetBkMode(Canvas.Handle, TRANSPARENT);
  if Wordwrap and (toFullJustify in Options) then begin
    if wwCountTokens(Text,#10#10) > 1 then Delimiter := #10#10
    else Delimiter := #13#10;

    for k := 0 to wwCountTokens(Text, Delimiter) - 1 do begin
      s := wwGetToken(Text, Delimiter, k);
      curPos := 1;
      for i := 0 to LineCount +1 do begin
        curwidth := 0;
        tokenword := wwGetWord(s,curPos,[], ' ' + #9); //[' ',#9]);
        if tokenword = '' then begin
           OffsetRect(r, fcTrunc(Sin(Angle) * CurLineHeight), fcTrunc(Cos(Angle) * CurLineHeight));
           break;
        end;
        juststr := '';
        paragraphend := false;
        blanks := 0;
        priorpos:=curpos;
        while (curwidth+Canvas.TextWidth(Tokenword)<wwRectWidth(r){-10}) {and (tokenword <> '')} do begin
          if (length(tokenword)=1) and (tokenword <> ' ') then
           juststr := juststr+tokenword+' '
          else juststr := juststr+tokenword{+' '};
          priorpos:=curpos;
          tokenword := wwgetWord(s,curPos,[],#32 + #9); //[#32,#9]);
          if (tokenword = '') then begin
             paragraphend := true;
             break;
          end;
          curwidth := Canvas.TextWidth(juststr);
        end;
        if not (curwidth+Canvas.TextWidth(Tokenword)<wwRectWidth(r)) then
           curpos:=priorpos;
        JustStr := Trim(JustStr);
        for n:= 1 to length(juststr) do
          if juststr[n] = ' ' then inc( blanks );
        extra := wwRectWidth(r) {- 10}- Canvas.textwidth(juststr);
        if (not paragraphend) and (blanks > 0) then//and (i< fcCountTokens(Text, #13#10)-1) then
           settextjustification(Canvas.handle, extra, blanks );
        Canvas.textout(r.Left, r.top, juststr);
        settextjustification(Canvas.handle, 0, 0 );
        OffsetRect(r, fcTrunc(Sin(Angle) * CurLineHeight), fcTrunc(Cos(Angle) * CurLineHeight));
        if paragraphend then begin
           OffsetRect(r, fcTrunc(Sin(Angle) * LineSpacing), fcTrunc(Cos(Angle) * LineSpacing));
           break;
        end;
      end; // End For i
    end; //End For k
  end
  else begin
    //9/19/2001 - Was not incrementing the rect when multiple line label.
    tempr := Rect(r.left,r.top,r.right{-10},r.bottom);
    for i := 0 to wwCountTokens(Text, #13#10) - 1 do
    begin
      s := wwGetToken(Text, #13#10, i);
      tempr := Rect(tempr.left,tempr.top,tempr.right,tempr.bottom);
      DrawTextEx(Canvas.Handle, PChar(s), Length(s),tempr, Flags, nil);
      CurLineHeight := wwLineHeight(Canvas, Flags, wwRectWidth(r), s) + LineSpacing;
      OffsetRect(tempr,
        fcTrunc(Sin(Angle) * CurLineHeight),
        fcTrunc(Cos(Angle) * CurLineHeight)
      );
    end;
    SetBkMode(Canvas.Handle, OldBkMode);
  end;
{   len := SendMessage( editcontrol_handle, EM_LINELENGTH, lineindex, 0 );
   If len > 0 Then Begin
     pBuf := StrAlloc( len + 1 );
     If Assigned( pBuf ) Then
     try
       SendMessage( editcontrol_handle, EM_GETLINE, lineindex,
                    longint(pBuf));
       ... do something with the text, e.g. StrPas it to a Pascal string
     finally
       StrDispose( pBuf );
     end;
   End; }
end;

// Initializes the Canvas's font using the rotation passed in.  Also
// set's the Canvas' font color to the passed in Font.Color.  The result
// is essentially the rectangle that should be used for any subsequent
// call to DrawTextEx as the position and size are calculated here.
//
// Always remember to "DeleteObject" the Canvas.Font.Handle when done.
//
// - ksw (9/28/98)

procedure TwwText.PrepareCanvas;
begin
  // Must Free This!
  Canvas.Font.Handle := CreateFontIndirect(GetLogFont);

  Canvas.Font.Color := Font.Color;

  FRect := CalcRect(False);
end;

function TwwText.CalcDrawRect(IgnoreRect: Boolean): TRect;
begin
  Canvas.Font.Handle := CreateFontIndirect(GetLogFont);
  try
    result := CalcRect(IgnoreRect);
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TwwText.CallInvalidate;
begin
  if Assigned(Callbacks.Invalidate) then Callbacks.Invalidate;
end;

procedure TwwText.UpdateFont(Value:TFont);
begin
   Font.Style := Value.Style;
   Font.Name := Value.Name;
   Font.Size := Value.Size;
   Font.Color := Value.Color;
   Font.Height := Value.Height;
   Font.Pitch := Value.Pitch;
   Font.Charset := value.Charset;
end;

procedure TwwText.Draw;
 procedure DoubleBufferedDraw;
 var aUpdateRect:TRect;
 begin
  aUpdateRect := Canvas.ClipRect;
  FPaintBitmap := TBitmap.Create;
  FPaintCanvas := FPaintBitmap.Canvas;
  try
    // 9/26/2001 - Paintbitmap not large enough so not working on statusbar right aligned.
    FPaintBitmap.width := aUpdateRect.Right{-aUpdateRect.Left};//CalcDrawRect(True).Right;
    FPaintBitmap.Height := aUpdateRect.Bottom{-aUpdateRect.Top};//CalcDrawRect(True).Bottom;
//    FPaintCanvas.CopyRect(CalcDrawRect(True),FCanvas,CalcDrawRect(True));
    with FPaintBitmap, aUpdateRect do
       BitBlt(FPaintBitmap.Canvas.Handle, Left, Top, Right - Left, Bottom - Top, self.Canvas.Handle, Left, Top, SRCCOPY);
    InDraw:=True;
    if Rotation mod 360 = 0 then with TextRect do
    begin
      if Alignment = taCenter then Flags := Flags or DT_CENTER else Flags := Flags and not DT_CENTER;
      if Alignment = taRightJustify then Flags := Flags or DT_RIGHT else Flags := Flags and not DT_RIGHT;
      case Alignment of
        taLeftJustify: TextRect := Rect(Left, Top, Left + wwRectWidth(CalcDrawRect(False)), Bottom);
        taRightJustify: TextRect := Rect(Right - wwRectWidth(CalcDrawRect(False)), Top, Right, Bottom);
      end;
      case VAlignment of
        vaTop: TextRect := Rect(Left, Top, Right, wwRectHeight(CalcDrawRect(False)));
        vaBottom: TextRect := Rect(Left, Bottom - wwRectHeight(CalcDrawRect(False)), Right, Bottom);
      end;
    end else Flags := Flags and not DT_CENTER and not DT_RIGHT;  // Added to correct bug where text was not painted in the proper position when rotated.  -ksw (5/20/99)

    case Style of
      fclsDefault: DrawStandardText;
      fclsLowered: DrawEmbossedText(False);
      fclsRaised: DrawEmbossedText(True);
      fclsOutline: DrawOutlineText;
    end;
    InDraw:=False;
    with FPaintBitmap, aUpdateRect do
       BitBlt(Self.Canvas.Handle, Left, Top, Right - Left, Bottom - Top, Canvas.Handle, Left, Top, SRCCOPY);

  finally
    InDraw:=False;
    FPaintBitmap.Free;
    FPaintBitmap := nil;
    FPaintCanvas := nil;
  end;
 end;

begin
  if (DoubleBuffered) then
  begin
     DoubleBufferedDraw;
     exit;
  end;

  if Rotation mod 360 = 0 then with TextRect do
  begin
    if Alignment = taCenter then Flags := Flags or DT_CENTER else Flags := Flags and not DT_CENTER;
    if Alignment = taRightJustify then Flags := Flags or DT_RIGHT else Flags := Flags and not DT_RIGHT;
    case Alignment of
      taLeftJustify: TextRect := Rect(Left, Top, Left + wwRectWidth(CalcDrawRect(False)), Bottom);
      taRightJustify: TextRect := Rect(Right - wwRectWidth(CalcDrawRect(False)), Top, Right, Bottom);
    end;
    case VAlignment of
      vaTop: TextRect := Rect(Left, Top, Right, wwRectHeight(CalcDrawRect(False)));
      vaBottom: TextRect := Rect(Left, Bottom - wwRectHeight(CalcDrawRect(False)), Right, Bottom);
    end;
  end else Flags := Flags and not DT_CENTER and not DT_RIGHT;  // Added to correct bug where text was not painted in the proper position when rotated.  -ksw (5/20/99)

  case Style of
    fclsDefault: DrawStandardText;
    fclsLowered: DrawEmbossedText(False);
    fclsRaised: DrawEmbossedText(True);
    fclsOutline: DrawOutlineText;
  end;

end;

function TwwText.GetTextColor;
begin
  if wwIsCustomStyle(nil) and not CallBacks.GetTextEnabled then
     result:= StyleServices.GetStyleFontColor(sfButtonTextDisabled)
  else
     result:= Font.Color;
end;

function TwwCaptionText.GetTextColor;
begin
   if wwIsCustomStyle(nil) then
   begin
      if not CallBacks.GetTextEnabled then
        result:= StyleServices.GetStyleFontColor(sfButtonTextDisabled)
      else
        result:= StyleServices.GetStyleFontColor(sfButtonTextNormal);
   end
   else result:= inherited GetTextColor;
end;

procedure TwwText.DrawStandardText;
begin
  // If disabled, draw the standard embossed (disabled) text.
  if (not Callbacks.GetTextEnabled) and not wwIsCustomStyle(nil) then
  begin
    DrawEmbossedText(False);
    Exit;
  end;

  PrepareCanvas;

  try
    DrawExtrusion;
    DrawShadow(FRect);
    Canvas.Font.Color := GetTextColor;
    DrawText(FRect);
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TwwText.DrawOutlineText;
begin
  PrepareCanvas;
  try
    DrawExtrusion;
    DrawShadow(FRect);
    DrawOutline;
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TwwText.DrawEmbossedText(Raised: Boolean);
begin
  PrepareCanvas;
  try
    Canvas.Lock;
    DrawExtrusion;
    DrawShadow(FRect);
    DrawEmbossed(Raised);
  finally
    Canvas.UnLock;
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TwwText.DrawExtrusion;
var ExtrudeColor, ShadeColor: TRGBQuad;
    i: Integer;
begin
  with ExtrudeEffects do
  begin
    if not Enabled then Exit;

    with ExtrudeColor do
      wwColorToByteValues(ExtrudeEffects.NearColor, rgbReserved, rgbBlue, rgbGreen, rgbRed);
    with ShadeColor do
      wwColorToByteValues(ExtrudeEffects.FarColor, rgbReserved, rgbBlue, rgbGreen, rgbRed);

    with ExtrudeEffects.EffectiveDepth(True) do
    begin
      OffsetRect(FRect, cx div 2, cy div 2);
      with OFFSETCOORD[ExtrudeEffects.Orientation] do
        OffsetRect(FRect, -x * (cx div 2), -y * (cy div 2));
    end;

    // Draw Gradiated Extrusion
    for i := 1 to Depth do
    begin
      with OFFSETCOORD[Orientation] do
        OffsetRect(FRect, x, y);

      if not Striated then Canvas.Font.Color := RGB(
        fcTrunc(ShadeColor.rgbRed + ((ExtrudeColor.rgbRed - ShadeColor.rgbRed) / (Depth / i))),
        fcTrunc(ShadeColor.rgbGreen + ((ExtrudeColor.rgbGreen - ShadeColor.rgbGreen) / (Depth / i))),
        fcTrunc(ShadeColor.rgbBlue + ((ExtrudeColor.rgbBlue - ShadeColor.rgbBlue) / (Depth / i)))
      )
      else Canvas.Font.Color := RGB(
        i * (ShadeColor.rgbRed + ((ExtrudeColor.rgbRed - ShadeColor.rgbRed) div Depth)) div (ord(i mod 2 = 0) * 3 + 1),
        i * (ShadeColor.rgbGreen + ((ExtrudeColor.rgbGreen - ShadeColor.rgbGreen) div Depth)) div (ord(i mod 2 = 0) * 3 + 1),
        i * (ShadeColor.rgbBlue + ((ExtrudeColor.rgbBlue - ShadeColor.rgbBlue) div Depth)) div (ord(i mod 2 = 0) * 3 + 1)
      );

      DrawText(FRect);
    end;
  end;
end;

function TwwText.GetCanvas: TCanvas;
begin
  if InDraw then
     result:= FPaintCanvas
  else
     result:= FCanvas;
end;

function TwwLabelText.GetTextColor: TColor;
begin
   // Image buttons don't use style colors as their colors are not the style but more the image
   if wwIsCustomStyle(Control) then //and not fcIsClass(Control.ClassType, 'TfcImageBtn') then
   begin
     result:= StyleServices.GetStyleFontColor(sfButtonTextNormal);
   end
   else result:= Font.Color;

end;


end.

