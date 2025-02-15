unit vcl.wwinputstring2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, wwintl, wwcommon, db, wwdbdatetimepicker,
  wwsystem;

type
  TwwInputTwoStringForm = class(TForm)
    filtervalue: TwwDBEdit;
    FilterLabel: TLabel;
    FilterLabel2: TLabel;
    FilterDateEdit: TwwDBDateTimePicker;
    filterValue2: TwwDBEdit;
    FieldLabel: TLabel;
    FilterDateEdit2: TwwDBDateTimePicker;
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    OKBtnpressed: boolean;
    Field: TField;
    procedure OKBtnClick(Sender: TObject);
  public
    { Public declarations }
    OKBtn, CancelBtn: TButton;
    constructor Create(AOwner: TComponent); override;
  end;

var
  wwInputTwoStringForm: TwwInputTwoStringForm;

function wwInputTwoStringDialog(AOwner: TComponent; AField: TField;
   fieldCaption: string;
//   ACaption: string; ACaption2: string;
  var value: string; var value2: string): boolean;

implementation

{$R *.dfm}

uses buttons, wwgridfilter;

function UseDateTimePicker(field: TField): boolean;
begin
  result:=  field.DataType in [ftDate, ftDateTime, ftTimeStamp];
end;

function wwInputTwoStringDialog(AOwner: TComponent;
  AField: TField;
  FieldCaption: string;
//  ACaption, ACaption2: string;
  var value: string;
  var value2: string): boolean;
var
  form: TwwInputTwoStringForm;
  ACaption, ACaption2: string;
begin
  form := TwwInputTwoStringForm.Create(AOwner);
  ACaption:= wwInternational.GridTitleMenu.BetweenDialogSmallestCaption;
  ACaption2:= wwInternational.GridTitleMenu.BetweenDialogLargestCaption;
  if ACaption = '' then ACaption := 'Smallest';
  if ACaption2 = '' then ACaption2 := 'Largest';

  with form do begin
    field:= AField;
    fieldLabel.Caption := fieldCaption;
    filtervalue.Text := value;
    filtervalue2.Text := value2;
    FilterLabel.Caption := ACaption;
    FilterLabel2.Caption := ACaption2;

    if UseDateTimePicker(field) then
    begin
       ACaption:= wwInternational.GridTitleMenu.BetweenDialogOldestCaption;
       ACaption2 :=wwInternational.GridTitleMenu.BetweenDialogNewestCaption;
       if ACaption = '' then ACaption := 'Oldest';
       if ACaption2 = '' then ACaption2 := 'Newest';
       FilterLabel.Caption := ACaption;
       FilterLabel2.Caption := ACaption2;

       FilterDateEdit.Visible:=true;
       FilterDateEdit2.Visible:=true;
       filtervalue.Visible:=false;
       filterVAlue2.Visible:=false;
       FilterDateEdit.BoundsRect:= filtervalue.BoundsRect;
       FilterDateEdit2.BoundsRect:= filtervalue2.BoundsRect;

       if (field.DataType in [ftDateTime, ftTimeStamp]) then
       begin
          FilterDateEdit.UnboundDataType:= wwDTEdtDateTime;
          FilterDateEdit2.UnboundDataType:= wwDTEdtDateTime;
       end
       else begin
          FilterDateEdit.UnboundDataType:= wwDTEdtDate;
          FilterDateEdit2.UnboundDataType:= wwDTEdtDate;

       end;

       if (value<>'') then
       begin
          if wwStrToDateTime(value) then
          begin
            FilterDateEdit.DateTime:= StrToDateTime(value);
            FilterDateEdit2.DateTime:= StrToDateTime(value2);
          end
          else begin
            if wwStrToDate(value) then
               FilterDateEdit.DateTime:= StrToDate(value);
            if wwStrToDate(value2) then
               FilterDateEdit2.DateTime:= StrToDate(value2);
          end;
       end;
    end;
    result := form.ShowModal = mrOK;
    if result then
      if UseDateTimePicker(field) then
      begin
         value:= FilterDateEdit.Text;
         value2:= FilterDateEdit2.Text;
      end
      else begin
         value := filtervalue.Text;
         value2:= filtervalue2.Text;
      end;
    free;
  end
end;

{
function wwInputDateDialog(AOwner: TComponent; AField: TField; ACaption: string;
  var value: string): boolean;
var
  form: TwwInputStringForm;
begin
  form := TwwInputStringForm.Create(AOwner);
  with form do begin
    field:= AField;
    filtervalue.Text := value;
    FilterLabel.Caption := ACaption;
    result := form.ShowModal = mrOK;
    if result then
      value := FilterDateEdit.Text;
    free;
  end
end;
}
constructor TwwInputTwoStringForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OKBtnpressed := False;
  OKBtn := TButton(wwCreateCommonButton(Self, bkOK));
  OKBtn.TabOrder := 2;
  OKBtn.OnClick := OKBtnClick;
  CancelBtn := TButton(wwCreateCommonButton(Self, bkCancel));
  CancelBtn.TabOrder := 3;
end;

procedure TwwInputTwoStringForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if ModalResult = mrOK then
   begin
      if UseDateTimePicker(field) then begin
        wwIsValidValue2(Field.DataType, FilterDateEdit.Text);  // Test if value is valid
        wwIsValidValue2(Field.DataType, FilterDateEdit2.Text)  // Test if value is valid
      end
      else begin
        wwIsValidValue2(Field.DataType, filterValue.Text);  // Test if value is valid
        wwIsValidValue2(Field.DataType, filterValue2.Text);  // Test if value is valid
      end
   end;
end;

procedure TwwInputTwoStringForm.FormResize(Sender: TObject);
const
  spacing = 20;
var
//  windowExtra: integer;
//  hasUserButton: boolean;
//  formWidth: integer;
//  labelWidth: integer;
  edit, edit2: TCustomEdit;
begin
//  windowExtra := { Compute size of windows title bar + borders }
//  GetSystemMetrics(SM_CYDLGFRAME) * 2 + GetSystemMetrics(SM_CYCAPTION);

  { Win95 fix }
  // labelWidth:= filterLabel.Canvas.TextWidth(filterLabel.Caption);
  if UseDateTimePicker(field) then
  begin
    edit:= FilterDateEdit;
    edit2:= FilterDateEdit2;
  end
  else begin
    edit:= filtervalue;
    edit2:= filtervalue2;
  end;
  edit.Left := FilterLabel.Left + FilterLabel.Width + 8;
  edit2.Left := edit.Left;

  Self.ClientWidth := edit.Left + filtervalue.Width + 6;
  OKBtn.Top := edit2.Top + edit2.height + 12;
  CancelBtn.Top := edit2.Top + edit2.height + 12;
  OKBtn.Left := edit2.Left + edit2.Width -
    ((OKBtn.Width + spacing) * 2);
  CancelBtn.Left := Self.ClientWidth - CancelBtn.Width - 8; // .Left + filtervalue.Width - ((OKBtn.Width + Spacing) * 1);
  OKBtn.Left := CancelBtn.Left - OKBtn.ClientWidth - 8;
  CancelBtn.visible := True;

  OKBtn.visible := True;

end;

procedure TwwInputTwoStringForm.FormShow(Sender: TObject);
begin
  if wwInternational.GridTitleMenu.BetweenDialogCaption<>'' then
     self.Caption:= wwInternational.GridTitleMenu.BetweenDialogCaption;
  if Assigned(wwInternational.OnInitInfoPowerDialog) then
  begin
     if Owner is TwwFormGridFilterTypes then
        wwInternational.OnInitInfoPowerDialog(TwwFormGridFilterTypes(Owner).Grid, self)
     else
        wwInternational.OnInitInfoPowerDialog(nil, self)
  end;
end;

procedure TwwInputTwoStringForm.OKBtnClick(Sender: TObject);
begin
  // AllowClose:= True;
  OKBtnpressed := True;
end;

end.
