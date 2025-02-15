// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxConnItemEdit.pas' rev: 32.00 (Windows)

#ifndef FrxconnitemeditHPP
#define FrxconnitemeditHPP

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
#include <frxClass.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxconnitemedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxConnectionItemEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxConnectionItemEdit : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* ConnL;
	Vcl::Stdctrls::TEdit* ConnE;
	Vcl::Stdctrls::TButton* ConnB;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TLabel* NameL;
	Vcl::Stdctrls::TEdit* NameE;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TRadioButton* SystemRB;
	Vcl::Stdctrls::TRadioButton* UserRB;
	void __fastcall ConnBClick(System::TObject* Sender);
	
public:
	Frxclass::TfrxReport* Report;
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxConnectionItemEdit(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxConnectionItemEdit(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxConnectionItemEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxConnectionItemEdit(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxConnectionItemEdit* frxConnectionItemEdit;
}	/* namespace Frxconnitemedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCONNITEMEDIT)
using namespace Frxconnitemedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxconnitemeditHPP
