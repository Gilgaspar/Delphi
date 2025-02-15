// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'qrFramelines.pas' rev: 32.00 (Windows)

#ifndef QrframelinesHPP
#define QrframelinesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrframelines
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRFrameline;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRFrameline : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	__fastcall virtual TQRFrameline(System::Classes::TComponent* aOwner);
	
__published:
	__property Left;
public:
	/* TQRPrintable.Destroy */ inline __fastcall virtual ~TQRFrameline(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRFrameline(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Qrframelines */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRFRAMELINES)
using namespace Qrframelines;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrframelinesHPP
