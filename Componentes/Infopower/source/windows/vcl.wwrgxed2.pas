{
//
// Components : TwwEditPictureMaskDlg - Design time
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit vcl.wwrgxed2;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls,
//  wwdblook, Wwdbdlg,
  ExtCtrls, Buttons, DB,
//  DBTables, Wwtable, wwidlg,
  wwdbedit, Mask, Wwdotdot,
  inifiles, registry, wwedtpic, ipdsgn, wwprprx;
  
type
  TwwEditRegexMaskdlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Panel1: TPanel;
    CaseSensitiveCheckbox: TCheckBox;
    RegexDescription: TMemo;
    PictureMaskLabel: TLabel;
    DesignMaskButton: TButton;
    RegexMaskEdit: TwwDBComboDlg;
    RegexErrorMsgEdit: TMemo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DesignMaskButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RegexMaskEditCustomDlg(Sender: TObject);
    procedure RegexMaskEditExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
//    ini: TIniFile;
//    procedure RecreateIniFile;
    procedure RefreshDescription;
//    procedure VerifyKeyValue(var Key, Value: string);
  public
    MyComponent: TwwCustomMaskEdit;
  end;

  Function wwPrpEdit_RegexMask2(AComponent: TwwCustomMaskEdit): boolean;
  //Function wwPrpEdit_RegexMask3(Picture: TwwDBPicture; TempParent: TWinControl): boolean;
  Function wwPrpEdit_RegexMask3(RegexMask: TwwRegexMask; TempParent: TWinControl): boolean;


var
  wwEditRegexMaskdlg: TwwEditRegexMaskdlg;

implementation

{$R *.DFM}
uses wwprppic, wwcommon, 
//    wwdatsrc, 
    wwlocate;

Function wwPrpEdit_RegexMask2(AComponent: TwwCustomMaskEdit): boolean;
var component: TwwCustomMaskEdit;
begin

    result:= False;
    with TwwEditRegexMaskdlg.create(Application) do try
       Component:=AComponent;
       MyComponent:= component;

       if ShowModal=mrOK then begin
          component.RegexMask.Mask:= RegexMaskEdit.text;
          component.RegexMask.CaseSensitive:= CaseSensitiveCheckbox.checked;
          component.RegexMask.ErrorMessage:= RegexErrorMsgEdit.Text;
          result:= True;
       end
    finally
       Free;
    end;
    
end;

Function wwPrpEdit_RegexMask3(RegexMask: TwwRegexMask; TempParent: TWinControl): boolean;
var component: TwwCustomMaskEdit;
begin
   component:= TwwCustomMaskEdit.create(tempParent);
   try
      component.visible:= False;
      component.parent:= TempParent;
      with component.RegexMask do begin
         Mask:= RegexMask.Mask;
         CaseSensitive:= RegexMask.CaseSensitive;
         ErrorMessage:= RegexMask.ErrorMessage;
      end;
      result:= wwPrpEdit_RegexMask(component);
      if result then
      begin
         with component.RegexMask do begin
          RegexMask.Mask:= Mask;
          RegexMask.CaseSensitive:= CaseSensitive;
          RegexMask.ErrorMessage:= ErrorMessage;
         end
      end;
   finally
      component.Free;
   end
end;

procedure TwwEditRegexMaskdlg.FormShow(Sender: TObject);
begin
   self.CaseSensitiveCheckbox.Checked:= MyComponent.RegexMask.CaseSensitive;
   RegexMaskEdit.text:= MyComponent.RegexMask.Mask;
   RegexErrorMsgEdit.Text:= MyComponent.RegexMask.ErrorMessage;

   RefreshDescription;

end;

procedure TwwEditRegexMaskdlg.DesignMaskButtonClick(Sender: TObject);
var component: TwwCustomMaskEdit;
begin
   component:= TwwCustomMaskEdit.create(self);
   with component do begin
      component.visible:= False;
      component.parent:= self;
      with component.RegexMask do begin
         Mask:= RegexMaskEdit.Text;
         CaseSensitive:= CaseSensitiveCheckbox.Checked;
//         AllowInvalidExit:= AllowInvalidCheckbox.checked;
      end;

      if wwPrpEdit_RegexMask(component) then
      begin
         with component.regexmask do begin
            RegexMaskEdit.Text:=Mask;
            CaseSensitiveCheckbox.Checked:= CaseSensitive
            // AllowInvalidCheckbox.checked:= AllowInvalidExit;
         end;
      end;
//      RecreateIniFile;

      Free;
   end
end;
procedure TwwEditRegexMaskdlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=vk_f1) then wwALinkHelp(Handle, 'Picture_Masks')
end;

procedure TwwEditRegexMaskdlg.RegexMaskEditCustomDlg(Sender: TObject);
var
    row: integer;
    masks: TStringList;
    key, value: string;
    mr: TModalResult;
begin
   with TwwPictureDialog.create(self) do begin
     masks:= TStringlist.create;
     iniPict.ReadSectionValues('Regex Masks', masks);
     for row:= 0 to masks.count-1 do begin
        stringgrid1.rowCount:= row+2;
        stringgrid1.cells[0,row+1]:= masks.Names[row];
        stringgrid1.cells[1,row+1]:= masks.values[masks.Names[row]];
        if stringgrid1.cells[1,row+1]=RegexMaskEdit.text then
           stringgrid1.row:= row+1;
     end;
     masks.free;

     mr:= showmodal;

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

     if mr=mrOK then
     begin
        RegexDescription.text:= StringGrid1.cells[0, StringGrid1.Row];
        RegexMaskEdit.Text:= StringGrid1.cells[1, StringGrid1.Row];
     end;

     free;
  end;

end;

procedure TwwEditRegexMaskdlg.RegexMaskEditExit(Sender: TObject);
begin
   RefreshDescription;
end;

procedure TwwEditRegexMaskdlg.RefreshDescription;
begin
   RegexDescription.Text:= wwIniGetRegexDescription(RegexMaskEdit.text);
end;


procedure TwwEditRegexMaskdlg.FormCreate(Sender: TObject);
begin
//   RecreateIniFile;
end;

{procedure TwwEditPictureMaskdlg.RecreateIniFile;
var ipreg: TRegIniFile;
    FileName: string;
begin
   ipreg := TRegIniFile.create('');
   FileName:= ipreg.ReadString('\Software\Woll2Woll\InfoPower', 'Masks IniFile', 'InfoPowerMasks.ini') + '\InfoPowerMasks.ini';
   ipreg.free;
   ini.Free;
   ini:= TIniFile.create(FileName);
end;
}
procedure TwwEditRegexMaskdlg.FormDestroy(Sender: TObject);
begin
//  ini.free;
//  ini:= nil;
//   IniPict.update;
end;
{
procedure TwwEditRegexMaskdlg.VerifyKeyValue(var Key, Value: string);
var i: integer;
    tempValue: string;
begin
   for i:= 1 to length(Key) do
     if (ord(key[i])<32) or (key[i]='=') then key[i]:= ' ';
   tempValue:= '';

   for i:= 1 to length(Value) do
      if not (ord(Value[i])<32) or (Value[i]='=') then tempValue:= tempValue + Value[i];
   Value:= tempValue;
end;

}


end.