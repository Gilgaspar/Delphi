// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QREnvEd.pas' rev: 32.00 (Windows)

#ifndef QrenvedHPP
#define QrenvedHPP

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
#include <QRExpr.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <qr5const.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrenved
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQREnvironmentEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQREnvironmentEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* VariableOKBtn;
	Vcl::Stdctrls::TGroupBox* AvailableGB;
	Vcl::Grids::TStringGrid* UDFGrid;
	Vcl::Stdctrls::TButton* DeleteBtn;
	Vcl::Stdctrls::TButton* EditBtn;
	Vcl::Stdctrls::TButton* AddBtn;
	Vcl::Stdctrls::TRadioButton* LocalCB;
	Vcl::Stdctrls::TRadioButton* GlobalCB;
	Vcl::Stdctrls::TGroupBox* NewEntryGB;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Name;
	Vcl::Stdctrls::TEdit* Expression;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TButton* NewOKBtn;
	Vcl::Stdctrls::TButton* NewCancelBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UDFGridSetEditText(System::TObject* Sender, int ACol, int ARow, const System::UnicodeString Value);
	void __fastcall EditBtnClick(System::TObject* Sender);
	void __fastcall LocalCBClick(System::TObject* Sender);
	void __fastcall VariableOKBtnClick(System::TObject* Sender);
	void __fastcall NewOKBtnClick(System::TObject* Sender);
	void __fastcall NewCancelBtnClick(System::TObject* Sender);
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
private:
	bool CloseDialog;
	int NewResult;
	Qrexpr::TQREvEnvironment* FEnvironment;
	Qrexpr::TQREvEnvironment* __fastcall WorkEnvironment(void);
	bool __fastcall GetNew(System::UnicodeString &AName, System::UnicodeString &AExpr);
	
public:
	void __fastcall PopulateGrid(void);
	__property Qrexpr::TQREvEnvironment* Environment = {read=FEnvironment, write=FEnvironment};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQREnvironmentEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQREnvironmentEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQREnvironmentEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQREnvironmentEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall EditEnvironment(Qrexpr::TQREvEnvironment* AEnvironment, bool AllowGlobalEnv, Vcl::Controls::TWinControl* ParentControl);
}	/* namespace Qrenved */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRENVED)
using namespace Qrenved;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrenvedHPP
