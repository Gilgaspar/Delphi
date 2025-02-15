// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxSaveFilterBrowser.pas' rev: 32.00 (Windows)

#ifndef FrxsavefilterbrowserHPP
#define FrxsavefilterbrowserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.OleCtrls.hpp>
#include <frxFPUMask.hpp>
#include <SHDocVw.hpp>
#include <System.Math.hpp>
#include <System.Win.Registry.hpp>
#include <Winapi.UrlMon.hpp>
#include <frxBrowser.hpp>
#include <frxBrowserWeb.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxsavefilterbrowser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBrowserForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBrowserForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
private:
	Vcl::Controls::TWinControl* WebBrowserWinControl;
	Frxbrowser::_di_IfrxWebBrowser WebBrowser;
	System::Classes::TStringList* __fastcall GetNavigateHistory(void);
	System::Classes::TNotifyEvent __fastcall GetOnDocumentComplet(void);
	Frxbrowser::TTestURLEvent __fastcall GetOnTestURL(void);
	System::UnicodeString __fastcall GetURL(void);
	void __fastcall SetNavigateHistory(System::Classes::TStringList* const Value);
	void __fastcall SetOnDocumentComplet(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnTestURL(const Frxbrowser::TTestURLEvent Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall NavComplete(const System::OleVariant &aURL);
	
public:
	__fastcall virtual TBrowserForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBrowserForm(void);
	__property System::UnicodeString URL = {read=GetURL, write=SetURL};
	__property System::Classes::TStringList* NavigateHistory = {read=GetNavigateHistory, write=SetNavigateHistory};
	__property Frxbrowser::TTestURLEvent OnTestURL = {read=GetOnTestURL, write=SetOnTestURL};
	__property System::Classes::TNotifyEvent OnDocumentComplet = {read=GetOnDocumentComplet, write=SetOnDocumentComplet};
	__property Frxbrowser::_di_IfrxWebBrowser GetWebBrowser = {read=WebBrowser, write=WebBrowser};
	_di_IDispatch __fastcall GetDocument(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBrowserForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBrowserForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word IE11_default = System::Word(0x2af8);
static const System::Word IE11_Quirks = System::Word(0x2af9);
static const System::Word IE10_force = System::Word(0x2711);
static const System::Word IE10_default = System::Word(0x2710);
static const System::Word IE9_Quirks = System::Word(0x270f);
static const System::Word IE9_default = System::Word(0x2328);
static const System::Word IE7_embedded = System::Word(0x1b58);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetExeName(void);
extern DELPHI_PACKAGE void __fastcall SetBrowserEmulationDWORD(const unsigned value);
}	/* namespace Frxsavefilterbrowser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSAVEFILTERBROWSER)
using namespace Frxsavefilterbrowser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxsavefilterbrowserHPP
