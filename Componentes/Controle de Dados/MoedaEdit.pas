unit MoedaEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math;

type
  TMoedaEdit = class(TCustomMemo)
  private

    vValor: Real;
    vMoeda: String;
    vDecimais: Integer;
    vMaxValor: Extended;
    vParteInteira : Integer;
    procedure Formata;
    procedure Desformata;
    function  GetMoedaSQL : String;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMActivate(var Message: TCMActivate); message CM_ACTIVATE;
    procedure CMChanged(var Message: TCMChanged); message CM_CHANGED;
    procedure setValor(const Value: Real);
  protected
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    property MoedaSQL : String read GetMoedaSQL;
    procedure AtribuiValor(pValor : Extended);
  published
    property Decimais: Integer read vDecimais write vDecimais;
    property Moeda: String read vMoeda write vMoeda;
    property Valor: Real read vValor write setValor;
    property MaxValor: Extended read vMaxValor write vMaxValor;
    property ParteInteira : Integer read vParteInteira write vParteInteira;

    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TMoedaEdit]);
end;

constructor TMoedaEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);  // chama o construtor original
  AutoSize := True;
  Alignment := taRightJustify;  // define alinhamento à direita
  Width := 121;  // define o tamanho default
  Height := 21;  // define a altura default
  WantReturns := False; // desabilita a entrado do caractere Return
  WordWrap := False;
  Valor := 0;
  Decimais := FormatSettings.CurrencyDecimals; // Nº de decimais do Windows
  Formata;
end;

procedure TMoedaEdit.Formata;
var
  Mascara: String;
begin
  // define a máscara a ser utilizada na pré-formatação
  Mascara := '%.' + IntToStr(Decimais) + 'n';
  Text := Format(Mascara,[Valor]); // Formata
  if Moeda = '%' then // se for percentual
    Text := Text + Moeda
  else if Moeda <> '-' then
    Text := Moeda+' '+Text;
end;

procedure TMoedaEdit.Desformata;
var
  Mascara: String;
begin
  Mascara := '%.' + IntToStr(Decimais) + 'f';
  Text := Format(Mascara,[Valor]);
end;

procedure TMoedaEdit.CMEnter(var Message: TCMEnter);
begin
 Desformata;
 SelectAll;
 inherited;
end;

procedure TMoedaEdit.CMExit(var Message: TCMExit);
var Str: String; i:Integer;
begin

    while Pos(FormatSettings.ThousandSeparator, Text)>0 do
    begin
      Str := Text;
      Delete(Str, Pos(FormatSettings.ThousandSeparator, Text), 1);
      Text := Str;
    end;

 // grava o valor da propriedade Valor
  if (Text = '') or (StrToFloat(Text) = 0) then
    Valor := 0
  else

    // Arredonda o valor p/o nº de casas decimais informado
    Valor := Round(StrToFloat(Text)*Power(10,Decimais))/
                   Power(10,Decimais);
  // Testa se o valor está dentro do permitido
  if (MaxValor = 0) or (Valor <= MaxValor) then
  begin
    Formata;
    Inherited; // chama o evento original
  end else  // Se valor for maior que o permitido
    SetFocus;  // recebe novamente o foco 
end;

procedure TMoedaEdit.CMActivate(var Message: TCMActivate);
begin
 // grava o valor da propriedade Valor
  if (Text = '') or (StrToFloat(Text) = 0) then
    Valor := 0
  else
    // Arredonda o valor p/o nº de casas decimais informado
    Valor := Round(StrToFloat(Text)*Power(10,Decimais))/
                   Power(10,Decimais);
  // Testa se o valor está dentro do permitido
  if (MaxValor = 0) or (Valor <= MaxValor) then
  begin
    Formata;
    Inherited; // chama o evento original
  end else  // Se valor for maior que o permitido
    SetFocus;  // recebe novamente o foco 
end;

procedure TMoedaEdit.CMChanged(var Message: TCMChanged);
var
 I : Integer;
 Texto : String;
begin
  Font.Color := clBlack;
  Texto := Text;
  For I := 1 To Length(Texto) Do
  If Texto[I] = '-' Then
  begin
   Delete(Texto,I,1);
   Insert('-',Texto,1);
   Font.Color := clRed;
   Text := Texto;
   SelStart := Length(Text);
  end;
  Inherited
end;
procedure TMoedaEdit.KeyPress(var Key: Char);
var
  I: Integer;
  Texto, ValFrac : String;
  Achou: Boolean;
  ValTexto : Extended;
begin
  if (Key = FormatSettings.DecimalSeparator) or (Key = FormatSettings.ThousandSeparator) then
  begin
    Key := FormatSettings.DecimalSeparator;
    // Testa se já existe uma ','. Se ela estiver em
    // uma parte selecionada não há problema.
    Texto := SelText;
    Achou := False;
    for I := 1 to Length(Texto) do
    if Texto[I] = FormatSettings.DecimalSeparator then
    Achou := True;
    if not (Achou) then
    begin
      Texto := Text;
      Achou := False;
      for I := 1 to Length(Texto) do
      if Texto[I] = FormatSettings.DecimalSeparator then
      Achou := True;
      if Achou then
      Key := #0;
    end;
  end
  else
  If Key = '-' Then
  begin
    Texto := Text;
    Achou := False;
    For I := 1 To Length(Texto) Do
    If Texto[I] = '-' Then
    Achou := True;
    If Achou Then
    Key := #0;
  end
  else
  If Key in ['0'..'9'] Then
  begin
    If ParteInteira <> 0 Then
    begin
      If (SelText = Text) or (SelText <> Text) and (SelText <> '') Then
      Text := '';
      Texto := Text;
      If Texto <> '' Then
      begin
        ValTexto := Int(StrToFloat(Texto));
        If (SelStart  < Pos(',',Texto)) or (Pos(',',Texto) = 0) Then
        begin
         If (Length(FloatToStr(ValTexto)) >= ParteInteira) Then
         Key := #0;
        end;

        ValFrac := Copy(Texto,Pos(',',Texto)+1,Decimais);
        If (SelStart  >= Pos(',',Texto)) and (Pos(',',Texto) <> 0) Then
        begin
         If (Length(ValFrac) >= Decimais) Then
         Key := #0;
        end;
      end;
    end;
  end
  else
  if not ( Key in ['0'..'9',#8,'-'] ) then   // Se não é dígito válido, nem BackSpace, ignora
  Key := #0;
  inherited KeyPress(Key); // chama o evento original
end;

procedure TMoedaEdit.setValor(const Value: Real);
begin
  vValor := Value;
  Formata;
end;

function TMoedaEdit.GetMoedaSQL : String;
var
 I : Integer;
 vMascara : String;
begin
  vMascara := Trim(Text);
  For I := 1 To Length(Text) Do
   If vMascara[I] = FormatSettings.ThousandSeparator Then
   begin
     Delete(vMascara,I,1);
     Insert(',',vMascara,I);
    end
   else
   If vMascara[I] = FormatSettings.DecimalSeparator Then
   begin
     Delete(vMascara,I,1);
     Insert('.',vMascara,I);
     Break;
    end;
    Result := vMascara;
end;

procedure TMoedaEdit.AtribuiValor(pValor : Extended);
var
  ValorAtual: Extended;
begin
  ValorAtual := Round(pValor * power(10, Decimais)) / (Power(10, Decimais));

  if (MaxValor = 0) or (Valor <= MaxValor) then
  begin
    Valor := ValorAtual;
    Formata;
  end;

end;

end.
