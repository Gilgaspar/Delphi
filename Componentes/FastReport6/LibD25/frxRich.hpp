﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxRich.pas' rev: 32.00 (Windows)

#ifndef FrxrichHPP
#define FrxrichHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <frxClass.hpp>
#include <Winapi.RichEdit.hpp>
#include <frxRichEdit.hpp>
#include <frxPrinter.hpp>
#include <System.Variants.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxrich
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxRichObject;
class DELPHICLASS TfrxRichView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxRichObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxRichObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxRichObject(void) { }
	
};


class PASCALIMPLEMENTATION TfrxRichView : public Frxclass::TfrxStretcheable
{
	typedef Frxclass::TfrxStretcheable inherited;
	
private:
	bool FAllowExpressions;
	System::UnicodeString FExpressionDelimiters;
	TfrxRichView* FFlowTo;
	System::Extended FGapX;
	System::Extended FGapY;
	bool FParaBreak;
	Frxrichedit::TRxRichEdit* FRichEdit;
	System::Classes::TMemoryStream* FTempStream;
	System::Classes::TMemoryStream* FTempStream1;
	bool FWysiwyg;
	bool FHasNextDataPart;
	bool FStopSplit;
	int FLastChar;
	System::UnicodeString FFileLink;
	Vcl::Graphics::TMetafile* __fastcall CreateMetafile(void);
	bool __fastcall IsExprDelimitersStored(void);
	bool __fastcall UsePrinterCanvas(void);
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TfrxRichView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxRichView(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall AfterPrint(void);
	virtual void __fastcall BeforePrint(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall InitPart(void);
	virtual System::Extended __fastcall CalcHeight(void);
	virtual System::Extended __fastcall DrawPart(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::UnicodeString __fastcall GetComponentText(void);
	virtual bool __fastcall HasNextDataPart(System::Extended aFreeSpace);
	virtual bool __fastcall IsEMFExportable(void);
	__property Frxrichedit::TRxRichEdit* RichEdit = {read=FRichEdit};
	
__published:
	__property bool AllowExpressions = {read=FAllowExpressions, write=FAllowExpressions, default=1};
	__property BrushStyle;
	__property Color;
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property System::UnicodeString ExpressionDelimiters = {read=FExpressionDelimiters, write=FExpressionDelimiters, stored=IsExprDelimitersStored};
	__property TfrxRichView* FlowTo = {read=FFlowTo, write=FFlowTo};
	__property FillType = {default=0};
	__property Fill;
	__property Frame;
	__property System::UnicodeString FileLink = {read=FFileLink, write=FFileLink};
	__property System::Extended GapX = {read=FGapX, write=FGapX};
	__property System::Extended GapY = {read=FGapY, write=FGapY};
	__property TagStr = {default=0};
	__property URL = {default=0};
	__property bool Wysiwyg = {read=FWysiwyg, write=FWysiwyg, default=1};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxRichView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxStretcheable(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxAssignRich(Frxrichedit::TRxRichEdit* RichFrom, Frxrichedit::TRxRichEdit* RichTo);
}	/* namespace Frxrich */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXRICH)
using namespace Frxrich;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxrichHPP
