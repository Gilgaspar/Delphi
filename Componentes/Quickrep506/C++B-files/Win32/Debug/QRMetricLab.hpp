// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRMetricLab.pas' rev: 32.00 (Windows)

#ifndef QrmetriclabHPP
#define QrmetriclabHPP

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
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRCtrls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrmetriclab
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRMetricLabel;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TQRMetlabOnPrintEvent)(System::TObject* sender, Vcl::Graphics::TCanvas* gcanvas, System::UnicodeString &printString);

enum DECLSPEC_DENUM TSpacingMode : unsigned char { Horiz, HorizAndVertical };

class PASCALIMPLEMENTATION TQRMetricLabel : public Qrctrls::TQRCustomLabel
{
	typedef Qrctrls::TQRCustomLabel inherited;
	
private:
	TQRMetlabOnPrintEvent FBeforePrint;
	TSpacingMode FSpacingMode;
	System::Classes::TStrings* FXlist;
	System::Classes::TStrings* FYList;
	System::WideChar *lzCaption;
	void __fastcall SetBeforePrint(TQRMetlabOnPrintEvent value);
	void __fastcall SetXlist(System::Classes::TStrings* value);
	void __fastcall SetYlist(System::Classes::TStrings* value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	System::StaticArray<int, 256> FXValues;
	System::StaticArray<int, 256> FYValues;
	__fastcall virtual TQRMetricLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRMetricLabel(void);
	virtual void __fastcall Prepare(void);
	
__published:
	__property TQRMetlabOnPrintEvent BeforePrint = {read=FBeforePrint, write=SetBeforePrint};
	__property Visible = {default=1};
	__property XLColumn;
	__property Font;
	__property Transparent;
	__property color = {default=0};
	__property Caption;
	__property TSpacingMode SpacingMode = {read=FSpacingMode, write=FSpacingMode, nodefault};
	__property System::Classes::TStrings* X_Spacing = {read=FXlist, write=SetXlist};
	__property System::Classes::TStrings* Y_Spacing = {read=FYList, write=SetYlist};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRMetricLabel(HWND ParentWindow) : Qrctrls::TQRCustomLabel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrmetriclab */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRMETRICLAB)
using namespace Qrmetriclab;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrmetriclabHPP
