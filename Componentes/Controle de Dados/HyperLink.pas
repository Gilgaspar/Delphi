unit HyperLink;

interface

uses
  Windows, Controls, StdCtrls, Classes, ShellApi
  ;


type
  THyperLink = class(TLabel)
  private
    FLink: String;
    procedure SetLink(const Value: String);
  protected
    procedure Execute(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
  published
    property Link: String read FLink write SetLink;
  end;


{$R *.dcr}  

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [THyperLink]);
end;

{ THyperLink }

procedure THyperLink.Click;
begin
  Execute(Self);
  inherited;
end;

constructor THyperLink.Create(AOwner: TComponent);
begin
  inherited;
  Cursor := crHandPoint;
//onClick := Execute(Self);
end;

procedure THyperLink.Execute(Sender: TObject);
begin
  if FLink <> '' then
  begin
    ShellExecute(0, 'Open', pChar(FLink), '', '', SW_NORMAL);
  end
end;

procedure THyperLink.SetLink(const Value: String);
begin
  FLink := Value;
end;

end.
