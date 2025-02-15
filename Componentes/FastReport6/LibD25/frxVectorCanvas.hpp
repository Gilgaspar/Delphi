// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxVectorCanvas.pas' rev: 32.00 (Windows)

#ifndef FrxvectorcanvasHPP
#define FrxvectorcanvasHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Contnrs.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxvectorcanvas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVectorCanvas;
class DELPHICLASS TVector_ExtTextOut;
class DELPHICLASS TVector_ExtTextOutW;
class DELPHICLASS TVector_ExtTextOutA;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TVectorCanvas : public System::Contnrs::TObjectList
{
	typedef System::Contnrs::TObjectList inherited;
	
public:
	__fastcall TVectorCanvas(void);
	void __fastcall ExtTextOutW(int X, int Y, int Options, System::Types::PRect Rect, void * Str, int aCount, System::PInteger Dx);
	void __fastcall ExtTextOutA(int X, int Y, int Options, System::Types::PRect Rect, void * Str, int aCount, System::PInteger Dx);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TVectorCanvas(void) { }
	
};

#pragma pack(pop)

typedef System::DynamicArray<int> TCharacterDistance;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TVector_ExtTextOut : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FX;
	int FY;
	int FOptions;
	System::Types::TRect FRect;
	TCharacterDistance FDx;
	System::WideString FStr;
	
public:
	__fastcall TVector_ExtTextOut(int AX, int AY, int AOptions, System::Types::PRect ARect, int ACount, System::PInteger ADx);
	__fastcall virtual ~TVector_ExtTextOut(void);
	System::UnicodeString __fastcall AsString(void);
	int __fastcall TextLength(void);
	__property int X = {read=FX, nodefault};
	__property int Y = {read=FY, nodefault};
	__property int Options = {read=FOptions, nodefault};
	__property System::Types::TRect Rect = {read=FRect};
	__property TCharacterDistance Dx = {read=FDx};
	__property System::WideString Str = {read=FStr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TVector_ExtTextOutW : public TVector_ExtTextOut
{
	typedef TVector_ExtTextOut inherited;
	
public:
	__fastcall TVector_ExtTextOutW(int AX, int AY, int AOptions, System::Types::PRect ARect, void * AStr, int ACount, System::PInteger ADx);
public:
	/* TVector_ExtTextOut.Destroy */ inline __fastcall virtual ~TVector_ExtTextOutW(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TVector_ExtTextOutA : public TVector_ExtTextOut
{
	typedef TVector_ExtTextOut inherited;
	
public:
	__fastcall TVector_ExtTextOutA(int AX, int AY, int AOptions, System::Types::PRect ARect, void * AStr, int ACount, System::PInteger ADx);
public:
	/* TVector_ExtTextOut.Destroy */ inline __fastcall virtual ~TVector_ExtTextOutA(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall isFRExtTextOut(System::TObject* VCO);
}	/* namespace Frxvectorcanvas */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXVECTORCANVAS)
using namespace Frxvectorcanvas;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxvectorcanvasHPP
