// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRCompEd.pas' rev: 32.00 (Windows)

#ifndef QrcompedHPP
#define QrcompedHPP

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
#include <System.UITypes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <QRAbout.hpp>
#include <Data.DB.hpp>
#include <qr5const.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrcomped
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRCompEd;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRCompEd : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* About;
	Vcl::Stdctrls::TButton* Preview;
	Vcl::Stdctrls::TButton* Apply1;
	Vcl::Stdctrls::TButton* OK1;
	Vcl::Stdctrls::TButton* Cancel1;
	Vcl::Stdctrls::TGroupBox* PaperSizeGB;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TComboBox* PaperSize;
	Vcl::Stdctrls::TEdit* PageWidth;
	Vcl::Stdctrls::TEdit* PageLength;
	Vcl::Stdctrls::TComboBox* OrientationCB;
	Vcl::Stdctrls::TGroupBox* MarginsGB;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* Topmargin;
	Vcl::Stdctrls::TEdit* BottomMargin;
	Vcl::Stdctrls::TEdit* LeftMargin;
	Vcl::Stdctrls::TEdit* RightMargin;
	Vcl::Stdctrls::TEdit* ColumnMargin;
	Vcl::Stdctrls::TGroupBox* OtherGB;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TComboBox* Units;
	Vcl::Stdctrls::TComboBox* FontName;
	Vcl::Stdctrls::TComboBox* FontSize;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* Columns;
	Vcl::Stdctrls::TGroupBox* PageFrameGB;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Extctrls::TShape* FrameColor;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TCheckBox* PageFrameTop;
	Vcl::Stdctrls::TCheckBox* PageFrameBottom;
	Vcl::Stdctrls::TCheckBox* PageFrameLeft;
	Vcl::Stdctrls::TCheckBox* PageFrameRight;
	Vcl::Stdctrls::TButton* ColorButton;
	Vcl::Stdctrls::TEdit* PageFramePenWidth;
	Vcl::Stdctrls::TGroupBox* BandsGB;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TCheckBox* Title;
	Vcl::Stdctrls::TCheckBox* PageHeader;
	Vcl::Stdctrls::TCheckBox* ColumnHeader;
	Vcl::Stdctrls::TCheckBox* Detail;
	Vcl::Stdctrls::TEdit* PageHeaderLength;
	Vcl::Stdctrls::TEdit* TitleLength;
	Vcl::Stdctrls::TEdit* ColumnHeaderLength;
	Vcl::Stdctrls::TEdit* DetailLength;
	Vcl::Stdctrls::TEdit* SummaryLength;
	Vcl::Stdctrls::TCheckBox* PageFooter;
	Vcl::Stdctrls::TCheckBox* Summary;
	Vcl::Stdctrls::TEdit* PageFooterLength;
	Vcl::Stdctrls::TCheckBox* FirstPageHeader;
	Vcl::Stdctrls::TCheckBox* LastPageFooter;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Buttons::TSpeedButton* SpeedButton3;
	Vcl::Buttons::TSpeedButton* SpeedButton4;
	Vcl::Extctrls::TShape* Shape1;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TLabel* Label16;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Cancel1Click(System::TObject* Sender);
	void __fastcall OK1Click(System::TObject* Sender);
	void __fastcall Apply1Click(System::TObject* Sender);
	void __fastcall FloatKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall PageWidthExit(System::TObject* Sender);
	void __fastcall AboutClick(System::TObject* Sender);
	void __fastcall PreviewClick(System::TObject* Sender);
	void __fastcall ColorButtonClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	void __fastcall PageWidthEnter(System::TObject* Sender);
	
private:
	Quickrpt::TQuickRep* FQuickRep;
	System::Classes::TStrings* FAvailableDataSets;
	System::UnicodeString Saver;
	void __fastcall GetValues(void);
	void __fastcall SetValues(void);
	void __fastcall SetQuickRep(Quickrpt::TQuickRep* Value);
	void __fastcall SetAvailableDataSets(System::Classes::TStrings* Value);
	void __fastcall ChangeValue(Vcl::Stdctrls::TEdit* Edit, int Value, int MinValue);
	
public:
	__property Quickrpt::TQuickRep* QuickRep = {read=FQuickRep, write=SetQuickRep};
	__property System::Classes::TStrings* AvailableDataSets = {read=FAvailableDataSets, write=SetAvailableDataSets};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRCompEd(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRCompEd(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRCompEd(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRCompEd(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrcomped */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRCOMPED)
using namespace Qrcomped;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrcompedHPP
