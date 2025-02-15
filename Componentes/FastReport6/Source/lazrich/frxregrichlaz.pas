unit frxRegRichLaz;

{$I frx.inc}

interface

procedure Register;

implementation

uses
SysUtils,
Classes ,Graphics, Controls, Forms,
PropEdits, LazarusPackageIntf, LResources,
frxRichLaz, frxLazRichRTTI;

procedure Register;
begin
  RegisterComponents('FastReport 6.0', [TfrxRichObject]);
end;

end.

