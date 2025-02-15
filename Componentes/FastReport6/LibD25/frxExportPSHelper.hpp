// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPSHelper.pas' rev: 32.00 (Windows)

#ifndef FrxexportpshelperHPP
#define FrxexportpshelperHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <frxExportBaseDialog.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <frxClass.hpp>
#include <frxExportMatrix.hpp>
#include <System.Math.hpp>
#include <frxBarcod.hpp>
#include <frxBarcode.hpp>
#include <frxBarcode2D.hpp>
#include <frxBarcodeMaxiCode.hpp>
#include <frxTableObject.hpp>
#include <frxRes.hpp>
#include <frxImageConverter.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportpshelper
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Dashes : unsigned char { Dash, Dot, DashDot, DashDotDot, DDouble };

enum DECLSPEC_DENUM PSImageFormat : unsigned char { psPng, psJpeg };

typedef System::DynamicArray<double> AOF;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall ColorToHtml(System::Uitypes::TColor DColor);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall HexToTColor(System::UnicodeString sColor);
extern DELPHI_PACKAGE System::Classes::TMemoryStream* __fastcall BitMapStream(Vcl::Graphics::TBitmap* BitMap);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall GetColorFromFill(Frxclass::TfrxCustomFill* Fill);
extern DELPHI_PACKAGE System::UnicodeString __fastcall MemoryStreamToHexStr(System::Classes::TMemoryStream* AStream);
extern DELPHI_PACKAGE double __fastcall MmToPt(double mm);
extern DELPHI_PACKAGE double __fastcall MmToDp(double mm);
extern DELPHI_PACKAGE double __fastcall DpToMm(double dp);
extern DELPHI_PACKAGE double __fastcall DpToPt(double dp);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall GetMixedColor(System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor);
}	/* namespace Frxexportpshelper */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPSHELPER)
using namespace Frxexportpshelper;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportpshelperHPP
