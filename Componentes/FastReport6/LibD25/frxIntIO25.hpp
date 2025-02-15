// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxIntIO25.dpk' rev: 32.00 (Windows)

#ifndef Frxintio25HPP
#define Frxintio25HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <frxBaseSocketIOHandler.hpp>
#include <frxTransportHTTP.hpp>
#include <frxOpenSSL.hpp>
#include <frxIOTransportDropbox.hpp>
#include <frxIOTransportOneDrive.hpp>
#include <frxIOTransportBoxCom.hpp>
#include <frxIOTransportGoogleDrive.hpp>
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
#include <System.SyncObjs.hpp>	// (rtl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <System.DateUtils.hpp>	// (rtl)
#include <System.IOUtils.hpp>	// (rtl)
#include <System.Win.Registry.hpp>	// (rtl)
#include <Vcl.Graphics.hpp>	// (vcl)
#include <System.Actions.hpp>	// (rtl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
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
#include <frxNetUtils.hpp>	// (frx25)
#include <frxMapHelpers.hpp>	// (frx25)
#include <Vcl.AxCtrls.hpp>	// (vcl)
#include <Vcl.OleCtrls.hpp>	// (vcl)
#include <frxFPUMask.hpp>	// (frxIntIOBase25)
#include <Vcl.OleServer.hpp>	// (vcl)
#include <SHDocVw.hpp>	// (vclie)
#include <frxBrowser.hpp>	// (frxIntIOBase25)
#include <frxBrowserWeb.hpp>	// (frxIntIOBase25)
#include <frxSaveFilterBrowser.hpp>	// (frxIntIOBase25)
#include <System.JSON.hpp>	// (rtl)
// PRG_EXT: .bpl
// OBJ_EXT: .obj

//-- user supplied -----------------------------------------------------------

namespace Frxintio25
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxintio25 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXINTIO25)
using namespace Frxintio25;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxintio25HPP
