// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LZW.pas' rev: 32.00 (Windows)

#ifndef LzwHPP
#define LzwHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lzw
{
//-- forward type declarations -----------------------------------------------
struct TLZWStats;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLZWStats
{
public:
	System::TDateTime Elapsed;
	double Speed;
	double Ratio;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLZWStats LZWEncodeStat;
extern DELPHI_PACKAGE TLZWStats LZWDecodeStat;
extern DELPHI_PACKAGE void __fastcall LZWEncode(System::Classes::TMemoryStream* sInput, System::Classes::TMemoryStream* sOutput)/* overload */;
extern DELPHI_PACKAGE void __fastcall LZWDecode(System::Classes::TMemoryStream* sInput, System::Classes::TMemoryStream* sOutput)/* overload */;
}	/* namespace Lzw */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LZW)
using namespace Lzw;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LzwHPP
