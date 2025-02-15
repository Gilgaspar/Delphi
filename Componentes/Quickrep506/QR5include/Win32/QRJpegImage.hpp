// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRJpegImage.pas' rev: 30.00 (Windows)

#ifndef QrjpegimageHPP
#define QrjpegimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <QuickRpt.hpp>
#include <Data.DB.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Imaging.jpeg.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrjpegimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRDBJPGImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRDBJPGImage : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Data::Db::TField* FField;
	Data::Db::TDataSet* FDataSet;
	System::UnicodeString FDataField;
	Vcl::Graphics::TPicture* FPicture;
	bool FStretch;
	bool FCenter;
	int FImageOffset;
	bool FPictureLoaded;
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetCenter(bool Value);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* Value);
	void __fastcall SetStretch(bool Value);
	
protected:
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall UnPrepare(void);
	
public:
	__fastcall virtual TQRDBJPGImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRDBJPGImage(void);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	virtual void __fastcall GetFieldString(System::UnicodeString &DataStr);
	void __fastcall LoadPicture(void);
	__property Data::Db::TField* Field = {read=FField};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	
__published:
	__property bool Center = {read=FCenter, write=SetCenter, default=1};
	__property System::UnicodeString DataField = {read=FDataField, write=SetDataField};
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property bool Stretch = {read=FStretch, write=SetStretch, default=0};
	__property int ImageOffset = {read=FImageOffset, write=FImageOffset, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDBJPGImage(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrjpegimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRJPEGIMAGE)
using namespace Qrjpegimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrjpegimageHPP
