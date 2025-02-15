// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportHelpers.pas' rev: 32.00 (Windows)

#ifndef FrxexporthelpersHPP
#define FrxexporthelpersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <frxClass.hpp>
#include <frxExportBaseDialog.hpp>
#include <System.UITypes.hpp>
#include <System.Variants.hpp>
#include <frxCrypto.hpp>
#include <frxStorage.hpp>
#include <frxVectorCanvas.hpp>
#include <frxUtils.hpp>
#include <frxAnaliticGeometry.hpp>
#include <frxTrueTypeCollection.hpp>
#include <System.Math.hpp>
#include <frxTrueTypeFont.hpp>
#include <frxPlatformServices.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexporthelpers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCustomOutlineNode;
class DELPHICLASS TfrxPDFOutlineNode;
class DELPHICLASS TfrxHTMLOutlineNode;
class DELPHICLASS TfrxCSSStyle;
class DELPHICLASS TfrxCSS;
struct TfrxPictureInfo;
class DELPHICLASS TfrxPictureStorage;
class DELPHICLASS TfrxPicture;
class DELPHICLASS TTextFragment;
class DELPHICLASS TAnsiMemoryStream;
class DELPHICLASS TExportHTMLDivSVGParent;
class DELPHICLASS TRotation2D;
struct SCRIPT_ANALYSIS;
class DELPHICLASS TfrxPDFRun;
struct TRemapedString;
class DELPHICLASS TfrxExportFont;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomOutlineNode : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Number;
	int Dest;
	int Top;
	int CountTree;
	int Count;
	System::UnicodeString Title;
	TfrxCustomOutlineNode* First;
	TfrxCustomOutlineNode* Last;
	TfrxCustomOutlineNode* Next;
	TfrxCustomOutlineNode* Prev;
	TfrxCustomOutlineNode* Parent;
	__fastcall TfrxCustomOutlineNode(void);
	__fastcall virtual ~TfrxCustomOutlineNode(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFOutlineNode : public TfrxCustomOutlineNode
{
	typedef TfrxCustomOutlineNode inherited;
	
public:
	/* TfrxCustomOutlineNode.Create */ inline __fastcall TfrxPDFOutlineNode(void) : TfrxCustomOutlineNode() { }
	/* TfrxCustomOutlineNode.Destroy */ inline __fastcall virtual ~TfrxPDFOutlineNode(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TfrxHTMLExportGetNavTemplate)(const System::UnicodeString ReportName, bool Multipage, bool PicsInSameFolder, System::UnicodeString Prefix, int TotalPages, System::UnicodeString &Template);

typedef void __fastcall (__closure *TfrxHTMLExportGetMainTemplate)(const System::UnicodeString Title, const System::UnicodeString FrameFolder, bool Multipage, bool Navigator, System::UnicodeString &Template);

typedef void __fastcall (__closure *TfrxHTMLExportGetToolbarTemplate)(int CurrentPage, int TotalPages, bool Multipage, bool Naviagtor, System::UnicodeString &Template);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLOutlineNode : public TfrxCustomOutlineNode
{
	typedef TfrxCustomOutlineNode inherited;
	
public:
	/* TfrxCustomOutlineNode.Create */ inline __fastcall TfrxHTMLOutlineNode(void) : TfrxCustomOutlineNode() { }
	/* TfrxCustomOutlineNode.Destroy */ inline __fastcall virtual ~TfrxHTMLOutlineNode(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCSSStyle : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString operator[](System::UnicodeString Index) { return this->Style[Index]; }
	
private:
	System::Classes::TStrings* FKeys;
	System::Classes::TStrings* FValues;
	System::UnicodeString FName;
	void __fastcall SetStyle(System::UnicodeString Index, const System::UnicodeString Value);
	void __fastcall SetPrefixStyle(System::UnicodeString Index, const System::UnicodeString Value);
	System::UnicodeString __fastcall GetStyle(System::UnicodeString Index);
	
public:
	__fastcall TfrxCSSStyle(void);
	__fastcall virtual ~TfrxCSSStyle(void);
	TfrxCSSStyle* __fastcall This(void);
	int __fastcall Count(void);
	System::UnicodeString __fastcall Text(bool Formatted = false);
	void __fastcall AssignTo(TfrxCSSStyle* Dest);
	__property System::UnicodeString Style[System::UnicodeString Index] = {read=GetStyle, write=SetStyle/*, default*/};
	__property System::UnicodeString PrefixStyle[System::UnicodeString Index] = {write=SetPrefixStyle};
	__property System::UnicodeString Name = {read=FName, write=FName};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCSS : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Frxstorage::TObjList* FStyles;
	System::Classes::TList* FStyleHashes;
	
protected:
	TfrxCSSStyle* __fastcall GetStyle(int i);
	int __fastcall GetHash(const System::UnicodeString s);
	System::UnicodeString __fastcall GetStyleName(int i);
	int __fastcall GetStylesCount(void);
	
public:
	__fastcall TfrxCSS(void);
	__fastcall virtual ~TfrxCSS(void);
	System::UnicodeString __fastcall Add(TfrxCSSStyle* Style)/* overload */;
	TfrxCSSStyle* __fastcall Add(const System::UnicodeString StyleName)/* overload */;
	void __fastcall Save(System::Classes::TStream* Stream, bool Formatted);
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TfrxPictureInfo
{
public:
	System::UnicodeString Extension;
	System::UnicodeString Mimetype;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPictureStorage : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FWorkDir;
	System::UnicodeString FPrefix;
	System::Classes::TList* FHashes;
	
protected:
	int __fastcall GetHash(System::Classes::TMemoryStream* Stream);
	
public:
	__fastcall TfrxPictureStorage(const System::UnicodeString WorkDir, System::UnicodeString Prefix);
	__fastcall virtual ~TfrxPictureStorage(void);
	System::UnicodeString __fastcall Save(Vcl::Graphics::TGraphic* Pic, Frxclass::TfrxCustomIOTransport* Filter);
	__classmethod TfrxPictureInfo __fastcall GetInfo(Vcl::Graphics::TGraphic* Pic);
};

#pragma pack(pop)

enum DECLSPEC_DENUM TfrxPictureFormat : unsigned char { pfPNG, pfEMF, pfBMP, pfJPG };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPicture : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxPictureFormat FFormat;
	Vcl::Graphics::TGraphic* FGraphic;
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Graphics::TBitmap* FBitmap;
	
public:
	__fastcall TfrxPicture(TfrxPictureFormat Format, int Width, int Height);
	__fastcall virtual ~TfrxPicture(void);
	Vcl::Graphics::TGraphic* __fastcall Release(void);
	void __fastcall SetTransparentColor(System::Uitypes::TColor TransparentColor);
	void __fastcall FillColor(System::Uitypes::TColor Color);
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
};

#pragma pack(pop)

typedef bool __fastcall (__closure *TfrxExportHandler)(Frxclass::TfrxView* Obj);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTextFragment : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FFormatted;
	System::UnicodeString FText;
	
public:
	__fastcall TTextFragment(bool AFormatted);
	void __fastcall Add(const System::UnicodeString s)/* overload */;
	void __fastcall Add(const System::UnicodeString Fmt, const System::TVarRec *Args, const int Args_High)/* overload */;
	__property System::UnicodeString Text = {read=FText};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTextFragment(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAnsiMemoryStream : public System::Classes::TMemoryStream
{
	typedef System::Classes::TMemoryStream inherited;
	
private:
	void __fastcall PutsRaw(const System::AnsiString s);
	void __fastcall PutsA(const System::AnsiString s);
	
protected:
	bool FFormatted;
	
public:
	__fastcall TAnsiMemoryStream(bool AFormatted);
	void __fastcall Puts(const System::UnicodeString s)/* overload */;
	void __fastcall Puts(const System::UnicodeString Fmt, const System::TVarRec *Args, const int Args_High)/* overload */;
	System::AnsiString __fastcall AsAnsiString(void);
public:
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TAnsiMemoryStream(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TExportHTMLDivSVGParent : public Frxexportbasedialog::TfrxBaseDialogExportFilter
{
	typedef Frxexportbasedialog::TfrxBaseDialogExportFilter inherited;
	
	
private:
	typedef System::DynamicArray<TfrxExportHandler> _TExportHTMLDivSVGParent__1;
	
	
private:
	bool FServer;
	bool FMultiPage;
	bool FFormatted;
	TfrxPictureFormat FPicFormat;
	bool FUnifiedPictures;
	bool FNavigation;
	bool FEmbeddedPictures;
	bool FEmbeddedCSS;
	bool FOutline;
	void __fastcall SetPicFormat(TfrxPictureFormat Fmt);
	void __fastcall SetMultiPage(const bool Value);
	
protected:
	System::Classes::TStream* FFilterStream;
	int FCurrentPage;
	TfrxCSS* FCSS;
	TfrxPictureStorage* FPictures;
	_TExportHTMLDivSVGParent__1 FHandlers;
	System::Classes::TStream* FCurrentFile;
	void __fastcall AttachHandler(TfrxExportHandler Handler);
	virtual void __fastcall RunExportsChain(Frxclass::TfrxView* Obj);
	System::UnicodeString __fastcall GetCSSFileName(void);
	System::UnicodeString __fastcall GetCSSFilePath(void);
	void __fastcall SaveCSS(const System::UnicodeString FileName);
	virtual void __fastcall CreateCSS(void) = 0 ;
	bool __fastcall IsCanSavePicture(Vcl::Graphics::TGraphic* Pic);
	void __fastcall SavePicture(Vcl::Graphics::TGraphic* Pic);
	void __fastcall FreeStream(void);
	void __fastcall PutsRaw(const System::AnsiString s);
	void __fastcall PutsA(const System::AnsiString s);
	void __fastcall Puts(const System::UnicodeString s)/* overload */;
	void __fastcall Puts(const System::UnicodeString Fmt, const System::TVarRec *Args, const int Args_High)/* overload */;
	System::UnicodeString __fastcall LockStyle(TfrxCSSStyle* Style);
	System::AnsiString __fastcall ExportViaVector(Frxclass::TfrxView* Obj);
	void __fastcall Vector_ExtTextOut(Frxclass::TfrxView* Obj, TAnsiMemoryStream* AMS, Frxvectorcanvas::TVector_ExtTextOut* Vector, const System::Types::TPoint &Shift);
	
public:
	__fastcall virtual TExportHTMLDivSVGParent(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual bool __fastcall Start(void);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	__property bool Server = {read=FServer, write=FServer, nodefault};
	
__published:
	__property OverwritePrompt;
	__property OpenAfterExport;
	__property bool MultiPage = {read=FMultiPage, write=SetMultiPage, nodefault};
	__property bool Formatted = {read=FFormatted, write=FFormatted, nodefault};
	__property TfrxPictureFormat PictureFormat = {read=FPicFormat, write=SetPicFormat, nodefault};
	__property bool UnifiedPictures = {read=FUnifiedPictures, write=FUnifiedPictures, nodefault};
	__property bool Navigation = {read=FNavigation, write=FNavigation, nodefault};
	__property bool EmbeddedPictures = {read=FEmbeddedPictures, write=FEmbeddedPictures, nodefault};
	__property bool EmbeddedCSS = {read=FEmbeddedCSS, write=FEmbeddedCSS, nodefault};
	__property bool Outline = {read=FOutline, write=FOutline, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TExportHTMLDivSVGParent(void) : Frxexportbasedialog::TfrxBaseDialogExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TExportHTMLDivSVGParent(void) { }
	
};


class PASCALIMPLEMENTATION TRotation2D : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Frxclass::TfrxPoint FCenter;
	System::UnicodeString FMatrix;
	
protected:
	System::Extended Sinus;
	System::Extended Cosinus;
	System::Extended C1;
	System::Extended C2;
	
public:
	void __fastcall Init(System::Extended Radian, const Frxclass::TfrxPoint &Center);
	System::UnicodeString __fastcall Turn2Str(const Frxclass::TfrxPoint &DP);
	Frxclass::TfrxPoint __fastcall Turn(const Frxclass::TfrxPoint &DP);
	__property System::UnicodeString Matrix = {read=FMatrix};
public:
	/* TObject.Create */ inline __fastcall TRotation2D(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TRotation2D(void) { }
	
};


typedef void * SCRIPT_CACHE;

typedef void * *PScriptCache;

struct DECLSPEC_DRECORD SCRIPT_ANALYSIS
{
public:
	System::Word fFlags;
	System::Word s;
};


typedef SCRIPT_ANALYSIS *PScriptAnalysis;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFRun : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	SCRIPT_ANALYSIS analysis;
	System::WideString text;
	__fastcall TfrxPDFRun(System::WideString t, SCRIPT_ANALYSIS a);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFRun(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TRemapedString
{
	
private:
	typedef System::DynamicArray<bool> _TRemapedString__1;
	
	
public:
	System::WideString Data;
	int Width;
	int SpacesCount;
	bool IsValidCharWidth;
	Frxutils::TIntegerDinArray CharWidth;
	bool IsHasLigatures;
	_TRemapedString__1 IsSpace;
};


class PASCALIMPLEMENTATION TfrxExportFont : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void * *FUSCache;
	bool FForceAnsi;
	int __fastcall GetGlyphs(HDC hdc, TfrxPDFRun* run, PWORD glyphs, System::PInteger widths, int maxGlyphs, bool rtl, bool IsIndexes = false);
	System::Classes::TList* __fastcall Itemize(System::WideString s, bool rtl, int maxItems);
	System::Classes::TList* __fastcall Layout(System::Classes::TList* runs, bool rtl);
	int __fastcall GetGlyphIndices(HDC hdc, System::WideString text, PWORD glyphs, System::PInteger widths, bool rtl, bool IsIndexes = false);
	
protected:
	Vcl::Graphics::TBitmap* GlobalTempBitmap;
	Frxtruetypecollection::TrueTypeCollection* TrueTypeTables;
	Frxtruetypefont::TrueTypeFont* ttf;
	bool PackFont;
	double PDFdpi_divider;
	double FDpiFX;
	bool FIsLigatureless;
	void __fastcall GetFontFile(void);
	TRemapedString __fastcall RemapString(System::WideString str, bool rtl, bool IsIndexes = false);
	
public:
	Vcl::Graphics::TFont* SourceFont;
	System::Classes::TList* Widths;
	System::Classes::TList* UsedAlphabet;
	System::Classes::TList* UsedAlphabetUnicode;
	_OUTLINETEXTMETRICA *TextMetric;
	char *FontData;
	int FontDataSize;
	__fastcall TfrxExportFont(Vcl::Graphics::TFont* Font);
	__fastcall virtual ~TfrxExportFont(void);
	TRemapedString __fastcall SoftRemapString(System::WideString str, bool rtl, bool IsIndexes = false);
	__property bool ForceAnsi = {write=FForceAnsi, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define outlineCSS L".outlineCSS,   .outlineCSS ul,  .outlineCSS li {   margin:"\
	L" 0;    padding: 0;    line-height: 1;   list-style: none; "\
	L"}  .outlineCSS ul {   margin: 0 0 0 .5em; }  .outlineCSS >"\
	L" li:not(:only-child), .outlineCSS li li {   position: rela"\
	L"tive;  padding: .2em 0 0 1.2em;}  .outlineCSS li:not(:last"\
	L"-child) {  border-left: 1px solid #ccc; }  .outlineCSS li "\
	L"li:before,.outlineCSS > li:not(:only-child):before {  cont"\
	L"ent: \"\";   position: absolute;    top: 0;   left: 0;   w"\
	L"idth: 1.1em;   height: .7em;    border-bottom: 1px solid #"\
	L"ccc; } .outlineCSS li:last-child:before {   width: calc(1."\
	L"1em - 1px);   border-left: 1px solid #ccc; } .outlineCSS ."\
	L"drop {   position: absolute;   left: -.5em;   top: .4em;  "\
	L" width: .9em;   height: .9em;    line-height: .9em;   text"\
	L"-align: center;    background: #fff;   font-size: 80%;    "\
	L"cursor: pointer; } .outlineCSS li:last-child > .drop {   m"\
	L"argin-left: 1px;  } .outlineCSS .drop ~ ul {   display: no"\
	L"ne;  } .outlineCSS .dropM ~ ul {   display: block; } .outl"\
	L"ineNode {color : black; text-decoration: none;} .blockOutl"\
	L"ine { position: fixed; height: 95%;   width: 200px; overfl"\
	L"ow-x: scroll;   overflow-y: scroll; left: 0%; padding: 0 1"\
	L"0px;  margin: 0 10px;border:1mm solid orange;margin:5mm;  "\
	L" box-shadow:3mm 3mm 3mm gray;   -webkit-box-shadow:3mm 3mm"\
	L" 3mm gray;-moz-box-shadow:3mm 3mm 3mm gray;   -ms-box-shad"\
	L"ow:3mm 3mm 3mm gray;-o-box-shadow:3mm 3mm 3mm gray;   bord"\
	L"er-radius:2mm;-webkit-border-radius:2mm;-moz-border-radius"\
	L":2mm;   -ms-border-radius:2mm;-o-border-radius:2mm;} .bloc"\
	L"kReport {position: relative; left: 250px;} .blockTableOutl"\
	L"ine {  display: block; position: fixed;  width: 200px;   o"\
	L"verflow: scroll; height : 95%;    border-top-color: grey; "\
	L"  border-top-style: inset;   border-top-width: 2px;  borde"\
	L"r-bottom-color: grey;  border-bottom-style: inset;  border"\
	L"-bottom-width: 2px;  border-right-color: grey;  border-rig"\
	L"ht-style: inset;  border-right-width: 2px;  border-left-co"\
	L"lor: grey;  border-left-style: inset;  border-left-width: "\
	L"2px;  padding: 0 10px;  margin: 0 5px; } "
#define outlineJS L"<script type=\"text/javascript\"> \t(function() { \t  var "\
	L"ul = document.querySelectorAll('.outlineCSS > li:not(:only"\
	L"-child) ul, .outlineCSS ul ul'); \t  for (var i = 0; i < u"\
	L"l.length; i++) {  \t\tvar div = document.createElement('di"\
	L"v');  \t\tdiv.className = 'drop'; \t\tdiv.innerHTML = '+';"\
	L"  \t\tul[i].parentNode.insertBefore(div, ul[i].previousSib"\
	L"ling);  \t\tdiv.onclick = function() {  \t\t  this.innerHT"\
	L"ML = (this.innerHTML == '+' ? '-' : '+')  ;\t\t  this.clas"\
	L"sName = (this.className == 'drop' ? 'drop dropM' : 'drop')"\
	L";  \t\t} \t  } \t})(); </script>"
static const System::Int8 spStroke = System::Int8(0x1);
static const System::Int8 spHTML = System::Int8(0x2);
extern DELPHI_PACKAGE void __fastcall AddLigatureless(System::UnicodeString FontName);
extern DELPHI_PACKAGE void __fastcall DeleteLigatureless(System::UnicodeString FontName);
extern DELPHI_PACKAGE double __fastcall ArrayAvg(Frxanaliticgeometry::TDoubleArray A);
extern DELPHI_PACKAGE double __fastcall ArraySum(Frxanaliticgeometry::TDoubleArray A)/* overload */;
extern DELPHI_PACKAGE int __fastcall ArraySum(Frxutils::TIntegerDinArray A)/* overload */;
extern DELPHI_PACKAGE unsigned __fastcall ArraySum(Frxutils::TLongWordDinArray A)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsInclude(const unsigned Options, const unsigned Param);
extern DELPHI_PACKAGE bool __fastcall IsDevanagari(System::WideString WS);
extern DELPHI_PACKAGE bool __fastcall IsCJK(System::WideString WS);
extern DELPHI_PACKAGE System::Extended __fastcall PiecewiseLinearInterpolation(int Rotation, int *X, const int X_High, int *Y, const int Y_High);
extern DELPHI_PACKAGE void __fastcall BitmapFill(Vcl::Graphics::TBitmap* Bitmap, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE bool __fastcall IsTransparentPNG(Frxclass::TfrxView* Obj);
extern DELPHI_PACKAGE System::AnsiString __fastcall GraphicToBase64AnsiString(Vcl::Graphics::TGraphic* Graphic);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxPoint2Str(const Frxclass::TfrxPoint &DP)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxPoint2Str(System::Extended X, System::Extended Y)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall Float2Str(const System::Extended Value, const int Prec = 0x3);
extern DELPHI_PACKAGE System::WideString __fastcall SVGStartSpace(const System::WideString s);
extern DELPHI_PACKAGE System::WideString __fastcall SVGEscapeTextAndAttribute(const System::WideString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SVGUniqueID(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SVGDasharray(Frxclass::TfrxFrameStyle Style, System::Extended LineWidth);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SVGLine(bool Formatted, bool ZeroBased, TfrxCSS* CSS, Frxclass::TfrxLineView* Line);
extern DELPHI_PACKAGE void __fastcall CalcGlassRect(Frxclass::TfrxGlassFillOrientation Orientation, System::Extended AbsTop, System::Extended AbsLeft, int &x, int &y, int &Width, int &Height);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SVGShapePath(Frxclass::TfrxShapeView* Shape, int Options = 0x0);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SVGPattern(bool Formatted, bool XLine, bool YLine, bool Turn, System::Uitypes::TColor Color, System::Extended LineWidth, System::UnicodeString Name);
extern DELPHI_PACKAGE System::WideString __fastcall StrFindAndReplace(const System::WideString Source, const System::WideString Dlm, System::WideString *SFR, const int SFR_High);
extern DELPHI_PACKAGE bool __fastcall IsHasHTMLTags(const System::UnicodeString s);
extern DELPHI_PACKAGE bool __fastcall IsHasSpecialChars(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetBorderRadius(int Curve);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetCursor(System::Uitypes::TCursor Cursor);
extern DELPHI_PACKAGE void __fastcall PrepareHTMLOutline(Frxclass::TfrxCustomOutline* Outline, TfrxHTMLOutlineNode* Node, int ObjNum);
extern DELPHI_PACKAGE void __fastcall WriteHTMLOutline(TfrxHTMLOutlineNode* Node, System::UnicodeString &html);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetIdOutlineHTML(System::Extended Top, System::Extended Height, TfrxHTMLOutlineNode* &FOutlineTree, System::Extended PageH);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReverseSlash(const System::UnicodeString S);
}	/* namespace Frxexporthelpers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTHELPERS)
using namespace Frxexporthelpers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexporthelpersHPP
