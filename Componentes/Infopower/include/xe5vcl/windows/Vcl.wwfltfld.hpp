// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwfltfld.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwfltfldHPP
#define Vcl_WwfltfldHPP

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
#include <Data.DB.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.TabNotBk.hpp>	// Pascal unit
#include <Vcl.Tabs.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <vcl.wwdblook.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <vcl.Wwdbcomb.hpp>	// Pascal unit
#include <vcl.wwdbgrid.hpp>	// Pascal unit
#include <vcl.wwdbdlg.hpp>	// Pascal unit
#include <vcl.wwIDlg.hpp>	// Pascal unit
#include <vcl.wwprpfld.hpp>	// Pascal unit
#include <vcl.Wwfltdlg.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwfltfld
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSelFilterFieldsForm;
class PASCALIMPLEMENTATION TSelFilterFieldsForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TListBox* DstList;
	Vcl::Stdctrls::TButton* AddButton;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TEdit* FieldDisplay;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TPanel* OKCancelPanel;
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	bool __fastcall InDestList(System::UnicodeString Value);
	void __fastcall ExcludeItems(void);
	void __fastcall ExcludeBtnClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall AddButtonClick(System::TObject* Sender);
	void __fastcall DstListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall DstListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall DstListMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DstListClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall DstListKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FieldDisplayExit(System::TObject* Sender);
	
private:
	Data::Db::TField* curField;
	int dragFromRow;
	bool initialized;
	System::Classes::TStrings* SrcListItems;
	System::Classes::TStrings* SelectedList;
	Vcl::Wwfltdlg::TwwFilterDialog* Dialog;
	void __fastcall UpdateFieldDisplay(void);
	int __fastcall GetSelectedListIndex(System::UnicodeString value);
	
public:
	__fastcall virtual TSelFilterFieldsForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSelFilterFieldsForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSelFilterFieldsForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSelFilterFieldsForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall wwSelectFilterableFields(Vcl::Wwfltdlg::TwwFilterDialog* ADialog, System::Classes::TStrings* FieldList);
}	/* namespace Wwfltfld */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWFLTFLD)
using namespace Vcl::Wwfltfld;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwfltfldHPP
