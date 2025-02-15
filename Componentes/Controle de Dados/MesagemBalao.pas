unit MesagemBalao;

interface

uses
  Forms, Windows, ExtCtrls, Themes, SysUtils, Classes, Controls, Graphics, Messages;

type
  TMensagemBalao = class(TCustomControl)
  private
    FAlignment: TAlignment;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FTransparentColor: Boolean;
    FTransparentColorValue: TColor;

    procedure SetAlignment(const Value: TAlignment);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  //procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Color;
    property Caption;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
  end;

procedure Register;

implementation

uses Types;

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TMensagemBalao]);
end;

{ TMensagemBalao }


procedure TMensagemBalao.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

constructor TMensagemBalao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner); // chama o construtor original
  Color       := clYellow;
  FAlignment  := taCenter;
  FAlphaBlend:=True;
  FAlphaBlendValue:=50;
  FTransparentColor:=True;
  FTransparentColorValue:=Color;
end;

destructor TMensagemBalao.Destroy;
begin
  inherited Destroy;
end;

procedure TMensagemBalao.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  vRect, Rect: TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;
  i, vBot, vLef: Integer;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

var LBitmap: TBitMap;
    LBlendStruct: TBlendFunction;

begin
  ControlStyle := ControlStyle - [csOpaque];
  Perform(WM_ERASEBKGND, Handle, Handle);

  {
  LBitmap := TBitmap.Create;
  LBitmap.Width := 1;
  LBitmap.Height := 1;
  LBitmap.Canvas.Pixels[0,0] := clRed;
  LBlendStruct.BlendOp := AC_SRC_OVER;
  LBlendStruct.BlendFlags := 0;
  LBlendStruct.SourceConstantAlpha := 127;
  LBlendStruct.AlphaFormat := 0;
  Windows.AlphaBlend(Canvas.Handle, 0, 0, Width, Height, LBitmap.Canvas.Handle, 0, 0, LBitmap.Width, LBitmap.Height, LBlendStruct);
  LBitmap.Free;
  }

  LBlendStruct.BlendOp := AC_SRC_OVER;
  LBlendStruct.BlendFlags := 0;
  LBlendStruct.SourceConstantAlpha := 127;
  LBlendStruct.AlphaFormat := 0;
  Windows.AlphaBlend(Canvas.Handle, 0, 0, Width, Height, 0, 0, 0, 1, 1, LBlendStruct);

  vRect := GetClientRect;
  Rect  := GetClientRect;
  vBot  := Rect.Bottom -Round(Rect.Bottom * 0.3);
  vLef  := Rect.Left   +Round(Rect.Right  * 0.1);
  Rect.Bottom := vBot;

  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;

  with Canvas do
  begin
    if not ThemeServices.ThemesEnabled or not ParentBackground then
    begin
      Brush.Color := Color;
      FillRect(Rect);
    end;
    Brush.Style := bsClear;
    Font := Self.Font;
    FontHeight := TextHeight('W');
    with Rect do
    begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[FAlignment];
    Flags := DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(Caption), -1, Rect, Flags);

  //...
    Brush.Style := bsSolid;
    Brush.Color := Color;
    MoveTo(vLef, vBot);
    LineTo(vLef, vRect.Bottom);
    for i := vLef to vLef+20 do
    begin
      LineTo(i, vBot);
      MoveTo(vLef, vRect.Bottom);
    end;

  end;
end;

procedure TMensagemBalao.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  Invalidate;
end;


{procedure TMensagemBalao.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := -1;
end;}



end.
