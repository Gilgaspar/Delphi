{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RpFont;

interface

uses
  Windows, Graphics,
  Classes,
  RpDefine,
  SyncObjs, SysUtils;

const
  BaseSize = 600;

type
  TRPBaseFontHandler = class
  public
    constructor Create(Font: TFont); virtual;
    function TextWidth(Value: string;
                       FontSize: double;
                       DPI: integer): integer; virtual; abstract;
  end; { TRPBaseFontHandler }

  TRPTrueTypeFontHandler = class(TRPBaseFontHandler)
  protected
    FFontTable: array[0..255] of integer;
  public
    constructor Create(Font: TFont); override;
    function TextWidth(Value: string;
                       FontSize: double;
                       DPI: integer): integer; override;
  end; { TRPTrueTypeFontHandler }

  TRPNonProportionalFontHandler = class(TRPBaseFontHandler)
  protected
    FFontWidth: integer;
  public
    constructor Create(Font: TFont); override;
    function TextWidth(Value: string;
                       FontSize: double;
                       DPI: integer): integer; override;
  end; { TRPNonProportionalFontHandler }

  TRPFontManager = class
  protected
    FFontList: TStringList;
    FDPI: integer;

    function FontNameOf(Font: TFont): string;
    function GetFontHandler(Font: TFont): TRPBaseFontHandler;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function TextWidth(Font: TFont;
                       Value: string): integer;
  end; { TRPFontManager }

var
  FontManager: TRPFontManager;

implementation

//uses
//  {Q}RvDefine;

{ class TRPBaseFontHandler }

constructor TRPBaseFontHandler.Create(Font: TFont);
begin { Create }
	inherited Create;
end;  { Create }

{ class TRPTrueTypeFontHandler }

constructor TRPTrueTypeFontHandler.Create(Font: TFont);
var
  ABCTable: array[0..255] of ABC;
  I1: integer;
begin { Create }
  inherited Create(Font);

// Get ABCTable
  with TBitmap.Create do try
    Canvas.Font.Assign(Font);
    Canvas.Font.Height := -BaseSize;
    GetCharABCWidths(Canvas.Handle,0,255,ABCTable);
  finally
    Free;
  end; { with }

// Convert ABCTable to FontTable
  for I1 := 0 to 255 do begin
    FFontTable[I1] := ABCTable[I1].abcA + integer(ABCTable[I1].abcB) + ABCTable[I1].abcC;
  end; { for }
end;  { Create }

function TRPTrueTypeFontHandler.TextWidth(Value: string;
                                          FontSize: double;
                                          DPI: integer): integer;
var
  I1: integer;
  I2: integer;
begin { TextWidth }
  Result := 0;
  for I1 := 1 to Length(Value) do begin
    I2 := Ord(Value[I1]);
    if I2 > 255 then begin
      Result := Result + FFontTable[1];
    end else begin
      Result := Result + FFontTable[Ord(Value[I1])];
    end; { else }
  end; { for }
  Result := Round((Result * FontSize * DPI) / (72 * BaseSize));
end;  { TextWidth }

{ class TRPNonProportionalFontHandler }

constructor TRPNonProportionalFontHandler.Create(Font: TFont);
var
  ABCVal: array[1..1] of ABC;
begin { Create }
  inherited Create(Font);

// Get FFontWidth
  with TBitmap.Create do try
    Canvas.Font.Assign(Font);
    Canvas.Font.Height := -BaseSize;
    GetCharABCWidths(Canvas.Handle,65,65,ABCVal);
    FFontWidth := ABCVal[1].abcA + integer(ABCVal[1].abcB) + ABCVal[1].abcC;
  finally
    Free;
  end; { with }
end;  { Create }

function TRPNonProportionalFontHandler.TextWidth(Value: string;
                                                 FontSize: double;
                                                 DPI: integer): integer;
begin { TextWidth }
  Result := Round((Length(Value) * FFontWidth * FontSize * DPI) / (72 * BaseSize));
end;  { TextWidth }

{ class TRPFontManager }

constructor TRPFontManager.Create;
begin { Create }
  inherited Create;
  FFontList := TStringList.Create;
  FFontList.Sorted := true;
end;  { Create }

destructor TRPFontManager.Destroy;
var
  I1: integer;
begin { Destroy }
  for I1 := 0 to FFontList.Count - 1 do begin
    TRPBaseFontHandler(FFontList.Objects[I1]).Free;
  end; { for }
  FreeAndNil(FFontList);
  inherited Destroy;
end;  { Destroy }

function TRPFontManager.FontNameOf(Font: TFont): string;
begin { FontNameOf }
  Result := Font.Name + '|' + IntToStr(Font.Charset);
  if fsBold in Font.Style then begin
    Result := Result + '|B';
  end; { if }
  if fsItalic in Font.Style then begin
    Result := Result + '|I';
  end; { if }
  case Font.Pitch of
    fpVariable: Result := Result + '|V';
    fpFixed: Result := Result + '|F';
  end; { case }
end;  { FontNameOf }

var
  CS: TCriticalSection;

function TRPFontManager.GetFontHandler(Font: TFont): TRPBaseFontHandler;
var
  Index: integer;
  TM: TextMetric;
begin { GetFontHandler }
// Find FontHandler for current font
// Use a critical section since Index may be invalid if a new font handler is
// inserted into the sorted FFontList between the Find() and the [Index] calls
  CS.Enter;
  try
    if FFontList.Find(FontNameOf(Font),Index) then begin // Found
      Result := TRPBaseFontHandler(FFontList.Objects[Index]);
      Exit;
    end; { if }
  finally
    CS.Leave;
  end; { tryf }

// Create font handler since one wasn't found
  with TBitmap.Create do try
    Canvas.Font.Assign(Font);
    GetTextMetrics(Canvas.Handle,TM);
  finally
    Free;
  end; { with }
  Result := nil;
  try
    if (TMPF_FIXED_PITCH and TM.tmPitchAndFamily) = 0 then begin
      Result := TRPNonProportionalFontHandler.Create(Font);
    end else begin
      Result := TRPTrueTypeFontHandler.Create(Font);
    end; { else }
  finally
    if Assigned(Result) then begin
      FFontList.AddObject(FontNameOf(Font),Result);
    end; { if }
  end; { tryf }
end;  { GetFontHandler }

function TRPFontManager.TextWidth(Font: TFont;
                                  Value: string): integer;
begin { TextWidth }
  if Font.PixelsPerInch = 0 then begin
//    RaveError('Division by 0 would occur. PixelsPerInch is 0');
  end;
  Result := GetFontHandler(Font).TextWidth(Value,
   (72 * Abs(Font.Height)) / Font.PixelsPerInch,Font.PixelsPerInch);
end;  { TextWidth }

initialization
  CS := TCriticalSection.Create;
  FontManager := TRPFontManager.Create;
finalization
  FreeAndNil(FontManager);
  FreeAndNil(CS);
end.
