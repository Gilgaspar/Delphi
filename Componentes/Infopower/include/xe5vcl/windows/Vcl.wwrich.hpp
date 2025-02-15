// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.Wwrich.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwrichHPP
#define Vcl_WwrichHPP

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
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <Vcl.DBCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Grids.hpp>	// Pascal unit
#include <Vcl.DBGrids.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <vcl.Wwdotdot.hpp>	// Pascal unit
#include <vcl.Wwdbcomb.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Winapi.RichEdit.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <vcl.wwrchdlg.hpp>	// Pascal unit
#include <vcl.wwriched.hpp>	// Pascal unit
#include <vcl.wwintl.hpp>	// Pascal unit
#include <vcl.Wwrichtb.hpp>	// Pascal unit
#include <Vcl.Printers.hpp>	// Pascal unit
#include <Winapi.CommDlg.hpp>	// Pascal unit
#include <Winapi.WinSpool.hpp>	// Pascal unit
#include <vcl.Wwtrackicon.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <vcl.wwricheditbar.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwrich
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwRichEditForm;
class PASCALIMPLEMENTATION TwwRichEditForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TMainMenu* MainMenu1;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* Print1;
	Vcl::Menus::TMenuItem* PageSetup1;
	Vcl::Menus::TMenuItem* SaveExit1;
	Vcl::Menus::TMenuItem* Exit1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* Undo1;
	Vcl::Menus::TMenuItem* EditSep1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Clear1;
	Vcl::Menus::TMenuItem* SelectAll1;
	Vcl::Menus::TMenuItem* EditSep2;
	Vcl::Menus::TMenuItem* Find1;
	Vcl::Menus::TMenuItem* FindNext1;
	Vcl::Menus::TMenuItem* Replace1;
	Vcl::Menus::TMenuItem* View1;
	Vcl::Menus::TMenuItem* Toolbar1;
	Vcl::Menus::TMenuItem* FormatBar1;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Menus::TMenuItem* OptionsSep;
	Vcl::Menus::TMenuItem* Options1;
	Vcl::Menus::TMenuItem* Insert1;
	Vcl::Menus::TMenuItem* DateandTime1;
	Vcl::Menus::TMenuItem* Format1;
	Vcl::Menus::TMenuItem* Font1;
	Vcl::Menus::TMenuItem* BulletStyle1;
	Vcl::Menus::TMenuItem* Paragraph1;
	Vcl::Menus::TMenuItem* Tabs1;
	Vcl::Menus::TMenuItem* Help1;
	Vcl::Menus::TMenuItem* StatusBar1;
	Vcl::Dialogs::TPrintDialog* PrintDialog1;
	Vcl::Menus::TMenuItem* FileSep2;
	Vcl::Menus::TMenuItem* FileSep1;
	Vcl::Menus::TMenuItem* Load1;
	Vcl::Menus::TMenuItem* SaveAs1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Extctrls::TBevel* ToolBarBevel;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Menus::TMenuItem* Ruler1;
	Vcl::Menus::TMenuItem* InsertObject1;
	Vcl::Menus::TMenuItem* Redo1;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Black1;
	Vcl::Menus::TMenuItem* Green1;
	Vcl::Menus::TMenuItem* Red1;
	Vcl::Menus::TMenuItem* Blue1;
	Vcl::Menus::TMenuItem* Yellow1;
	Vcl::Menus::TMenuItem* Purple1;
	Vcl::Menus::TMenuItem* Teal1;
	Vcl::Menus::TMenuItem* Gray1;
	Vcl::Menus::TMenuItem* Silver1;
	Vcl::Menus::TMenuItem* Red2;
	Vcl::Menus::TMenuItem* Lime1;
	Vcl::Menus::TMenuItem* Yellow2;
	Vcl::Menus::TMenuItem* Blue2;
	Vcl::Menus::TMenuItem* Fuchsia1;
	Vcl::Menus::TMenuItem* Aqua1;
	Vcl::Menus::TMenuItem* White1;
	Vcl::Menus::TMenuItem* Automatic1;
	Vcl::Menus::TMenuItem* Tools1;
	Vcl::Menus::TMenuItem* Spelling1;
	Vcl::Controls::TImageList* ImageListOld;
	Vcl::Menus::TMenuItem* PrintPreview1;
	Vcl::Controls::TImageList* ImageList1;
	void __fastcall BoldButtonClick(System::TObject* Sender);
	void __fastcall UnderlineButtonClick(System::TObject* Sender);
	void __fastcall ItalicButtonClick(System::TObject* Sender);
	void __fastcall RightButtonClick(System::TObject* Sender);
	void __fastcall CenterButtonClick(System::TObject* Sender);
	void __fastcall LeftButtonClick(System::TObject* Sender);
	void __fastcall BulletButtonClick(System::TObject* Sender);
	void __fastcall RichEdit1SelectionChange(System::TObject* Sender);
	void __fastcall Undo1Click(System::TObject* Sender);
	void __fastcall Cut1Click(System::TObject* Sender);
	void __fastcall Copy1Click(System::TObject* Sender);
	void __fastcall Paste1Click(System::TObject* Sender);
	void __fastcall SelectAll1Click(System::TObject* Sender);
	void __fastcall Clear1Click(System::TObject* Sender);
	void __fastcall Find1Click(System::TObject* Sender);
	void __fastcall FindNext1Click(System::TObject* Sender);
	void __fastcall Replace1Click(System::TObject* Sender);
	void __fastcall Font1Click(System::TObject* Sender);
	void __fastcall FontNameComboCloseUp(Vcl::Wwdbcomb::TwwDBComboBox* Sender, bool Select);
	void __fastcall FontSizeComboCloseUp(Vcl::Wwdbcomb::TwwDBComboBox* Sender, bool Select);
	void __fastcall BulletStyle1Click(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall Paragraph1Click(System::TObject* Sender);
	void __fastcall Edit1Click(System::TObject* Sender);
	void __fastcall Print1Click(System::TObject* Sender);
	void __fastcall FormatBar1Click(System::TObject* Sender);
	void __fastcall StatusBar1Click(System::TObject* Sender);
	void __fastcall Exit1Click(System::TObject* Sender);
	void __fastcall SaveExit1Click(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall Tabs1Click(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall PageSetup1Click(System::TObject* Sender);
	void __fastcall Load1Click(System::TObject* Sender);
	void __fastcall SaveAs1Click(System::TObject* Sender);
	void __fastcall Toolbar1Click(System::TObject* Sender);
	void __fastcall NewButtonClick(System::TObject* Sender);
	void __fastcall SaveAsButtonClick(System::TObject* Sender);
	void __fastcall PrintButtonClick(System::TObject* Sender);
	void __fastcall FindButtonClick(System::TObject* Sender);
	void __fastcall CutButtonClick(System::TObject* Sender);
	void __fastcall CopyButtonClick(System::TObject* Sender);
	void __fastcall PasteButtonClick(System::TObject* Sender);
	void __fastcall UndoButtonClick(System::TObject* Sender);
	void __fastcall FontNameComboDropDown(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall Ruler1Click(System::TObject* Sender);
	void __fastcall InsertObject1Click(System::TObject* Sender);
	void __fastcall RedoButtonClick(System::TObject* Sender);
	void __fastcall Redo1Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall Spelling1Click(System::TObject* Sender);
	void __fastcall SpellButtonClick(System::TObject* Sender);
	void __fastcall HighlightButtonClick(System::TObject* Sender);
	void __fastcall BoldButtonMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall JustifyButtonClick(System::TObject* Sender);
	void __fastcall PrintPreviewButtonClick(System::TObject* Sender);
	void __fastcall NumberingButtonClick(System::TObject* Sender);
	
private:
	bool tempDown;
	System::Classes::TNotifyEvent OrigOnHint;
	Vcl::Graphics::TCanvas* FCanvas;
	bool SkipClose;
	void __fastcall RefreshControls(void);
	void __fastcall UpdateStatusBar(void);
	void __fastcall UpdateFormatToolBar(bool ShowToolBar, bool ShowFormatBar);
	void __fastcall FormChangeHint(System::TObject* Sender);
	void __fastcall ApplyIntl(void);
	HIDESBASE MESSAGE void __fastcall WMCommand(Winapi::Messages::TWMCommand &Message);
	void __fastcall HorzScrollRichEdit(System::TObject* Sender);
	Vcl::Comctrls::TToolBar* __fastcall GetToolBar(void);
	Vcl::Comctrls::TToolBar* __fastcall GetFormatBar(void);
	void __fastcall HandleDropDownKeysForCombo(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
public:
	Vcl::Wwriched::TwwCustomRichEdit* OrigRichEdit;
	Vcl::Wwriched::TwwDBRichEdit* RichEdit1;
	Vcl::Wwricheditbar::TwwRichEditBar* RichEditBar1;
	Vcl::Wwriched::TwwRulerPanel* RulerPanel;
	__property Vcl::Comctrls::TToolBar* ToolBar = {read=GetToolBar};
	__property Vcl::Comctrls::TToolBar* FormatBar = {read=GetFormatBar};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwRichEditForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwRichEditForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwRichEditForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwRichEditForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define wwCentimetersPerInch  (2.537000E+00)
extern DELPHI_PACKAGE TwwRichEditForm* wwRichEditForm;
}	/* namespace Wwrich */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRICH)
using namespace Vcl::Wwrich;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwrichHPP
