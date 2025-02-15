// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwlocate.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwlocateHPP
#define Vcl_WwlocateHPP

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
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <vcl.wwDialog.hpp>	// Pascal unit
#include <Vcl.DBCtrls.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwlocate
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TwwLocateMatchType : unsigned char { mtExactMatch, mtPartialMatchStart, mtPartialMatchAny };

enum DECLSPEC_DENUM TwwFieldSortType : unsigned char { fsSortByFieldNo, fsSortByFieldName };

enum DECLSPEC_DENUM TwwDefaultButtonType : unsigned char { dbFindFirst, dbFindNext };

enum DECLSPEC_DENUM TwwFieldSelection : unsigned char { fsAllFields, fsVisibleFields };

enum DECLSPEC_DENUM TwwLocateDlgOption : unsigned char { ldoCaseSensitiveBelow, ldoCloseOnMatch, ldoPreserveSearchText };

typedef System::Set<TwwLocateDlgOption, TwwLocateDlgOption::ldoCaseSensitiveBelow, TwwLocateDlgOption::ldoPreserveSearchText> TwwLocateDlgOptions;

class DELPHICLASS TwwLocateDlg;
typedef void __fastcall (__closure *TwwOnInitLocateDlgEvent)(TwwLocateDlg* Dialog);

typedef void __fastcall (__closure *TwwLocateSelectFieldEvent)(TwwLocateDlg* Dialog, System::UnicodeString SearchField);

class PASCALIMPLEMENTATION TwwLocateDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* SearchTypeGroup;
	Vcl::Stdctrls::TGroupBox* FieldsGroup;
	Vcl::Stdctrls::TCheckBox* CaseSensitiveCheckBox;
	Vcl::Stdctrls::TRadioButton* ExactMatchBtn;
	Vcl::Stdctrls::TRadioButton* PartialMatchStartBtn;
	Vcl::Stdctrls::TRadioButton* PartialMatchAnyBtn;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TGroupBox* FieldValueGroup;
	Vcl::Stdctrls::TEdit* SearchValue;
	Vcl::Stdctrls::TButton* FirstButton;
	Vcl::Stdctrls::TButton* NextButton;
	Vcl::Stdctrls::TComboBox* FieldNameComboBox;
	void __fastcall FindFirst(System::TObject* Sender);
	void __fastcall FindNextBtnClick(System::TObject* Sender);
	void __fastcall BitBtn1KeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FieldNameComboBoxChange(System::TObject* Sender);
	void __fastcall FieldNameComboBoxEnter(System::TObject* Sender);
	void __fastcall FieldNameComboBoxExit(System::TObject* Sender);
	void __fastcall FieldNameComboBoxKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	System::UnicodeString __fastcall GetFieldNameFromTitle(System::UnicodeString fieldTitle);
	void __fastcall ApplyIntl(void);
	
public:
	Data::Db::TDataSet* DataSet;
	Vcl::Stdctrls::TCustomButton* CancelBtn;
	System::Classes::TComponent* DlgComponent;
	bool __fastcall FindMatch(bool FromBeginning);
	__fastcall virtual TwwLocateDlg(System::Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwLocateDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwLocateDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwLocateDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TwwLocateDialog;
class PASCALIMPLEMENTATION TwwLocateDialog : public Vcl::Wwdialog::TwwCustomDialog
{
	typedef Vcl::Wwdialog::TwwCustomDialog inherited;
	
private:
	System::UnicodeString FCaption;
	System::UnicodeString FDataField;
	Data::Db::TDataLink* FDataLink;
	System::UnicodeString FFieldValue;
	TwwLocateMatchType FMatchType;
	bool FCaseSensitive;
	TwwFieldSortType FSortFields;
	TwwDefaultButtonType FDefaultButton;
	TwwFieldSelection FFieldSelection;
	bool FShowMessages;
	TwwLocateDlgOptions FOptions;
	TwwOnInitLocateDlgEvent FOnInitDialog;
	TwwLocateSelectFieldEvent FOnSelectField;
	bool FUseLocateMethod;
	void __fastcall SetDataSource(Data::Db::TDataSource* value);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	
protected:
	virtual void __fastcall DoInitDialog(void);
	
public:
	TwwLocateDlg* Form;
	System::Variant Patch;
	virtual Data::Db::TDataSet* __fastcall GetPrimaryDataSet(void);
	__fastcall virtual TwwLocateDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TwwLocateDialog(void);
	virtual bool __fastcall Execute(void);
	bool __fastcall FindPrior(void);
	bool __fastcall FindNext(void);
	bool __fastcall FindFirst(void);
	__property System::UnicodeString FieldValue = {read=FFieldValue, write=FFieldValue};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::UnicodeString SearchField = {read=FDataField, write=FDataField};
	__property TwwLocateMatchType MatchType = {read=FMatchType, write=FMatchType, nodefault};
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, nodefault};
	__property TwwFieldSortType SortFields = {read=FSortFields, write=FSortFields, nodefault};
	__property TwwDefaultButtonType DefaultButton = {read=FDefaultButton, write=FDefaultButton, nodefault};
	__property TwwFieldSelection FieldSelection = {read=FFieldSelection, write=FFieldSelection, nodefault};
	__property bool ShowMessages = {read=FShowMessages, write=FShowMessages, nodefault};
	__property bool UseLocateMethod = {read=FUseLocateMethod, write=FUseLocateMethod, default=0};
	__property TwwLocateDlgOptions Options = {read=FOptions, write=FOptions, default=2};
	__property TwwOnInitLocateDlgEvent OnInitDialog = {read=FOnInitDialog, write=FOnInitDialog};
	__property TwwLocateSelectFieldEvent OnSelectField = {read=FOnSelectField, write=FOnSelectField};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwLocateDlg* wwLocateDlg;
extern DELPHI_PACKAGE bool __fastcall wwFindMatch(bool FromBeginning, Data::Db::TDataSet* DataSet, System::UnicodeString searchField, System::UnicodeString searchValue, TwwLocateMatchType matchType, bool caseSens, bool UseLocateMethod = false);
}	/* namespace Wwlocate */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWLOCATE)
using namespace Vcl::Wwlocate;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwlocateHPP
