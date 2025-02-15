// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRXMLSFilt.pas' rev: 32.00 (Windows)

#ifndef QrxmlsfiltHPP
#define QrxmlsfiltHPP

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

namespace Qrxmlsfilt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRXAbstractExportFilter;
class DELPHICLASS TQRXDocumentFilter;
class DELPHICLASS TQRXMLSFilter;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRXAbstractExportFilter : public Qrprntr::TQRExportFilter
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
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FActiveFont;
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
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
	__property System::Extended CharWidth = {read=FCharWidth, write=FCharWidth};
	__property System::Extended CharHeight = {read=FCharHeight, write=FCharHeight};
	__property System::Extended PaperWidth = {read=FPaperWidth, write=FPaperWidth};
	__property System::Extended PaperHeight = {read=FPaperHeight, write=FPaperHeight};
	__property int LineCount = {read=FLineCount, write=FLineCount, nodefault};
	__property int ColCount = {read=FColCount, write=FColCount, nodefault};
	
public:
	__fastcall virtual TQRXAbstractExportFilter(System::UnicodeString filename);
	__fastcall virtual ~TQRXAbstractExportFilter(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall AcceptBand(Vcl::Controls::TControl* aBand, System::Extended Xoff, System::Extended Yoff, System::Extended Expanded);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
};


typedef void __fastcall (__closure *TQRXImageURLNeeded)(System::TObject* Sender, Vcl::Controls::TControl* ImageCtrl, System::UnicodeString &ImageURL, bool &IncludeByRef);

class PASCALIMPLEMENTATION TQRXDocumentFilter : public TQRXAbstractExportFilter
{
	typedef TQRXAbstractExportFilter inherited;
	
private:
	bool FFreeStream;
	int FLastRecordNum;
	int FNextPicNum;
	int FPagenumber;
	System::UnicodeString FDocType;
	System::UnicodeString FCreator;
	System::UnicodeString FTitle;
	System::UnicodeString FAuthor;
	System::UnicodeString FDocDate;
	System::UnicodeString FCopyright;
	System::UnicodeString FOrientation;
	System::UnicodeString FXLStyleURL;
	bool FConcatenating;
	bool FCompressImages;
	System::UnicodeString FXLEncoding;
	int FCodepage;
	bool FDoImages;
	TQRXImageURLNeeded FOnImageURLNeeded;
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual bool __fastcall GetStreaming(void);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	
public:
	double VertLineAdjust;
	double HorizLineAdjust;
	double LeftMarginAdjust;
	__fastcall virtual TQRXDocumentFilter(System::UnicodeString filename);
	void __fastcall NewDocument(System::Classes::TStringList* doclist, double PaperWidth, double PaperHeight, System::UnicodeString Papername, System::UnicodeString orient);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	void __fastcall LoadDTD(System::Classes::TStringList* &dlist);
	virtual void __fastcall ProcessPage(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	void __fastcall EndConcat(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall EndPage(void);
	void __fastcall AcceptVector(System::Classes::TStringList* comms);
	virtual void __fastcall AcceptBand(Vcl::Controls::TControl* aBand, System::Extended Xoff, System::Extended Yoff, System::Extended Expanded);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	void __fastcall SetDocumentProperties(System::UnicodeString author, System::UnicodeString title, System::UnicodeString copyright);
	void __fastcall AddToStream(System::Classes::TStringList* xmlInlist);
	__property Stream;
	__property bool FreeStream = {read=FFreeStream, write=FFreeStream, nodefault};
	__property System::UnicodeString Orientation = {read=FOrientation, write=FOrientation};
	__property System::UnicodeString Creator = {read=FCreator, write=FCreator};
	__property System::UnicodeString Author = {read=FAuthor, write=FAuthor};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::UnicodeString DocDate = {read=FDocDate, write=FDocDate};
	__property System::UnicodeString Copyright = {read=FCopyright, write=FCopyright};
	__property System::UnicodeString DocType = {read=FDocType, write=FDocType};
	__property System::UnicodeString XLEncoding = {read=FXLEncoding, write=FXLEncoding};
	__property System::UnicodeString XLStyleURL = {read=FXLStyleURL, write=FXLStyleURL};
	__property bool CompressImages = {read=FCompressImages, write=FCompressImages, nodefault};
	__property bool DoImages = {read=FDoImages, write=FDoImages, nodefault};
	__property bool Concatenating = {read=FConcatenating, write=FConcatenating, nodefault};
	__property TQRXImageURLNeeded OnImageURLNeeded = {read=FOnImageURLNeeded, write=FOnImageURLNeeded};
	__property TextEncoding;
public:
	/* TQRXAbstractExportFilter.Destroy */ inline __fastcall virtual ~TQRXDocumentFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRXMLSFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	__fastcall virtual TQRXMLSFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRXMLSFilter(void);
	
__published:
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define CRLF L"\r\n"
static const System::Word ORD0 = System::Word(0x30);
static const System::Word ORDA = System::Word(0x41);
extern DELPHI_PACKAGE System::UnicodeString __fastcall basename(System::UnicodeString fname);
extern DELPHI_PACKAGE void __fastcall RunLength(System::Classes::TStream* Source, System::Classes::TStream* Target);
}	/* namespace Qrxmlsfilt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRXMLSFILT)
using namespace Qrxmlsfilt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrxmlsfiltHPP
