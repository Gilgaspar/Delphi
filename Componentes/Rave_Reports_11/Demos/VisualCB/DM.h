//---------------------------------------------------------------------------
#ifndef DMH
#define DMH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "RPCon.hpp"
#include "RPConBDE.hpp"
#include "RPConDS.hpp"
#include "RPDefine.hpp"
#include <Db.hpp>
#include <DBTables.hpp>
#include <DB.hpp>
#include <RpCon.hpp>
#include <RpConBDE.hpp>
#include <RpConDS.hpp>
#include <RpDefine.hpp>
//---------------------------------------------------------------------------
class TDataModule1 : public TDataModule
{
__published:	// IDE-managed Components
  TTable *CustomerTable;
  TTable *OrdersTable;
  TQuery *CustrOrdQuery;
  TTable *ClientsTable;
  TTable *PartsTable;
  TTable *BioLifeTable;
  TTable *MasterTable;
	TRvTableConnection *MasterCXN;
	TRvTableConnection *BioLifeCXN;
	TRvTableConnection *PartsCXN;
	TRvTableConnection *ClientsCXN;
	TRvQueryConnection *CustOrdCXN;
	TRvTableConnection *OrdersCXN;
	TRvTableConnection *CustomerCXN;
  TTable *ItemsTable;
  TFloatField *ItemsTableOrderNo;
  TFloatField *ItemsTableItemNo;
  TFloatField *ItemsTablePartNo;
  TIntegerField *ItemsTableQty;
  TFloatField *ItemsTableDiscount;
  TCurrencyField *ItemsTableListPrice;
  TCurrencyField *ItemsTableTotalPrice;
  TTable *VendorsTable;
	TRvTableConnection *ItemsCXN;
	TRvTableConnection *VendorsCXN;
	TRvCustomConnection *CustomCXN;
	TRvCustomConnection *CustomMasterCXN;
	TRvCustomConnection *CustomDetail1CXN;
	TRvCustomConnection *CustomDetail2CXN;
  void __fastcall CustomCXNEOF(TRvCustomConnection *Connection, bool &Eof);
  void __fastcall CustomCXNGetCols(TRvCustomConnection *Connection);
  void __fastcall CustomCXNGetRow(TRvCustomConnection *Connection);
  void __fastcall ItemsTableCalcFields(TDataSet *DataSet);
  void __fastcall CustomMasterCXNGetCols(TRvCustomConnection *Connection);
  void __fastcall CustomMasterCXNGetRow(TRvCustomConnection *Connection);
  void __fastcall CustomMasterCXNOpen(TRvCustomConnection *Connection);
  void __fastcall CustomDetail1CXNGetCols(TRvCustomConnection *Connection);
  void __fastcall CustomDetail1CXNGetRow(TRvCustomConnection *Connection);
  void __fastcall CustomDetail1CXNOpen(TRvCustomConnection *Connection);
  void __fastcall CustomDetail2CXNGetCols(TRvCustomConnection *Connection);
  void __fastcall CustomDetail2CXNGetRow(TRvCustomConnection *Connection);
  void __fastcall CustomDetail2CXNOpen(TRvCustomConnection *Connection);
private:	// User declarations
public:		// User declarations
  __fastcall TDataModule1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDataModule1 *DataModule1;
//---------------------------------------------------------------------------
#endif
