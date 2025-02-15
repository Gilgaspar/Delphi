// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRPrev.pas' rev: 30.00 (Windows)

#ifndef QrprevHPP
#define QrprevHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <QRPrntr.hpp>
#include <qr5const.hpp>
#include <QRExtra.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Printers.hpp>
#include <QuickRpt.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrprev
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRStandardPreview;
class DELPHICLASS TResizeGrid;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRStandardPreview : public Vcl::Forms::TForm
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
	Vcl::Comctrls::TToolButton* nextPage;
	Vcl::Comctrls::TToolButton* LastPage;
	Vcl::Comctrls::TToolButton* PrintSetup;
	Vcl::Comctrls::TToolButton* Print;
	Vcl::Comctrls::TToolButton* SaveReport;
	Vcl::Comctrls::TToolButton* LoadReport;
	Vcl::Controls::TImageList* Images;
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
	Vcl::Comctrls::TToolButton* FindButton;
	Vcl::Comctrls::TToolButton* Spacer1;
	Vcl::Comctrls::TToolButton* GotoPageButton;
	Vcl::Comctrls::TToolButton* Spacer5;
	Vcl::Dialogs::TPrintDialog* PrintDialog1;
	Vcl::Comctrls::TToolButton* CancelButton;
	Vcl::Comctrls::TToolButton* copybutton;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Menus::TPopupMenu* Zoommenu;
	Vcl::Menus::TMenuItem* N50;
	Vcl::Menus::TMenuItem* N60;
	Vcl::Menus::TMenuItem* N70;
	Vcl::Menus::TMenuItem* N80;
	Vcl::Menus::TMenuItem* N90;
	Vcl::Menus::TMenuItem* N100;
	Vcl::Menus::TMenuItem* N110;
	Vcl::Menus::TMenuItem* N120;
	Vcl::Menus::TMenuItem* N130;
	Vcl::Menus::TMenuItem* N140;
	Vcl::Menus::TMenuItem* N150;
	Vcl::Menus::TMenuItem* N160;
	Vcl::Menus::TMenuItem* N170;
	Vcl::Menus::TMenuItem* N180;
	Vcl::Menus::TMenuItem* N190;
	Vcl::Menus::TMenuItem* N200;
	Qrprntr::TQRPreview* QRPreview;
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall ZoomToFitClick(System::TObject* Sender);
	void __fastcall ZoomTo100Click(System::TObject* Sender);
	void __fastcall ZoomToWidthClick(System::TObject* Sender);
	void __fastcall FirstPageClick(System::TObject* Sender);
	void __fastcall PrevPageClick(System::TObject* Sender);
	void __fastcall NextPageClick(System::TObject* Sender);
	void __fastcall LastPageClick(System::TObject* Sender);
	void __fastcall PrintClick(System::TObject* Sender);
	void __fastcall ExitClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall PrintSetupClick(System::TObject* Sender);
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall QRPreviewPageAvailable(System::TObject* Sender, int PageNum);
	void __fastcall QRPreviewProgressUpdate(System::TObject* Sender, int Progress);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall QRPreviewHyperlink(System::TObject* Sender, Qrprntr::TQRHyperlinkEventType EventType, System::UnicodeString Link, bool &Handled);
	void __fastcall ThumbGridDrawCell(System::TObject* Sender, int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState State);
	void __fastcall ThumbGridSelectCell(System::TObject* Sender, int ACol, int ARow, bool &CanSelect);
	void __fastcall FindButtonClick(System::TObject* Sender);
	void __fastcall GotoPageButtonClick(System::TObject* Sender);
	void __fastcall SearchResultBoxClick(System::TObject* Sender);
	void __fastcall QRPreviewMouseWheelUp(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall CancelButtonClick(System::TObject* Sender);
	void __fastcall copybuttonClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall N50Click(System::TObject* Sender);
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetupFromController(Quickrpt::TQRPreviewController* prevcon);
	
private:
	Qrprntr::TQRPrinter* FQRPrinter;
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
	Qrprntr::TQRZoomState InitZoom;
	
public:
	__fastcall virtual TQRStandardPreview(System::Classes::TComponent* AOwner, Qrprntr::TQRPrinter* aQRPrinter);
	HIDESBASE void __fastcall Show(void);
	void __fastcall UpdateInfo(void);
	void __fastcall SelectPage(int aPageNumber);
	void __fastcall ResizeThumb(System::TObject* Sender);
	bool __fastcall GetTextSearch(bool &MatchCase, System::UnicodeString &AText);
	__property Qrprntr::TQRPrinter* QRPrinter = {read=FQRPrinter, write=FQRPrinter};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRStandardPreview(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRStandardPreview(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRStandardPreview(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRStandardPreview(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
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
}	/* namespace Qrprev */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPREV)
using namespace Qrprev;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrprevHPP
