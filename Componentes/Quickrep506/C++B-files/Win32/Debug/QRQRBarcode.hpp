// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRQRBarcode.pas' rev: 32.00 (Windows)

#ifndef QrqrbarcodeHPP
#define QrqrbarcodeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <QuickRpt.hpp>
#include <Data.DB.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <QRCtrls.hpp>
#include <DelphiZXIngQRCode_q.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrqrbarcode
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRQRBarcode;
class DELPHICLASS TQRQRDBBarcode;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRQRBarcode : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	System::UnicodeString FBCText;
	Delphizxingqrcode_q::TQRCodeEncoding FBCEncoding;
	int FBCQuietzone;
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	__fastcall virtual TQRQRBarcode(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRQRBarcode(void);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	
__published:
	__property System::UnicodeString BarcodeText = {read=FBCText, write=FBCText};
	__property Delphizxingqrcode_q::TQRCodeEncoding BarcodeEncoding = {read=FBCEncoding, write=FBCEncoding, nodefault};
	__property int QuietZone = {read=FBCQuietzone, write=FBCQuietzone, default=5};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRQRBarcode(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRQRDBBarcode : public TQRQRBarcode
{
	typedef TQRQRBarcode inherited;
	
private:
	Data::Db::TField* FField;
	Data::Db::TDataSet* FDataSet;
	System::UnicodeString FDataField;
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	
protected:
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall UnPrepare(void);
	
public:
	virtual void __fastcall GetFieldString(System::UnicodeString &DataStr);
	__property Data::Db::TField* Field = {read=FField};
	
__published:
	__property System::UnicodeString DataField = {read=FDataField, write=SetDataField};
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property BarcodeEncoding;
	__property QuietZone = {default=5};
public:
	/* TQRQRBarcode.Create */ inline __fastcall virtual TQRQRDBBarcode(System::Classes::TComponent* AOwner) : TQRQRBarcode(AOwner) { }
	/* TQRQRBarcode.Destroy */ inline __fastcall virtual ~TQRQRDBBarcode(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRQRDBBarcode(HWND ParentWindow) : TQRQRBarcode(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrqrbarcode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRQRBARCODE)
using namespace Qrqrbarcode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrqrbarcodeHPP
