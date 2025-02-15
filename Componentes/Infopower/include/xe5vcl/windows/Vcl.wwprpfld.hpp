﻿// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwprpfld.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwprpfldHPP
#define Vcl_WwprpfldHPP

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
#include <Data.DB.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwprpfld
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwSelectField;
class PASCALIMPLEMENTATION TwwSelectField : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TListBox* ListBox1;
	Vcl::Stdctrls::TCheckBox* SortAvailCheckbox;
	Vcl::Stdctrls::TLabel* Label1;
	void __fastcall SortAvailCheckboxClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	Data::Db::TDataSet* MyDataSet;
	System::Classes::TStrings* CurrentList;
	bool FilterListFlag;
	System::Classes::TStrings* AvailList;
	void __fastcall RefreshList(void);
	void __fastcall RefreshFilteredList(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwSelectField(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwSelectField(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwSelectField(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwSelectField(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwSelectField* wwSelectField;
extern DELPHI_PACKAGE bool __fastcall wwDlgSelectFields(Data::Db::TDataSet* AMyDataSet, System::Classes::TStrings* ACurrentList, System::Classes::TStrings* selectedList);
extern DELPHI_PACKAGE bool __fastcall wwDlgSelectFilterFields(System::Classes::TStrings* AAvailList, System::Classes::TStrings* ACurrentList, System::Classes::TStrings* selectedList);
}	/* namespace Wwprpfld */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWPRPFLD)
using namespace Vcl::Wwprpfld;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwprpfldHPP
