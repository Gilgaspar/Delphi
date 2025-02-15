{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RvWzExpertTests;

interface

uses
  RvClass,
  RvToolUtil,
  RvWzExpert;

type
  TBandControllerBandNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TBandControllerBandNotAssignedTest }

  TBandGroupKeySetOnNonGroupBandTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TBandGroupKeySetOnNonGroupBandTest }

  TDataBandDataViewNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataBandDataViewNotAssignedTest }

  TDataBandSetToHeaderFooterTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataBandSetToHeaderFooterTest }

  TDriverDataViewDatabaseNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDriverDataViewDatabaseNotAssignedTest }

  TDataTextDataFieldNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataTextDataFieldNotAssignedTest }

  TDataTextOutsideParentBoundsTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataTextOutsideParentBoundsTest }

  TRaveTextColorWhiteTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TRaveTextColorWhiteTest }

  TLookupDataViewWithNoDataViewTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TLookupDataViewWithNoDataViewTest }

  TLookupDataViewWithNoLookupFieldTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TLookupDataViewWithNoLookupFieldTest }

  TLookupDataViewWithNoLookupDisplayTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TLookupDataViewWithNoLookupDisplayTest }

  TLookupInvalidTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TLookupInvalidTest }

  TDataCycleDataViewNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataCycleDataViewNotAssignedTest }

  TDataCycleMasterKeyNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataCycleMasterKeyNotAssignedTest }

  TDataCycleDetailKeyNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataCycleDetailKeyNotAssignedTest }

  TLineColorWhiteTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TLineColorWhiteTest }

  TEllipseColorWhiteTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TEllipseColorWhiteTest }

  TRectangleColorWhiteTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TRectangleColorWhiteTest }

  TDataMirrorSectionNoDataviewTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataMirrorSectionNoDataviewTest }

  TDataMirrorSectionDataFieldNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataMirrorSectionDataFieldNotAssignedTest }

  TDataMirrorSectionDataMirrorsNotAssignedTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataMirrorSectionDataMirrorsNotAssignedTest }

  TDataMirrorSectionNoDefaultDataMirrorTest = class(TReportExpertTest)
  protected
    function GetID: string; override;
    function GetDescription: string; override;
  public
    constructor Create; override;
    procedure Test; override;
  end; { TDataMirrorSectionNoDefaultDataMirrorTest }

  procedure RaveRegister;

implementation

uses
  Classes,
  SysUtils,
  Graphics,
  RvCsData,
  RvCsRpt,
  RvCsStd,
  RvCsDraw,
  RvDriverDataView;

procedure RaveRegister;
begin
  RegisterTest(TBandControllerBandNotAssignedTest);
  RegisterTest(TBandGroupKeySetOnNonGroupBandTest);
  RegisterTest(TDataBandDataViewNotAssignedTest);
  RegisterTest(TDataBandSetToHeaderFooterTest);
  RegisterTest(TDriverDataViewDatabaseNotAssignedTest);
  RegisterTest(TDataTextDataFieldNotAssignedTest);
  RegisterTest(TDataTextOutsideParentBoundsTest);
  RegisterTest(TRaveTextColorWhiteTest);
  RegisterTest(TLookupDataViewWithNoDataViewTest);
  RegisterTest(TLookupDataViewWithNoLookupFieldTest);
  RegisterTest(TLookupDataViewWithNoLookupDisplayTest);
  RegisterTest(TLookupInvalidTest);
  RegisterTest(TDataCycleDataViewNotAssignedTest);
  RegisterTest(TDataCycleMasterKeyNotAssignedTest);
  RegisterTest(TDataCycleDetailKeyNotAssignedTest);
  RegisterTest(TLineColorWhiteTest);
  RegisterTest(TEllipseColorWhiteTest);
  RegisterTest(TRectangleColorWhiteTest);
  RegisterTest(TDataMirrorSectionNoDataviewTest);
  RegisterTest(TDataMirrorSectionDataFieldNotAssignedTest);
  RegisterTest(TDataMirrorSectionDataMirrorsNotAssignedTest);
  RegisterTest(TDataMirrorSectionNoDefaultDataMirrorTest);
end;

{ TControllerBandNotAssignedTest }

constructor TBandControllerBandNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

procedure TBandControllerBandNotAssignedTest.Test;
var
  Band: TRaveBand;
  TI: TReportExpertTestInfo;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveBand) do begin
      Band := GetComp(1) as TRaveBand;
      TI := CreateComponent(Band);
      if not TI.Ignored then begin
        if (Band.ControllerBand = nil) and
         (Band.BandStyle.PrintLoc <> []) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
          Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

function TBandControllerBandNotAssignedTest.GetDescription: string;
begin
  Result := 'ControllerBand property not assigned.  ';
  Result := Result + 'Band will only print once as a master level band.'
end;

function TBandControllerBandNotAssignedTest.GetID: string;
begin
  Result := '{B6A69C2A-CEF7-4766-93D8-DD8BE25380FD}';
end;

{ TBandGroupKeySetOnNonGroupBandTest }

constructor TBandGroupKeySetOnNonGroupBandTest.Create;
begin
  inherited;
  MessageType := mtHint;
end;

function TBandGroupKeySetOnNonGroupBandTest.GetDescription: string;
begin
  Result := 'GroupKey or GroupDataView properties are set on a non-group band.';
end;

function TBandGroupKeySetOnNonGroupBandTest.GetID: string;
begin
  Result := '{C23580BB-F4CE-4132-A45F-0CE6FD0E8A39}';
end;

procedure TBandGroupKeySetOnNonGroupBandTest.Test;
var
  Band: TRaveBand;
  TI: TReportExpertTestInfo;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveBand) do begin
      Band := GetComp(1) as TRaveBand;
      TI := CreateComponent(Band);
      if not TI.Ignored then begin
        if ((Band.GroupKey <> '') or (Band.GroupDataView <> nil)) and
         not ((plGroupHeader in Band.BandStyle.PrintLoc) or (plGroupFooter in Band.BandStyle.PrintLoc)) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataBandDataViewNotAssignedTest }

constructor TDataBandDataViewNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDataBandDataViewNotAssignedTest.GetDescription: string;
begin
  Result := 'DataView property is not assigned.  Databand will not print.';
end;

function TDataBandDataViewNotAssignedTest.GetID: string;
begin
  Result := '{33C480C2-B73F-4281-B6E4-146F3528CE10}';
end;

procedure TDataBandDataViewNotAssignedTest.Test;
var
  DataBand: TRaveDataBand;
  TI: TReportExpertTestInfo;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataBand) do begin
      DataBand := GetComp(1) as TRaveDataBand;
      TI := CreateComponent(DataBand);
      if not TI.Ignored then begin
        if Databand.DataView = nil then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end;
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataBandSetToHeaderFooterTest }

constructor TDataBandSetToHeaderFooterTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TDataBandSetToHeaderFooterTest.GetDescription: string;
begin
  Result := 'BandStyles are set to header or footer values.  ';
  Result := Result + 'Databands should not be headers or footers.'
end;

function TDataBandSetToHeaderFooterTest.GetID: string;
begin
  Result := '{0D6055C8-E0A3-4738-A963-C5E7EC5DD009}';
end;

procedure TDataBandSetToHeaderFooterTest.Test;
var
  TI: TReportExpertTestInfo;
  DataBand: TRaveDataBand;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataBand) do begin
      DataBand := GetComp(1) as TRaveDataBand;
      TI := CreateComponent(DataBand);
      if not TI.Ignored then begin
        if (DataBand.BandStyle.PrintLoc <> [])
         and (DataBand.BandStyle.PrintLoc <> [plDetail]) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDriverDataViewDatabaseNotAssignedTest }

constructor TDriverDataViewDatabaseNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDriverDataViewDatabaseNotAssignedTest.GetDescription: string;
begin
  Result := 'Database property is not assigned.  ';
  Result := Result + 'DriverDataView will not connect.';
end;

function TDriverDataViewDatabaseNotAssignedTest.GetID: string;
begin
  Result := '{2C8A15CA-3F4D-4B90-BE4F-C9B338121A14}';
end;

procedure TDriverDataViewDatabaseNotAssignedTest.Test;
var
  TI: TReportExpertTestInfo;
  DriverDataView: TRaveDriverDataView;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDriverDataView) do begin
      DriverDataView := GetComp(1) as TRaveDriverDataView;
      TI := CreateComponent(DriverDataView);
      if not TI.Ignored then begin
        if DriverDataView.Database = nil then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataTextDataFieldNotAssignedTest }

constructor TDataTextDataFieldNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDataTextDataFieldNotAssignedTest.GetDescription: string;
begin
  Result := 'DataField property is not assigned.  DataText will not print.';
end;

function TDataTextDataFieldNotAssignedTest.GetID: string;
begin
  Result := '{60AC2B7E-0ECE-4C36-B26E-1972010A79CC}';
end;

procedure TDataTextDataFieldNotAssignedTest.Test;
var
  TI: TReportExpertTestInfo;
  DataText: TRaveDataText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataText) do begin
      DataText := GetComp(1) as TRaveDataText;
      TI := CreateComponent(DataText);
      if not TI.Ignored then begin
        if (DataText.DataField = '') and
         (DataText.Visible = true) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataTextOutsideParentBoundsTest }

constructor TDataTextOutsideParentBoundsTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TDataTextOutsideParentBoundsTest.GetDescription: string;
begin
  Result := 'DataText is outside its parent bounds.  DataText may not show or may cause report run-ons.';
end;

function TDataTextOutsideParentBoundsTest.GetID: string;
begin
  Result := '{0837230C-FFBA-4764-B8B6-C216102B3885}';
end;

procedure TDataTextOutsideParentBoundsTest.Test;
var
  TI: TReportExpertTestInfo;
  DataText: TRaveDataText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataText) do begin
      DataText := GetComp(1) as TRaveDataText;
      TI := CreateComponent(DataText);
      if not TI.Ignored then begin
        if DataText.Visible then begin
          if DataText.Left < 0 then begin // Check Left Position
            Add(TI, FormReportExpert.ReportItems);
          end else if DataText.Top < 0 then begin // Check Top Position
            Add(TI, FormReportExpert.ReportItems);
          end else if DataText.Parent is TRavePage then begin // Check Right Position
            if DataText.Right > TRavePage(DataText.Parent).PageWidth then begin
              Add(TI, FormReportExpert.ReportItems);
            end else if DataText.Bottom + DataText.Height > TRavePage(DataText.Parent).PageHeight then begin
              Add(TI, FormReportExpert.ReportItems);
            end;
          end else if DataText.Parent is TRaveBand then begin // Check Bottom Position
            if DataText.Bottom > TRaveBand(DataText.Parent).Height then begin
              Add(TI, FormReportExpert.ReportItems);
            end;
            if DataText.Right > TRaveBand(DataText.Parent).Width then begin
              Add(TI, FormReportExpert.ReportItems);
            end;
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TTextColorWhiteTest }

constructor TRaveTextColorWhiteTest.Create;
begin
  inherited;
  MessageType := mtHint;
end;

function TRaveTextColorWhiteTest.GetDescription: string;
begin
  Result := 'Text color is set to white.  Text may not be shown.';
end;

function TRaveTextColorWhiteTest.GetID: string;
begin
  Result := '{7337FEC1-7337-4466-BABF-956700C0DA82}';
end;

procedure TRaveTextColorWhiteTest.Test;
var
  TI: TReportExpertTestInfo;
  RaveText: TRaveText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveText) do begin
      RaveText := GetComp(1) as TRaveText;
      TI := CreateComponent(RaveText);
      if not TI.Ignored then begin
        if RaveText.Visible then begin
          if RaveText.Font.Color = clWhite then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TLookupDataViewWithNoDataViewTest }

constructor TLookupDataViewWithNoDataViewTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TLookupDataViewWithNoDataViewTest.GetDescription: string;
begin
  Result := 'Lookup Dataview set but DataView is not.  Lookup may not succeed.';
end;

function TLookupDataViewWithNoDataViewTest.GetID: string;
begin
  Result := '{7FA6BB62-CB00-41F0-8B2F-309D2A06DF97}';
end;

procedure TLookupDataViewWithNoDataViewTest.Test;
var
  TI: TReportExpertTestInfo;
  DataText: TRaveDataText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataText) do begin
      DataText := GetComp(1) as TRaveDataText;
      TI := CreateComponent(DataText);
      if not TI.Ignored then begin
        if DataText.Visible then begin
          if Assigned(DataText.LookupDataView) and (not Assigned(DataText.DataView)) then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TLookupDataViewWithNoLookupFieldTest }

constructor TLookupDataViewWithNoLookupFieldTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TLookupDataViewWithNoLookupFieldTest.GetDescription: string;
begin
  Result := 'Lookup Dataview set but LookupField is not.  Lookup may not succeed.';
end;

function TLookupDataViewWithNoLookupFieldTest.GetID: string;
begin
  Result := '{FD57A9F3-688D-44FE-B3F0-3DCB0B40E69B}';
end;

procedure TLookupDataViewWithNoLookupFieldTest.Test;
var
  TI: TReportExpertTestInfo;
  DataText: TRaveDataText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataText) do begin
      DataText := GetComp(1) as TRaveDataText;
      TI := CreateComponent(DataText);
      if not TI.Ignored then begin
        if DataText.Visible then begin
          if Assigned(DataText.LookupDataView) and (DataText.LookupField = '') then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TLookupDataViewWithNoLookupDisplayTest }

constructor TLookupDataViewWithNoLookupDisplayTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TLookupDataViewWithNoLookupDisplayTest.GetDescription: string;
begin
  Result := 'Lookup Dataview set but LookupDisplay is not.  Lookup may not succeed.';
end;

function TLookupDataViewWithNoLookupDisplayTest.GetID: string;
begin
  Result := '{4523E63A-BD70-4676-929E-EE2C890BC8E3}';
end;

procedure TLookupDataViewWithNoLookupDisplayTest.Test;
var
  TI: TReportExpertTestInfo;
  DataText: TRaveDataText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataText) do begin
      DataText := GetComp(1) as TRaveDataText;
      TI := CreateComponent(DataText);
      if not TI.Ignored then begin
        if DataText.Visible then begin
          if Assigned(DataText.LookupDataView) and (DataText.LookupDisplay = '') then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TLookupInvalidTest }

constructor TLookupInvalidTest.Create;
begin
  inherited;
  MessageType := mtHint;
end;

function TLookupInvalidTest.GetDescription: string;
begin
  Result := 'Lookup Dataview set.  Use the LookupInvalid property to display specific text when a lookup is not found.';
end;

function TLookupInvalidTest.GetID: string;
begin
  Result := '{4742BA8F-E67E-4210-A2C6-65ADC7D78FFE}';
end;

procedure TLookupInvalidTest.Test;
var
  TI: TReportExpertTestInfo;
  DataText: TRaveDataText;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataText) do begin
      DataText := GetComp(1) as TRaveDataText;
      TI := CreateComponent(DataText);
      if not TI.Ignored then begin
        if DataText.Visible then begin
          if Assigned(DataText.LookupDataView) and (DataText.LookupInvalid = '') then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataCycleDataViewNotAssignedTest }

constructor TDataCycleDataViewNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDataCycleDataViewNotAssignedTest.GetDescription: string;
begin
  Result := 'DataView property is not assigned.  DataCycle may not function properly.';
end;

function TDataCycleDataViewNotAssignedTest.GetID: string;
begin
  Result := '{57488731-48F1-414E-AC5C-2B2699E012C7}';
end;

procedure TDataCycleDataViewNotAssignedTest.Test;
var
  DataCycle: TRaveDataCycle;
  TI: TReportExpertTestInfo;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataCycle) do begin
      DataCycle := GetComp(1) as TRaveDataCycle;
      TI := CreateComponent(DataCycle);
      if not TI.Ignored then begin
        if DataCycle.DataView = nil then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end;
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataCycleMasterKeyNotAssignedTest }

constructor TDataCycleMasterKeyNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TDataCycleMasterKeyNotAssignedTest.GetDescription: string;
begin
  Result := 'MasterDataview set but MasterKey is not.  MasterKey property should be set.';
end;

function TDataCycleMasterKeyNotAssignedTest.GetID: string;
begin
  Result := '{B10287BE-1E5C-44B7-B545-B30640E5221F}';
end;

procedure TDataCycleMasterKeyNotAssignedTest.Test;
var
  TI: TReportExpertTestInfo;
  DataCycle: TRaveDataCycle;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataCycle) do begin
      DataCycle := GetComp(1) as TRaveDataCycle;
      TI := CreateComponent(DataCycle);
      if not TI.Ignored then begin
        if (Assigned(DataCycle.MasterDataView) and (DataCycle.MasterKey = '')) and
         (DataCycle.Visible = true) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataCycleDetailKeyNotAssignedTest }

constructor TDataCycleDetailKeyNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TDataCycleDetailKeyNotAssignedTest.GetDescription: string;
begin
  Result := 'MasterDataview set but DetailKey is not.  Master/Detail relationship may not function properly.';
end;

function TDataCycleDetailKeyNotAssignedTest.GetID: string;
begin
  Result := '{493AE63B-D8C1-4C50-BEF1-C17A8E1F168E}';
end;

procedure TDataCycleDetailKeyNotAssignedTest.Test;
var
  TI: TReportExpertTestInfo;
  DataCycle: TRaveDataCycle;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataCycle) do begin
      DataCycle := GetComp(1) as TRaveDataCycle;
      TI := CreateComponent(DataCycle);
      if not TI.Ignored then begin
        if (Assigned(DataCycle.MasterDataView) and (DataCycle.DetailKey = '')) and
         (DataCycle.Visible = true) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TLineColorWhiteTest }

constructor TLineColorWhiteTest.Create;
begin
  inherited;
  MessageType := mtHint;
end;

function TLineColorWhiteTest.GetDescription: string;
begin
  Result := 'Line color is set to white.  Line may not be visible.';
end;

function TLineColorWhiteTest.GetID: string;
begin
  Result := '{F1B4B133-B87D-43C3-A9D6-E62332E8B24E}';
end;

procedure TLineColorWhiteTest.Test;
var
  TI: TReportExpertTestInfo;
  RaveLine: TRaveLine;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveLine) do begin
      RaveLine := GetComp(1) as TRaveLine;
      TI := CreateComponent(RaveLine);
      if not TI.Ignored then begin
        if RaveLine.Visible then begin
          if RaveLine.Color = clWhite then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TEllipseColorWhiteTest }

constructor TEllipseColorWhiteTest.Create;
begin
  inherited;
  MessageType := mtHint;
end;

function TEllipseColorWhiteTest.GetDescription: string;
begin
  Result := 'Border and Fill color is set to white.  Ellipse/Circle may not be visible.';
end;

function TEllipseColorWhiteTest.GetID: string;
begin
  Result := '{931DD3BB-902E-437A-B8B2-5AE9B3CAB02E}';
end;

procedure TEllipseColorWhiteTest.Test;
var
  TI: TReportExpertTestInfo;
  RaveEllipse: TRaveEllipse;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveEllipse) do begin
      RaveEllipse := GetComp(1) as TRaveEllipse;
      TI := CreateComponent(RaveEllipse);
      if not TI.Ignored then begin
        if RaveEllipse.Visible then begin
          if (RaveEllipse.BorderColor = clWhite) and
             (RaveEllipse.FillColor = clWhite) then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TRectangleColorWhiteTest }

constructor TRectangleColorWhiteTest.Create;
begin
  inherited;
  MessageType := mtHint;
end;

function TRectangleColorWhiteTest.GetDescription: string;
begin
  Result := 'Border and Fill color is set to white.  Rectangle/Square may not be visible.';
end;

function TRectangleColorWhiteTest.GetID: string;
begin
  Result := '{72C90F6D-B686-435E-A314-20A20BD41E04}';
end;

procedure TRectangleColorWhiteTest.Test;
var
  TI: TReportExpertTestInfo;
  RaveRectangle: TRaveRectangle;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveRectangle) do begin
      RaveRectangle := GetComp(1) as TRaveRectangle;
      TI := CreateComponent(RaveRectangle);
      if not TI.Ignored then begin
        if RaveRectangle.Visible then begin
          if (RaveRectangle.BorderColor = clWhite) and
             (RaveRectangle.FillColor = clWhite) then begin
            Add(TI, FormReportExpert.ReportItems);
          end; { if }
        end; { if }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataMirrorSectionNoDataviewTest }

constructor TDataMirrorSectionNoDataviewTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDataMirrorSectionNoDataviewTest.GetDescription: string;
begin
  Result := 'DataView property is not assigned.  DataMirrorSection will not print correctly.';
end;

function TDataMirrorSectionNoDataviewTest.GetID: string;
begin
  Result := '{6D4BE0B8-57A9-4AA6-8206-7F4D086316BD}';
end;

procedure TDataMirrorSectionNoDataviewTest.Test;
var
  DataMirrorSection: TRaveDataMirrorSection;
  TI: TReportExpertTestInfo;
begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataMirrorSection) do begin
      DataMirrorSection := GetComp(1) as TRaveDataMirrorSection;
      TI := CreateComponent(DataMirrorSection);
      if not TI.Ignored then begin
        if DataMirrorSection.DataView = nil then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end;
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataMirrorSectionDataFieldNotAssignedTest }

constructor TDataMirrorSectionDataFieldNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDataMirrorSectionDataFieldNotAssignedTest.GetDescription: string;
begin
  Result := 'DataField property is not assigned.  DataMirrorSection will not print correctly.';
end;

function TDataMirrorSectionDataFieldNotAssignedTest.GetID: string;
begin
  Result := '{45D6E8FD-56FE-4317-8745-F824FAFE5436}';
end;

procedure TDataMirrorSectionDataFieldNotAssignedTest.Test;
var
  TI: TReportExpertTestInfo;
  DataMirrorSection: TRaveDataMirrorSection;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataMirrorSection) do begin
      DataMirrorSection := GetComp(1) as TRaveDataMirrorSection;
      TI := CreateComponent(DataMirrorSection);
      if not TI.Ignored then begin
        if (DataMirrorSection.DataField = '') and
         (DataMirrorSection.Visible = true) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataMirrorSectionDataMirrorsNotAssignedTest }

constructor TDataMirrorSectionDataMirrorsNotAssignedTest.Create;
begin
  inherited;
  MessageType := mtError;
end;

function TDataMirrorSectionDataMirrorsNotAssignedTest.GetDescription: string;
begin
  Result := 'DataMirrors have not been assigned.  DataMirrorSection will not function properly.';
end;

function TDataMirrorSectionDataMirrorsNotAssignedTest.GetID: string;
begin
  Result := '{57D48BBE-CB37-4C22-9C19-45E18718095A}';
end;

procedure TDataMirrorSectionDataMirrorsNotAssignedTest.Test;
var
  TI: TReportExpertTestInfo;
  DataMirrorSection: TRaveDataMirrorSection;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataMirrorSection) do begin
      DataMirrorSection := GetComp(1) as TRaveDataMirrorSection;
      TI := CreateComponent(DataMirrorSection);
      if not TI.Ignored then begin
        if (DataMirrorSection.DataMirrors.Count < 1) and
         (DataMirrorSection.Visible = true) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

{ TDataMirrorSectionNoDefaultDataMirrorTest }

constructor TDataMirrorSectionNoDefaultDataMirrorTest.Create;
begin
  inherited;
  MessageType := mtWarning;
end;

function TDataMirrorSectionNoDefaultDataMirrorTest.GetDescription: string;
begin
  Result := 'No default DataMirror selected.  DataMirrorSection may not funtion properly.';
end;

function TDataMirrorSectionNoDefaultDataMirrorTest.GetID: string;
begin
  Result := '{9282E2A4-9869-4211-A840-705E4EB2C1C2}';
end;

procedure TDataMirrorSectionNoDefaultDataMirrorTest.Test;
var
  TI: TReportExpertTestInfo;
  DataMirrorSection: TRaveDataMirrorSection;

  function DefaultAssigned: boolean;
  var
    I1: integer;
    DataMirror: TRaveDataMirror;
  begin
    Result := false;
    with DataMirrorSection do begin
      for I1 := 0 to DataMirrors.Count - 1 do begin
        DataMirror := DataMirrors[I1];
        if DataMirror.IsDefault then begin
          Result := true;
          Exit;
        end; { if }
      end; { for }
    end; { with }
  end;

begin
  inherited;
  if not GlobalIgnored then begin
    while FindComp(1,TRaveDataMirrorSection) do begin
      DataMirrorSection := GetComp(1) as TRaveDataMirrorSection;
      TI := CreateComponent(DataMirrorSection);
      if not TI.Ignored then begin
        if (DataMirrorSection.Visible = true) and
         (not DefaultAssigned) then begin
          Add(TI, FormReportExpert.ReportItems);
        end else begin
          FreeAndNil(TI);
        end; { else }
      end else begin
        Add(TI, FormReportExpert.IgnoredItems);
      end; { else }
    end; { while }
  end; { if }
end;

initialization
  RegisterProc({Trans-}'RVCL',RaveRegister);
end.
