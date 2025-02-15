// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRCtrls.pas' rev: 30.00 (Windows)

#ifndef QrctrlsHPP
#define QrctrlsHPP

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
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRCustomLabel;
class DELPHICLASS TQRLabel;
class DELPHICLASS TQRMemo;
class DELPHICLASS TQRDBText;
class DELPHICLASS TQRExpr;
class DELPHICLASS TQRSysData;
class DELPHICLASS TQRShape;
class DELPHICLASS TQRImage;
class DELPHICLASS TQRDBImage;
class DELPHICLASS TQRRichEdit;
class DELPHICLASS TQRCustomRichText;
class DELPHICLASS TQRRichText;
class DELPHICLASS TQRDBRichText;
class DELPHICLASS TQRMerger;
class DELPHICLASS TQRExprMemo;
class DELPHICLASS TQRDBCalc;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TWrapStyle : unsigned char { BreakOnSpaces, BreakAnywhere };

typedef void __fastcall (__closure *TQRLabelOnPrintEvent)(System::TObject* sender, System::UnicodeString &Value);

class PASCALIMPLEMENTATION TQRCustomLabel : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	bool FCaptionBased;
	bool DoneFormat;
	bool FAutoSize;
	bool FAutoStretch;
	System::UnicodeString FCaption;
	System::WideString FWidecaption;
	TWrapStyle FWrapStyle;
	int FCurrentLine;
	System::UnicodeString FPrintCaption;
	System::WideString FWideprintcaption;
	int FFontSize;
	System::Classes::TStrings* FFormattedLines;
	System::Classes::TStrings* FLines;
	TQRLabelOnPrintEvent FOnPrint;
	bool FWordWrap;
	bool FFullJustify;
	int FMaxBreakChars;
	bool UpdatingBounds;
	Vcl::Stdctrls::TTextLayout FVerticalAlignment;
	System::UnicodeString __fastcall GetCaption(void);
	System::WideString __fastcall GetWidecaption(void);
	virtual bool __fastcall GetCaptionBased(void);
	void __fastcall SetAutoStretch(bool Value);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetWidecaption(System::WideString Value);
	void __fastcall SetLines(System::Classes::TStrings* Value);
	void __fastcall SetWordWrap(bool Value);
	void __fastcall PaintToCanvas(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, bool CanExpand, int LineHeight);
	void __fastcall PrintToCanvas(Vcl::Graphics::TCanvas* aCanvas, System::Extended aLeft, System::Extended aTop, System::Extended aWidth, System::Extended aHeight, System::Extended LineHeight, bool CanExpand);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
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
	__property TQRLabelOnPrintEvent OnPrint = {read=FOnPrint, write=FOnPrint};
	
public:
	__fastcall virtual TQRCustomLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCustomLabel(void);
	DYNAMIC System::Classes::TAlignment __fastcall GetControlsAlignment(void);
	__property bool CaptionBased = {read=GetCaptionBased, nodefault};
	__property Alignment;
	__property Vcl::Stdctrls::TTextLayout VerticalAlignment = {read=FVerticalAlignment, write=FVerticalAlignment, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=1};
	__property bool AutoStretch = {read=FAutoStretch, write=SetAutoStretch, default=0};
	__property System::UnicodeString Caption = {read=GetCaption, write=SetCaption, stored=true};
	__property TWrapStyle WrapStyle = {read=FWrapStyle, write=FWrapStyle, stored=true, nodefault};
	__property System::WideString Widecaption = {read=GetWidecaption, write=SetWidecaption, stored=true};
	__property Color = {default=0};
	__property Font;
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property ExportAs;
	__property bool FullJustify = {read=FFullJustify, write=FFullJustify, nodefault};
	__property int MaxBreakChars = {read=FMaxBreakChars, write=FMaxBreakChars, default=5};
	__property XLColumn;
	__property XLNumFormat;
	__property ParagraphChar = {default=0};
	__property ParagraphIndent = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRCustomLabel(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRLabel : public TQRCustomLabel
{
	typedef TQRCustomLabel inherited;
	
protected:
	virtual Quickrpt::TQRPrintableEditorClass __fastcall GetEditorClass(void);
	
__published:
	__property Alignment;
	__property AlignToBand;
	__property AutoSize = {default=1};
	__property AutoStretch = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property Caption;
	__property Widecaption = {default=0};
	__property Color = {default=0};
	__property Font;
	__property OnPrint;
	__property ParentFont = {default=1};
	__property Transparent;
	__property WordWrap = {default=1};
	__property ExportAs;
	__property WrapStyle;
	__property XLColumn;
	__property XLNumFormat;
	__property VerticalAlignment;
public:
	/* TQRCustomLabel.Create */ inline __fastcall virtual TQRLabel(System::Classes::TComponent* AOwner) : TQRCustomLabel(AOwner) { }
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRLabel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRLabel(HWND ParentWindow) : TQRCustomLabel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRMemo : public TQRCustomLabel
{
	typedef TQRCustomLabel inherited;
	
protected:
	virtual bool __fastcall GetCaptionBased(void);
	
public:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	
__published:
	__property Alignment;
	__property AlignToBand;
	__property AutoSize = {default=1};
	__property AutoStretch = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property Color = {default=0};
	__property Font;
	__property Lines;
	__property ParentFont = {default=1};
	__property Transparent;
	__property WordWrap = {default=1};
	__property OnPrint;
	__property FullJustify;
	__property MaxBreakChars = {default=5};
	__property XLColumn;
	__property XLNumFormat;
	__property ParagraphChar = {default=0};
	__property ParagraphIndent = {default=0};
public:
	/* TQRCustomLabel.Create */ inline __fastcall virtual TQRMemo(System::Classes::TComponent* AOwner) : TQRCustomLabel(AOwner) { }
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRMemo(HWND ParentWindow) : TQRCustomLabel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRDBText : public TQRCustomLabel
{
	typedef TQRCustomLabel inherited;
	
private:
	Vcl::Stdctrls::TEdit* ComboBox;
	Data::Db::TField* Field;
	int FieldNo;
	bool FieldOK;
	System::UnicodeString DataSourceName;
	Data::Db::TDataSet* FDataSet;
	System::UnicodeString FDataField;
	System::UnicodeString FMask;
	bool IsMemo;
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	void __fastcall SetDataField(System::UnicodeString Value);
	void __fastcall SetMask(System::UnicodeString Value);
	
protected:
	virtual bool __fastcall GetCaptionBased(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall UnPrepare(void);
	
public:
	__fastcall virtual TQRDBText(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	virtual void __fastcall GetFieldString(System::UnicodeString &DataStr);
	
__published:
	__property Alignment;
	__property AlignToBand;
	__property AutoSize = {default=1};
	__property AutoStretch = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property Color = {default=0};
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataField = {read=FDataField, write=SetDataField};
	__property Font;
	__property System::UnicodeString Mask = {read=FMask, write=SetMask};
	__property OnPrint;
	__property ParentFont = {default=1};
	__property Transparent;
	__property WordWrap = {default=1};
	__property ExportAs;
	__property WrapStyle;
	__property FullJustify;
	__property MaxBreakChars = {default=5};
	__property XLColumn;
	__property XLNumFormat;
public:
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRDBText(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDBText(HWND ParentWindow) : TQRCustomLabel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRExpr : public TQRCustomLabel
{
	typedef TQRCustomLabel inherited;
	
private:
	Qrexpr::TQREvaluator* Evaluator;
	System::UnicodeString FExpression;
	System::UnicodeString FMask;
	System::Classes::TComponent* FMaster;
	bool FResetAfterPrint;
	Qrexpr::TQREvResult __fastcall GetValue(void);
	void __fastcall SetExpression(System::UnicodeString Value);
	void __fastcall SetMask(System::UnicodeString Value);
	
protected:
	virtual void __fastcall Prepare(void);
	virtual void __fastcall UnPrepare(void);
	virtual void __fastcall QRNotification(System::TObject* Sender, Quickrpt::TQRNotifyOperation Operation);
	virtual void __fastcall Print(int OfsX, int OfsY);
	void __fastcall SetMaster(System::Classes::TComponent* AComponent);
	virtual Quickrpt::TQRPrintableEditorClass __fastcall GetEditorClass(void);
	
public:
	__fastcall virtual TQRExpr(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRExpr(void);
	void __fastcall Reset(void);
	__property Qrexpr::TQREvResult Value = {read=GetValue};
	
__published:
	__property Alignment;
	__property AlignToBand;
	__property AutoSize = {default=1};
	__property AutoStretch = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property Font;
	__property Color = {default=0};
	__property System::Classes::TComponent* Master = {read=FMaster, write=SetMaster};
	__property OnPrint;
	__property ParentFont = {default=1};
	__property bool ResetAfterPrint = {read=FResetAfterPrint, write=FResetAfterPrint, nodefault};
	__property Transparent;
	__property WordWrap = {default=1};
	__property System::UnicodeString Expression = {read=FExpression, write=SetExpression};
	__property System::UnicodeString Mask = {read=FMask, write=SetMask};
	__property ExportAs;
	__property WrapStyle;
	__property XLColumn;
	__property XLNumFormat;
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRExpr(HWND ParentWindow) : TQRCustomLabel(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TQRSysDataType : unsigned char { qrsTime, qrsDate, qrsDateTime, qrsPageNumber, qrsReportTitle, qrsDetailCount, qrsDetailNo };

class PASCALIMPLEMENTATION TQRSysData : public TQRCustomLabel
{
	typedef TQRCustomLabel inherited;
	
private:
	TQRSysDataType FData;
	System::UnicodeString FText;
	void __fastcall SetData(TQRSysDataType Value);
	HIDESBASE void __fastcall SetText(System::UnicodeString Value);
	void __fastcall CreateCaption(void);
	
protected:
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	__fastcall virtual TQRSysData(System::Classes::TComponent* AOwner);
	
__published:
	__property Alignment;
	__property AlignToBand;
	__property AutoSize = {default=1};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property Color = {default=0};
	__property TQRSysDataType Data = {read=FData, write=SetData, nodefault};
	__property Font;
	__property OnPrint;
	__property ParentFont = {default=1};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property Transparent;
	__property ExportAs;
	__property XLColumn;
	__property XLNumFormat;
public:
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRSysData(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRSysData(HWND ParentWindow) : TQRCustomLabel(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TQRShapeType : unsigned char { qrsRectangle, qrsCircle, qrsVertLine, qrsHorLine, qrsTopAndBottom, qrsRightAndLeft, qrsRoundRect, qrsLeftDiagonal, qrsRightDiagonal };

class PASCALIMPLEMENTATION TQRShape : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	TQRShapeType FShape;
	Vcl::Graphics::TBrush* FBrush;
	Vcl::Graphics::TPen* FPen;
	float FRoundFactor;
	int FVertAdjust;
	void __fastcall SetBrush(Vcl::Graphics::TBrush* Value);
	void __fastcall SetPen(Vcl::Graphics::TPen* Value);
	void __fastcall SetShape(TQRShapeType Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	void __fastcall StyleChanged(System::TObject* sender);
	void __fastcall SetRoundFactor(float value);
	
public:
	__fastcall virtual TQRShape(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRShape(void);
	
__published:
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Height = {default=65};
	__property Vcl::Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property TQRShapeType Shape = {read=FShape, write=SetShape, nodefault};
	__property Width = {default=65};
	__property float RoundFactor = {read=FRoundFactor, write=SetRoundFactor};
	__property int VertAdjust = {read=FVertAdjust, write=FVertAdjust, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRShape(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRImage : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	Vcl::Graphics::TPicture* FPicture;
	bool FAutoSize;
	bool FStretch;
	bool FCenter;
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
	__fastcall virtual TQRImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRImage(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool Center = {read=FCenter, write=SetCenter, default=0};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Stretch = {read=FStretch, write=SetStretch, default=0};
	__property Visible = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRImage(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRDBImage : public Quickrpt::TQRPrintable
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
	__fastcall virtual TQRDBImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRDBImage(void);
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDBImage(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRRichEdit : public Vcl::Comctrls::TCustomRichEdit
{
	typedef Vcl::Comctrls::TCustomRichEdit inherited;
	
__published:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &params);
	virtual void __fastcall CreateWnd(void);
	
public:
	__property BorderStyle = {default=1};
public:
	/* TCustomRichEdit.Create */ inline __fastcall virtual TQRRichEdit(System::Classes::TComponent* AOwner) : Vcl::Comctrls::TCustomRichEdit(AOwner) { }
	/* TCustomRichEdit.Destroy */ inline __fastcall virtual ~TQRRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRRichEdit(HWND ParentWindow) : Vcl::Comctrls::TCustomRichEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRCustomRichText : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	int LastChar;
	bool FAutoStretch;
	Vcl::Comctrls::TRichEdit* FParentRichEdit;
	TQRRichEdit* FRichEdit;
	bool FHiresExport;
	System::Classes::TAlignment __fastcall GetAlignment(void);
	System::Uitypes::TColor __fastcall GetColor(void);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	System::Classes::TStrings* __fastcall GetLines(void);
	HIDESBASE void __fastcall SetColor(System::Uitypes::TColor Value);
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetLines(System::Classes::TStrings* Value);
	void __fastcall SetParentRichEdit(Vcl::Comctrls::TRichEdit* Value);
	void __fastcall SetRTFTransparent(bool value);
	bool __fastcall getRTFTransparent(void);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall SetAlignment(System::Classes::TAlignment Value);
	__property System::Classes::TStrings* Lines = {read=GetLines, write=SetLines};
	__property Vcl::Comctrls::TRichEdit* ParentRichEdit = {read=FParentRichEdit, write=SetParentRichEdit};
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	__fastcall virtual TQRCustomRichText(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCustomRichText(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC System::Classes::TAlignment __fastcall GetControlsAlignment(void);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	
__published:
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, nodefault};
	__property bool AutoStretch = {read=FAutoStretch, write=FAutoStretch, nodefault};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=0};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property bool HiresExport = {read=FHiresExport, write=FHiresExport, nodefault};
	__property XLColumn;
	__property bool Transparent = {read=getRTFTransparent, write=SetRTFTransparent, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRCustomRichText(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRRichText : public TQRCustomRichText
{
	typedef TQRCustomRichText inherited;
	
__published:
	__property Lines;
	__property ParentRichEdit;
	__property HiresExport;
	__property Transparent;
public:
	/* TQRCustomRichText.Create */ inline __fastcall virtual TQRRichText(System::Classes::TComponent* AOwner) : TQRCustomRichText(AOwner) { }
	/* TQRCustomRichText.Destroy */ inline __fastcall virtual ~TQRRichText(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRRichText(HWND ParentWindow) : TQRCustomRichText(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRDBRichText : public TQRCustomRichText
{
	typedef TQRCustomRichText inherited;
	
private:
	Data::Db::TField* Field;
	System::UnicodeString FDataField;
	Data::Db::TDataSet* FDataSet;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall UnPrepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
__published:
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	virtual void __fastcall GetFieldString(System::UnicodeString &DataStr);
	__property System::UnicodeString DataField = {read=FDataField, write=FDataField};
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property HiresExport;
	__property XLColumn;
	__property Transparent;
public:
	/* TQRCustomRichText.Create */ inline __fastcall virtual TQRDBRichText(System::Classes::TComponent* AOwner) : TQRCustomRichText(AOwner) { }
	/* TQRCustomRichText.Destroy */ inline __fastcall virtual ~TQRDBRichText(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDBRichText(HWND ParentWindow) : TQRCustomRichText(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRMerger : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStrings* FOrgLines;
	System::Classes::TStrings* FStrippedLines;
	System::Classes::TStrings* FMergedLines;
	bool FMerged;
	bool FPrepared;
	System::Classes::TList* Expressions;
	System::Classes::TList* FDataSets;
	
protected:
	System::Classes::TStrings* __fastcall GetOrgLines(void);
	System::Classes::TStrings* __fastcall GetMergedLines(void);
	void __fastcall SetOrgLines(System::Classes::TStrings* Value);
	
public:
	__fastcall TQRMerger(void);
	__fastcall virtual ~TQRMerger(void);
	void __fastcall Prepare(void);
	void __fastcall Merge(void);
	void __fastcall UnPrepare(void);
	__property System::Classes::TStrings* Lines = {read=GetOrgLines, write=SetOrgLines};
	__property System::Classes::TStrings* MergedLines = {read=GetMergedLines};
	__property bool Merged = {read=FMerged, nodefault};
	__property bool Prepared = {read=FPrepared, nodefault};
	__property System::Classes::TList* DataSets = {read=FDataSets, write=FDataSets};
};


class PASCALIMPLEMENTATION TQRExprMemo : public TQRCustomLabel
{
	typedef TQRCustomLabel inherited;
	
private:
	TQRMerger* Merger;
	bool FRemoveBlankLines;
	
protected:
	virtual bool __fastcall GetCaptionBased(void);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall UnPrepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TQRExprMemo(System::Classes::TComponent* AOwner);
	
__published:
	__property bool RemoveBlankLines = {read=FRemoveBlankLines, write=FRemoveBlankLines, nodefault};
	__property Alignment;
	__property AlignToBand;
	__property AutoSize = {default=1};
	__property AutoStretch = {default=0};
	__property Color = {default=0};
	__property Font;
	__property Lines;
	__property ParentFont = {default=1};
	__property Transparent;
	__property WordWrap = {default=1};
	__property XLColumn;
	__property XLNumFormat;
public:
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRExprMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRExprMemo(HWND ParentWindow) : TQRCustomLabel(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TQRCalcOperation : unsigned char { qrcSum, qrcCount, qrcMax, qrcMin, qrcAverage };

class PASCALIMPLEMENTATION TQRDBCalc : public TQRExpr
{
	typedef TQRExpr inherited;
	
private:
	System::UnicodeString FDataField;
	Data::Db::TDataSource* FDataSource;
	TQRCalcOperation FOperation;
	Quickrpt::TQRBand* FResetBand;
	
protected:
	System::UnicodeString __fastcall GetPrintMask(void);
	void __fastcall SetDataField(System::UnicodeString Value);
	void __fastcall SetOperation(TQRCalcOperation Value);
	void __fastcall SetPrintMask(System::UnicodeString Value);
	
__published:
	__property System::UnicodeString DataField = {read=FDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=FDataSource, write=FDataSource};
	__property OnPrint;
	__property TQRCalcOperation Operation = {read=FOperation, write=SetOperation, nodefault};
	__property ParentFont = {default=1};
	__property System::UnicodeString PrintMask = {read=GetPrintMask, write=SetPrintMask};
	__property Quickrpt::TQRBand* ResetBand = {read=FResetBand, write=FResetBand};
public:
	/* TQRExpr.Create */ inline __fastcall virtual TQRDBCalc(System::Classes::TComponent* AOwner) : TQRExpr(AOwner) { }
	/* TQRExpr.Destroy */ inline __fastcall virtual ~TQRDBCalc(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRDBCalc(HWND ParentWindow) : TQRExpr(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Graphics::TMetafileCanvas* metacanvas;
extern DELPHI_PACKAGE int LogX;
extern DELPHI_PACKAGE int LogY;
extern DELPHI_PACKAGE int ExportingRecordnumber;
extern DELPHI_PACKAGE System::UnicodeString ExportingControlName;
extern DELPHI_PACKAGE bool globalTransparentRTF;
}	/* namespace Qrctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRCTRLS)
using namespace Qrctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrctrlsHPP
