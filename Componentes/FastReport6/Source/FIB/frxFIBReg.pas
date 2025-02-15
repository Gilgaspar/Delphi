{******************************************}
{                                          }
{             FastReport v5.0              }
{         Fib enduser components           }
{                                          }
{         Copyright (c) 2004               }
{         by Alexander Tzyganenko,         }
{******************************************}
{                                          }
{       Improved by Butov Konstantin       }
{  Improved by  Serge Buzadzhy             }
{             buzz@devrace.com             }
{                                          }
{******************************************}

unit frxFIBReg;

interface

{$I frx.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, frxFIBComponents;

procedure Register;
begin
  RegisterComponents('FastReport 6.0', [TfrxFIBComponents]);
  {$IFDEF DELPHI16}
//GroupDescendentsWith(TfrxFIBComponents, TControl);
{$ENDIF}
end;

end.
