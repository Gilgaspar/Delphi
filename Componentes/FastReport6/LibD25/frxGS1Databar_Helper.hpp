// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxGS1Databar_Helper.pas' rev: 32.00 (Windows)

#ifndef Frxgs1databar_helperHPP
#define Frxgs1databar_helperHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxgs1databar_helper
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBaseDatabar;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<bool> Frxgs1databar_helper__1;

typedef System::DynamicArray<System::DynamicArray<bool> > TEncoded_Data;

typedef System::DynamicArray<System::Byte> TArrayOfByte;

typedef System::DynamicArray<int> TArrayOfInteger;

typedef System::DynamicArray<System::WideChar> TArrayOfChar;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBaseDatabar : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<int> _TBaseDatabar__1;
	
	
public:
	TArrayOfInteger elements;
	int rows;
	int width;
	int data_chars;
	_TBaseDatabar__1 row_height;
	TEncoded_Data symbol;
	TArrayOfInteger sub_elements;
public:
	/* TObject.Create */ inline __fastcall TBaseDatabar(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TBaseDatabar(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 COLS_MAX = System::Int8(0x66);
static const System::Int8 NUMERIC = System::Int8(0x6e);
static const System::Int8 ALPHA = System::Int8(0x61);
static const System::Int8 ISOIEC = System::Int8(0x69);
static const System::Int8 INVALID_CHAR = System::Int8(0x64);
static const System::Int8 ANY_ENC = System::Int8(0x78);
static const System::Int8 ALPHA_OR_ISO = System::Int8(0x79);
extern DELPHI_PACKAGE System::StaticArray<int, 5> g_sum_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 5> t_even_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 5> modules_odd_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 5> modules_even_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 5> widest_odd_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 5> widest_even_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 184> checksum_weight_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 60> finder_pattern_exp;
extern DELPHI_PACKAGE System::StaticArray<int, 110> finder_sequence;
extern DELPHI_PACKAGE System::StaticArray<int, 210> weight_rows;
extern DELPHI_PACKAGE TArrayOfByte __fastcall StrToArrayOfByte(const System::UnicodeString AString);
extern DELPHI_PACKAGE TArrayOfChar __fastcall StrToArrayOfChar(const System::UnicodeString AString);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ArrayOfCharToString(const TArrayOfChar AArray);
extern DELPHI_PACKAGE void __fastcall ArrayCopy(TArrayOfChar &ADestination, const TArrayOfByte ASource, int ACount = 0x7fffffff)/* overload */;
extern DELPHI_PACKAGE void __fastcall ArrayCopy(TArrayOfByte &ADestination, const TArrayOfChar ASource, int ACount = 0x7fffffff)/* overload */;
extern DELPHI_PACKAGE int __fastcall strlen(const TArrayOfChar AString);
extern DELPHI_PACKAGE void __fastcall strcpy(TArrayOfChar &target, const TArrayOfChar source)/* overload */;
extern DELPHI_PACKAGE void __fastcall strcpy(TArrayOfChar &ATarget, const System::UnicodeString ASource)/* overload */;
extern DELPHI_PACKAGE int __fastcall ustrlen(const TArrayOfByte data);
extern DELPHI_PACKAGE void __fastcall concat(TArrayOfChar &dest, const TArrayOfChar source)/* overload */;
extern DELPHI_PACKAGE void __fastcall concat(TArrayOfChar &ADest, const System::UnicodeString ASource)/* overload */;
extern DELPHI_PACKAGE int __fastcall ctoi(System::WideChar source);
extern DELPHI_PACKAGE System::WideChar __fastcall itoc(int source);
extern DELPHI_PACKAGE bool __fastcall module_is_set(TEncoded_Data symbol, int y_coord, int x_coord);
extern DELPHI_PACKAGE void __fastcall set_module(TEncoded_Data &symbol, int y_coord, int x_coord);
extern DELPHI_PACKAGE void __fastcall unset_module(TEncoded_Data &symbol, int y_coord, int x_coord);
extern DELPHI_PACKAGE int __fastcall general_rules(TArrayOfChar field, TArrayOfChar _type);
extern DELPHI_PACKAGE void __fastcall getRSSwidths(int val, int n, int elements, int maxWidth, int noNarrow, /* out */ TArrayOfInteger &widths);
extern DELPHI_PACKAGE int __fastcall combins(int n, int r);
extern DELPHI_PACKAGE int __fastcall CalcSumArrayOfInteger(TArrayOfInteger arr);
extern DELPHI_PACKAGE TBaseDatabar* __fastcall Code_DBEorES(const System::UnicodeString FText, bool Stacked, int option_2 = 0x2);
}	/* namespace Frxgs1databar_helper */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXGS1DATABAR_HELPER)
using namespace Frxgs1databar_helper;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxgs1databar_helperHPP
