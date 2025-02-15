// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRLablWz.pas' rev: 30.00 (Windows)

#ifndef QrlablwzHPP
#define QrlablwzHPP

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
#include <Vcl.StdCtrls.hpp>
#include <QuickRpt.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrlablwz
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRLabelSetup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRLabelSetup : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TRadioButton* StandardLabel;
	Vcl::Stdctrls::TRadioButton* CustomLabel;
	Vcl::Stdctrls::TComboBox* StandardLabelType;
	Vcl::Stdctrls::TButton* StartWizardBtn;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TEdit* TopMargin;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* SideMargin;
	Vcl::Stdctrls::TEdit* LabelHeight;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* LabelWidth;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* VerticalPitch;
	Vcl::Stdctrls::TEdit* HorizontalPitch;
	Vcl::Stdctrls::TEdit* NumberAcross;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TComboBox* PaperSize;
	
private:
	Quickrpt::TQuickLabelReport* FReport;
	
public:
	__property Quickrpt::TQuickLabelReport* Report = {read=FReport, write=FReport};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRLabelSetup(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRLabelSetup(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRLabelSetup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRLabelSetup(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TQRLabelSetup* QRLabelSetup;
}	/* namespace Qrlablwz */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRLABLWZ)
using namespace Qrlablwz;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrlablwzHPP
