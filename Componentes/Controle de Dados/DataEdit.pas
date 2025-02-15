 unit DataEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, Windows;

type
  TDataEdit = class(TCustomMaskEdit)
  private
    { Private declarations }
    FValidaData : Boolean;
    function GetData : String;
    function GetDataSQL : String;
    function GetDateTime: TDate;
    procedure SetValidaData(Valor : Boolean);
    procedure CMExit(var Message : TCMExit); message CM_EXIT;
    procedure setDateTime(const Value: TDate);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    property Data : String read GetData;
    property DataSQL : String read GetDataSQL;
    property asDate : TDate read GetDateTime write setDateTime;
    property ValidaData : Boolean read FValidaData write SetValidaData Default False;
  published
    { Published declarations }
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EditMask;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TDataEdit]);
end;

constructor TDataEdit.Create(AOWner: TComponent);
begin
  Inherited Create(AOWner);
  EditMask := '99/99/9999;1; ';
end;

procedure TDataEdit.CMExit(var Message: TCMExit);
begin
  SetValidaData(True);
  Inherited;
end;

function TDataEdit.GetData : String;
var
  vData : TDate;
begin
  If Text <> '  /  /    ' Then
  begin
    vData  := StrToDate(Text);
    Result := FormatDateTime('yyyy/mm/dd',vData);
  end
  else
    Result := 'NULL';
end;

function TDataEdit.GetDataSQL : String;
var
  vData : TDate;
begin
  If Text <> '  /  /    ' Then
  begin
    vData  := StrToDate(Text);
    Result := ''''+FormatDateTime('yyyy/mm/dd',vData)+'''';
  end
  else
    Result := 'NULL';
end;

procedure TDataEdit.SetValidaData(Valor : Boolean);
var
  vAno,vData : String;
begin
  If Valor Then
  begin
    If Text <> '  /  /    ' Then
    begin
      vData := Text;
      vAno  := Trim(Copy(Text,7,4));
      If Length(Trim(vAno)) = 2 Then
      begin
        Delete(vData,7,4);
        Insert('20'+vAno,vData,7);
        Text := vData;
      end
      else
      If Length(Trim(vAno)) < 4 Then
      begin
        MessageBox(0,'Data Inválida','Erro',MB_OK + MB_ICONSTOP);
        SetFocus;
        Abort;
      end;

      Try
        StrToDate(Text);
      except
      on EConvertError do
        begin
          MessageBox(0,'Data Inválida','Erro',MB_OK + MB_ICONSTOP);
          SetFocus;
          Abort;
        end;
      end;
    end;
  end;
end;

function TDataEdit.GetDateTime: TDate;
begin
  if Text <> '  /  /    '
    then Result := StrToDate(Text)
    else Result := -1;
end;

procedure TDataEdit.setDateTime(const Value: TDate);
begin
  Text := DateToStr(Value);
end;

end.
