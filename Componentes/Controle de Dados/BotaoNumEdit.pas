unit BotaoNumEdit;

interface

uses
  SysUtils, Classes, Controls,
//  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit;

type
  TBotaoNumEdit = class(TcxButtonEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  procedure KeyPress(var Key: Char); override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TBotaoNumEdit]);
end;

procedure TBotaoNumEdit.KeyPress(var Key : Char);
begin
  If Not (Key in ['0'..'9', #8]) Then
  Key := #0;
  inherited
end;

end.



















