// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DelphiZXIngQRCode_q.pas' rev: 30.00 (Windows)

#ifndef Delphizxingqrcode_qHPP
#define Delphizxingqrcode_qHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Delphizxingqrcode_q
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDelphiZXingQRCode;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TQRCodeEncoding : unsigned char { qrAuto, qrNumeric, qrAlphanumeric, qrISO88591, qrUTF8NoBOM, qrUTF8BOM };

typedef System::DynamicArray<bool> Delphizxingqrcode_q__1;

typedef System::DynamicArray<System::DynamicArray<bool> > T2DBooleanArray;

class PASCALIMPLEMENTATION TDelphiZXingQRCode : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::WideString FData;
	int FRows;
	int FColumns;
	TQRCodeEncoding FEncoding;
	int FQuietZone;
	T2DBooleanArray FElements;
	void __fastcall SetEncoding(TQRCodeEncoding NewEncoding);
	void __fastcall SetData(const System::WideString NewData);
	void __fastcall SetQuietZone(int NewQuietZone);
	bool __fastcall GetIsBlack(int Row, int Column);
	void __fastcall Update(void);
	
public:
	__fastcall TDelphiZXingQRCode(void);
	__property System::WideString Data = {read=FData, write=SetData};
	__property TQRCodeEncoding Encoding = {read=FEncoding, write=SetEncoding, nodefault};
	__property int QuietZone = {read=FQuietZone, write=SetQuietZone, nodefault};
	__property int Rows = {read=FRows, nodefault};
	__property int Columns = {read=FColumns, nodefault};
	__property bool IsBlack[int Row][int Column] = {read=GetIsBlack};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDelphiZXingQRCode(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Delphizxingqrcode_q */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DELPHIZXINGQRCODE_Q)
using namespace Delphizxingqrcode_q;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Delphizxingqrcode_qHPP
