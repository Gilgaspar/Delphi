// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRNewXLSXFilt.pas' rev: 32.00 (Windows)

#ifndef QrnewxlsxfiltHPP
#define QrnewxlsxfiltHPP

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
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <System.UITypes.hpp>
#include <System.Zip.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrnewxlsxfilt
{
//-- forward type declarations -----------------------------------------------
struct XLXSTextItem;
class DELPHICLASS TQXLSXAbstractExportFilter;
class DELPHICLASS TQRXLSXDocumentFilter;
class DELPHICLASS TQRXLSXFilter;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD XLXSTextItem
{
public:
	int row;
	int col;
	System::Extended X;
	System::Extended Y;
	System::UnicodeString text;
	System::UnicodeString fontname;
	Qrprntr::TExportType exportAs;
	bool fontbold;
	bool fontitalic;
	bool fontstrike;
	int fontsize;
	System::Uitypes::TColor fontcolor;
	System::UnicodeString controlName;
	Qrprntr::TXLNumFormat XLNumFormat;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQXLSXAbstractExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	System::Classes::TStream* FStream;
	int FLineCount;
	int FColCount;
	bool FPageProcessed;
	
protected:
	System::UnicodeString __fastcall GetText(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* &Font);
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	void __fastcall WriteToStream(const System::UnicodeString AText);
	void __fastcall WriteLnToStream(const System::UnicodeString AText);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	virtual void __fastcall ProcessPage(void);
	virtual void __fastcall StorePage(void);
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property bool PageProcessed = {read=FPageProcessed, write=FPageProcessed, nodefault};
	__property int LineCount = {read=FLineCount, write=FLineCount, nodefault};
	__property int ColCount = {read=FColCount, write=FColCount, nodefault};
	
public:
	__fastcall virtual TQXLSXAbstractExportFilter(System::UnicodeString filename);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewPage(void);
public:
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQXLSXAbstractExportFilter(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRXLSXDocumentFilter : public TQXLSXAbstractExportFilter
{
	typedef TQXLSXAbstractExportFilter inherited;
	
	
private:
	typedef System::DynamicArray<XLXSTextItem> _TQRXLSXDocumentFilter__1;
	
	
private:
	bool FFreeStream;
	int FLastRecordNum;
	int FPagenumber;
	System::UnicodeString FTitle;
	System::UnicodeString FLastAuthor;
	System::UnicodeString FCreated;
	System::UnicodeString FLastSaved;
	System::UnicodeString FXLStyleURL;
	bool FConcatenating;
	System::UnicodeString FXLEncoding;
	_TQRXLSXDocumentFilter__1 FItems;
	System::Classes::TStringList* FSortList;
	System::Classes::TStringList* FStylenames;
	System::Classes::TStringList* FFontTags;
	int FItemcount;
	System::Classes::TStringList* Content_Types;
	System::Classes::TStringList* dotrels;
	System::Classes::TStringList* app;
	System::Classes::TStringList* core;
	System::Classes::TStringList* sharedStrings;
	System::Classes::TStringList* styles;
	System::Classes::TStringList* workbook;
	System::Classes::TStringList* theme1;
	System::Classes::TStringList* sheet1;
	System::Classes::TStringList* workbook_xml_rels;
	System::Classes::TStringList* celldupcheck;
	System::Extended FPageYOffset;
	System::Extended FMaxYValue;
	int rowno;
	int colno;
	int maxcols;
	void __fastcall SetWorkSheetName(System::UnicodeString value);
	System::UnicodeString __fastcall getWorkSheetName(void);
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual bool __fastcall GetStreaming(void);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	void __fastcall ProcessItems(void);
	void __fastcall LoadProlog(void);
	virtual void __fastcall ProcessPage(void);
	
public:
	__fastcall virtual TQRXLSXDocumentFilter(System::UnicodeString filename);
	__fastcall virtual ~TQRXLSXDocumentFilter(void);
	virtual void __fastcall TextOutRec(const Qrprntr::TExportInfoRec &ExportInfo);
	void __fastcall NewDocument(System::Classes::TStringList* doclist, double PaperWidth, double PaperHeight, System::UnicodeString Papername, System::UnicodeString orient);
	void __fastcall SetColWidths(int startcol, int endcol, System::Extended cwidth);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	void __fastcall EndConcat(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall EndPage(void);
	void __fastcall SetDocumentProperties(System::UnicodeString author, System::UnicodeString title, System::UnicodeString company);
	__property Stream;
	__property bool FreeStream = {read=FFreeStream, write=FFreeStream, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::UnicodeString LastAuthor = {read=FLastAuthor, write=FLastAuthor};
	__property System::UnicodeString Created = {read=FCreated, write=FCreated};
	__property System::UnicodeString LastSaved = {read=FLastSaved, write=FLastSaved};
	__property System::UnicodeString XLEncoding = {read=FXLEncoding, write=FXLEncoding};
	__property System::UnicodeString XLStyleURL = {read=FXLStyleURL, write=FXLStyleURL};
	__property bool Concatenating = {read=FConcatenating, write=FConcatenating, nodefault};
	__property System::UnicodeString WorkSheetname = {read=getWorkSheetName, write=SetWorkSheetName};
};


class PASCALIMPLEMENTATION TQRXLSXFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	void __fastcall SetWorkSheetName(System::UnicodeString value);
	System::UnicodeString __fastcall getWorkSheetName(void);
	
public:
	__fastcall virtual TQRXLSXFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRXLSXFilter(void);
	
__published:
	__property System::UnicodeString WorkSheetname = {read=getWorkSheetName, write=SetWorkSheetName};
};


//-- var, const, procedure ---------------------------------------------------
#define CRLF L"\r\n"
static const System::Word ORD0 = System::Word(0x30);
static const System::Word ORDA = System::Word(0x41);
extern DELPHI_PACKAGE System::UnicodeString __fastcall EntityReplace(System::UnicodeString &ctext);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ColTrans(System::Uitypes::TColor ct);
}	/* namespace Qrnewxlsxfilt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRNEWXLSXFILT)
using namespace Qrnewxlsxfilt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrnewxlsxfiltHPP
