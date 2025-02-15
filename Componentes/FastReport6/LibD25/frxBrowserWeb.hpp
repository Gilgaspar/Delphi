// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBrowserWeb.pas' rev: 32.00 (Windows)

#ifndef FrxbrowserwebHPP
#define FrxbrowserwebHPP

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
#include <frxBrowser.hpp>
#include <Vcl.OleCtrls.hpp>
#include <frxFPUMask.hpp>
#include <SHDocVw.hpp>
#include <System.Math.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbrowserweb
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBrowserWeb;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBrowserWeb : public Shdocvw::TWebBrowser
{
	typedef Shdocvw::TWebBrowser inherited;
	
__published:
	void __fastcall WebBrowserNavigateComplete2(System::TObject* ASender, const _di_IDispatch pDisp, const System::OleVariant &URL);
	
private:
	System::UnicodeString FURL;
	System::Classes::TStringList* FNavigateHistory;
	Frxbrowser::TTestURLEvent FOnTestURL;
	System::Classes::TNotifyEvent FOnDocumentComplet;
	Frxbrowser::TNavComplete FOnNavComplete;
	System::Classes::TStringList* __stdcall GetNavigateHistory(void);
	System::Classes::TNotifyEvent __stdcall GetOnDocumentComplet(void);
	Frxbrowser::TTestURLEvent __stdcall GetOnTestURL(void);
	System::UnicodeString __stdcall GetURL(void);
	_di_IDispatch __stdcall GetDocument(void);
	void __stdcall SetNavigateHistory(System::Classes::TStringList* const Value);
	void __stdcall SetOnDocumentComplet(const System::Classes::TNotifyEvent Value);
	void __stdcall SetOnTestURL(const Frxbrowser::TTestURLEvent Value);
	void __stdcall SetOnNavComplete(const Frxbrowser::TNavComplete Value);
	void __stdcall SetURL(const System::UnicodeString Value);
	void __stdcall BrowserConfiguration(void);
	void __stdcall CloseQuery(bool &CanClose);
	void __fastcall NavigateError(System::TObject* ASender, const _di_IDispatch pDisp, const System::OleVariant &URL, const System::OleVariant &Frame, const System::OleVariant &StatusCode, System::WordBool &Cancel);
	void __fastcall DocumentComplet(System::TObject* ASender, const _di_IDispatch pDisp, const System::OleVariant &URL);
	
protected:
	void __stdcall NavigateURL(System::UnicodeString aURL);
	
public:
	__fastcall virtual TfrxBrowserWeb(System::Classes::TComponent* AOwner);
public:
	/* TOleControl.Destroy */ inline __fastcall virtual ~TfrxBrowserWeb(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBrowserWeb(HWND ParentWindow) : Shdocvw::TWebBrowser(ParentWindow) { }
	
private:
	void *__IfrxWebBrowser;	// Frxbrowser::IfrxWebBrowser 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FAA83A31-6D9B-4C9D-8C3D-A6F8F61F85B8}
	operator Frxbrowser::_di_IfrxWebBrowser()
	{
		Frxbrowser::_di_IfrxWebBrowser intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Frxbrowser::IfrxWebBrowser*(void) { return (Frxbrowser::IfrxWebBrowser*)&__IfrxWebBrowser; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbrowserweb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBROWSERWEB)
using namespace Frxbrowserweb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbrowserwebHPP
