﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBreakPointsForm.pas' rev: 32.00 (Windows)

#ifndef FrxbreakpointsformHPP
#define FrxbreakpointsformHPP

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
#include <Vcl.ComCtrls.hpp>
#include <fs_iinterpreter.hpp>
#include <Vcl.CheckLst.hpp>
#include <frxSynMemo.hpp>
#include <frxBaseForm.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <System.Variants.hpp>
#include <Vcl.Grids.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbreakpointsform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBreakPointsForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBreakPointsForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* DeleteB;
	Vcl::Comctrls::TToolButton* EditB;
	Vcl::Comctrls::TToolButton* ToggleEnableB;
	Vcl::Grids::TStringGrid* BreakPGR;
	Vcl::Stdctrls::TButton* EditBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall ToggleEnableBClick(System::TObject* Sender);
	void __fastcall BreakPGRDrawCell(System::TObject* Sender, int ACol, int ARow, const System::Types::TRect &Rect, Vcl::Grids::TGridDrawState State);
	void __fastcall BreakPGRDblClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	Fs_iinterpreter::TfsScript* FScript;
	bool FScriptRunning;
	Frxsynmemo::TfrxSyntaxMemo* FSynMemo;
	void __fastcall SetSynMemo(Frxsynmemo::TfrxSyntaxMemo* const Value);
	void __fastcall BPListUpdated(System::TObject* Sender);
	
public:
	__fastcall virtual ~TfrxBreakPointsForm(void);
	HIDESBASE void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall UpdateList(void);
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property Fs_iinterpreter::TfsScript* Script = {read=FScript, write=FScript};
	__property bool ScriptRunning = {read=FScriptRunning, write=FScriptRunning, nodefault};
	__property Frxsynmemo::TfrxSyntaxMemo* SynMemo = {read=FSynMemo, write=SetSynMemo};
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxBreakPointsForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBreakPointsForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBreakPointsForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbreakpointsform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBREAKPOINTSFORM)
using namespace Frxbreakpointsform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbreakpointsformHPP
