// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRGraphcon.pas' rev: 30.00 (Windows)

#ifndef QrgraphconHPP
#define QrgraphconHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.ComCtrls.hpp>
#include <QRXDocument.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRCtrls.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrgraphcon
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRGraphicCanvas;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TQRGraphicOnPrintEvent)(TQRGraphicCanvas* sender, const System::Types::TRect &grect);

typedef void __fastcall (__closure *TQRGraphicOnCommandEvent)(TQRGraphicCanvas* sender);

class PASCALIMPLEMENTATION TQRGraphicCanvas : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	TQRGraphicOnPrintEvent FBeforePrint;
	System::Classes::TStringList* commlist;
	void __fastcall SetBeforePrint(TQRGraphicOnPrintEvent value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	void __fastcall RenderComms(Vcl::Graphics::TCanvas* acanvas, System::Extended OffX, System::Extended OffY);
	
public:
	__fastcall virtual TQRGraphicCanvas(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRGraphicCanvas(void);
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	void __fastcall TextOut(int x, int y, System::UnicodeString s);
	void __fastcall MoveTo(int x, int y);
	void __fastcall LinetoTo(int x, int y);
	void __fastcall Ellipse(int x, int y, int w, int h);
	void __fastcall rectangle(int x, int y, int w, int h);
	void __fastcall setPenWidth(System::Extended w);
	void __fastcall setPenColor(System::Uitypes::TColor pencolor);
	void __fastcall setBrushColor(System::Uitypes::TColor brushcolor);
	void __fastcall setPenStyle(Vcl::Graphics::TPenStyle pstyle);
	void __fastcall setBrushStyle(Vcl::Graphics::TBrushStyle bstyle);
	HIDESBASE void __fastcall setFont(System::UnicodeString s);
	void __fastcall setFontSize(int h);
	
__published:
	__property TQRGraphicOnPrintEvent BeforePrint = {read=FBeforePrint, write=SetBeforePrint};
	__property Visible = {default=1};
	__property XLColumn;
	__property Font;
	__property Transparent;
	__property color = {default=-16777211};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRGraphicCanvas(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrgraphcon */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRGRAPHCON)
using namespace Qrgraphcon;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrgraphconHPP
