// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'csProp.pas' rev: 32.00 (Windows)

#ifndef CspropHPP
#define CspropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Csprop
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall PropertyExists(System::Classes::TComponent* Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetPointerProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName, void * ptr);
extern DELPHI_PACKAGE void * __fastcall GetPointerProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetBooleanProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName, bool B);
extern DELPHI_PACKAGE bool __fastcall GetBooleanProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetIntegerProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName, int L);
extern DELPHI_PACKAGE int __fastcall GetIntegerProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetFloatProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName, System::Extended Value);
extern DELPHI_PACKAGE System::Extended __fastcall GetFloatProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetStringProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName, System::UnicodeString Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetStringProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetMethodProperty(System::Classes::TComponent* Component, const System::UnicodeString PropName, void * Code, void * Data);
extern DELPHI_PACKAGE Vcl::Graphics::TFont* __fastcall GetFontProperty(System::Classes::TComponent* Component);
}	/* namespace Csprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_CSPROP)
using namespace Csprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CspropHPP
