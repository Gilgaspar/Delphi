unit DBGrade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBClient, Grids, DBGrids, StdCtrls, SimpleDS, extCtrls, strUtils, BuscaRapida;

type
  TOrder=(toNone, toAsc, toDesc);
  TIndexParam=record
    IndexName: String;
    FieldName: String;
    Order: TOrder;
    OrderStr: String;
    IndexCol: Integer;
    Options: TIndexOptions;
  end;

  TDBGrade = class(TDBGrid)
  private
    strAux: String;
    FIndexParam: TIndexParam;
    FBusca: TBuscaRapida;
    FEnabledIndex: Boolean;
    FEnabledBusca: Boolean;
    procedure ClearIndexParam;
    procedure DefineGridIndex(FieldName: String; AOrder: TOrder=toNone);
    procedure DrawColumn(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure setBitMap;
    procedure NextIndex;
    procedure setEnabledBusca(const Value: Boolean);
  protected
    procedure TitleClick(Column: TColumn); override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function OrderToStr(Order: Torder): String;
    function StrToOrder(Order: String): Torder;
  published
    property IndexParam: TIndexParam read FIndexParam;
    property EnabledIndex: Boolean read FEnabledIndex write FEnabledIndex;
    property EnabledBusca: Boolean read FEnabledBusca write setEnabledBusca;
    property BuscaRapida: TBuscaRapida read FBusca write FBusca;
    procedure SetIndex(FieldName: String; AOrder: TOrder=toNone);
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TDBGrade]);
end;

{ TDBGrade }

constructor TDBGrade.Create(AOwner: TComponent);
begin
  inherited;
  FBusca:=TBuscaRapida.Create(Self);
  FBusca.Grid:=Self;
  FBusca.Parent:=Self;
  FBusca.Align:=alBottom;
  FBusca.Transparent:=False;
  FBusca.ParentBiDiMode:=False;
  FBusca.BringToFront;
  FBusca.Visible:=False;

  EnabledIndex:=True;
  ClearIndexParam;
end;

destructor TDBGrade.Destroy;
begin
  FBusca.Free;
  inherited;
end;

function GetColsWidth(Grid: TDBGrid; Index: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Index do
    Result := Result + Grid.Columns.Items[i].Width;
  Result := Result + Index - 1;
end;

procedure TDBGrade.TitleClick(Column: TColumn);
begin
  inherited;
  DefineGridIndex(Column.FieldName);
end;

procedure TDBGrade.SetIndex(FieldName: String; AOrder: TOrder);
begin
  DefineGridIndex(FieldName, AOrder);
end;

procedure TDBGrade.DefineGridIndex(FieldName: String; AOrder: TOrder);
var
  Client: TClientDataSet; i: Integer;
begin
  inherited;

  if FEnabledIndex and (Self.DataSource<>nil) then
  begin
    Client:=TClientDataSet(Self.DataSource.DataSet);

    if FIndexParam.FieldName<>FieldName then begin
       FIndexParam.FieldName:=FieldName;
       FIndexParam.Order:=toNone;
    end;
    if AOrder<>toNone then
       FIndexParam.Order:=AOrder else
    case FIndexParam.Order of //Inverter
      toNone: FIndexParam.Order:=toAsc;
      toAsc:  FIndexParam.Order:=toDesc;
      toDesc: FIndexParam.Order:=toNone;
    end;
    FIndexParam.OrderStr:=OrderToStr(FIndexParam.Order);

    if FIndexParam.Order=toNone then
       ClearIndexParam
    else begin
      if FIndexParam.Order=toAsc then begin
         FIndexParam.IndexName:=FieldName;
         FIndexParam.Options:=[];
      end else begin
         FIndexParam.IndexName:=FieldName+'_desc';
         FIndexParam.Options:=[ixDescending];
      end;
      i:=Client.IndexDefs.IndexOf(FIndexParam.IndexName);
      if i<0 then
         TIndexDef.Create(Client.IndexDefs, FIndexParam.IndexName, FIndexParam.FieldName, FIndexParam.Options);
    end;
    Client.IndexName:=FIndexParam.IndexName;
  //Paint;
    for i := 0 to Self.Columns.Count - 1 do begin
      if(Self.Columns.Items[i].FieldName=FieldName) and (FIndexParam.Order<>toNone) then begin
         Self.Columns.Items[i].Title.Font.Style := [fsBold];
         Self.Columns.Items[i].Title.Color := clSkyBlue;
         FIndexParam.IndexCol:=i;
      end else begin
        Self.Columns.Items[i].Title.Font.Style := [];
        if Self.Columns.Items[i].ReadOnly then
           Self.Columns.Items[i].Title.Color := clSilver else
           Self.Columns.Items[i].Title.Color := clBtnFace;
      end;
    end;
    setBitMap;
  end;
//.....
end;

procedure TDBGrade.DrawColumn(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
end;

procedure TDBGrade.DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if (gdSelected in State) then
  begin
    FBusca.GridDataset:=Self.DataSource.DataSet;
    if(FIndexParam.IndexName<>'') and (FIndexParam.IndexCol=DataCol) then begin
       setBitMap;
    end;
  end;
end;

procedure TDBGrade.ClearIndexParam;
begin
  FIndexParam.IndexName:='';
  FIndexParam.FieldName:='';
  FIndexParam.IndexCol:=-1;
  FIndexParam.Order:=toNone;
  FIndexParam.OrderStr:='toNone';
  FIndexParam.Options:=[];
end;

procedure TDBGrade.setBitMap;
var
  Bmp: TBitmap;
begin
  if(FIndexParam.Order in [toasc, todesc]) then
  begin
    Bmp:=TBitMap.Create;
    try
      Bmp.LoadFromResourceName(HInstance, ifthen(FIndexParam.Order=toDesc, 'SETABAIXO', 'SETACIMA'));
      Self.Canvas.Draw(GetColsWidth(Self, FIndexParam.IndexCol)-Bmp.Width, (Self.RowHeights[0]-Bmp.Height) div 2, Bmp);
    finally
      Bmp.Free;
    end;
  end;
end;

procedure TDBGrade.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F5 then
     NextIndex;
  inherited;
end;

procedure TDBGrade.NextIndex;
var
  i, indice: integer;
begin
  FIndexParam.IndexCol:=FIndexParam.IndexCol+1;
  if FIndexParam.IndexCol>=Self.Columns.Count then
     FIndexParam.IndexCol:=0;
  try
    SetIndex(Self.Columns.Items[FIndexParam.IndexCol].FieldName);
  except
    SetIndex('');
  end;
end;

procedure TDBGrade.setEnabledBusca(const Value: Boolean);
begin
  FEnabledBusca:=Value;
end;

function TDBGrade.OrderToStr(Order: Torder): String;
begin
  case Order of
    toNone: Result:='toNone';
    toAsc : Result:='toAsc';
    toDesc: Result:='toDesc';
  end;
end;

function TDBGrade.StrToOrder(Order: String): Torder;
begin
  Result:=toNone;
  if Order='toAsc'  then Result:=toAsc else
  if Order='toDesc' then Result:=toDesc;
end;

end.