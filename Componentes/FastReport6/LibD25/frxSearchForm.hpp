// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxSearchForm.pas' rev: 32.00 (Windows)

#ifndef FrxsearchformHPP
#define FrxsearchformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <frxBaseForm.hpp>
#include <frxRes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxsearchform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTView;
class DELPHICLASS TfrxSearchForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTView : public Vcl::Comctrls::TTreeView
{
	typedef Vcl::Comctrls::TTreeView inherited;
	
__published:
	MESSAGE void __fastcall WM_MouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
public:
	/* TCustomTreeView.Create */ inline __fastcall virtual TTView(System::Classes::TComponent* AOwner) : Vcl::Comctrls::TTreeView(AOwner) { }
	/* TCustomTreeView.Destroy */ inline __fastcall virtual ~TTView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTView(HWND ParentWindow) : Vcl::Comctrls::TTreeView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TfrxSearchForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* pnlSearch;
	Vcl::Stdctrls::TEdit* edtFind;
	Vcl::Stdctrls::TLabel* lblFind;
	Vcl::Stdctrls::TButton* btnFind;
	Vcl::Stdctrls::TGroupBox* gbSearch;
	Vcl::Stdctrls::TCheckBox* chkBeg;
	Vcl::Stdctrls::TCheckBox* chkCase;
	Vcl::Stdctrls::TCheckBox* chkFindAll;
	void __fastcall chkFindAllClick(System::TObject* Sender);
	void __fastcall edtFindKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	TTView* trvFind;
	__fastcall virtual ~TfrxSearchForm(void);
	virtual void __fastcall UpdateResouces(void);
	void __fastcall CleartrvFind(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxSearchForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSearchForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSearchForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const short EventScrollFind = short(32767);
}	/* namespace Frxsearchform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSEARCHFORM)
using namespace Frxsearchform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxsearchformHPP
