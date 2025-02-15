// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'qrpBaseCtrls.pas' rev: 30.00 (Windows)

#ifndef QrpbasectrlsHPP
#define QrpbasectrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <QRCtrls.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrpbasectrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLabelSettings;
class DELPHICLASS TQRPQuickrep;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLabelSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int fFirstLabel;
	int fLabelCount;
	
__published:
	__property int FirstLabel = {read=fFirstLabel, write=fFirstLabel, nodefault};
	__property int LabelCount = {read=fLabelCount, write=fLabelCount, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLabelSettings(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLabelSettings(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRPQuickrep : public Quickrpt::TQuickRep
{
	typedef Quickrpt::TQuickRep inherited;
	
private:
	TLabelSettings* FLabelSettings;
	bool FPrepareAutomatically;
	bool BandsHidden;
	
protected:
	bool ReportPrintPrepared;
	Quickrpt::TQRCustomBand* SkipLabelsBand1;
	Quickrpt::TQRChildBand* SkipLabelsBand2;
	Quickrpt::TQRChildBand* SkipLabelsBand3;
	
public:
	Quickrpt::TQRCustomBand* DetailBand;
	int TotalPageCount;
	__fastcall virtual TQRPQuickrep(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPQuickrep(void);
	HIDESBASE void __fastcall Print(void);
	HIDESBASE void __fastcall Preview(void);
	HIDESBASE void __fastcall Prepare(void);
	HIDESBASE void __fastcall PrintBackground(void);
	HIDESBASE void __fastcall ExportToFilter(Qrprntr::TQRExportFilter* AFilter);
	HIDESBASE void __fastcall PreviewModal(void);
	HIDESBASE void __fastcall PreviewModeless(void);
	virtual bool __fastcall PrepareReportPrint(void);
	virtual void __fastcall DoneReportPrint(void);
	
__published:
	__property TLabelSettings* LabelSettings = {read=FLabelSettings, write=FLabelSettings};
	__property bool PrepareAutomatically = {read=FPrepareAutomatically, write=FPrepareAutomatically, nodefault};
public:
	/* TQuickRep.CreateNew */ inline __fastcall virtual TQRPQuickrep(System::Classes::TComponent* AOwner, int Dummy) : Quickrpt::TQuickRep(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPQuickrep(HWND ParentWindow) : Quickrpt::TQuickRep(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Qrpbasectrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPBASECTRLS)
using namespace Qrpbasectrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrpbasectrlsHPP
