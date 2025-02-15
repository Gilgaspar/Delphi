unit vcl.wwgridselectcolumns;
{
//
// Components : TwwGridSelectColumnsForm
//
// Copyright (c) 2009 by Woll2Woll Software
//
// Description: Define dialog to add columns to the grid
//
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, wwintl, wwcommon, db,
  wwsystem, CheckLst, buttons, grids, ComCtrls, wwgridfilter, wwstr, 
  wwtreeview, wwdbigrd;

type
  TwwGridSelectColumnsForm = class(TForm)
    CheckListBox1: TCheckListBox;
    TreeView1: TwwSelectColumnsTreeView;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    OKBtnpressed: boolean;
    FGrid: TCustomGrid;
    procedure OKBtnClick(Sender: TObject);
    //function GetDataSet: TDataSet;
  public
    { Public declarations }
    OKBtn, CancelBtn: TButton;
    constructor Create(AOwner: TComponent); override;

  end;

var
  wwGridSelectColumnsForm: TwwGridSelectColumnsForm;

//function wwSelectGridColumns(AGrid: TCustomGrid; curField: string): boolean;

implementation

{$R *.dfm}

//uses wwdbigrd;

constructor TwwGridSelectColumnsForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGrid:= AOwner as TCustomGrid;
  OKBtnpressed := False;
  OKBtn := TButton(wwCreateCommonButton(Self, bkOK));
  OKBtn.TabOrder := 1;
  OKBtn.OnClick := OKBtnClick;
  CancelBtn := TButton(wwCreateCommonButton(Self, bkCancel));
  CancelBtn.TabOrder := 2;
end;

procedure TwwGridSelectColumnsForm.FormResize(Sender: TObject);
const
  spacing = 20;
var
  edit: TWinControl;
begin
  edit:= checklistbox1;

  OKBtn.Top := edit.Top + edit.height + 8;
  CancelBtn.Top := edit.Top + edit.height + 8;
  OKBtn.Left := edit.Left + edit.Width -
    ((OKBtn.Width + spacing) * 2);
  CancelBtn.Left := Self.ClientWidth - CancelBtn.Width - 8; // .Left + filtervalue.Width - ((OKBtn.Width + Spacing) * 1);
  OKBtn.Left := CancelBtn.Left - OKBtn.ClientWidth - 8;
  CancelBtn.visible := True;

  OKBtn.visible := True;

end;

procedure TwwGridSelectColumnsForm.FormShow(Sender: TObject);
begin
  if wwInternational.GridTitleMenu.SelectColumnsDialogCaption<>'' then
     self.Caption:= wwInternational.GridTitleMenu.SelectColumnsDialogCaption;
end;

{
function TwwGridSelectColumnsForm.GetDataSet: TDataSet;
var
  //dataset: TDataSet;
  datasource: TDataSource;
begin
  result:=nil;
  datasource := wwGetDatasource(FGrid);
  if datasource = nil then
    exit;
  result := wwGetDataSet(datasource);
end;
}

procedure TwwGridSelectColumnsForm.OKBtnClick(Sender: TObject);
begin
  OKBtnpressed := True;
end;

end.
