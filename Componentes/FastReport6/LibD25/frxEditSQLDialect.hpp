// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditSQLDialect.pas' rev: 32.00 (Windows)

#ifndef FrxeditsqldialectHPP
#define FrxeditsqldialectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <frxSynMemo.hpp>
#include <frxBaseForm.hpp>
#include <frxInsp.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxeditsqldialect
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSQLDialectForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxSQLDialectForm : public Frxbaseform::TfrxBaseLoadSavePrefForm
{
	typedef Frxbaseform::TfrxBaseLoadSavePrefForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* PnTree;
	Vcl::Comctrls::TTreeView* TVStyles;
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Comctrls::TToolButton* TBNewDialect;
	Vcl::Comctrls::TToolButton* TBNewStyle;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Comctrls::TToolButton* TBDelete;
	Vcl::Extctrls::TPanel* PnInsp;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall MemoKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TBNewDialectClick(System::TObject* Sender);
	void __fastcall TBNewStyleClick(System::TObject* Sender);
	void __fastcall TVStylesChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TVStylesEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall TBDeleteClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	
private:
	Frxinsp::TfrxObjectInspector* FInspector;
	Frxsynmemo::TfrxSynDialectStyles* FSynDialectStyles;
	void __fastcall FillDialects(void);
	
public:
	__fastcall virtual TfrxSQLDialectForm(System::Classes::TComponent* AOwner);
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property Frxsynmemo::TfrxSynDialectStyles* SynDialectStyles = {read=FSynDialectStyles, write=FSynDialectStyles};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSQLDialectForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseLoadSavePrefForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSQLDialectForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSQLDialectForm(HWND ParentWindow) : Frxbaseform::TfrxBaseLoadSavePrefForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditsqldialect */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITSQLDIALECT)
using namespace Frxeditsqldialect;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditsqldialectHPP
