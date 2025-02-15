// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRXBrowser.pas' rev: 32.00 (Windows)

#ifndef QrxbrowserHPP
#define QrxbrowserHPP

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
#include <QRXDocument.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Printers.hpp>
#include <QRPrntr.hpp>
#include <qr5const.hpp>
#include <QuickRpt.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrxbrowser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRXStandardViewer;
class DELPHICLASS TQRXMLPreviewInterface;
class DELPHICLASS TQRXMLStandardPreviewInterface;
class DELPHICLASS TResizeGrid;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRXStandardViewer : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* ZoomFit;
	Vcl::Comctrls::TToolButton* Zoom100;
	Vcl::Comctrls::TToolButton* ZoomToWidth;
	Vcl::Comctrls::TToolButton* FirstPage;
	Vcl::Comctrls::TToolButton* PreviousPage;
	Vcl::Comctrls::TToolButton* nextpage;
	Vcl::Comctrls::TToolButton* LastPage;
	Vcl::Comctrls::TToolButton* PrintSetup;
	Vcl::Comctrls::TToolButton* Print;
	Vcl::Comctrls::TToolButton* SaveReport;
	Vcl::Comctrls::TToolButton* LoadReport;
	Vcl::Controls::TImageList* Images;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Buttons::TSpeedButton* ExitButton;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Comctrls::TToolButton* Spacer2;
	Vcl::Comctrls::TPageControl* Tabs;
	Vcl::Comctrls::TTabSheet* TabThumbs;
	Vcl::Comctrls::TTabSheet* TabSearchResult;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TListBox* SearchResultBox;
	Vcl::Stdctrls::TLabel* SearchTextLabel;
	Vcl::Grids::TDrawGrid* ThumbGrid;
	Vcl::Comctrls::TToolButton* Spacer3;
	Vcl::Comctrls::TToolButton* Spacer4;
	Vcl::Comctrls::TToolButton* FindButton;
	Vcl::Comctrls::TToolButton* Spacer1;
	Vcl::Comctrls::TToolButton* GotoPageButton;
	Vcl::Comctrls::TToolButton* Spacer5;
	Vcl::Dialogs::TPrintDialog* PrintDialog1;
	Vcl::Forms::TScrollBox* ScrollBox1;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Comctrls::TToolButton* copybutton;
	Vcl::Comctrls::TToolButton* cancelbutton;
	Vcl::Dialogs::TOpenDialog* Open1;
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall ZoomToFitClick(System::TObject* Sender);
	void __fastcall ZoomTo100Click(System::TObject* Sender);
	void __fastcall ZoomToWidthClick(System::TObject* Sender);
	void __fastcall FirstPageClick(System::TObject* Sender);
	void __fastcall PrevPageClick(System::TObject* Sender);
	void __fastcall NextPageClick(System::TObject* Sender);
	void __fastcall LastPageClick(System::TObject* Sender);
	void __fastcall ExitClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall PrintSetupClick(System::TObject* Sender);
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall QRPreviewPageAvailable(System::TObject* Sender, int PageNum);
	void __fastcall QRPreviewProgressUpdate(System::TObject* Sender, int Progress);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ThumbGridDrawCell(System::TObject* Sender, int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState State);
	void __fastcall ThumbGridSelectCell(System::TObject* Sender, int ACol, int ARow, bool &CanSelect);
	void __fastcall FindButtonClick(System::TObject* Sender);
	void __fastcall GotoPageButtonClick(System::TObject* Sender);
	void __fastcall Image1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Image1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Splitter2Moved(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall PrintClick(System::TObject* Sender);
	void __fastcall SearchResultBoxClick(System::TObject* Sender);
	void __fastcall copybuttonClick(System::TObject* Sender);
	
private:
	Qrxdocument::TQRXDocument* FQRXDocument;
	Qrprntr::TQRZoomState FZoomState;
	System::Uitypes::TPrinterOrientation FReportOrientation;
	Vcl::Comctrls::TProgressBar* Gauge;
	int LastProgress;
	int ThumbFontHeight;
	int ThumbDrawHeight;
	int ThumbDrawWidth;
	int ThumbTopMargin;
	int ThumbLeftMargin;
	bool ShowThumbs;
	bool ShowSearch;
	System::UnicodeString FTitle;
	bool doneActivate;
	int FInitTop;
	int FInitLeft;
	void __fastcall SetupFromController(Quickrpt::TQRPreviewController* prevcon);
	void __fastcall PositionImage(void);
	
public:
	int PageNumber;
	__fastcall virtual TQRXStandardViewer(System::Classes::TComponent* AOwner);
	HIDESBASE void __fastcall Show(void);
	void __fastcall UpdateInfo(void);
	void __fastcall SelectPage(int aPageNumber);
	void __fastcall ResizeThumb(System::TObject* Sender);
	bool __fastcall GetTextSearch(bool &MatchCase, System::UnicodeString &AText);
	void __fastcall SetDocument(Qrxdocument::TQRXDocument* aDoc);
	Vcl::Extctrls::TImage* __fastcall GetImage(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRXStandardViewer(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRXStandardViewer(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRXStandardViewer(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
public:
	/* TObject.Create */ inline __fastcall TQRXStandardViewer(void) : Vcl::Forms::TForm() { }
	
};


class PASCALIMPLEMENTATION TQRXMLPreviewInterface : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	virtual void __fastcall Show(void);
	virtual void __fastcall ShowModal(void);
	virtual Vcl::Extctrls::TImage* __fastcall GetImageControl(void);
	virtual void __fastcall SetDocument(Qrxdocument::TQRXDocument* aDoc);
public:
	/* TComponent.Create */ inline __fastcall virtual TQRXMLPreviewInterface(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRXMLPreviewInterface(void) { }
	
};


typedef System::TMetaClass* TQRXMLPreviewInterfaceClass;

class PASCALIMPLEMENTATION TQRXMLStandardPreviewInterface : public TQRXMLPreviewInterface
{
	typedef TQRXMLPreviewInterface inherited;
	
private:
	TQRXStandardViewer* FStandPrev;
	
public:
	__fastcall virtual TQRXMLStandardPreviewInterface(System::Classes::TComponent* Owner);
	virtual void __fastcall Show(void);
	virtual void __fastcall ShowModal(void);
	virtual Vcl::Extctrls::TImage* __fastcall GetImageControl(void);
	virtual void __fastcall SetDocument(Qrxdocument::TQRXDocument* aDoc);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRXMLStandardPreviewInterface(void) { }
	
};


class PASCALIMPLEMENTATION TResizeGrid : public Vcl::Grids::TDrawGrid
{
	typedef Vcl::Grids::TDrawGrid inherited;
	
public:
	__property OnResize;
public:
	/* TCustomGrid.Create */ inline __fastcall virtual TResizeGrid(System::Classes::TComponent* AOwner) : Vcl::Grids::TDrawGrid(AOwner) { }
	/* TCustomGrid.Destroy */ inline __fastcall virtual ~TResizeGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TResizeGrid(HWND ParentWindow) : Vcl::Grids::TDrawGrid(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TQRXMLPreviewInterfaceClass GlobalXMLPreviewInterface;
}	/* namespace Qrxbrowser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRXBROWSER)
using namespace Qrxbrowser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrxbrowserHPP
