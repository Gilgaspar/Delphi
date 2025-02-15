unit AgrupamentoBox;

interface

uses
  SysUtils, Classes, Controls, StdCtrls;

type
  TGroup = record
    Title: String;
    OrderBy: String;
    IndexFieldNames: String;
    Count: Integer;
    Index: Integer;
  end;

  TGroupClass = Class(Tobject)
    Title: String;
    OrderBy: String;
    IndexFieldNames: String;
  end;

type
  TAgrupamentoBox = class(TComboBox)
  private
    function GetGroup: TGroup;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Group: TGroup  read GetGroup;

    procedure Clear;
    procedure AddGroup(Title, OrderBy, IndexField: String);
    procedure SetGroup(Group: array of TGroup);
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TAgrupamentoBox]);
end;




{ TAgrupamentoBox }

constructor TAgrupamentoBox.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAgrupamentoBox.Destroy;
var
  i: Integer;
begin
  for i := 0 to Items.Count-1 do begin
    if Items.Objects[i] <> nil then
       Items.Objects[i].Free;
  end;

  inherited;
end;

procedure TAgrupamentoBox.Clear;
begin
   items.Clear;
end;

procedure TAgrupamentoBox.AddGroup(Title, OrderBy, IndexField: String);
var
  Item: TGroupClass; strAux: String;
begin
  Item := TGroupClass.Create;
  Item.Title := Title;
  Item.OrderBy := OrderBy;
  Item.IndexFieldNames := IndexField;
  Items.AddObject(Title, Item);
end;

procedure TAgrupamentoBox.SetGroup(Group: Array of TGroup);
var
  i: Integer;
begin
  Clear;
  for i := Low(Group) to High(Group) do begin
    AddGroup(Group[i].Title, Group[i].OrderBy, Group[i].IndexFieldNames);
  end;
end;

function TAgrupamentoBox.GetGroup: TGroup;
begin
  Result.Title := '';
  Result.OrderBy := '';
  Result.IndexFieldNames := '';
  Result.Count := Items.Count;
  Result.Index := ItemIndex;

  if Items.Count > 0 then begin
     Result.Title := TGroupClass(Items.Objects[ItemIndex]).Title;
     Result.OrderBy := TGroupClass(Items.Objects[ItemIndex]).OrderBy;
     Result.IndexFieldNames := TGroupClass(Items.Objects[ItemIndex]).IndexFieldNames;
  end;
end;

end.
