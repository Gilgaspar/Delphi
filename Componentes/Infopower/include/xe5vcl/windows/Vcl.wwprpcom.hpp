// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwprpcom.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwprpcomHPP
#define Vcl_WwprpcomHPP

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
#include <Vcl.Grids.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwprpcom
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwPrpEditComboList;
class PASCALIMPLEMENTATION TwwPrpEditComboList : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Extctrls::TNotebook* Notebook1;
	Vcl::Grids::TStringGrid* StringGrid1;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* SeparateStoredList;
	Vcl::Stdctrls::TButton* Button1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall StringGrid1KeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SeparateStoredListClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall OKBtnClick(System::TObject* Sender);
	
private:
	bool MapList;
	System::Classes::TStrings* Items;
	bool init;
	bool changingMapCheckbox;
	bool okBtnPressed;
	bool changed;
	int startWidth1;
	void __fastcall DeleteCurrentRow(void);
	void __fastcall ComputeGridColumns(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwPrpEditComboList(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwPrpEditComboList(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwPrpEditComboList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwPrpEditComboList(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwPrpEditComboList* wwPrpEditComboList;
extern DELPHI_PACKAGE bool __fastcall wwEditComboList(System::Classes::TStrings* AItems, bool &AMapList);
}	/* namespace Wwprpcom */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWPRPCOM)
using namespace Vcl::Wwprpcom;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwprpcomHPP
