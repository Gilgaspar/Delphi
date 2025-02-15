// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxAbout.pas' rev: 32.00 (Windows)

#ifndef FrxaboutHPP
#define FrxaboutHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxabout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxAboutForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxAboutForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Extctrls::TShape* Shape1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall LabelClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
public:
	virtual void __fastcall UpdateResouces(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxAboutForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxAboutForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxAboutForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxAboutForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxabout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXABOUT)
using namespace Frxabout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxaboutHPP
