// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDialogForm.pas' rev: 32.00 (Windows)

#ifndef FrxdialogformHPP
#define FrxdialogformHPP

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
#include <frxBaseForm.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxdialogform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDialogForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDialogForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall DoCreateWnd(void);
	void __fastcall DoDestroyWnd(void);
	void __fastcall DoCreateHandle(void);
	void __fastcall DoDestroyHandle(void);
	void __fastcall DoDestroyWindowHandle(void);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DestroyHandle(void);
	virtual void __fastcall DestroyWindowHandle(void);
	
private:
	System::Classes::TNotifyEvent FOnModify;
	bool FThreadSafe;
	System::Classes::TComponent* FDialogPageControl;
	MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	
public:
	__fastcall virtual TfrxDialogForm(System::Classes::TComponent* AOwner);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property System::Classes::TNotifyEvent OnModify = {read=FOnModify, write=FOnModify};
	__property bool ThreadSafe = {read=FThreadSafe, write=FThreadSafe, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDialogForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDialogForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdialogform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDIALOGFORM)
using namespace Frxdialogform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdialogformHPP
