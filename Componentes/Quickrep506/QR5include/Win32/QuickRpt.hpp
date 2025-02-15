// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QuickRpt.pas' rev: 30.00 (Windows)

#ifndef QuickrptHPP
#define QuickrptHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
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
#include <QRPrntr.hpp>
#include <qr5const.hpp>
#include <QRPrgres.hpp>
#include <QRExpr.hpp>
#include <QRExpBld.hpp>
#include <Vcl.OleCtnrs.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Quickrpt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRPreviewController;
class DELPHICLASS TQRCustomController;
class DELPHICLASS TQRController;
class DELPHICLASS TQRFrame;
class DELPHICLASS TQRUnitBase;
class DELPHICLASS TQRBandSize;
class DELPHICLASS TQRPage;
class DELPHICLASS TQRBasePanel;
class DELPHICLASS TQRCustomBand;
class DELPHICLASS TQRBand;
class DELPHICLASS TQRWildBand;
class DELPHICLASS TQRChildBand;
class DELPHICLASS TQRControllerBand;
class DELPHICLASS TQRSubDetailGroupBands;
class DELPHICLASS TQRSubDetail;
class DELPHICLASS TQRLoopController;
class DELPHICLASS TQRLoopBand;
class DELPHICLASS TQRStringsController;
class DELPHICLASS TQRStringsBand;
class DELPHICLASS TQuickRepBands;
class DELPHICLASS TQuickRepPrinterSettings;
class DELPHICLASS TQRCompositePrinterSettings;
class DELPHICLASS TQRCreateReportThread;
class DELPHICLASS TCustomQuickRep;
class DELPHICLASS TQuickRep;
class DELPHICLASS TQuickAbstractRep;
class DELPHICLASS TQRLabelSetup;
class DELPHICLASS TQuickLabelReport;
class DELPHICLASS TQRGroup;
class DELPHICLASS TQRPrintableSize;
class DELPHICLASS TQRPrintableEditor;
class DELPHICLASS TQRPrintable;
class DELPHICLASS TQRCompositeWinControl;
class DELPHICLASS TQRCompositeReport;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TQRNewComponentClass;

typedef void __fastcall (__closure *TQROnNeedDataEvent)(System::TObject* Sender, bool &MoreData);

typedef void __fastcall (__closure *TQRPrinterEvent)(System::TObject* Sender, bool &Cancel, void * DevMode);

enum DECLSPEC_DENUM TQRNotifyOperation : unsigned char { qrMasterDataAdvance, qrBandPrinted, qrBandSizeChange };

typedef void __fastcall (__closure *TQRNotifyOperationEvent)(System::TObject* Sender, TQRNotifyOperation Operation);

enum DECLSPEC_DENUM TCBPrintOrder : unsigned char { cboBeforeParent, cboAfterParent, cboBeforeAndAfter };

enum DECLSPEC_DENUM TPrevEventType : unsigned char { etPrintButton, etSaveButton, etControlClick, etLoadButton, etPrintSetup, etMouseOver, etMouseOut, etBandClick };

typedef void __fastcall (__closure *TQRPreviewXEvent)(System::TObject* Sender, TPrevEventType eventNum, System::UnicodeString cName, System::UnicodeString CText, int rec);

enum DECLSPEC_DENUM TStandPrevEventType : unsigned char { spOpen, spClose, spCopy, spPrint, spPrintSetup, spLoad, spSave, spCancel };

typedef void __fastcall (__closure *TQRStandPrevEvent)(System::TObject* Sender, TStandPrevEventType eventType, System::UnicodeString contName, bool &Handled);

typedef void __fastcall (__closure *TCompositeEvent)(System::TObject* Sender, System::TObject* Report, int reportNumber);

typedef void __fastcall (__closure *TQRExportEvent)(TCustomQuickRep* Sender, bool &ExportHandled);

class PASCALIMPLEMENTATION TQRPreviewController : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FshowMinimise;
	bool FshowMaximise;
	bool FshowSysmenu;
	bool FshowSaveReport;
	bool FshowLoadReport;
	bool FShowPrint;
	bool FShowPrintSetup;
	bool FShowFindButton;
	bool FShowCopyButton;
	bool FShowGotoButton;
	bool FShowZoomFitButton;
	bool FShowZoom100Button;
	bool FShowZoomToWidthButton;
	bool FShowCancelButton;
	bool FShowZoomPickButton;
	bool FShowFirstButton;
	bool FShowNextButton;
	bool FShowPrevButton;
	bool FShowLastButton;
	int FPagesInPreview;
	int FprevInitWidth;
	int FprevInitHeight;
	int FPrevInitTop;
	int FPrevInitLeft;
	Vcl::Forms::TFormStyle FPrevWinStyle;
	Qrprntr::TPrevSaveType FPrevDefaultSave;
	System::Uitypes::TWindowState FPrevInitState;
	Qrprntr::TQRZoomState FPrevInitZoom;
	bool FShowThumbs;
	
public:
	__fastcall virtual TQRPreviewController(System::Classes::TComponent* aOwner);
	
__published:
	__property bool ShowMinimise = {read=FshowMinimise, write=FshowMinimise, default=1};
	__property bool ShowMaximise = {read=FshowMaximise, write=FshowMaximise, default=1};
	__property bool ShowSaveReportButton = {read=FshowSaveReport, write=FshowSaveReport, default=1};
	__property bool ShowLoadReportButton = {read=FshowLoadReport, write=FshowLoadReport, default=1};
	__property bool ShowPrintButton = {read=FShowPrint, write=FShowPrint, default=1};
	__property bool ShowPrintSetupButton = {read=FShowPrintSetup, write=FShowPrintSetup, default=1};
	__property bool ShowFindButton = {read=FShowFindButton, write=FShowFindButton, default=1};
	__property bool ShowCopyButton = {read=FShowCopyButton, write=FShowCopyButton, default=1};
	__property bool ShowSysMenu = {read=FshowSysmenu, write=FshowSysmenu, default=1};
	__property bool ShowGotoButton = {read=FShowGotoButton, write=FShowGotoButton, default=1};
	__property bool ShowZoomFitButton = {read=FShowZoomFitButton, write=FShowZoomFitButton, default=1};
	__property bool ShowZoom100Button = {read=FShowZoom100Button, write=FShowZoom100Button, default=1};
	__property bool ShowZoomToWidthButton = {read=FShowZoomToWidthButton, write=FShowZoomToWidthButton, default=1};
	__property bool ShowCancelButton = {read=FShowCancelButton, write=FShowCancelButton, default=1};
	__property bool ShowZoomPickButton = {read=FShowZoomPickButton, write=FShowZoomPickButton, default=1};
	__property bool ShowFirstButton = {read=FShowFirstButton, write=FShowFirstButton, default=1};
	__property bool ShowNextButton = {read=FShowNextButton, write=FShowNextButton, default=1};
	__property bool ShowPrevButton = {read=FShowPrevButton, write=FShowPrevButton, default=1};
	__property bool ShowLastButton = {read=FShowLastButton, write=FShowLastButton, default=1};
	__property int PagesInPreview = {read=FPagesInPreview, write=FPagesInPreview, nodefault};
	__property int prevInitWidth = {read=FprevInitWidth, write=FprevInitWidth, default=800};
	__property int prevInitHeight = {read=FprevInitHeight, write=FprevInitHeight, default=600};
	__property int PrevInitLeft = {read=FPrevInitLeft, write=FPrevInitLeft, nodefault};
	__property int PrevInitTop = {read=FPrevInitTop, write=FPrevInitTop, nodefault};
	__property Qrprntr::TPrevSaveType PrevDefaultSaveType = {read=FPrevDefaultSave, write=FPrevDefaultSave, nodefault};
	__property Vcl::Forms::TFormStyle PrevWindowStyle = {read=FPrevWinStyle, write=FPrevWinStyle, nodefault};
	__property System::Uitypes::TWindowState PrevInitState = {read=FPrevInitState, write=FPrevInitState, nodefault};
	__property Qrprntr::TQRZoomState PrevInitZoom = {read=FPrevInitZoom, write=FPrevInitZoom, nodefault};
	__property bool ShowThumbs = {read=FShowThumbs, write=FShowThumbs, default=1};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRPreviewController(void) { }
	
};


class PASCALIMPLEMENTATION TQRCustomController : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Classes::TComponent* OrgOwner;
	System::Classes::TComponent* FMaster;
	System::Classes::TList* PrintAfterList;
	System::Classes::TList* PrintBeforeList;
	System::Classes::TList* GroupList;
	bool FPrintIfEmpty;
	System::Classes::TComponent* FSelfCheck;
	TCustomQuickRep* FParentReport;
	bool FPrintBefore;
	System::Classes::TList* NotifyList;
	Qrexpr::TQREvElement* EvConstant;
	bool __fastcall CheckGroups(void);
	void __fastcall CheckLastGroupFooters(void);
	void __fastcall NewPageCheckGroups(void);
	void __fastcall SetMaster(System::Classes::TComponent* Value);
	
protected:
	virtual Qrexpr::TQREvResult __fastcall LocalVarValue(void);
	void __fastcall AddAfter(TQRCustomController* aController);
	void __fastcall AddBefore(TQRCustomController* aController);
	virtual void __fastcall BuildTree(void);
	virtual void __fastcall Execute(void);
	void __fastcall NotifyClients(TQRNotifyOperation Operation);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall Unprepare(void);
	virtual void __fastcall PrintAfterControllers(void);
	virtual void __fastcall PrintBeforeControllers(void);
	virtual void __fastcall PrintEmptyController(void);
	void __fastcall PrintGroupHeaders(void);
	void __fastcall PrintGroupFooters(void);
	virtual void __fastcall RegisterBands(void);
	virtual void __fastcall RegisterDatasets(void);
	virtual void __fastcall SetPrintBefore(bool Value);
	virtual void __fastcall UpdateLocalVar(void);
	
public:
	__fastcall virtual TQRCustomController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCustomController(void);
	void __fastcall AddNotifyClient(TQRPrintable* Value);
	__property System::Classes::TComponent* Master = {read=FMaster, write=SetMaster};
	__property TCustomQuickRep* ParentReport = {read=FParentReport, write=FParentReport};
	__property bool PrintBefore = {read=FPrintBefore, write=SetPrintBefore, nodefault};
	__property bool PrintIfEmpty = {read=FPrintIfEmpty, write=FPrintIfEmpty, nodefault};
	__property System::Classes::TComponent* SelfCheck = {read=FSelfCheck, write=FSelfCheck};
};


class PASCALIMPLEMENTATION TQRController : public TQRCustomController
{
	typedef TQRCustomController inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	TQRCustomBand* FDetail;
	TQRCustomBand* FFooter;
	TQRCustomBand* FHeader;
	TQROnNeedDataEvent FOnNeedDataEvent;
	int FDetailNumber;
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall PrintEmptyController(void);
	virtual void __fastcall RegisterBands(void);
	virtual void __fastcall RegisterDatasets(void);
	virtual void __fastcall Execute(void);
	
public:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property int DetailNumber = {read=FDetailNumber, nodefault};
	__property TQRCustomBand* Detail = {read=FDetail, write=FDetail};
	__property TQRCustomBand* Footer = {read=FFooter, write=FFooter};
	__property TQRCustomBand* Header = {read=FHeader, write=FHeader};
	__property TQROnNeedDataEvent OnNeedData = {read=FOnNeedDataEvent, write=FOnNeedDataEvent};
public:
	/* TQRCustomController.Create */ inline __fastcall virtual TQRController(System::Classes::TComponent* AOwner) : TQRCustomController(AOwner) { }
	/* TQRCustomController.Destroy */ inline __fastcall virtual ~TQRController(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRFrame : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FColor;
	bool FBottom;
	bool FLeft;
	Vcl::Controls::TControl* FParent;
	Vcl::Graphics::TPenStyle FPenStyle;
	bool FRight;
	bool FTop;
	int FWidth;
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetParent(Vcl::Controls::TControl* Value);
	void __fastcall SetStyle(Vcl::Graphics::TPenStyle Value);
	void __fastcall SetValue(int index, bool Value);
	void __fastcall SetWidth(int Value);
	
protected:
	void __fastcall PaintIt(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, System::Extended XFact, System::Extended YFact);
	void __fastcall SetPen(Vcl::Graphics::TPen* aPen);
	
public:
	__fastcall TQRFrame(void);
	bool __fastcall AnyFrame(void);
	__property Vcl::Controls::TControl* Parent = {read=FParent, write=SetParent};
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property bool DrawTop = {read=FTop, write=SetValue, index=0, default=0};
	__property bool DrawBottom = {read=FBottom, write=SetValue, index=1, default=0};
	__property bool DrawLeft = {read=FLeft, write=SetValue, index=2, default=0};
	__property bool DrawRight = {read=FRight, write=SetValue, index=3, default=0};
	__property Vcl::Graphics::TPenStyle Style = {read=FPenStyle, write=SetStyle, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRFrame(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TQRUnit : unsigned char { MM, Inches, Pixels, Characters, Native };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRUnitBase : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FResolution;
	TQRUnit FUnits;
	TQRUnit SavedUnits;
	TCustomQuickRep* FParentReport;
	bool FParentUpdating;
	int FZoom;
	virtual System::Extended __fastcall LoadUnit(System::Extended Value, TQRUnit aUnit, bool Horizontal);
	virtual System::Extended __fastcall SaveUnit(System::Extended Value, TQRUnit aUnit, bool Horizontal);
	
protected:
	virtual TQRUnit __fastcall GetUnits(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadValues(System::Classes::TReader* Reader);
	virtual void __fastcall SetParentSizes(void);
	virtual void __fastcall SetUnits(TQRUnit Value);
	virtual void __fastcall WriteValues(System::Classes::TWriter* Writer);
	void __fastcall SetPixels(void);
	void __fastcall RestoreUnit(void);
	
public:
	__fastcall TQRUnitBase(void);
	__property TCustomQuickRep* ParentReport = {read=FParentReport, write=FParentReport};
	__property bool ParentUpdating = {read=FParentUpdating, write=FParentUpdating, nodefault};
	__property int Resolution = {read=FResolution, nodefault};
	__property TQRUnit Units = {read=GetUnits, write=SetUnits, nodefault};
	__property int Zoom = {read=FZoom, write=FZoom, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRUnitBase(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRBandSize : public TQRUnitBase
{
	typedef TQRUnitBase inherited;
	
private:
	System::Extended FWidth;
	System::Extended FLength;
	TQRCustomBand* Parent;
	System::Extended __fastcall GetValue(int Index);
	void __fastcall SetValue(int Index, System::Extended Value);
	
protected:
	virtual void __fastcall ReadValues(System::Classes::TReader* Reader);
	virtual void __fastcall SetParentSizes(void);
	virtual void __fastcall WriteValues(System::Classes::TWriter* Writer);
	void __fastcall FixZoom(void);
	
public:
	__fastcall TQRBandSize(TQRCustomBand* AParent);
	__property System::Extended Length = {read=GetValue, write=SetValue, stored=false, index=0};
	
__published:
	__property System::Extended Height = {read=GetValue, write=SetValue, stored=false, index=0};
	__property System::Extended Width = {read=GetValue, write=SetValue, stored=false, index=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRBandSize(void) { }
	
};


enum DECLSPEC_DENUM TQRPrintOrder : unsigned char { ColByCol, RowByRow };

class PASCALIMPLEMENTATION TQRPage : public TQRUnitBase
{
	typedef TQRUnitBase inherited;
	
private:
	System::Extended FBottomMargin;
	System::Extended FColumnSpace;
	int FColumns;
	System::Extended FLeftMargin;
	System::Extended FLength;
	System::Uitypes::TPrinterOrientation FOrientation;
	Qrprntr::TQRPaperSize FPaperSize;
	TQRPrintOrder FPrintOrder;
	System::Extended FRightMargin;
	bool FRuler;
	System::Extended FTopMargin;
	System::Extended FWidth;
	TCustomQuickRep* Parent;
	bool FContinuous;
	Qrprntr::TQRPaperSize __fastcall GetPaperSize(void);
	bool __fastcall GetRuler(void);
	System::Extended __fastcall GetValue(int Index);
	void __fastcall SetColumns(int Value);
	void __fastcall SetOrientation(System::Uitypes::TPrinterOrientation Value);
	void __fastcall SetPaperSize(Qrprntr::TQRPaperSize Value);
	void __fastcall SetPrintOrder(TQRPrintOrder Value);
	void __fastcall SetRuler(bool Value);
	void __fastcall SetValue(int Index, System::Extended Value);
	__property TQRPrintOrder PrintOrder = {read=FPrintOrder, write=SetPrintOrder, nodefault};
	
protected:
	virtual void __fastcall ReadValues(System::Classes::TReader* Reader);
	virtual void __fastcall SetParentSizes(void);
	virtual void __fastcall SetUnits(TQRUnit Value);
	virtual void __fastcall WriteValues(System::Classes::TWriter* Writer);
	void __fastcall FixZoom(void);
	
public:
	__fastcall TQRPage(TCustomQuickRep* AParent);
	
__published:
	__property System::Extended BottomMargin = {read=GetValue, write=SetValue, stored=false, index=0};
	__property System::Extended ColumnSpace = {read=GetValue, write=SetValue, stored=false, index=6};
	__property int Columns = {read=FColumns, write=SetColumns, nodefault};
	__property System::Extended LeftMargin = {read=GetValue, write=SetValue, stored=false, index=4};
	__property System::Extended Length = {read=GetValue, write=SetValue, stored=false, index=1};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FOrientation, write=SetOrientation, nodefault};
	__property Qrprntr::TQRPaperSize PaperSize = {read=GetPaperSize, write=SetPaperSize, nodefault};
	__property System::Extended RightMargin = {read=GetValue, write=SetValue, stored=false, index=5};
	__property bool Ruler = {read=GetRuler, write=SetRuler, default=1};
	__property System::Extended TopMargin = {read=GetValue, write=SetValue, stored=false, index=2};
	__property System::Extended Width = {read=GetValue, write=SetValue, stored=false, index=3};
	__property bool Continuous = {read=FContinuous, write=FContinuous, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRPage(void) { }
	
};


class PASCALIMPLEMENTATION TQRBasePanel : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	int FFontSize;
	int FZoom;
	TQRFrame* FFrame;
	TQRFrame* __fastcall GetFrame(void);
	void __fastcall SetFrame(TQRFrame* Value);
	
protected:
	virtual void __fastcall SetZoom(int Value);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintRuler(TQRUnit Units);
	void __fastcall PrepareComponents(void);
	void __fastcall UnprepareComponents(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TQRBasePanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRBasePanel(void);
	__property int Zoom = {read=FZoom, write=SetZoom, nodefault};
	__property int FontSize = {read=FFontSize, write=FFontSize, nodefault};
	
__published:
	__property TQRFrame* Frame = {read=GetFrame, write=SetFrame};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRBasePanel(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TQRBandBeforePrintEvent)(TQRCustomBand* Sender, bool &PrintBand);

typedef void __fastcall (__closure *TQRBandAfterPrintEvent)(TQRCustomBand* Sender, bool BandPrinted);

class PASCALIMPLEMENTATION TQRCustomBand : public TQRBasePanel
{
	typedef TQRBasePanel inherited;
	
private:
	bool FPreCaluculateBandHeight;
	bool FKeepOnOnePage;
	System::Extended FExpandedHeight;
	System::Types::TRect BandFrameRect;
	bool ButtonDown;
	System::Extended FExpanded;
	TQRBandAfterPrintEvent FAfterPrintEvent;
	bool FAlignToBottom;
	TQRBandBeforePrintEvent FBeforePrintEvent;
	bool FEnabled;
	bool FForceNewColumn;
	bool FForceNewPage;
	TQRCustomBand* FLinkBand;
	TCustomQuickRep* FParentReport;
	bool FParentUpdating;
	bool FTransparentBand;
	Qrprntr::TQRBandType FQRBandType;
	int LoadedHeight;
	TQRBandSize* FSize;
	TQRCustomController* FNotifyController;
	void __fastcall SetLinkBand(TQRCustomBand* Value);
	TQRBandSize* __fastcall GetBandSize(void);
	bool __fastcall GetHasChild(void);
	TQRChildBand* __fastcall GetChild(void);
	void __fastcall SetBandType(Qrprntr::TQRBandType Value);
	void __fastcall SetHasChild(bool Value);
	
protected:
	TQRUnit __fastcall GetUnits(void);
	System::Extended __fastcall StretchHeight(bool IncludeNext);
	virtual System::UnicodeString __fastcall BandTypeName(void);
	virtual System::UnicodeString __fastcall BandComponentName(void);
	void __fastcall AdvancePaper(void);
	virtual void __fastcall Loaded(void);
	void __fastcall MakeSpace(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintRuler(TQRUnit Units);
	void __fastcall Print(void);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall SetParentReport(TCustomQuickRep* AParentReport);
	void __fastcall SetBandSize(TQRBandSize* Value);
	virtual void __fastcall SetEnabled(bool Value);
	void __fastcall SetUnits(TQRUnit Value);
	virtual void __fastcall SetZoom(int Value);
	virtual void __fastcall WriteDummy(System::Classes::TWriter* Writer);
	__property TQRCustomController* NotifyController = {read=FNotifyController, write=FNotifyController};
	__property bool ParentUpdating = {read=FParentUpdating, write=FParentUpdating, nodefault};
	__property TQRUnit Units = {read=GetUnits, write=SetUnits, nodefault};
	
public:
	__fastcall virtual TQRCustomBand(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCustomBand(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	TQRPrintable* __fastcall AddPrintable(TQRNewComponentClass PrintableClass);
	bool __fastcall CanExpand(System::Extended Value);
	bool __fastcall ExpandBand(System::Extended Value, System::Extended &NewExpanded, bool &HasExpanded);
	__property System::Extended Expanded = {read=FExpanded};
	__property Qrprntr::TQRBandType BandType = {read=FQRBandType, write=SetBandType, nodefault};
	__property TQRChildBand* ChildBand = {read=GetChild};
	__property TCustomQuickRep* ParentReport = {read=FParentReport, write=SetParentReport};
	void __fastcall ExpandedHeight(System::Extended &NewHeight);
	
__published:
	__property TQRBandAfterPrintEvent AfterPrint = {read=FAfterPrintEvent, write=FAfterPrintEvent};
	__property bool AlignToBottom = {read=FAlignToBottom, write=FAlignToBottom, nodefault};
	__property TQRBandBeforePrintEvent BeforePrint = {read=FBeforePrintEvent, write=FBeforePrintEvent};
	__property Color = {default=-16777201};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool TransparentBand = {read=FTransparentBand, write=FTransparentBand, nodefault};
	__property Font;
	__property bool ForceNewColumn = {read=FForceNewColumn, write=FForceNewColumn, nodefault};
	__property bool ForceNewPage = {read=FForceNewPage, write=FForceNewPage, nodefault};
	__property bool HasChild = {read=GetHasChild, write=SetHasChild, stored=false, nodefault};
	__property TQRCustomBand* LinkBand = {read=FLinkBand, write=SetLinkBand};
	__property ParentFont = {default=1};
	__property TQRBandSize* Size = {read=GetBandSize, write=SetBandSize};
	__property bool PreCaluculateBandHeight = {read=FPreCaluculateBandHeight, write=FPreCaluculateBandHeight, nodefault};
	__property bool KeepOnOnePage = {read=FKeepOnOnePage, write=FKeepOnOnePage, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRCustomBand(HWND ParentWindow) : TQRBasePanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRBand : public TQRCustomBand
{
	typedef TQRCustomBand inherited;
	
__published:
	__property BandType;
	__property TransparentBand;
	__property PreCaluculateBandHeight;
	__property KeepOnOnePage;
public:
	/* TQRCustomBand.Create */ inline __fastcall virtual TQRBand(System::Classes::TComponent* AOwner) : TQRCustomBand(AOwner) { }
	/* TQRCustomBand.Destroy */ inline __fastcall virtual ~TQRBand(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRBand(HWND ParentWindow) : TQRCustomBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRWildBand : public TQRCustomBand
{
	typedef TQRCustomBand inherited;
	
protected:
	bool FPrintNow;
	void __fastcall SetPrintNow(bool value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TQRWildBand(System::Classes::TComponent* AOwner);
	__property bool PrintNow = {read=FPrintNow, write=SetPrintNow, nodefault};
public:
	/* TQRCustomBand.Destroy */ inline __fastcall virtual ~TQRWildBand(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRWildBand(HWND ParentWindow) : TQRCustomBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRChildBand : public TQRCustomBand
{
	typedef TQRCustomBand inherited;
	
private:
	TQRCustomBand* FParentBand;
	TCBPrintOrder FPrintOrder;
	void __fastcall SetParentBand(TQRCustomBand* Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TQRChildBand(System::Classes::TComponent* AOwner);
	
__published:
	__property TQRCustomBand* ParentBand = {read=FParentBand, write=SetParentBand};
	__property TCBPrintOrder PrintOrder = {read=FPrintOrder, write=FPrintOrder, nodefault};
public:
	/* TQRCustomBand.Destroy */ inline __fastcall virtual ~TQRChildBand(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRChildBand(HWND ParentWindow) : TQRCustomBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRControllerBand : public TQRCustomBand
{
	typedef TQRCustomBand inherited;
	
private:
	bool LocalVarCreated;
	TQRCustomController* FController;
	System::Classes::TComponent* FMaster;
	
protected:
	bool __fastcall GetPrintIfEmpty(void);
	bool __fastcall GetPrintBefore(void);
	void __fastcall SetPrintBefore(bool Value);
	virtual void __fastcall CreateController(void);
	virtual void __fastcall RegisterBands(void);
	virtual void __fastcall SetMaster(System::Classes::TComponent* Value);
	virtual void __fastcall SetName(const System::Classes::TComponentName NewName);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall SetParentReport(TCustomQuickRep* AParentReport);
	virtual void __fastcall CreateLocalVar(void);
	virtual void __fastcall RemoveLocalVar(void);
	virtual System::UnicodeString __fastcall LocalVarExpression(void);
	void __fastcall SetPrintIfEmpty(bool Value);
	__property TQRCustomController* Controller = {read=FController, write=FController};
	
public:
	__fastcall virtual TQRControllerBand(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRControllerBand(void);
	__property bool PrintIfEmpty = {read=GetPrintIfEmpty, write=SetPrintIfEmpty, nodefault};
	__property bool PrintBefore = {read=GetPrintBefore, write=SetPrintBefore, nodefault};
	
__published:
	__property System::Classes::TComponent* Master = {read=FMaster, write=SetMaster};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRControllerBand(HWND ParentWindow) : TQRCustomBand(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRSubDetailGroupBands : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TQRSubDetail* Owner;
	TQRCustomBand* __fastcall GetFooterBand(void);
	bool __fastcall GetHasFooter(void);
	bool __fastcall GetHasHeader(void);
	TQRCustomBand* __fastcall GetHeaderBand(void);
	void __fastcall SetHasFooter(bool Value);
	void __fastcall SetHasHeader(bool Value);
	
public:
	__fastcall TQRSubDetailGroupBands(TQRSubDetail* AOwner);
	__property TQRCustomBand* FooterBand = {read=GetFooterBand};
	__property TQRCustomBand* HeaderBand = {read=GetHeaderBand};
	
__published:
	__property bool HasFooter = {read=GetHasFooter, write=SetHasFooter, stored=false, nodefault};
	__property bool HasHeader = {read=GetHasHeader, write=SetHasHeader, stored=false, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRSubDetailGroupBands(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRSubDetail : public TQRControllerBand
{
	typedef TQRControllerBand inherited;
	
private:
	TQRSubDetailGroupBands* FBands;
	Data::Db::TDataSet* __fastcall GetDataSet(void);
	TQRCustomBand* __fastcall GetFooterBand(void);
	TQRCustomBand* __fastcall GetHeaderBand(void);
	TQROnNeedDataEvent __fastcall GetOnNeedData(void);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	void __fastcall SetFooterBand(TQRCustomBand* Value);
	void __fastcall SetHeaderBand(TQRCustomBand* Value);
	void __fastcall SetOnNeedData(TQROnNeedDataEvent Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall RegisterBands(void);
	
public:
	__fastcall virtual TQRSubDetail(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRSubDetail(void);
	void __fastcall AddNotifyClient(TQRPrintable* Value);
	
__published:
	__property TQRSubDetailGroupBands* Bands = {read=FBands, write=FBands};
	__property Data::Db::TDataSet* DataSet = {read=GetDataSet, write=SetDataSet};
	__property TQRCustomBand* FooterBand = {read=GetFooterBand, write=SetFooterBand};
	__property TQRCustomBand* HeaderBand = {read=GetHeaderBand, write=SetHeaderBand};
	__property TQROnNeedDataEvent OnNeedData = {read=GetOnNeedData, write=SetOnNeedData};
	__property PrintBefore;
	__property PrintIfEmpty;
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRSubDetail(HWND ParentWindow) : TQRControllerBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRLoopController : public TQRCustomController
{
	typedef TQRCustomController inherited;
	
private:
	int FCount;
	int FPrintCount;
	TQRCustomBand* FDetailBand;
	
protected:
	virtual Qrexpr::TQREvResult __fastcall LocalVarValue(void);
	virtual void __fastcall RegisterBands(void);
	
public:
	__fastcall virtual TQRLoopController(System::Classes::TComponent* AOwner);
	virtual void __fastcall Execute(void);
	__property TQRCustomBand* Detail = {read=FDetailBand, write=FDetailBand};
	__property int PrintCount = {read=FPrintCount, write=FPrintCount, nodefault};
	__property int Count = {read=FCount, write=FCount, nodefault};
public:
	/* TQRCustomController.Destroy */ inline __fastcall virtual ~TQRLoopController(void) { }
	
};


class PASCALIMPLEMENTATION TQRLoopBand : public TQRControllerBand
{
	typedef TQRControllerBand inherited;
	
protected:
	int __fastcall GetPrintCount(void);
	void __fastcall SetPrintCount(int Value);
	virtual void __fastcall CreateController(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual System::UnicodeString __fastcall BandTypeName(void);
	virtual System::UnicodeString __fastcall BandComponentName(void);
	int __fastcall GetCount(void);
	virtual System::UnicodeString __fastcall LocalVarExpression(void);
	
public:
	__fastcall virtual TQRLoopBand(System::Classes::TComponent* AOwner);
	__property int Count = {read=GetCount, nodefault};
	
__published:
	__property int PrintCount = {read=GetPrintCount, write=SetPrintCount, nodefault};
	__property PrintBefore;
public:
	/* TQRControllerBand.Destroy */ inline __fastcall virtual ~TQRLoopBand(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRLoopBand(HWND ParentWindow) : TQRControllerBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRStringsController : public TQRCustomController
{
	typedef TQRCustomController inherited;
	
private:
	System::Classes::TStrings* FItems;
	int FIndex;
	TQRCustomBand* FDetailBand;
	
protected:
	virtual Qrexpr::TQREvResult __fastcall LocalVarValue(void);
	virtual void __fastcall RegisterBands(void);
	
public:
	__fastcall virtual TQRStringsController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRStringsController(void);
	virtual void __fastcall Execute(void);
	__property TQRCustomBand* Detail = {read=FDetailBand, write=FDetailBand};
	__property System::Classes::TStrings* Items = {read=FItems, write=FItems};
	__property int Index = {read=FIndex, write=FIndex, nodefault};
};


class PASCALIMPLEMENTATION TQRStringsBand : public TQRControllerBand
{
	typedef TQRControllerBand inherited;
	
protected:
	int __fastcall GetIndex(void);
	System::UnicodeString __fastcall GetItem(void);
	System::Classes::TStrings* __fastcall GetItems(void);
	virtual System::UnicodeString __fastcall BandTypeName(void);
	virtual System::UnicodeString __fastcall BandComponentName(void);
	virtual System::UnicodeString __fastcall LocalVarExpression(void);
	void __fastcall SetItems(System::Classes::TStrings* Value);
	virtual void __fastcall CreateController(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TQRStringsBand(System::Classes::TComponent* AOwner);
	__property System::UnicodeString Item = {read=GetItem};
	__property int Index = {read=GetIndex, nodefault};
	
__published:
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property PrintBefore;
public:
	/* TQRControllerBand.Destroy */ inline __fastcall virtual ~TQRStringsBand(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRStringsBand(HWND ParentWindow) : TQRControllerBand(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQuickRepBands : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TCustomQuickRep* FOwner;
	TQRCustomBand* __fastcall BandInList(Qrprntr::TQRBandType BandType);
	void __fastcall SetBand(Qrprntr::TQRBandType BandType, bool Value);
	TQRCustomBand* __fastcall GetBand(int Index);
	bool __fastcall GetHasBand(int Index);
	void __fastcall SetHasBand(int Index, bool Value);
	
public:
	__fastcall TQuickRepBands(TCustomQuickRep* AOwner);
	__property TQRCustomBand* TitleBand = {read=GetBand, index=1};
	__property TQRCustomBand* PageHeaderBand = {read=GetBand, index=2};
	__property TQRCustomBand* ColumnHeaderBand = {read=GetBand, index=3};
	__property TQRCustomBand* DetailBand = {read=GetBand, index=4};
	__property TQRCustomBand* ColumnFooterBand = {read=GetBand, index=5};
	__property TQRCustomBand* PageFooterBand = {read=GetBand, index=6};
	__property TQRCustomBand* SummaryBand = {read=GetBand, index=7};
	
__published:
	__property bool HasTitle = {read=GetHasBand, write=SetHasBand, stored=false, index=1, nodefault};
	__property bool HasPageHeader = {read=GetHasBand, write=SetHasBand, stored=false, index=2, nodefault};
	__property bool HasColumnHeader = {read=GetHasBand, write=SetHasBand, stored=false, index=3, nodefault};
	__property bool HasDetail = {read=GetHasBand, write=SetHasBand, stored=false, index=4, nodefault};
	__property bool HasPageFooter = {read=GetHasBand, write=SetHasBand, stored=false, index=6, nodefault};
	__property bool HasSummary = {read=GetHasBand, write=SetHasBand, stored=false, index=7, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQuickRepBands(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TQRState : unsigned char { qrAvailable, qrPrepare, qrPreview, qrPrint, qrEdit };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQuickRepPrinterSettings : public Qrprntr::TQRPrinterSettings
{
	typedef Qrprntr::TQRPrinterSettings inherited;
	
private:
	bool FPrintMetaFile;
	
__published:
	__property Copies;
	__property OutputBin;
	__property Duplex;
	__property FirstPage;
	__property LastPage;
	__property UseStandardprinter;
	__property UseCustomBinCode;
	__property CustomBinCode;
	__property ExtendedDuplex;
	__property UseCustomPaperCode;
	__property CustomPaperCode;
	__property bool PrintMetaFile = {read=FPrintMetaFile, write=FPrintMetaFile, nodefault};
	__property MemoryLimit = {default=250000};
	__property PrintQuality = {default=600};
	__property Collate;
	__property ColorOption;
public:
	/* TQRPrinterSettings.Create */ inline __fastcall TQuickRepPrinterSettings(void) : Qrprntr::TQRPrinterSettings() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQuickRepPrinterSettings(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRCompositePrinterSettings : public TQuickRepPrinterSettings
{
	typedef TQuickRepPrinterSettings inherited;
	
__published:
	__property Orientation;
	__property PaperSize;
	__property MemoryLimit = {default=250000};
	__property PrintQuality = {default=600};
	__property Collate;
	__property ColorOption;
public:
	/* TQRPrinterSettings.Create */ inline __fastcall TQRCompositePrinterSettings(void) : TQuickRepPrinterSettings() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRCompositePrinterSettings(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRCreateReportThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	Qrprntr::TQRPrinter* FQRPrinter;
	TCustomQuickRep* FQuickRep;
	
public:
	__fastcall TQRCreateReportThread(TCustomQuickRep* AReport);
	virtual void __fastcall Execute(void);
	__property TCustomQuickRep* QuickRep = {read=FQuickRep, write=FQuickRep};
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TQRCreateReportThread(void) { }
	
};


enum DECLSPEC_DENUM TQuickReportOption : unsigned char { FirstPageHeader, LastPageFooter, Compression };

typedef System::Set<TQuickReportOption, TQuickReportOption::FirstPageHeader, TQuickReportOption::Compression> TQuickReportOptions;

typedef void __fastcall (__closure *TQRNotifyEvent)(TCustomQuickRep* Sender);

typedef void __fastcall (__closure *TQRReportBeforePrintEvent)(TCustomQuickRep* Sender, bool &PrintReport);

class PASCALIMPLEMENTATION TCustomQuickRep : public TQRBasePanel
{
	typedef TQRBasePanel inherited;
	
private:
	TQRCreateReportThread* BGThread;
	System::UnicodeString FBackgroundImage;
	TQRPrintable* FBackgroundcontrol;
	System::Classes::TList* BandRegList;
	System::Classes::TList* FAllDataSets;
	Qrprntr::TQRAfterPrintEvent FAfterPrintEvent;
	Qrprntr::TQRAfterPreviewEvent FAfterPreviewEvent;
	Qrprntr::TQRAfterPreviewEvent FOnPreviewShowing;
	System::Classes::TNotifyEvent FBeforePreview;
	bool FAvailable;
	System::Classes::TList* FBandList;
	TQuickRepBands* FBands;
	TQRReportBeforePrintEvent FBeforePrintEvent;
	bool FCancelled;
	System::Uitypes::TColor FBackgroundColor;
	TQRCustomController* FController;
	int FColumnTopPosition;
	int FCurrentColumn;
	int FCurrentX;
	int FCurrentY;
	System::Classes::TStrings* FDescription;
	Qrexpr::TQREvEnvironment* FEnvironment;
	Qrprntr::TQRExportFilter* FExportFilter;
	bool FExporting;
	bool FFinalPass;
	bool FHideBands;
	bool FLastPage;
	bool FModified;
	TQRNotifyEvent FOnEndPageEvent;
	TQROnNeedDataEvent FOnNeedDataEvent;
	System::Classes::TNotifyEvent FOnPreviewEvent;
	TQRNotifyEvent FOnStartPageEvent;
	TQuickReportOptions FOptions;
	TQRPage* FPage;
	Vcl::Graphics::TMetafile* FPreviewPage;
	System::Extended FPageFooterSize;
	TQuickRepPrinterSettings* FPrinterSettings;
	System::UnicodeString FReportTitle;
	int FRotateBands;
	bool FShowProgress;
	bool FSnapToGrid;
	TQRState FState;
	Qrprntr::TQRPrinter* FQRPrinter;
	bool NewColumnForced;
	bool NewPageForced;
	NativeUInt ReferenceDC;
	bool PreparingDesignTime;
	Qrexpr::TQREvElement* EvPageNumber;
	Qrexpr::TQREvElement* EvColumnNumber;
	Qrexpr::TQREvElement* EvReportTitle;
	bool NoForceNewPage;
	Vcl::Forms::TFormStyle FPrevFormStyle;
	System::Uitypes::TWindowState FPreviewInitialState;
	int FPreviewWidth;
	int FPreviewHeight;
	int FPagecount;
	bool FPrevShowThumbs;
	bool FPrevShowSearch;
	Qrprntr::TQRZoomState FPrevInitialZoom;
	TQRPrinterEvent FOnGetPrinterSettings;
	TQRPrinterEvent FOnApplyPrinterSettings;
	TQRPreviewXEvent FOnPrevXEvent;
	TQRStandPrevEvent FonStandPrevEvent;
	int FPagesInPreview;
	Qrprntr::TPrevSaveType FPreviewDefaultSaveType;
	bool FShowingPreview;
	bool FStartNewPageInComposite;
	bool FCreateInBGThread;
	int FPreviewLeft;
	int FPreviewTop;
	TQRExportEvent FOnExport;
	TQRPreviewController* FPreviewSetup;
	int __fastcall GetPreviewHeight(void);
	int __fastcall GetPreviewWidth(void);
	bool __fastcall GetPrevShowThumbs(void);
	void __fastcall SetPrevShowThumbs(bool value);
	TQRUnit __fastcall GetUnits(void);
	bool __fastcall GetPrintIfEmpty(void);
	void __fastcall PrintBand(TQRCustomBand* ABand);
	void __fastcall PrintPageBackground(void);
	void __fastcall SetExportFilter(Qrprntr::TQRExportFilter* Value);
	virtual void __fastcall SetUnits(TQRUnit Value);
	void __fastcall SetDescription(System::Classes::TStrings* Value);
	void __fastcall SetPrinterValues(void);
	void __fastcall SetController(TQRCustomController* Value);
	
protected:
	virtual void __fastcall Execute(void);
	MESSAGE void __fastcall CMPageAvailable(Qrprntr::TCM_QRPageAvailable &Message);
	MESSAGE void __fastcall CMPreviewClose(Qrprntr::TCM_QRPreviewClose &Message);
	MESSAGE void __fastcall CMPrint(Winapi::Messages::TMessage &Message);
	bool __fastcall PrepareQRPrinter(void);
	virtual void __fastcall CreateReport(bool CompositeReport);
	void __fastcall ForceNewColumn(void);
	void __fastcall ForceNewPage(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall PaintColumns(void);
	virtual void __fastcall PaintMargins(void);
	virtual void __fastcall PaintFrame(void);
	virtual void __fastcall PaintRuler(TQRUnit Units);
	void __fastcall PreviewFinished(System::TObject* Sender);
	void __fastcall PreviewIt(bool Modal);
	void __fastcall PrintFinished(System::TObject* Sender);
	void __fastcall RebuildBandList(void);
	void __fastcall RegisterBand(TQRCustomBand* aBand);
	virtual void __fastcall SetControllerBands(void);
	virtual void __fastcall SetPrintIfEmpty(bool Value);
	void __fastcall SetHideBands(bool Value);
	void __fastcall SetRotateBands(int Value);
	virtual void __fastcall SetZoom(int Value);
	__property TQRCustomController* Controller = {read=FController, write=SetController};
	
public:
	bool UserCancel;
	bool PrintAfterSetup;
	TQuickRepPrinterSettings* UserPrinterSettings;
	System::TObject* ParentComposite;
	__fastcall virtual TCustomQuickRep(System::Classes::TComponent* AOwner);
	__fastcall virtual TCustomQuickRep(System::Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TCustomQuickRep(void);
	int __fastcall AvailableSpace(void);
	TQRBand* __fastcall CreateBand(Qrprntr::TQRBandType BandType);
	int __fastcall TextHeight(Vcl::Graphics::TFont* aFont, System::UnicodeString aText);
	int __fastcall TextWidth(Vcl::Graphics::TFont* aFont, System::UnicodeString aText);
	void __fastcall AddBand(TQRCustomBand* aBand);
	virtual void __fastcall AddNotifyClient(TQRPrintable* Value);
	void __fastcall Cancel(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* root);
	void __fastcall ExportComposite(Qrprntr::TQRExportFilter* AFilter, Qrprntr::TQRPrinter* expQRPrinter);
	void __fastcall ExportToFilter(Qrprntr::TQRExportFilter* AFilter);
	void __fastcall EndPage(void);
	void __fastcall Modify(void);
	void __fastcall NewColumn(void);
	void __fastcall NewPage(void);
	virtual void __fastcall Paint(void);
	void __fastcall Print(void);
	void __fastcall PrintBackground(void);
	void __fastcall PrinterSetup(void);
	void __fastcall Prepare(void);
	void __fastcall Preview(void);
	void __fastcall PreviewXML(void);
	void __fastcall PreviewModeless(void);
	void __fastcall PreviewModal(void);
	void __fastcall ResetPageFooterSize(void);
	void __fastcall RemoveBand(TQRCustomBand* aBand);
	void __fastcall SetBandValues(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property bool Available = {read=FAvailable, nodefault};
	__property System::Classes::TList* AllDataSets = {read=FAllDataSets, write=FAllDataSets};
	__property System::Classes::TList* BandList = {read=FBandList};
	__property bool Cancelled = {read=FCancelled, nodefault};
	__property int ColumnTopPosition = {read=FColumnTopPosition, write=FColumnTopPosition, nodefault};
	__property int CurrentColumn = {read=FCurrentColumn, nodefault};
	__property int CurrentX = {read=FCurrentX, write=FCurrentX, nodefault};
	__property int CurrentY = {read=FCurrentY, write=FCurrentY, nodefault};
	__property Qrprntr::TQRExportFilter* ExportFilter = {read=FExportFilter, write=SetExportFilter};
	__property bool Exporting = {read=FExporting, nodefault};
	__property bool FinalPass = {read=FFinalPass, nodefault};
	__property bool HideBands = {read=FHideBands, write=SetHideBands, nodefault};
	__property int PageNumber = {read=FPagecount, nodefault};
	__property bool ShowingPreview = {read=FShowingPreview, write=FShowingPreview, nodefault};
	__property Qrprntr::TQRPrinter* QRPrinter = {read=FQRPrinter, write=FQRPrinter};
	__property int RotateBands = {read=FRotateBands, write=SetRotateBands, nodefault};
	__property TQRState State = {read=FState, write=FState, nodefault};
	__property Qrprntr::TQRAfterPrintEvent AfterPrint = {read=FAfterPrintEvent, write=FAfterPrintEvent};
	__property Qrprntr::TQRAfterPreviewEvent AfterPreview = {read=FAfterPreviewEvent, write=FAfterPreviewEvent};
	__property Qrprntr::TQRAfterPreviewEvent OnPreviewShowing = {read=FOnPreviewShowing, write=FOnPreviewShowing};
	__property System::Classes::TNotifyEvent BeforePreview = {read=FBeforePreview, write=FBeforePreview};
	__property TQuickRepBands* Bands = {read=FBands, write=FBands};
	__property TQRReportBeforePrintEvent BeforePrint = {read=FBeforePrintEvent, write=FBeforePrintEvent};
	__property System::Classes::TStrings* Description = {read=FDescription, write=SetDescription};
	__property System::UnicodeString BackImageControl = {read=FBackgroundImage, write=FBackgroundImage};
	__property Font;
	__property Qrexpr::TQREvEnvironment* Functions = {read=FEnvironment, write=FEnvironment, stored=true};
	__property TQRNotifyEvent OnEndPage = {read=FOnEndPageEvent, write=FOnEndPageEvent};
	__property TQROnNeedDataEvent OnNeedData = {read=FOnNeedDataEvent, write=FOnNeedDataEvent};
	__property System::Classes::TNotifyEvent OnPreview = {read=FOnPreviewEvent, write=FOnPreviewEvent};
	__property TQRNotifyEvent OnStartPage = {read=FOnStartPageEvent, write=FOnStartPageEvent};
	__property TQuickReportOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property TQRPage* Page = {read=FPage, write=FPage};
	__property bool PrintIfEmpty = {read=GetPrintIfEmpty, write=SetPrintIfEmpty, nodefault};
	__property TQuickRepPrinterSettings* PrinterSettings = {read=FPrinterSettings, write=FPrinterSettings};
	__property System::UnicodeString ReportTitle = {read=FReportTitle, write=FReportTitle};
	__property bool ShowProgress = {read=FShowProgress, write=FShowProgress, default=1};
	__property bool SnapToGrid = {read=FSnapToGrid, write=FSnapToGrid, nodefault};
	__property TQRUnit Units = {read=GetUnits, write=SetUnits, stored=true, nodefault};
	__property Zoom;
	__property Vcl::Forms::TFormStyle PrevFormStyle = {read=FPrevFormStyle, write=FPrevFormStyle, nodefault};
	__property System::Uitypes::TWindowState PreviewInitialState = {read=FPreviewInitialState, write=FPreviewInitialState, nodefault};
	__property int PreviewWidth = {read=GetPreviewWidth, write=FPreviewWidth, default=500};
	__property int PreviewHeight = {read=GetPreviewHeight, write=FPreviewHeight, default=500};
	__property bool PrevShowThumbs = {read=GetPrevShowThumbs, write=SetPrevShowThumbs, default=1};
	__property bool PrevShowSearch = {read=FPrevShowSearch, write=FPrevShowSearch, default=1};
	__property Qrprntr::TQRZoomState PrevInitialZoom = {read=FPrevInitialZoom, write=FPrevInitialZoom, nodefault};
	__property TQRPrinterEvent OnGetPrinterSettings = {read=FOnGetPrinterSettings, write=FOnGetPrinterSettings};
	__property TQRPrinterEvent OnApplyPrinterSettings = {read=FOnApplyPrinterSettings, write=FOnApplyPrinterSettings};
	__property Qrprntr::TPrevSaveType PreviewDefaultSaveType = {read=FPreviewDefaultSaveType, write=FPreviewDefaultSaveType, nodefault};
	__property System::Uitypes::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, default=16777215};
	__property TQRPreviewXEvent OnPrevXEvent = {read=FOnPrevXEvent, write=FOnPrevXEvent};
	__property TQRStandPrevEvent OnStandPrevEvent = {read=FonStandPrevEvent, write=FonStandPrevEvent};
	__property int PagesInPreview = {read=FPagesInPreview, write=FPagesInPreview, default=0};
	__property int PreviewLeft = {read=FPreviewLeft, write=FPreviewLeft, default=100};
	__property int PreviewTop = {read=FPreviewTop, write=FPreviewTop, default=100};
	__property bool StartNewPageInComposite = {read=FStartNewPageInComposite, write=FStartNewPageInComposite, default=0};
	__property bool CreateInBGThread = {read=FCreateInBGThread, write=FCreateInBGThread, default=0};
	__property TQRPreviewController* PreviewController = {read=FPreviewSetup, write=FPreviewSetup};
	__property TQRExportEvent OnExport = {read=FOnExport, write=FOnExport};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomQuickRep(HWND ParentWindow) : TQRBasePanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQuickRep : public TCustomQuickRep
{
	typedef TCustomQuickRep inherited;
	
private:
	Data::Db::TDataSet* __fastcall GetDataSet(void);
	int __fastcall GetRecordCount(void);
	int __fastcall GetRecordNumber(void);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	
protected:
	virtual void __fastcall Execute(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetControllerBands(void);
	
public:
	__fastcall virtual TQuickRep(System::Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TQuickRep(void);
	__property int RecordCount = {read=GetRecordCount, nodefault};
	__property int RecordNumber = {read=GetRecordNumber, nodefault};
	
__published:
	__property AfterPrint;
	__property AfterPreview;
	__property BackImageControl = {default=0};
	__property Bands;
	__property BeforePrint;
	__property Data::Db::TDataSet* DataSet = {read=GetDataSet, write=SetDataSet};
	__property Description;
	__property Font;
	__property Functions;
	__property OnEndPage;
	__property OnNeedData;
	__property OnPreview;
	__property OnStartPage;
	__property Options;
	__property Page;
	__property PrinterSettings;
	__property PrintIfEmpty;
	__property ReportTitle = {default=0};
	__property ShowProgress = {default=1};
	__property SnapToGrid;
	__property Units;
	__property Zoom;
	__property OnGetPrinterSettings;
	__property OnApplyPrinterSettings;
	__property PrevFormStyle;
	__property PreviewInitialState;
	__property PreviewWidth = {default=500};
	__property PreviewHeight = {default=500};
	__property PrevShowThumbs = {default=1};
	__property PrevShowSearch = {default=1};
	__property PrevInitialZoom;
	__property PreviewDefaultSaveType;
	__property BackgroundColor = {default=16777215};
	__property OnPrevXEvent;
	__property OnStandPrevEvent;
	__property PagesInPreview = {default=0};
	__property PreviewLeft = {default=100};
	__property PreviewTop = {default=100};
	__property StartNewPageInComposite = {default=0};
	__property CreateInBGThread = {default=0};
	__property PreviewController;
	__property OnExport;
	__property OnPreviewShowing;
public:
	/* TCustomQuickRep.Create */ inline __fastcall virtual TQuickRep(System::Classes::TComponent* AOwner) : TCustomQuickRep(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQuickRep(HWND ParentWindow) : TCustomQuickRep(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQuickAbstractRep : public TCustomQuickRep
{
	typedef TCustomQuickRep inherited;
	
__published:
	__property AfterPrint;
	__property AfterPreview;
	__property OnPreviewShowing;
	__property Bands;
	__property BeforePrint;
	__property Description;
	__property Font;
	__property Functions;
	__property OnEndPage;
	__property OnPreview;
	__property OnStartPage;
	__property Options;
	__property Page;
	__property PrinterSettings;
	__property PrintIfEmpty;
	__property ReportTitle = {default=0};
	__property Units;
	__property Zoom;
public:
	/* TCustomQuickRep.Create */ inline __fastcall virtual TQuickAbstractRep(System::Classes::TComponent* AOwner) : TCustomQuickRep(AOwner) { }
	/* TCustomQuickRep.CreateNew */ inline __fastcall virtual TQuickAbstractRep(System::Classes::TComponent* AOwner, int Dummy) : TCustomQuickRep(AOwner, Dummy) { }
	/* TCustomQuickRep.Destroy */ inline __fastcall virtual ~TQuickAbstractRep(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQuickAbstractRep(HWND ParentWindow) : TCustomQuickRep(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRLabelSetup : public TQRUnitBase
{
	typedef TQRUnitBase inherited;
	
private:
	System::Extended FTopMargin;
	System::Extended FSideMargin;
	System::Extended FVerticalPitch;
	System::Extended FLabelWidth;
	System::Extended FLabelHeight;
	System::Extended FHorizontalPitch;
	int FNumberDown;
	int FNumberAcross;
	TCustomQuickRep* FParent;
	
protected:
	System::Extended __fastcall GetValue(int Index);
	int __fastcall GetInteger(int Index);
	void __fastcall SetValue(int Index, System::Extended Value);
	void __fastcall SetInteger(int Index, int Value);
	
public:
	__fastcall TQRLabelSetup(TCustomQuickRep* Parent);
	
__published:
	__property System::Extended TopMargin = {read=GetValue, write=SetValue, stored=false, index=0};
	__property System::Extended SideMargin = {read=GetValue, write=SetValue, stored=false, index=1};
	__property System::Extended VerticalPitch = {read=GetValue, write=SetValue, stored=false, index=2};
	__property System::Extended LabelWidth = {read=GetValue, write=SetValue, stored=false, index=3};
	__property System::Extended LabelHeight = {read=GetValue, write=SetValue, stored=false, index=4};
	__property System::Extended HorizontalPitch = {read=GetValue, write=SetValue, stored=false, index=5};
	__property int NumberDown = {read=GetInteger, write=SetInteger, stored=false, index=0, nodefault};
	__property int NumberAcross = {read=GetInteger, write=SetInteger, stored=false, index=1, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRLabelSetup(void) { }
	
};


class PASCALIMPLEMENTATION TQuickLabelReport : public TCustomQuickRep
{
	typedef TCustomQuickRep inherited;
	
private:
	TQRLabelSetup* FLabelSetup;
	
public:
	__fastcall virtual TQuickLabelReport(System::Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TQuickLabelReport(void);
	
__published:
	__property TQRLabelSetup* LabelSetup = {read=FLabelSetup, write=FLabelSetup};
public:
	/* TCustomQuickRep.Create */ inline __fastcall virtual TQuickLabelReport(System::Classes::TComponent* AOwner) : TCustomQuickRep(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQuickLabelReport(HWND ParentWindow) : TCustomQuickRep(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRGroup : public TQRCustomBand
{
	typedef TQRCustomBand inherited;
	
private:
	Qrexpr::TQREvaluator* Evaluator;
	System::UnicodeString FExpression;
	TQRBand* FFooterBand;
	System::Classes::TComponent* FMaster;
	bool FReprint;
	bool FReprintOnNewPage;
	Qrexpr::TQREvResult GroupValue;
	bool HasResult;
	bool InGroup;
	int PrintPageNumber;
	void __fastcall SetFooterBand(TQRBand* Value);
	void __fastcall SetMaster(System::Classes::TComponent* Value);
	
protected:
	__property bool Reprint = {read=FReprint, write=FReprint, nodefault};
	void __fastcall Check(void);
	void __fastcall NewPageCheck(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall Prepare(void);
	void __fastcall PrintGroupHeader(void);
	void __fastcall PrintGroupFooter(void);
	void __fastcall SetExpression(System::UnicodeString Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall Unprepare(void);
	
public:
	__fastcall virtual TQRGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRGroup(void);
	
__published:
	__property System::UnicodeString Expression = {read=FExpression, write=SetExpression};
	__property TQRBand* FooterBand = {read=FFooterBand, write=SetFooterBand};
	__property System::Classes::TComponent* Master = {read=FMaster, write=SetMaster};
	__property bool ReprintOnNewPage = {read=FReprintOnNewPage, write=FReprintOnNewPage, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRGroup(HWND ParentWindow) : TQRCustomBand(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRPrintableSize : public TQRUnitBase
{
	typedef TQRUnitBase inherited;
	
private:
	System::Extended FHeight;
	System::Extended FLeft;
	System::Extended FTop;
	System::Extended FWidth;
	TQRPrintable* Parent;
	System::Extended __fastcall GetValue(int Index);
	void __fastcall SetValue(int Index, System::Extended Value);
	
protected:
	virtual void __fastcall SetParentSizes(void);
	virtual void __fastcall ReadValues(System::Classes::TReader* Reader);
	virtual void __fastcall WriteValues(System::Classes::TWriter* Writer);
	void __fastcall FixZoom(void);
	
public:
	__fastcall TQRPrintableSize(TQRPrintable* AParent);
	
__published:
	__property System::Extended Height = {read=GetValue, write=SetValue, stored=false, index=0};
	__property System::Extended Left = {read=GetValue, write=SetValue, stored=false, index=1};
	__property System::Extended Top = {read=GetValue, write=SetValue, stored=false, index=2};
	__property System::Extended Width = {read=GetValue, write=SetValue, stored=false, index=3};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRPrintableSize(void) { }
	
};


typedef System::TMetaClass* TQRPrintableClass;

typedef System::TMetaClass* TQRPrintableEditorClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRPrintableEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TQRPrintable* FControl;
	
protected:
	virtual System::Uitypes::TColor __fastcall GetColor(void);
	virtual Vcl::Graphics::TFont* __fastcall GetFont(void);
	virtual TQRPrintableClass __fastcall GetPrintableClass(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual System::UnicodeString __fastcall GetGlyphResName(void);
	virtual System::UnicodeString __fastcall GetControlName(void);
	virtual System::Classes::TAlignment __fastcall GetAlignment(void);
	virtual void __fastcall SetAlignment(System::Classes::TAlignment Value);
	virtual void __fastcall SetColor(System::Uitypes::TColor Value) = 0 ;
	virtual void __fastcall SetFont(Vcl::Graphics::TFont* Value) = 0 ;
	virtual void __fastcall SetValue(System::UnicodeString Value) = 0 ;
	
public:
	__fastcall virtual TQRPrintableEditor(TQRPrintable* AControl);
	virtual bool __fastcall ShowEditor(void) = 0 ;
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, nodefault};
	__property TQRPrintable* Control = {read=FControl, write=FControl};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=0};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property TQRPrintableClass PrintableClass = {read=GetPrintableClass};
	__property System::UnicodeString Value = {read=GetValue, write=SetValue};
	__property System::UnicodeString GlyphResName = {read=GetGlyphResName};
	__property System::UnicodeString ControlName = {read=GetControlName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQRPrintableEditor(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRPrintable : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool AlignUpdating;
	System::Classes::TAlignment FAlignment;
	bool FAlignToBand;
	bool ButtonDown;
	TQRFrame* FFrame;
	bool FIsPrinting;
	TCustomQuickRep* FParentReport;
	bool FPrintFinished;
	Qrprntr::TQRPrinter* FQRPrinter;
	TQRPrintableSize* FSize;
	int LoadedTop;
	int LoadedWidth;
	int LoadedHeight;
	int LoadedLeft;
	Qrprntr::TExportType FExportAs;
	int FXLColumn;
	Qrprntr::TXLNumFormat FXLNumFormat;
	System::UnicodeString FParagraphChar;
	System::UnicodeString FParagraphIndent;
	bool __fastcall GetTransparent(void);
	void __fastcall SetTransparent(bool Value);
	int __fastcall GetZoom(void);
	void __fastcall SetAlignToBand(bool Value);
	void __fastcall SetFrame(TQRFrame* Value);
	
protected:
	virtual bool __fastcall IsEnabled(void);
	virtual TQRPrintableEditorClass __fastcall GetEditorClass(void);
	virtual void __fastcall AlignIt(void);
	virtual void __fastcall Loaded(void);
	void __fastcall PaintCorners(void);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetZoom(int Value);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall Print(int OfsX, int OfsY);
	virtual void __fastcall QRNotification(System::TObject* Sender, TQRNotifyOperation Operation);
	virtual void __fastcall SetAlignment(System::Classes::TAlignment Value);
	virtual void __fastcall UnPrepare(void);
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property bool AlignToBand = {read=FAlignToBand, write=SetAlignToBand, nodefault};
	__property bool IsPrinting = {read=FIsPrinting, write=FIsPrinting, nodefault};
	__property bool PrintFinished = {read=FPrintFinished, write=FPrintFinished, nodefault};
	__property Qrprntr::TQRPrinter* QRPrinter = {read=FQRPrinter, write=FQRPrinter};
	__property bool Transparent = {read=GetTransparent, write=SetTransparent, nodefault};
	
public:
	__fastcall virtual TQRPrintable(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPrintable(void);
	virtual void __fastcall GetExpandedHeight(System::Extended &newheight);
	virtual void __fastcall GetFieldString(System::UnicodeString &DataStr);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TCustomQuickRep* ParentReport = {read=FParentReport, write=FParentReport};
	__property int Zoom = {read=GetZoom, write=SetZoom, nodefault};
	__property TQRPrintableEditorClass EditorClass = {read=GetEditorClass};
	__property Qrprntr::TExportType ExportAs = {read=FExportAs, write=FExportAs, nodefault};
	__property System::UnicodeString ParagraphChar = {read=FParagraphChar, write=FParagraphChar};
	__property System::UnicodeString ParagraphIndent = {read=FParagraphIndent, write=FParagraphIndent};
	
__published:
	__property Enabled = {default=1};
	__property TQRFrame* Frame = {read=FFrame, write=SetFrame};
	__property TQRPrintableSize* Size = {read=FSize, write=FSize};
	__property int XLColumn = {read=FXLColumn, write=FXLColumn, nodefault};
	__property Qrprntr::TXLNumFormat XLNumFormat = {read=FXLNumFormat, write=FXLNumFormat, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPrintable(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRCompositeWinControl : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
protected:
	TQRCompositeReport* ParentReport;
	MESSAGE void __fastcall CMPreviewClose(Qrprntr::TCM_QRPreviewClose &Message);
	MESSAGE void __fastcall CMPrint(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual ~TQRCompositeWinControl(void);
public:
	/* TWinControl.Create */ inline __fastcall virtual TQRCompositeWinControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TQRCompositeWinControl(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRCompositeReport : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Classes::TNotifyEvent FOnAddReports;
	System::Classes::TNotifyEvent FOnFinished;
	TCompositeEvent FOnStartReport;
	TQuickReportOptions FOptions;
	TQRCompositePrinterSettings* FPrinterSettings;
	Qrprntr::TQRPrinter* FQRPrinter;
	System::Classes::TList* FReports;
	int FIndex;
	int FCurrReport;
	System::UnicodeString FReportTitle;
	bool FGenerating;
	int FPagecount;
	TQuickRep* aReport;
	TQRCompositeWinControl* aWinControl;
	void __fastcall CreateComposite(void);
	void __fastcall SetPrinterValues(void);
	
protected:
	void __fastcall CMPreviewClose(Qrprntr::TCM_QRPreviewClose &Message);
	void __fastcall CMPrint(Winapi::Messages::TMessage &Message);
	__property bool Generating = {read=FGenerating, nodefault};
	
public:
	__fastcall virtual TQRCompositeReport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCompositeReport(void);
	void __fastcall Prepare(void);
	void __fastcall ExportToFilter(Qrprntr::TQRExportFilter* AFilter);
	void __fastcall PrinterSetup(void);
	void __fastcall Preview(void);
	void __fastcall PreviewXML(void);
	void __fastcall Print(void);
	__property int Index = {read=FIndex, nodefault};
	__property System::Classes::TList* Reports = {read=FReports, write=FReports};
	__property Qrprntr::TQRPrinter* QRPrinter = {read=FQRPrinter};
	
__published:
	__property System::Classes::TNotifyEvent OnAddReports = {read=FOnAddReports, write=FOnAddReports};
	__property TCompositeEvent OnStartReport = {read=FOnStartReport, write=FOnStartReport};
	__property System::Classes::TNotifyEvent OnFinished = {read=FOnFinished, write=FOnFinished};
	__property TQuickReportOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property TQRCompositePrinterSettings* PrinterSettings = {read=FPrinterSettings, write=FPrinterSettings};
	__property System::UnicodeString ReportTitle = {read=FReportTitle, write=FReportTitle};
	__property int PageCount = {read=FPagecount, write=FPagecount, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Extended debugext;
extern DELPHI_PACKAGE bool PrintMetafileFromPreview;
extern DELPHI_PACKAGE int CompPageCount;
extern DELPHI_PACKAGE System::UnicodeString __fastcall UniqueName(System::Classes::TComponent* AComponent, System::UnicodeString Start);
extern DELPHI_PACKAGE void __fastcall SetQRHiColor(void);
extern DELPHI_PACKAGE void __fastcall SetQRLoColor(void);
}	/* namespace Quickrpt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QUICKRPT)
using namespace Quickrpt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QuickrptHPP
