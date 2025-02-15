{
//
// Components : TwwEditMaskForm - Design time
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit vcl.Wwpicdb;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Wwdbedit,
  //DB, Wwdatsrc, DBTables, Wwtable,
  dialogs;

type
  TwwEditMaskForm = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    MaskEdit: TwwDBEdit;
    Description: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wwEditMaskForm: TwwEditMaskForm;

implementation

{$R *.DFM}

uses wwcommon;

procedure TwwEditMaskForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOK then
  begin
     if Description.Text='' then
     begin
       ShowMessage('Description cannot be blank');
       CanClose:=false;
     end;
     
  end;
end;

procedure TwwEditMaskForm.FormCreate(Sender: TObject);
begin
//   wwOpenPictureDB(PictureTable);
end;

procedure TwwEditMaskForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=vk_f1) then wwALinkHelp(Handle, 'Picture_Masks')
   else if (key=vk_escape) then modalResult:= mrCancel
   else if (key=vk_return) then modalResult:= mrOK;
end;

end.
