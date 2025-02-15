unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpDefine, RpRave, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RvProject1: TRvProject;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  RvProject1.ExecuteReport('SimpleTableListingReport');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RvProject1.ExecuteReport('HighlightingReport');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  RvProject1.ExecuteReport('LineCountTableReport');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  RvProject1.ExecuteReport('GotoPageReport');
end;

end.
