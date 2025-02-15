// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRDMBarcode.pas' rev: 30.00 (Windows)

#ifndef QrdmbarcodeHPP
#define QrdmbarcodeHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Winapi.RichEdit.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRExpr.hpp>
#include <QRCtrls.hpp>
#include <QRLablEd.hpp>
#include <Data.DB.hpp>
#include <ECC200Consts.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrdmbarcode
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRDMBarcode;
class DELPHICLASS TQRDbDMBarcode;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRDMBarcode : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Vcl::Graphics::TPicture* FPicture;
	Ecc200consts::TMatrixsize FMatrixRows;
	System::UnicodeString FText;
	bool FGS1;
	System::WideChar FFNCChar;
	bool FQuietZone;
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetMatrixrows(Ecc200consts::TMatrixsize value);
	
protected:
	void __fastcall SetQuietZone(bool Value);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	__fastcall virtual TQRDMBarcode(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRDMBarcode(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	
__published:
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property Ecc200consts::TMatrixsize MatrixRows = {read=FMatrixRows, write=SetMatrixrows, nodefault};
	__property System::WideChar FNCChar = {read=FFNCChar, write=FFNCChar, nodefault};
	__property bool GS1 = {read=FGS1, write=FGS1, nodefault};
	__property bool QuietZone = {read=FQuietZone, write=SetQuietZone, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDMBarcode(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRDbDMBarcode : public Qrctrls::TQRCustomLabel
{
	typedef Qrctrls::TQRCustomLabel inherited;
	
private:
	Data::Db::TField* Field;
	int FieldNo;
	bool FieldOK;
	System::SmallString<30> DataSourceName;
	Data::Db::TDataSet* FDataSet;
	System::UnicodeString FDataField;
	System::UnicodeString FMask;
	bool IsMemo;
	Ecc200consts::TMatrixsize FMatrixRows;
	System::UnicodeString FText;
	bool FGS1;
	System::WideChar FFNCChar;
	bool FQuietZone;
	void __fastcall SetMatrixrows(Ecc200consts::TMatrixsize value);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	void __fastcall SetDataField(System::UnicodeString Value);
	void __fastcall SetMask(System::UnicodeString Value);
	void __fastcall SetQuietZone(bool Value);
	
protected:
	virtual void __fastcall SetAutoSize(bool Value);
	virtual void __fastcall Paint(void);
	HIDESBASE bool __fastcall GetCaptionBased(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall UnPrepare(void);
	
public:
	__fastcall virtual TQRDbDMBarcode(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	virtual void __fastcall GetFieldString(System::UnicodeString &DataStr);
	
__published:
	__property Ecc200consts::TMatrixsize MatrixRows = {read=FMatrixRows, write=SetMatrixrows, nodefault};
	__property System::WideChar FNCChar = {read=FFNCChar, write=FFNCChar, nodefault};
	__property bool GS1 = {read=FGS1, write=FGS1, nodefault};
	__property bool QuietZone = {read=FQuietZone, write=SetQuietZone, nodefault};
	__property AutoSize = {default=1};
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataField = {read=FDataField, write=SetDataField};
	__property System::UnicodeString Mask = {read=FMask, write=SetMask};
	__property OnPrint;
public:
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRDbDMBarcode(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDbDMBarcode(HWND ParentWindow) : Qrctrls::TQRCustomLabel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrdmbarcode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRDMBARCODE)
using namespace Qrdmbarcode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrdmbarcodeHPP
