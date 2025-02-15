// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRPrgres.pas' rev: 32.00 (Windows)

#ifndef QrprgresHPP
#define QrprgresHPP

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
#include <Vcl.ComCtrls.hpp>
#include <QRPrntr.hpp>
#include <qr5const.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrprgres
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRProgressForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRProgressForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Info;
	Vcl::Stdctrls::TButton* CancelButton;
	Vcl::Comctrls::TProgressBar* Gauge;
	void __fastcall CancelButtonClick(System::TObject* Sender);
	
private:
	Qrprntr::TQRPrinter* FQRPrinter;
	
protected:
	MESSAGE void __fastcall CMQRPROGRESSUPDATE(void *Message);
	
public:
	__property Qrprntr::TQRPrinter* QRPrinter = {read=FQRPrinter, write=FQRPrinter};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRProgressForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRProgressForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRProgressForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRProgressForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrprgres */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPRGRES)
using namespace Qrprgres;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrprgresHPP
