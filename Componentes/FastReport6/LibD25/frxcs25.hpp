// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxcs25.dpk' rev: 32.00 (Windows)

#ifndef Frxcs25HPP
#define Frxcs25HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <frxServer.hpp>
#include <frxServerClient.hpp>
#include <frxServerConfig.hpp>
#include <frxServerFormControls.hpp>
#include <frxServerForms.hpp>
#include <frxServerLog.hpp>
#include <frxServerReports.hpp>
#include <frxServerSessionManager.hpp>
#include <frxUsers.hpp>
#include <frxServerSSI.hpp>
#include <frxServerStat.hpp>
#include <frxHTTPClient.hpp>
#include <frxCGIClient.hpp>
#include <frxServerCache.hpp>
#include <frxServerReportsList.hpp>
#include <frxServerTemplates.hpp>
#include <frxServerVariables.hpp>
#include <frxServerPrinter.hpp>
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
#include <System.Actions.hpp>	// (rtl)
#include <System.TimeSpan.hpp>	// (rtl)
#include <System.DateUtils.hpp>	// (rtl)
#include <System.IOUtils.hpp>	// (rtl)
#include <System.Win.Registry.hpp>	// (rtl)
#include <Vcl.Graphics.hpp>	// (vcl)
#include <System.SyncObjs.hpp>	// (rtl)
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <System.AnsiStrings.hpp>	// (rtl)
#include <System.Win.ComObj.hpp>	// (rtl)
#include <Winapi.MsCTF.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <Vcl.Controls.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
#include <Vcl.Printers.hpp>	// (vcl)
#include <Vcl.Clipbrd.hpp>	// (vcl)
#include <Vcl.ComCtrls.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <Vcl.Dialogs.hpp>	// (vcl)
#include <Vcl.ExtCtrls.hpp>	// (vcl)
#include <Vcl.Themes.hpp>	// (vcl)
#include <Vcl.Menus.hpp>	// (vcl)
#include <Winapi.FlatSB.hpp>	// (rtl)
#include <Vcl.Forms.hpp>	// (vcl)
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
#include <frxThreading.hpp>	// (frx25)
#include <frxNetUtils.hpp>	// (frx25)
#include <frxrcExports.hpp>	// (frxe25)
#include <frxCrypto.hpp>	// (frxe25)
#include <frxTrueTypeFont.hpp>	// (frxe25)
#include <frxTrueTypeCollection.hpp>	// (frxe25)
#include <frxExportHelpers.hpp>	// (frxe25)
#include <frxExportHTML.hpp>	// (frxe25)
#include <frxEMFFormat.hpp>	// (frxe25)
#include <frxExportPDFHelpers.hpp>	// (frxe25)
#include <frxChBoxRTTI.hpp>	// (frx25)
#include <frxChBox.hpp>	// (frx25)
#include <frxExportPDF.hpp>	// (frxe25)
#include <frxGradientRTTI.hpp>	// (frx25)
#include <frxGradient.hpp>	// (frx25)
#include <Vcl.CheckLst.hpp>	// (vclx)
#include <frxDCtrlRTTI.hpp>	// (frx25)
#include <frxDCtrl.hpp>	// (frx25)
#include <frxExportODF.hpp>	// (frxe25)
#include <frxBIFF.hpp>	// (frxe25)
// PRG_EXT: .bpl
// OBJ_EXT: .obj

//-- user supplied -----------------------------------------------------------

namespace Frxcs25
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcs25 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCS25)
using namespace Frxcs25;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxcs25HPP
