// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'grimgctrl.pas' rev: 32.00 (Windows)

#ifndef GrimgctrlHPP
#define GrimgctrlHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Printers.hpp>
#include <Data.DB.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.RichEdit.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRExpr.hpp>
#include <QRCtrls.hpp>
#include <QRLablEd.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Grimgctrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRFixFrame;
class DELPHICLASS TQRCustomHTMLLabel;
class DELPHICLASS TQRHTMLLabel;
class DELPHICLASS TQRHRule;
class DELPHICLASS TQRPDFShape;
class DELPHICLASS TQRGrImage;
class DELPHICLASS TQRGrDBImage;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRFixFrame : public Quickrpt::TQRFrame
{
	typedef Quickrpt::TQRFrame inherited;
	
public:
	/* TQRFrame.Create */ inline __fastcall TQRFixFrame(void) : Quickrpt::TQRFrame() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRFixFrame(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLinkDef : unsigned char { ldHTTPJump, ldNameJump, ldNameLabel };

enum DECLSPEC_DENUM TFitMode : unsigned char { fmProportional, fmKeepWidth, fmKeepHeight, fmInsideProp };

class PASCALIMPLEMENTATION TQRCustomHTMLLabel : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	bool FCaptionBased;
	bool DoneFormat;
	bool FAutoSize;
	bool FAutoStretch;
	System::UnicodeString FCaption;
	System::UnicodeString FPrintCaption;
	int FFontSize;
	System::Classes::TStrings* FFormattedLines;
	System::Classes::TStrings* FLines;
	Qrctrls::TQRLabelOnPrintEvent FOnPrint;
	bool FWordWrap;
	bool FShowOnDocs;
	bool UpdatingBounds;
	System::UnicodeString __fastcall GetCaption(void);
	virtual bool __fastcall GetCaptionBased(void);
	void __fastcall SetAutoStretch(bool Value);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetLines(System::Classes::TStrings* Value);
	void __fastcall SetWordWrap(bool Value);
	void __fastcall PaintToCanvas(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, bool CanExpand, int LineHeight);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall PrintToCanvas(Vcl::Graphics::TCanvas* aCanvas, System::Extended aLeft, System::Extended aTop, System::Extended aWidth, System::Extended aHeight, System::Extended LineHeight, bool CanExpand);
	virtual void __fastcall FormatLines(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall ReadFontSize(System::Classes::TReader* Reader);
	virtual void __fastcall WriteFontSize(System::Classes::TWriter* Writer);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall UnPrepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall SetAlignment(System::Classes::TAlignment Value);
	__property Qrctrls::TQRLabelOnPrintEvent OnPrint = {read=FOnPrint, write=FOnPrint};
	
public:
	__fastcall virtual TQRCustomHTMLLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCustomHTMLLabel(void);
	DYNAMIC System::Classes::TAlignment __fastcall GetControlsAlignment(void);
	__property bool CaptionBased = {read=GetCaptionBased, nodefault};
	__property Alignment;
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, nodefault};
	__property bool AutoStretch = {read=FAutoStretch, write=SetAutoStretch, nodefault};
	__property System::UnicodeString Caption = {read=GetCaption, write=SetCaption, stored=true};
	__property Color = {default=-16777211};
	__property Font;
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property bool ShowOnDocs = {read=FShowOnDocs, write=FShowOnDocs, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRCustomHTMLLabel(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRHTMLLabel : public TQRCustomHTMLLabel
{
	typedef TQRCustomHTMLLabel inherited;
	
protected:
	virtual Quickrpt::TQRPrintableEditorClass __fastcall GetEditorClass(void);
	virtual void __fastcall PrintToCanvas(Vcl::Graphics::TCanvas* aCanvas, System::Extended aLeft, System::Extended aTop, System::Extended aWidth, System::Extended aHeight, System::Extended LineHeight, bool CanExpand);
	
public:
	System::Uitypes::TColor FFlashColor;
	System::UnicodeString FLinkText;
	TLinkDef FLinkType;
	
__published:
	__property System::Uitypes::TColor Flashcolor = {read=FFlashColor, write=FFlashColor, nodefault};
	__property System::UnicodeString LinkText = {read=FLinkText, write=FLinkText};
	__property TLinkDef LinkType = {read=FLinkType, write=FLinkType, nodefault};
	__property Alignment;
	__property AlignToBand;
	__property AutoSize;
	__property AutoStretch;
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property Caption;
	__property Color = {default=-16777211};
	__property Font;
	__property OnPrint;
	__property ParentFont = {default=1};
	__property Transparent;
	__property WordWrap;
	__property ShowOnDocs;
public:
	/* TQRCustomHTMLLabel.Create */ inline __fastcall virtual TQRHTMLLabel(System::Classes::TComponent* AOwner) : TQRCustomHTMLLabel(AOwner) { }
	/* TQRCustomHTMLLabel.Destroy */ inline __fastcall virtual ~TQRHTMLLabel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRHTMLLabel(HWND ParentWindow) : TQRCustomHTMLLabel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRHRule : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Vcl::Graphics::TBrush* FBrush;
	Vcl::Graphics::TPen* FPen;
	int FVertAdjust;
	void __fastcall SetBrush(Vcl::Graphics::TBrush* Value);
	void __fastcall SetPen(Vcl::Graphics::TPen* Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	void __fastcall StyleChanged(System::TObject* sender);
	
public:
	__fastcall virtual TQRHRule(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRHRule(void);
	
__published:
	__property int VertAdjust = {read=FVertAdjust, write=FVertAdjust, nodefault};
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Height = {default=10};
	__property Vcl::Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Width = {default=100};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRHRule(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPDFShape : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Vcl::Graphics::TBrush* FBrush;
	Vcl::Graphics::TPen* FPen;
	int FVertAdjust;
	Qrctrls::TQRShapeType FShapeType;
	void __fastcall SetBrush(Vcl::Graphics::TBrush* Value);
	void __fastcall SetPen(Vcl::Graphics::TPen* Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	void __fastcall StyleChanged(System::TObject* sender);
	
public:
	__fastcall virtual TQRPDFShape(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPDFShape(void);
	
__published:
	__property int VertAdjust = {read=FVertAdjust, write=FVertAdjust, nodefault};
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Qrctrls::TQRShapeType ShapeType = {read=FShapeType, write=FShapeType, nodefault};
	__property Height = {default=10};
	__property Vcl::Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Width = {default=100};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPDFShape(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRGrImage : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Vcl::Graphics::TPicture* FPicture;
	bool FAutoSize;
	bool FStretch;
	bool FCenter;
	bool FClipImage;
	TFitMode FFitMode;
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetCenter(bool Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* Value);
	void __fastcall SetStretch(bool Value);
	
protected:
	virtual void __fastcall SetAutoSize(bool Value);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	__fastcall virtual TQRGrImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRGrImage(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	
__published:
	__property bool ClipImage = {read=FClipImage, write=FClipImage, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool Center = {read=FCenter, write=SetCenter, default=0};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Stretch = {read=FStretch, write=SetStretch, default=0};
	__property TFitMode FitMode = {read=FFitMode, write=FFitMode, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRGrImage(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRGrDBImage : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Data::Db::TField* FField;
	Data::Db::TDataSet* FDataSet;
	System::UnicodeString FDataField;
	Vcl::Graphics::TPicture* FPicture;
	bool FStretch;
	bool FCenter;
	bool FPictureLoaded;
	bool FClipImage;
	bool FKeepWidth;
	bool FKeepHeight;
	TFitMode FFitMode;
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
	__fastcall virtual TQRGrDBImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRGrDBImage(void);
	void __fastcall LoadPicture(void);
	__property Data::Db::TField* Field = {read=FField};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	
__published:
	__property bool Center = {read=FCenter, write=SetCenter, default=1};
	__property System::UnicodeString DataField = {read=FDataField, write=SetDataField};
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property bool Stretch = {read=FStretch, write=SetStretch, default=0};
	__property bool ClipImage = {read=FClipImage, write=FClipImage, default=0};
	__property TFitMode FitMode = {read=FFitMode, write=FFitMode, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRGrDBImage(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Grimgctrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GRIMGCTRL)
using namespace Grimgctrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GrimgctrlHPP
