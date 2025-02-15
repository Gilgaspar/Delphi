// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRExprEd.pas' rev: 30.00 (Windows)

#ifndef QrexpredHPP
#define QrexpredHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Mask.hpp>
#include <QuickRpt.hpp>
#include <QRLablEd.hpp>
#include <Vcl.Buttons.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrexpred
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRExprEditorForm;
class DELPHICLASS TQRExprEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRExprEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Value;
	Vcl::Stdctrls::TCheckBox* AutoSize;
	Vcl::Stdctrls::TCheckBox* Stretch;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Vcl::Stdctrls::TButton* OKBtn;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TCheckBox* Transparent;
	Vcl::Mask::TMaskEdit* Width;
	Vcl::Mask::TMaskEdit* Height;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Buttons::TSpeedButton* ShowExprBuilder;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TComboBox* Mask;
	void __fastcall ShowExprBuilderClick(System::TObject* Sender);
	
private:
	Vcl::Forms::TCustomForm* DSForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRExprEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRExprEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRExprEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRExprEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRExprEditor : public Qrlabled::TQRLabelEditor
{
	typedef Qrlabled::TQRLabelEditor inherited;
	
protected:
	virtual Quickrpt::TQRPrintableClass __fastcall GetPrintableClass(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual System::UnicodeString __fastcall GetGlyphResName(void);
	virtual System::UnicodeString __fastcall GetControlName(void);
	virtual void __fastcall SetValue(System::UnicodeString Value);
	
public:
	virtual bool __fastcall ShowEditor(void);
public:
	/* TQRPrintableEditor.Create */ inline __fastcall virtual TQRExprEditor(Quickrpt::TQRPrintable* AControl) : Qrlabled::TQRLabelEditor(AControl) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQRExprEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrexpred */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QREXPRED)
using namespace Qrexpred;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrexpredHPP
