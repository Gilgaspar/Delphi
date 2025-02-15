// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRXDocument.pas' rev: 30.00 (Windows)

#ifndef QrxdocumentHPP
#define QrxdocumentHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.OleServer.hpp>
#include <MSXML_TLB.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Printers.hpp>
#include <QuickRpt.hpp>
#include <QRPrntr.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrxdocument
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPageItem;
class DELPHICLASS THintItem;
class DELPHICLASS TQRXDocument;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TMouseEvent)(System::UnicodeString controlName, System::UnicodeString controlText, int recNum);

typedef void __fastcall (__closure *TButtonEvent)(System::TObject* sender);

enum DECLSPEC_DENUM TQRXBrowserState : unsigned char { bsReady, bsBusy };

enum DECLSPEC_DENUM TVecComm : unsigned char { moveto = 1, lineto, ellipse, rectangle, pencolor, brushcolor, penstyle, brushstyle, penwidth, textout, setFont, setFontSize };

enum DECLSPEC_DENUM THTMLMode : unsigned char { hmSinglePage, hmMultipage };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPageItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int xpos;
	int ypos;
	int width;
	int height;
	int DBRecord;
	System::UnicodeString controlID;
	System::UnicodeString cText;
	__fastcall TPageItem(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPageItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION THintItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString controlID;
	System::UnicodeString hint;
	__fastcall THintItem(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THintItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRXDocument : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Msxml_tlb::TDOMDocument* FDomDocument;
	Quickrpt::TCustomQuickRep* FCurrentQR;
	System::UnicodeString FDocumentFile;
	int FCurrentPage;
	double FPagewidth;
	double FPageheight;
	int FPagecount;
	bool PageHasChanged;
	bool FShowImagesInThumbs;
	Vcl::Extctrls::TImage* FImageControl;
	System::Classes::TStringList* FPageItems;
	System::Classes::TStringList* FPageBands;
	System::Extended FZoomfactor;
	System::Extended FPrintZoom;
	System::Classes::TStream* FStream;
	int FNextImage;
	System::UnicodeString FImagepath;
	bool FDocumentLoaded;
	System::UnicodeString FTitle;
	System::UnicodeString FPapername;
	bool FUseImageURL;
	bool FShowprogress;
	System::UnicodeString FHTMLImageURL;
	TMouseEvent FOnClick;
	TMouseEvent FOnBandClick;
	TMouseEvent FOnMouseover;
	TMouseEvent FOnMouseOut;
	TButtonEvent FOnPrintClicked;
	TButtonEvent FOnPrintSetupClicked;
	TButtonEvent FOnSaveClicked;
	TButtonEvent FOnLoadClicked;
	bool FShowthumbs;
	bool FShowSearch;
	bool FShowToolbar;
	bool FShowPrintButtons;
	bool FShowSave;
	bool FShowLoad;
	int FInitwidth;
	int FInitHeight;
	int FInitTop;
	int FInitLeft;
	System::Extended FInitZoom;
	Qrprntr::TQRZoomState FInitZoomState;
	System::Uitypes::TWindowState FInitWindowState;
	System::Classes::TStringList* FHintlist;
	System::Classes::TStringList* FTextindex;
	System::UnicodeString FSearchText;
	int FOrientation;
	System::Uitypes::TPrinterOrientation FPOrientation;
	System::Extended FPrinterOffsetX;
	System::Extended FPrinterOffsetY;
	System::Extended FPixelsPerX;
	System::Extended FPixelsPerY;
	void __fastcall SetDocumentFile(System::UnicodeString filename);
	void __fastcall SetFPOrientation(System::Uitypes::TPrinterOrientation value);
	void __fastcall SetCurrentPage(int value);
	void __fastcall RegisterBand(Msxml_tlb::_di_IXMLDOMNode dnode, Vcl::Graphics::TCanvas* acanvas);
	void __fastcall RenderText(Msxml_tlb::_di_IXMLDOMNode dnode, Vcl::Graphics::TCanvas* acanvas);
	void __fastcall RenderGraphic(Msxml_tlb::_di_IXMLDOMNode dnode, Vcl::Graphics::TCanvas* acanvas);
	void __fastcall RenderImage(Msxml_tlb::_di_IXMLDOMNode dnode, Vcl::Graphics::TCanvas* acanvas);
	void __fastcall RenderVector(Msxml_tlb::_di_IXMLDOMNode dnode, Vcl::Graphics::TCanvas* acanvas);
	void __fastcall DummyImage(Msxml_tlb::_di_IXMLDOMNode dnode, Vcl::Graphics::TCanvas* acanvas);
	void __fastcall RenderOnePage(int pagenum, Msxml_tlb::TDOMDocument* aDomDocument, int fpagewidth, int fpageheight, bool ToPrinter);
	int __fastcall GetPageCount(void);
	void __fastcall ReadQXDDocument(Msxml_tlb::TDOMDocument* aDomDocument);
	void __fastcall WriteToStream(System::UnicodeString tx);
	void __fastcall HTMLGraphic(Msxml_tlb::_di_IXMLDOMNode dnode, int pagenum);
	void __fastcall HTMLImage(Msxml_tlb::_di_IXMLDOMNode dnode, int pagenum);
	void __fastcall HTMLText(Msxml_tlb::_di_IXMLDOMNode dnode, int pagenum);
	void __fastcall HTMLOnePage(int pagenum, Msxml_tlb::TDOMDocument* aDomDocument);
	void __fastcall LoadQXDString(System::UnicodeString instring, Msxml_tlb::TDOMDocument* aDomDocument);
	void __fastcall LoadQXDFile(System::UnicodeString filename, Msxml_tlb::TDOMDocument* aDomDocument);
	void __fastcall GetAttributes(Msxml_tlb::_di_IXMLDOMNode dnode, double &x, double &y, double &iwidth, double &iheight, int &layer, System::Uitypes::TColor &fcolor);
	void __fastcall ViewReportInt(Quickrpt::TCustomQuickRep* QReport, bool modal);
	void __fastcall ViewCompositeReportInt(Quickrpt::TQRCompositeReport* CReport, bool modal);
	void __fastcall ClearLists(void);
	
public:
	int FirstPage;
	int LastPage;
	THTMLMode HTMLExportMode;
	System::UnicodeString CurrentFile;
	System::UnicodeString HTMLImageURL;
	__fastcall virtual TQRXDocument(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRXDocument(void);
	void __fastcall SaveAsPDFStream(System::Classes::TStream* pdfstream);
	void __fastcall PDFOnePage(int pagenum, Msxml_tlb::TDOMDocument* aDomDocument, int fpagewidth, int fpageheight);
	void __fastcall PDFText(Msxml_tlb::_di_IXMLDOMNode dnode);
	void __fastcall PDFGraphic(Msxml_tlb::_di_IXMLDOMNode dnode);
	void __fastcall PDFImage(Msxml_tlb::_di_IXMLDOMNode dnode);
	void __fastcall RenderPage(int pagenum);
	void __fastcall MakeTextIndex(void);
	void __fastcall FindText(System::UnicodeString cText, bool matchCase, System::Classes::TStrings* resList);
	void __fastcall SaveReportAsXML(Quickrpt::TCustomQuickRep* QReport, System::UnicodeString fileName);
	void __fastcall ViewReport(Quickrpt::TCustomQuickRep* QReport);
	void __fastcall ViewCompositeReport(Quickrpt::TQRCompositeReport* CReport);
	void __fastcall ViewReportModal(Quickrpt::TCustomQuickRep* QReport);
	void __fastcall RenderPageToBM(Vcl::Graphics::TBitmap* pagemap, int pagenum);
	void __fastcall RenderPageToMetafile(Vcl::Graphics::TMetafileCanvas* metacanvas, int pagenum);
	void __fastcall SetImageControl(Vcl::Extctrls::TImage* iCont);
	void __fastcall SetZoomFactor(System::Extended value);
	System::UnicodeString __fastcall GetControlFromPosition(int x, int y, System::UnicodeString &cText, int &DBRecordNum);
	System::UnicodeString __fastcall GetBandFromPosition(int x, int y, System::UnicodeString &cText, int &DBRecordNum);
	void __fastcall ViewDocument(bool modal);
	void __fastcall LoadAndViewXML(System::UnicodeString filename, System::Classes::TStream* inStream, bool modal);
	void __fastcall LoadFromFile(System::UnicodeString filename);
	void __fastcall LoadFromStream(System::Classes::TStream* instream);
	void __fastcall AddPage(Msxml_tlb::_di_IXMLDOMNode pagenode);
	void __fastcall SaveToFile(System::UnicodeString filename);
	void __fastcall SaveToStream(System::Classes::TStream* outstr);
	void __fastcall InitialiseDoc(System::UnicodeString title, double pagewidth, double pageheight, System::UnicodeString papername, System::UnicodeString orient, System::UnicodeString stylesheetURI);
	void __fastcall SaveAsQRPFile(System::UnicodeString qrpfile);
	void __fastcall SaveAsPDFFile(System::UnicodeString pdffile);
	void __fastcall SaveAsHTMLStream(System::Classes::TStream* htmstream);
	void __fastcall SaveAsHTMLFile(System::UnicodeString htmfile);
	void __fastcall Print(Vcl::Printers::TPrinter* aprinter);
	void __fastcall ReplaceToken(System::UnicodeString token, System::UnicodeString replacement);
	void __fastcall ReNumberpages(System::UnicodeString pagetoken, System::UnicodeString counttoken);
	void __fastcall FireEvent(Quickrpt::TPrevEventType eventNum, System::UnicodeString cName, System::UnicodeString CText, int rec);
	void __fastcall ZoomToWidth(System::Extended reqWidth);
	void __fastcall ZoomToHeight(System::Extended reqHeight);
	Vcl::Graphics::TBitmap* __fastcall RenderOneThumb(int pagenum, Msxml_tlb::TDOMDocument* aDomDocument, int fpagewidth, int fpageheight, const System::Types::TRect &thRect);
	Vcl::Graphics::TBitmap* __fastcall RenderThumbnail(int pagenum, const System::Types::TRect &thumbRect);
	void __fastcall AddHint(System::UnicodeString controlName, System::UnicodeString hintText);
	System::UnicodeString __fastcall GetHint(System::UnicodeString cName);
	System::Extended __fastcall GetZoom(void);
	void __fastcall SetSearchText(System::UnicodeString value);
	Msxml_tlb::_di_IXMLDOMNode __fastcall GetPage(int Pagenum);
	void __fastcall ShowConnectionDlg(void);
	__property Quickrpt::TCustomQuickRep* Quickrep = {read=FCurrentQR};
	__property System::Extended PrintZoom = {read=FPrintZoom, write=FPrintZoom};
	
__published:
	__property bool ShowImagesInThumbs = {read=FShowImagesInThumbs, write=FShowImagesInThumbs, nodefault};
	__property bool ShowSaveButton = {read=FShowSave, write=FShowSave, nodefault};
	__property bool ShowLoadButton = {read=FShowLoad, write=FShowLoad, nodefault};
	__property bool ShowPrintButtons = {read=FShowPrintButtons, write=FShowPrintButtons, nodefault};
	__property bool ShowToolbar = {read=FShowToolbar, write=FShowToolbar, nodefault};
	__property bool Showthumbs = {read=FShowthumbs, write=FShowthumbs, nodefault};
	__property bool ShowSearch = {read=FShowSearch, write=FShowSearch, nodefault};
	__property bool DocumentLoaded = {read=FDocumentLoaded, nodefault};
	__property int InitViewerWidth = {read=FInitwidth, write=FInitwidth, nodefault};
	__property int InitViewerHeight = {read=FInitHeight, write=FInitHeight, nodefault};
	__property int InitViewerTop = {read=FInitTop, write=FInitTop, nodefault};
	__property int InitViewerLeft = {read=FInitLeft, write=FInitLeft, nodefault};
	__property System::Extended InitViewerZoom = {read=FInitZoom, write=FInitZoom};
	__property Qrprntr::TQRZoomState InitViewerZoomState = {read=FInitZoomState, write=FInitZoomState, nodefault};
	__property System::Uitypes::TWindowState InitViewerState = {read=FInitWindowState, write=FInitWindowState, nodefault};
	__property bool ShowProgress = {read=FShowprogress, write=FShowprogress, nodefault};
	__property System::Extended ZoomFactor = {read=FZoomfactor, write=SetZoomFactor};
	__property System::UnicodeString DocumentFile = {read=FDocumentFile, write=SetDocumentFile};
	__property System::UnicodeString ReportTitle = {read=FTitle, write=FTitle};
	__property int CurrentPage = {read=FCurrentPage, write=SetCurrentPage, nodefault};
	__property int Pagecount = {read=GetPageCount, nodefault};
	__property double Pagewidth = {read=FPagewidth};
	__property double Pageheight = {read=FPageheight};
	__property TMouseEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TMouseEvent OnBandClick = {read=FOnBandClick, write=FOnBandClick};
	__property TMouseEvent OnMouseOver = {read=FOnMouseover, write=FOnMouseover};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FPOrientation, write=SetFPOrientation, nodefault};
	__property TMouseEvent OnMouseOut = {read=FOnMouseOut, write=FOnMouseOut};
	__property TButtonEvent OnPrintClicked = {read=FOnPrintClicked, write=FOnPrintClicked};
	__property TButtonEvent OnPrintSetupClicked = {read=FOnPrintSetupClicked, write=FOnPrintSetupClicked};
	__property TButtonEvent OnSaveClicked = {read=FOnSaveClicked, write=FOnSaveClicked};
	__property TButtonEvent OnLoadClicked = {read=FOnLoadClicked, write=FOnLoadClicked};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word ORD0 = System::Word(0x30);
static const System::Word ORDA = System::Word(0x41);
static const System::Extended mmToPoints = 2.834646E+00;
extern DELPHI_PACKAGE double mmToPix;
extern DELPHI_PACKAGE System::WideChar * __fastcall MakeZTS(System::UnicodeString src);
extern DELPHI_PACKAGE void __fastcall BinToAsciiHex(System::Classes::TStream* Source, System::Classes::TStream* Dest);
extern DELPHI_PACKAGE void __fastcall UnRLE(System::Classes::TStream* Source, System::Classes::TStream* Target);
}	/* namespace Qrxdocument */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRXDOCUMENT)
using namespace Qrxdocument;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrxdocumentHPP
