// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ECC200Consts.pas' rev: 30.00 (Windows)

#ifndef Ecc200constsHPP
#define Ecc200constsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Ecc200consts
{
//-- forward type declarations -----------------------------------------------
struct TPatternInfoRec;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TMatrixsize : unsigned char { m8x8, m10x10, m12x12, m14x14, m16x16, m18x18, m20x20, m22x22, m24x24, m28x28, m32x32, m36x36, m40x40, m44x44 };

typedef System::DynamicArray<System::Byte> TVarByte;

typedef System::DynamicArray<int> TVarInt;

struct DECLSPEC_DRECORD TPatternInfoRec
{
public:
	int matrixdim;
	int databytes;
	int ECCbytes;
	int regions;
	int regionsize;
	int numBlocks;
	int regionNumECC;
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 ascfirst = System::Int8(0x1);
static const System::Byte asclast = System::Byte(0x80);
static const System::Byte ascPad = System::Byte(0x81);
static const System::Byte ascLatchC40 = System::Byte(0xe6);
static const System::Byte ascLatchB256 = System::Byte(0xe7);
static const System::Byte ascUpperShift = System::Byte(0xeb);
static const System::Byte ascFNC = System::Byte(0xe8);
extern DELPHI_PACKAGE System::StaticArray<TPatternInfoRec, 14> PatternInfo;
extern DELPHI_PACKAGE void __fastcall GetPatternInfo(int msize, int &datasize, int &eccsize, int &regions, int &regsize, int &blocks);
}	/* namespace Ecc200consts */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ECC200CONSTS)
using namespace Ecc200consts;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ecc200constsHPP
