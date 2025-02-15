// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwrtfprintpreview.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwrtfprintpreviewHPP
#define Vcl_WwrtfprintpreviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Winapi.RichEdit.hpp>	// Pascal unit
#include <vcl.wwriched.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <vcl.Wwdotdot.hpp>	// Pascal unit
#include <vcl.Wwdbcomb.hpp>	// Pascal unit
#include <vcl.Wwdbspin.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwrtfprintpreview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwRtfPreviewForm;
class PASCALIMPLEMENTATION TwwRtfPreviewForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	typedef System::DynamicArray<CHARRANGE> _TwwRtfPreviewForm__1;
	
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Forms::TScrollBox* ScrollBox1;
	Vcl::Extctrls::TPaintBox* PaintBox1;
	Vcl::Dialogs::TPrintDialog* PrintDialog;
	Vcl::Controls::TImageList* RichEditButtonIcons;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* N5001;
	Vcl::Menus::TMenuItem* N2001;
	Vcl::Menus::TMenuItem* N1501;
	Vcl::Menus::TMenuItem* N10001;
	Vcl::Menus::TMenuItem* N751;
	Vcl::Menus::TMenuItem* N501;
	Vcl::Menus::TMenuItem* N251;
	Vcl::Menus::TMenuItem* Auto1;
	Vcl::Wwdbcomb::TwwDBComboBox* zoomCombo;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* ToolButton5;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Wwdbspin::TwwDBSpinEdit* wwDBSpinEdit1;
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall ToolButton1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ScrollBox1Resize(System::TObject* Sender);
	void __fastcall wwDBSpinEdit1Change(System::TObject* Sender);
	void __fastcall ToolButton5Click(System::TObject* Sender);
	void __fastcall ToolButton2Click(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall zoomComboChange(System::TObject* Sender);
	
private:
	Vcl::Graphics::TMetafile* FMetafile;
	Vcl::Wwriched::TwwCustomRichEdit* FRichedit;
	_TwwRtfPreviewForm__1 FPages;
	System::Types::TRect FPagerect;
	System::Types::TRect FPrintRect;
	double FZoomFactor;
	int NumPages;
	void __fastcall PreparePreview(Vcl::Wwriched::TwwCustomRichEdit* aRichedit);
	void __fastcall Paginate(void);
	void __fastcall DrawPage(int pagenum);
	int __fastcall RenderPage(int pagenum, BOOL render = true);
	void __fastcall VerifyPagenum(int pagenum);
	void __fastcall PrintHeader(Vcl::Graphics::TCanvas* cv);
	void __fastcall UpdateZoom(void);
	void __fastcall DrawScaled(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &outrect, Vcl::Graphics::TGraphic* image, int iwidth, int iheight);
	
public:
	__fastcall virtual ~TwwRtfPreviewForm(void);
	__fastcall virtual TwwRtfPreviewForm(System::Classes::TComponent* AOwner);
	__classmethod void __fastcall Preview(Vcl::Wwriched::TwwCustomRichEdit* arichedit);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwRtfPreviewForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwRtfPreviewForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TwwRtfPreviewForm* wwRtfPreviewForm;
}	/* namespace Wwrtfprintpreview */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRTFPRINTPREVIEW)
using namespace Vcl::Wwrtfprintpreview;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwrtfprintpreviewHPP
