//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "RPBase.hpp"
#include "RPDefine.hpp"
#include "RPRave.hpp"
#include "RPSystem.hpp"
#include "RVCsBars.hpp"
#include "RpRave.hpp"
#include <RpBase.hpp>
#include <RpDefine.hpp>
#include <RpSystem.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TListBox *ReportLB;
  TMemo *DescMemo;
  TLabel *Label2;
	TRvSystem *RvSystem1;
	TRvProject *RaveProject;
  TButton *Button1;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall ReportLBClick(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
