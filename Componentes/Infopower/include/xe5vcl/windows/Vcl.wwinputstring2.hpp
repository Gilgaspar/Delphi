// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwinputstring2.pas' rev: 26.00 (Windows)

#ifndef Vcl_Wwinputstring2HPP
#define Vcl_Wwinputstring2HPP

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
namespace Wwinputstring2
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwInputTwoStringForm;
class PASCALIMPLEMENTATION TwwInputTwoStringForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Wwdbedit::TwwDBEdit* filtervalue;
	Vcl::Stdctrls::TLabel* FilterLabel;
	Vcl::Stdctrls::TLabel* FilterLabel2;
	Vcl::Wwdbdatetimepicker::TwwDBDateTimePicker* FilterDateEdit;
	Vcl::Wwdbedit::TwwDBEdit* filterValue2;
	Vcl::Stdctrls::TLabel* FieldLabel;
	Vcl::Wwdbdatetimepicker::TwwDBDateTimePicker* FilterDateEdit2;
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
	__fastcall virtual TwwInputTwoStringForm(System::Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwInputTwoStringForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwInputTwoStringForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwInputTwoStringForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwInputTwoStringForm* wwInputTwoStringForm;
extern DELPHI_PACKAGE bool __fastcall wwInputTwoStringDialog(System::Classes::TComponent* AOwner, Data::Db::TField* AField, System::UnicodeString fieldCaption, System::UnicodeString &value, System::UnicodeString &value2);
}	/* namespace Wwinputstring2 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWINPUTSTRING2)
using namespace Vcl::Wwinputstring2;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Wwinputstring2HPP
