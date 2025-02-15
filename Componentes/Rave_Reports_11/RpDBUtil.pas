{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RpDBUtil;

{$I RpVer.inc}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  SysUtils, Classes, DB, RpDefine, RpMemo;

type
  TDBMemoBuf = class(TMemoBuf)
  protected
    procedure SetMemoField(Value: TMemoField);
    procedure SetRTFMemoField(Value: TMemoField);
  public
    property Field: TMemoField write SetMemoField;
    property RTFField: TMemoField write SetRTFMemoField;
  end; { TDBMemoBuf }

  procedure GraphicFieldToBitmap(GraphicField: TBlobField; Bitmap: TBitmap);

implementation

  procedure TDBMemoBuf.SetMemoField(Value: TMemoField);
  var
    Stream: TMemoryStream;
  begin { SetMemoField }
    Stream := TMemoryStream.Create; { Create temporary stream }
    try
      if not Value.IsBLOB then begin
        Stream.SetSize(Value.DataSize);
	  {$IFDEF LevelXE3}{$WARN SYMBOL_DEPRECATED OFF}{$ENDIF}
        Value.GetData(Stream.Memory);
	  {$IFDEF LevelXE3}{$WARN SYMBOL_DEPRECATED DEFAULT}{$ENDIF}
      end else begin
        (Value as TBlobField).SaveToStream(Stream);
      end; { else }
      SetData(Stream.Memory^,Stream.Size); { Set memo buffer data to stream }
    finally
      Stream.Free; { Free up temporary stream }
    end; { try }
  end;  { SetMemoField }

  procedure TDBMemoBuf.SetRTFMemoField(Value: TMemoField);
  begin { SetRTFMemoField }
    ReadRTF := true;
    SetMemoField(Value);
  end;  { SetRTFMemoField }

  procedure GraphicFieldToBitmap(GraphicField: TBlobField; Bitmap: TBitmap);
  begin { GraphicFieldToBitmap }
    Bitmap.Assign(GraphicField);
  end;  { GraphicFieldToBitmap }

end.