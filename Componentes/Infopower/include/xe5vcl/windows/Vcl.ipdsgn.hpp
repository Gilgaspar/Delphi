﻿// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.ipdsgn.pas' rev: 26.00 (Windows)

#ifndef Vcl_IpdsgnHPP
#define Vcl_IpdsgnHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Ipdsgn
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Inifiles::TIniFile* __fastcall IniPict(void);
extern DELPHI_PACKAGE void __fastcall wwVerifyPictureKeyValue(System::UnicodeString &Key, System::UnicodeString &Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall wwIniGetPictureDescription(System::UnicodeString Mask);
extern DELPHI_PACKAGE System::UnicodeString __fastcall wwIniGetRegexDescription(System::UnicodeString Mask);
extern DELPHI_PACKAGE void __fastcall wwOpenPictureIni(void);
extern DELPHI_PACKAGE void __fastcall wwClosePictureIni(void);
}	/* namespace Ipdsgn */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_IPDSGN)
using namespace Vcl::Ipdsgn;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_IpdsgnHPP
