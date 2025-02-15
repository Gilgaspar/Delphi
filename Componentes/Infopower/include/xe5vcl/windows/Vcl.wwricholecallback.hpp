﻿// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwricholecallback.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwricholecallbackHPP
#define Vcl_WwricholecallbackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.RichEdit.hpp>	// Pascal unit
#include <Winapi.ActiveX.hpp>	// Pascal unit
#include <System.Win.ComObj.hpp>	// Pascal unit
#include <vcl.wwrichole.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.OleCtnrs.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwricholecallback
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRichEditOleCallback;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TRichEditOleCallback : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::Classes::TComponent* FOwner;
	
protected:
	HRESULT __stdcall GetNewStorage(/* out */ _di_IStorage &stg);
	HRESULT __stdcall GetInPlaceContext(/* out */ _di_IOleInPlaceFrame &Frame, /* out */ _di_IOleInPlaceUIWindow &Doc, tagOIFI &FrameInfo);
	HRESULT __stdcall ShowContainerUI(BOOL fShow);
	HRESULT __stdcall QueryInsertObject(const GUID &clsid, _di_IStorage stg, int cp);
	HRESULT __stdcall DeleteObject(_di_IOleObject oleobj);
	HRESULT __stdcall QueryAcceptData(_di_IDataObject dataobj, System::Word &cfFormat, unsigned reco, BOOL fReally, NativeUInt hMetaPict);
	HRESULT __stdcall ContextSensitiveHelp(BOOL fEnterMode);
	HRESULT __stdcall GetClipboardData(const CHARRANGE &chrg, unsigned reco, /* out */ _di_IDataObject &dataobj);
	HRESULT __stdcall GetDragDropEffect(BOOL fDrag, unsigned grfKeyState, unsigned &dwEffect);
	HRESULT __stdcall GetContextMenu(System::Word seltype, _di_IOleObject oleobj, const CHARRANGE &chrg, HMENU &menu);
	
public:
	__fastcall TRichEditOleCallback(System::Classes::TComponent* AOwner);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TRichEditOleCallback(void) { }
	
private:
	void *__IRichEditOleCallback;	// Vcl::Wwrichole::IRichEditOleCallback 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00020D03-0000-0000-C000-000000000046}
	operator Vcl::Wwrichole::_di_IRichEditOleCallback()
	{
		Vcl::Wwrichole::_di_IRichEditOleCallback intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Vcl::Wwrichole::IRichEditOleCallback*(void) { return (Vcl::Wwrichole::IRichEditOleCallback*)&__IRichEditOleCallback; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Wwricholecallback */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRICHOLECALLBACK)
using namespace Vcl::Wwricholecallback;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwricholecallbackHPP
