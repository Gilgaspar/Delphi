
{******************************************}
{                                          }
{             FastReport v5.0              }
{         Exports Registration unit        }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxeReg;

{$I frx.inc}

interface


procedure Register;

implementation

uses
{$IFNDEF Linux}
  Windows, Messages,
{$ENDIF}
SysUtils, Classes, Graphics, Controls, Forms,
frxExportImage, frxExportText,
{$IFNDEF FPC}
  {$IFNDEF Delphi6}
    DsgnIntf,
  {$ELSE}
    DesignIntf, DesignEditors,
  {$ENDIF}
  {$IFNDEF ACADEMIC_ED}
    {$IFNDEF RAD_ED}
      frxExportXML, frxExportXLS, frxExportMail, frxExportHTMLDiv, frxExportZPL, frxExportPS, frxExportPPML,
      frxExportODF, frxExportDBF, frxExportBIFF, frxExportDOCX, frxExportPPTX, frxExportXLSX, frxExportSVG,
    {$ENDIF}
    frxExportHTML,
      {$IFNDEF Delphi12}frxExportTXT, {$ENDIF}
    frxExportRTF, frxExportPDF,
  {$ENDIF}
{$ELSE}
  PropEdits, LazarusPackageIntf, LResources, frxExportHTML, frxExportHTMLDiv, frxExportODF, frxExportTXT,
  frxExportXML, frxExportRTF, frxExportDBF, frxPreProgramClass, frxExportPDF, frxExportDOCX, frxExportPPTX,
  frxExportXLSX, frxExportZPL, frxExportPS, frxExportPPML,
{$ENDIF}
  frxExportCSV;

{-----------------------------------------------------------------------}

procedure Register;
begin
RegisterComponents('FastReport 6.0 exports',[
TfrxBMPExport, TfrxJPEGExport, TfrxTIFFExport, TfrxPNGExport, TfrxSimpleTextExport, TfrxCSVExport,
{$IFNDEF FPC}
  {$IFNDEF ACADEMIC_ED}
    {$IFNDEF RAD_ED}
      TfrxXLSExport, TfrxXMLExport, TfrxMailExport,
        {$IFNDEF Delphi12}
		  TfrxTXTExport,
		{$ENDIF}
	  TfrxODSExport, TfrxODTExport, TfrxDBFExport, TfrxBIFFExport, TfrxDOCXExport, TfrxPPTXExport, TfrxXLSXExport, TfrxHTML4DivExport, TfrxHTML5DivExport, TfrxSVGExport, TfrxZPLExport, TfrxPSExport, TfrxPPMLExport, 
	{$ENDIF}
    TfrxPDFExport, TfrxHTMLExport, TfrxRTFExport,
  {$ENDIF}
  TfrxGIFExport
{$ELSE}
  TfrxHTMLExport, TfrxHTML4DivExport, TfrxHTML5DivExport, TfrxODSExport, TfrxODTExport, TfrxTXTExport,
  TfrxXMLExport, TfrxRTFExport, TfrxDBFExport, TfrxPDFExport, TfrxDOCXExport, TfrxPPTXExport, TfrxXLSXExport, TfrxZPLExport, TfrxPSExport, TfrxPPMLExport
{$ENDIF}
]);
end;

{$IFDEF FPC}
initialization
{$INCLUDE frxeReg.lrs}
{$ENDIF}


end.
