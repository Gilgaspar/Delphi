﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDelphiZXIngAztecCode.pas' rev: 32.00 (Windows)

#ifndef FrxdelphizxingazteccodeHPP
#define FrxdelphizxingazteccodeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <frxBarcode2DBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxdelphizxingazteccode
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAztecEncoder;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TAztecEncoder : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FData;
	int FMatrixSize;
	int FMinECCPercent;
	bool __fastcall GetIsBlack(int Row, int Column);
	void __fastcall SetData(const System::WideString Value);
	void __fastcall SetMinECCPercent(const int Value);
	
protected:
	void __fastcall Update(void);
	
public:
	Frxbarcode2dbase::T2DBooleanArray FElements;
	__fastcall TAztecEncoder(void);
	__property bool IsBlack[int Row][int Column] = {read=GetIsBlack};
	__property System::WideString Data = {read=FData, write=SetData};
	__property int MatrixSize = {read=FMatrixSize, nodefault};
	__property int MinECCPercent = {read=FMinECCPercent, write=SetMinECCPercent, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAztecEncoder(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 DEFAULT_EC_PERCENT = System::Int8(0x21);
}	/* namespace Frxdelphizxingazteccode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDELPHIZXINGAZTECCODE)
using namespace Frxdelphizxingazteccode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdelphizxingazteccodeHPP
