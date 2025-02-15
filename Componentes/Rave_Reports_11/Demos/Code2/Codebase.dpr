program CodeBase;

uses
  Forms,
  Reports in 'Reports.pas' {FormReports};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormReports, FormReports);
  Application.Run;
end.
