
{******************************************}
{                                          }
{             FastReport v6.0              }
{            DOCX export dialog            }
{                                          }
{         Copyright (c) 1998-2017          }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportDOCXDialog;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLType, LCLIntf,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, frxExportBaseDialog
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxDOCXExportDialog = class(TfrxBaseExportDialog)
  end;
  
implementation

{$R *.dfm}

end.
