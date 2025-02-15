unit LabelBalao;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, fmBaloom;

type
  TLabelBalao = class(TImage)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    Constructor Create(AOwner : TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

var FBaloom: TFormBaloom;


procedure Register;
begin
  RegisterComponents('Controle de  Dados', [TLabelBalao]);
end;

{ TLabelBalao }

constructor TLabelBalao.Create(AOwner: TComponent);
begin
  inherited;
  FBaloom:=TFormBaloom.Create(Self);
  Picture.Assign(FormBaloom.im_baloom.Picture);

end;

end.
