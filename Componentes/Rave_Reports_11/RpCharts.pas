{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RpCharts;

interface

uses
  SysUtils, Classes, Graphics, RpBase, RpDefine;

{

  Pie: Name:Value


  Bar: Name[:Name]:Value

    Name:Value - Simple bars
    Name:Name:Value - 2-D bar array
    Name:Value - Min/Max bars


  Point: Name:Value:Value

    Name:Value:Value - XY points


  Line: Name[:Name]:Value

    Name:Value - Single line
    Name:Name:Value - Group of lines


  Layer: Name[:Name]:Value

}

const
  ChartColors = 20;
  ChartColor: array[1..ChartColors] of TColor = (
   clBlue,
   clRed,
   clLime,
   clFuchsia,
   clAqua,
   clYellow,
   TColor($FF0080), { LightPurple }
   TColor($0080FF), { Orange }
   TColor($FF8000), { GreenBlue }
   TColor($C080FF), { BubbleGum }
   TColor($004080), { Brown }
   TColor($C08080), { Periwinkle }
   TColor($8000FF), { VioletRed }
   clMaroon,
   clGreen,
   clNavy,
   TColor($FF8080), { Lavender }
   clPurple,
   clTeal,
   clOlive);

type
  TRpChartsBase = class;

  TRpSeries = class;

  TPointData = class
  protected
    FValue: double;
    FColor: TColor;
  public
    constructor Create(AValue: double); overload;
    constructor Create(AValue: double; AColor: TColor); overload;
    procedure Add(AValue: double); overload;
    procedure Add(AValue: double; AColor: TColor); overload;
    function TotalPerc(AChart: TRpSeries): double;
    function RangePerc(ASeries: TRpSeries): double;
    //
    property Value: double read FValue write FValue;
    property Color: TColor read FColor write FColor;
  end; { TPointData }

  TValueFunc = (vfTotal,vfRange,vfAverage);

  TValueList = class(TStringList)
  protected
    FValue1: double;
    FValue2: double;
    FValueFunc: TValueFunc;
  public
    procedure AddValue(AName: string; AValue: double);
    //
    property Value1: double read FValue1 write FValue1;
    property Value2: double read FValue2 write FValue2;
    property ValueFunc: TValueFunc read FValueFunc write FValueFunc;
  end; { TValueList }

  TSeriesType = (csBar, csPie, csLine);

  TStyle = class
  protected
    FFont: TSaveFont;
  public
    constructor Create(ABaseReport: TBaseReport);
    destructor Destroy; override;
    property Font: TSaveFont read FFont write FFont;
  end; { TStyle }

  TRpChartsBase = class
  protected
    FDraw3D: boolean;
    FBaseReport: TBaseReport;
    FFillColor: TColor;
    FPenColor: TColor;
    FShade: integer;
    FSeriesList: TList;
    FScaleWidth: double;
    FFooterHeight: double;
    FFooterBackgroundColor: TColor;
    FLabelColor: TColor;
    FFooterStyle: TStyle;

    //
    procedure CalcAngles( X1,Y1,X2,Y2,A1,A2: double;
                         var X3,Y3,X4,Y4: double);
    procedure Rectangle(X1,Y1,X2,Y2: double);
    procedure Arc(X1,Y1,X2,Y2,A1,A2: double);
    procedure Pie(X1,Y1,X2,Y2,A1,A2: double);
    procedure MoveTo(X1,Y1: double);
    procedure LineTo(X1,Y1: double);
    procedure SetStyle(AStyle: TStyle);
    property SeriesList: TList read FSeriesList write FSeriesList;
  public
    constructor Create(ABaseReport: TBaseReport); virtual;
    destructor Destroy; override;
    procedure Print; virtual; abstract;
    //
    property BaseReport: TBaseReport read FBaseReport write FBaseReport;
    property Draw3D: boolean read FDraw3D write FDraw3D;
    property FillColor: TColor read FFillColor write FFillColor;
    property PenColor: TColor read FPenColor write FPenColor;
    property Shade: integer read FShade write FShade;
    property ScaleWidth: double read FScaleWidth write FScaleWidth;
    property FooterHeight: double read FFooterHeight write FFooterHeight;
    property FooterBackgroundColor: TColor read FFooterBackgroundColor write FFooterBackgroundColor;
    property LabelColor: TColor read FLabelColor write FLabelColor;
    property FooterStyle: TStyle read FFooterStyle write FFooterStyle;
  end; { TRpChartsBase }

  TRpCharts = class(TRPChartsBase)
  protected
    FBackgroundColor: TColor;
    FLabelBackgroundColor: TColor;
    FLeft: double;
    FTop: double;
    FWidth: double;
    FHeight: double;
    FUseDefaultColors: boolean;
    FTitle: string;
    FTitleHeight: double;
    FTitleStyle: TStyle;

  public
    constructor Create(ABaseReport: TBaseReport); override;
    destructor Destroy; override;
    procedure Print; override;
    procedure PrintScale; virtual;
    function Series(AIndex: integer = 0): TRpSeries;
    function AddSeries(SeriesType: TSeriesType): TRpSeries;
    procedure PrintTitle; virtual;

    property Left: double read FLeft write FLeft;
    property Top: double read FTop write FTop;
    property Width: double read FWidth write FWidth;
    property Height: double read FHeight write FHeight;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property LabelBackgroundColor: TColor read FLabelBackgroundColor write FLabelBackgroundColor;
    property UseDefaultColors: boolean read FUseDefaultColors write FUseDefaultColors;
    property Title: string read FTitle write FTitle;
    property TitleHeight: double read FTitleHeight write FTitleHeight;
    property TitleStyle: TStyle read FTitleStyle write FTitleStyle;
  end; { TRpCharts }

  TRpSeries = class(TRpChartsBase)
  protected
    FOwner: TRpCharts;
    FValueList: TStringList;
    FPoints: TStringList;
    FPointsTotal: double;
    FPointsMax: double;
    FPointsMin: double;
    FBarSpacing: double;

    procedure Clear;
    procedure PrintFooter; virtual;
    procedure SetMinMax(AValue: double);
  public
    constructor Create(ABaseReport: TBaseReport); override;
    destructor Destroy; override;
    function AddPoint(AName: string; AValue: double): TPointData; overload;
    function AddPoint(AName: string; AValue: double; AColor: TColor): TPointData; overload;

    property Owner: TRpCharts read FOwner write FOwner;
    property PointsTotal: double read FPointsTotal;
    property PointsMin: double read FPointsMin;
    property PointsMax: double read FPointsMax;
    property BarSpacing: double read FBarSpacing write FBarSpacing;
  end; { TRpSeries }

  TRpSeriesPie = class(TRpSeries)
  protected
    procedure PrintFooter; override;
  public
    procedure Print; override;
  end; { TRpChartsPie }

  TRpSeriesBar = class(TRpSeries)
  protected
    procedure PrintFooter; override;
  public
    procedure Print; override;
  end; { TRpChartsBar }

  TRpSeriesLine = class(TRpSeries)
  protected
    procedure PrintFooter; override;
  public
    procedure Print; override;
  end; { TRpChartsLine }

implementation

{ TPointData }

procedure TPointData.Add(AValue: double; AColor: TColor);
begin
  Add(AValue);
  FColor := AColor;
end;

procedure TPointData.Add(AValue: double);
begin
  FValue := FValue + AValue;
end;

constructor TPointData.Create(AValue: double);
begin
  inherited Create;
  FValue := AValue;
end;

constructor TPointData.Create(AValue: double; AColor: TColor);
begin
  Create(AValue);
  FColor := AColor;
end;

function TPointData.RangePerc(ASeries: TRpSeries): double;
var
  F1: double;
begin
  F1 := ASeries.PointsMax - ASeries.PointsMin;
  if F1 = 0 then begin
    Result := 1.0;
  end else begin
    Result := (Value - ASeries.PointsMin) / F1;
  end; { else }
end;

function TPointData.TotalPerc(AChart: TRpSeries): double;
begin
  Result := Value / AChart.PointsTotal;
end;

{ TValueList }

procedure TValueList.AddValue(AName: string; AValue: double);
begin
  case ValueFunc of
    vfTotal,vfAverage: begin
      Value1 := Value1 + AValue;
      Value2 := Value2 + 1.0;
    end;
    vfRange: begin
      if AValue < Value1 then begin
        Value1 := AValue;
      end; { if }
      if AValue > Value2 then begin
        Value2 := AValue;
      end; { if }
    end;
  end; { case }
end;

{ TRpChartsBase }

procedure TRpChartsBase.Arc(X1, Y1, X2, Y2, A1, A2: double);
var
  X3,Y3: double;
  X4,Y4: double;
begin
  BaseReport.SetBrush(FillColor,bsSolid,nil);
  BaseReport.SetPen(PenColor,psSolid,1,pmCopy);
  CalcAngles(X1,Y1,X2,Y2,A1,A2,X3,Y3,X4,Y4);
  BaseReport.Arc(X1,Y1,X2,Y2,X3,Y3,X4,Y4);
end;

procedure TRpChartsBase.CalcAngles(X1, Y1, X2, Y2, A1, A2: double; var X3,
  Y3, X4, Y4: double);
var
  XC,YC: double;
  XR,YR: double;
begin
  XR := Abs(X2 - X1) / 2.0;
  YR := Abs(Y2 - Y1) / 2.0;
  XC := Abs(X1 + X2) / 2.0;
  YC := Abs(Y1 + Y2) / 2.0;
  X3 := XC + XR * Cos(A1 * Pi / 180.0);
  Y3 := YC - YR * Sin(A1 * Pi / 180.0);
  X4 := XC + XR * Cos(A2 * Pi / 180.0);
  Y4 := YC - YR * Sin(A2 * Pi / 180.0);
end;

constructor TRpChartsBase.Create(ABaseReport: TBaseReport);
begin
  inherited Create;
  FFooterStyle := TStyle.Create(ABaseReport);
  FBaseReport := ABaseReport;
  FSeriesList := TList.Create;
  FillColor := clWhite;
  PenColor := clBlack;
  FShade := 100;
end;

destructor TRpChartsBase.Destroy;
begin
  FreeAndNil(FFooterStyle);
  FreeAndNil(FSeriesList);
  inherited;
end;

procedure TRpChartsBase.LineTo(X1, Y1: double);
begin
  FBaseReport.SetPen(PenColor,psSolid,1,pmCopy);
  FBaseReport.LineTo(X1,Y1);
end;

procedure TRpChartsBase.MoveTo(X1, Y1: double);
begin
  FBaseReport.SetPen(PenColor,psSolid,1,pmCopy);
  FBaseReport.MoveTo(X1,Y1);
end;

procedure TRpChartsBase.Pie(X1, Y1, X2, Y2, A1, A2: double);
var
  X3,Y3: double;
  X4,Y4: double;
  Diff: double;
  Recalc: boolean;
begin
  FBaseReport.SetBrush(FillColor,bsSolid,nil);
  FBaseReport.SetPen(PenColor,psSolid,1,pmCopy);
  if Draw3D then begin
    Diff := (Y2 - Y1) * 0.1;
    CalcAngles(X1,Y1,X2,Y2 - Diff,A1,A2,X3,Y3,X4,Y4);
    FBaseReport.Pie(X1,Y1,X2,Y2 - Diff,X3,Y3,X4,Y4);

    if (A1 < 360) and (A2 > 180) then begin
      Recalc := false;
      if A1 < 180 then begin
        A1 := 180;
        Recalc := true;
      end; { if }
      if A2 > 360 then begin
        A2 := 360;
        Recalc := true;
      end; { if }
      if Recalc then begin
        CalcAngles(X1,Y1,X2,Y2 - Diff,A1,A2,X3,Y3,X4,Y4);
      end; { if }
      FBaseReport.Arc(X1,Y1 + Diff,X2,Y2,X3,Y3 + Diff,X4,Y4 + Diff);
      FBaseReport.MoveTo(X3,Y3);
      FBaseReport.LineTo(X3,Y3 + Diff);
      FBaseReport.MoveTo(X4,Y4);
      FBaseReport.LineTo(X4,Y4 + Diff);
    end; { if }
  end else begin
    CalcAngles(X1,Y1,X2,Y2,A1,A2,X3,Y3,X4,Y4);
    FBaseReport.Pie(X1,Y1,X2,Y2,X3,Y3,X4,Y4);
  end; { if }
end;

procedure TRpChartsBase.Rectangle(X1, Y1, X2, Y2: double);
begin
  FBaseReport.SetBrush(FillColor,bsSolid,nil);
  FBaseReport.SetPen(PenColor,psSolid,1,pmCopy);
  FBaseReport.Rectangle(X1,Y1,X2,Y2);
end;

procedure TRpChartsBase.SetStyle(AStyle: TStyle);
begin
  with AStyle.Font do begin
    BaseReport.SetFont(Name, Size);
    BaseReport.FontColor := Color;
    BaseReport.FontPitch := Pitch;
    BaseReport.FontCharset := Charset;
    BaseReport.Bold := Bold;
    BaseReport.Underline := Underline;
    BaseReport.Italic := Italic;
    BaseReport.Strikeout := Strikeout;
    BaseReport.Subscript := Subscript;
    BaseReport.Superscript := Superscript;
    BaseReport.FontRotation := Rotation;
    BaseReport.FontAlign := Align;

  end; { with }
end;

{ TRpCharts }

function TRpCharts.AddSeries(SeriesType: TSeriesType): TRpSeries;
begin
  case SeriesType of
    csLine: Result := TRpSeriesLine.Create(BaseReport);
    csPie: Result := TRpSeriesPie.Create(BaseReport);
    else begin
    Result := TRpSeriesBar.Create(BaseReport);
    end;
  end;
  Result.Owner := self;
  FSeriesList.Add(Result);
end;

constructor TRpCharts.Create(ABaseReport: TBaseReport);
begin
  inherited;
  FTitleHeight := 0.2;
  FTitleStyle := TStyle.Create(ABaseReport);
end;

destructor TRpCharts.Destroy;
begin
  FreeAndNil(FTitleStyle);
  inherited;
end;

procedure TRpCharts.Print;
var
  i1: integer;
begin
  inherited;
  FillColor := BackgroundColor;
  PenColor := clYellow;
  PenColor := BackgroundColor;
  Rectangle(Left, Top, Left + Width, Top + Height);
  PrintScale;
  for i1 := 0 to FSeriesList.Count - 1 do begin
    Series(i1).Print;
  end;
  PrintTitle;
end;

procedure TRpCharts.PrintScale;
var
  X1,Y1,X2,Y2: double;
begin
  inherited;

  X1 := Left + 0.01;
  Y1 := Top + 0.01;
  X2 := Left + ScaleWidth;
  Y2 := Top + Height - 0.01;

  FillColor := FooterBackgroundColor;
  PenColor := FooterBackgroundColor;
  Rectangle(X1, Y1, X2, Y2);
end;

procedure TRpCharts.PrintTitle;
begin
  with BaseReport do begin
    YPos := Top + TitleHeight - ((TitleHeight - FontHeight) / 2);
    PushFont;
    SetStyle(TitleStyle);
    PrintCenter(Title, Left + ScaleWidth + ((Width - ScaleWidth) / 2));
    PopFont;
  end; { with }
end;

function TRpCharts.Series(AIndex: integer): TRpSeries;
begin
  Result := FSeriesList[AIndex];
end;

{ TRpSeries }

function TRpSeries.AddPoint(AName: string; AValue: double; AColor: TColor): TPointData;
var
  I1: integer;
begin
  FPointsTotal := FPointsTotal + AValue;
  for I1 := 0 to FPoints.Count - 1 do begin
    if SameText(FPoints[I1],AName) then begin
    // Add to existing point
      Result := TPointData(FPoints.Objects[I1]);
      Result.Add(AValue, AColor);
      SetMinMax(Result.Value);
      Exit;
    end; { if }
  end; { for }

// Add to new point
  Result := TPointData.Create(AValue, AColor);
  FPoints.AddObject(AName,Result);
  SetMinMax(AValue);
end;

function TRpSeries.AddPoint(AName: string; AValue: double): TPointData;
var
  I1: integer;
begin
  FPointsTotal := FPointsTotal + AValue;
  for I1 := 0 to FPoints.Count - 1 do begin
    if SameText(FPoints[I1],AName) then begin
    // Add to existing point
      Result := TPointData(FPoints.Objects[I1]);
      Result.Add(AValue);
      SetMinMax(Result.Value);
      Exit;
    end; { if }
  end; { for }

// Add to new point
  Result := TPointData.Create(AValue);
  FPoints.AddObject(AName,Result);
  SetMinMax(AValue);
end;

procedure TRpSeries.Clear;
var
  I1: integer;
begin
  FPointsTotal := 0;
  FPointsMax := 5.0E-324;
  FPointsMin := 1.7E308;
  for I1 := 0 to FPoints.Count - 1 do begin
    FPoints.Objects[I1].Free;
    FPoints.Objects[I1] := nil;
  end; { for }
  FPoints.Clear;
end;

constructor TRpSeries.Create(ABaseReport: TBaseReport);
begin
  inherited;
  FPoints := TStringList.Create;
  FValueList := TStringList.Create;
end;

destructor TRpSeries.Destroy;
begin
  Clear;
  FreeAndNil(FPoints);
  FreeAndNil(FValueList);
  inherited;
end;

procedure TRpSeries.PrintFooter;
var
  X1,Y1,X2,Y2: double;
begin
  with Owner do begin
    X1 := Left + ScaleWidth;
    Y1 := Top + Height - FooterHeight;
    X2 := Left + Width - 0.01;
    Y2 := Top + Height - 0.01;

    FillColor := FooterBackgroundColor;
    PenColor := FooterBackgroundColor;
    Rectangle(X1, Y1, X2, Y2);
  end; // with
end;

procedure TRpSeries.SetMinMax(AValue: double);
begin
  if AValue > FPointsMax then begin
    FPointsMax := AValue;
  end; { if }
  if AValue < FPointsMin then begin
    FPointsMin := AValue;
  end; { if }
end;

{ TRpSeriesPie }

procedure TRpSeriesPie.Print;
var
  X1,Y1,X2,Y2: double;
  I1: integer;
  Perc1, Perc2: double;
  W1, H1: double;
begin
  inherited;
  PrintFooter;
  with Owner do begin
    W1 := Width - ScaleWidth;
    H1 := Height - FooterHeight - TitleHeight;
    if W1 > H1 then begin
      X1 := Left + ScaleWidth + ((W1 - H1) / 2);
      Y1 := Top + TitleHeight;
      X2 := X1 + H1;
      Y2 := Y1 + H1;
    end else begin
      X1 := Left + ScaleWidth;
      Y1 := (Top + TitleHeight) + ((H1 - W1) / 2);
      X2 := X1 + W1;
      Y2 := Y1 + W1;
    end;

    Perc2 := 0;
    for I1 := 0 to FPoints.Count - 1 do begin
      Perc1 := Perc2;
      Perc2 := Perc1 + TPointData(FPoints.Objects[I1]).TotalPerc(self) * 360;
      if UseDefaultColors then begin
        FillColor := ShadeToColor(ChartColor[I1 + 1],Shade);
      end else begin
        FillColor := ShadeToColor(TPointData(FPoints.Objects[I1]).Color,Shade);
      end;
      Pie(X1,Y1,X2,Y2,Perc1,Perc2);
    end; { for }
  end;
end;

procedure TRpSeriesPie.PrintFooter;
begin
  inherited;
end;

{ TRpSeriesBar }

procedure TRpSeriesBar.Print;
var
  X1,Y1,X2,Y2: double;
  XD: double;
  I1: integer;
begin
  inherited;

  PrintFooter;

  with Owner do begin
    X1 := Left + ScaleWidth;
    Y1 := Top + TitleHeight;
    X2 := Left + Width - BarSpacing;
    Y2 := Top + Height - FooterHeight;
    XD := (X2 - X1) / FPoints.Count;
    for I1 := 0 to FPoints.Count - 1 do begin
      if UseDefaultColors then begin
        FillColor := ChartColor[I1 + 1];
      end else begin
        FillColor := TPointData(FPoints.Objects[I1]).Color;
      end;
      Rectangle(X1 + (I1 * XD) + BarSpacing,
                Y2 - TPointData(FPoints.Objects[I1]).RangePerc(self) * (Y2 - Y1),
                X1 + ((I1 + 1) * XD),
                Y2);
    end; { for }
  end; // with
end;

procedure TRpSeriesBar.PrintFooter;
var
  X1,Y1,X2,Y2: double;
  XD: double;
  I1: integer;
  SaveYPos: double;
begin
  inherited;
  BaseReport.PushFont;
  with Owner do begin
    X1 := Left + ScaleWidth;
    Y1 := Top + Height - FooterHeight;
    X2 := Left + Width - 0.01;
    Y2 := Top + Height - 0.01;
    XD := (X2 - X1) / FPoints.Count;

    FillColor := FooterBackgroundColor;
    PenColor := FooterBackgroundColor;
    Rectangle(X1, Y1, X2, Y2);

    SaveYPos := FBaseReport.YPos;
    FBaseReport.YPos := Y1 + ((Y2 - Y1) / 2) + (FBaseReport.FontHeight / 2);
    SetStyle(FooterStyle);
    for I1 := 0 to FPoints.Count - 1 do begin
      FillColor := ChartColor[I1 + 1];
      FBaseReport.FontColor := LabelColor;
      FBaseReport.PrintCenter(FPoints[I1], X1 + (I1 * XD) + (XD / 2));
    end; { for }
    FBaseReport.YPos := SaveYPos;
  end; // with
  BaseReport.PopFont;
end;

{ TRpSeriesLine }

procedure TRpSeriesLine.Print;
var
  X1,Y1,X2,Y2: double;
  XD: double;
  YD: double;
  I1: integer;
begin
  inherited;

  PrintFooter;
  with Owner do begin
    X1 := Left + ScaleWidth;
    Y1 := Top + TitleHeight;
    X2 := Left + Width;
    Y2 := Top + Height - FooterHeight;
    XD := (X2 - X1) / (FPoints.Count);
    X1 := X1 + XD / 2;

    for I1 := 0 to FPoints.Count - 1 do begin
      YD := Y2 - TPointData(FPoints.Objects[I1]).RangePerc(self) * (Y2 - Y1);
      if I1 = 0 then begin
        MoveTo(X1,YD);
      end else begin
        LineTo(X1 + I1 * XD,YD);
      end; { else }
    end; { for }
  end; // with
end;

procedure TRpSeriesLine.PrintFooter;
begin
  if (Owner.SeriesList.Count) <= 1 then begin
    inherited;
  end;
end;

{ TStyle }

constructor TStyle.Create(ABaseReport: TBaseReport);
begin
  FFont := TSaveFont.Create;
  FFont.Assign(ABaseReport.GetBaseFont);
end;

destructor TStyle.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

end.
