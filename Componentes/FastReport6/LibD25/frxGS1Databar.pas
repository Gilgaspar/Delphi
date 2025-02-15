
{******************************************}
{                                          }
{             FastReport v6.3              }
{               GS1 Databars               }
{                                          }
{             Copyright (c) 2019           }
{             by Sergey Plastun,           }
{             Fast Reports, Inc.           }
{                                          }
{******************************************}

unit frxGS1Databar;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ELSE}
  Windows, Messages,
{$ENDIF}
  SysUtils, Types, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, frxBarcode2DBase, frxGS1Databar_Helper;


type
  TfrxGS1Databar = class(TfrxBarcode2DBaseWithUnion)
  private
    base: TBaseDatabar;
    FOriginalHeight: Integer;
  protected
    function Generate(Text: string; rebase: Boolean = True): Integer; Virtual; Abstract;
    procedure SetHeight(const Value: Integer); override;
    function GetHeight: Integer; override;
  public
    constructor Create; override;
    destructor  Destroy; override;
    procedure   Assign(src: TfrxBarcode2DBase); override;
    procedure RePaint();
    function IsScaled: Boolean; override;
  end;

  TfrxGS1DatabarE = class(TfrxGS1Databar)
  protected
    function Generate(Text: string; rebase: Boolean = True): Integer; override;
  public
    procedure SetText(v: string); override;
    constructor Create; override;
  end;

  TfrxGS1DatabarES = class(TfrxGS1Databar)
  protected
    FColumns: Integer;
    procedure SetColumns(Col: Integer);
    function Generate(Text: string; rebase: Boolean = True): Integer; override;
  public
    procedure SetText(v: string); override;
    constructor Create; override;
    property Columns: Integer read FColumns write SetColumns;
  end;


implementation


{ TfrxBarcodeQR }

procedure TfrxGS1Databar.Assign(src: TfrxBarcode2DBase);
var
   BSource : TfrxGS1Databar;
begin
   inherited;
   if src is TfrxGS1Databar then
   begin
      BSource    := TfrxGS1Databar(src);
      FHeight    := BSource.FHeight;
      QuietZone := BSource.QuietZone;
   end;
end;

destructor TfrxGS1Databar.Destroy;
begin
  FreeAndNil(base);
  inherited;
end;

function TfrxGS1Databar.GetHeight: Integer;
begin
  if FHeight = 0 then
  begin
    FHeight := FOriginalHeight div FPixelHeight - Round(GetFooterHeight);
    Generate(Text, True);
  end;
  Result := inherited GetHeight;
end;

function TfrxGS1Databar.IsScaled: Boolean;
begin
  Result := True;
end;

procedure TfrxGS1Databar.RePaint();
begin
  Text := Text;
end;

procedure TfrxGS1Databar.SetHeight(const Value: Integer);
begin
  FOriginalHeight := Value;
  FHeight := 0;
end;

constructor TfrxGS1Databar.Create;
begin
  inherited;
  PixelWidth := 1;
  PixelHeight := 1;
  QuietZone := 0;
  FHeight := 0;
  Text := '(01)12345678901234';
end;

constructor TfrxGS1DatabarE.Create;
begin
  inherited;
end;

constructor TfrxGS1DatabarES.Create;
begin
  FColumns := 2;
  inherited;
end;

procedure TfrxGS1DatabarE.SetText(v: string);
begin
  inherited;
  Generate(v);
end;

procedure TfrxGS1DatabarES.SetText(v: string);
begin
  inherited;
  Generate(v);
end;

function TfrxGS1DatabarE.Generate(Text: string; rebase: Boolean = True): Integer;
var
  i, iLeft: Integer;
  black: Boolean;
begin
  result := 0;
  ClearFigures;
  if rebase then
    try
      FreeAndNil(base);
      base := Code_DBEorES(Text, False);
    except
      on e : Exception do
      begin
        FText := '(01)12345678901234';
        base := Code_DBEorES(FText, False);
      end;
    end;
  FWidth := CalcSumArrayOfInteger(base.elements);
  black := false;
  i := 0;
  iLeft := 0;
  while(base.elements[i] > 0) do
  begin
    if(black) then
    begin
      FVectorPrimitivesAdd(iLeft, 0, base.elements[i], FHeight);
    end;
    black := not black;
    inc(iLeft, base.elements[i]);
    inc(i);
  end;
end;

function TfrxGS1DatabarES.Generate(Text: string; rebase: Boolean = True): Integer;
var
  i, row, BarHeight, block_width, LX, LY, SumMil, BigLineHeight, kolBigLine: Integer;
  isspace: Boolean;
begin
  ClearFigures;
  if rebase then
    try
      FreeAndNil(base);
      base := Code_DBEorES(Text, True, FColumns);
    except
      on e : Exception do
      begin
        FText := '(01)12345678901234';
        base := Code_DBEorES(FText, True, FColumns);
      end;
    end;
  SumMil := 0;
  for i := 0 to Length(base.row_height) - 1 do
    inc(SumMil, base.row_height[i]);
  kolBigLine := SumMil div 3 + 1;
  BigLineHeight := (FHeight - SumMil) div kolBigLine; // BigLinesHeight = (FHeight - SumMil);
  if BigLineHeight < 1 then
    BigLineHeight := 1;
  result := FHeight - kolBigLine * BigLineHeight - SumMil;
  LY := 0;
  for row := 0 to base.rows - 1 do
  begin
    LX := 0;
    isspace := not module_is_set(base.symbol, row, LX);
    if base.row_height[row] = 0 then
      BarHeight := BigLineHeight
    else
      BarHeight := 1;
    repeat
      block_width := 0;
      repeat
        Inc(block_width);
        if (LX + block_width >= base.width) then
          break;
      until not (module_is_set(base.symbol, row, LX + block_width) = module_is_set(base.symbol, row, LX));
      if not isspace then
        FVectorPrimitivesAdd(LX, LY, block_width, BarHeight);
      inc(LX, block_width);
      isspace := not isspace;
    until LX >= base.width;
    if(LY = 0) then
      FWidth := LX;
    inc(LY, BarHeight);
  end;
end;

procedure TfrxGS1DatabarES.SetColumns(Col: Integer);
begin
  FColumns := Col;
  Generate(Text, True);
end;

end.
