program ViewNestedBandsDemoD103Rio;

uses
  Forms,
  ViewNestedBandsDemoMain in 'ViewNestedBandsDemoMain.pas' {ViewNestedBandsDemoMainForm},
  ViewNestedBandsDemoData in 'ViewNestedBandsDemoData.pas' {ViewNestedBandsDemoDataDM: TDataModule},
  CarsData in '..\Common\CarsData.pas' {dmCars},
  CarsDataForGrid in '..\Common\CarsDataForGrid.pas' {dmGridCars},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas' {fmBaseForm},
  SkinDemoUtils in '..\SkinDemoUtils.pas',
  DemoUtils in '..\DemoUtils.pas';

  {$R *.res}
  {$R WindowsXP.res}


begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid ViewNestedBandsDemoD103Rio';
  Application.CreateForm(TdmGridCars, dmGridCars);
  Application.CreateForm(TViewNestedBandsDemoDataDM, ViewNestedBandsDemoDataDM);
  Application.CreateForm(TViewNestedBandsDemoMainForm, ViewNestedBandsDemoMainForm);
  Application.Run;
end.
