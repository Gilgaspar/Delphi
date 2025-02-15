﻿// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.Wwpicdb.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwpicdbHPP
#define Vcl_WwpicdbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.DBCtrls.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwpicdb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwEditMaskForm;
class PASCALIMPLEMENTATION TwwEditMaskForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Wwdbedit::TwwDBEdit* MaskEdit;
	Vcl::Wwdbedit::TwwDBEdit* Description;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwEditMaskForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwEditMaskForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwEditMaskForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwEditMaskForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwEditMaskForm* wwEditMaskForm;
}	/* namespace Wwpicdb */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWPICDB)
using namespace Vcl::Wwpicdb;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwpicdbHPP
