﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxRichEditor.pas' rev: 32.00 (Windows)

#ifndef FrxricheditorHPP
#define FrxricheditorHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <frxClass.hpp>
#include <frxRich.hpp>
#include <frxCustomEditors.hpp>
#include <frxCtrls.hpp>
#include <frxRichEdit.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxUnicodeCtrls.hpp>
#include <frxBaseForm.hpp>
#include <frxDock.hpp>
#include <System.Variants.hpp>
#include <frxDsgnIntf.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxricheditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxRichEditor;
class DELPHICLASS TfrxRichEditorForm;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxRichEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall virtual TfrxRichEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxRichEditor(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxRichEditorForm : public Frxbaseform::TfrxBaseLoadSavePrefForm
{
	typedef Frxbaseform::TfrxBaseLoadSavePrefForm inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Comctrls::TToolBar* SpeedBar;
	Vcl::Extctrls::TPanel* Ruler;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Vcl::Stdctrls::TLabel* FirstInd;
	Vcl::Stdctrls::TLabel* LeftInd;
	Vcl::Extctrls::TBevel* RulerLine;
	Vcl::Stdctrls::TLabel* RightInd;
	Vcl::Comctrls::TToolButton* BoldB;
	Vcl::Comctrls::TToolButton* ItalicB;
	Vcl::Comctrls::TToolButton* LeftAlignB;
	Vcl::Comctrls::TToolButton* CenterAlignB;
	Vcl::Comctrls::TToolButton* RightAlignB;
	Vcl::Comctrls::TToolButton* UnderlineB;
	Vcl::Comctrls::TToolButton* BulletsB;
	Vcl::Comctrls::TToolButton* TTB;
	Vcl::Comctrls::TToolButton* CancelB;
	Vcl::Comctrls::TToolButton* OkB;
	Vcl::Comctrls::TToolButton* ExprB;
	Frxctrls::TfrxFontComboBox* FontNameCB;
	Frxctrls::TfrxComboBox* FontSizeCB;
	Vcl::Comctrls::TToolButton* OpenB;
	Vcl::Comctrls::TToolButton* SaveB;
	Vcl::Comctrls::TToolButton* UndoB;
	Vcl::Comctrls::TToolButton* Sep1;
	Vcl::Comctrls::TToolButton* Sep2;
	Frxdock::TfrxTBPanel* Sep3;
	Vcl::Comctrls::TToolButton* Sep4;
	Vcl::Comctrls::TToolButton* Sep5;
	Vcl::Comctrls::TToolButton* BlockAlignB;
	Vcl::Comctrls::TToolButton* FillColorB;
	Vcl::Menus::TPopupMenu* FillColorPopupMenu;
	void __fastcall SelectionChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FileOpen(System::TObject* Sender);
	void __fastcall FileSaveAs(System::TObject* Sender);
	void __fastcall EditUndo(System::TObject* Sender);
	void __fastcall SelectFont(System::TObject* Sender);
	void __fastcall RulerResize(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall BoldBClick(System::TObject* Sender);
	void __fastcall AlignButtonClick(System::TObject* Sender);
	void __fastcall FontNameCBChange(System::TObject* Sender);
	void __fastcall BulletsBClick(System::TObject* Sender);
	void __fastcall RulerItemMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall RulerItemMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FirstIndMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall LeftIndMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall RightIndMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall ExprBClick(System::TObject* Sender);
	void __fastcall FontSizeCBChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FillColorBClick(System::TObject* Sender);
	void __fastcall FillColorPopupMenuPopup(System::TObject* Sender);
	void __fastcall FontSizeCBKeyPress(System::TObject* Sender, System::WideChar &Key);
	
private:
	bool FDragging;
	int FDragOfs;
	System::Uitypes::TColor FFillColor;
	Frxrich::TfrxRichView* FRichView;
	bool FUpdating;
	Frxunicodectrls::TRxUnicodeRichEdit* RichEdit1;
	Frxrichedit::TRxTextAttributes* __fastcall CurrText(void);
	void __fastcall SetupRuler(void);
	void __fastcall SetEditRect(void);
	void __fastcall OnColorChanged(System::TObject* Sender);
	
public:
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property Frxrich::TfrxRichView* RichView = {read=FRichView, write=FRichView};
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxRichEditorForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseLoadSavePrefForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxRichEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseLoadSavePrefForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxRichEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxRichEditorForm(HWND ParentWindow) : Frxbaseform::TfrxBaseLoadSavePrefForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxricheditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXRICHEDITOR)
using namespace Frxricheditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxricheditorHPP
