// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditReportData.pas' rev: 32.00 (Windows)

#ifndef FrxeditreportdataHPP
#define FrxeditreportdataHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <frxClass.hpp>
#include <Vcl.CheckLst.hpp>
#include <frxBaseForm.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxeditreportdata
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxReportDataForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxReportDataForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OKB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Checklst::TCheckListBox* DatasetsLB;
	Vcl::Stdctrls::TCheckBox* SelAllCB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall DatasetsLBClickCheck(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SelAllCBClick(System::TObject* Sender);
	
private:
	bool FStandalone;
	void __fastcall BuildConnectionList(void);
	void __fastcall BuildDatasetList(void);
	void __fastcall UpdateCBState(void);
	
public:
	Frxclass::TfrxReport* Report;
	virtual void __fastcall UpdateResouces(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxReportDataForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxReportDataForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxReportDataForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxReportDataForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditreportdata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITREPORTDATA)
using namespace Frxeditreportdata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditreportdataHPP
