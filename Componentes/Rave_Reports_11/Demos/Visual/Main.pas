Unit Main;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Buttons, Controls,
  Forms, Dialogs, StdCtrls, RpRave, RpDefine, RpBase, RpSystem,
  RvClass,                              // RavePage
  RvCsRpt;                              // RaveBand

Type
  TForm1 = Class(TForm)
    ButtonClose: TBitBtn;
    ButtonPrint: TButton;
    lbReportsAvailable: TListBox;
    LabelAvailableReports: TLabel;
    LabelReportDescription: TLabel;
    MemoReportDescription: TMemo;
    RvProject: TRvProject;
    RvSystem1: TRvSystem;
    Procedure FormCreate(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    Procedure FormDestroy(Sender: TObject);
    Procedure ButtonCloseClick(Sender: TObject);
    Procedure ButtonPrintClick(Sender: TObject);
    Procedure lbReportsAvailableClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  End;

Var
  Form1: TForm1;
  ShowNotice: boolean = true;

Implementation

{$R *.DFM}

Procedure TForm1.FormCreate(Sender: TObject);
Begin
  RvProject.Open;
  RvProject.GetReportList(lbReportsAvailable.Items, true);
End;

Procedure TForm1.FormShow(Sender: TObject);
Begin
  lbReportsAvailable.ItemIndex := 0;
  lbReportsAvailableClick(Nil);
End;

Procedure TForm1.FormDestroy(Sender: TObject);
Begin
  RvProject.Close;
End;

Procedure TForm1.ButtonCloseClick(Sender: TObject);
Begin
  Close;
End;

Procedure TForm1.ButtonPrintClick(Sender: TObject);
Var
  iColumns, iHeight, iLoop, iSkipNum: Integer;
  MyHeaderBand: TRaveBand;
  MyPage: TRavePage;
Begin
  iSkipNum := 5;                        // Skip labels
  iColumns := 3;                        // Could Ask for number of labels to skip
  For iLoop := 0 To (lbReportsAvailable.Count - 1) Do Begin
    If lbReportsAvailable.Items[iLoop] = 'Labels' Then Begin
      // Select the project file
      RvProject.ProjectFile := 'RaveDemo.rav';
      RvProject.Open;
      // Select the "Page1" of desired report ("Labels")
      MyPage := RvProject.ProjMan.FindRaveComponent('Labels.Page1', Nil) As TRavePage;
      // Select the Header Band that you want to change the height
      MyHeaderBand := RvProject.ProjMan.FindRaveComponent('BodyHeader', MyPage) As TRaveBand;
      // BodyHeader.Height = Truncate((SkipLabels+(Columns-1))/Columns)
      iHeight := Trunc((iSkipNum + (iColumns - 1)) / iColumns);
      // Change the "Header Band" Height properties to "skip" labels
      MyHeaderBand.Height := iHeight;
    End;
  End;
  RvProject.Execute;
End;

Procedure TForm1.lbReportsAvailableClick(Sender: TObject);
Begin
  RvProject.SelectReport(lbReportsAvailable.Items[lbReportsAvailable.ItemIndex], true);
  RvProject.ReportDescToMemo(memoReportDescription);
End;

End.

