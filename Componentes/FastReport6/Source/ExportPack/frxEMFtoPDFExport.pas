
{******************************************}
{                                          }
{             FastReport v6.0              }
{            EMF to PDF Export             }
{                                          }
{        Copyright (c) 2015 - 2019         }
{             by Oleg Adibekov             }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxEMFtoPDFExport;

interface

{$I frx.inc}

uses Windows, Graphics, Classes, frxExportHelpers, frxEMFAbstractExport,
  frxEMFFormat, frxExportPDFHelpers, frxClass, frxAnaliticGeometry, frxUtils;

type
  TBezierResult = record
    P0, P1, P2, P3: TfrxPoint;
  end;

  TPDFDeviceContext = class (TDeviceContext);

  TPDFPath = class
  private
    FOutStream: TStream;
    FExists: Boolean;
  protected
    FStream: TMemoryStream;
  public
    constructor Create(AOutStream: TStream);
    destructor Destroy; override;

    procedure Put(const S: AnsiString);
    procedure Flush;

    property Exists: Boolean read FExists write FExists;
  end;

  TEMFtoPDFExport = class (TEMFAbstractExport)
  private
    FForceMitterLineJoin: Boolean;
    FForceButtLineCap: Boolean;
    FJPGQuality: integer;
    FForceNullBrush: Boolean;
    FTransparency: Boolean;
    FForceAnsi: Boolean;
    FClipped: Boolean;

    procedure Put(const S: AnsiString);
    procedure PutLn(const S: AnsiString); {$IFDEF Delphi12} overload;
    procedure PutLn(const S: String); overload; {$ENDIF}

    function pdfSize(emfSize: Extended): Extended;

    function pdfFrxPoint(emfP: TPoint; IsScalingOnly: Boolean = False): TfrxPoint; overload;
    function pdfFrxPoint(emfSP: TSmallPoint; IsScalingOnly: Boolean = False): TfrxPoint; overload;
    function pdfFrxPoint(emfDP: TfrxPoint; IsScalingOnly: Boolean = False): TfrxPoint; overload;

    function pdfFrxRect(emfR: TRect; IsScalingOnly: Boolean = False): TfrxRect;

//    function emfSize2Str(emfSize: Extended): String;

    function emfPoint2Str(emfP: TPoint; IsScalingOnly: Boolean = False): String; overload;
    function emfPoint2Str(emfSP: TSmallPoint; IsScalingOnly: Boolean = False): String; overload;
    function emfPoint2Str(emfFP: TfrxPoint; IsScalingOnly: Boolean = False): String; overload;

    function emfRect2Str(emfR: TRect; IsScalingOnly: Boolean = False): String;

    function EvenOdd: String;
    function IsNullBrush: Boolean;
    function IsNullPen: Boolean;

    function BezierCurve(Center, Radius: TfrxPoint; startAngle, arcAngle: Double): TBezierResult;
    procedure cmd_AngleArc(Center, Radius: TfrxPoint; StartAngle, SweepAngle: Single);
    procedure cmd_RoundRect(l, t, r, b, rx, ry: Extended);
    procedure cmdPathPainting(Options: integer);
    procedure cmdPathParams(Options: integer);
    procedure cmdSetClippingPath;
    procedure cmdCloseSubpath;
    procedure cmdAppendAngleArcToPath(AngleArc: TEMRAngleArc);
    procedure cmdAppendPieToPath(Pie: TEMRPie);
    procedure cmdAppendEllipsToPath(emfRect: TRect);
    procedure cmdAppendRectangleToPath(emfRect: TRect; IsScalingOnly: Boolean = False);
    procedure cmdAppendEMFRectangleToPath(emfRect: TRect);
    procedure cmdAppendRoundRectToPath(emfRect: TRect; emfCorners: TSize);

    procedure cmdMoveTo(X, Y: extended); overload;
    procedure cmdMoveTo(emfP: TPoint); overload;
    procedure cmdMoveTo(emfSP: TSmallPoint); overload;
    procedure cmdMoveTo(emfFP: TfrxPoint); overload;

    procedure cmdLineTo(X, Y: extended); overload;
    procedure cmdLineTo(emfP: TPoint); overload;
    procedure cmdLineTo(emfSP: TSmallPoint); overload;
    procedure cmdLineTo(emfDP: TfrxPoint); overload;
    procedure cmdSetLineDashPattern(PenStyle: LongWord; Width: Extended);
    procedure cmdSetStrokeColor(Color: TColor);
    procedure cmdSetFillColor(Color: TColor);
    procedure cmdSetLineWidth(Width: Extended); overload;
    procedure cmdSetLineWidth(PDFWidth: String); overload;
    procedure cmdSetMiterLimit(MiterLimit: Extended);
    procedure cmdSetLineCap(PenEndCap: Integer);
    procedure cmdSetLineJoin(PenLineJoin: Integer);
    procedure cmdAppendCurvedSegment2final(emfSP1, emfSP3: TSmallPoint); overload;
    procedure cmdAppendCurvedSegment2final(emfP1, emfP3: TPoint); overload;
    procedure cmdAppendCurvedSegment3(emfSP1, emfSP2, emfSP3: TSmallPoint); overload;
    procedure cmdAppendCurvedSegment3(emfP1, emfP2, emfP3: TPoint); overload;
    procedure cmdAppendCurvedSegment3(emfDP1, emfDP2, emfDP3: TfrxPoint); overload;
    procedure cmdPolyBezier(Options: integer = 0);
    procedure cmdPolyBezier16(Options: integer = 0);
    procedure cmdPolyLine(Options: integer = 0);
    procedure cmdPolyLine16(Options: integer = 0);
    procedure cmdPolyPolyLine(Options: integer = 0);
    procedure cmdPolyPolyLine16(Options: integer = 0);

    procedure cmdCreateExtSelectClipRgn;

    procedure cmdSaveGraphicsState;
    procedure cmdRestoreGraphicsState;

    procedure cmdBitmap(emfRect: TRect; dwRop: LongWord; EMRBitmap: TEMRBitmap);

    procedure cmdTranslationAndScaling(Sx, Sy, Tx, Ty: Extended);
//    procedure cmdXForm(XF: TXForm);

//    procedure CrossAtPos(pdfPoint: TfrxPoint; Color: TColor; Len: Integer; LineWidth: Integer); // Debug
  protected
    FPDFRect: TfrxRect;
    FEMFtoPDFFactor: TfrxPoint;
    FPOH: TPDFObjectsHelper;
    FRotation2D: TRotation2D;
    FRealizationList: TStringList;
    FqQBalance: Integer;
    FPath: TPDFPath;
    FExtSelectClipRgnCreated: Boolean;

    procedure Comment(CommentString: String = ''); override;
    procedure CommentAboutRealization;
    procedure CommentTextRect(rtl: TRect; Color: TColor = clRed);
    procedure RealizationListFill(RealizedCommands: array of String);
    procedure DCCreate; override;
    function FontCreate: TEMFFont; override;
    function PDFDeviceContext: TPDFDeviceContext;

    procedure DrawFontLines(FontSize: Double; TextPosition: TfrxPoint; TextWidth: Extended);
    procedure DrawFigureStart;
    procedure DrawFigureFinish(Options: integer);
    procedure RestoreExtSelectClipRgn;
    function FillStrokeOptions(Options: integer): integer;

    procedure DoEMR_AngleArc; override;
    procedure DoEMR_AlphaBlend; override;
    procedure DoEMR_BitBlt; override;
    procedure DoEMR_CloseFigure; override;
    procedure DoEMR_Ellipse; override;
    procedure DoEMR_EoF; override;
    procedure DoEMR_ExtSelectClipRgn; override;
    procedure DoEMR_ExtTextOutW; override;
    procedure DoEMR_FillPath; override;
    procedure DoEMR_FillRgn; override;
    procedure DoEMR_Header; override;
    procedure DoEMR_IntersectClipRect; override;
    procedure DoEMR_LineTo; override;
    procedure DoEMR_MaskBlt; override;
    procedure DoEMR_MoveToEx; override;
    procedure DoEMR_Pie; override;
    procedure DoEMR_PolyBezier; override;
    procedure DoEMR_PolyBezier16; override;
    procedure DoEMR_PolyBezierTo; override;
    procedure DoEMR_PolyBezierTo16; override;
    procedure DoEMR_PolyDraw; override;
    procedure DoEMR_PolyDraw16; override;
    procedure DoEMR_Polygon; override;
    procedure DoEMR_Polygon16; override;
    procedure DoEMR_Polyline; override;
    procedure DoEMR_Polyline16; override;
    procedure DoEMR_PolylineTo; override;
    procedure DoEMR_PolylineTo16; override;
    procedure DoEMR_PolyPolygon; override;
    procedure DoEMR_PolyPolygon16; override;
    procedure DoEMR_PolyPolyline; override;
    procedure DoEMR_PolyPolyline16; override;
    procedure DoEMR_Rectangle; override;
    procedure DoEMR_RestoreDC; override;
    procedure DoEMR_RoundRect; override;
    procedure DoEMR_SaveDC; override;
    procedure DoEMR_SelectClipPath; override;
    procedure DoEMR_StretchBlt; override;
    procedure DoEMR_StretchDIBits; override;
    procedure DoEMR_StrokeAndFillPath; override;
    procedure DoEMR_StrokePath; override;
    procedure DoEMR_TransparentBlt; override;

    procedure DoStart; override;
    procedure DoFinish; override;
  public
    constructor Create(InStream, OutStream: TStream; APDFRect: TfrxRect; APOH: TPDFObjectsHelper);
    destructor Destroy; override;

    property ForceMitterLineJoin: Boolean read FForceMitterLineJoin write FForceMitterLineJoin;
    property ForceButtLineCap: Boolean write FForceButtLineCap;
    property JPGQuality: integer write FJPGQuality;
    property ForceNullBrush: Boolean write FForceNullBrush;
    property Transparency: Boolean write FTransparency;
    property ForceAnsi: Boolean write FForceAnsi;
    property Clipped: Boolean write FClipped;
  end;

implementation

uses
  {$IFDEF Delphi12}pngimage{$ELSE}frxpngimage{$ENDIF},
  Contnrs, SysUtils, Types, Math, JPEG
{$IFDEF DELPHI16}
  , UITypes
{$ENDIF} {It is necessary to prevent H2443}
  ;

type
  TEMFPDFSizeConverter = class
  private
    FDev: Double; // EMR_ExtTextOutW.rclBounds
    FLog: Double; // EMR_ExtTextOutW.emrtext.ptlReference // WordTransform etc...
    FPDF: Double;
    FChar: Double;
    procedure SetDev(const Value: Double);
    procedure SetLog(const Value: Double);
    procedure SetPDF(const Value: Double);
    procedure SetChar(const Value: Double);
  protected
    FExport: TEMFtoPDFExport;
    FEMFPDFFactor: Double;
    FFont: TEMFFont;
  public
    constructor Create(AExport: TEMFtoPDFExport);
    destructor Destroy; override;

    property Dev: Double read FDev write SetDev;
    property Log: Double read FLog write SetLog;
    property PDF: Double read FPDF write SetPDF;
    property Char: Double read FChar write SetChar;
  end;

const
  // Path-Painting Operators
  ppEnd      =  $0;
  ppClose    =  $1;
  ppStroke   =  $2;
  ppFill     =  $4;
  ppWithTo   =  $8; // To resets the current position
  ppBkFill   = $10; // Ignored when ppFill not setted
  ppAsIsFill = $20; // Ignored when ppFill not setted

{ Utility routines }

function PenStyle2Str(PenStyle: LongWord; Width: Extended): String;
var
  Dash, Dot: string;
begin
  Dash := Float2Str(6 * Width) + ' ';
  Dot := Float2Str(2 * Width) + ' ';
  case PenStyle of
    PS_SOLID:
      Result := '';
    PS_DASH:
      Result := Dash;
    PS_DOT:
      Result := Dot + Dash;
    PS_DASHDOT:
      Result := Dash + Dash + Dot + Dash;
    PS_DASHDOTDOT:
      Result := Dash + Dash + Dot + Dash + Dot + Dash;
    PS_NULL:
      Result := '';
    PS_INSIDEFRAME:
      Result := '';
    PS_ALTERNATE:
      Result := Dot + Dot;
  else // PS_USERSTYLE:
    Result := Dash + Dot;
  end;
  if Result <> '' then
    Delete(Result, Length(Result), 1);
end;

{ TEMFtoPDFExport }

function TEMFtoPDFExport.BezierCurve(Center, Radius: TfrxPoint; StartAngle, ArcAngle: Double): TBezierResult;
  function Rad(Degree: Double): Extended;
  begin
    Result := Degree * Pi / 180;
  end;
var
  Cos1, Sin1, Cos2, Sin2, Aux, Alpha: Extended;
begin
  SinCos(Rad(StartAngle), Sin1, Cos1);
  SinCos(Rad(StartAngle + ArcAngle), Sin2, Cos2);

  //point p1. Start point
  Result.P0 := frxPoint(Center.X + Radius.X * Cos1, Center.Y - Radius.Y * Sin1);
  //point p2. End point
  Result.P3 := frxPoint(Center.X + Radius.X * Cos2, Center.Y - Radius.Y * Sin2);

  //Alpha constant
  Aux := Tan(Rad(ArcAngle / 2));
  Alpha := Sin(Rad(ArcAngle)) * (Sqrt(4 + 3 * Aux * Aux) - 1.0) / 3.0;

  //point q1. First control point
  Result.P1 := frxPoint(Result.P0.X - Alpha * Radius.X * Sin1,
                        Result.P0.Y - Alpha * Radius.Y * Cos1);
  //point q2. Second control point.
  Result.P2 := frxPoint(Result.P3.X + Alpha * Radius.X * Sin2,
                        Result.P3.Y + Alpha * Radius.Y * Cos2);
end;

procedure TEMFtoPDFExport.cmdAppendAngleArcToPath(AngleArc: TEMRAngleArc);
begin
  with AngleArc do
    cmd_AngleArc(ToFrxPoint(ptlCenter), frxPoint(nRadius, nRadius), eStartAngle, eSweepAngle);
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment2final(emfSP1, emfSP3: TSmallPoint);
begin
  PutLn(emfPoint2Str(emfSP1) + ' ' + emfPoint2Str(emfSP3) + ' v');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment2final(emfP1, emfP3: TPoint);
begin
  PutLn(emfPoint2Str(emfP1) + ' ' + emfPoint2Str(emfP3) + ' v');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment3(emfDP1, emfDP2, emfDP3: TfrxPoint);
begin
  PutLn(emfPoint2Str(emfDP1) + ' ' + emfPoint2Str(emfDP2) + ' ' + emfPoint2Str(emfDP3) + ' c');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment3(emfP1, emfP2, emfP3: TPoint);
begin
  PutLn(emfPoint2Str(emfP1) + ' ' + emfPoint2Str(emfP2) + ' ' + emfPoint2Str(emfP3) + ' c');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment3(emfSP1, emfSP2, emfSP3: TSmallPoint);
begin
  PutLn(emfPoint2Str(emfSP1) + ' ' + emfPoint2Str(emfSP2) + ' ' + emfPoint2Str(emfSP3) + ' c');
end;

procedure TEMFtoPDFExport.cmdAppendEllipsToPath(emfRect: TRect);
begin
  with pdfFrxRect(emfRect) do
    cmd_RoundRect(Left, Top, Right, Bottom, (Right - Left) / 2, (Top - Bottom) / 2);
end;

procedure TEMFtoPDFExport.cmdAppendEMFRectangleToPath(emfRect: TRect);
begin
  EnableTransform := False;
  cmdAppendRectangleToPath(emfRect);
  EnableTransform := True;
end;

procedure TEMFtoPDFExport.cmdAppendPieToPath(Pie: TEMRPie);
var
  Center, Radius: TfrxPoint;
  StartAngle, EndAngle, SweepAngle: Extended;
begin
  with Pie do
  begin
    with rclBox do
    begin
      Center := frxPoint((Right + Left) / 2, (Bottom + Top) / 2);
      Radius := frxPoint((Right - Left) / 2, (Bottom - Top) / 2);
    end;

    StartAngle := ArcTan2(ptlStart.Y - Center.Y, ptlStart.X - Center.X) / Pi * 180;
    EndAngle := ArcTan2(ptlEnd.Y - Center.Y, ptlEnd.X - Center.X) / Pi * 180;
    SweepAngle := StartAngle - EndAngle;
    SweepAngle := IfReal(SweepAngle < 0, SweepAngle + 360, SweepAngle);

    cmd_AngleArc(Center, Radius, -StartAngle, SweepAngle);

    cmdLineTo(Center);
  end;
end;

procedure TEMFtoPDFExport.cmdAppendRectangleToPath(emfRect: TRect; IsScalingOnly: Boolean = False);
begin
  FPath.Exists := True;
  PutLn(emfRect2Str(emfRect, IsScalingOnly) + ' re'); // Begin new subpath
end;

procedure TEMFtoPDFExport.cmdAppendRoundRectToPath(emfRect: TRect; emfCorners: TSize);
begin
  with pdfFrxRect(emfRect), emfCorners do
    cmd_RoundRect(Left, Top, Right, Bottom, pdfSize(cx) / 2, pdfSize(cy) / 2);
end;

procedure TEMFtoPDFExport.cmdBitmap(emfRect: TRect; dwRop: LongWord; EMRBitmap: TEMRBitmap);
var
  pdfRect: TfrxRect;
  TempBitmap: TBitMap;
  Jpg: TJPEGImage;
  XObjectStream: TMemoryStream;
  XObjectHash: TfrxPDFXObjectHash;
  PicIndex: Integer;
  PNGA: TPNGObject;
  Size: TSize;

  procedure ReferenceToXObject;
  begin
    FPOH.AddUsedObject(PicIndex);

    cmdSaveGraphicsState;
    cmdTranslationAndScaling(pdfRect.Right - pdfRect.Left,
      pdfRect.Top - pdfRect.Bottom, pdfRect.Left, pdfRect.Bottom);
    Putln('/Im' + IntToStr(PicIndex) + ' Do');
    cmdRestoreGraphicsState;
  end;

  procedure OutOpaque;
  begin
    TempBitmap := EMRBitmap.GetBitmap;
    try
      Jpg := TJPEGImage.Create;
      try
        Jpg.PixelFormat := jf24bit;
        Jpg.CompressionQuality := FJPGQuality;
        Jpg.Assign(TempBitmap);
        XObjectStream := TMemoryStream.Create;
        try
          Jpg.SaveToStream(XObjectStream);

          XObjectStream.Position := 0;
          GetStreamHash(XObjectHash, XObjectStream);
          PicIndex := FPOH.FindXObject(XObjectHash);

          if PicIndex = -1 then
            PicIndex := FPOH.OutXObjectImage(XObjectHash, Jpg, XObjectStream);

        finally
          XObjectStream.Free;
        end;
      finally
        Jpg.Free;
      end;
    finally
      TempBitmap.Free;
    end;
    ReferenceToXObject;
  end;

begin
  pdfRect := pdfFrxRect(emfRect);
  case dwRop of // https://msdn.microsoft.com/en-us/library/cc250408.aspx
    PATCOPY {P}:
      begin
        DrawFigureStart;

        cmdAppendRectangleToPath(emfRect);

        DrawFigureFinish(ppFill);
      end;
    $1FF0000: // 32 bit here
      if FTransparency then
      begin
        PNGA := TEMRAlphaBlendObj(EMRBitmap).GetPngObject;
        try
          Size.cx := Round(pdfRect.Right - pdfRect.Left);
          Size.cy := Round(pdfRect.Top - pdfRect.Bottom);
          PicIndex := FPOH.OutTransparentPNG(PNGA, Size);
        finally
          PNGA.Free;
        end;
        ReferenceToXObject;
      end
      else
        OutOpaque;
    SRCCOPY {S}, SRCPAINT {DSo}, SRCAND {DSa}, SRCINVERT {DSx}:
      OutOpaque;
    $AA0029: {D}
      begin
        // Do nothing
      end;
  else
    Comment(' Unsupported dwRop: ' + IntToStr(dwRop));
  end;
end;

procedure TEMFtoPDFExport.cmdCloseSubpath;
begin
  PutLn('h');
end;

procedure TEMFtoPDFExport.cmdCreateExtSelectClipRgn;
var
  PRegionData: PRgnData;
  Size, i: Integer;
  R: TRect;
begin
  if FDC.ClipRgn <> HRGN(nil) then
  begin
    Size := GetRegionData(FDC.ClipRgn, 0, nil);
    if Size > 0 then
    begin
      GetMem(PRegionData, Size);
      try
        GetRegionData(FDC.ClipRgn, Size, PRegionData);
        for i := 0 to PRegionData^.rdh.nCount - 1 do
        begin
          Move(PRegionData^.Buffer[i * SizeOf(TRect)], R, SizeOf(TRect));
          cmdAppendEMFRectangleToPath(R);
        end;
        cmdSetClippingPath;
        cmdPathPainting(ppEnd);
      finally
        FreeMem(PRegionData, Size);
      end;
    end;
  end;
end;

procedure TEMFtoPDFExport.cmdLineTo(emfDP: TfrxPoint);
begin
  PutLn(emfPoint2Str(emfDP) + ' l'); // Append straight line segment to path
end;

procedure TEMFtoPDFExport.cmdLineTo(emfP: TPoint);
begin
  PutLn(emfPoint2Str(emfP) + ' l'); // Append straight line segment to path
end;

procedure TEMFtoPDFExport.cmdLineTo(emfSP: TSmallPoint);
begin
  PutLn(emfPoint2Str(emfSP) + ' l'); // Append straight line segment to path
end;

procedure TEMFtoPDFExport.cmdLineTo(X, Y: extended);
begin
  PutLn(frxPoint2Str(X, Y) + ' l'); // Append straight line segment to path
end;

procedure TEMFtoPDFExport.cmdMoveTo(emfFP: TfrxPoint);
begin
  FPath.Exists := True;
  PutLn(emfPoint2Str(emfFP) + ' m'); // Begin new subpath
end;

procedure TEMFtoPDFExport.cmdMoveTo(emfP: TPoint);
begin
  FPath.Exists := True;
  PutLn(emfPoint2Str(emfP) + ' m'); // Begin new subpath
end;

procedure TEMFtoPDFExport.cmdMoveTo(emfSP: TSmallPoint);
begin
  FPath.Exists := True;
  PutLn(emfPoint2Str(emfSP) + ' m'); // Begin new subpath
end;

procedure TEMFtoPDFExport.cmdMoveTo(X, Y: extended);
begin
  FPath.Exists := True;
  PutLn(frxPoint2Str(X, Y) + ' m'); // Begin new subpath
end;

procedure TEMFtoPDFExport.cmdPathPainting(Options: integer);
begin
  FPath.Exists := False;

  cmdPathParams(Options);

  FPath.Flush;

  case Options and (ppEnd or ppClose or ppStroke or ppFill) of
    ppEnd:              PutLn('n');
    ppStroke:           PutLn('S');
    ppStroke + ppClose: PutLn('s');
    ppFill, ppFill + ppClose:    PutLn('f' + EvenOdd);
    ppFill + ppStroke:           PutLn('B' + EvenOdd);
    ppFill + ppStroke + ppClose: PutLn('b' + EvenOdd);
  else
    raise Exception.Create('Invalid Patch Painting');
  end;
end;

procedure TEMFtoPDFExport.cmdPathParams(Options: integer);
begin
  if IsInclude(Options, ppFill) then
    if          IsInclude(Options, ppBkFill) then
      cmdSetFillColor(FDC.BkColor)
    else if not IsInclude(Options, ppAsIsFill) then
      cmdSetFillColor(FDC.BrushColor);

  if IsInclude(Options, ppStroke) then
  begin
    cmdSetLineDashPattern(FDC.PenStyle, pdfSize(FDC.PenWidth));
    cmdSetStrokeColor(FDC.PenColor);
    cmdSetLineWidth(pdfSize(FDC.PenWidth));
    cmdSetMiterLimit(FDC.MiterLimit);
    cmdSetLineCap(FDC.PenEndCap);
    cmdSetLineJoin(FDC.PenLineJoin);
  end;
end;

procedure TEMFtoPDFExport.cmdPolyBezier(Options: integer);
var
  Point: integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      Point := 0
    else
      begin
        cmdMoveTo(Polyline.aptl[0]);
        Point := 1;
      end;
    while True do
      case Integer(Polyline.cptl) - Point of
        0, 1:
          Break;
        2, 4:
          begin
            cmdAppendCurvedSegment2final(Polyline.aptl[Point],
              Polyline.aptl[Point + 1]);
            Inc(Point, 2);
          end;
      else
        cmdAppendCurvedSegment3(Polyline.aptl[Point],
          Polyline.aptl[Point + 1], Polyline.aptl[Point + 2]);
        Inc(Point, 3);
      end;
  end;
end;

procedure TEMFtoPDFExport.cmdPolyBezier16(Options: integer = 0);
var
  Point: integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      Point := 0
    else
      begin
        cmdMoveTo(Polyline16.apts[0]);
        Point := 1;
      end;
    while True do
      case Integer(Polyline16.cpts) - Point of
        0, 1:
          Break;
        2, 4:
          begin
            cmdAppendCurvedSegment2final(Polyline16.apts[Point],
              Polyline16.apts[Point + 1]);
            Inc(Point, 2);
          end;
      else
        cmdAppendCurvedSegment3(Polyline16.apts[Point],
          Polyline16.apts[Point + 1], Polyline16.apts[Point + 2]);
        Inc(Point, 3);
      end;
  end;
end;

procedure TEMFtoPDFExport.cmdPolyLine(Options: integer);
var
  Point: integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      cmdLineTo(Polyline.aptl[0])
    else
      cmdMoveTo(Polyline.aptl[0]);
    for Point := 1 to Polyline.cptl - 1 do
      cmdLineTo(Polyline.aptl[Point])
  end;
  if IsInclude(Options, ppClose) then
    cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.cmdPolyLine16(Options: integer = 0);
var
  Point: integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      cmdLineTo(Polyline16.apts[0])
    else
      cmdMoveTo(Polyline16.apts[0]);
    for Point := 1 to Polyline16.cpts - 1 do
      cmdLineTo(Polyline16.apts[Point])
  end;
  if IsInclude(Options, ppClose) then
    cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.cmdPolyPolyLine(Options: integer);
var
  Poly, Point: integer;
begin
  with FEMRList.Last as TEMRPolyPolygonObj do
  begin
    for Poly := 0 to P^.PolyPolygon.nPolys - 1 do
    begin
      if IsInclude(Options, ppWithTo) then
        cmdLineTo(PolyPoint[Poly, 0])
      else
        cmdMoveTo(PolyPoint[Poly, 0]);
      for Point := 1 to P^.PolyPolygon.aPolyCounts[Poly] - 1 do
        cmdLineTo(PolyPoint[Poly, Point]);
    end;
  end;
  if IsInclude(Options, ppClose) then
    cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.cmdPolyPolyLine16(Options: integer);
var
  Poly, Point: integer;
begin
  with FEMRList.Last as TEMRPolyPolygon16Obj do
  begin
    for Poly := 0 to P^.PolyPolygon16.nPolys - 1 do
    begin
      if IsInclude(Options, ppWithTo) then
        cmdLineTo(PolyPoint[Poly, 0])
      else
        cmdMoveTo(PolyPoint[Poly, 0]);
      for Point := 1 to P^.PolyPolygon16.aPolyCounts[Poly] - 1 do
        cmdLineTo(PolyPoint[Poly, Point]);
    end;
  end;
  if IsInclude(Options, ppClose) then
    cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.cmdRestoreGraphicsState;
begin
  PutLn('Q');
  FqQBalance := FqQBalance - 1;
end;

procedure TEMFtoPDFExport.cmdSaveGraphicsState;
begin
  PutLn('q');
  FqQBalance := FqQBalance + 1;
end;

procedure TEMFtoPDFExport.cmdSetClippingPath;
begin
  PutLn('W' + EvenOdd);
end;

procedure TEMFtoPDFExport.cmdSetFillColor(Color: TColor);
begin
  PutLn(Color2Str(Color) + ' rg'); // Set RGB color for nonstroking operations
end;

procedure TEMFtoPDFExport.cmdSetLineCap(PenEndCap: Integer);
begin
  if FForceButtLineCap then
    PutLn('2 J')
  else
    case FDC.PenEndCap of
      PS_ENDCAP_ROUND:
        PutLn('1 J');
      PS_ENDCAP_SQUARE:
        PutLn('2 J');
    else // PS_ENDCAP_FLAT
        PutLn('0 J');
    end;
end;

procedure TEMFtoPDFExport.cmdSetLineDashPattern(PenStyle: LongWord; Width: Extended);
begin
  PutLn('[' + PenStyle2Str(PenStyle, Width) + '] 0 d');
end;

procedure TEMFtoPDFExport.cmdSetLineJoin(PenLineJoin: Integer);
begin
  if FForceMitterLineJoin then
    PutLn('0 j')
  else
    case FDC.PenLineJoin of
      PS_JOIN_ROUND:
        PutLn('1 j');
      PS_JOIN_BEVEL:
        PutLn('2 j');
    else // PS_JOIN_MITER
        PutLn('0 j');
    end;

end;

procedure TEMFtoPDFExport.cmdSetLineWidth(PDFWidth: String);
begin
  PutLn(PDFWidth + ' w');
end;

procedure TEMFtoPDFExport.cmdSetLineWidth(Width: Extended);
begin
  cmdSetLineWidth(Float2Str(Width));
end;

procedure TEMFtoPDFExport.cmdSetMiterLimit(MiterLimit: Extended);
begin
  PutLn(Float2Str(MiterLimit) + ' M');
end;

procedure TEMFtoPDFExport.cmdSetStrokeColor(Color: TColor);
begin
  PutLn(Color2Str(Color) + ' RG'); // Set RGB color for stroking operations
end;

procedure TEMFtoPDFExport.cmdTranslationAndScaling(Sx, Sy, Tx, Ty: Extended);
begin
  PutLn(Float2Str(Sx) + ' 0 0 ' + Float2Str(Sy) + ' ' +
        Float2Str(Tx) + ' ' + Float2Str(Ty) + ' cm');
end;

//procedure TEMFtoPDFExport.cmdXForm(XF: TXForm);
//begin
//  PutLn(frFloat2Str(XF.eM11, 4) +  ' ' + frFloat2Str(XF.eM12, 4) + ' ' +
//        frFloat2Str(XF.eM21, 4) +  ' ' + frFloat2Str(XF.eM22, 4) + ' ' +
//        frFloat2Str(XF.eDx, 4) +   ' ' + frFloat2Str(XF.eDy, 4)  + ' cm');
//end;
//
procedure TEMFtoPDFExport.cmd_AngleArc(Center, Radius: TfrxPoint; StartAngle, SweepAngle: Single);
const
  MaxAnglePerCurve = 60;
var
  n, i: Integer;
  ActualArcAngle: Double;
  Bezier: TBezierResult;
begin
  n := Ceil(Abs(SweepAngle / MaxAnglePerCurve));
  ActualArcAngle := SweepAngle / n;
  for i := 0 to n - 1 do
  begin
    Bezier := BezierCurve(Center, Radius, StartAngle + i * ActualArcAngle, ActualArcAngle);
  	if i = 0 then
      cmdMoveTo(Bezier.P0);
    cmdAppendCurvedSegment3(Bezier.P1, Bezier.P2, Bezier.P3);
  end;
end;

procedure TEMFtoPDFExport.cmd_RoundRect(l, t, r, b, rx, ry: Extended);
  procedure Corner(x1, y1, x2, y2, x3, y3: Extended);
  begin
    PutLn(Float2Str(x1) + ' ' + Float2Str(y1) + ' ' + Float2Str(x2) + ' ' +
          Float2Str(y2) + ' ' + Float2Str(x3) + ' ' + Float2Str(y3) + '  c');
  end;
begin
  CmdMoveTo(l + rx, b);
  CmdLineTo(r - rx, b); // bottom
  Corner(r - rx / 2, b, r, b + ry / 2, r, b + ry);  // right-bottom
  CmdLineTo(r, t - ry); // right
  Corner(r, t - ry / 2, r - rx / 2, t, r - rx, t);  // right-top
  CmdLineTo(l + rx, t); // top
  Corner(l + rx / 2, t, l, t - ry / 2, l, t - ry);  // left-top
  CmdLineTo(l, b + ry); // left
  Corner(l, b + ry / 2, l + rx / 2, b, l + rx, b);  // left-bottom
end;

procedure TEMFtoPDFExport.Comment(CommentString: String);
begin
  if CommentString <> '' then
    PutLn('%--'+ CommentString)
  else if ShowComments then
  begin
    CommentAboutRealization;
    PutLn('%--' + Parsing);
  end;
end;

procedure TEMFtoPDFExport.CommentAboutRealization;
var
  CommandName, Value: String;
  i: integer;
begin
  CommandName := Copy(Parsing, 1, Pos(' ', Parsing + ' ') - 1);
  if FRealizationList.IndexOf(CommandName) <> -1 then // OK
    Exit;
  i := FRealizationList.IndexOfName(CommandName);
  Value := IfStr(i <> -1, FRealizationList.ValueFromIndex[i], '0');
  PutLn('% Realization: ' + Value);
end;

procedure TEMFtoPDFExport.CommentTextRect(rtl: TRect; Color: TColor = clRed);
var
  XFactor, YFactor: Extended;
  P1, P2: TfrxPoint;
begin
  XFactor := 1 / FDC.XFormScale.X;
  YFactor := 1 / FDC.XFormScale.Y;

  P1 := pdfFrxPoint(frxPoint(rtl.Left * XFactor, rtl.Top * YFactor));
  P2 := pdfFrxPoint(frxPoint(rtl.Right * XFactor, rtl.Bottom * YFactor));

  Comment('Comment ExtTextOutW.rclBounds >>>>>>');
  Comment(IntToStr(rtl.Left) + ', ' + IntToStr(rtl.Right) +
    ' (' + IntToStr(rtl.Right - rtl.Left) + ') -=> ' +
    frFloat2Str(P1.X, 2) + ', ' + frFloat2Str(P2.X, 2) +
    ' (' + frFloat2Str(P2.X - P1.X, 2) + ')');
  cmdSaveGraphicsState;
  PutLn('[] 0 d');
  cmdSetLineWidth(0.25);

  cmdMoveTo(P1.X, P1.Y);
  cmdLineTo(P1.X, P2.Y);
  cmdLineTo(P2.X, P1.Y);
  cmdLineTo(P2.X, P2.Y);
  cmdSetStrokeColor(Color);
  PutLn('S');

  cmdRestoreGraphicsState;
  Comment('Comment ExtTextOutW.rclBounds <<<<<<');
end;

constructor TEMFtoPDFExport.Create(InStream, OutStream: TStream; APDFRect: TfrxRect; APOH: TPDFObjectsHelper);
begin
  inherited Create(InStream, OutStream);
  FPDFRect := APDFRect;
  FPOH := APOH;

  FForceMitterLineJoin := False;
  FForceButtLineCap := False;
  FJPGQuality := 90;
  FForceNullBrush := False;
  FTransparency := False;
  FForceAnsi := False;
  FClipped := True;
  FExtSelectClipRgnCreated := False;

  FRotation2D := TRotation2D.Create;
  FPath := TPDFPath.Create(FOutStream);

  FRealizationList := TStringList.Create;
  FRealizationList.NameValueSeparator := '=';
  RealizationListFill([
    'EMR_AbortPath=?',
    'EMR_AngleArc',
    'EMR_AlphaBlend',
    'EMR_BeginPath',
    'EMR_BitBlt',
    'EMR_BrushOrgEx',
    'EMR_CloseFigure',
    'EMR_CreateBrushIndirect',
    'EMR_CreateMonoBrush',
    'EMR_CreatePen',
    'EMR_DeleteObject',
    'EMR_PolyDraw',
    'EMR_PolyDraw16',
    'EMR_Ellipse',
    'EMR_EndPath',
    'EMR_EoF',
    'EMR_ExtCreateFontIndirectW',
    'EMR_ExtCreatePen',
    'EMR_ExtSelectClipRgn',
    'EMR_ExtTextOutW',
    'EMR_FillPath',
    'EMR_FillRgn',
    'EMR_GDIComment',
    'EMR_Header',
    'EMR_IntersectClipRect',
    'EMR_LineTo',
    'EMR_MaskBlt',
    'EMR_ModifyWorldTransform',
    'EMR_MoveToEx',
    'EMR_PolyBezier',
    'EMR_PolyBezier16',
    'EMR_PolyBezierTo',
    'EMR_PolyBezierTo16',
    'EMR_Polygon',
    'EMR_Polygon16',
    'EMR_Polyline',
    'EMR_Polyline16',
    'EMR_PolylineTo',
    'EMR_PolylineTo16',
    'EMR_PolyPolygon',
    'EMR_PolyPolygon16',
    'EMR_PolyPolyline',
    'EMR_PolyPolyline16',
    'EMR_Rectangle',
    'EMR_RestoreDC',
    'EMR_RoundRect',
    'EMR_SaveDC',
    'EMR_SelectClipPath',
    'EMR_SelectObject',
    'EMR_SetBkColor',
    'EMR_SetBkMode',
    'EMR_SetICMMode',
    'EMR_SetLayout',
    'EMR_SetMetaRgn',
    'EMR_SetMiterLimit',
    'EMR_SetPolyFillMode',
    'EMR_SetRop2',
    'EMR_SetTextAlign',
    'EMR_SetTextColor',
    'EMR_SetStretchBltMode',
    'EMR_SetWorldTransform',
    'EMR_StretchDIBits',
    'EMR_StretchBlt',
    'EMR_StrokeAndFillPath',
    'EMR_StrokePath',
    'EMR_TransparentBlt'
  ]);
end;

//procedure TEMFtoPDFExport.CrossAtPos(pdfPoint: TfrxPoint; Color: TColor; Len, LineWidth: Integer);
//  function dPoint(dX, dY: double): TfrxPoint;
//  begin
//    Result := frxPoint(pdfPoint.X + dX, pdfPoint.Y + dY);
//  end;
//begin
//  PutLn('%Debug >>>');
//  cmdSaveGraphicsState;
//  PutLn('[] 0 d');
//  cmdSetStrokeColor(Color);
//  cmdSetLineWidth(LineWidth);
//  PutLn(frxPoint2Str(dPoint( 0, -Len)) + ' m');
//  PutLn(frxPoint2Str(dPoint( 0,  Len)) + ' l');
//  PutLn(frxPoint2Str(dPoint(-Len,  0)) + ' m');
//  PutLn(frxPoint2Str(dPoint( Len,  0)) + ' l');
//  PutLn('s');
//  cmdRestoreGraphicsState;
//  PutLn('%Debug <<<');
//end;

procedure TEMFtoPDFExport.DCCreate;
begin
  FDC := TPDFDeviceContext.Create;
end;

destructor TEMFtoPDFExport.Destroy;
begin
  FPath.Free;
  FRotation2D.Free;
  FRealizationList.Free;
  inherited;
end;

procedure TEMFtoPDFExport.DoEMR_AlphaBlend;
begin
  inherited;

  with PLast^.AlphaBlend do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop,
      FEMRList.Last as TEMRAlphaBlendObj);
end;

procedure TEMFtoPDFExport.DoEMR_AngleArc;
begin
  inherited;

  DrawFigureStart;

  with PLast^ do
    cmdAppendAngleArcToPath(AngleArc);

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_BitBlt;
begin
  inherited;

  with PLast^.BitBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRBitBltObj);
end;

procedure TEMFtoPDFExport.DoEMR_CloseFigure;
begin
  inherited;

  cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.DoEMR_Ellipse;
begin
  inherited;

  DrawFigureStart;

  with PLast^ do
    cmdAppendEllipsToPath(Ellipse.rclBox);

  DrawFigureFinish(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_EoF;
begin                    
  inherited;

  if FPath.Exists then
    cmdPathPainting(ppEnd);

  while FqQBalance > 0 do
    cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_ExtSelectClipRgn;
begin
  inherited DoEMR_ExtSelectClipRgn;

  if FExtSelectClipRgnCreated then
    cmdRestoreGraphicsState
  else
  begin
    cmdRestoreGraphicsState;
    FExtSelectClipRgnCreated := True;
    cmdSaveGraphicsState;
  end;

  cmdSaveGraphicsState;
  cmdCreateExtSelectClipRgn;
end;

procedure TEMFtoPDFExport.DoEMR_ExtTextOutW;

  function IsCompatible: Boolean;
  begin
    Result := PLast^.ExtTextOutW.iGraphicsMode = GM_COMPATIBLE;
  end;

  function IsAdvanced: Boolean;
  begin
    Result := PLast^.ExtTextOutW.iGraphicsMode = GM_ADVANCED;
  end;

  procedure DrawRotation(var pdfTextPosition: TfrxPoint);
  var
    LineOrientation, SumOrientation: LongInt; // specifies the angle, in tenths of degrees
    SumRadian: Single;
  begin
    if IsAdvanced then
      LineOrientation := FDC.LineOrientation
    else // GM_COMPATIBLE
      LineOrientation := 0;

    SumOrientation := FDC.FontOrientation + LineOrientation;
    if SumOrientation <> 0 then
    begin
      SumRadian := SumOrientation / 10.0 * Pi / 180.0;
      FRotation2D.Init(SumRadian, frxPoint(0.0, 0.0));
      PutLn(FRotation2D.Matrix + ' cm');
      pdfTextPosition := FRotation2D.Turn(pdfTextPosition);
    end;
  end;

var
  EMRExtTextOutWObj: TEMRExtTextOutWObj;
  Font: TEMFFont;
  RS: TRemapedString;

  function pdfDX: TDoubleArray;
  var
    i: Integer;
    OutputDx: TLongWordDinArray;
    SC: TEMFPDFSizeConverter;
  begin
    SC := TEMFPDFSizeConverter.Create(Self);
    OutputDx := EMRExtTextOutWObj.OutputDx;

    SetLength(Result, Length(OutputDx));
    for i := 0 to High(OutputDx) do
    begin
      SC.Log := LongInt(OutputDx[i]);
      Result[i] := SC.Char;
    end;
    SC.Free;
  end;

var
  OutputString: WideString;
  pdfFont: TfrxPDFFont;
  FontIndex: Integer;
  MovedTextPosition, ShiftSign, pdfTextPosition: TfrxPoint;
  Simulation: String;
  SimulateBold: Boolean;
  AlCorr: TfrxPoint; // Alignment correction
  IsRTL, IsRTLOptions, IsGlyphOut: Boolean;
  LogRect: TRect;
  XFactor, YFactor: Extended;
  R: TfrxRect;
const
  YCorr: array[TfrxVAlign] of Extended = (0.92, -0.23, 0.0);
  XCorr: array[TfrxHalign] of Extended = (0.0, -1.0, -0.5, 0.0);
begin
  inherited DoEMR_ExtTextOutW;

  cmdSaveGraphicsState;

  with PLast^.ExtTextOutW do
    if IsInclude(emrtext.fOptions, ETO_OPAQUE) then
    begin
      cmdAppendRectangleToPath(emrtext.rcl, IsCompatible);
      cmdPathPainting(ppFill + ppBkFill); // Use BkColor
    end;

  XFactor := (1 / FDC.XFormScale.X);
  YFactor := (1 / FDC.XFormScale.Y);
  with PLast^.ExtTextOutW.rclBounds do
    LogRect := Rect(Floor((Left - FDC.DeviceTopLeft.X) * XFactor),
                    Floor((Top - FDC.DeviceTopLeft.Y) * YFactor),
                    Ceil((Right  - FDC.DeviceTopLeft.X)* XFactor),
                    Ceil((Bottom - FDC.DeviceTopLeft.Y) * YFactor));

  if FDC.BkMode = OPAQUE then
  begin
    cmdAppendRectangleToPath(LogRect);
    cmdPathPainting(ppFill);
  end;

  IsRTLOptions := IsInclude(PLast^.ExtTextOutW.emrtext.fOptions, ETO_RTLREADING)
               or IsInclude(FDC.TextAlignmentMode, TA_RTLREADING)
               or IsInclude(FDC.Layout, EMR_LAYOUT_RTL);
  IsRTL := IsRTLOptions and
          (FDC.FontCharSet in [ARABIC_CHARSET, HEBREW_CHARSET]);
  IsGlyphOut := not IsRTL and
    IsInclude(PLast^.ExtTextOutW.emrtext.fOptions, ETO_GLYPH_INDEX);
  { disable back conversion in OutputString }
  if IsGlyphOut then
    PLast^.ExtTextOutW.emrtext.fOptions := PLast^.ExtTextOutW.emrtext.fOptions and not ETO_GLYPH_INDEX;

  EMRExtTextOutWObj := FEMRList.Last as TEMRExtTextOutWObj;

  OutputString := EMRExtTextOutWObj.OutputString(FDC.FontFamily, IsRTL);
  if OutputString <> '' then
  begin
    Font := FontCreate;

    with PLast^.ExtTextOutW do
      if IsInclude(emrtext.fOptions, ETO_CLIPPED) then
      begin
        cmdAppendRectangleToPath(emrtext.rcl, IsCompatible);
        cmdSetClippingPath;
        cmdPathPainting(ppEnd);
      end;

    AlCorr.X := Sin(FDC.FontRadian) * YCorr[FDC.VAlign] * FDC.FontSize
      + Cos(FDC.FontRadian) * XCorr[FDC.HAlign] * EMRExtTextOutWObj.TextLength;
    AlCorr.Y := Cos(FDC.FontRadian) * YCorr[FDC.VAlign] * FDC.FontSize +
      - Sin(FDC.FontRadian) * XCorr[FDC.HAlign] * EMRExtTextOutWObj.TextLength;

    ShiftSign := frxPoint(1.0, 1.0);
    if IsCompatible then // Need testing for GM_ADVANCED
      ShiftSign := frxPoint(Sign(FDC.XForm.eM11), Sign(FDC.XForm.eM22));

    with PLast^.ExtTextOutW.emrtext.ptlReference do
      MovedTextPosition := frxPoint(
        X + ShiftSign.X * (AlCorr.X),
        Y + ShiftSign.Y * (AlCorr.Y - FDC.FontSize * (1.0 - Font.DownSizeFactor)));

    pdfTextPosition := pdfFrxPoint(MovedTextPosition);

    { TODO : Needs rework }
    if (FDC.FontFamily = 'Cambria Math') then
    begin
      R := pdfFrxRect(LogRect);
      pdfTextPosition.Y := pdfTextPosition.Y
        - (R.Top - R.Bottom - Font.Size) / 2.25;
    end
    else if (FDC.FontFamily = 'Segoe UI Symbol') then
    begin
      R := pdfFrxRect(LogRect);
      pdfTextPosition.Y := pdfTextPosition.Y
        - (R.Top - R.Bottom - Font.Size) / 2.5;
    end;

    DrawRotation({var} pdfTextPosition);
    if  (FDC.FontOrientation > -1800) and (FDC.FontOrientation <= -1) and
        (FDC.XForm.eM22 < 0) and IsCompatible then
      PutLn('-1 0 0 -1 ' +
        frFloat2Str(2 * pdfTextPosition.X, 4) + ' ' +
        frFloat2Str(2 * (pdfTextPosition.Y + Font.PreciseSize * (1 - tpPt)), 4) +
        ' cm');

    if FPath.Exists then
      cmdPathPainting(ppEnd);

    if FPOH.IsBBox then
    begin
      PutLn('/Tx BMC');
      cmdSaveGraphicsState;
    end;

    PutLn('BT'); // Begin text object

    FontIndex := FPOH.GetObjFontNumber(Font);

    if IsAdvanced then
      PutLn(FPOH.Fonts[FontIndex].Name +
        AnsiString(' ' + frFloat2Str(Font.PreciseSize * (1 - tpPt)) + ' Tf'))
    else
      PutLn(FPOH.Fonts[FontIndex].Name +
        AnsiString(' ' + frFloat2Str(PDFFontSize(Font)) + ' Tf'));

    PutLn('[] 0 d');
    cmdSetFillColor(Font.Color);

    PutLn(frxPoint2Str(pdfTextPosition) + ' Td'); // Move text position

    pdfFont := FPOH.PageFonts[FontIndex];
    pdfFont.ForceAnsi := FForceAnsi;
    try
      RS := pdfFont.SoftRemapString(OutputString, IsRTL, IsGlyphOut);
    finally
      pdfFont.ForceAnsi := False;
    end;

    if IsNeedsItalicSimulation(Font, Simulation) then
      PutLn(Simulation + ' ' + frxPoint2Str(pdfTextPosition) + ' Tm');
    SimulateBold := IsNeedsBoldSimulation(Font, Simulation);
    if SimulateBold then
      PutLn(Simulation);

    if IsRTLOptions or not RS.IsValidCharWidth or RS.IsHasLigatures then
      PutLn('<' + StrToHex(RS.Data) + '> Tj') // Show text
    else
      PutLn('[<' + StrToHexDx(RS, pdfDX, Round(pdfSize(FDC.FontSize)) < 20) + '>] TJ');

    PutLn('ET'); // End text object

    if FPOH.IsBBox then
    begin
      PutLn('EMC');
      cmdRestoreGraphicsState;
    end;

    if SimulateBold then
      PutLn('0 Tr');

    if FDC.FontUnderline or FDC.FontStrikeOut then
      DrawFontLines(Font.PreciseSize, pdfTextPosition, pdfSize(EMRExtTextOutWObj.TextLength));

    Font.Free;
  end; // OutputString <> ''

  cmdRestoreGraphicsState;

  RestoreExtSelectClipRgn;
end;

procedure TEMFtoPDFExport.DoEMR_FillPath;
begin
  inherited DoEMR_FillPath;

  cmdPathPainting(ppFill);

  RestoreExtSelectClipRgn;
end;

procedure TEMFtoPDFExport.DoEMR_FillRgn;
var
  PRD: PRgnData;
  RectCount, i: Integer;
  R: TRect;
begin
  inherited DoEMR_FillRgn;

  cmdSaveGraphicsState;

  PRD := @PLast^.FillRgn.RgnData;
  RectCount := PRD^.rdh.nCount;

  cmdSetFillColor(MonoBrushAverageColor(PLast^.FillRgn.ihBrush));
  for i := 0 to RectCount - 1 do
  begin
    Move(PRD^.Buffer[i * SizeOf(TRect)], R, SizeOf(TRect));
    cmdAppendRectangleToPath(R);
  end;

  cmdPathPainting(ppFill + ppAsIsFill);

  cmdRestoreGraphicsState;

  RestoreExtSelectClipRgn;
end;

procedure TEMFtoPDFExport.DoEMR_Header;
var
  rWidth, rHeight: double;
begin
  inherited DoEMR_Header;

  with PLast^.Header do
  begin
    rWidth := szlDevice.cx / szlMillimeters.cx * (rclFrame.Right - rclFrame.Left) / 100;
    rHeight := szlDevice.cy / szlMillimeters.cy * (rclFrame.Bottom - rclFrame.Top) / 100;
  end;

  FEMFtoPDFFactor := frxPoint(
    (FPDFRect.Right - FPDFRect.Left) / rWidth,
    (FPDFRect.Top - FPDFRect.Bottom) / rHeight);

  FqQBalance := 0;

end;

procedure TEMFtoPDFExport.DoEMR_IntersectClipRect;
begin
  inherited DoEMR_IntersectClipRect;

  with PLast^.IntersectClipRect.rclClip do
    if (Right = Left) or (Bottom = Top) then
      Exit;
  cmdAppendRectangleToPath(PLast^.IntersectClipRect.rclClip);
  cmdSetClippingPath;
  cmdPathPainting(ppEnd);
end;

procedure TEMFtoPDFExport.DoEMR_LineTo;
begin
  inherited;
  // Specifies a line from the current position up to the specified point.

  DrawFigureStart;

  cmdLineTo(FDC.PositionNext);

  DrawFigureFinish(ppStroke + ppWithTo);
end;

procedure TEMFtoPDFExport.DoEMR_MaskBlt;
begin
  inherited;

  with PLast^.MaskBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRBitBltObj);
end;

procedure TEMFtoPDFExport.DoEMR_MoveToEx;
begin
  inherited;

  cmdMoveTo(FDC.PositionNext);
end;

procedure TEMFtoPDFExport.DoEMR_Pie;
begin
  inherited;

  DrawFigureStart;

  with PLast^ do
    cmdAppendPieToPath(Pie);

  DrawFigureFinish(ppClose + ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezier;
begin
  inherited;

  DrawFigureStart;

  cmdPolyBezier;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezier16;
begin
  inherited DoEMR_PolyBezier16;

  DrawFigureStart;

  cmdPolyBezier16;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezierTo;
begin
  inherited;

  DrawFigureStart;

  cmdPolyBezier(ppWithTo);

  DrawFigureFinish(ppStroke + ppWithTo);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezierTo16;
begin
  inherited;
// Specifies one or more Bezier curves based on the current position.

  DrawFigureStart;

  cmdPolyBezier16(ppWithTo);

  DrawFigureFinish(ppStroke + ppWithTo);
end;

procedure TEMFtoPDFExport.DoEMR_PolyDraw;
var
  Point, T, Count: integer;
begin
  inherited;

  DrawFigureStart;

  Point := 0;
  Count := PLast^.PolyDraw.cptl;
  with FEMRList.Last as TEMRPolyDrawObj do
    while Point <= Count - 1 do
    begin
      T := Types[Point];
      if IsInclude(T, PT_MOVETO) {PT_MOVETO - MUST be first test} then
        cmdMoveTo(P.PolyDraw.aptl[Point])
      else if IsInclude(T, PT_LINETO) then
        cmdLineTo(P.PolyDraw.aptl[Point])
      else if IsInclude(T, PT_BEZIERTO) then
        if      Point + 2 <= Count - 1 then
        begin
          cmdAppendCurvedSegment3(P.PolyDraw.aptl[Point],
            P.PolyDraw.aptl[Point + 1],
            P.PolyDraw.aptl[Point + 2]);
          Point := Point + 2;
        end
        else if Point + 1 <= Count - 1 then
        begin
          cmdAppendCurvedSegment2final(P.PolyDraw.aptl[Point],
            P.PolyDraw.aptl[Point + 1]);
          Point := Point + 1;
        end;

      if IsInclude(T, PT_CLOSEFIGURE) then
        cmdCloseSubpath;

      Point := Point + 1;
    end;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyDraw16;
var
  Point, T, Count: integer;
begin
  inherited;

  DrawFigureStart;

  Point := 0;
  Count := PLast^.PolyDraw16.cpts;
  with FEMRList.Last as TEMRPolyDraw16Obj do
    while Point <= Count - 1 do
    begin
      T := Types[Point];
      if IsInclude(T, PT_MOVETO) {PT_MOVETO - MUST be first test} then
        cmdMoveTo(P.PolyDraw16.apts[Point])
      else if IsInclude(T, PT_LINETO) then
        cmdLineTo(P.PolyDraw16.apts[Point])
      else if IsInclude(T, PT_BEZIERTO) then
        if      Point + 2 <= Count - 1 then
        begin
          cmdAppendCurvedSegment3(P.PolyDraw16.apts[Point],
            P.PolyDraw16.apts[Point + 1],
            P.PolyDraw16.apts[Point + 2]);
          Point := Point + 2;
        end
        else if Point + 1 <= Count - 1 then
        begin
          cmdAppendCurvedSegment2final(P.PolyDraw16.apts[Point],
            P.PolyDraw16.apts[Point + 1]);
          Point := Point + 1;
        end;

      if IsInclude(T, PT_CLOSEFIGURE) then
        cmdCloseSubpath;

      Point := Point + 1;
    end;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_Polygon;
begin
  inherited;

  if PLast^.Polyline.cptl > 1 then
  begin
    DrawFigureStart;

    cmdPolyLine(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Polygon16;
begin
  inherited;
// The polygon SHOULD be outlined using the current pen and filled using
// the current brush and polygon fill mode. The polygon SHOULD be closed
// automatically by drawing a line from the last vertex to the first.

  if PLast^.Polyline16.cpts > 1 then
  begin
    DrawFigureStart;

    cmdPolyLine16(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Polyline;
begin
  inherited;

  if PLast^.Polyline.cptl > 1 then
  begin
    DrawFigureStart;

    cmdPolyLine;

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Polyline16;
begin
  inherited;

  if PLast^.Polyline16.cpts > 1 then
  begin
    DrawFigureStart;

    cmdPolyLine16;

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolylineTo;
begin
  inherited;

  if PLast^.Polyline.cptl > 1 then
  begin
    DrawFigureStart;

    cmdPolyLine(ppWithTo);

    DrawFigureFinish(ppStroke + ppWithTo);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolylineTo16;
begin
  inherited;

  if PLast^.Polyline16.cpts > 1 then
  begin
    DrawFigureStart;

    cmdPolyLine16(ppWithTo);

    DrawFigureFinish(ppStroke + ppWithTo);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolygon;
begin
  inherited;

  if PLast^.PolyPolyline.nPolys > 0 then
  begin
    DrawFigureStart;

    cmdPolyPolyLine(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolygon16;
begin
  inherited;

  if PLast^.PolyPolyline16.nPolys > 0 then
  begin
    DrawFigureStart;

    cmdPolyPolyLine16(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolyline;
begin
  inherited;

  if PLast^.PolyPolyline.nPolys > 0 then
  begin
    DrawFigureStart;

    cmdPolyPolyLine(ppEnd);

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolyline16;
begin
  inherited;

  if PLast^.PolyPolyline16.nPolys > 0 then
  begin
    DrawFigureStart;

    cmdPolyPolyLine16(ppEnd);

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Rectangle;
begin
  inherited;

  DrawFigureStart;

  cmdAppendRectangleToPath(PLast^.Rectangle.rclBox);

  DrawFigureFinish(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_RestoreDC;
var
  i: integer;
begin
  inherited DoEMR_RestoreDC;

  for i := PLast^.RestoreDC.iRelative to -1 do
    cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_RoundRect;
begin
  inherited;

  DrawFigureStart;

  with PLast^ do
    cmdAppendRoundRectToPath(RoundRect.rclBox, RoundRect.szlCorner);

  DrawFigureFinish(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_SaveDC;
begin
  inherited;

  cmdSaveGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_SelectClipPath;
begin
  inherited;

  cmdSetClippingPath;
  cmdPathPainting(ppEnd);
end;

procedure TEMFtoPDFExport.DoEMR_StretchBlt;
begin
  inherited;

  with PLast^.StretchBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRStretchBltObj);
end;

procedure TEMFtoPDFExport.DoEMR_StretchDIBits;
begin
  inherited;

  with PLast^.StretchDIBits do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRStretchDIBitsObj);
end;

procedure TEMFtoPDFExport.DoEMR_StrokeAndFillPath;
begin
  inherited;

  cmdPathPainting(ppFill + ppStroke);

  RestoreExtSelectClipRgn;
end;

procedure TEMFtoPDFExport.DoEMR_StrokePath;
begin
  inherited;

  cmdPathPainting(ppStroke);

  RestoreExtSelectClipRgn;
end;

procedure TEMFtoPDFExport.DoEMR_TransparentBlt;
begin
  inherited;

  with PLast^.TransparentBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRTransparentBltObj);
end;

procedure TEMFtoPDFExport.DoFinish;
begin
  inherited;

  cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoStart;
begin        // Before EMR_Header
  inherited;

  cmdSaveGraphicsState;

  if FClipped then
  begin
    PutLn(frxRect2Str(FPDFRect) + ' re');

    cmdSetClippingPath;
    cmdPathPainting(ppEnd);
  end;
end;

procedure TEMFtoPDFExport.DrawFigureFinish(Options: integer);
begin
  if not FDC.IsPathBracketOpened then
  begin
    cmdPathPainting(FillStrokeOptions(Options));
    cmdRestoreGraphicsState;
    if IsInclude(Options, ppWithTo) then
      cmdMoveTo(FDC.PositionNext);

    RestoreExtSelectClipRgn;
  end;
end;

procedure TEMFtoPDFExport.DrawFigureStart;
begin
  if not FDC.IsPathBracketOpened then
    cmdSaveGraphicsState;
end;

procedure TEMFtoPDFExport.DrawFontLines(FontSize: Double; TextPosition: TfrxPoint; TextWidth: Extended);
  procedure DrawLine(Shift, Width: Extended);
  var
    Y: Extended;
  begin
    Y := TextPosition.Y + FontSize * Shift;

    cmdMoveTo(TextPosition.X, Y);
    cmdLineTo(TextPosition.X + TextWidth, Y);
    cmdSetLineWidth(Width);

    cmdPathPainting(ppStroke);
  end;
const
  FontLineThickness = 0.095 * PDF_DIVIDER;
  UnderlineShift = -0.125;
  StrikeOutShift = 0.29;
begin
  cmdSetLineDashPattern(PS_SOLID, 0);
  cmdSetStrokeColor(FDC.TextColor);

  if FDC.FontUnderline then
    DrawLine(UnderlineShift, FontSize * FontLineThickness);
  if FDC.FontStrikeOut then
    DrawLine(StrikeOutShift, FontSize * FontLineThickness / 2);
end;

function TEMFtoPDFExport.emfPoint2Str(emfSP: TSmallPoint; IsScalingOnly: Boolean = False): String;
begin
  Result := frxPoint2Str(pdfFrxPoint(emfSP, IsScalingOnly));
end;

function TEMFtoPDFExport.emfPoint2Str(emfP: TPoint; IsScalingOnly: Boolean = False): String;
begin
  Result := frxPoint2Str(pdfFrxPoint(emfP, IsScalingOnly));
end;

function TEMFtoPDFExport.emfPoint2Str(emfFP: TfrxPoint; IsScalingOnly: Boolean = False): String;
begin
  Result := frxPoint2Str(pdfFrxPoint(emfFP, IsScalingOnly));
end;

function TEMFtoPDFExport.emfRect2Str(emfR: TRect; IsScalingOnly: Boolean = False): String;
begin
  Result := frxRect2Str(pdfFrxRect(emfR, IsScalingOnly));
end;

//function TEMFtoPDFExport.emfSize2Str(emfSize: Extended): String;
//begin
//  Result := Float2Str(pdfSize(emfSize));
//end;

function TEMFtoPDFExport.EvenOdd: String;
begin
  Result := IfStr(FDC.PolyFillMode = ALTERNATE, '*');
end;

function TEMFtoPDFExport.FillStrokeOptions(Options: integer): integer;
begin
  Result := IfInt(IsInclude(Options, ppStroke) and not IsNullPen, ppStroke) +
            IfInt(IsInclude(Options, ppFill) and not IsNullBrush, ppFill);
end;

function TEMFtoPDFExport.FontCreate: TEMFFont;
var
  FontIndex: Integer;
begin
  Result := inherited FontCreate;

  if FDC.IsFontHeight then
  begin
    FontIndex := FPOH.GetObjFontNumber(Result);
    Result.DownSizeFactor := FPOH.PageFonts[FontIndex].FontHeightToPointSizeFactor;
  end
  else
    Result.DownSizeFactor := 1.0;

  Result.PreciseSize := pdfSize(FDC.FontSize * Result.DownSizeFactor);
  Result.Size := Round(Result.PreciseSize);
end;

function TEMFtoPDFExport.IsNullBrush: Boolean;
begin
  Result := FForceNullBrush or
    (FDC.BrushStyle in [BS_NULL, BS_PATTERN8X8, BS_DIBPATTERN8X8, BS_MONOPATTERN]);
end;

function TEMFtoPDFExport.IsNullPen: Boolean;
begin
  Result := FDC.PenStyle in [PS_NULL];
end;

function TEMFtoPDFExport.PDFDeviceContext: TPDFDeviceContext;
begin
  Result := FDC as TPDFDeviceContext;
end;

function TEMFtoPDFExport.pdfFrxPoint(emfP: TPoint; IsScalingOnly: Boolean = False): TfrxPoint;
begin
  Result := LogToDevPoint(emfP, IsScalingOnly);
  Result.X := FPDFRect.Left + Result.X * FEMFtoPDFFactor.X;
  Result.Y := FPDFRect.Top - Result.Y * FEMFtoPDFFactor.Y;
end;

function TEMFtoPDFExport.pdfFrxPoint(emfSP: TSmallPoint; IsScalingOnly: Boolean = False): TfrxPoint;
begin
  Result := LogToDevPoint(emfSP, IsScalingOnly);
  Result.X := FPDFRect.Left + Result.X * FEMFtoPDFFactor.X;
  Result.Y := FPDFRect.Top - Result.Y * FEMFtoPDFFactor.Y;
end;

function TEMFtoPDFExport.pdfFrxPoint(emfDP: TfrxPoint; IsScalingOnly: Boolean = False): TfrxPoint;
begin
  Result := LogToDevPoint(emfDP, IsScalingOnly);
  Result.X := FPDFRect.Left + Result.X * FEMFtoPDFFactor.X;
  Result.Y := FPDFRect.Top - Result.Y * FEMFtoPDFFactor.Y;
end;

function TEMFtoPDFExport.pdfFrxRect(emfR: TRect; IsScalingOnly: Boolean = False): TfrxRect;
var
  TopLeft, BottomRight: TfrxPoint;
begin
  TopLeft := pdfFrxPoint(emfR.TopLeft, IsScalingOnly);
  BottomRight := pdfFrxPoint(emfR.BottomRight, IsScalingOnly);

  Result.Left := Min(TopLeft.X, BottomRight.X);
  Result.Right := Max(TopLeft.X, BottomRight.X);

  Result.Top := Max(TopLeft.Y, BottomRight.Y);    // Max !
  Result.Bottom := Min(TopLeft.Y, BottomRight.Y); // Min !
end;

function TEMFtoPDFExport.pdfSize(emfSize: Extended): Extended;
begin
  Result := LogToDevSize(emfSize) * (FEMFtoPDFFactor.X + FEMFtoPDFFactor.Y) / 2;
end;

procedure TEMFtoPDFExport.Put(const S: AnsiString);
begin
  if FPath.Exists then
    FPath.Put(S)
  else if FOutStream <> nil then
    FOutStream.Write(S[1], Length(S));
end;

procedure TEMFtoPDFExport.PutLn(const S: AnsiString);
begin
  Put(S + AnsiString(#13#10));
end;

procedure TEMFtoPDFExport.RealizationListFill(RealizedCommands: array of String);
var
  i: integer;
begin
  for i := Low(RealizedCommands) to High(RealizedCommands) do
    FRealizationList.Add(RealizedCommands[i]);
end;

procedure TEMFtoPDFExport.RestoreExtSelectClipRgn;
begin
  if FExtSelectClipRgnCreated then
  begin
    FExtSelectClipRgnCreated := False;
    cmdRestoreGraphicsState;
  end;
end;

{$IFDEF Delphi12}
procedure TEMFtoPDFExport.PutLn(const S: String);
begin
  PutLn(AnsiString(S));
end;
{$ENDIF}

{ TPDFPath }

constructor TPDFPath.Create(AOutStream: TStream);
begin
  FOutStream := AOutStream;

  FExists := False;

  FStream := nil;
  if FOutStream <> nil then
    FStream := TMemoryStream.Create;
end;

destructor TPDFPath.Destroy;
begin
  FStream.Free;

  inherited;
end;

procedure TPDFPath.Flush;
begin
  if FOutStream <> nil then
  begin
    FStream.Position := 0;
    FOutStream.CopyFrom(FStream, FStream.Size);
    FStream.Clear;
  end;
  FExists := False;
end;

procedure TPDFPath.Put(const S: AnsiString);
begin
  if FOutStream <> nil then
    FStream.Write(S[1], Length(S));
end;

{ TEMFPDFSizeConverter }

constructor TEMFPDFSizeConverter.Create(AExport: TEMFtoPDFExport);
begin
  FExport := AExport;
  FEMFPDFFactor := FExport.FEMFtoPDFFactor.X;
  FFont := FExport.FontCreate;
end;

destructor TEMFPDFSizeConverter.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TEMFPDFSizeConverter.SetChar(const Value: Double);
begin
  FChar := Value;

  FDev := FChar * FFont.Size / 1000 / FEMFPDFFactor;

  FPDF := FDev * FEMFPDFFactor;

  FLog := FDev * FEXport.FDC.XFormAverageScale;
end;

procedure TEMFPDFSizeConverter.SetDev(const Value: Double);
begin
  FDev := Value;

  FPDF := FDev * FEMFPDFFactor;

  FChar := FDev * 1000 / Max(1, FFont.Size) * FEMFPDFFactor;

  FLog := FDev * FEXport.FDC.XFormAverageScale;
end;

procedure TEMFPDFSizeConverter.SetLog(const Value: Double);
begin
  FLog := Value;

  FDev := FExport.LogToDevSizeX(FLog);

  FPDF := FDev * FEMFPDFFactor;

  FChar := FDev * 1000 / Max(1, FFont.Size) * FEMFPDFFactor;
end;

procedure TEMFPDFSizeConverter.SetPDF(const Value: Double);
begin
  FPDF := Value;

  FDev := FPDF / FEMFPDFFactor;

  FChar := FDev * 1000 / Max(1, FFont.Size) * FEMFPDFFactor;

  FLog := FDev * FEXport.FDC.XFormAverageScale;
end;

end.

