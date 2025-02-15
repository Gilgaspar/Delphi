unit vcl.wwinputstring;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, wwintl, wwcommon, db, wwdbdatetimepicker,
  wwsystem;

type
  TwwInputStringForm = class(TForm)
    filtervalue: TwwDBEdit;
    FilterLabel: TLabel;
    FilterDateEdit: TwwDBDateTimePicker;
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
  wwInputStringForm: TwwInputStringForm;

function wwInputStringDialog(AOwner: TComponent; AField: TField; ACaption: string;
  var value: string): boolean;

implementation

{$R *.dfm}

uses buttons, wwgridfilter;

function UseDateTimePicker(field: TField): boolean;
begin
  result:=  field.DataType in [ftDate, ftDateTime, ftTimeStamp];
end;

function wwInputStringDialog(AOwner: TComponent; AField: TField; ACaption: string;
  var value: string): boolean;
var
  form: TwwInputStringForm;
begin
  form := TwwInputStringForm.Create(AOwner);
  with form do begin
    field:= AField;
    filtervalue.Text := value;
    FilterLabel.Caption := ACaption;

    if UseDateTimePicker(field) then
    begin
       FilterDateEdit.Visible:=true;
       filtervalue.Visible:=false;
       FilterDateEdit.BoundsRect:= filtervalue.BoundsRect;
       if (field.DataType in [ftDateTime, ftTimeStamp]) then
          FilterDateEdit.UnboundDataType:= wwDTEdtDateTime
       else
          FilterDateEdit.UnboundDataType:= wwDTEdtDate;

       if (value<>'') then
       begin
          if wwStrToDateTime(value) then
            FilterDateEdit.DateTime:= StrToDateTime(value)
          else
            FilterDateEdit.DateTime:= StrToDate(value);
       end;
    end;
    result := form.ShowModal = mrOK;
    if result then
      if UseDateTimePicker(field) then
         value:= FilterDateEdit.Text
      else
         value := filtervalue.Text;
    free;
  end
end;

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

constructor TwwInputStringForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OKBtnpressed := False;
  OKBtn := TButton(wwCreateCommonButton(Self, bkOK));
  OKBtn.TabOrder := 1;
  OKBtn.OnClick := OKBtnClick;
  CancelBtn := TButton(wwCreateCommonButton(Self, bkCancel));
  CancelBtn.TabOrder := 2;
end;

procedure TwwInputStringForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if ModalResult = mrOK then
   begin
      if UseDateTimePicker(field) then
        wwIsValidValue2(Field.DataType, FilterDateEdit.Text)  // Test if value is valid
      else
        wwIsValidValue2(Field.DataType, filterValue.Text);  // Test if value is valid
   end;
end;

procedure TwwInputStringForm.FormResize(Sender: TObject);
const
  spacing = 20;
var
  //windowExtra: integer;
  //hasUserButton: boolean;
  //formWidth: integer;
  //labelWidth: integer;
  edit: TCustomEdit;
begin
  //windowExtra := { Compute size of windows title bar + borders }
  //GetSystemMetrics(SM_CYDLGFRAME) * 2 + GetSystemMetrics(SM_CYCAPTION);

  { Win95 fix }
  // labelWidth:= filterLabel.Canvas.TextWidth(filterLabel.Caption);
  if UseDateTimePicker(field) then
    edit:= FilterDateEdit
  else
    edit:= filtervalue;
  edit.Left := FilterLabel.Left + FilterLabel.Width + 8;
  Self.ClientWidth := edit.Left + filtervalue.Width + 6;
  OKBtn.Top := edit.Top + edit.height + 12;
  CancelBtn.Top := edit.Top + edit.height + 12;
  OKBtn.Left := edit.Left + edit.Width -
    ((OKBtn.Width + spacing) * 2);
  CancelBtn.Left := Self.ClientWidth - CancelBtn.Width - 8; // .Left + filtervalue.Width - ((OKBtn.Width + Spacing) * 1);
  OKBtn.Left := CancelBtn.Left - OKBtn.ClientWidth - 8;
  CancelBtn.visible := True;

  OKBtn.visible := True;

end;

procedure TwwInputStringForm.FormShow(Sender: TObject);
begin
  if wwInternational.GridTitleMenu.BetweenDialogCaption<>'' then
     self.Caption:= wwInternational.GridTitleMenu.BetweenDialogCaption;
  if Assigned(wwInternational.OnInitInfoPowerDialog) then
  begin
     if Owner is TwwFormGridFilterTypes then
        wwInternational.OnInitInfoPowerDialog(TwwFormGridFilterTypes(Owner).Grid, self)
     else
        wwInternational.OnInitInfoPowerDialog(nil, self)
  end
end;

procedure TwwInputStringForm.OKBtnClick(Sender: TObject);
begin
  // AllowClose:= True;
  OKBtnpressed := True;
end;

end.
