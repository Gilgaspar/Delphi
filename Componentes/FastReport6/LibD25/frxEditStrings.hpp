﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditStrings.pas' rev: 32.00 (Windows)

#ifndef FrxeditstringsHPP
#define FrxeditstringsHPP

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
#include <frxBaseForm.hpp>
#include <Vcl.ToolWin.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxeditstrings
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxStringsEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxStringsEditorForm : public Frxbaseform::TfrxBaseLoadSavePrefForm
{
	typedef Frxbaseform::TfrxBaseLoadSavePrefForm inherited;
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Comctrls::TToolButton* OkB;
	Vcl::Comctrls::TToolButton* CancelB;
	Vcl::Stdctrls::TMemo* Memo;
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall MemoKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
public:
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxStringsEditorForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseLoadSavePrefForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxStringsEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseLoadSavePrefForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxStringsEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxStringsEditorForm(HWND ParentWindow) : Frxbaseform::TfrxBaseLoadSavePrefForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditstrings */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITSTRINGS)
using namespace Frxeditstrings;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditstringsHPP
