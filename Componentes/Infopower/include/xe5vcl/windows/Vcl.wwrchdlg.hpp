// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwrchdlg.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwrchdlgHPP
#define Vcl_WwrchdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <vcl.wwintl.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <vcl.Wwdotdot.hpp>	// Pascal unit
#include <vcl.Wwdbcomb.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <vcl.Wwsystem.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <vcl.wwriched.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwrchdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwRichParagraphDialog;
class PASCALIMPLEMENTATION TwwRichParagraphDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OKBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Wwdbcomb::TwwDBComboBox* AlignmentCombo;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* LeftEdit;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* RightEdit;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* FirstLineEdit;
	Vcl::Stdctrls::TLabel* GroupBox1;
	Vcl::Stdctrls::TLabel* SpacingGroup;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TLabel* BeforeParagraphLabel;
	Vcl::Stdctrls::TEdit* BeforeParagraphEdit;
	Vcl::Stdctrls::TLabel* AfterParagraphLabel;
	Vcl::Stdctrls::TEdit* AfterParagraphEdit;
	Vcl::Stdctrls::TLabel* WithinParagraphLabel;
	Vcl::Stdctrls::TEdit* WithinParagraphEdit;
	Vcl::Stdctrls::TComboBox* LineSpacingComboBox;
	Vcl::Stdctrls::TLabel* WithinParagraphAt;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall OKClick(System::TObject* Sender);
	void __fastcall LineSpacingComboBoxClick(System::TObject* Sender);
	void __fastcall LineSpacingComboBoxChange(System::TObject* Sender);
	void __fastcall WithinParagraphEditKeyPress(System::TObject* Sender, System::WideChar &Key);
	
private:
	void __fastcall ApplyIntl(void);
	
public:
	Vcl::Wwriched::TwwCustomRichEdit* RichEdit;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwRichParagraphDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwRichParagraphDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwRichParagraphDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwRichParagraphDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwRichParagraphDialog* wwRichParagraphDialog;
extern DELPHI_PACKAGE bool __fastcall wwRichEditParagraphDlg(Vcl::Wwriched::TwwCustomRichEdit* richedit1);
}	/* namespace Wwrchdlg */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRCHDLG)
using namespace Vcl::Wwrchdlg;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwrchdlgHPP
