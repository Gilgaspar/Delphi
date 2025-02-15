// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwfltvw.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwfltvwHPP
#define Vcl_WwfltvwHPP

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
#include <Vcl.Grids.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <vcl.wwdbgrid.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <vcl.wwtypes.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwfltvw
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwFilterDialogView;
class PASCALIMPLEMENTATION TwwFilterDialogView : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Grids::TStringGrid* StringGrid1;
	Vcl::Buttons::TBitBtn* CancelBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall StringGrid1DrawCell(System::TObject* Sender, int Col, int Row, const System::Types::TRect &Rect, Vcl::Grids::TGridDrawState State);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall StringGrid1Enter(System::TObject* Sender);
	
private:
	void __fastcall ApplyIntl(void);
	
public:
	Vcl::Stdctrls::TButton* OKBtn;
	__fastcall virtual TwwFilterDialogView(System::Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwFilterDialogView(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwFilterDialogView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwFilterDialogView(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall wwFilterDialogView(System::Classes::TComponent* tc, System::Classes::TList* FieldInfo);
}	/* namespace Wwfltvw */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWFLTVW)
using namespace Vcl::Wwfltvw;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwfltvwHPP
