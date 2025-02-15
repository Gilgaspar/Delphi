// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxIOTransportIntDialog.pas' rev: 32.00 (Windows)

#ifndef FrxiotransportintdialogHPP
#define FrxiotransportintdialogHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxiotransportintdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxIOTransportDialogIntForm;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TDirChangeEvent)(System::UnicodeString Name, System::UnicodeString Id, System::Classes::TStrings* DirItems);

typedef void __fastcall (__closure *TDirCreateEvent)(System::UnicodeString Name, System::Classes::TStrings* DirItems);

typedef TDirChangeEvent TDirDeleteEvent;

typedef TDirChangeEvent TFileDeleteEvent;

enum DECLSPEC_DENUM TfrxIOInternetDialogMode : unsigned char { idmOpen, idmSave, idmDir };

class PASCALIMPLEMENTATION TfrxIOTransportDialogIntForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TEdit* FileNameEdit;
	Vcl::Stdctrls::TLabel* FileNameLabel;
	Vcl::Stdctrls::TButton* CreateDirectoryButton;
	Vcl::Stdctrls::TButton* DeleteButton;
	Vcl::Comctrls::TListView* DirectoryLV;
	Vcl::Buttons::TSpeedButton* ListSB;
	Vcl::Buttons::TSpeedButton* IconsSB;
	Vcl::Extctrls::TTimer* FillTimer;
	Vcl::Extctrls::TPanel* UpdateP;
	Vcl::Stdctrls::TLabel* UpdateL;
	Vcl::Buttons::TSpeedButton* RefreshSB;
	void __fastcall DirectoryListBoxDblClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	System::UnicodeString __fastcall GetFileName(void);
	void __fastcall CreateDirectoryButtonClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall DeleteButtonClick(System::TObject* Sender);
	void __fastcall IconsSBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FillTimerTimer(System::TObject* Sender);
	void __fastcall DirectoryLVClick(System::TObject* Sender);
	
private:
	System::Classes::TStrings* FItemsList;
	TDirChangeEvent FOnDirChange;
	TDirCreateEvent FOnDirCreate;
	TDirChangeEvent FOnDirDelete;
	TDirChangeEvent FOnFileDelete;
	TfrxIOInternetDialogMode FDialogMode;
	System::Classes::TComponent* FIOTransport;
	System::Classes::TStrings* __fastcall GetItems(void);
	void __fastcall UpdateListView(void);
	void __fastcall SetFileName(const System::UnicodeString Value);
	bool __fastcall IsConfirm(const System::UnicodeString Text);
	void __fastcall ListChanged(System::TObject* Sender);
	void __fastcall StartUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SetDialogMode(const TfrxIOInternetDialogMode Value);
	
protected:
	bool __fastcall IsDirectory(int Index);
	bool __fastcall IsFile(int Index);
	System::UnicodeString __fastcall StripDir(int Index);
	System::UnicodeString __fastcall IdOf(int Index);
	
public:
	__classmethod System::UnicodeString __fastcall AsFile(System::UnicodeString fName);
	__classmethod System::UnicodeString __fastcall AsDirectory(System::UnicodeString fName);
	void __fastcall DisableDelete(void);
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property TDirChangeEvent OnDirChange = {read=FOnDirChange, write=FOnDirChange};
	__property TDirCreateEvent OnDirCreate = {read=FOnDirCreate, write=FOnDirCreate};
	__property TDirChangeEvent OnDirDelete = {read=FOnDirDelete, write=FOnDirDelete};
	__property TDirChangeEvent OnFileDelete = {read=FOnFileDelete, write=FOnFileDelete};
	__property System::Classes::TStrings* DirItems = {read=GetItems};
	__property TfrxIOInternetDialogMode DialogMode = {read=FDialogMode, write=SetDialogMode, nodefault};
	__property System::UnicodeString DialogFileName = {read=GetFileName, write=SetFileName};
	__property System::Classes::TComponent* IOTransport = {read=FIOTransport, write=FIOTransport};
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxIOTransportDialogIntForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxIOTransportDialogIntForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxIOTransportDialogIntForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxIOTransportDialogIntForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxiotransportintdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXIOTRANSPORTINTDIALOG)
using namespace Frxiotransportintdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxiotransportintdialogHPP
