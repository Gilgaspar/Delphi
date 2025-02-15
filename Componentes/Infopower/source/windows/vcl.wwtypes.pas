{
//
// Components : InfoPower types
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit vcl.wwtypes;

interface
{$i wwIfDef.pas}

  uses classes, db, forms, stdctrls;

const wwNewLineString='<New Line>';

  CmpLess = -1;
  CMPEql = 0;
  CmpGtr = 1;
  CMPKeyEql = 2;
  wwSLookupSourceError = 'Unable to use duplicate DataSource and LookupSource';
  wwSLookupTableError = 'LookupSource must be connected to a TDataSet component';
type
  TwwProcMeth = procedure of object;
  TwwBoolFunc = function: Boolean of object;

  TwwInvalidValueEvent = Procedure(DataSet: TDataSet; Field: TField) of object;
  TwwFilterFieldMethod =  Function(AFieldName: string): TParam of object;
  TwwDataSetFilterEvent = Procedure(table: TDataSet; var Accept: boolean) of object;
  TwwPerformSearchEvent = procedure(Sender: TObject;
     LookupTable: TDataSet;
     SearchField: string;
     SearchValue: string;
     PerformLookup: boolean;
     var Found: boolean) of object;
  TwwGetWordOption = (wwgwSkipLeadingBlanks, wwgwQuotesAsWords, wwgwStripQuotes,
                      wwgwSpacesInWords);

  // 1/22/13 - added wtoGridSelected
  TwwWriteTextOption = (wtoAmpersandToUnderline, wtoEllipsis, wtoWordWrap,
                        wtoMergeCanvas, wtoTransparent, wtoCenterVert, wtoIsTitle,
                        wtoDisableThemes, wtoDisabledText, wtoGridSelected);
//                        ,
//                        wtoRightToLeft);

  TwwWriteTextOptions = Set of TwwWriteTextOption;
  TwwGetWordOptions = set of TwwGetWordOption;  {pwe}
  TwwEditAlignment = (eaLeftAlignEditing, eaRightAlignEditing);

  TwwFormPosition = class(TPersistent)
  private
     FLeft, FTop: integer;
     FWidth, FHeight: integer;
  published
     property Left: integer read FLeft write FLeft;
     property Top: integer read FTop write FTop;
     property Width: integer read FWidth write FWidth;
     property Height: integer read FHeight write FHeight;
  end;

  TwwCheatCastNotify = class(TComponent)
  public
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  end;

  TwwCheatCastKeyDown = class(TCustomEdit)
  public
    procedure KeyDown(var key: word; shift: TShiftState); override;
  end;

  TwwOnFilterOption = (ofoEnabled, ofoShowHourGlass, ofoCancelOnEscape);
  TwwOnFilterOptions = set of TwwOnFilterOption;
{
  TwwInternalOperation = class(TComponent)
  public
     Operation: string;
     NumValues: integer;
     Object1: TObject;
     Value: Variant;
     Value2: Variant;
     Value3: Variant;
     Value4: Variant;
     Value5: Variant;
     OperResult: Variant;
     constructor Create;
  end;

  IwwInternalOperation = interface
     procedure SetOperation(AOperation: TwwInternalOperation);
  end;
}

  function wwFilterMemoSize: integer;

implementation

uses wwintl;

function wwFilterMemoSize: integer;
begin
   result:= wwInternational.FilterMemoSize;
end;

procedure TwwCheatCastNotify.Notification(AComponent: TComponent;
      Operation: TOperation);
begin
   inherited Notification(AComponent, Operation);
end;

procedure TwwCheatCastKeyDown.KeyDown(var key: word; shift: TShiftState);
begin
   inherited KeyDown(Key, shift);
end;

end.
