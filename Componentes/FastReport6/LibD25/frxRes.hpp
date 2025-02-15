// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxRes.pas' rev: 32.00 (Windows)

#ifndef FrxresHPP
#define FrxresHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Buttons.hpp>
#include <frxUnicodeUtils.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Variants.hpp>
#include <System.WideStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxres
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxResources;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxResources : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Controls::TImageList* FDisabledButtonImages;
	Vcl::Controls::TImageList* FMainButtonImages;
	System::Classes::TStringList* FNames;
	Vcl::Controls::TImageList* FObjectImages;
	Vcl::Controls::TImageList* FPreviewButtonImages;
	System::Widestrings::TWideStrings* FValues;
	Vcl::Controls::TImageList* FWizardImages;
	System::Classes::TStringList* FLanguages;
	System::Classes::TStringList* FImagesList;
	System::UnicodeString FHelpFile;
	unsigned FCP;
	int FImagesPPI;
	void __fastcall BuildLanguagesList(void);
	Vcl::Controls::TImageList* __fastcall GetMainButtonImages(void);
	Vcl::Controls::TImageList* __fastcall GetObjectImages(void);
	Vcl::Controls::TImageList* __fastcall GetPreviewButtonImages(void);
	Vcl::Controls::TImageList* __fastcall GetWizardImages(void);
	void __fastcall ResizeImages(void);
	void __fastcall SetImagesPPI(int Value);
	Vcl::Controls::TImageList* __fastcall GetImages(const System::UnicodeString aName, int aPPIScale, int aImageWidth = 0x10, int aImageHeight = 0x10);
	Vcl::Controls::TImageList* __fastcall GetDisabledButtonImages(void);
	void __fastcall AssignImages(Vcl::Graphics::TBitmap* Bitmap, int dx, int dy, Vcl::Controls::TImageList* ImgList1, Vcl::Controls::TImageList* ImgList2 = (Vcl::Controls::TImageList*)(0x0));
	
public:
	__fastcall TfrxResources(void);
	__fastcall virtual ~TfrxResources(void);
	System::UnicodeString __fastcall Get(const System::UnicodeString StrName);
	void __fastcall Add(const System::UnicodeString Ref, const System::UnicodeString Str);
	void __fastcall AddW(const System::UnicodeString Ref, System::WideString Str);
	void __fastcall AddStrings(const System::UnicodeString Str);
	void __fastcall AddXML(const System::AnsiString Str);
	void __fastcall Clear(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SetButtonImages(Vcl::Graphics::TBitmap* Images, bool Clear = false);
	void __fastcall SetObjectImages(Vcl::Graphics::TBitmap* Images, bool Clear = false);
	void __fastcall SetPreviewButtonImages(Vcl::Graphics::TBitmap* Images, bool Clear = false);
	void __fastcall SetWizardImages(Vcl::Graphics::TBitmap* Images, bool Clear = false);
	void __fastcall SetGlyph(Vcl::Buttons::TSpeedButton* Button, int Index);
	void __fastcall UpdateFSResources(void);
	void __fastcall Help(System::TObject* Sender)/* overload */;
	__property Vcl::Controls::TImageList* DisabledButtonImages = {read=GetDisabledButtonImages};
	__property Vcl::Controls::TImageList* MainButtonImages = {read=GetMainButtonImages};
	__property Vcl::Controls::TImageList* PreviewButtonImages = {read=GetPreviewButtonImages};
	__property Vcl::Controls::TImageList* ObjectImages = {read=GetObjectImages};
	__property Vcl::Controls::TImageList* WizardImages = {read=GetWizardImages};
	__property System::Classes::TStringList* Languages = {read=FLanguages};
	__property System::UnicodeString HelpFile = {read=FHelpFile, write=FHelpFile};
	__property int ImagesPPI = {read=FImagesPPI, write=SetImagesPPI, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 frxDefToolImageWidth = System::Int8(0x10);
static const System::Int8 frxDefToolImageHeight = System::Int8(0x10);
extern DELPHI_PACKAGE TfrxResources* __fastcall frxResources(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxGet(int ID);
}	/* namespace Frxres */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXRES)
using namespace Frxres;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxresHPP
