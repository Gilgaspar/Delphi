unit QRQRBarcode;

interface
uses Windows, quickrpt, DB, vcl.graphics, classes, controls, QRCtrls, DelphiZXingQRCode_q;


type
  TQRQRBarcode = class(TQRPrintable)
  private
    FBCText : string;
    FBCEncoding : TQRCodeEncoding;
    FBCQuietzone : integer;
  protected
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetExpandedHeight(var newheight : extended ); override;
  published
    property BarcodeText : string read FBCText write FBCText;
    property BarcodeEncoding : TQRCodeEncoding read FBCEncoding write FBCEncoding;
    property QuietZone: integer read FBCQuietzone write FBCQuietzone default 5;
  end;

TQRQRDBBarcode = class(TQRQRBarcode)
  private
    FField : TField;
    FDataSet : TDataSet;
    FDataField : string;
    procedure SetDataField(const Value: string);
    procedure SetDataSet(Value: TDataSet);
  protected
    procedure Print(OfsX, OfsY : integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Prepare; override;
    procedure UnPrepare; override;
  public
    procedure GetFieldString( var DataStr : string); override;
    property Field: TField read FField;
  published
    property DataField: string read FDataField write SetDataField;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property BarcodeEncoding;
    property QuietZone;
end;

implementation
uses qrprntr, forms;


procedure RenderQRBarcode( bcdata : string; bcenc : TQRCodeEncoding; qzone, targx, targy, targwidth, targheight : integer; bcanvas : TCanvas);
var
  QRCode: TDelphiZXingQRCode;
  Row, Column, cellwidth : Integer;
begin
    QRCode := TDelphiZXingQRCode.Create;
    try
      QRCode.Data := bcdata;
      QRCode.Encoding := bcenc;
      QRCode.QuietZone := qzone;
      bcanvas.Brush.Style := bsSolid;
      bcanvas.Brush.Color := clWhite;
      bcanvas.Pen.Color := clWhite;
      bcanvas.Rectangle(targx,targy, targx+targwidth, targy+targheight);
      bcanvas.Brush.Color := clBlack;
      bcanvas.Pen.Color := clBlack;
      if (qrcode.Columns < 1) or (qrcode.Rows<1) then exit;
      if targwidth < targheight  then
            cellwidth := targwidth div qrcode.Columns
      else
            cellwidth := targheight div qrcode.Rows;
      if cellwidth < 2 then exit;
      for Row := 0 to QRCode.Rows - 1 do
      begin
        for Column := 0 to QRCode.Columns - 1 do
        begin
          if (QRCode.IsBlack[Row, Column]) then
            bcanvas.Rectangle( (cellwidth*column)+targx, (cellwidth*row)+targy, (cellwidth*column)+cellwidth+targx, (cellwidth*row)+cellwidth+targy);
        end;
      end;
    finally
      QRCode.Free;
    end;
end;

{ TQRQRBarcode }
constructor TQRQRBarcode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  Width := 105;
  Height := 105;
  FBCText := 'unset';
end;

destructor TQRQRBarcode.Destroy;
begin
  inherited Destroy;
end;

procedure TQRQRDBBarcode.Prepare;
begin
  inherited Prepare;
  FBCText := '';
  if assigned(FDataSet) then
  begin
    FField := DataSet.FindField(FDataField);
    FBCText := FField.AsString;
  end
  else
    FField := nil;
end;

// return value in screen pixels
procedure TQRQRBarcode.GetExpandedHeight(var newheight : extended );
begin
end;

procedure TQRQRDBBarcode.GetFieldString( var DataStr : string);
begin
  FBCText := '';
  if assigned(FDataSet) then
  begin
    FField := DataSet.FindField(FDataField);
    FBCText := FField.AsString;
  end
  else
    FField := nil;
end;

procedure TQRQRDbBarcode.Print(OfsX, OfsY : integer);
var
   bcstr : string;
begin
    GetFieldString(bcstr);
    inherited Print(OfsX, OfsY );
end;


procedure TQRQRBarcode.Print(OfsX, OfsY : integer);
var
   dest : TRect;
   expimg : TQRimage;
   expbmp : vcl.Graphics.TBitmap;
begin
  Dest.Top := QRPrinter.YPos(OfsY + Size.Top);
  Dest.Left := QRPrinter.XPos(OfsX + Size.Left);
  Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left);
  Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top);
  RenderQRBarcode( FBCText, FBCEncoding, FBCQuietzone,dest.Left,dest.Top,dest.Width, dest.height, QRPrinter.canvas);
  if ParentReport.exporting then
  begin
    expbmp := vcl.Graphics.TBitmap.create;
    expbmp.width := width;
    expbmp.height := height;
    expimg := TQRImage.create(self);
    expimg.left := left;
    expimg.top := top;
    expimg.width := width;
    expimg.height := height;
    RenderQRBarcode( FBCText, FBCEncoding, FBCQuietzone,0,0,expbmp.Width, expbmp.height, expbmp.canvas);
    expimg.picture.Assign(expbmp);
    parentreport.ExportFilter.AcceptGraphic(dest.left,dest.top, expimg);
    expimg.free;
    expbmp.free;
  end;
end;

procedure TQRQRDBBarcode.UnPrepare;
begin
  FField := nil;
  inherited UnPrepare;
end;

procedure TQRQRDBBarcode.SetDataSet(Value: TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TQRQRDBBarcode.SetDataField(const Value: string);
begin
  FDataField := Value;
end;

procedure TQRQRBarcode.Paint;
begin
    Inherited Paint;
    if csDesigning in ComponentState then
       RenderQRBarcode( FBCText, FBCEncoding, FBCQuietzone,0,0,Width, height, inherited canvas);
end;

procedure TQRQRDBBarcode.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSet) then
    DataSet := nil;
end;


end.
