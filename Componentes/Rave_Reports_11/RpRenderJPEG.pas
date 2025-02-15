{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RpRenderJPEG;

interface

uses
  Windows,
  Graphics,
  Classes, SysUtils, RpDefine, RpRenderCanvas, JPEG;

type
  TCompressionQualityRange = 1..100;
  TRvRenderJpeg = class(TRvRenderCanvas)
  protected
    FBitmap: TBitmap;
    FJPEG: TJPEGImage;
    FImageDPI: integer;
    FCompressionQuality: TCompressionQualityRange;
    function GetCanvas: TCanvas; override;
    procedure PageBegin; override;
    procedure PageEnd; override;
    function GetXDPI: integer; override;
    function GetYDPI: integer; override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property ImageDPI: integer read FImageDPI write FImageDPI;
    property CompressionQuality: TCompressionQualityRange read FCompressionQuality write FCompressionQuality;
  end;

implementation

{ TRvRenderBitmap }

constructor TRvRenderJpeg.Create(AOwner: TComponent);
begin
  inherited;
  DisplayName := 'JPEG Files (JPG)';
  FileExtension := '*.jpg';
  FImageDPI := 72;
  FCompressionQuality := 90;
end;

function TRvRenderJpeg.GetCanvas: TCanvas;
begin
  Result := FBitmap.Canvas;
end;

function TRvRenderJpeg.GetXDPI: integer;
begin
  Result := ImageDPI;
end;

function TRvRenderJpeg.GetYDPI: integer;
begin
  Result := ImageDPI;
end;

procedure TRvRenderJpeg.PageBegin;
begin
  inherited;
  if Assigned(FBitmap) then begin
    FreeAndNil(FBitmap);
  end;
  FBitmap := TBitmap.Create;
  FBitmap.Width := XI2D(PaperWidth);
  FBitmap.Height := YI2D(PaperHeight);
end;

procedure TRvRenderJpeg.PageEnd;
var
  FileName: TFileName;
  Path: string;
  Name: string;
begin
  inherited;
  Path := ExtractFilePath(OutputFileName);
  Name := ExtractFileName(OutputFileName);
  Name := Copy(Name, 1, Pos('.', Name) - 1);
  FileName := Path + Name + IntToStr(Converter.PageNo) + '.jpg';
  FJPEG := TJPEGImage.Create;
  try
    FJPEG.CompressionQuality := CompressionQuality;
    FJPEG.Assign(FBitmap);
    if Assigned(ActiveStream) then begin
      FJPEG.SaveToStream(ActiveStream);
    end else begin
      FJPEG.SaveToFile(FileName);
    end;
  finally
    FreeAndNil(FJPEG);
    NDRStream := nil;
  end; { tryf }
end;

end.