// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwaddlk.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwaddlkHPP
#define Vcl_WwaddlkHPP

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
#include <Data.DB.hpp>	// Pascal unit
#include <vcl.Wwgttbl.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <Bde.DBTables.hpp>	// Pascal unit
#include <vcl.wwtable.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwaddlk
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwAddLookupForm;
class PASCALIMPLEMENTATION TwwAddLookupForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* TableNameCaption;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TComboBox* FieldNameComboBox;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* MasterFieldsCaption;
	Vcl::Stdctrls::TLabel* IndexFieldsCaption;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TListBox* MasterFieldsList;
	Vcl::Stdctrls::TListBox* IndexFieldsList;
	Vcl::Stdctrls::TComboBox* IndexComboBox;
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Buttons::TBitBtn* HelpBtn;
	Vcl::Stdctrls::TListBox* JoinedFieldsList;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Buttons::TBitBtn* AddJoinButton;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Wwtable::TwwTable* Table1;
	void __fastcall IndexComboBoxChange(System::TObject* Sender);
	void __fastcall IndexFieldsListClick(System::TObject* Sender);
	void __fastcall MasterFieldsListClick(System::TObject* Sender);
	void __fastcall AddJoinButtonClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FieldNameComboBoxChange(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	Data::Db::TDataSet* MasterTable;
	bool firstTime;
	
public:
	System::UnicodeString databaseName;
	System::UnicodeString tableName;
	System::UnicodeString fieldName;
	System::UnicodeString indexName;
	System::UnicodeString indexFields;
	System::UnicodeString joins;
	System::WideChar useExtension;
	__fastcall virtual TwwAddLookupForm(System::Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwAddLookupForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwAddLookupForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwAddLookupForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwAddLookupForm* wwAddLookupForm;
extern DELPHI_PACKAGE bool __fastcall wwAddLookupfield(System::UnicodeString &aDbName, System::UnicodeString &aTblName, System::UnicodeString &aFieldName, System::UnicodeString &aIndex, System::UnicodeString &aIndexFields, System::UnicodeString &aJoins, System::WideChar &aUseExtension, Data::Db::TDataSet* aMasterTable);
}	/* namespace Wwaddlk */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWADDLK)
using namespace Vcl::Wwaddlk;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwaddlkHPP
