// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxe25.dpk' rev: 32.00 (Windows)

#ifndef Frxe25HPP
#define Frxe25HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <frxExportImage.hpp>
#include <GIF.hpp>
#include <frxImageConverter.hpp>
#include <frxExportMatrix.hpp>
#include <frxExportCSV.hpp>
#include <frxExportText.hpp>
#include <frxZip.hpp>
#include <frxrcExports.hpp>
#include <frxExportBaseDialog.hpp>
#include <frxExportTextDialog.hpp>
#include <frxExportImageDialog.hpp>
#include <frxSendMAPI.hpp>
#include <frxExportHTML.hpp>
#include <frxExportPDF.hpp>
#include <frxExportPDFHelpers.hpp>
#include <frxEMFAbstractExport.hpp>
#include <frxEMFFormat.hpp>
#include <frxEMFtoSVGExport.hpp>
#include <frxEMFtoPDFExport.hpp>
#include <frxExportRTF.hpp>
#include <frxRC4.hpp>
#include <frxGML.hpp>
#include <frxExportHelpers.hpp>
#include <frxCrypto.hpp>
#include <frxSMTP.hpp>
#include <frxExportMail.hpp>
#include <frxExportODF.hpp>
#include <frxExportDBF.hpp>
#include <frxExportBIFF.hpp>
#include <frxExportXLS.hpp>
#include <frxExportXML.hpp>
#include <frxExportSVG.hpp>
#include <frxExportZPL.hpp>
#include <frxCBFF.hpp>
#include <frxOLEPS.hpp>
#include <frxDraftPool.hpp>
#include <frxBiffConverter.hpp>
#include <frxBIFF.hpp>
#include <frxEscher.hpp>
#include <frxExportHTMLDiv.hpp>
#include <frxExportDOCX.hpp>
#include <frxExportPPTX.hpp>
#include <frxExportXLSX.hpp>
#include <frxOfficeOpen.hpp>
#include <frxExportXLSDialog.hpp>
#include <frxExportXLSXDialog.hpp>
#include <frxExportPPTXDialog.hpp>
#include <frxExportDOCXDialog.hpp>
#include <frxExportHTMLDivDialog.hpp>
#include <frxExportSVGDialog.hpp>
#include <frxExportBIFFDialog.hpp>
#include <frxExportODFDialog.hpp>
#include <frxExportXMLDialog.hpp>
#include <frxExportZPLDialog.hpp>
#include <frxExportPSHelper.hpp>
#include <frxExportPSDialog.hpp>
#include <frxExportPSDocument.hpp>
#include <frxExportPS.hpp>
#include <frxExportPPMLDocument.hpp>
#include <frxExportPPML.hpp>
#include <frxExportPPMLDialog.hpp>
#include <frxExportRTFDialog.hpp>
#include <frxExportPDFDialog.hpp>
#include <frxExportHTMLDialog.hpp>
#include <frxExportCSVDialog.hpp>
#include <frxTrueTypeCollection.hpp>
#include <frxTrueTypeFont.hpp>
#include <frxCmapTableClass.hpp>
#include <frxGlyphTableClass.hpp>
#include <frxGlyphSubstitutionClass.hpp>
#include <frxHorizontalHeaderClass.hpp>
#include <frxHorizontalMetrixClass.hpp>
#include <frxIndexToLocationClass.hpp>
#include <frxKerningTableClass.hpp>
#include <frxPostScriptClass.hpp>
#include <frxMaximumProfileClass.hpp>
#include <frxOS2WindowsMetricsClass.hpp>
#include <frxPreProgramClass.hpp>
#include <frxNameTableClass.hpp>
#include <frxFontHeaderClass.hpp>
#include <frxTrueTypeTable.hpp>
#include <TTFHelpers.hpp>
#include <Winapi.Windows.hpp>	// (rtl)
#include <Winapi.PsAPI.hpp>	// (rtl)
#include <System.Character.hpp>	// (rtl)
#include <System.Internal.ExcUtils.hpp>	// (rtl)
#include <System.SysUtils.hpp>	// (rtl)
#include <System.VarUtils.hpp>	// (rtl)
#include <System.Variants.hpp>	// (rtl)
#include <System.Math.hpp>	// (rtl)
#include <System.Rtti.hpp>	// (rtl)
#include <System.TypInfo.hpp>	// (rtl)
#include <System.Generics.Defaults.hpp>	// (rtl)
#include <System.Classes.hpp>	// (rtl)
#include <System.TimeSpan.hpp>	// (rtl)
#include <System.DateUtils.hpp>	// (rtl)
#include <System.IOUtils.hpp>	// (rtl)
#include <System.Win.Registry.hpp>	// (rtl)
#include <Vcl.Graphics.hpp>	// (vcl)
#include <System.Actions.hpp>	// (rtl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <System.SyncObjs.hpp>	// (rtl)
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <Vcl.Printers.hpp>	// (vcl)
#include <Vcl.Clipbrd.hpp>	// (vcl)
#include <Vcl.ComCtrls.hpp>	// (vcl)
#include <Vcl.Dialogs.hpp>	// (vcl)
#include <Vcl.ExtCtrls.hpp>	// (vcl)
#include <Vcl.Themes.hpp>	// (vcl)
#include <System.AnsiStrings.hpp>	// (rtl)
#include <System.Win.ComObj.hpp>	// (rtl)
#include <Winapi.FlatSB.hpp>	// (rtl)
#include <Vcl.Forms.hpp>	// (vcl)
#include <Vcl.Menus.hpp>	// (vcl)
#include <Winapi.MsCTF.hpp>	// (rtl)
#include <Vcl.Controls.hpp>	// (vcl)
#include <Vcl.Buttons.hpp>	// (vcl)
#include <Vcl.Imaging.pngimage.hpp>	// (vclimg)
#include <frxChm.hpp>	// (frx25)
#include <fs_iconst.hpp>	// (fs25)
#include <frxRes.hpp>	// (frx25)
#include <frxDPIAwareInt.hpp>	// (frx25)
#include <fs_itools.hpp>	// (fs25)
#include <fs_iinterpreter.hpp>	// (fs25)
#include <frxDsgnIntf.hpp>	// (frx25)
#include <frxDMPClass.hpp>	// (frx25)
#include <frxStorage.hpp>	// (frx25)
#include <frxThreading.hpp>	// (frx25)
#include <frxPrinter.hpp>	// (frx25)
#include <frxSearchDialog.hpp>	// (frx25)
#include <Vcl.OleCtnrs.hpp>	// (vcl)
#include <frxRichEdit.hpp>	// (frx25)
#include <frxUnicodeCtrls.hpp>	// (frx25)
#include <frxInPlaceClipboards.hpp>	// (frx25)
#include <frxInPlaceEditors.hpp>	// (frx25)
#include <frxIOTransportIntf.hpp>	// (frx25)
#include <frxIOTransportDialog.hpp>	// (frx25)
#include <frxPreview.hpp>	// (frx25)
#include <frxGraphicUtils.hpp>	// (frx25)
#include <frxrcClass.hpp>	// (frx25)
#include <fs_iclassesrtti.hpp>	// (fs25)
#include <fs_igraphicsrtti.hpp>	// (fs25)
#include <fs_iformsrtti.hpp>	// (fs25)
#include <Vcl.Imaging.jpeg.hpp>	// (vclimg)
#include <frxClassRTTI.hpp>	// (frx25)
#include <fs_ipascal.hpp>	// (fs25)
#include <fs_icpp.hpp>	// (fs25)
#include <fs_ibasic.hpp>	// (fs25)
#include <fs_ijs.hpp>	// (fs25)
#include <fs_idialogsrtti.hpp>	// (fs25)
#include <fs_iinirtti.hpp>	// (fs25)
#include <frxClass.hpp>	// (frx25)
#include <Winapi.Mapi.hpp>	// (rtl)
#include <frxNetUtils.hpp>	// (frx25)
#include <frxChBoxRTTI.hpp>	// (frx25)
#include <frxChBox.hpp>	// (frx25)
#include <frxGradientRTTI.hpp>	// (frx25)
#include <frxGradient.hpp>	// (frx25)
#include <frxGS1Helper.hpp>	// (frx25)
#include <frxBarcod.hpp>	// (frx25)
#include <frxEditFormat.hpp>	// (frx25)
#include <frxDesgnCtrls.hpp>	// (frx25)
#include <frxBarcodeEditor.hpp>	// (frx25)
#include <frxBarcodeRTTI.hpp>	// (frx25)
#include <frxDelphiZXIngAztecCode.hpp>	// (frx25)
#include <frxrcInsp.hpp>	// (frx25)
#include <frxDataTree.hpp>	// (frx25)
#include <frxSynMemo.hpp>	// (frx25)
#include <Vcl.CheckLst.hpp>	// (vclx)
#include <Vcl.Grids.hpp>	// (vcl)
#include <frxDesgnEditors.hpp>	// (frx25)
#include <frxStdWizard.hpp>	// (frx25)
#include <frxrcDesgn.hpp>	// (frx25)
#include <frxDesgn.hpp>	// (frx25)
#include <frx2DBarcodesPresets.hpp>	// (frx25)
#include <frxBarcode2DEditor.hpp>	// (frx25)
#include <frxBarcode2DRTTI.hpp>	// (frx25)
#include <frxQRCodeSwissPreset.hpp>	// (frx25)
#include <frxQRCodeSberPreset.hpp>	// (frx25)
#include <frxBarcode2D.hpp>	// (frx25)
#include <frxBarcode.hpp>	// (frx25)
#include <frxTableObjectRTTI.hpp>	// (frx25)
#include <frxTableObjectEditor.hpp>	// (frx25)
#include <frxTableObjectClipboard.hpp>	// (frx25)
#include <frxTableObject.hpp>	// (frx25)
// PRG_EXT: .bpl
// OBJ_EXT: .obj

//-- user supplied -----------------------------------------------------------

namespace Frxe25
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxe25 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXE25)
using namespace Frxe25;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxe25HPP
