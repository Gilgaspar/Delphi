// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.Wwmemo.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwmemoHPP
#define Vcl_WwmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.DBCtrls.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwmemo
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TwwMemoAttribute : unsigned char { mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog };

typedef System::Set<TwwMemoAttribute, TwwMemoAttribute::mSizeable, TwwMemoAttribute::mDisableDialog> TwwMemoAttributes;

class DELPHICLASS TwwMemoDlg;
class PASCALIMPLEMENTATION TwwMemoDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TMemo* Memo;
	Vcl::Extctrls::TPanel* UserButtonPanel;
	Vcl::Stdctrls::TButton* UserButton1;
	Vcl::Stdctrls::TButton* UserButton2;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	void __fastcall ResizeControls(System::TObject* Sender);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall MemoKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall UserButton1Click(System::TObject* Sender);
	void __fastcall UserButton2Click(System::TObject* Sender);
	void __fastcall MemoChange(System::TObject* Sender);
	
private:
	bool OKBtnpressed;
	System::Types::TRect posRect;
	void __fastcall ApplyIntl(void);
	
protected:
	bool changed;
	bool init;
	bool allowClose;
	DYNAMIC void __fastcall KeyPress(System::WideChar &key);
	
public:
	Vcl::Graphics::TFont* TempFont;
	System::UnicodeString TempTitle;
	System::Classes::TComponent* CallingComponent;
	Vcl::Stdctrls::TButton* OKBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	__fastcall virtual TwwMemoDlg(System::Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwMemoDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwMemoDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwMemoDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall wwEditMemoField(Vcl::Forms::TForm* AParentForm, System::Classes::TComponent* ADialog, bool Editable);
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Wwmemo */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWMEMO)
using namespace Vcl::Wwmemo;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwmemoHPP
