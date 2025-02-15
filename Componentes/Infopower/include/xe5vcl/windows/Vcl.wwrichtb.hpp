// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.Wwrichtb.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwrichtbHPP
#define Vcl_WwrichtbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <vcl.wwriched.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <vcl.Wwsystem.hpp>	// Pascal unit
#include <Winapi.RichEdit.hpp>	// Pascal unit
#include <vcl.wwintl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwrichtb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwRichTabDialog;
class PASCALIMPLEMENTATION TwwRichTabDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OKButton;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Stdctrls::TListBox* ListBox1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* Button4;
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall SetButtonClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Edit1Enter(System::TObject* Sender);
	void __fastcall Edit1Exit(System::TObject* Sender);
	void __fastcall Edit1KeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OKButtonClick(System::TObject* Sender);
	
private:
	Vcl::Wwriched::TwwCustomRichEdit* richedit;
	void __fastcall ApplyIntl(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwRichTabDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwRichTabDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwRichTabDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwRichTabDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwRichTabDialog* wwRichTabDialog;
extern DELPHI_PACKAGE bool __fastcall wwRichTabDlg(Vcl::Wwriched::TwwCustomRichEdit* richedit1);
}	/* namespace Wwrichtb */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRICHTB)
using namespace Vcl::Wwrichtb;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwrichtbHPP
