﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditFrame.pas' rev: 32.00 (Windows)

#ifndef FrxeditframeHPP
#define FrxeditframeHPP

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
#include <Vcl.ImgList.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.Buttons.hpp>
#include <frxCtrls.hpp>
#include <frxDock.hpp>
#include <frxClass.hpp>
#include <frxDesgnCtrls.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxeditframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxFrameEditorForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxFrameEditorForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TGroupBox* FrameGB;
	Vcl::Buttons::TSpeedButton* FrameAllB;
	Vcl::Buttons::TSpeedButton* FrameNoB;
	Vcl::Buttons::TSpeedButton* FrameTopB;
	Vcl::Buttons::TSpeedButton* FrameBottomB;
	Vcl::Buttons::TSpeedButton* FrameLeftB;
	Vcl::Buttons::TSpeedButton* FrameRightB;
	Vcl::Stdctrls::TCheckBox* ShadowCB;
	Vcl::Stdctrls::TLabel* ShadowWidthL;
	Vcl::Stdctrls::TComboBox* ShadowWidthCB;
	Vcl::Stdctrls::TLabel* ShadowColorL;
	Vcl::Stdctrls::TGroupBox* LineGB;
	Vcl::Stdctrls::TLabel* LineStyleL;
	Vcl::Stdctrls::TLabel* LineWidthL;
	Vcl::Stdctrls::TComboBox* LineWidthCB;
	Vcl::Stdctrls::TLabel* LineColorL;
	Vcl::Stdctrls::TLabel* HintL;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FrameAllBClick(System::TObject* Sender);
	void __fastcall FrameNoBClick(System::TObject* Sender);
	void __fastcall FrameLineClick(System::TObject* Sender);
	void __fastcall ShadowCBClick(System::TObject* Sender);
	void __fastcall ShadowWidthCBChange(System::TObject* Sender);
	void __fastcall LineWidthCBChange(System::TObject* Sender);
	
private:
	Frxclass::TfrxFrame* FFrame;
	Frxdesgnctrls::TfrxFrameSampleControl* SampleC;
	Frxdesgnctrls::TfrxLineStyleControl* LineStyleC;
	Frxdesgnctrls::TfrxColorComboBox* ShadowColorCB;
	Frxdesgnctrls::TfrxColorComboBox* LineColorCB;
	void __fastcall SetFrame(Frxclass::TfrxFrame* const Value);
	void __fastcall FrameLineClicked(Frxclass::TfrxFrameType Line, bool state);
	void __fastcall ShadowColorChanged(System::TObject* Sender);
	void __fastcall LineColorChanged(System::TObject* Sender);
	void __fastcall LineStyleChanged(System::TObject* Sender);
	Frxclass::TfrxFrameStyle __fastcall LineStyle(void);
	System::Extended __fastcall LineWidth(void);
	System::Uitypes::TColor __fastcall LineColor(void);
	void __fastcall UpdateControls(void);
	void __fastcall Change(void);
	
public:
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property Frxclass::TfrxFrame* Frame = {read=FFrame, write=SetFrame};
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxFrameEditorForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxFrameEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxFrameEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxFrameEditorForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITFRAME)
using namespace Frxeditframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditframeHPP
