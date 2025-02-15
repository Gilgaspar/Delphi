{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RpRenderMetafile;

interface

uses
  Windows,
  Graphics,
  Classes, SysUtils, RpDefine, RpRenderCanvas;

type
  TRvRenderMetafile = class(TRvRenderCanvas)
  protected
    FMetafile: TMetafile;
    FMetafileCanvas: TMetafileCanvas;
    FImageDPI: integer;
    FEnhanced: boolean;
    function GetCanvas: TCanvas; override;
    procedure PageBegin; override;
    procedure PageEnd; override;
    function GetXDPI: integer; override;
    function GetYDPI: integer; override;
    function GetFileExtension: string; override;
    procedure SetEnhanced(Value: boolean);

  public
    constructor Create(AOwner: TComponent); override;

  published
    property ImageDPI: integer read FImageDPI write FImageDPI;
    property Enhanced: boolean read FEnhanced write SetEnhanced;
  end;

implementation

{ TRvRenderBitmap }

constructor TRvRenderMetafile.Create(AOwner: TComponent);
begin
  inherited;
  DisplayName := 'Windows Enhanced Metafile (EMF)';
  FileExtension := '*.emf';
  FImageDPI := 72;
end;

function TRvRenderMetafile.GetCanvas: TCanvas;
begin
  Result := FMetafileCanvas;
end;

function TRvRenderMetafile.GetFileExtension: string;
begin
  if Enhanced then begin
    Result := '*.emf';
  end else begin
    Result := '*.wmf';
  end; { if }
end;

function TRvRenderMetafile.GetXDPI: integer;
begin
  Result := ImageDPI;
end;

function TRvRenderMetafile.GetYDPI: integer;
begin
  Result := ImageDPI;
end;

procedure TRvRenderMetafile.PageBegin;
begin
  inherited;
  FMetafile := TMetafile.Create;
  FMetafile.Enhanced := Enhanced;
  FMetafile.Width := XI2D(PaperWidth);
  FMetafile.Height := YI2D(PaperHeight);
  FMetafileCanvas := TMetafileCanvas.Create(FMetaFile,0);
end;

procedure TRvRenderMetafile.PageEnd;
var
  FileName: TFileName;
  Path: string;
  Name: string;
begin
  inherited;
  Path := ExtractFilePath(OutputFileName);
  Name := ExtractFileName(OutputFileName);
  Name := Copy(Name, 1, Pos('.', Name) - 1);
  FileName := Path + Name + IntToStr(Converter.PageNo) + Copy(FileExtension, 2, 4);

  FreeAndNil(FMetafileCanvas);

  if Assigned(ActiveStream) then begin
    FMetafile.SaveToStream(ActiveStream);
  end else begin
    FMetafile.SaveToFile(FileName);
  end;
  FreeAndNil(FMetafile);
  NDRStream := nil;
end;

procedure TRvRenderMetafile.SetEnhanced(Value: boolean);
begin
  FEnhanced := Value;
  if FEnhanced then begin
    DisplayName := 'Windows Enhanced Metafile (EMF)';
  end else begin
    DisplayName := 'Windows Metafile (WMF)';
  end; { else }
end;

end.