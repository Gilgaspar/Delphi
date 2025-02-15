// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwinputstring.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwinputstringHPP
#define Vcl_WwinputstringHPP

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
#include <System.Variants.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <vcl.wwintl.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <vcl.Wwdbdatetimepicker.hpp>	// Pascal unit
#include <vcl.Wwsystem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwinputstring
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwInputStringForm;
class PASCALIMPLEMENTATION TwwInputStringForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Wwdbedit::TwwDBEdit* filtervalue;
	Vcl::Stdctrls::TLabel* FilterLabel;
	Vcl::Wwdbdatetimepicker::TwwDBDateTimePicker* FilterDateEdit;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	bool OKBtnpressed;
	Data::Db::TField* Field;
	void __fastcall OKBtnClick(System::TObject* Sender);
	
public:
	Vcl::Stdctrls::TButton* OKBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	__fastcall virtual TwwInputStringForm(System::Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwInputStringForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwInputStringForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwInputStringForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwInputStringForm* wwInputStringForm;
extern DELPHI_PACKAGE bool __fastcall wwInputStringDialog(System::Classes::TComponent* AOwner, Data::Db::TField* AField, System::UnicodeString ACaption, System::UnicodeString &value);
}	/* namespace Wwinputstring */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWINPUTSTRING)
using namespace Vcl::Wwinputstring;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwinputstringHPP
