{ ************************************************************************* }
{ TRaveJPEGImage Rave Component version 1.0                                 }
{ Copyright (c), 1999, Nevrona Designs, all rights reserved                 }
{                                                                           }
{ 02.Jan.2010: Thomas Pfister added the 2010-Rave7.7 support ...            }
{ 2009 adds new GIF and PNG support, so the implementations of              }
{ the supported image formats were consolidated into a new VCLIMG package.  }
{ ************************************************************************* }

unit NDCsJPEG;

interface

uses
  Messages, Windows, Controls, Classes, SysUtils, Graphics,
  RVDefine, RVUtil, RVClass, RPDefine, RPBase, JPEG, RVCsStd;

type
  TRaveJPEGImage = class(TRaveGraphicImage)
  protected
    function CreateGraphic: TGraphic; override;
    function ImageValid: boolean; override;
    procedure PrintImage(Report: TBaseReport; X1, Y1, X2, Y2: TRaveUnits);
      override;
  public
    function ImageName: string; override;
    function ImageFilter: string; override;
  end; { TRaveJPEGImage }

procedure RaveRegister;

implementation

{$IFDEF DESIGNER}
{$R *.RES}
{$ENDIF}

procedure RaveRegister;

begin { RaveRegister }
  RegisterRaveGroup('Standard', 'Standard Components');
  RegisterRaveComponents('Standard', [TRaveJPEGImage]);

  RegisterRaveProperties(TRaveJPEGImage,
    { Beginner } 'Image',
    { Intermediate } 'DataField;DataView;MatchSide',
    { Developer } '',
    { Hidden } '');

  SetPropDesc(TRaveJPEGImage, 'Image', Trans(''));
end; { RaveRegister }

(* ****************************************************************************}
  ( class TFixedJPEGImage
  (**************************************************************************** *)

type
  TFixedJPEGImage = class({$IFDEF CLR} TBitmap {$ELSE} TJPEGImage {$ENDIF})
  protected
    function GetEmpty: boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
  end; { TFixedJPEGImage }

procedure TFixedJPEGImage.Assign(Source: TPersistent);

var
  TempImg: TBitmap;

begin { Assign }
  If not Assigned(Source) then
  begin
    TempImg := TBitmap.Create;
    try
      inherited Assign(TempImg);
    finally
      TempImg.Free;
    end; { tryf }
  end
  else
  begin
    inherited Assign(Source);
  end; { else }
end; { Assign }

function TFixedJPEGImage.GetEmpty: boolean;

begin { GetEmpty }
  Result := (Width = 0);
end; { GetEmpty }

(* ****************************************************************************}
  ( class TRaveJPEGImage
  (**************************************************************************** *)

function TRaveJPEGImage.CreateGraphic: TGraphic;

begin { CreateGraphic }
  Result := TFixedJPEGImage.Create;
end; { CreateGraphic }

function TRaveJPEGImage.ImageValid: boolean;

begin { ImageValid }
  Result := (ActiveImage <> nil) { and (ActiveImage.Width <> 0) }
  and not(ActiveImage as TFixedJPEGImage).Empty;
end; { ImageValid }

procedure TRaveJPEGImage.PrintImage(Report: TBaseReport;
  X1, Y1, X2, Y2: TRaveUnits);
{$IFDEF CLR}
var
  TempImage: System.Drawing.Bitmap;
  Stream: TMemoryStream;
{$ENDIF}
begin { PrintImage }
{$IFDEF CLR}
  Stream := TMemoryStream.Create;
  ActiveImage.SaveToStream(Stream);
  Stream.Position := 0;
  TempImage := System.Drawing.Bitmap(System.Drawing.Bitmap.FromStream
      (TStreamToCLRStream.GetStream(Stream)));
  ActiveImage.Assign(TempImage);
  Report.PrintBitmapRect(X1, Y1, X2, Y2, TBitmap(ActiveImage));
{$ELSE}
  Report.PrintBitmapRect(X1, Y1, X2, Y2, TFixedJPEGImage(ActiveImage).Bitmap);
{$ENDIF}
end; { PrintImage }

function TRaveJPEGImage.ImageName: string;

begin { ImageName }
  Result := 'JPEG Image';
end; { ImageName }

function TRaveJPEGImage.ImageFilter: string;

begin { ImageFilter }
  Result := Trans('JPEG Files (*.jpg;*.jpeg)|*.jpg;*.jpeg');
end; { ImageFilter }

end.
