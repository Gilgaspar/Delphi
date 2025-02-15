{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RpRenderBitmap;

interface

uses
  Windows,
  Graphics,
  Classes, SysUtils, RpRenderCanvas, RpDefine;

type
  TRvRenderBitmap = class(TRvRenderCanvas)
  protected
    FBitmap: TBitmap;
    FImageDPI: integer;
    function GetCanvas: TCanvas; override;
    procedure PageBegin; override;
    procedure PageEnd; override;
    function GetXDPI: integer; override;
    function GetYDPI: integer; override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property ImageDPI: integer read FImageDPI write FImageDPI;
  end;

implementation

{ TRvRenderBitmap }

constructor TRvRenderBitmap.Create(AOwner: TComponent);
begin
  inherited;
  DisplayName := 'Windows Bitmap (BMP)';
  FileExtension := '*.bmp';
  FImageDPI := 72;
end;

function TRvRenderBitmap.GetCanvas: TCanvas;
begin
  Result := FBitmap.Canvas;
end;

function TRvRenderBitmap.GetXDPI: integer;
begin
  Result := ImageDPI;
end;

function TRvRenderBitmap.GetYDPI: integer;
begin
  Result := ImageDPI;
end;

procedure TRvRenderBitmap.PageBegin;
begin
  inherited;
  if Assigned(FBitmap) then begin
    FreeAndNil(FBitmap);
  end;
  FBitmap := TBitmap.Create;
  FBitmap.Width := XI2D(PaperWidth);
  FBitmap.Height := YI2D(PaperHeight);
end;

procedure TRvRenderBitmap.PageEnd;
var
  FileName: TFileName;
  Path: string;
  Name: string;
begin
  inherited;
  Path := ExtractFilePath(OutputFileName);
  Name := ExtractFileName(OutputFileName);
  Name := Copy(Name, 1, Pos('.', Name) - 1);
  FileName := Path + Name + IntToStr(Converter.PageNo) + '.bmp';
  if Assigned(ActiveStream) then begin
    FBitmap.SaveToStream(ActiveStream);
  end else begin
    FBitmap.SaveToFile(FileName);
  end;
  NDRStream := nil;
end;

end.