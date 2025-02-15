// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pdfobjs.pas' rev: 32.00 (Windows)

#ifndef PdfobjsHPP
#define PdfobjsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Math.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Pdfobjs
{
//-- forward type declarations -----------------------------------------------
struct TRGBColor;
class DELPHICLASS TDictionary;
struct TTFontrec;
struct TPDFItemRec;
class DELPHICLASS TPDFPageObj;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 5> Pdfobjs__1;

typedef System::StaticArray<System::UnicodeString, 14> Pdfobjs__2;

typedef System::DynamicArray<System::Byte> TBuffer;

struct DECLSPEC_DRECORD TRGBColor
{
public:
	System::Byte red;
	System::Byte green;
	System::Byte blue;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TDictionary : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int __fastcall GetCount(void);
	
protected:
	System::Classes::TStringList* keys;
	System::Classes::TStringList* values;
	
public:
	void __fastcall Add(System::UnicodeString key, System::UnicodeString value);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall Key(int index);
	bool __fastcall KeyExists(System::UnicodeString key);
	System::UnicodeString __fastcall Value(System::UnicodeString key);
	void __fastcall RemoveKey(System::UnicodeString key);
	__fastcall TDictionary(void);
	__fastcall virtual ~TDictionary(void);
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TTFontrec
{
	
private:
	typedef System::DynamicArray<int> _TTFontrec__1;
	
	
public:
	int firstchar;
	int lastchar;
	int capheight;
	int italica;
	int stemv;
	int stemh;
	int xheight;
	int flags;
	int NumMetrics;
	int MapMode;
	short ascent;
	short descent;
	unsigned filelength;
	System::StaticArray<int, 4> BBox;
	_TTFontrec__1 metrics;
};


struct DECLSPEC_DRECORD TPDFItemRec
{
public:
	System::Byte ItemType;
	System::Extended Xpos;
	System::Extended Ypos;
	System::WideChar *Fontname;
	System::WideChar *FText;
	int fontsize;
	int FontCharset;
	System::WideChar *fcolor;
	bool fbold;
	bool fitalic;
	System::Byte fAlignment;
	System::UnicodeString Imagefilter;
	bool filled;
	bool staticimage;
	System::Extended width;
	System::Extended height;
	System::Extended thickness;
	System::Extended xscale;
	System::Extended yscale;
	System::WideChar *imagesrc;
	System::UnicodeString imagestring;
	System::UnicodeString imagedata;
	System::Byte shape;
	int pixelwidth;
	int pixelheight;
	TRGBColor rgbstrokecolor;
	TRGBColor rgbfcolor;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFPageObj : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString imagedata;
	System::UnicodeString textdata;
	int textlen;
	int grlen;
public:
	/* TObject.Create */ inline __fastcall TPDFPageObj(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TPDFPageObj(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Pdfobjs__1 BaseFamilies;
extern DELPHI_PACKAGE Pdfobjs__2 BaseFonts;
static const System::Int8 IT_TEXT = System::Int8(0x1);
static const System::Int8 IT_NEWPAGE = System::Int8(0x2);
static const System::Int8 IT_GRAPHIC = System::Int8(0x3);
static const System::Int8 IT_IMAGE = System::Int8(0x4);
static const System::Int8 IT_INVALID = System::Int8(0x0);
static const System::Int8 S_BOX = System::Int8(0x0);
static const System::Int8 S_CIRCLE = System::Int8(0x1);
static const System::Int8 S_HLINE = System::Int8(0x2);
static const System::Int8 S_VLINE = System::Int8(0x3);
static const System::Int8 S_OBLIQUE = System::Int8(0x4);
static const System::Int8 S_TOPBOTTOM = System::Int8(0x5);
static const System::Int8 S_LEFTRIGHT = System::Int8(0x6);
static const System::Word ORD0 = System::Word(0x30);
static const System::Word ORDA = System::Word(0x41);
#define CRLF L"\r\n"
static const System::Int8 TTFheader = System::Int8(0xc);
static const System::Int8 TABDIR = System::Int8(0x10);
extern DELPHI_PACKAGE bool CompressionOn;
extern DELPHI_PACKAGE bool MadeFirstPageFiles;
extern DELPHI_PACKAGE bool TextFirst;
extern DELPHI_PACKAGE System::Classes::TStream* OutputStream;
extern DELPHI_PACKAGE System::UnicodeString Docdate;
extern DELPHI_PACKAGE System::UnicodeString DocSubject;
extern DELPHI_PACKAGE System::UnicodeString DocTitle;
extern DELPHI_PACKAGE System::UnicodeString DocAuthor;
extern DELPHI_PACKAGE System::WideChar OldSeparator;
extern DELPHI_PACKAGE TDictionary* CustomWidths;
extern DELPHI_PACKAGE TDictionary* CustomEncodings;
extern DELPHI_PACKAGE System::UnicodeString debugstr;
extern DELPHI_PACKAGE System::StaticArray<System::Byte, 51> debugbuff;
extern DELPHI_PACKAGE int debugint;
extern DELPHI_PACKAGE System::Uitypes::TFontCharset FCharset;
extern DELPHI_PACKAGE void __fastcall InitLib(void * Mother);
extern DELPHI_PACKAGE void __fastcall EmbedTTFont(System::UnicodeString fontname);
extern DELPHI_PACKAGE void __fastcall SelectCharset(System::Uitypes::TFontCharset chars);
extern DELPHI_PACKAGE void __fastcall CloseDownLib(void);
extern DELPHI_PACKAGE void __fastcall SetDocProperties(System::UnicodeString author, System::UnicodeString title, System::UnicodeString subject);
extern DELPHI_PACKAGE void __fastcall SetOutputStream(System::Classes::TStream* pstr);
extern DELPHI_PACKAGE void __fastcall SetTempDirectory(System::UnicodeString tpath);
extern DELPHI_PACKAGE void __fastcall SetFiltCompression(int OnOff);
extern DELPHI_PACKAGE void __fastcall SetPageParams(System::Extended w, System::Extended h, System::Extended tm, System::Extended tma, System::Extended lma);
extern DELPHI_PACKAGE void __fastcall SetWidths(System::UnicodeString fontname, System::UnicodeString widthstr);
extern DELPHI_PACKAGE void __fastcall SetEncoding(System::UnicodeString fontname, System::UnicodeString estr);
extern DELPHI_PACKAGE void __fastcall SetTextFirst(bool bval);
extern DELPHI_PACKAGE void __fastcall AddFontSub(System::UnicodeString ssmap);
extern DELPHI_PACKAGE void __fastcall FinishDoc(System::UnicodeString FOutFile);
extern DELPHI_PACKAGE void __fastcall MakeXRef(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall MapFontName(System::UnicodeString oldname);
extern DELPHI_PACKAGE void __fastcall MakeTTFont(System::UnicodeString fontname, System::UnicodeString stylename, int fnumber);
extern DELPHI_PACKAGE void __fastcall MakeResourceDict(void);
extern DELPHI_PACKAGE void __fastcall StartPage(void);
extern DELPHI_PACKAGE void __fastcall FinishPage(void);
extern DELPHI_PACKAGE void __fastcall AddImageItem(const TPDFItemRec &ItemRec, void * imgdata);
extern DELPHI_PACKAGE void __fastcall AddPDFItem(const TPDFItemRec &ItemRec);
extern DELPHI_PACKAGE void __fastcall ASCII85(System::Classes::TStream* Source, System::Classes::TStream* Target, int soffset);
extern DELPHI_PACKAGE void __fastcall RunLength(System::Classes::TStream* source, System::Classes::TStream* Target);
extern DELPHI_PACKAGE void __fastcall HEXImage(System::UnicodeString ffi);
extern DELPHI_PACKAGE System::UnicodeString __fastcall RGBString(TRGBColor acol);
extern DELPHI_PACKAGE bool __fastcall IsNumber(System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall Pad10(System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall PDFArcTo(System::Extended X1, System::Extended Y1, System::Extended X2, System::Extended Y2, System::Extended XRadius, System::Extended YRadius);
extern DELPHI_PACKAGE void __fastcall SplitString(System::UnicodeString ss, System::WideChar sep, System::Classes::TStringList* &aList);
}	/* namespace Pdfobjs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PDFOBJS)
using namespace Pdfobjs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PdfobjsHPP
