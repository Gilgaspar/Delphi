{*************************************************************************}
{ TRaveGreenBar Rave Component version 1.0                                }
{ Copyright (c), 1998-99, Nevrona Designs, all rights reserved            }
{*************************************************************************}

unit NDCsGBar;

interface

uses
  Messages, Windows, Controls, Classes, SysUtils, Graphics,
  RVDefine, RVUtil, RVClass, RPDefine, RPBase;

type
  TRaveGreenBar = class(TRaveControl)
  protected
    FColor1: TColor;
    FColor2: TColor;
    FCycleCount: Integer;
    CycleCounter: Integer;
    procedure SetForeColor(Value: TColor); override;
    function GetForeColor: TColor; override;
    procedure SetBackColor(Value: TColor); override;
    function GetBackColor: TColor; override;
    procedure BeforeReport; override;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF DESIGNER}
    procedure Paint(Canvas: TCanvas); override;
    {$ENDIF}
    procedure Print(Report: TBaseReport); override;
  published
    property CycleCount: Integer read FCycleCount write FCycleCount default 1;
    property Color1: TColor read GetForeColor write SetForeColor default $00BFFFBF;
    property Color2: TColor read GetBackColor write SetBackColor default $00E5E5E5;
    property Height;
    property Left;
    property Top;
    property Width;
  end; { TRaveGreenBar }

procedure RaveRegister;

implementation

{$IFDEF DESIGNER}
{$R *.RES}
{$ENDIF}

procedure RaveRegister;
begin { RaveRegister }
  RegisterRaveGroup('Graphics', 'Drawing Components');
  RegisterRaveComponents('Graphics', [TRaveGreenBar]);
  RegisterRaveProperties(TRaveGreenBar,
    {Beginner}     '',
    {Intermediate} '',
    {Developer}    '',
    {Hidden}       '');
end; { RaveRegister }

(*****************************************************************************}
( class TRaveGreenBar
(*****************************************************************************)

constructor TRaveGreenBar.Create(AOwner: TComponent);
begin { Create }
  inherited Create(AOwner);
  {$IFDEF DESIGNER}
  BoundsRect := RaveRect(0.0,0.0,4.0,0.2);
  {$ENDIF}
  FCycleCount := 1;
  FColor1 := $00BFFFBF; { 25% Lime };
  FColor2 := $00E5E5E5; { 10% Black };
end;  { Create }

{$IFDEF DESIGNER}
procedure TRaveGreenBar.Paint(Canvas: TCanvas);
begin { Paint }
  with Canvas do begin
    Pen.Width := 1;
    Pen.Color := Color1;
    Brush.Color := Color1;
    Brush.Style := bsSolid;
    Rectangle(XI2D(PageLeft), YI2D(PageTop), XI2D(PageRight) + 1,YI2D(PageBottom) + 1);
  end; { with }
end;   { Paint }
{$ENDIF}

procedure TRaveGreenBar.BeforeReport;
begin { BeforeReport }
  CycleCounter := 0;
end;  { BeforeReport }

procedure TRaveGreenBar.SetForeColor(Value: TColor);
begin { SetForeColor }
  FColor1 := Value;
  Invalidate;
end;  { SetForeColor }

function TRaveGreenBar.GetForeColor: TColor;
begin { GetForeColor }
  Result := FColor1;
end;  { GetForeColor }

procedure TRaveGreenBar.SetBackColor(Value: TColor);
begin { SetBackColor }
  FColor2 := Value;
  Invalidate;
end;  { SetBackColor }

function TRaveGreenBar.GetBackColor: TColor;
begin { GetBackColor }
  Result := FColor2;
end;  { GetBackColor }

procedure TRaveGreenBar.Print(Report: TBaseReport);
var
  Color: TColor;
begin { Print }
  with Report do begin
    if not Odd(CycleCounter div CycleCount) then begin
      Color := Color1;
    end else begin
      Color := Color2;
    end; { else }
    SetPen(Color, psSolid, 1,pmCopy);
    SetBrush(Color, bsSolid, nil);
    Rectangle(PageLeft, PageTop, PageRight, PageBottom);
    Inc(CycleCounter);
  end; { with }
end;   { Print }

initialization
  RegisterProc('RVCL', RaveRegister);
end.
