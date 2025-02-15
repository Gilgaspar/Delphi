unit MultStringGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  TVerticalAlignment = (vaTop, vaCenter, vaBottom);
  TMultStringGridAlignmentEvent=procedure(Sender:TObject;ACol,ARow:Integer;var HorAlignment:TAlignment;var VerAlignment:TVerticalAlignment) of object;
  TMultStringGridColorEvent=procedure(Sender:TObject;ACol,ARow:Integer;AState:TGridDrawState;ABrush:TBrush;AFont:TFont) of object;

  TMultStringGrid = class(TStringGrid)
  private
    FAlignment : TAlignment;
    FVerticalAlignment : TVerticalAlignment;
    FMultiLinha : Boolean;
    FOnGetCellAlignment : TMultStringGridAlignmentEvent;
    FOnGetCellColor : TMultStringGridColorEvent;
    FForceDrawCell: Boolean;
    procedure SetAlignment(Valor : TAlignment);
    procedure SetVerticalAlignment(Valor : TVerticalAlignment);
    procedure SetMultiLinha(Valor : Boolean);
    procedure SetForceDrawCell(const Value: Boolean);
  protected
    procedure DrawCell(ACol,ARow : LongInt; ARect : TRect; AState : TGridDrawState); override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property Alignment : TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property VerticalAlignment : TVerticalAlignment read FVerticalAlignment write SetVerticalAlignment default vaCenter;
    property MultiLinha : Boolean read FMultiLinha write SetMultiLinha default False;
    property OnGetCellAlignment : TMultStringGridAlignmentEvent read FOnGetCellAlignment write FOnGetCellAlignment;
    property OnGetCellColor : TMultStringGridColorEvent read FOnGetCellColor write FOnGetCellColor;
    property Options default [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing];
    property ForceDrawCell: Boolean read FForceDrawCell write SetForceDrawCell default False;
  end;

procedure Register;

implementation

constructor TMultStringGrid.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FAlignment:=taLeftJustify;
  FVerticalAlignment:=vaCenter;
  {FColor:=clWindowText;}
  FMultiLinha:=False;
  Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing];
end;

procedure TMultStringGrid.SetAlignment(Valor : TAlignment);
begin
  if valor <> FAlignment then
  begin
    FAlignment:=Valor;
    Invalidate;
  end;
end;

procedure TMultStringGrid.SetVerticalAlignment(Valor : TVerticalAlignment);
begin
  if valor <> FVerticalAlignment then
  begin
    FVerticalAlignment:=Valor;
    Invalidate;
  end;
end;

procedure TMultStringGrid.SetMultiLinha(Valor : Boolean);
begin
  if valor <> FMultiLinha then
  begin
    FMultiLinha:=Valor;
    Invalidate;
  end;
end;

procedure TMultStringGrid.DrawCell(ACol,ARow : Integer; ARect : TRect; AState : TGridDrawState);
const
  TextAlignments : Array[TAlignment] of Word = (dt_Left, dt_Right, dt_Center);
var
  HorAlignment : TAlignment;
  VerAlignment : TVerticalAlignment;
  Texto : string;
  Altura : integer;
  CRect : TRect;
  Options : integer;
begin
  Texto:=Cells[ACol,ARow];
  HorAlignment:=FAlignment;
  VerAlignment:=FVerticalAlignment;
  if Assigned(FOnGetCellAlignment) then FOnGetCellAlignment(Self,ACol,ARow,HorAlignment,VerAlignment);
  if Assigned(FOnGetCellColor) then FOnGetCellColor(Self,ACol,ARow,AState,Canvas.Brush,Canvas.Font);
  Canvas.FillRect(ARect);
  Inc(ARect.Left,2);
  Dec(ARect.Right,2);
  CRect:=Arect;
  Options:=TextAlignments[HorAlignment] or dt_VCenter;
  if Multilinha then Options:=Options or dt_WordBreak;

  if DefaultDrawing then
  with ARect,Canvas do
  begin
    Altura:=DrawText(Handle,PChar(Texto),-1,CRect, options or dt_CalcRect);
    if FVerticalAlignment = vaCenter then
    begin
      if Altura < Bottom-Top+1 then
      begin
        Top:=(Bottom+Top-Altura) shr 1;
        Bottom:=Top+Altura;
      end;
    end
    else if FVerticalAlignment = vaBottom then
      if Altura < Bottom-Top+1 then Top:=Bottom-Altura;
    DrawText(Handle,PChar(Texto),-1,ARect,options)
  end;

  if not DefaultDrawing or FForceDrawCell then
     inherited DrawCell(ACol,ARow,ARect,AState);

end;

procedure TMultStringGrid.SetForceDrawCell(const Value: Boolean);
begin
  FForceDrawCell := Value;
end;

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TMultStringGrid]);
end;

end.
