unit fmBaloom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient, SimpleDS;

type
  TFormBaloom = class(TForm)
    pn_baloom: TPanel;
    im_baloom: TImage;
    lb_baloom: TLabel;
    Timer1: TTimer;
    ClientDataSet1: TClientDataSet;
    SimpleDataSet1: TSimpleDataSet;
    procedure lb_baloomClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBaloom: TFormBaloom;

implementation

{$R *.dfm}

procedure TFormBaloom.lb_baloomClick(Sender: TObject);
begin
//

end;

end.
