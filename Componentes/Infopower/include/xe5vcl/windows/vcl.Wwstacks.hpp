// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.Wwstacks.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwstacksHPP
#define Vcl_WwstacksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwstacks
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TStackStr;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TStackStr : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* list;
	
public:
	void __fastcall push(System::UnicodeString s);
	System::UnicodeString __fastcall pop(void);
	__fastcall TStackStr(void);
	__fastcall virtual ~TStackStr(void);
	int __fastcall count(void);
};

#pragma pack(pop)

class DELPHICLASS TStackPtr;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TStackPtr : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* list;
	
public:
	void __fastcall push(void * s);
	void * __fastcall pop(void);
	__fastcall TStackPtr(void);
	__fastcall virtual ~TStackPtr(void);
	int __fastcall count(void);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Wwstacks */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWSTACKS)
using namespace Vcl::Wwstacks;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwstacksHPP
