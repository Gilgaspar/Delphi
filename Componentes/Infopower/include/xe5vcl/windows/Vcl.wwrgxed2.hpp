// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwrgxed2.pas' rev: 26.00 (Windows)

#ifndef Vcl_Wwrgxed2HPP
#define Vcl_Wwrgxed2HPP

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
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdotdot.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <vcl.wwedtpic.hpp>	// Pascal unit
#include <vcl.ipdsgn.hpp>	// Pascal unit
#include <vcl.wwprprx.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwrgxed2
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwEditRegexMaskdlg;
class PASCALIMPLEMENTATION TwwEditRegexMaskdlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* CaseSensitiveCheckbox;
	Vcl::Stdctrls::TMemo* RegexDescription;
	Vcl::Stdctrls::TLabel* PictureMaskLabel;
	Vcl::Stdctrls::TButton* DesignMaskButton;
	Vcl::Wwdotdot::TwwDBComboDlg* RegexMaskEdit;
	Vcl::Stdctrls::TMemo* RegexErrorMsgEdit;
	Vcl::Stdctrls::TLabel* Label1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DesignMaskButtonClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall RegexMaskEditCustomDlg(System::TObject* Sender);
	void __fastcall RegexMaskEditExit(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	void __fastcall RefreshDescription(void);
	
public:
	Vcl::Wwdbedit::TwwCustomMaskEdit* MyComponent;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwEditRegexMaskdlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwEditRegexMaskdlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwEditRegexMaskdlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwEditRegexMaskdlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwEditRegexMaskdlg* wwEditRegexMaskdlg;
extern DELPHI_PACKAGE bool __fastcall wwPrpEdit_RegexMask2(Vcl::Wwdbedit::TwwCustomMaskEdit* AComponent);
extern DELPHI_PACKAGE bool __fastcall wwPrpEdit_RegexMask3(Vcl::Wwdbedit::TwwRegexMask* RegexMask, Vcl::Controls::TWinControl* TempParent);
}	/* namespace Wwrgxed2 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRGXED2)
using namespace Vcl::Wwrgxed2;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Wwrgxed2HPP
