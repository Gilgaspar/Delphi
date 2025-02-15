// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBrowser.pas' rev: 32.00 (Windows)

#ifndef FrxbrowserHPP
#define FrxbrowserHPP

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

//-- user supplied -----------------------------------------------------------

namespace Frxbrowser
{
//-- forward type declarations -----------------------------------------------
__interface IfrxWebBrowser;
typedef System::DelphiInterface<IfrxWebBrowser> _di_IfrxWebBrowser;
//-- type declarations -------------------------------------------------------
typedef bool __fastcall (__closure *TTestURLEvent)(System::UnicodeString URL);

typedef void __fastcall (__closure *TNavComplete)(const System::OleVariant &Value);

typedef System::TMetaClass* TfrxBrowserClass;

__interface  INTERFACE_UUID("{FAA83A31-6D9B-4C9D-8C3D-A6F8F61F85B8}") IfrxWebBrowser  : public System::IInterface 
{
	virtual System::Classes::TStringList* __stdcall GetNavigateHistory(void) = 0 ;
	virtual System::Classes::TNotifyEvent __stdcall GetOnDocumentComplet(void) = 0 ;
	virtual TTestURLEvent __stdcall GetOnTestURL(void) = 0 ;
	virtual System::UnicodeString __stdcall GetURL(void) = 0 ;
	virtual _di_IDispatch __stdcall GetDocument(void) = 0 ;
	virtual void __stdcall SetNavigateHistory(System::Classes::TStringList* const Value) = 0 ;
	virtual void __stdcall SetOnDocumentComplet(const System::Classes::TNotifyEvent Value) = 0 ;
	virtual void __stdcall SetURL(const System::UnicodeString Value) = 0 ;
	virtual void __stdcall SetOnTestURL(const TTestURLEvent Value) = 0 ;
	virtual void __stdcall SetOnNavComplete(const TNavComplete Value) = 0 ;
	virtual void __stdcall CloseQuery(bool &CanClose) = 0 ;
	virtual void __stdcall NavigateURL(System::UnicodeString aURL) = 0 ;
	virtual void __stdcall BrowserConfiguration(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxBrowserClass frxBrowserGlobal;
}	/* namespace Frxbrowser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBROWSER)
using namespace Frxbrowser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbrowserHPP
