// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwprprx.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwprprxHPP
#define Vcl_WwprprxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <vcl.wwdblook.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <vcl.Wwdotdot.hpp>	// Pascal unit
#include <vcl.wwdbigrd.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <vcl.Wwpicdb.hpp>	// Pascal unit
#include <Vcl.Grids.hpp>	// Pascal unit
#include <vcl.wwdbgrid.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <vcl.wwedtpic.hpp>	// Pascal unit
#include <vcl.ipdsgn.hpp>	// Pascal unit
#include <vcl.wwintl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwprprx
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwEditRegexForm;
class PASCALIMPLEMENTATION TwwEditRegexForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TMemo* PictureDescription;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Wwdbedit::TwwDBEdit* wwPictureEdit1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Extctrls::TPanel* Status;
	Vcl::Stdctrls::TCheckBox* AutoFill;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Wwdotdot::TwwDBComboDlg* NewPicture;
	Vcl::Wwintl::TwwIntl* wwIntl1;
	void __fastcall NewPictureChange(System::TObject* Sender);
	void __fastcall wwPictureEdit1Change(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall AutoFillClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall NewPictureCustomDlg(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall NewPictureExit(System::TObject* Sender);
	
private:
	Vcl::Stdctrls::TCustomEdit* Component;
	System::UnicodeString OrigRegexMask;
	bool OrigCaseSensitive;
	void __fastcall RefreshDescription(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwEditRegexForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwEditRegexForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwEditRegexForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwEditRegexForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwEditRegexForm* wwEditRegexForm;
extern DELPHI_PACKAGE bool __fastcall wwPrpEdit_RegexMask(Vcl::Wwdbedit::TwwCustomMaskEdit* AComponent);
}	/* namespace Wwprprx */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWPRPRX)
using namespace Vcl::Wwprprx;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwprprxHPP
