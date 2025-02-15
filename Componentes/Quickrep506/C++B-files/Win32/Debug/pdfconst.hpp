// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pdfconst.pas' rev: 32.00 (Windows)

#ifndef PdfconstHPP
#define PdfconstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Pdfconst
{
//-- forward type declarations -----------------------------------------------
struct UniGlyph;
class DELPHICLASS TDictionary;
struct TRGBColor;
struct TPDFItemRec;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD UniGlyph
{
public:
	System::Word ID;
	System::UnicodeString Name;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TDictionary : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int __fastcall GetCount(void);
	
protected:
	System::Classes::TStringList* Keys;
	System::Classes::TStringList* Values;
	
public:
	void __fastcall Add(System::UnicodeString Key, System::UnicodeString Value);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall Key(int Index);
	bool __fastcall KeyExists(System::UnicodeString Key);
	System::UnicodeString __fastcall Value(System::UnicodeString Key);
	void __fastcall RemoveKey(System::UnicodeString Key);
	__fastcall TDictionary(void);
	__fastcall virtual ~TDictionary(void);
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,1)
struct DECLSPEC_DRECORD TRGBColor
{
public:
	System::Byte Red;
	System::Byte Green;
	System::Byte Blue;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TPDFItemType : unsigned char { IT_INVALID, IT_TEXT, IT_NEWPAGE, IT_GRAPHIC, IT_IMAGE };

enum DECLSPEC_DENUM TPDFShapeType : unsigned char { S_BOX, S_CIRCLE, S_HLINE, S_VLINE, S_OBLIQUE, S_TOPBOTTOM, S_LEFTRIGHT, S_RIGHTDIAG, S_LEFTDIAG };

struct DECLSPEC_DRECORD TPDFItemRec
{
public:
	TPDFItemType ItemType;
	System::Extended XPos;
	System::Extended YPos;
	System::UnicodeString FontName;
	System::UnicodeString FText;
	System::Uitypes::TFontCharset FontCharset;
	int FontSize;
	System::WideChar *FColor;
	bool fbold;
	bool fItalic;
	System::Byte FAlignment;
	bool Filled;
	bool staticimage;
	System::Extended Width;
	System::Extended Height;
	System::Extended thickness;
	System::Extended xscale;
	System::Extended yscale;
	System::Classes::TMemoryStream* imgstr;
	System::UnicodeString ImageFilter;
	TPDFShapeType Shape;
	int pixelWidth;
	int pixelHeight;
	TRGBColor RGBStrokeColor;
	TRGBColor RGBFColor;
};


typedef System::StaticArray<UniGlyph, 1051> Pdfconst__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Pdfconst__2 UniGlyphs;
}	/* namespace Pdfconst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PDFCONST)
using namespace Pdfconst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PdfconstHPP
