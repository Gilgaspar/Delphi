﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxSearchDialog.pas' rev: 32.00 (Windows)

#ifndef FrxsearchdialogHPP
#define FrxsearchdialogHPP

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
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxsearchdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSearchDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxSearchDialog : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* ReplacePanel;
	Vcl::Stdctrls::TLabel* ReplaceL;
	Vcl::Stdctrls::TEdit* ReplaceE;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* TextL;
	Vcl::Stdctrls::TEdit* TextE;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TGroupBox* SearchL;
	Vcl::Stdctrls::TCheckBox* CaseCB;
	Vcl::Stdctrls::TCheckBox* TopCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormActivate(System::TObject* Sender);
	
public:
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxSearchDialog(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSearchDialog(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSearchDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSearchDialog(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxsearchdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSEARCHDIALOG)
using namespace Frxsearchdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxsearchdialogHPP
