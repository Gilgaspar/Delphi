// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcode2D.pas' rev: 32.00 (Windows)

#ifndef Frxbarcode2dHPP
#define Frxbarcode2dHPP

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
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <System.Variants.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <frxClass.hpp>
#include <frxBarcodePDF417.hpp>
#include <frxBarcodeDataMatrix.hpp>
#include <frxBarcodeQR.hpp>
#include <frxBarcodeAztec.hpp>
#include <frxBarcodeMaxiCode.hpp>
#include <frxGS1Databar.hpp>
#include <frxBarcode2DBase.hpp>
#include <frxBarcodeProperties.hpp>
#include <frx2DBarcodesPresets.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbarcode2d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcode2DView;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxBarcode2DType : unsigned char { bcCodePDF417, bcCodeDataMatrix, bcCodeQR, bcCodeAztec, bcCodeMaxiCode, bcGS1DatabarE, bcGS1DatabarES };

class PASCALIMPLEMENTATION TfrxBarcode2DView : public Frxclass::TfrxStretcheable
{
	typedef Frxclass::TfrxStretcheable inherited;
	
private:
	Frxbarcode2dbase::TfrxBarcode2DBase* FBarCode;
	TfrxBarcode2DType FBarType;
	Frxclass::TfrxHAlign FHAlign;
	Frxbarcodeproperties::TfrxBarcode2DProperties* FProp;
	System::UnicodeString FExpression;
	bool FMacroLoaded;
	bool FAutoSize;
	Frx2dbarcodespresets::TfrxObjectDataPreset* FExpressionPreset;
	Frxclass::TfrxExtPropList* FExtPropList;
	void __fastcall SetZoom(System::Extended z);
	System::Extended __fastcall GetZoom(void);
	void __fastcall SetRotation(int v);
	int __fastcall GetRotation(void);
	void __fastcall SetShowText(bool v);
	bool __fastcall GetShowText(void);
	void __fastcall SetText(System::UnicodeString v);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetFontScaled(bool v);
	bool __fastcall GetFontScaled(void);
	void __fastcall SetErrorText(System::UnicodeString v);
	System::UnicodeString __fastcall GetErrorText(void);
	void __fastcall SetQuietZone(int v);
	int __fastcall GetQuietZone(void);
	void __fastcall SetColorBar(System::Uitypes::TColor c);
	System::Uitypes::TColor __fastcall GetColorBar(void);
	void __fastcall SetProp(Frxbarcodeproperties::TfrxBarcode2DProperties* v);
	void __fastcall SetBarType(TfrxBarcode2DType v);
	void __fastcall CalcSize(void);
	Frxclass::TfrxPoint __fastcall CalcAddSize(void);
	System::UnicodeString __fastcall GetHexData(void);
	void __fastcall SetHexData(const System::UnicodeString Value);
	void __fastcall WritePreset(System::Classes::TWriter* Writer);
	void __fastcall ReadPreset(System::Classes::TReader* Reader);
	virtual Frx2dbarcodespresets::TfrxObjectDataPreset* __fastcall GetDataPreset(void);
	
protected:
	virtual void __fastcall SetWidth(System::Extended Value);
	virtual void __fastcall SetHeight(System::Extended Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	Frxclass::TfrxExtPropList* __fastcall GetProperies(void);
	
public:
	__fastcall virtual TfrxBarcode2DView(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxBarcode2DView(System::Classes::TComponent* AOwner, System::Word Flags);
	__fastcall virtual ~TfrxBarcode2DView(void);
	virtual Vcl::Graphics::TGraphic* __fastcall GetVectorGraphic(bool DrawFill = false);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall GetData(void);
	virtual Frxclass::TfrxRect __fastcall GetRealBounds(void);
	virtual void __fastcall GetScaleFactor(System::Extended &ScaleX, System::Extended &ScaleY);
	virtual System::Extended __fastcall CalcHeight(void);
	virtual System::Extended __fastcall DrawPart(void);
	virtual void __fastcall SaveContentToDictionary(Frxclass::TfrxReport* aReport, Frxclass::TfrxPostProcessor* PostProcessor);
	virtual bool __fastcall LoadContentFromDictionary(Frxclass::TfrxReport* aReport, Frxclass::TfrxMacrosItem* aItem);
	virtual void __fastcall ProcessDictionary(Frxclass::TfrxMacrosItem* aItem, Frxclass::TfrxReport* aReport, Frxclass::TfrxPostProcessor* PostProcessor);
	__property Frx2dbarcodespresets::TfrxObjectDataPreset* ExpressionPreset = {read=FExpressionPreset};
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=1};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property TfrxBarcode2DType BarType = {read=FBarType, write=SetBarType, nodefault};
	__property Frxbarcodeproperties::TfrxBarcode2DProperties* BarProperties = {read=FProp, write=SetProp};
	__property BrushStyle;
	__property Color;
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property Fill;
	__property Frame;
	__property Frxclass::TfrxHAlign HAlign = {read=FHAlign, write=FHAlign, default=0};
	__property Processing;
	__property int Rotation = {read=GetRotation, write=SetRotation, nodefault};
	__property bool ShowText = {read=GetShowText, write=SetShowText, nodefault};
	__property TagStr = {default=0};
	__property System::UnicodeString Text = {read=GetText, write=SetText, stored=false};
	__property System::UnicodeString HexData = {read=GetHexData, write=SetHexData};
	__property URL = {default=0};
	__property System::Extended Zoom = {read=GetZoom, write=SetZoom};
	__property Font;
	__property bool FontScaled = {read=GetFontScaled, write=SetFontScaled, nodefault};
	__property System::UnicodeString ErrorText = {read=GetErrorText, write=SetErrorText};
	__property int QuietZone = {read=GetQuietZone, write=SetQuietZone, nodefault};
	__property System::Uitypes::TColor ColorBar = {read=GetColorBar, write=SetColorBar, nodefault};
private:
	void *__IInspectedProperties;	// Frxclass::IInspectedProperties 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {BDBE0326-DA24-4FB8-ADA0-2F740AB6C199}
	operator Frxclass::_di_IInspectedProperties()
	{
		Frxclass::_di_IInspectedProperties intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Frxclass::IInspectedProperties*(void) { return (Frxclass::IInspectedProperties*)&__IInspectedProperties; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcode2d */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODE2D)
using namespace Frxbarcode2d;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxbarcode2dHPP
