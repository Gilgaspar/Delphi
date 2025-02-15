// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRPDFFilt.pas' rev: 30.00 (Windows)

#ifndef QrpdffiltHPP
#define QrpdffiltHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Printers.hpp>
#include <Data.DB.hpp>
#include <Vcl.ComCtrls.hpp>
#include <QRExport.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRCtrls.hpp>
#include <grimgctrl.hpp>
#include <pdfconst.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrpdffilt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRPAbstractExportFilter;
struct TPDFPages;
struct TPDFNote;
class DELPHICLASS TQRPDFDocumentFilter;
class DELPHICLASS TQRPDFFilter;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 5> Qrpdffilt__1;

enum DECLSPEC_DENUM TFontHandling : unsigned char { fhSubstitute, fhAutoEmbed, fhNoEmbedding };

class PASCALIMPLEMENTATION TQRPAbstractExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	System::Classes::TStream* FStream;
	System::Extended FCharWidth;
	System::Extended FCharHeight;
	System::Extended FPaperWidth;
	System::Extended FPaperHeight;
	int FLineCount;
	int FColCount;
	bool FPageProcessed;
	
protected:
	System::UnicodeString __fastcall GetCodepage(void);
	void __fastcall SetCodepage(System::UnicodeString value);
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	System::UnicodeString __fastcall GetText(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* &Font);
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	void __fastcall WriteToStream(const System::UnicodeString AText);
	void __fastcall WriteLnToStream(const System::UnicodeString AText);
	virtual void __fastcall CreateStream(System::UnicodeString FileName);
	virtual void __fastcall CloseStream(void);
	virtual void __fastcall ProcessPage(void);
	virtual void __fastcall StorePage(void);
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property bool PageProcessed = {read=FPageProcessed, write=FPageProcessed, nodefault};
	__property System::Extended CharWidth = {read=FCharWidth, write=FCharWidth};
	__property System::Extended CharHeight = {read=FCharHeight, write=FCharHeight};
	__property System::Extended PaperWidth = {read=FPaperWidth, write=FPaperWidth};
	__property System::Extended PaperHeight = {read=FPaperHeight, write=FPaperHeight};
	__property int LineCount = {read=FLineCount, write=FLineCount, nodefault};
	__property int ColCount = {read=FColCount, write=FColCount, nodefault};
	
public:
	System::Extended BGHFactor;
	__fastcall virtual TQRPAbstractExportFilter(System::UnicodeString FileName);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor bgColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property System::UnicodeString Codepage = {read=GetCodepage, write=SetCodepage};
public:
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRPAbstractExportFilter(void) { }
	
};


struct DECLSPEC_DRECORD TPDFPages
{
public:
	System::Extended PageWidth;
	System::Extended PageHeight;
};


struct DECLSPEC_DRECORD TPDFNote
{
	
private:
	typedef System::DynamicArray<TPDFPages> _TPDFNote__1;
	
	
public:
	_TPDFNote__1 pages;
	System::Classes::TStringList* pagetextfiles;
	System::Classes::TStringList* pagegraphicsfiles;
	System::Classes::TStringList* textlengths;
	System::Classes::TStringList* graphicslengths;
	System::Classes::TStringList* XRefBytes;
};


class PASCALIMPLEMENTATION TQRPDFDocumentFilter : public TQRPAbstractExportFilter
{
	typedef TQRPAbstractExportFilter inherited;
	
private:
	bool FFreeStream;
	System::Uitypes::TColor FBodyColor;
	bool FFirstPage;
	int FPageLength;
	int FPageNumber;
	int FLeftMargin;
	int FTopMargin;
	bool FPDFConcatenating;
	bool FPDFTextOnTop;
	TFontHandling FFontHandling;
	System::Classes::TBiDiMode FBiDiMode;
	bool FMadeFirstPageFiles;
	bool FTextFirst;
	System::UnicodeString FDocSubject;
	System::UnicodeString FDocCreator;
	System::UnicodeString FDocTitle;
	System::UnicodeString FDocAuthor;
	System::WideChar FOldSeparator;
	Pdfconst::TDictionary* FCustomWidths;
	Pdfconst::TDictionary* FCustomEncodings;
	bool FPDFCompressionOn;
	int FGraphicsLength;
	int FTextLength;
	TPDFNote FPDF;
	System::Classes::TStringList* FReportFonts;
	System::Classes::TStringList* FEmbedFonts;
	System::Classes::TStringList* FSubstitutedFonts;
	System::Extended FPageWidth;
	System::Extended FPageHeight;
	System::Extended FExtTopMargin;
	System::Extended FAdjustTM;
	System::Extended FAdjustLM;
	int FVertAdjust;
	void __fastcall SetTextOnTop(bool bVal);
	void __fastcall SetConcatenating(bool p_Value);
	bool __fastcall getConcatenating(void);
	bool __fastcall getTextOnTop(void);
	void __fastcall StartPage(void);
	void __fastcall FinishPage(void);
	void __fastcall ProcessItem(const Pdfconst::TPDFItemRec &ir);
	void __fastcall AddImageItem(const Pdfconst::TPDFItemRec &ItemRec, void * imgdata);
	void __fastcall AddPDFItem(const Pdfconst::TPDFItemRec &ItemRec);
	void __fastcall PTWrite(System::UnicodeString ob);
	void __fastcall GRWrite(System::UnicodeString ob);
	void __fastcall GRWriteBlob(System::Classes::TMemoryStream* Idata);
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual bool __fastcall GetStreaming(void);
	virtual void __fastcall CreateStream(System::UnicodeString FileName);
	virtual void __fastcall CloseStream(void);
	
public:
	__fastcall virtual TQRPDFDocumentFilter(System::UnicodeString FileName);
	__fastcall virtual ~TQRPDFDocumentFilter(void);
	virtual void __fastcall StorePage(void);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor bgColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	virtual void __fastcall ProcessPage(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	void __fastcall SetMargins(int TopMarg, int Leftmarg);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall EndPage(void);
	void __fastcall EndConcat(void);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	void __fastcall SetDocumentInfo(System::UnicodeString Creator, System::UnicodeString author, System::UnicodeString Title, System::UnicodeString Subject);
	void __fastcall AddFontMap(System::UnicodeString ssmap);
	void __fastcall SetPageParams(System::Extended w, System::Extended h, System::Extended tm, System::Extended tma, System::Extended lma);
	void __fastcall AddTTFont(System::UnicodeString FontName);
	void __fastcall AddCustomWidths(System::UnicodeString FontName, System::UnicodeString widthstr);
	void __fastcall AddCustomEncoding(System::UnicodeString FontName, System::UnicodeString encodingstr);
	__property int PageLength = {read=FPageLength, write=FPageLength, nodefault};
	__property Stream;
	__property bool FreeStream = {read=FFreeStream, write=FFreeStream, nodefault};
	__property bool TextOnTop = {read=getTextOnTop, write=SetTextOnTop, nodefault};
	__property bool Concatenating = {read=getConcatenating, write=SetConcatenating, nodefault};
	__property int TopMargin = {read=FTopMargin, write=FTopMargin, nodefault};
	__property int leftMargin = {read=FLeftMargin, write=FLeftMargin, nodefault};
	__property bool CompressionOn = {read=FPDFCompressionOn, write=FPDFCompressionOn, nodefault};
	__property TFontHandling FontHandling = {read=FFontHandling, write=FFontHandling, nodefault};
	__property System::Classes::TBiDiMode BiDiMode = {read=FBiDiMode, write=FBiDiMode, nodefault};
	__property TextEncoding;
	__property Codepage = {default=0};
};


class PASCALIMPLEMENTATION TQRPDFFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FCompressionOn;
	
protected:
	System::UnicodeString __fastcall GetCodepage(void);
	void __fastcall SetCodepage(System::UnicodeString value);
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	__fastcall virtual TQRPDFFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPDFFilter(void);
	
__published:
	__property bool CompressionOn = {read=FCompressionOn, write=FCompressionOn, nodefault};
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property System::UnicodeString Codepage = {read=GetCodepage, write=SetCodepage};
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar cFontMapSeparator = (System::WideChar)(0x3a);
#define cCourier L"Courier"
#define cHelvetica L"Helvetica"
#define cTimes L"Times"
#define cSymbol L"Symbol"
#define cZapfDingbats L"ZapfDingbats"
extern DELPHI_PACKAGE Qrpdffilt__1 BaseFamilies;
#define CRLF L"\r\n"
static const System::Int8 CR = System::Int8(0xd);
static const System::Int8 LF = System::Int8(0xa);
static const System::WideChar TAB = (System::WideChar)(0x9);
#define CZECH_ENC L"2 /space/space/space/space/space/space/space/space/space/s"\
	L"pace/space/space/space/space/space/space/space/space/space"\
	L"/space/space/space/space/space/space/space/space/space/spa"\
	L"ce/space/space/exclam/quotedbl/numbersign/dollar/percent/a"\
	L"mpersand/quoteright/parenleft/parenright/asterisk/plus/com"\
	L"ma/minus/period/slash/zero/one/two/three/four/five/six/sev"\
	L"en/eight/nine/colon/semicolon/less/equal/greater/question/"\
	L"at/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z/bra"\
	L"cketleft/backslash/bracketright/asciicircum/underscore/quo"\
	L"teleft/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z"\
	L"/braceleft/bar/braceright/tilde/space/space/space/quotesin"\
	L"glbase/space/quotedblbase/ellipsis/dagger/daggerdbl/space/"\
	L"perthousand/Scaron/guilsinglleft/Sacute/Tcaron/Zcaron/Zacu"\
	L"te/space/quoteleft/quoteright/quotedblleft/quotedblright/b"\
	L"ullet/endash/emdash/space/trademark/scaron/guilsinglright/"\
	L"sacute/tcaron/zcaron/zacute/space/caron/breve/Lslash/curre"\
	L"ncy/Aogonek/brokenbar/section/dieresis/copyright/Scedilla/"\
	L"guillemotleft/logicalnot/hyphen/registered/Zdotaccent/degr"\
	L"ee/plusminus/ogonek/lslash/acute/mu/paragraph/bullet/cedil"\
	L"la/aogonek/scedilla/guillemotright/Ydieresis/hungarumlaut/"\
	L"Lcaron/zdotaccent/Racute/Aacute/Acircumflex/Abreve/Adieres"\
	L"is/Lacute/Cacute/Ccedilla/Ccaron/Eacute/Eogonek/Edieresis/"\
	L"Ecaron/Iacute/Icircumflex/Dcaron/Eth/Nacute/Ncaron/Oacute/"\
	L"Ocircumflex/Ohungarumlaut/Odieresis/multiply/Rcaron/Uring/"\
	L"Uacute/Uhungarumlaut/Udieresis/Yacute/Tcedilla/germandbls/"\
	L"racute/aacute/acircumflex/abreve/adieresis/lacute/cacute/c"\
	L"cedilla/ccaron/eacute/eogonek/edieresis/ecaron/iacute/icir"\
	L"cumflexv/dcaron/dbar/nacute/ncaron/oacute/ocircumflex/ohun"\
	L"garumlaut/odieresis/divide/rcaron/uring/uacute/uhungarumla"\
	L"ut/udieresis/yacute/tcedilla/dotaccent"
extern DELPHI_PACKAGE void __fastcall AsciiHexEncodeFilter(System::Classes::TMemoryStream* sFrom, System::Classes::TMemoryStream* sTo);
}	/* namespace Qrpdffilt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPDFFILT)
using namespace Qrpdffilt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrpdffiltHPP
