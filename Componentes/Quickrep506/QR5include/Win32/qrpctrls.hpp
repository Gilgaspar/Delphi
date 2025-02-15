// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'qrpctrls.pas' rev: 30.00 (Windows)

#ifndef QrpctrlsHPP
#define QrpctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.DBGrids.hpp>
#include <System.Classes.hpp>
#include <QuickRpt.hpp>
#include <QRCtrls.hpp>
#include <csProp.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <QRExpr.hpp>
#include <grimgctrl.hpp>
#include <System.UITypes.hpp>
#include <qrpexpr.hpp>
#include <qrpBaseCtrls.hpp>
#include <QRPrntr.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrpctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRPFrame;
class DELPHICLASS TQRPDBImage;
class DELPHICLASS TQRPLabel;
class DELPHICLASS TQRPDBText;
class DELPHICLASS TQRPExpr;
class DELPHICLASS TQRPMemo;
class DELPHICLASS TQRPRichtext;
class DELPHICLASS TQRPShape;
class DELPHICLASS TQRPCheckBox;
class DELPHICLASS TQRPExprCheckbox;
class DELPHICLASS TQRPGridCell;
class DELPHICLASS TQRPGrid;
class DELPHICLASS TQRPBand;
class DELPHICLASS TQRPChildBand;
class DELPHICLASS TQRAbstractGridReport;
class DELPHICLASS TQRGridReport;
class DELPHICLASS TQRStringgridReport;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TCPEventHandler)(System::TObject* sender, int Xp, int Yp, const System::Types::TRect &cellRect, Vcl::Graphics::TCanvas* pCanvas);

typedef void __fastcall (__closure *TDLEventHandler)(System::TObject* sender, double X1, double Y1, double X2, double Y2, Vcl::Graphics::TCanvas* pCanvas, Vcl::Graphics::TBitmap* &lbmp, bool &Done, bool &useBmp);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRPFrame : public Quickrpt::TQRFrame
{
	typedef Quickrpt::TQRFrame inherited;
	
public:
	/* TQRFrame.Create */ inline __fastcall TQRPFrame(void) : Quickrpt::TQRFrame() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRPFrame(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRPDBImage : public Qrctrls::TQRDBImage
{
	typedef Qrctrls::TQRDBImage inherited;
	
private:
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
protected:
	virtual void __fastcall Print(int OfsX, int OfsY);
	
public:
	HIDESBASE void __fastcall LoadPicture(void);
	
__published:
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRDBImage.Create */ inline __fastcall virtual TQRPDBImage(System::Classes::TComponent* AOwner) : Qrctrls::TQRDBImage(AOwner) { }
	/* TQRDBImage.Destroy */ inline __fastcall virtual ~TQRPDBImage(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPDBImage(HWND ParentWindow) : Qrctrls::TQRDBImage(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPLabel : public Qrctrls::TQRLabel
{
	typedef Qrctrls::TQRLabel inherited;
	
private:
	System::Word FDegree;
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
protected:
	void __fastcall SetDegree(System::Word Value);
	virtual void __fastcall FormatLines(void);
	
public:
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall Paint(void);
	
__published:
	__property System::Word Degree = {read=FDegree, write=SetDegree, nodefault};
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRCustomLabel.Create */ inline __fastcall virtual TQRPLabel(System::Classes::TComponent* AOwner) : Qrctrls::TQRLabel(AOwner) { }
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRPLabel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPLabel(HWND ParentWindow) : Qrctrls::TQRLabel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPDBText : public Qrctrls::TQRDBText
{
	typedef Qrctrls::TQRDBText inherited;
	
private:
	Qrctrls::TQRLabelOnPrintEvent FOldOnPrint;
	bool FSuppressRepeatedValues;
	bool FReprintOnNewPage;
	bool FReprintOnNewGroup;
	bool FBlankIfZero;
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
protected:
	void __fastcall DBTextOnPrint(System::TObject* sender, System::UnicodeString &Value);
	
public:
	System::UnicodeString LastValue;
	int LastPage;
	virtual void __fastcall Print(int OfsX, int OfsY);
	__property Qrctrls::TQRLabelOnPrintEvent OldOnPrint = {read=FOldOnPrint, write=FOldOnPrint};
	
__published:
	__property bool SuppressRepeatedValues = {read=FSuppressRepeatedValues, write=FSuppressRepeatedValues, nodefault};
	__property bool ReprintOnNewPage = {read=FReprintOnNewPage, write=FReprintOnNewPage, nodefault};
	__property bool ReprintOnNewGroup = {read=FReprintOnNewGroup, write=FReprintOnNewGroup, nodefault};
	__property bool BlankIfZero = {read=FBlankIfZero, write=FBlankIfZero, nodefault};
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRDBText.Create */ inline __fastcall virtual TQRPDBText(System::Classes::TComponent* AOwner) : Qrctrls::TQRDBText(AOwner) { }
	
public:
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRPDBText(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPDBText(HWND ParentWindow) : Qrctrls::TQRDBText(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPExpr : public Qrctrls::TQRExpr
{
	typedef Qrctrls::TQRExpr inherited;
	
private:
	System::Word FDegree;
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
protected:
	void __fastcall SetDegree(System::Word Value);
	
public:
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall Paint(void);
	
__published:
	__property System::Word Degree = {read=FDegree, write=SetDegree, nodefault};
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRExpr.Create */ inline __fastcall virtual TQRPExpr(System::Classes::TComponent* AOwner) : Qrctrls::TQRExpr(AOwner) { }
	/* TQRExpr.Destroy */ inline __fastcall virtual ~TQRPExpr(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPExpr(HWND ParentWindow) : Qrctrls::TQRExpr(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPMemo : public Qrctrls::TQRMemo
{
	typedef Qrctrls::TQRMemo inherited;
	
private:
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
public:
	virtual void __fastcall Print(int OfsX, int OfsY);
	
__published:
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRCustomLabel.Create */ inline __fastcall virtual TQRPMemo(System::Classes::TComponent* AOwner) : Qrctrls::TQRMemo(AOwner) { }
	/* TQRCustomLabel.Destroy */ inline __fastcall virtual ~TQRPMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPMemo(HWND ParentWindow) : Qrctrls::TQRMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPRichtext : public Qrctrls::TQRRichText
{
	typedef Qrctrls::TQRRichText inherited;
	
private:
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
public:
	virtual void __fastcall Print(int OfsX, int OfsY);
	
__published:
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRCustomRichText.Create */ inline __fastcall virtual TQRPRichtext(System::Classes::TComponent* AOwner) : Qrctrls::TQRRichText(AOwner) { }
	/* TQRCustomRichText.Destroy */ inline __fastcall virtual ~TQRPRichtext(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPRichtext(HWND ParentWindow) : Qrctrls::TQRRichText(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TQRPShapeType : unsigned char { qrpsRectangle, qrpsCircle, qrpsVertLine, qrpsHorLine, qrpsTopAndBottom, qrpsRightAndLeft, qrpsDownLine, qrpsUpLine, qrpsTriangle1, qrpsTriangle2, qrpsTriangle3, qrpsTriangle4 };

class PASCALIMPLEMENTATION TQRPShape : public Qrctrls::TQRShape
{
	typedef Qrctrls::TQRShape inherited;
	
private:
	TQRPShapeType FQRPShape;
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	
protected:
	void __fastcall SetQRPShape(TQRPShapeType Value);
	
public:
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall Paint(void);
	
__published:
	__property TQRPShapeType Shape = {read=FQRPShape, write=SetQRPShape, nodefault};
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TQRShape.Create */ inline __fastcall virtual TQRPShape(System::Classes::TComponent* AOwner) : Qrctrls::TQRShape(AOwner) { }
	/* TQRShape.Destroy */ inline __fastcall virtual ~TQRPShape(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPShape(HWND ParentWindow) : Qrctrls::TQRShape(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TQRPCheckmarkType : unsigned char { cmCross, cmHook, cmGlyph };

class PASCALIMPLEMENTATION TQRPCheckBox : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	Vcl::Graphics::TBrush* FBrush;
	Vcl::Graphics::TPen* FPen;
	bool FCtl3d;
	bool FChecked;
	System::Word FCheckmarkDistance;
	TQRPCheckmarkType FCheckmarkType;
	Vcl::Graphics::TPicture* FGlyphChecked;
	Vcl::Graphics::TPicture* FGlyphUnchecked;
	void __fastcall SetChecked(bool Value);
	void __fastcall SetBrush(Vcl::Graphics::TBrush* Value);
	void __fastcall SetPen(Vcl::Graphics::TPen* Value);
	HIDESBASE void __fastcall SetCtl3d(bool Value);
	void __fastcall SetCheckmarkDistance(System::Word Value);
	void __fastcall SetCheckmarkType(TQRPCheckmarkType Value);
	void __fastcall SetGlyphChecked(Vcl::Graphics::TPicture* Value);
	void __fastcall SetGlyphUnchecked(Vcl::Graphics::TPicture* Value);
	
protected:
	void __fastcall StyleChanged(System::TObject* sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TQRPCheckBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	__fastcall virtual ~TQRPCheckBox(void);
	
__published:
	__property Vcl::Graphics::TPicture* GlyphChecked = {read=FGlyphChecked, write=SetGlyphChecked};
	__property Vcl::Graphics::TPicture* GlyphUnchecked = {read=FGlyphUnchecked, write=SetGlyphUnchecked};
	__property TQRPCheckmarkType CheckmarkType = {read=FCheckmarkType, write=SetCheckmarkType, nodefault};
	__property System::Word CheckmarkDistance = {read=FCheckmarkDistance, write=SetCheckmarkDistance, nodefault};
	__property bool Checked = {read=FChecked, write=SetChecked, nodefault};
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Vcl::Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Height = {default=17};
	__property Width = {default=17};
	__property Transparent;
	__property bool Ctl3D = {read=FCtl3d, write=SetCtl3d, nodefault};
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPCheckBox(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPExprCheckbox : public TQRPCheckBox
{
	typedef TQRPCheckBox inherited;
	
private:
	System::UnicodeString FExpression;
	
public:
	__fastcall virtual TQRPExprCheckbox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Print(int OfsX, int OfsY);
	
__published:
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
public:
	/* TQRPCheckBox.Destroy */ inline __fastcall virtual ~TQRPExprCheckbox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPExprCheckbox(HWND ParentWindow) : TQRPCheckBox(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TVertAlignment : unsigned char { vaNone, vaTop, vaCenter, vaBottom };

enum DECLSPEC_DENUM THorizAlignment : unsigned char { haNone, haLeft, haCenter, haRight };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRPGridCell : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString Caption;
	Vcl::Graphics::TFont* Font;
	Vcl::Graphics::TBrush* Brush;
	bool ParentFont;
	TVertAlignment VertAlignment;
	THorizAlignment HorizAlignment;
	Vcl::Graphics::TPicture* Picture;
	int PicXoff;
	int PicYoff;
	Qrprntr::TExportType ExportType;
	Qrprntr::TXLNumFormat XLNumFormat;
	__fastcall TQRPGridCell(void);
	__fastcall virtual ~TQRPGridCell(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRPGrid : public Quickrpt::TQRPrintable
{
	typedef Quickrpt::TQRPrintable inherited;
	
private:
	bool FFixBottomPosition;
	bool FStretchHeightWithBand;
	THorizAlignment FCellHorizAlignment;
	TVertAlignment FCellVertAlignment;
	Vcl::Graphics::TBrush* FBrush;
	Vcl::Graphics::TPen* FPen;
	System::Word FRows;
	System::Word FColumns;
	bool FDrawFirstRowLine;
	System::Word FFirstRowHeight;
	System::Word FFirstColumnWidth;
	bool FFirstColumnJoined;
	bool FFirstRowJoined;
	System::Classes::TStrings* FColumnSizes;
	System::Classes::TStrings* FRowSizes;
	System::Classes::TList* FCellColumns;
	TCPEventHandler FOnPaintCell;
	TDLEventHandler FOnDrawLine;
	TCPEventHandler FOnPrintImage;
	Vcl::Graphics::TBitmap* FLinebmp;
	int FXLColumn;
	void __fastcall SetBrush(Vcl::Graphics::TBrush* Value);
	void __fastcall SetPen(Vcl::Graphics::TPen* Value);
	void __fastcall SetRows(System::Word Value);
	void __fastcall SetColumns(System::Word Value);
	void __fastcall SetFirstRowColor(System::Uitypes::TColor Value);
	void __fastcall SetFirstCellColor(System::Uitypes::TColor Value);
	void __fastcall SetFirstColumnColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetFirstRowColor(void);
	System::Uitypes::TColor __fastcall GetFirstCellColor(void);
	System::Uitypes::TColor __fastcall GetFirstColumnColor(void);
	void __fastcall SetFirstColumnJoined(bool Value);
	void __fastcall SetFirstRowJoined(bool Value);
	void __fastcall SetDrawFirstRowLine(bool Value);
	void __fastcall SetRowSizes(System::Classes::TStrings* Value);
	void __fastcall SetColumnSizes(System::Classes::TStrings* Value);
	TQRPGridCell* __fastcall GetCells(int ACol, int ARow);
	void __fastcall SetCells(int ACol, int ARow, TQRPGridCell* const Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	void __fastcall StyleChanged(System::TObject* sender);
	
public:
	__fastcall virtual TQRPGrid(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPGrid(void);
	__property TQRPGridCell* Cells[int ACol][int ARow] = {read=GetCells, write=SetCells};
	
__published:
	__property bool FixBottomPosition = {read=FFixBottomPosition, write=FFixBottomPosition, nodefault};
	__property bool StretchHeightWithBand = {read=FStretchHeightWithBand, write=FStretchHeightWithBand, nodefault};
	__property THorizAlignment CellHorizAlignment = {read=FCellHorizAlignment, write=FCellHorizAlignment, nodefault};
	__property TVertAlignment CellVertAlignment = {read=FCellVertAlignment, write=FCellVertAlignment, nodefault};
	__property System::Word Columns = {read=FColumns, write=SetColumns, nodefault};
	__property System::Classes::TStrings* ColumnSizes = {read=FColumnSizes, write=SetColumnSizes};
	__property System::Word Rows = {read=FRows, write=SetRows, nodefault};
	__property System::Classes::TStrings* RowSizes = {read=FRowSizes, write=SetRowSizes};
	__property bool DrawFirstRowLine = {read=FDrawFirstRowLine, write=SetDrawFirstRowLine, nodefault};
	__property System::Uitypes::TColor FirstRowColor = {read=GetFirstRowColor, write=SetFirstRowColor, nodefault};
	__property System::Uitypes::TColor FirstColumnColor = {read=GetFirstColumnColor, write=SetFirstColumnColor, nodefault};
	__property System::Uitypes::TColor FirstCellColor = {read=GetFirstCellColor, write=SetFirstCellColor, nodefault};
	__property bool FirstColumnJoined = {read=FFirstColumnJoined, write=SetFirstColumnJoined, nodefault};
	__property bool FirstRowJoined = {read=FFirstRowJoined, write=SetFirstRowJoined, nodefault};
	__property Transparent;
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Vcl::Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Height = {default=65};
	__property Width = {default=65};
	__property TCPEventHandler OnPaintCell = {read=FOnPaintCell, write=FOnPaintCell};
	__property TDLEventHandler OnDrawLine = {read=FOnDrawLine, write=FOnDrawLine};
	__property TCPEventHandler OnPrintImage = {read=FOnPrintImage, write=FOnPrintImage};
	__property int XLColumn = {read=FXLColumn, write=FXLColumn, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPGrid(HWND ParentWindow) : Quickrpt::TQRPrintable(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPBand : public Quickrpt::TQRBand
{
	typedef Quickrpt::TQRBand inherited;
	
private:
	bool FNotOnFirstPage;
	bool FNotOnLastPage;
	System::UnicodeString FExpression;
	bool FAlwaysUseSpace;
	Quickrpt::TQRBandBeforePrintEvent FOldBeforePrint;
	bool InSetBounds;
	
protected:
	System::Classes::TList* DisabledControls;
	
public:
	__fastcall virtual TQRPBand(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPBand(void);
	void __fastcall BandBeforePrint(Quickrpt::TQRCustomBand* Sender, bool &PrintBand);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Quickrpt::TQRBandBeforePrintEvent BeforePrint = {read=FOldBeforePrint, write=FOldBeforePrint};
	__property bool AlwaysUseSpace = {read=FAlwaysUseSpace, write=FAlwaysUseSpace, nodefault};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property bool NotOnFirstPage = {read=FNotOnFirstPage, write=FNotOnFirstPage, nodefault};
	__property bool NotOnLastPage = {read=FNotOnLastPage, write=FNotOnLastPage, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPBand(HWND ParentWindow) : Quickrpt::TQRBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPChildBand : public Quickrpt::TQRChildBand
{
	typedef Quickrpt::TQRChildBand inherited;
	
private:
	bool FNotOnFirstPage;
	bool FNotOnLastPage;
	System::UnicodeString FExpression;
	int FPagePrints;
	Quickrpt::TQRBandBeforePrintEvent FOldBeforePrint;
	int LastPage;
	bool InSetBounds;
	
public:
	__fastcall virtual TQRPChildBand(System::Classes::TComponent* AOwner);
	virtual void __fastcall BandBeforePrint(Quickrpt::TQRCustomBand* Sender, bool &PrintBand);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Quickrpt::TQRBandBeforePrintEvent BeforePrint = {read=FOldBeforePrint, write=FOldBeforePrint};
	__property int PagePrints = {read=FPagePrints, write=FPagePrints, nodefault};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property bool NotOnFirstPage = {read=FNotOnFirstPage, write=FNotOnFirstPage, nodefault};
	__property bool NotOnLastPage = {read=FNotOnLastPage, write=FNotOnLastPage, nodefault};
public:
	/* TQRCustomBand.Destroy */ inline __fastcall virtual ~TQRPChildBand(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPChildBand(HWND ParentWindow) : Quickrpt::TQRChildBand(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TQRPAfterReportFormCreatedEvent)(Vcl::Forms::TForm* Form, Quickrpt::TQuickRep* QReport, bool DoCancel);

enum DECLSPEC_DENUM TReportStyle : unsigned char { rsList, rsTabular, rsForm, rsSingleForm };

class PASCALIMPLEMENTATION TQRAbstractGridReport : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	System::UnicodeString FReportTitle;
	bool FReportTitleDate;
	Quickrpt::TQuickRep* FQuickRep;
	bool FPrintGridLines;
	TQRPAfterReportFormCreatedEvent FAfterReportFormCreated;
	bool FSelectedRecordsOnly;
	virtual Quickrpt::TQRBand* __fastcall CreateBandClass(System::Classes::TComponent* AOwner);
	virtual Quickrpt::TQuickRep* __fastcall CreateReportClass(System::Classes::TComponent* AOwner);
	virtual Qrctrls::TQRSysData* __fastcall CreateSysDataClass(System::Classes::TComponent* AOwner);
	virtual Qrctrls::TQRLabel* __fastcall CreateLabelClass(System::Classes::TComponent* AOwner);
	virtual Qrctrls::TQRDBText* __fastcall CreateDBTextClass(System::Classes::TComponent* AOwner);
	virtual Qrctrls::TQRShape* __fastcall CreateShapeClass(System::Classes::TComponent* AOwner);
	virtual Qrctrls::TQRExpr* __fastcall CreateExprClass(System::Classes::TComponent* AOwner);
	virtual Quickrpt::TQRGroup* __fastcall CreateGroupClass(System::Classes::TComponent* AOwner);
	virtual Quickrpt::TQRSubDetail* __fastcall CreateSubdetailClass(System::Classes::TComponent* AOwner);
	Qrctrls::TQRSysData* __fastcall CreateSysdata(Vcl::Extctrls::TCustomPanel* ParentBand, int Left, int Top, Qrctrls::TQRSysDataType Datatype);
	virtual Qrctrls::TQRShape* __fastcall CreateShape(Vcl::Extctrls::TCustomPanel* ParentBand, Qrctrls::TQRShapeType ShapeType, int Left, int Top, int Width, int Height, System::Uitypes::TColor Color);
	virtual Qrctrls::TQRLabel* __fastcall CreateLabel(Vcl::Extctrls::TCustomPanel* ParentBand, int Left, int Top);
	virtual Qrctrls::TQRExpr* __fastcall CreateExpr(Vcl::Extctrls::TCustomPanel* ParentBand, int Left, int Top);
	virtual Qrctrls::TQRDBText* __fastcall CreateDBText(Vcl::Extctrls::TCustomPanel* ParentBand, int Left, int Top);
	virtual Quickrpt::TQRBand* __fastcall CreateBand(Quickrpt::TQuickRep* Quickrep, Qrprntr::TQRBandType BandType, int Height);
	virtual Quickrpt::TQRGroup* __fastcall CreateGroup(Quickrpt::TQuickRep* Quickrep, int Height);
	virtual Quickrpt::TQRSubDetail* __fastcall CreateSubdetail(Quickrpt::TQuickRep* Quickrep, int Height);
	virtual Quickrpt::TQuickRep* __fastcall CreateReport(System::Classes::TComponent* AParent);
	virtual void __fastcall _PreviewReport(Quickrpt::TQuickRep* DefaultReport, bool Modal);
	virtual void __fastcall CreateTitle(void);
	
public:
	__fastcall virtual TQRAbstractGridReport(System::Classes::TComponent* AOwner);
	virtual bool __fastcall CreateReportFromGrid(void);
	virtual void __fastcall PrintReport(Quickrpt::TQuickRep* DefaultReport);
	virtual void __fastcall PreviewReport(Quickrpt::TQuickRep* DefaultReport);
	
__published:
	__property System::UnicodeString ReportTitle = {read=FReportTitle, write=FReportTitle};
	__property bool ReportTitleDate = {read=FReportTitleDate, write=FReportTitleDate, nodefault};
	__property bool PrintGridLines = {read=FPrintGridLines, write=FPrintGridLines, nodefault};
	__property Quickrpt::TQuickRep* QuickRep = {read=FQuickRep, write=FQuickRep};
	__property TQRPAfterReportFormCreatedEvent AfterReportFormCreated = {read=FAfterReportFormCreated, write=FAfterReportFormCreated};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRAbstractGridReport(void) { }
	
};


class PASCALIMPLEMENTATION TQRGridReport : public TQRAbstractGridReport
{
	typedef TQRAbstractGridReport inherited;
	
private:
	Vcl::Dbgrids::TDBGrid* FDBGrid;
	bool FUseExprForDatafields;
	bool FAutoStretchMemos;
	bool FSpanPagesHorizontally;
	
protected:
	virtual void __fastcall DetailBandBeforePrint(Quickrpt::TQRCustomBand* Sender, bool &PrintBand);
	
public:
	virtual bool __fastcall CreateReportFromGrid(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
__published:
	__property bool AutoStretchMemos = {read=FAutoStretchMemos, write=FAutoStretchMemos, nodefault};
	__property bool UseExprForDatafields = {read=FUseExprForDatafields, write=FUseExprForDatafields, nodefault};
	__property Vcl::Dbgrids::TDBGrid* DBGrid = {read=FDBGrid, write=FDBGrid};
	__property bool SelectedRecordsOnly = {read=FSelectedRecordsOnly, write=FSelectedRecordsOnly, nodefault};
	__property bool SpanPagesHorizontally = {read=FSpanPagesHorizontally, write=FSpanPagesHorizontally, nodefault};
public:
	/* TQRAbstractGridReport.Create */ inline __fastcall virtual TQRGridReport(System::Classes::TComponent* AOwner) : TQRAbstractGridReport(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRGridReport(void) { }
	
};


class PASCALIMPLEMENTATION TQRStringgridReport : public TQRAbstractGridReport
{
	typedef TQRAbstractGridReport inherited;
	
private:
	Vcl::Grids::TStringGrid* FStringGrid;
	
protected:
	virtual void __fastcall DetailBandBeforePrint(Quickrpt::TQRCustomBand* Sender, bool &PrintBand);
	virtual void __fastcall NeedData(System::TObject* Sender, bool &MoreData);
	
public:
	int CurrentRow;
	virtual bool __fastcall CreateReportFromGrid(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
__published:
	__property Vcl::Grids::TStringGrid* StringGrid = {read=FStringGrid, write=FStringGrid};
public:
	/* TQRAbstractGridReport.Create */ inline __fastcall virtual TQRStringgridReport(System::Classes::TComponent* AOwner) : TQRAbstractGridReport(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRStringgridReport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 CellBorderX = System::Int8(0x5);
static const System::Int8 CellBorderY = System::Int8(0x3);
extern DELPHI_PACKAGE System::UnicodeString __fastcall FindUniqueComponentName(Vcl::Forms::TForm* Owner, System::UnicodeString Name, bool UseDefault);
}	/* namespace Qrpctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPCTRLS)
using namespace Qrpctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrpctrlsHPP
