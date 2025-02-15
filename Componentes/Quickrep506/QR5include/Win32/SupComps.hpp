// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SupComps.pas' rev: 30.00 (Windows)

#ifndef SupcompsHPP
#define SupcompsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <QuickRpt.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Supcomps
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEnhancedListbox;
class DELPHICLASS TEventScrollbox;
class DELPHICLASS TRulerPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEnhancedListbox : public Vcl::Stdctrls::TListBox
{
	typedef Vcl::Stdctrls::TListBox inherited;
	
private:
	System::Classes::TNotifyEvent FOnChange;
	int FLastSel;
	
protected:
	virtual void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	
public:
	__fastcall virtual TEnhancedListbox(System::Classes::TComponent* AOwner);
	void __fastcall MoveUp(void);
	void __fastcall MoveDown(void);
	void __fastcall MoveItems(int DestIndex);
	void __fastcall MoveItemsRelative(int R);
	void __fastcall MoveFromListbox(Vcl::Stdctrls::TListBox* Source, int DestIndex);
	void __fastcall CopyFromListbox(Vcl::Stdctrls::TListBox* Source, int DestIndex);
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TEnhancedListbox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEnhancedListbox(HWND ParentWindow) : Vcl::Stdctrls::TListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TEventScrollbox : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
private:
	System::Classes::TNotifyEvent fOnScrollHorz;
	System::Classes::TNotifyEvent fOnScrollVert;
	int fWheelMousePixels;
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	
protected:
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	
public:
	__fastcall virtual TEventScrollbox(System::Classes::TComponent* AOwner);
	virtual void __fastcall AutoScrollInView(Vcl::Controls::TControl* AControl);
	
__published:
	__property int WheelMousePixels = {read=fWheelMousePixels, write=fWheelMousePixels, nodefault};
	__property System::Classes::TNotifyEvent OnScrollHorz = {read=fOnScrollHorz, write=fOnScrollHorz};
	__property System::Classes::TNotifyEvent OnScrollVert = {read=fOnScrollVert, write=fOnScrollVert};
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TEventScrollbox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEventScrollbox(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TRulerPanel : public Vcl::Extctrls::TPanel
{
	typedef Vcl::Extctrls::TPanel inherited;
	
private:
	System::Uitypes::TColor fMajorColor;
	System::Uitypes::TColor fMinorColor;
	Vcl::Graphics::TPenStyle fMajorStyle;
	Vcl::Graphics::TPenStyle fMinorStyle;
	Quickrpt::TQuickRep* fQReport;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TRulerPanel(System::Classes::TComponent* AOwner);
	
__published:
	__property System::Uitypes::TColor MajorColor = {read=fMajorColor, write=fMajorColor, nodefault};
	__property Vcl::Graphics::TPenStyle MajorStyle = {read=fMajorStyle, write=fMajorStyle, nodefault};
	__property System::Uitypes::TColor MinorColor = {read=fMinorColor, write=fMinorColor, nodefault};
	__property Vcl::Graphics::TPenStyle MinorStyle = {read=fMinorStyle, write=fMinorStyle, nodefault};
	__property Quickrpt::TQuickRep* QReport = {read=fQReport, write=fQReport};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRulerPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRulerPanel(HWND ParentWindow) : Vcl::Extctrls::TPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Supcomps */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SUPCOMPS)
using namespace Supcomps;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SupcompsHPP
