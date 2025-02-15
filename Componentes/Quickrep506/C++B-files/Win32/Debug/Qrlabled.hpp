// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRLablEd.pas' rev: 32.00 (Windows)

#ifndef QrlabledHPP
#define QrlabledHPP

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

//-- user supplied -----------------------------------------------------------

namespace Qrlabled
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRLabelEditorForm;
class DELPHICLASS TQRLabelEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRLabelEditorForm : public Vcl::Forms::TForm
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
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRLabelEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRLabelEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRLabelEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRLabelEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRLabelEditor : public Quickrpt::TQRPrintableEditor
{
	typedef Quickrpt::TQRPrintableEditor inherited;
	
protected:
	virtual System::Uitypes::TColor __fastcall GetColor(void);
	virtual Vcl::Graphics::TFont* __fastcall GetFont(void);
	virtual Quickrpt::TQRPrintableClass __fastcall GetPrintableClass(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual System::UnicodeString __fastcall GetGlyphResName(void);
	virtual System::UnicodeString __fastcall GetControlName(void);
	virtual System::Classes::TAlignment __fastcall GetAlignment(void);
	virtual void __fastcall SetAlignment(System::Classes::TAlignment Value);
	virtual void __fastcall SetColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	virtual void __fastcall SetValue(System::UnicodeString Value);
	
public:
	virtual bool __fastcall ShowEditor(void);
public:
	/* TQRPrintableEditor.Create */ inline __fastcall virtual TQRLabelEditor(Quickrpt::TQRPrintable* AControl) : Quickrpt::TQRPrintableEditor(AControl) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQRLabelEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrlabled */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRLABLED)
using namespace Qrlabled;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrlabledHPP
