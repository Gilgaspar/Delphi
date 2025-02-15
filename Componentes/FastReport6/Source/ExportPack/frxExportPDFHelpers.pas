
{******************************************}
{                                          }
{             FastReport v6.0              }
{            PDF export filter             }
{                                          }
{         Copyright (c) 1998-2019          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportPDFHelpers;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}{$IFDEF Delphi12}pngimage{$ELSE}frxpngimage{$ENDIF},{$ENDIF}
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Graphics, Classes, SysUtils, frxRC4, frxTrueTypeCollection, Contnrs,
{$IFNDEF FPC}frxEMFAbstractExport, {$ENDIF}
  frxClass,
{$IFNDEF FPC}frxEMFFormat, {$ENDIF}
{$IFDEF FPC}LazHelper, {$ENDIF}
  frxUtils,
{$IFNDEF FPC}JPEG, {$ENDIF}
{$IFDEF Delphi12}
  AnsiStrings,
{$ENDIF}
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  frxAnaliticGeometry, frxExportHelpers
{$IFDEF Linux}
  , types,  Messages, Controls, Forms, Dialogs, Process,
  Variants,  StdCtrls, Db, DBCtrls, Buttons, ExtCtrls, Menus, ComCtrls, lmessages, frxStorage, frxLinuxFonts
{$ENDIF};

type
  TfrxPDFFont = class(TfrxExportFont)
  private
    FColor: TColor;
    FFontName: AnsiString;
    FSize: Extended;
  protected
    Index: Integer;

    procedure FillOutlineTextMetrix();
  public
    Name: AnsiString;
    Reference: Longint;
    Saved: Boolean;
    constructor Create(Font: TFont);
    procedure PackTTFFont;
    function GetFontName: AnsiString;
    function SpaceAdjustment(RS: TRemapedString; TextWidth, FontSize: Extended): Extended;
    function FontHeightToPointSizeFactor: Double;
    {$IFDEF Linux}
    function GetFontDataSize(): Longint; Override;
    {$ENDIF}

    procedure Update(const SourcePDFFont: TfrxPDFFont; const SourceFont: TFont);
    property FontName: AnsiString read FFontName write FFontName;
    property Size: Extended read FSize write FSize;
    property Color: TColor read FColor write FColor;
  end;

  TfrxPDFXObjectHash = array[0..15] of Byte; // MD5
  TfrxPDFXObject = record
    ObjId: Integer; // id that appears in 'id 0 R'
    Hash: TfrxPDFXObjectHash;
  end;

  TPDFObjectsHelper = class
  private
    FFonts: TList;
    FAcroFonts: TList;
    FBBoxFonts: TList;
    FPageFonts: TList;
    FXRef: TStringList;
    FpdfStream: TStream;
    FProtection: boolean;
    FEncKey: AnsiString;
    FEmbedded: boolean;
    FQuality: Integer;
    FXObjectsCount: Integer;
    FXObjects: array of TfrxPDFXObject;
    FUsedXObjects: array of Integer; // XObjects' ids used within the current page
    FIsBBoxReleative: Boolean;
    FLastRequestedXRef: Integer;
    function GetFonts(Index: integer): TfrxPDFFont;
    function GetFontsCount: integer;
    function GetPageFonts(Index: integer): TfrxPDFFont;
    function GetPageFontsCount: integer;
    function GetAcroFonts(Index: integer): TfrxPDFFont;
    function GetAcroFontsCount: integer;
    function GetBBoxFonts(Index: integer): TfrxPDFFont;
    function GetBBoxFontsCount: Integer;
    function GetLastObjectXRefID: Integer;
  protected
    function GetOSFontName(const Font: TFont): String;
    function IsFontNameAndStyle(const Font: TFont; Name: String; Style: TFontStyles): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function GetGlobalFont(const Font: TFont; const OSFontName: String): TfrxPDFFont;
    function GetAcroFont(const Font: TFont): TfrxPDFFont;
    function GetObjFontNumber(const Font: TFont): integer;

    procedure ClearUsedXObjects;
    procedure OutUsedXObjects;
    function FindXObject(const Hash: TfrxPDFXObjectHash): Integer;
    function AddXObject(Id: Integer; const Hash: TfrxPDFXObjectHash): Integer;
    procedure ClearXObject;
    procedure AddUsedObject(Index: integer);
    function GetXObjectsId(Index: integer): Integer;

    function OutXObjectImage(XObjectHash: TfrxPDFXObjectHash;
      Jpg: TJPEGImage; XObjectStream: TStream;
      IsTransparent: Boolean = False; MaskId: Integer = 0): Integer;
    function OutTransparentPNG(PNGA: TPNGObject; Size: TSize): Integer; // map images
    function UpdateXRef: Integer;
    procedure StartBBox;
    procedure EndBBox;

    property AcroFonts[Index: integer]: TfrxPDFFont read GetAcroFonts;
    property AcroFontsCount: integer read GetAcroFontsCount;
    property BBoxFonts[Index: integer]: TfrxPDFFont read GetBBoxFonts;
    property BBoxFontsCount: Integer read GetBBoxFontsCount;
    property Fonts[Index: integer]: TfrxPDFFont read GetFonts;
    property FontsCount: integer read GetFontsCount;
    property PageFonts [Index: integer]: TfrxPDFFont read GetPageFonts;
    property PageFontsCount: integer read GetPageFontsCount;
    property pdfStream: TStream write FpdfStream;
    property XRef: TStringList read FXRef;
    property LastObjectXRefID: Integer read GetLastObjectXRefID;
    property Protection: boolean write FProtection;
    property EncKey: AnsiString write FEncKey;
    property EmbeddedFonts: Boolean read FEmbedded write FEmbedded default False;
    property IsBBox: Boolean read FIsBBoxReleative;
    property Quality: Integer write FQuality;
  end;


function IsNeedsItalicSimulation(Font: TFont; out Simulation: String): Boolean;
function IsNeedsBoldSimulation(Font: TFont; out Simulation: String): Boolean;

procedure AddStyleSimulation(FontName: String; FontStyles: TFontStyles);
procedure DeleteStyleSimulation(FontName: String);

function StrToHex(const Value: WideString): AnsiString;
function StrToHexSp(const Value: WideString; SpaceAdjustment: Extended): AnsiString;
function StrToHexDx(const RS: TRemapedString; pdfDX: TDoubleArray; AverageDx: Boolean): AnsiString;

function Color2Str(Color: TColor): String;
function frxRect2Str(DR: TfrxRect): String;

function frxPointSum(P1, P2: TfrxPoint): TfrxPoint;
function frxPointMult(P: TfrxPoint; Factor: Extended): TfrxPoint;

procedure GetStreamHash(out Hash: TfrxPDFXObjectHash; S: TStream);
function ObjNumberRef(FNumber: longint): String;
function ObjNumber(FNumber: longint): String;
function PrepXRefPos(Index: Integer): String;
function CryptStream(Source: TStream; Target: TStream; Key: AnsiString; id: Integer): AnsiString;

procedure Write(Stream: TStream; const S: AnsiString);{$IFDEF Delphi12} overload;
procedure Write(Stream: TStream; const S: String); overload; {$ENDIF}
procedure WriteLn(Stream: TStream; const S: AnsiString);{$IFDEF Delphi12} overload;
procedure WriteLn(Stream: TStream; const S: String); overload; {$ENDIF}

type
  TMaskArray = array of byte;
function BitmapPixelSize(Bitmap: TBitmap): Integer;
function CreateBitmap(PixelFormat: TPixelFormat; SizeBitmap: TBitmap): TBitmap; overload;
function CreateBitmap(PixelFormat: TPixelFormat; Width, Height: Integer): TBitmap; overload;
procedure CreateMask(Bitmap: TBitmap; var Mask: TMaskArray);
procedure SaveMask(pdf, XObjectStream: TStream; MaskBytes: TMaskArray;
  FPOH: TPDFObjectsHelper; TempBitmap: TBitmap; FProtection: Boolean; FEncKey: AnsiString;
  out XObjectHash: TfrxPDFXObjectHash; out XMaskId, PicIndex: Integer);

const
  PDF_DIVIDER = 0.75;

type
  TfrxShapeKindSet = set of TfrxShapeKind;

function IsShape(Obj: TfrxView; ShapeKindSet: TfrxShapeKindSet): boolean;
function Is2DShape(Obj: TfrxView): boolean;

type
  TViewSizes = record l, t, w, h, r, b: Extended; end;

function ShadowlessSizes(Obj: TfrxView): TViewSizes;

type
  TRGBAWord = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;

  PRGBAWord = ^TRGBAWordArray;
  TRGBAWordArray = array[0..4095] of TRGBAWord;

  TPDFStandard =
    (psNone, psPDFA_1a, psPDFA_1b, psPDFA_2a, psPDFA_2b, psPDFA_3a, psPDFA_3b);
  TPDFVersion =
    (pv14, pv15, pv16, pv17);

const
  PDFStandardName: array[TPDFStandard] of string =
    ('None', 'PDF/A-1a', 'PDF/A-1b', 'PDF/A-2a', 'PDF/A-2b', 'PDF/A-3a', 'PDF/A-3b');
  PDFPartName: array[TPDFStandard] of string =
    (    '',       '1',        '1',         '2',       '2',         '3',       '3');
  PDFConformanceName: array[TPDFStandard] of string =
    (    '',       'A',        'B',         'A',       'B',         'A',       'B');
  PDFVersionName: array[TPDFVersion] of string =
    ('1.4', '1.5', '1.6', '1.7');

function PDFStandardByName(StandardName: string): TPDFStandard;
function PDFVersionByName(VersionName: string): TPDFVersion;
function IsPDFA(ps: TPDFStandard): Boolean;
function IsPDFA_1(ps: TPDFStandard): Boolean;
function IsVersionByStandard(ps: TPDFStandard; var pv: TPDFVersion): Boolean;

function PDFFontSize(Font: TFont): Extended;
//function IsMonospaced(FontName: string): Boolean;
procedure StretchFont(FontName: TFontName; FontSize: Integer; Factor: Double);
procedure ClearStretchedFont(FontName: TFontName);
procedure DisableTpPtCorrection;
procedure EnableTpPtCorrection;

type
  TInt64List = class
  private
    function GetItem(Index: integer): Int64;
    procedure Setitem(Index: integer; const Value: Int64);
    function GetCount: Integer;
  protected
    FObjectList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(Value: Int64);
    procedure Clear;

    property Items[Index: integer]: Int64 read GetItem write Setitem; default;
    property Count: Integer read GetCount;
  end;

const
  tpPt = 0.254 / 72; // typography pt

implementation

uses
  frxTrueTypeFont,
  frxCrypto, frxmd5;

var
  tpPtCorrection: Boolean;

type
  TPDFFontSimulation = class
  private
    FName: String;
    FFontStyles: TFontStyles;
  public
    constructor Create(Name: String; FontStyles: TFontStyles);
    procedure AddStyles(FontStyles: TFontStyles);
    function IsName(Name: String): Boolean;
    function IsStyle(FontStyle: TFontStyle): Boolean;
  end;

  TPDFFontSimulationList = class (TObjectList)
  protected
    procedure DeleteFont(Name: String);
    function Find(Name: String): TPDFFontSimulation;
    function IsNeedsStyle(Name: String; FontStyle: TFontStyle): Boolean;
  public
    procedure AddFont(Name: String; FontStyles: TFontStyles);

    function IsNeedsBold(Name: String): Boolean;
    function IsNeedsItalic(Name: String): Boolean;
  end;

// list of fonts that do not have bold-italic versions and needs to be simulated
var
  PDFFontSimulationList: TPDFFontSimulationList;

type
  TPDFFontCorrection = class
  private
    function GetCorrection(Index: Integer): Double;
    procedure SetCorrection(Index: Integer; const Value: Double);
  protected
    FCorrection: array [0..64] of Double;
  public
    constructor Create;
    property Correction[Index: Integer]: Double read GetCorrection write SetCorrection;
  end;

  TPDFFontCorrectionList = class (TStringList)
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCorrection(FontName: TFontName; FontSize: Integer; Factor: Double);
    procedure DeleteCorrection(FontName: TFontName);
    function GetCorrection(FontName: TFontName; FontSize: Integer): Double;
  end;

var
  PDFFontCorrectionList: TPDFFontCorrectionList;

{ Utility routines }

//function EnumFontsProc(var EnumLogFont: TEnumLogFont;
//  var TextMetric: TNewTextMetric; FontType: Integer;
//  Data: LPARAM): Integer; export; stdcall;
//begin
//  Result := Integer((EnumLogFont.elfLogFont.lfPitchAndFamily and FIXED_PITCH) = FIXED_PITCH);
//end;
//
//function IsMonospaced(FontName: string): Boolean;
//var
//  DC : HDC;
//begin;
//  DC:=GetDC(0);
//  try
//    Result := EnumFontFamilies(DC, PChar(FontName), @EnumFontsProc, 0); //EnumFontFamilies return Integer, but Result is Boolean
//  finally
//    ReleaseDC(0, DC);
//  end;
//end;

function IfFontCorrected(Font: TFont; out Corr: Extended): Boolean;
begin
  Corr := PDFFontCorrectionList.GetCorrection(Font.Name, Font.Size);
  Result := Corr <> 1.0;
end;

procedure DisableTpPtCorrection;
begin
  tpPtCorrection := False;
end;

procedure EnableTpPtCorrection;
begin
  tpPtCorrection := True;;
end;

procedure StretchFont(FontName: TFontName; FontSize: Integer; Factor: Double);
begin
  PDFFontCorrectionList.AddCorrection(FontName, FontSize, Factor);
end;

procedure ClearStretchedFont(FontName: TFontName);
begin
  PDFFontCorrectionList.DeleteCorrection(FontName);
end;

function PDFFontSize(Font: TFont): Extended;
var
  Corr: Extended;
begin
  if      IfFontCorrected(Font, Corr) then
    Result := Round((Font.Size * (1 - tpPt) * Corr) * 1000) / 1000
  else if tpPtCorrection then
    Result := Trunc(Font.Size * (1 - tpPt) * 10) / 10
  else
    Result := Font.Size;
end;

function CreateBitmap(PixelFormat: TPixelFormat; Width, Height: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := PixelFormat;
  Result.Width := Width;
  Result.Height := Height;
end;

function CreateBitmap(PixelFormat: TPixelFormat; SizeBitmap: TBitmap): TBitmap;
begin
  Result := CreateBitmap(PixelFormat, SizeBitmap.Width, SizeBitmap.Height);
end;

function BitmapPixelSize(Bitmap: TBitmap): Integer;
begin
  Result := Bitmap.Width * Bitmap.Height;
end;

procedure SaveMask(pdf, XObjectStream: TStream; MaskBytes: TMaskArray;
  FPOH: TPDFObjectsHelper; TempBitmap: TBitmap; FProtection: Boolean; FEncKey: AnsiString;
  out XObjectHash: TfrxPDFXObjectHash; out XMaskId, PicIndex: Integer);
var
  MaskIndex, MaskSize: Integer;
  XMaskStream: TStream;
  XMaskHash: TfrxPDFXObjectHash;
begin
  XMaskStream := TMemoryStream.Create;
  try
    XMaskStream.Position := 0;
    MaskSize := BitmapPixelSize(TempBitmap);
    XMaskStream.Write(Pointer(MaskBytes)^, MaskSize);

    XMaskStream.Position := 0;
    GetStreamHash(XMaskHash, XMaskStream);
    MaskIndex := FPOH.FindXObject(XMaskHash);

    if MaskIndex < 0 then
    begin
      XMaskId := FPOH.UpdateXRef;
      FPOH.AddXObject(XMaskId, XMaskHash);
      Writeln(pdf, ObjNumber(XMaskId));

      Writeln(pdf, '<< /Type /XObject');
      Writeln(pdf, '/Subtype /Image');
      Writeln(pdf, '/Width ' + IntToStr(TempBitmap.Width));
      Writeln(pdf, '/Height ' + IntToStr(TempBitmap.Height));
      Writeln(pdf, '/ColorSpace /DeviceGray/Matte[ 0 0 0] ');
      Writeln(pdf, '/BitsPerComponent 8');
      Writeln(pdf, '/Interpolate false');

      /// ///////  NEED TO REPLACE

      Writeln(pdf, ' /Length ' + IntToStr(MaskSize) + ' >>');
      Writeln(pdf, 'stream');
      if FProtection then
        CryptStream(XMaskStream, pdf, FEncKey, XMaskId)
      else
        pdf.CopyFrom(XMaskStream, 0);

      Write(pdf, #13#10'endstream'#13#10);
      Writeln(pdf, 'endobj');
    end
    else
      XMaskId := FPOH.GetXObjectsId(MaskIndex);
    { hash should be calculated for Pic + Mask }
    XMaskStream.Position := XMaskStream.Size;
    XObjectStream.Position := 0;
    XMaskStream.CopyFrom(XObjectStream, 0);
    XMaskStream.Position := 0;
    XObjectStream.Position := 0;
    GetStreamHash(XObjectHash, XMaskStream);
    PicIndex := FPOH.FindXObject(XObjectHash);
  finally
    XMaskStream.Free;
  end;
end;

procedure CreateMask(Bitmap: TBitmap; var Mask: TMaskArray);
var
  Ix, Iy: Integer;
  dots: PRGBAWord;
begin
  SetLength(Mask, BitmapPixelSize(Bitmap));
  for Iy := 0 to Bitmap.Height - 1 do
  begin
    dots := Bitmap.ScanLine[Iy];
    for Ix := 0 to Bitmap.Width - 1 do
      Mask[Ix + Iy * Bitmap.Width] := dots[Ix].Alpha;
  end;
end;

function IsVersionByStandard(ps: TPDFStandard; var pv: TPDFVersion): Boolean;
begin
  Result := True;
  case ps of
    psPDFA_1a, psPDFA_1b:
      pv := pv14;
    psPDFA_2a, psPDFA_2b, psPDFA_3a, psPDFA_3b:
      pv := pv17;
  else
    Result := False;
  end;

end;

function IsPDFA_1(ps: TPDFStandard): Boolean;
begin
  Result := ps in [psPDFA_1a, psPDFA_1b];
end;

function IsPDFA(ps: TPDFStandard): Boolean;
begin
  Result := ps in [psPDFA_1a, psPDFA_1b, psPDFA_2a, psPDFA_2b, psPDFA_3a, psPDFA_3b];
end;

function PDFVersionByName(VersionName: string): TPDFVersion;
var
  pv: TPDFVersion;
begin
  for pv := Low(TPDFVersion) to High(TPDFVersion) do
    if VersionName = PDFVersionName[pv] then
    begin
      Result := pv;
      Exit;
    end;

  raise Exception.Create('Unknown/unsupported PDF version: "' + VersionName +'"');
end;

function PDFStandardByName(StandardName: string): TPDFStandard;
var
  ps: TPDFStandard;
begin
  for ps := Low(TPDFStandard) to High(TPDFStandard) do
    if StandardName = PDFStandardName[ps] then
    begin
      Result := ps;
      Exit;
    end;

  raise Exception.Create('Unknown/unsupported PDF standard: "' + StandardName +'"');
end;

function ShadowlessSizes(Obj: TfrxView): TViewSizes;
begin
  with Result do
  begin
    l := Obj.AbsLeft;
    t := Obj.AbsTop;
    w := Obj.Width - Obj.ShadowSize;
    h := Obj.Height - Obj.ShadowSize;
    r := l + w;
    b := t + h;
  end;
end;

function Is2DShape(Obj: TfrxView): boolean;
begin
  Result := IsShape(Obj,
    [skRectangle, skRoundRectangle, skEllipse, skTriangle, skDiamond]);
end;

function IsShape(Obj: TfrxView; ShapeKindSet: TfrxShapeKindSet): boolean;
begin
  Result := (Obj is TfrxShapeView) and (TfrxShapeView(Obj).Shape in ShapeKindSet);
end;

procedure Write(Stream: TStream; const S: AnsiString);
begin
  Stream.Write(S[1], Length(S));
end;

procedure WriteLn(Stream: TStream; const S: AnsiString);
begin
  Write(Stream, S + AnsiString(#13#10));
end;

{$IFDEF Delphi12}
procedure WriteLn(Stream: TStream; const S: String);
begin
  WriteLn(Stream, AnsiString(s));
end;

procedure Write(Stream: TStream; const S: String);
begin
  Write(Stream, AnsiString(S));
end;
{$ENDIF}

procedure GetStreamHash(out Hash: TfrxPDFXObjectHash; S: TStream);
var
  H: TCryptoHash;
begin
  H := TCryptoMD5.Create;

  try
    H.Push(S);
    H.GetDigest(Hash[0], SizeOf(Hash));
  finally
    H.Free;
  end;
end;

function ObjNumber(FNumber: longint): String;
begin
  Result := IntToStr(FNumber) + ' 0 obj';
end;

function ObjNumberRef(FNumber: longint): String;
begin
  Result := IntToStr(FNumber) + ' 0 R';
end;

function PrepXRefPos(Index: Integer): String;
begin
  Result := StringOfChar('0',  10 - Length(IntToStr(Index))) + IntToStr(Index)
end;

function CryptStream(Source: TStream; Target: TStream; Key: AnsiString; id: Integer): AnsiString;
var
  s: AnsiString;
  k: array [ 1..21 ] of Byte;
  rc4: TfrxRC4;
  m1, m2: TMemoryStream;
begin
  FillChar(k, 21, 0);
  Move(Key[1], k, 16);
  Move(id, k[17], 3);
  SetLength(s, 16);
  MD5Buf(@k, 21, @s[1]);
  m1 := TMemoryStream.Create;
  m2 := TMemoryStream.Create;
  rc4 := TfrxRC4.Create;
  try
    m1.LoadFromStream(Source);
    m2.SetSize(m1.Size);
    rc4.Start(@s[1], 16);
    rc4.Crypt(m1.Memory, m2.Memory, m1.Size);
    m2.SaveToStream(Target);
  finally
    m1.Free;
    m2.Free;
    rc4.Free;
  end;
end;

procedure AddStyleSimulation(FontName: String; FontStyles: TFontStyles);
begin
  PDFFontSimulationList.AddFont(FontName, FontStyles);
end;

function SimulationlessStyle(Font: TFont): TFontStyles;
var
  Simulation: String;
begin
  Result := Font.Style;
  if IsNeedsItalicSimulation(Font, Simulation) then
    Exclude(Result, fsItalic);
  if IsNeedsBoldSimulation(Font, Simulation) then
    Exclude(Result, fsBold);
end;

procedure DeleteStyleSimulation(FontName: String);
begin
  PDFFontSimulationList.DeleteFont(FontName);
end;

function IsNeedsBoldSimulation(Font: TFont; out Simulation: String): Boolean;
begin
  Result := (fsBold in Font.Style) and
    PDFFontSimulationList.IsNeedsBold(Font.Name);

  if Result then
    Simulation := '2 Tr ' + frFloat2Str(Font.Size / 35.0) + ' w ' +
      Color2Str(Font.Color) + ' RG';
end;

function IsNeedsItalicSimulation(Font: TFont; out Simulation: String): Boolean;
begin
  Result := (fsItalic in Font.Style) and
    PDFFontSimulationList.IsNeedsItalic(Font.Name);

  if Result then
    Simulation := '1 0 0.25 1';
end;

function Color2Str(Color: TColor): String;
var
  RGB: LongInt;
begin
  if Color = clNone then
    Result:= '0 0 0'
  else
  begin
    RGB := ColorToRGB(Color);
    Result:= Float2Str(GetRValue(RGB) / 255) + ' ' +
             Float2Str(GetGValue(RGB) / 255) + ' ' +
             Float2Str(GetBValue(RGB) / 255);
  end;
end;

function frxRect2Str(DR: TfrxRect): String;
begin   // x  y  width  height, with lower-left corner (x, y)
  Result := Float2Str(DR.Left) + ' ' + Float2Str(DR.Bottom) + ' ' +
    Float2Str(DR.Right - DR.Left) + ' ' + Float2Str(DR.Top - DR.Bottom);
end;

function frxPointSum(P1, P2: TfrxPoint): TfrxPoint;
begin
  Result := frxPoint(P1.X + P2.X, P1.Y + P2.Y);
end;

function frxPointMult(P: TfrxPoint; Factor: Extended): TfrxPoint;
begin
  Result := frxPoint(Factor * P.X, Factor * P.Y);
end;

function StrToHex(const Value: WideString): AnsiString;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Value) do
    Result := Result  + AnsiString(IntToHex(Word(Value[i]), 4));
end;

function StrToHexDx(const RS: TRemapedString; pdfDX: TDoubleArray; AverageDx: Boolean): AnsiString;

  function HexLetter(ZeroBasedIndex: Integer): AnsiString;
  begin
    Result := AnsiString(IntToHex(Word(RS.Data[ZeroBasedIndex + 1]), 4));
  end;

var
  Dx: TDoubleArray;
  Len, Count: Integer;

  procedure CalcAverageDx;
  var
    i: Integer;
    Average: Double;
  begin
    Average := 0;
    Count := 0;
    for i := 0 to Len - 1 do
      if not RS.IsSpace[i] then
      begin
        Average := Average + Dx[i];
        Count := Count + 1;
      end;
    if Count > 1 then
    begin
      Average := Average / Count;
      for i := 0 to Len - 1 do
        if not RS.IsSpace[i] then
          Dx[i] := Average;
    end;
  end;

var
  i: Integer;
  Ix: TIntegerDinArray;
  Balance: Double;
begin
  Result := '';

  Len := Length(pdfDx);
  SetLength(Dx, Len);
  for i := 0 to Len - 1 do
    Dx[i] := RS.CharWidth[i] - pdfDx[i];

  if AverageDx then
    CalcAverageDx;

  SetLength(Ix, Len);
  Balance := 0;
  for i := 0 to Len - 1 do
  begin
    Ix[i] := Round(Int(Dx[i]));
    Balance := Balance + Frac(Dx[i]);
    if      Balance > 0.5 then
    begin
      Ix[i] := Ix[i] + 1;
      Balance := Balance - 1;
    end
    else if Balance < -0.5 then
    begin
      Ix[i] := Ix[i] - 1;
      Balance := Balance + 1;
    end
  end;

  for i := 0 to Len - 1 do
  begin
    Result := Result + HexLetter(i);
    if (i < Len - 1) and (Ix[i] <> 0) then
      Result := Result + '>' + AnsiString(IntToStr(Ix[i])) + '<';
  end;
end;

function StrToHexSp(const Value: WideString; SpaceAdjustment: Extended): AnsiString;
var
  i: integer;
  w: Integer;
  z: Extended;
begin
  result := '';
  z := 0;
  w := Trunc(SpaceAdjustment);
  for i := 1 to Length(Value) do
  begin
    result := result + AnsiString(IntToHex(Word(Value[i]), 4));
    if Value[i] = #3 then
    begin
      z := z + Frac(SpaceAdjustment);
      if w + Trunc(z) <> 0 then
        result := result + AnsiString('>' + IntToStr(w + Trunc(z)) + '<');
      z := Frac(z);
    end;
  end;
end;

{ TfrxPDFFont }

constructor TfrxPDFFont.Create(Font: TFont);
begin
  inherited Create(Font);

  Saved := false;
end;

procedure TfrxPDFFont.FillOutlineTextMetrix();
var
  i: Cardinal;
{$IFDEF Linux}
  FPath: String;
  SkipList: TList;
  test: TrueTypeFont;
{$ENDIF}
begin
  GlobalTempBitmap.Canvas.Lock;
  try
    GlobalTempBitmap.Canvas.Font.Assign(SourceFont);
    {$IFNDEF Linux}
    i := GetOutlineTextMetrics(GlobalTempBitmap.Canvas.Handle, 0, nil);
    if i = 0 then
    begin
      GlobalTempBitmap.Canvas.Font.Name := 'Arial';
      i := GetOutlineTextMetrics(GlobalTempBitmap.Canvas.Handle, 0, nil);
    end;
    if i <> 0 then
    begin
      TextMetric := GetMemory(i);
      if TextMetric <> nil then
        GetOutlineTextMetricsA(GlobalTempBitmap.Canvas.Handle, i, TextMetric);
    end;
    {$ELSE}
    FPath := LFonts.GetFontPath(SourceFont, Name);
    try
      FontData.LoadFromFile(FPath);
    except
      raise Exception.Create('Error. Cant load/find font.');
    end;
    FontData.Position := 0;
    TrueTypeTables := TrueTypeCollection.Create();
    TrueTypeTables.Initialize(FontData.Memory, FontDataSize);
    SkipList := Tlist.Create;
    SkipList.Add( Pointer(TablesID.TablesID_EmbedBitmapLocation));
    SkipList.Add( Pointer(TablesID.TablesID_EmbededBitmapData));
    SkipList.Add( Pointer(TablesID.TablesID_HorizontakDeviceMetrix));
    SkipList.Add( Pointer(TablesID.TablesID_VerticalDeviceMetrix));
    SkipList.Add( Pointer(TablesID.TablesID_DigitalSignature));

    for i := 0 to TrueTypeTables.FontCollection.Count - 1 do
    begin
      ttf := TrueTypeFont(TrueTypeTables.FontCollection[i]);
      ttf.PrepareFont( SkipList );
    end;
    SkipList.Free;
    try
      test := TrueTypeTables.Item[Name];
      TextMetric := GetMemory(sizeof(TOUTLINETEXTMETRIC));
      test.GetOutlineTextMetrics(TextMetric);
    except
      raise Exception.Create('Error.Cant get text metric');
    end;
    {$ENDIF}
  finally
    GlobalTempBitmap.Canvas.Unlock;
  end;
end;

function TfrxPDFFont.FontHeightToPointSizeFactor: Double;
begin
  with TextMetric.otmTextMetrics do
    if tmHeight = 0 then
      Result := 1.0
    else
      Result := (tmHeight - tmInternalLeading) / tmHeight;
end;

function TfrxPDFFont.GetFontName: AnsiString;
var
  s: AnsiString;

  function HexEncode7F(Str: AnsiString): AnsiString;
  var
    AnStr: AnsiString;
    s: AnsiString;
    Index, Len: Integer;
  begin
    s := '';
    AnStr := AnsiString(Str);
    Len := Length(AnStr);
    Index := 0;
    while Index < Len do
    begin
      Index := Index + 1;
      if Byte(AnStr[Index]) > $7F then
        s := s + '#' + AnsiString(IntToHex(Byte(AnStr[Index]), 2))
      else
        s := s + AnsiString(AnStr[Index]);
    end;
    Result := s;
  end;

  function IsAnsiName(ws: WideString): Boolean;
  var
    i, len: Integer;
  begin
    Result := False;
    len := Length(ws);
    for i := 1 to len do
      if ord(ws[i]) > 127 then
          exit;
    Result := True;
  end;

begin
{$IFDEF Delphi12}
  if IsAnsiName(SourceFont.Name) then
    Result := AnsiString(SourceFont.Name)
  else if (ttf <> nil) then
    Result := UTF8Encode(ttf.PostScriptName);
  if (ttf <> nil) and (ttf.SubstitutionName <> '') and
     (ttf.FamilyName <> '') and (Pos('?', ttf.FamilyName) = 0) then
    Result :=  UTF8Encode(ttf.FamilyName);
  Result := StringReplace(Result, AnsiString(' '), AnsiString('#20'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('('), AnsiString('#28'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString(')'), AnsiString('#29'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('%'), AnsiString('#25'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('<'), AnsiString('#3C'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('>'), AnsiString('#3E'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('['), AnsiString('#5B'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString(']'), AnsiString('#5D'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('{'), AnsiString('#7B'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('}'), AnsiString('#7D'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('/'), AnsiString('#2F'), [rfReplaceAll]);
{$ELSE}
  Result := SourceFont.Name;
  Result := StringReplace(Result, ' ', '#20', [rfReplaceAll]);
  Result := StringReplace(Result, '(', '#28', [rfReplaceAll]);
  Result := StringReplace(Result, ')', '#29', [rfReplaceAll]);
  Result := StringReplace(Result, '%', '#25', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '#3C', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '#3E', [rfReplaceAll]);
  Result := StringReplace(Result, '[', '#5B', [rfReplaceAll]);
  Result := StringReplace(Result, ']', '#5D', [rfReplaceAll]);
  Result := StringReplace(Result, '{', '#7B', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '#7D', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '#2F', [rfReplaceAll]);
{$ENDIF}
  s := '';
  if (fsBold in SourceFont.Style) and
    not PDFFontSimulationList.IsNeedsBold(SourceFont.Name) then
    s := s + 'Bold';
  if (fsItalic in SourceFont.Style) and
    not PDFFontSimulationList.IsNeedsItalic(SourceFont.Name) then
    s := s + 'Italic';
  if s <> '' then
    Result := Result + ',' + s;
  Result := HexEncode7F(Result);
end;

procedure TfrxPDFFont.PackTTFFont;
var
  i, j: Integer;
  packed_font: frxTrueTypeFont.TByteArray;
begin
  packed_font := nil;
  if (ttf <> nil) and Self.PackFont then
  begin
    packed_font := Self.TrueTypeTables.PackFont( ttf {Self.SourceFont}, Self.UsedAlphabet );
    if packed_font <> nil then
    begin
      {$IFDEF Linux}
      FontData.SetSize(Length(packed_font));
      CopyMemory( FontData.Memory^, packed_font[0], Length(packed_font));
      FontData.SetSize(Length(packed_font));
      {$ELSE}
      FontDataSize := Length(packed_font);
      CopyMemory( FontData, packed_font, FontDataSize);

      for i := 0 to UsedAlphabet.Count - 1 do
        if (Word(UsedAlphabetUnicode[i]) <> $20) and
           (Word(UsedAlphabetUnicode[i]) <> $A0) then
        begin
          j := Integer(UsedAlphabet[i]);
          try
            { dont use values from table for ligatures }
            if Widths[i] <> Pointer(-1) then
            begin
              j := ttf.Width[j];
              Widths[i] := Pointer(j)
            end;
          except
            Widths[i] := Pointer(0);
          end;
        end;
      {$ENDIF}
    end;
  end;
end;

function TfrxPDFFont.SpaceAdjustment(RS: TRemapedString; TextWidth, FontSize: Extended): Extended;
var
  TotalAjustment: Extended;
begin
  TotalAjustment := RS.Width;
  if FontSize <> 0 then
    TotalAjustment := TotalAjustment - TextWidth * 1000 / FontSize;

  Result := TotalAjustment / RS.SpacesCount;
end;

procedure TfrxPDFFont.Update(const SourcePDFFont: TfrxPDFFont; const SourceFont: TFont);
begin
  FontName := SourcePDFFont.Name;
  Size := PDFFontSize(SourceFont);
  Color := IfColor(SourceFont.Color <> clNone, SourceFont.Color, clBlack);
end;

{ TPDFObjectsHelper }

procedure TPDFObjectsHelper.AddUsedObject(Index: integer);
begin
  SetLength(FUsedXObjects, Length(FUsedXObjects) + 1);
  FUsedXObjects[High(FUsedXObjects)] := Index;
end;

function TPDFObjectsHelper.AddXObject(Id: Integer; const Hash: TfrxPDFXObjectHash): Integer;
const DefGrowCapavity: Integer = 32;
var
  NewSize: Integer;
begin
  Inc(FXObjectsCount);
  if High(FXObjects) + 1 < FXObjectsCount then
  begin
    NewSize := High(FXObjects) + 1;
    if FXObjectsCount > DefGrowCapavity then
      NewSize := NewSize + DefGrowCapavity
    else
      if NewSize < 1 then
        NewSize := 4
    else
      NewSize := NewSize + NewSize div 2;
    SetLength(FXObjects, NewSize);
  end;
  FXObjects[FXObjectsCount - 1].ObjId := Id;
  Move(Hash, FXObjects[FXObjectsCount - 1].Hash, SizeOf(Hash));
  Result := FXObjectsCount - 1;
end;

procedure TPDFObjectsHelper.Clear;
var
  i: Integer;
begin
  for i := 0 to FFonts.Count - 1 do
    Fonts[i].Free;

  FFonts.Clear;
  FPageFonts.Clear;
  FAcroFonts.Clear;
  FBBoxFonts.Clear;
  FXRef.Clear;
end;

procedure TPDFObjectsHelper.ClearUsedXObjects;
begin
  SetLength(FUsedXObjects, 0);
end;

procedure TPDFObjectsHelper.ClearXObject;
begin
  SetLength(FXObjects, 0);
  FXObjectsCount := 0;
end;

constructor TPDFObjectsHelper.Create;
begin
  FFonts := TList.Create;
  FPageFonts := TList.Create;
  FXRef := TStringList.Create;
  FAcroFonts := TList.Create;
  FBBoxFonts := TList.Create;
  Protection := False;
  EmbeddedFonts := False;
  EncKey := '';
  FXObjectsCount := 0;
end;

destructor TPDFObjectsHelper.Destroy;
begin
  Clear;
  FFonts.Free;
  FAcroFonts.Free;
  FBBoxFonts.Free;
  FPageFonts.Free;
  FXRef.Free;
  inherited;
end;

procedure TPDFObjectsHelper.EndBBox;
begin
  FIsBBoxReleative := False;
  FBBoxFonts.Clear;
end;

function TPDFObjectsHelper.FindXObject(const Hash: TfrxPDFXObjectHash): Integer;
begin
  for Result := 0 to FXObjectsCount - 1 do
    if CompareMem(@Hash, @FXObjects[Result].Hash, SizeOf(Hash)) then
    begin
      FLastRequestedXRef := FXObjects[Result].ObjId;
      Exit;
    end;
  Result := -1;
end;

function TPDFObjectsHelper.GetAcroFont(const Font: TFont): TfrxPDFFont;
var
  i: Integer;
  OSFontName: String;
begin
  OSFontName := GetOSFontName(Font);
  i := 0;
  while i < FAcroFonts.Count do
    if IsFontNameAndStyle(AcroFonts[i].SourceFont, OSFontName, Font.Style) then
      Break
    else
      Inc(i);
  if i < FAcroFonts.Count then
    Result := AcroFonts[i]
  else
  begin
    Result := GetGlobalFont(Font, OSFontName);
    FAcroFonts.Add(Result);
  end;
end;

function TPDFObjectsHelper.GetAcroFonts(Index: integer): TfrxPDFFont;
begin
  Result := TfrxPDFFont(FAcroFonts[Index]);
end;

function TPDFObjectsHelper.GetAcroFontsCount: integer;
begin
  Result := FAcroFonts.Count;
end;

function TPDFObjectsHelper.GetBBoxFonts(Index: integer): TfrxPDFFont;
begin
  Result := TfrxPDFFont(FBBoxFonts[Index]);
end;

function TPDFObjectsHelper.GetBBoxFontsCount: Integer;
begin
  Result := FBBoxFonts.Count;
end;

function TPDFObjectsHelper.GetFonts(Index: integer): TfrxPDFFont;
begin
  Result := TfrxPDFFont(FFonts[Index]);
end;

function TPDFObjectsHelper.GetFontsCount: integer;
begin
  Result := FFonts.Count;
end;

function TPDFObjectsHelper.GetGlobalFont(const Font: TFont; const OSFontName: String): TfrxPDFFont;
var
  i: Integer;
begin
  i := 0;
  while i < FFonts.Count do
    if IsFontNameAndStyle(Fonts[i].SourceFont, OSFontName, Font.Style) then
      Break
    else
      Inc(i);
  if i < FFonts.Count then
    result := Fonts[i]
  else
  begin
    result := TfrxPDFFont.Create(Font);
    {$IFDEF Linux}
    result.Name := OSFontName;
    result.SourceFont.Name := OSFontName;
    {$ENDIF}
    result.FillOutlineTextMetrix();
    FFonts.Add(result);

    result.Name := AnsiString('/F' + IntToStr(FFonts.Count - 1));
  end;
end;

function TPDFObjectsHelper.GetLastObjectXRefID: Integer;
begin
  Result := FLastRequestedXRef;
end;

function TPDFObjectsHelper.GetObjFontNumber(const Font: TFont): integer;
var
  i: Integer;
  OldStyle, NewStyle: TFontStyles;
  OSFontName: String;
  AFont: TfrxPDFFont;
begin
  NewStyle := SimulationlessStyle(Font);
  OSFontName := GetOSFontName(Font);
  i := 0;
  while i < FFonts.Count do
    if IsFontNameAndStyle(PageFonts[i].SourceFont, OSFontName, NewStyle) then
      Break
    else
      Inc(i);
  if i < FPageFonts.Count then
    result := i
  else
  begin
    OldStyle := Font.Style;
    Font.Style := NewStyle;
    FPageFonts.Add(GetGlobalFont(Font, OSFontName));
    Font.Style := OldStyle;
    result := FPageFonts.Count - 1;
  end;

  if FIsBBoxReleative then
  begin
    AFont := GetAcroFont(Font);
    i := FBBoxFonts.IndexOf(AFont);
    if i < 0 then
    begin
      AFont.Update(AFont, Font);
      FBBoxFonts.Add(AFont);
      if not AFont.Saved then
      begin
        AFont.Reference := UpdateXRef;
        AFont.Saved := True;
      end;
    end;
  end;
end;

function TPDFObjectsHelper.GetOSFontName(const Font: TFont): String;
begin
  {$IFDEF Linux}
  Result := LFonts.GetFontName(Font);
  {$ELSE}
  Result := Font.Name;
  {$ENDIF}
end;

function TPDFObjectsHelper.GetPageFonts(Index: integer): TfrxPDFFont;
begin
  Result := TfrxPDFFont(FPageFonts[Index]);
end;

function TPDFObjectsHelper.GetPageFontsCount: integer;
begin
  Result := FPageFonts.Count;
end;

function TPDFObjectsHelper.GetXObjectsId(Index: integer): Integer;
begin
  Result := FXObjects[Index].ObjId;
end;

function TPDFObjectsHelper.IsFontNameAndStyle(const Font: TFont; Name: String; Style: TFontStyles): Boolean;
begin
  Result := (Font.Name = Name) and (Font.Style = Style);
end;

function TPDFObjectsHelper.OutTransparentPNG(PNGA: TPNGObject; Size: TSize): Integer;
var
  TempBitmap: TBitmap;
  TBRect: TRect;
  XMaskId:    Integer;
  MaskBytes: TMaskArray;
  Jpg: TJPEGImage;
  XObjectStream: TStream;
  XObjectHash: TfrxPDFXObjectHash;
  PicIndex: Integer;
begin
  TempBitmap := CreateBitmap(pf32bit, Size.cx, Size.cy);
  try
    TBRect := Rect(0, 0, TempBitmap.Width, TempBitmap.Height);

    TempBitmap.Canvas.Lock;
    try
      TempBitmap.Canvas.FillRect(TBRect); // Any Brush.Color
      TempBitmap.Canvas.StretchDraw(TBRect, {$IFDEF FPC}PNGA.Picture.Graphic{$ELSE}PNGA{$ENDIF});
    finally
      TempBitmap.Canvas.Unlock;
    end;

    CreateMask(TempBitmap, MaskBytes);

    { Write XObject with a picture inside }
    Jpg := TJPEGImage.Create;
    try
      Jpg.PixelFormat := {$IFDEF FPC}pf24Bit{$ELSE}jf24Bit{$ENDIF};
      Jpg.CompressionQuality := FQuality;

      Jpg.Assign(TempBitmap);
      XObjectStream := TMemoryStream.Create;
      try
        Jpg.SaveToStream(XObjectStream);
        SaveMask(FpdfStream, XObjectStream, MaskBytes,
                 Self, TempBitmap, FProtection, FEncKey,
                 XObjectHash, XMaskId, PicIndex);
        if PicIndex = -1 then
          PicIndex := OutXObjectImage(XObjectHash, Jpg, XObjectStream, True, XMaskId);
      finally
        XObjectStream.Free;
      end;
    finally
      Jpg.Free;
      SetLength(MaskBytes, 0);
    end;
  finally
    TempBitmap.Free;
  end;

  Result := PicIndex;
end;

procedure TPDFObjectsHelper.OutUsedXObjects;
var
  i: integer;
begin
  if Length(FUsedXObjects) > 0 then
  begin
    Write(FpdfStream, '/XObject << ');

    for i := 0 to High(FUsedXObjects) do
    begin
      Write(FpdfStream, '/Im' + IntToStr(FUsedXObjects[i]) + ' ');
      Write(FpdfStream, ObjNumberRef(FXObjects[FUsedXObjects[i]].ObjId) + ' ');
    end;

    Writeln(FpdfStream, '>>');
  end;

end;

function TPDFObjectsHelper.OutXObjectImage(XObjectHash: TfrxPDFXObjectHash;
  Jpg: TJPEGImage; XObjectStream: TStream;
  IsTransparent: Boolean = False; MaskId: Integer = 0): Integer;
var
  XObjectId: Integer;
begin
  XObjectId := UpdateXRef;
  Result := AddXObject(XObjectId, XObjectHash);

  Writeln(FpdfStream, ObjNumber(XObjectId));
  Writeln(FpdfStream, '<<');
  Writeln(FpdfStream, '/Type /XObject');
  Writeln(FpdfStream, '/Subtype /Image');
  Writeln(FpdfStream, '/ColorSpace /DeviceRGB');
  Writeln(FpdfStream, '/BitsPerComponent 8');
  Writeln(FpdfStream, '/Filter /DCTDecode');
  Writeln(FpdfStream, '/Width ' + IntToStr(Jpg.Width));
  Writeln(FpdfStream, '/Height ' + IntToStr(Jpg.Height));

  if IsTransparent then
     WriteLn(FpdfStream, '/SMask ' + ObjNumberRef(MaskId));

  ///// NEED TO REPLACE

  Writeln(FpdfStream, '/Length ' + IntToStr(XObjectStream.Size));
  Writeln(FpdfStream, '>>');

  WriteLn(FpdfStream, 'stream'); // 'stream'#10 is also valid
  XObjectStream.Position := 0;
  if FProtection then
    CryptStream(XObjectStream, FpdfStream, FEncKey, XObjectId)
  else
    FpdfStream.CopyFrom(XObjectStream, 0);
  WriteLn(FpdfStream, '');
  WriteLn(FpdfStream, 'endstream');
  WriteLn(FpdfStream, 'endobj');
end;

procedure TPDFObjectsHelper.StartBBox;
begin
  FIsBBoxReleative := True;
end;

function TPDFObjectsHelper.UpdateXRef: Integer;
begin
  FXRef.Add(PrepXrefPos(FpdfStream.Position));
  Result := FXRef.Count;
  FLastRequestedXRef := Result;
end;

{ TPDFFontSimulation }

procedure TPDFFontSimulation.AddStyles(FontStyles: TFontStyles);
begin
  FFontStyles := FFontStyles + FontStyles;
end;

constructor TPDFFontSimulation.Create(Name: String; FontStyles: TFontStyles);
begin
  FName := Name;
  FFontStyles := FontStyles;
end;

function TPDFFontSimulation.IsName(Name: String): Boolean;
begin
  Result := FName = Name;
end;

function TPDFFontSimulation.IsStyle(FontStyle: TFontStyle): Boolean;
begin
  Result := FFontStyles * [FontStyle] <> [];
end;

{ TPDFFontSimulationList }

procedure TPDFFontSimulationList.AddFont(Name: String; FontStyles: TFontStyles);
var
  PDFFontSimulation: TPDFFontSimulation;
begin
  if FontStyles <> [] then
  begin
    PDFFontSimulation := Find(Name);
    if PDFFontSimulation <> nil then
      PDFFontSimulation.AddStyles(FontStyles)
    else
      Add(TPDFFontSimulation.Create(Name, FontStyles));
  end;
end;

procedure TPDFFontSimulationList.DeleteFont(Name: String);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if TPDFFontSimulation(Items[i]).IsName(Name) then
    begin
      Delete(i);
      Break;
    end;
end;

function TPDFFontSimulationList.Find(Name: String): TPDFFontSimulation;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TPDFFontSimulation(Items[i]).IsName(Name) then
    begin
      Result := TPDFFontSimulation(Items[i]);
      Break;
    end;
end;

function TPDFFontSimulationList.IsNeedsBold(Name: String): Boolean;
begin
  Result := IsNeedsStyle(Name, fsBold);
end;

function TPDFFontSimulationList.IsNeedsItalic(Name: String): Boolean;
begin
  Result := IsNeedsStyle(Name, fsItalic);
end;

function TPDFFontSimulationList.IsNeedsStyle(Name: String; FontStyle: TFontStyle): Boolean;
var
  PDFFontSimulation: TPDFFontSimulation;
begin
  PDFFontSimulation := Find(Name);
  Result := (PDFFontSimulation <> nil) and PDFFontSimulation.IsStyle(FontStyle);
end;

{$IFDEF Linux}
function TfrxPDFFont.GetFontDataSize(): Longint;
begin
  if FontData <> nil then
    Result := FontData.Size
  else
    Result := 0;
end;
{$ENDIF}

{ TPDFFontCorrection }

constructor TPDFFontCorrection.Create;
var
  i: Integer;
begin
  for i := Low(FCorrection) to High(FCorrection) do
    FCorrection[i] := 1;
end;

function TPDFFontCorrection.GetCorrection(Index: Integer): Double;
begin
  if Index in [Low(FCorrection)..High(FCorrection)] then
    Result := FCorrection[Index]
  else
    Result := 1;
end;

procedure TPDFFontCorrection.SetCorrection(Index: Integer; const Value: Double);
begin
  if Index in [Low(FCorrection)..High(FCorrection)] then
    FCorrection[Index] := Value;
end;

{ TPDFFontCorrectionList }

procedure TPDFFontCorrectionList.AddCorrection(FontName: TFontName; FontSize: Integer; Factor: Double);
var
  Index: Integer;
begin
  if not Find(FontName, Index) then
  begin
    Index := Add(FontName);
    Objects[Index] := TPDFFontCorrection.Create;
  end;

  TPDFFontCorrection(Objects[Index]).Correction[FontSize] := Factor;
end;

constructor TPDFFontCorrectionList.Create;
begin
  inherited Create;
  CaseSensitive := False;
  Duplicates := dupIgnore;
  Sorted := True;
end;

{ TInt64Object }

type
  TInt64Object = class
  public
    Value: Int64;
  end;

{ TInt64List }

procedure TInt64List.Add(Value: Int64);
begin
  Setitem(FObjectList.Add(TInt64Object.Create), Value);
end;

procedure TInt64List.Clear;
begin
  FObjectList.Clear;
end;

constructor TInt64List.Create;
begin
  FObjectList := TObjectList.Create;
  FObjectList.OwnsObjects := True;
end;

destructor TInt64List.Destroy;
begin
  FObjectList.Free;
  inherited;
end;

function TInt64List.GetCount: Integer;
begin
  Result := FObjectList.Count;
end;

function TInt64List.GetItem(Index: integer): Int64;
begin
  Result := TInt64Object(FObjectList[Index]).Value;
end;

procedure TInt64List.Setitem(Index: integer; const Value: Int64);
begin
  TInt64Object(FObjectList[Index]).Value := Value;
end;

procedure TPDFFontCorrectionList.DeleteCorrection(FontName: TFontName);
var
  Index: Integer;
begin
  if Find(FontName, Index) then
  begin
    Objects[Index].Free;
    Delete(Index);
  end;
end;

destructor TPDFFontCorrectionList.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Objects[Index].Free;

  inherited;
end;

function TPDFFontCorrectionList.GetCorrection(FontName: TFontName; FontSize: Integer): Double;
var
  Index: Integer;
begin
  if Find(FontName, Index) then
    Result := TPDFFontCorrection(Objects[Index]).Correction[FontSize]
  else
    Result := 1;
end;

initialization

  EnableTpPtCorrection;

  PDFFontSimulationList := TPDFFontSimulationList.Create;
  AddStyleSimulation(#$FF2D#$FF33#$0020#$30B4#$30B7#$30C3#$30AF, [fsBold, fsItalic]);
  AddStyleSimulation(#$FF2D#$FF33#$0020#$FF30#$30B4#$30B7#$30C3#$30AF, [fsBold, fsItalic]);
  AddStyleSimulation(#$FF2D#$FF33#$0020#$660E#$671D, [fsBold, fsItalic]);
  AddStyleSimulation(#$FF2D#$FF33#$0020#$FF30#$660E#$671D, [fsBold, fsItalic]);
  AddStyleSimulation('MS UI Gothic', [fsBold, fsItalic]);
  AddStyleSimulation('Arial Black', [fsBold, fsItalic]);
  AddStyleSimulation('Tahoma', [fsItalic]);

  PDFFontCorrectionList := TPDFFontCorrectionList.Create;
  StretchFont('Consolas',  6, 0.986); StretchFont('Consolas',  7, 1.002);
  StretchFont('Consolas',  8, 1.012); StretchFont('Consolas',  9, 0.997);
  StretchFont('Consolas', 10, 1.008); StretchFont('Consolas', 11, 1.016);
  StretchFont('Consolas', 12, 1.002); StretchFont('Consolas', 13, 0.994);
  StretchFont('Consolas', 14, 1.002); StretchFont('Consolas', 15, 1.007);

  StretchFont('Courier New',  6, 1.004); StretchFont('Courier New',  7, 1.005);
  StretchFont('Courier New',  8, 1.002); StretchFont('Courier New',  9, 1.003);
  StretchFont('Courier New', 10, 1.004); StretchFont('Courier New', 11, 1.002);
  StretchFont('Courier New', 12, 1.004); StretchFont('Courier New', 13, 1.004);
  StretchFont('Courier New', 14, 1.004); StretchFont('Courier New', 15, 1.003);

  StretchFont('Lucida Console',  8, 0.998); StretchFont('Lucida Console',  9, 0.998);
  StretchFont('Lucida Console', 10, 0.998); StretchFont('Lucida Console', 11, 0.998);
  StretchFont('Lucida Console', 12, 0.999); StretchFont('Lucida Console', 13, 0.999);
  StretchFont('Lucida Console', 14, 1.000); StretchFont('Lucida Console', 15, 0.998);

finalization

  PDFFontSimulationList.Free;
  PDFFontCorrectionList.Free;

end.

