// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEvaluateForm.pas' rev: 32.00 (Windows)

#ifndef FrxevaluateformHPP
#define FrxevaluateformHPP

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
#include <fs_iinterpreter.hpp>
#include <frxBaseForm.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxevaluateform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxEvaluateForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxEvaluateForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* ExpressionE;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TMemo* ResultM;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	void __fastcall ExpressionEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	Fs_iinterpreter::TfsScript* FScript;
	bool FIsWatch;
	
public:
	virtual void __fastcall UpdateResouces(void);
	__property bool IsWatch = {read=FIsWatch, write=FIsWatch, nodefault};
	__property Fs_iinterpreter::TfsScript* Script = {read=FScript, write=FScript};
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxEvaluateForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxEvaluateForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxEvaluateForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxEvaluateForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxevaluateform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEVALUATEFORM)
using namespace Frxevaluateform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxevaluateformHPP
