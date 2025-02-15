// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRXLSXFilt.pas' rev: 30.00 (Windows)

#ifndef QrxlsxfiltHPP
#define QrxlsxfiltHPP

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

//-- user supplied -----------------------------------------------------------

namespace Qrxlsxfilt
{
//-- forward type declarations -----------------------------------------------
struct XLXSTextItem;
class DELPHICLASS TQRXMLSSAbstractExportFilter;
class DELPHICLASS TQRXMLSSDocumentFilter;
class DELPHICLASS TQRXMLSSFilter;
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
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRXMLSSAbstractExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	System::Classes::TStream* FStream;
	int FLineCount;
	int FColCount;
	bool FPageProcessed;
	System::Classes::TStringList* dlist;
	
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
	__fastcall virtual TQRXMLSSAbstractExportFilter(System::UnicodeString filename);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewPage(void);
public:
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRXMLSSAbstractExportFilter(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRXMLSSDocumentFilter : public TQRXMLSSAbstractExportFilter
{
	typedef TQRXMLSSAbstractExportFilter inherited;
	
	
private:
	typedef System::DynamicArray<XLXSTextItem> _TQRXMLSSDocumentFilter__1;
	
	
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
	_TQRXMLSSDocumentFilter__1 FItems;
	System::Classes::TStringList* FSortList;
	System::Classes::TStringList* FStylenames;
	System::Classes::TStringList* FFontTags;
	int FItemcount;
	System::Extended FPageYOffset;
	System::Extended FMaxYValue;
	int rowno;
	int colno;
	int maxcols;
	int fixline1;
	int styleinsert;
	void __fastcall SetCreator(System::UnicodeString value);
	System::UnicodeString __fastcall getCreator(void);
	System::UnicodeString __fastcall getAuthor(void);
	void __fastcall SetAuthor(System::UnicodeString value);
	void __fastcall SetCompany(System::UnicodeString value);
	System::UnicodeString __fastcall getCompany(void);
	void __fastcall SetWorkSheetName(System::UnicodeString value);
	System::UnicodeString __fastcall getWorkSheetName(void);
	void __fastcall SetOpenWidth(int value);
	int __fastcall getOpenWidth(void);
	int __fastcall getOpenHeight(void);
	void __fastcall SetOpenHeight(int value);
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual bool __fastcall GetStreaming(void);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	void __fastcall ProcessItems(void);
	
public:
	__fastcall virtual TQRXMLSSDocumentFilter(System::UnicodeString filename);
	__fastcall virtual ~TQRXMLSSDocumentFilter(void);
	virtual void __fastcall TextOutRec(const Qrprntr::TExportInfoRec &ExportInfo);
	void __fastcall NewDocument(System::Classes::TStringList* doclist, double PaperWidth, double PaperHeight, System::UnicodeString Papername, System::UnicodeString orient);
	void __fastcall LoadProlog(void);
	virtual void __fastcall ProcessPage(void);
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
	__property int OpenWidth = {read=getOpenWidth, write=SetOpenWidth, nodefault};
	__property int OpenHeight = {read=getOpenHeight, write=SetOpenHeight, nodefault};
	__property System::UnicodeString Creator = {read=getCreator, write=SetCreator};
	__property System::UnicodeString Author = {read=getAuthor, write=SetAuthor};
	__property System::UnicodeString Company = {read=getCompany, write=SetCompany};
	__property System::UnicodeString WorkSheetname = {read=getWorkSheetName, write=SetWorkSheetName};
};


class PASCALIMPLEMENTATION TQRXMLSSFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	void __fastcall SetCreator(System::UnicodeString value);
	System::UnicodeString __fastcall getCreator(void);
	System::UnicodeString __fastcall getAuthor(void);
	void __fastcall SetAuthor(System::UnicodeString value);
	void __fastcall SetCompany(System::UnicodeString value);
	System::UnicodeString __fastcall getCompany(void);
	void __fastcall SetWorkSheetName(System::UnicodeString value);
	System::UnicodeString __fastcall getWorkSheetName(void);
	void __fastcall SetOpenWidth(int value);
	int __fastcall getOpenWidth(void);
	int __fastcall getOpenHeight(void);
	void __fastcall SetOpenHeight(int value);
	
public:
	__fastcall virtual TQRXMLSSFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRXMLSSFilter(void);
	
__published:
	__property int OpenWidth = {read=getOpenWidth, write=SetOpenWidth, nodefault};
	__property int OpenHeight = {read=getOpenHeight, write=SetOpenHeight, nodefault};
	__property System::UnicodeString Creator = {read=getCreator, write=SetCreator};
	__property System::UnicodeString Author = {read=getAuthor, write=SetAuthor};
	__property System::UnicodeString Company = {read=getCompany, write=SetCompany};
	__property System::UnicodeString WorkSheetname = {read=getWorkSheetName, write=SetWorkSheetName};
};


//-- var, const, procedure ---------------------------------------------------
#define CRLF L"\r\n"
static const System::Word ORD0 = System::Word(0x30);
static const System::Word ORDA = System::Word(0x41);
extern DELPHI_PACKAGE System::UnicodeString __fastcall EntityReplace(System::UnicodeString &ctext);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ColTrans(System::Uitypes::TColor ct);
}	/* namespace Qrxlsxfilt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRXLSXFILT)
using namespace Qrxlsxfilt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrxlsxfiltHPP
