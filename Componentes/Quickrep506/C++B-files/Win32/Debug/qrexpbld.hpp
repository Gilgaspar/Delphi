// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRExpBld.pas' rev: 32.00 (Windows)

#ifndef QrexpbldHPP
#define QrexpbldHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <QRExpr.hpp>
#include <qr5const.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrexpbld
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRExpressionBuilder;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRExpressionBuilder : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* MainPage;
	Vcl::Extctrls::TPanel* DataFieldPage;
	Vcl::Extctrls::TPanel* FunctionPage;
	Vcl::Extctrls::TPanel* FuncParamsPage;
	Vcl::Stdctrls::TLabel* Heading;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* InsertDataFieldBtn;
	Vcl::Stdctrls::TButton* InsertFunctionBtn;
	Vcl::Stdctrls::TButton* InsertVariableBtn;
	Vcl::Stdctrls::TButton* AddPlus;
	Vcl::Stdctrls::TButton* AddMinus;
	Vcl::Stdctrls::TButton* AddMul;
	Vcl::Stdctrls::TButton* AddDiv;
	Vcl::Stdctrls::TButton* AddEqual;
	Vcl::Stdctrls::TButton* AddSmaller;
	Vcl::Stdctrls::TButton* AddLarger;
	Vcl::Stdctrls::TButton* AddNotEqual;
	Vcl::Stdctrls::TButton* AddLessEqual;
	Vcl::Stdctrls::TButton* AddGreaterEqual;
	Vcl::Stdctrls::TButton* AddNot;
	Vcl::Stdctrls::TButton* AddAnd;
	Vcl::Stdctrls::TButton* AddOr;
	Vcl::Stdctrls::TButton* ValidateBtn;
	Vcl::Stdctrls::TButton* Clear;
	Vcl::Stdctrls::TButton* OK;
	Vcl::Stdctrls::TButton* Cancel;
	Vcl::Stdctrls::TButton* DataFieldOKBtn;
	Vcl::Stdctrls::TButton* DataFieldCancelBtn;
	Vcl::Stdctrls::TGroupBox* DataFieldGB;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TComboBox* DataSet;
	Vcl::Stdctrls::TListBox* DataField;
	Vcl::Stdctrls::TButton* FunctionOKBtn;
	Vcl::Stdctrls::TButton* FunctionCancelBtn;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TListBox* AvailableFields;
	Vcl::Stdctrls::TGroupBox* GroupBox4;
	Vcl::Stdctrls::TListBox* Categories;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TListBox* AvailableFunc;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* FuncName;
	Vcl::Stdctrls::TLabel* FuncDescription;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TLabel* CopyFuncName;
	Vcl::Stdctrls::TLabel* CopyFuncDescription;
	Vcl::Forms::TScrollBox* FuncParamSB;
	Vcl::Stdctrls::TButton* FuncParamOkBtn;
	Vcl::Stdctrls::TButton* FuncArgCancelBtn;
	Vcl::Stdctrls::TListBox* AvailableDatasets;
	Vcl::Extctrls::TPanel* VariablePage;
	Vcl::Stdctrls::TGroupBox* GroupBox5;
	Vcl::Stdctrls::TButton* VariableOKBtn;
	Vcl::Stdctrls::TButton* VariableCancelBtn;
	Vcl::Stdctrls::TListBox* AvailableVariables;
	Vcl::Stdctrls::TLabel* VariableValue;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TButton* ModifyVariables;
	Vcl::Extctrls::TPanel* TopPanel;
	Vcl::Extctrls::TImage* TopImage;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Extctrls::TShape* Shape1;
	void __fastcall InsertDataFieldBtnClick(System::TObject* Sender);
	void __fastcall DataFieldCancelBtnClick(System::TObject* Sender);
	void __fastcall DataFieldOKBtnClick(System::TObject* Sender);
	void __fastcall FunctionOKBtnClick(System::TObject* Sender);
	void __fastcall CategoriesClick(System::TObject* Sender);
	void __fastcall AvailableFuncClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall InsertFunctionBtnClick(System::TObject* Sender);
	void __fastcall FuncParamOkBtnClick(System::TObject* Sender);
	void __fastcall FuncArgCancelBtnClick(System::TObject* Sender);
	void __fastcall FunctionCancelBtnClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall AddSomeClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall AvailableDatasetsClick(System::TObject* Sender);
	void __fastcall OKClick(System::TObject* Sender);
	void __fastcall CancelClick(System::TObject* Sender);
	void __fastcall ClearClick(System::TObject* Sender);
	void __fastcall ValidateBtnClick(System::TObject* Sender);
	void __fastcall InsertVariableBtnClick(System::TObject* Sender);
	void __fastcall VariableOKBtnClick(System::TObject* Sender);
	void __fastcall VariableCancelBtnClick(System::TObject* Sender);
	void __fastcall AvailableVariablesClick(System::TObject* Sender);
	void __fastcall ModifyVariablesClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	
private:
	Vcl::Stdctrls::TEdit* Expr;
	int FFuncParamsResult;
	int FFuncResult;
	int FDatafieldResult;
	int FExprResult;
	Vcl::Forms::TCustomForm* FDatasetForm;
	int FVariableResult;
	Qrexpr::TQREvEnvironment* FLocalEnvironment;
	void __fastcall GetParamExprClick(System::TObject* Sender);
	void __fastcall GetFunctionsCat(int Index);
	void __fastcall SelectFunc(int Index);
	void __fastcall InsertText(System::UnicodeString AText);
	void __fastcall PickDataSets(void);
	void __fastcall PickVariables(void);
	bool __fastcall GetParams(System::UnicodeString ParamList, System::UnicodeString &ParamResult);
	bool __fastcall GetFunc(System::UnicodeString &Func);
	bool __fastcall GetDatafield(System::UnicodeString &Field);
	bool __fastcall GetVariable(System::UnicodeString &Variable);
	
public:
	bool Cancelled;
	__property Vcl::Forms::TCustomForm* DatasetForm = {read=FDatasetForm, write=FDatasetForm};
	__property Qrexpr::TQREvEnvironment* LocalEnvironment = {read=FLocalEnvironment, write=FLocalEnvironment};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TQRExpressionBuilder(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TQRExpressionBuilder(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TQRExpressionBuilder(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRExpressionBuilder(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall GetExpression(System::UnicodeString ACaption, System::UnicodeString &Value, Vcl::Forms::TCustomForm* ADataSetForm, Vcl::Controls::TWinControl* AParentControl, Qrexpr::TQREvEnvironment* ALocalEnvironment);
}	/* namespace Qrexpbld */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QREXPBLD)
using namespace Qrexpbld;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrexpbldHPP
