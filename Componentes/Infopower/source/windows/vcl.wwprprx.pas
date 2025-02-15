{
//
// Components : TwwEditPictureForm - Design time
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit vcl.wwprprx;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, wwdblook, StdCtrls, DB,
//  DBTables, Wwtable, Wwdatsrc, Wwdbdlg, wwidlg,
  Mask, Wwdbedit, Wwdotdot, wwdbigrd, Buttons, ExtCtrls,
  wwpicdb, Grids, Wwdbgrid, inifiles, registry, wwedtpic, ipdsgn, Wwintl;

type
  TwwEditRegexForm = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    PictureDescription: TMemo;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    wwPictureEdit1: TwwDBEdit;
    Label1: TLabel;
    Button3: TButton;
    Status: TPanel;
    AutoFill: TCheckBox;
    Button4: TButton;
    NewPicture: TwwDBComboDlg;
    wwIntl1: TwwIntl;
    procedure NewPictureChange(Sender: TObject);
    procedure wwPictureEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AutoFillClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewPictureCustomDlg(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NewPictureExit(Sender: TObject);
  private
    Component: TCustomEdit;
    OrigRegexMask: string;
    OrigCaseSensitive: boolean;
//    ini: TIniFile;

    procedure RefreshDescription;
//    Function CreateNewPicture(ALookupTable: TTable): boolean;

  public
    { Public declarations }
  end;

var
  wwEditRegexForm: TwwEditRegexForm;

Function wwPrpEdit_RegexMask(AComponent: TwwCustomMaskEdit): boolean;
//Function wwPrpEdit_RegexMaskGen(AComponent: TCustomEdit): boolean;

implementation

{$R *.DFM}

uses wwcommon, wwlocate;

Function wwPrpEdit_RegexMask(AComponent: TwwCustomMaskEdit): boolean;
begin
    result:= False;
    with TwwEditRegexForm.create(Application) do try
       Component:=AComponent;
       OrigRegexMask:= AComponent.RegexMask.Mask;
       OrigCaseSensitive:= AComponent.RegexMask.CaseSensitive;
       if ShowModal=mrOK then begin
          AComponent.RegexMask.Mask:= NewPicture.text;
          AComponent.RegexMask.CaseSensitive:= AutoFill.checked;
          result:= True;
       end
    finally
       Free;
    end;
end;
{
Function wwPrpEdit_RegexMaskGen(AComponent: TCustomEdit): boolean;
begin
    result:= False;
    with TwwEditRegexForm.create(Application) do try
       Component:=AComponent;
       OrigPictureMask:= wwGetControlRegexMask(AComponent);
       OrigCaseSenstive:= wwGetControlCaseSenstive(AComponent);

       if ShowModal=mrOK then begin
          wwSetControlRegexMask(AComponent, NewPicture.text);
          wwSetControlCaseSensitive(AComponent, AutoFill.checked);
          result:= True;
       end
    finally
       Free;
    end;
end;
 }

procedure TwwEditRegexForm.NewPictureChange(Sender: TObject);
begin
   wwPictureEdit1.RegexMask.Mask:= NewPicture.Text;
end;

procedure TwwEditRegexForm.wwPictureEdit1Change(Sender: TObject);
begin
   if wwPictureEdit1.isValidRegexValue(wwPictureEdit1.text) then
      Status.caption:= 'Value is valid'
   else Status.caption:= 'Regular Expression does not accept value';
end;

procedure TwwEditRegexForm.Button1Click(Sender: TObject);
begin
   if not wwPictureEdit1.IsValidRegexMask(NewPicture.text) then
      Status.caption:= 'Invalid Regular Expression Syntax'
   else Status.caption:= 'Regular Expression is valid';
end;

procedure TwwEditRegexForm.FormShow(Sender: TObject);
begin
   if Component<>Nil then begin
      NewPicture.text:= OrigRegexMask;
      AutoFill.checked:= OrigCaseSensitive;
   end;

   RefreshDescription;
end;

procedure TwwEditRegexForm.Button2Click(Sender: TObject);
begin
   if Component<>Nil then begin
      NewPicture.text:= OrigRegexMask;
      AutoFill.checked:= OrigCaseSensitive;
   end
end;

procedure TwwEditRegexForm.AutoFillClick(Sender: TObject);
begin
   wwPictureEdit1.RegexMask.CaseSensitive:= AutoFill.checked;
end;

procedure TwwEditRegexForm.Button3Click(Sender: TObject);
begin
   if wwPictureEdit1.isValidRegexValue(wwPictureEdit1.text) then
      Status.caption:= 'Value is valid'
   else Status.caption:= 'Regular Expression does not accept value';
end;

procedure TwwEditRegexForm.Button4Click(Sender: TObject);
var
    Key, Value: string;
begin
   Screen.cursor:= crHourGlass;
   with TwwEditMaskForm.create(Application) do begin
      MaskEdit.Text:= NewPicture.text;
      Description.text:= PictureDescription.Text;

      Screen.cursor:= crDefault;
      if ShowModal = mrOK then
      begin
         PictureDescription.text:= Description.text;
         NewPicture.Text:= MaskEdit.Text;
         Key:= PictureDescription.Text;
         Value:= NewPicture.Text;
         wwVerifyPictureKeyValue(Key,Value);
         IniPict.WriteString('Regex Masks', Key, Value);
      end;
      Free;
   end

end;

procedure TwwEditRegexForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=vk_f1) then wwALinkHelp(Handle, 'Regex_Masks')
end;


procedure TwwEditRegexForm.NewPictureCustomDlg(Sender: TObject);
var
    row: integer;
    masks: TStringList;
    key, value: string;
    mr: TModalResult;
begin
   with TwwPictureDialog.create(self) do begin
     masks:= TStringlist.create;
     IniPict.ReadSectionValues('Regex Masks', masks);
     for row:= 0 to masks.count-1 do begin
        stringgrid1.rowCount:= row+2;
        stringgrid1.cells[0,row+1]:= masks.Names[row];
        stringgrid1.cells[1,row+1]:= masks.values[masks.Names[row]];
        if stringgrid1.cells[1,row+1]=NewPicture.text then
           stringgrid1.row:= row+1;
     end;
     masks.free;

     mr:= ShowModal;

     if MaskChanged then
     begin
        { Strip out characters < 32 Ascii, and the = }
        IniPict.EraseSection('Regex Masks');
        for row:= 1 to StringGrid1.RowCount-1 do begin
          Key:= StringGrid1.Cells[0, row];
          Value:= StringGrid1.Cells[1, row];
          wwVerifyPictureKeyValue(Key,Value);
          IniPict.WriteString('Regex Masks', Key, Value);
        end;
     end;

     if mr=mrok then
     begin
        PictureDescription.text:= StringGrid1.cells[0, StringGrid1.Row];
        NewPicture.Text:= StringGrid1.cells[1, StringGrid1.Row];
        wwPictureEdit1.text:= '';
     end;

     free;
  end;

end;

procedure TwwEditRegexForm.RefreshDescription;
begin
   PictureDescription.Text:= wwIniGetRegexDescription(NewPicture.text);
end;

procedure TwwEditRegexForm.FormDestroy(Sender: TObject);
begin
   IniPict.UpdateFile; //wwClosePictureIni;
end;

procedure TwwEditRegexForm.NewPictureExit(Sender: TObject);
begin
   RefreshDescription;
end;

end.

