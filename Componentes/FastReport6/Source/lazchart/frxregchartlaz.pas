unit frxRegChartLaz;

{$I frx.inc}

interface

procedure Register;

implementation

uses
SysUtils,
Classes ,Graphics, Controls, Forms,
PropEdits, LazarusPackageIntf, LResources,
frxChartLaz, frxLazChartRTTI;

procedure Register;
begin
  RegisterComponents('FastReport 6.0', [TfrxChartObject]);
  RegisterComponents('FastScript', [TfsChartRTTI]);
end;

initialization

{$INCLUDE frxRegChartLaz.lrs}

end.

