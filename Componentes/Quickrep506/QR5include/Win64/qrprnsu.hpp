// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRPrnSu.pas' rev: 30.00 (Windows)

#ifndef QrprnsuHPP
#define QrprnsuHPP

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
#include <Winapi.CommDlg.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Printers.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrprnsu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRCommonDialog;
class DELPHICLASS TQRBasePrintDialog;
class DELPHICLASS TQRPrinterSetupDialog;
class DELPHICLASS TQRPrintDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRCommonDialog : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FCtl3D;
	void *FDefWndProc;
	System::Classes::THelpContext FHelpContext;
	HWND FHandle;
	void *FObjectInstance;
	System::WideChar *FTemplate;
	System::Classes::TNotifyEvent FOnClose;
	System::Classes::TNotifyEvent FOnShow;
	MESSAGE void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMInitDialog(Winapi::Messages::TWMInitDialog &Message);
	MESSAGE void __fastcall WMNCDestroy(Winapi::Messages::TWMNoParams &Message);
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual bool __fastcall MessageHook(Winapi::Messages::TMessage &Msg);
	virtual System::LongBool __fastcall TaskModalDialog(void * DialogFunc, void *DialogData);
	DYNAMIC void __fastcall DoClose(void);
	DYNAMIC void __fastcall DoShow(void);
	virtual bool __fastcall Execute(void) = 0 ;
	__property System::WideChar * Template = {read=FTemplate, write=FTemplate};
	
public:
	__fastcall virtual TQRCommonDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCommonDialog(void);
	virtual void __fastcall DefaultHandler(void *Message);
	__property HWND Handle = {read=FHandle};
	
__published:
	__property bool Ctl3D = {read=FCtl3D, write=FCtl3D, default=1};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
};


class PASCALIMPLEMENTATION TQRBasePrintDialog : public TQRCommonDialog
{
	typedef TQRCommonDialog inherited;
	
private:
	Vcl::Printers::TPrinter* FPrinter;
	
protected:
	System::StaticArray<System::WideChar, 1025> Device;
	System::StaticArray<System::WideChar, 1025> Driver;
	System::StaticArray<System::WideChar, 1025> Port;
	NativeUInt __fastcall CopyData(NativeUInt Handle);
	void __fastcall SetPrinter(NativeUInt DeviceMode, NativeUInt DeviceNames);
	void __fastcall GetPrinter(NativeUInt &DeviceMode, NativeUInt &DeviceNames);
	
public:
	__fastcall virtual TQRBasePrintDialog(System::Classes::TComponent* AOwner);
	__property Vcl::Printers::TPrinter* Printer = {read=FPrinter, write=FPrinter};
public:
	/* TQRCommonDialog.Destroy */ inline __fastcall virtual ~TQRBasePrintDialog(void) { }
	
};


class PASCALIMPLEMENTATION TQRPrinterSetupDialog : public TQRBasePrintDialog
{
	typedef TQRBasePrintDialog inherited;
	
public:
	virtual bool __fastcall Execute(void);
public:
	/* TQRBasePrintDialog.Create */ inline __fastcall virtual TQRPrinterSetupDialog(System::Classes::TComponent* AOwner) : TQRBasePrintDialog(AOwner) { }
	
public:
	/* TQRCommonDialog.Destroy */ inline __fastcall virtual ~TQRPrinterSetupDialog(void) { }
	
};


class PASCALIMPLEMENTATION TQRPrintDialog : public TQRBasePrintDialog
{
	typedef TQRBasePrintDialog inherited;
	
private:
	int FFromPage;
	int FToPage;
	int FCollate;
	System::Uitypes::TPrintDialogOptions FOptions;
	bool FPrintToFile;
	System::Uitypes::TPrintRange FPrintRange;
	int FMinPage;
	int FMaxPage;
	int FCopies;
	int FPrintQuality;
	int FColorOption;
	int FOutputBin;
	int FPaperSize;
	bool FDuplex;
	System::Extended FPaperwidth;
	System::Extended FPaperlength;
	unsigned FdmFields;
	short FOrientation;
	int FDuplexCode;
	void __fastcall SetNumCopies(int Value);
	
public:
	virtual bool __fastcall Execute(void);
	
__published:
	__property bool Duplex = {read=FDuplex, write=FDuplex, default=0};
	__property int DuplexCode = {read=FDuplexCode, write=FDuplexCode, default=0};
	__property int OutputBin = {read=FOutputBin, write=FOutputBin, default=0};
	__property int PaperSize = {read=FPaperSize, write=FPaperSize, default=0};
	__property System::Extended Paperwidth = {read=FPaperwidth, write=FPaperwidth};
	__property System::Extended Paperlength = {read=FPaperlength, write=FPaperlength};
	__property int Collate = {read=FCollate, write=FCollate, default=0};
	__property int Copies = {read=FCopies, write=SetNumCopies, default=1};
	__property int FromPage = {read=FFromPage, write=FFromPage, default=0};
	__property int PrintQuality = {read=FPrintQuality, write=FPrintQuality, default=0};
	__property int ColorOption = {read=FColorOption, write=FColorOption, default=0};
	__property int MinPage = {read=FMinPage, write=FMinPage, default=0};
	__property int MaxPage = {read=FMaxPage, write=FMaxPage, default=0};
	__property System::Uitypes::TPrintDialogOptions Options = {read=FOptions, write=FOptions, default=0};
	__property bool PrintToFile = {read=FPrintToFile, write=FPrintToFile, default=0};
	__property System::Uitypes::TPrintRange PrintRange = {read=FPrintRange, write=FPrintRange, default=0};
	__property int ToPage = {read=FToPage, write=FToPage, default=0};
	__property short Orientation = {read=FOrientation, write=FOrientation, default=1};
public:
	/* TQRBasePrintDialog.Create */ inline __fastcall virtual TQRPrintDialog(System::Classes::TComponent* AOwner) : TQRBasePrintDialog(AOwner) { }
	
public:
	/* TQRCommonDialog.Destroy */ inline __fastcall virtual ~TQRPrintDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MaxCustomColors = System::Int8(0x10);
}	/* namespace Qrprnsu */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPRNSU)
using namespace Qrprnsu;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrprnsuHPP
