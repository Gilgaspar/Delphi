{ WILSON LUZ 2024 }

{$I QRDEFS.INC}
{$R fonts.res}
unit QRPrev;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, QRPrntr, QR5const, QRExtra, ComCtrls, ToolWin,
  Menus, ImgList, Grids, printers, quickrpt, System.ImageList, QRExport,
  QRPDFFilt, Vcl.Imaging.pngimage,Vcl.Imaging.jpeg,Web.HTTPApp,FireDAC.Comp.Client;

type
  TQRStandardPreview = class(TForm)
    StatusBar: TStatusBar;
    Splitter1: TSplitter;
    Tabs: TPageControl;
    TabThumbs: TTabSheet;
    TabSearchResult: TTabSheet;
    Splitter2: TSplitter;
    GroupBox1: TGroupBox;
    SearchResultBox: TListBox;
    SearchTextLabel: TLabel;
    ThumbGrid: TDrawGrid;
    PrintDialog1: TPrintDialog;
    Zoommenu: TPopupMenu;
    N50: TMenuItem;
    N60: TMenuItem;
    N70: TMenuItem;
    N80: TMenuItem;
    N90: TMenuItem;
    N100: TMenuItem;
    N110: TMenuItem;
    N120: TMenuItem;
    N130: TMenuItem;
    N140: TMenuItem;
    N150: TMenuItem;
    N160: TMenuItem;
    N170: TMenuItem;
    N180: TMenuItem;
    N190: TMenuItem;
    N200: TMenuItem;
    QRPreview: TQRPreview;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ZoomFit: TToolButton;
    ZoomToWidth: TToolButton;
    Zoom100: TToolButton;
    Spacer3: TToolButton;
    FirstPage: TToolButton;
    PreviousPage: TToolButton;
    nextPage: TToolButton;
    LastPage: TToolButton;
    Spacer2: TToolButton;
    GotoPageButton: TToolButton;
    FindButton: TToolButton;
    btExecel: TToolButton;
    copybutton: TToolButton;
    PrintSetup: TToolButton;
    Print: TToolButton;
    LoadReport: TToolButton;
    SaveReport: TToolButton;
    Spacer5: TToolButton;
    CancelButton: TToolButton;
    btEmail: TToolButton;
    btPdf: TToolButton;
    QRPDFFilter1: TQRPDFFilter;
    QRExcelFilter1: TQRExcelFilter;
    ImageList2: TImageList;
    ToolButton2: TToolButton;
    btzoom: TToolButton;
    imgFundo: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZoomToFitClick(Sender: TObject);
    procedure ZoomTo100Click(Sender: TObject);
    procedure ZoomToWidthClick(Sender: TObject);
    procedure FirstPageClick(Sender: TObject);
    procedure PrevPageClick(Sender: TObject);
    procedure NextPageClick(Sender: TObject);
    procedure LastPageClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure FormCreate(Sender: TObject);
    procedure QRPreviewHyperlink(Sender: TObject;
      EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
    procedure ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      ARect: TRect; State: TGridDrawState);
    procedure ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FindButtonClick(Sender: TObject);
    procedure GotoPageButtonClick(Sender: TObject);
    procedure SearchResultBoxClick(Sender: TObject);
    procedure QRPreviewMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure CancelButtonClick(Sender: TObject);
    procedure copybuttonClick(Sender: TObject);

    procedure N50Click(Sender: TObject);
    procedure btPdfClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure btzoomClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btEmailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btExecelClick(Sender: TObject);
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure SetupFromController(prevcon: TQRPreviewController);
  private
    FQRPrinter: TQRPrinter;
    FReportOrientation: TPrinterOrientation;
    Gauge: TProgressBar;
    LastProgress: Integer;
    ThumbFontHeight, ThumbDrawHeight, ThumbDrawWidth, ThumbTopMargin,
      ThumbLeftMargin: Integer;
    ShowThumbs, ShowSearch: Boolean;
    InitZoom: TQRZoomstate;
    procedure SendMail();
    procedure QrpToImg(QR: Tqrprinter; Path: string; Tipo: Integer; GeraHTML: Boolean);
  public
    constructor CreatePreview(AOwner: TComponent;
      aQRPrinter: TQRPrinter); virtual;
    procedure Show;
    procedure UpdateInfo;
    procedure SelectPage(aPageNumber: Integer);
    procedure ResizeThumb(Sender: TObject);
    function GetTextSearch(var MatchCase: Boolean; var AText: string): Boolean;
    property QRPrinter: TQRPrinter read FQRPrinter write FQRPrinter;

  end;

  TResizeGrid = class(TDrawGrid)
  public
    property OnResize;
  end;

implementation

uses qrsearchdlg,

  fmMenu,
  FMDM,
  fmDMFd,
  uVariaveisSistema,
  funcoes,
  libmgalog,
  libExportaCSV,
  frelClifor,
  fmQuickCell,
  fmsetpage,
  fmSendMail,
  Clipbrd;

var
  ThumbUpdating, ThumbSelecting: Boolean;
  ReportTitle: string;
  FParentReport: TCustomQuickrep;
  eventHandled: Boolean;
{$R *.DFM}

  { ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.WndProc(var Message: TMessage);
var
  i: smallint;
begin
  if Message.Msg = WM_MOUSEWHEEL then
  begin
    Message.Msg := WM_KEYDOWN;
    Message.lParam := 0;
    try
      i := Message.wParam div $1000;
      if i > 0 then
        Message.wParam := VK_UP
      else
        Message.wParam := VK_DOWN;
    except
      Message.wParam := VK_DOWN;
    end;
  end;
  inherited WndProc(message);
end;

{ ----------------------------------------------------------------------------- }
constructor TQRStandardPreview.CreatePreview(AOwner: TComponent;
  aQRPrinter: TQRPrinter);
var
  localZoom: Integer; // ZOOM FIX
begin
  inherited Create(AOwner);
  // set captions
  Tabs.Pages[0].Caption := sqrThumbNails;
  Tabs.Pages[1].Caption := sqrSearchResults;
  GroupBox1.Caption := sqrSearchText;
  ZoomFit.Hint := SqrZoomToFit;
  ZoomToWidth.Hint := sqrZoomTowidth;
  Zoom100.Hint := sqrZoom100;
  FirstPage.Hint := sqrFirstPage;
  nextPage.Hint := sqrNextPage;
  PreviousPage.Hint := sqrPrevPage;
  LastPage.Hint := sqrLastPage;
  GotoPageButton.Hint := sqrPageSelect;
  FindButton.Hint := sqrFindCaption;
  PrintSetup.Hint := sqrPrinterSetup;
  Print.Hint := sqrPrint;
  SaveReport.Hint := sqrSaveReport;
  LoadReport.Hint := sqrLoadReport;

  Caption := sqrPreviewWindowCaption;

  CancelButton.Enabled := false;

  CancelButton.Hint := sqrCancelButtonHint;
  copybutton.Hint := sqrcopyButtonHint;
  btzoom.Enabled := false;

{$DEFINE NAV_ALWAYS}
{$IFDEF NAV_ALWAYS}
  GotoPageButton.Enabled := true;
  FirstPage.Enabled := true;
  nextPage.Enabled := true;
  PreviousPage.Enabled := true;
  LastPage.Enabled := true;
{$ENDIF}
  QRPrinter := aQRPrinter;

  QRPreview.QRPrinter := aQRPrinter;
  if QRPrinter.parentreport is TCustomQuickrep then
  begin
    FParentReport := TCustomQuickrep(QRPrinter.parentreport);
    if FParentReport.PreviewController <> nil then
    begin
      SetupFromController(FParentReport.PreviewController);
      localZoom := TCustomQuickrep(QRPrinter.parentreport).zoom; // ZOOM FIX
    end
    else
    begin
      FormStyle := TCustomQuickrep(QRPrinter.parentreport).PrevFormstyle;
      ShowThumbs := TCustomQuickrep(QRPrinter.parentreport).PrevShowThumbs;
      ShowSearch := TCustomQuickrep(QRPrinter.parentreport).PrevShowSearch;
      InitZoom := TCustomQuickrep(QRPrinter.parentreport).PrevInitialZoom;
      localZoom := TCustomQuickrep(QRPrinter.parentreport).zoom; // ZOOM FIX
      ReportTitle := TCustomQuickrep(QRPrinter.parentreport).ReportTitle;
      QRPrinter.Title := ReportTitle;
      FReportOrientation := TCustomQuickrep(QRPrinter.parentreport)
        .Page.Orientation;
      WindowState := TCustomQuickrep(QRPrinter.parentreport)
        .PreviewInitialState;
      if WindowState <> wsMaximized then
      begin
        top := TCustomQuickrep(QRPrinter.parentreport).Previewtop;
        left := TCustomQuickrep(QRPrinter.parentreport).PreviewLeft;
        width := TCustomQuickrep(QRPrinter.parentreport).PreviewWidth;
        height := TCustomQuickrep(QRPrinter.parentreport).Previewheight;
      end;
    end;
    eventHandled := false;
    if assigned(FParentReport.OnStandPrevEvent) then
      FParentReport.OnStandPrevEvent(self, spOpen, '', eventHandled);
  end
  else
  begin // this should never happen
    WindowState := wsMaximized;
    ShowThumbs := true;
    ShowSearch := true;
    localZoom := 100; // ZOOM FIX
    FParentReport := nil;
  end;
  QRPreview.QRPrinter.Orientation := FReportOrientation;
  if (QRPrinter <> nil) and (QRPrinter.Title <> '') then
    Caption := sqrPreviewWindowCaption + QRPrinter.Title;
  Gauge := TProgressBar.Create(self);
  Gauge.top := 2;
  Gauge.left := 2;
  Gauge.height := 10;
  Gauge.width := 100;
  LastProgress := 0;
  // qrprinter.load -> qrprinter.preview grid bug fix
  ThumbGrid.RowCount := 1; // ******************
  Tabs.Visible := ShowThumbs or ShowSearch;
  try
    if Tabs.Visible and (QRPrinter.PageCount > 0) then
      ThumbGrid.RowCount := QRPrinter.PageCount;

    if Tabs.Visible then
      TabThumbs.TabVisible := ShowThumbs;
    FindButton.Visible := ShowSearch;
    if not ShowSearch and Tabs.Visible then
    begin
      TabSearchResult.TabVisible := false;
      FindButton.Visible := false;
    end;
  except

  end;
  if InitZoom = QRZoomtofit then
  begin
    QRPreview.ZoomToFit;
    ZoomFit.Down := true;
  end
  else if InitZoom = QRZoomtowidth then
  begin
    QRPreview.ZoomToWidth;
    ZoomToWidth.Down := true;
  end
  else
  begin
    QRPreview.zoom := localZoom; // ZOOM FIX
    QRPreview.UpdateZoom;
    Zoom100.Down := true;
  end;
  if QRPrinter.status = mpFinished then
    QRPreviewPageAvailable(self, QRPrinter.PageCount);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.SetupFromController(prevcon: TQRPreviewController);
begin
  FormStyle := prevcon.PrevWindowStyle;
  ShowThumbs := prevcon.ShowThumbs;
  ShowSearch := prevcon.ShowFindButton;
  InitZoom := prevcon.PrevInitZoom;
  ReportTitle := TCustomQuickrep(QRPrinter.parentreport).ReportTitle;
  QRPrinter.Title := ReportTitle;
  FReportOrientation := TCustomQuickrep(QRPrinter.parentreport)
    .Page.Orientation;
  WindowState := prevcon.PrevInitState;
  // jan 2010
  if WindowState <> wsMaximized then
  begin
    top := prevcon.PrevInitTop;
    left := prevcon.PrevInitLeft;
    width := prevcon.prevInitWidth;
    height := prevcon.prevInitHeight;
  end;
  // buttons
  LoadReport.Visible := prevcon.ShowLoadReportButton;
  SaveReport.Visible := prevcon.ShowSaveReportButton;
  CancelButton.Visible := prevcon.ShowCancelButton;
  Print.Visible := prevcon.ShowPrintButton;
  PrintSetup.Visible := prevcon.ShowPrintSetupButton;
  FindButton.Visible := prevcon.ShowFindButton;
  ShowSearch := prevcon.ShowFindButton;
  GotoPageButton.Visible := prevcon.ShowGotoButton;
  btzoom.Visible := prevcon.ShowZoomPickButton;
  Zoom100.Visible := prevcon.ShowZoom100Button;
  ZoomFit.Visible := prevcon.ShowZoom100Button;
  ZoomToWidth.Visible := prevcon.ShowZoomToWidthButton;
  FirstPage.Visible := prevcon.ShowFirstButton;
  PreviousPage.Visible := prevcon.ShowPrevButton;
  nextPage.Visible := prevcon.ShowNextButton;
  LastPage.Visible := prevcon.ShowLastButton;

  // system menu
  if not prevcon.ShowMinimise then
    self.BorderIcons := self.BorderIcons - [biMinimize];
  if not prevcon.ShowMaximise then
    self.BorderIcons := self.BorderIcons - [biMaximize];
  if not prevcon.ShowSysMenu then
    self.BorderIcons := self.BorderIcons - [biSystemMenu];

end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if QRPrinter.status = mpBusy then
  begin
    Action := caNone;
    exit;
  end;

  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spclose, '', eventHandled);
  QRPrinter.ClosePreview(self); // leak fix

  Action := caFree;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.UpdateInfo;
begin
  try
    StatusBar.Panels[1].Text := SqrPage + ' ' + IntToStr(QRPreview.PageNumber) +
      ' ' + SqrOf + ' ' + IntToStr(QRPreview.QRPrinter.PageCount);
  except
  end;
  StatusBar.Panels[2].Text := ReportTitle;
  StatusBar.Panels[3].Text := 'Zoom ' + IntToStr(QRPreview.zoom) + '%';
end;

procedure TQRStandardPreview.ZoomToFitClick(Sender: TObject);
begin
  application.ProcessMessages;
  QRPreview.ZoomToFit;
  UpdateInfo;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.ZoomTo100Click(Sender: TObject);
begin
  application.ProcessMessages;
  QRPreview.zoom := 100;
  QRPreview.UpdateZoom;
  UpdateInfo;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.ZoomToWidthClick(Sender: TObject);
begin
  application.ProcessMessages;
  QRPreview.ZoomToWidth;
  UpdateInfo;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.SelectPage(aPageNumber: Integer);
begin
  try
    QRPreview.PageNumber := aPageNumber;
    UpdateInfo;
    // set thumb row
    if ((aPageNumber > 0) and (aPageNumber <= QRPrinter.PageCount) and
      (aPageNumber <= ThumbGrid.RowCount)) then
    begin
      ThumbUpdating := true;
      ThumbGrid.Row := aPageNumber - 1;
      ThumbUpdating := false;
    end;
  except
  end;
end;

procedure TQRStandardPreview.QrpToImg(QR: Tqrprinter; Path: string; Tipo: Integer; GeraHTML: Boolean);
var
  i, vLef, vTop: Integer;
  BMP: TBitmap;
  JPG: TJPegImage;
  aUnits: TQRUnit;
  vHTML: TStringList;
  vHTMLPath: string;
  MF: TMetaFile;
  tipoMail:string;
begin
  if QR = nil then
    Exit;
  if not DirectoryExists(Path) then
    ForceDirectories(Path);

  //-- Gera o relatório em Memória ---------------------------------------------------------------------------------------------
  if not  TQuickRep(qr.ParentReport).Available then
    TQuickRep(qr.ParentReport).Prepare;
  //----------------------------------------------------------------------------------------------------------------------------

  //-- Pega unidade de medida atual no QReport ---------------------------------------------------------------------------------
  aUnits := TQuickRep(qr.ParentReport).Units;
  //----------------------------------------------------------------------------------------------------------------------------

  //-- Altera unidade de medida para Pixels ------------------------------------------------------------------------------------
TQuickRep(qr.ParentReport).Units := Pixels;
  //----------------------------------------------------------------------------------------------------------------------------

  try
    vMailInfo.ImgHTML.Clear;

    vHTML := TStringList.Create;
    vHTML.Add('<html><body>');

    //-- Coloca o Texto "Body" no próprio html --------------------------------------------------------------------------------
    //if vMailInfo.Corpo<>'' then
    //  vHTML.Add('<table><tr><td> '+vMailInfo.Corpo+' <br></td></tr></table>');

    for i := 1 to QR.PageCount do
    begin
      BMP := TBitMap.Create;
      JPG := TJPegImage.Create;
      MF  := TMetaFile.Create;
      MF  := QRPrinter.GetPage(i);
      MF.Enhanced:=True;
      BMP.Width:=MF.Width;
      BMP.Height:=MF.Height;
      BMP.Canvas.Draw(0,0,MF);
      try
        //-- Define tamanho do Bitmap de acordo com o tamanho da página do QReport ---------------------------------------
        vLef := Round(TQuickRep(qr.ParentReport).Page.LeftMargin) - 2;
        vTop := Round(TQuickRep(qr.ParentReport).Page.TopMargin) - 2;

        //--- Devido a um erro na geração dos anexos, foi fixado o left e top
        // erro passou a ser apresentado na versão 4.0
        vLef := 34;
        vTop := 0;
        // ---
        BMP.Width := Round(TQuickRep(qr.ParentReport).Page.Width);
        BMP.Height := Round(TQuickRep(qr.ParentReport).Page.Length);
        BMP.Width := Round(TQuickRep(qr.ParentReport).Page.Width - vLef - TQuickRep(qr.ParentReport).Page.RightMargin);
        BMP.Height := Round(TQuickRep(qr.ParentReport).Page.Length - vTop - TQuickRep(qr.ParentReport).Page.BottomMargin);

        //-- Pega Página à Página ----------------------------------------------------------------------------------------
        QRPrinter.PageNumber := i;
        //----------------------------------------------------------------------------------------------------------------

        //-- Atribui a Página ao Bitmap ----------------------------------------------------------------------------------
        BMP.Canvas.Draw(-vLef, -vTop, MF);
        //----------------------------------------------------------------------------------------------------------------

        case Tipo of
          0:
            begin
              BMP.SaveToFile(Path + 'pagina' + IntToStr(i) + '.bmp');
              vMailInfo.ImgHTML.Add(Path + 'pagina' + IntToStr(i) + '.bmp');
            end;
          1:
            begin
              JPG.Assign(BMP);
              JPG.SaveToFile(Path + 'pagina' + IntToStr(i) + '.jpg');
              vMailInfo.ImgHTML.Add(Path + 'pagina' + IntToStr(i) + '.jpg');
            end;
        end;

        vHTMLPath := 'file:///' + DosPathToUnixPath(Path) + 'pagina' + IntToStr(i) + '.jpg';
        vHTML.Add('<table><tr><td bgcolor="SILVER"> <img src=' + vHTMLPath + '> </td></tr></table>');
        //----------------------------------------------------------------------------------------------------------------
      finally
        //-- Libera Objetos ----------------------------------------------------------------------------------------------
        BMP.Free;
        JPG.Free;
        MF.Free;
        //----------------------------------------------------------------------------------------------------------------
      end;
    end;

  finally
    if GeraHTML then
    begin
      //-- Coloca os Anexos de imagem no próprio html ---------------------------------------------------------------------
      if vMailInfo.Anexo.Count > 0 then
      begin
//      vHTML.Add('<p align="left"><b>&nbsp Imagens Anexas:</b></p> <table width="' + IntToStr(qr.Width + 10) + '" bgcolor="Silver" >');
        vHTML.Add('<p align="left"><b>&nbsp Imagens Anexas:</b></p> <table width=150% bgcolor="Silver" >');
//ggg
        for i := 0 to vMailInfo.Anexo.Count - 1 do
        begin
          if EstaContido(LowerCase(ExtractFileExt(vMailInfo.Anexo.Strings[i])), ['.bmp', '.jpg', '.gif', '.png']) then
          begin
            vHTMLPath := 'file:///' + DosPathToUnixPath(vMailInfo.Anexo.Strings[i]);
            vHTML.Add('<tr width=150%><td align="center" bgcolor="White"> <img src="' + vHTMLPath + '"> </td></tr>');
          end;
        end;

        vHTML.Add('</table>');
      end;

      vHTML.Add('</body></html>');
      //-------------------------------------------------------------------------------------------------------------------

      //-- Salva o Arquivo como .Html -------------------------------------------------------------------------------------
      vHTML.SaveToFile(Path + 'relatorio.html');
      vMailInfo.EndHTML := Path + 'relatorio.html';
      vMailInfo.TxtHTML := vHTML.Text;
      //-------------------------------------------------------------------------------------------------------------------

      //-- Libera o Objeto ------------------------------------------------------------------------------------------------
      vHTML.Free;
      //-------------------------------------------------------------------------------------------------------------------
    end;

    //-- Volta Unidade de Medida ----------------------------------------------------------------------------------------------
    TQuickRep(qr.ParentReport).Units := aUnits;
    //-------------------------------------------------------------------------------------------------------------------------
  end;
end;

procedure TQRStandardPreview.SendMail;

var
  i: Integer;
  bm: TBitmap;
  tipoMail, usuFlag, usuMail, usuFRp, sisLink, sisFlag, sisMail: String;
begin

  usuFRp := Trim(DM.BuscaConfigUsu('MAILBYFAST'));

  //QRPrinter.Title
  QrpToImg(QRPrinter, vPastaUsu, 1, true);
  tipoMail := 'SMTP';
  tipoMail := 'MSOutLook'; // Microsoft Office Outlook
  tipoMail := 'OLExpress'; // Outlook Express
  sisLink := DMFd.BuscaParametros('FLAGLINKMAIL');
  usuFlag := Trim(DM.BuscaConfigUsu('FLAGSMTP'));
  usuMail := Trim(DM.BuscaConfigUsu('MAILPADRAO'));
  sisFlag := Trim(DMFd.BuscaParametros('FLAGSMTP'));
  sisMail := Trim(DMFd.BuscaParametros('MAILPADRAO'));
  if usuFlag = 'S' then
    tipoMail := 'SMTP'
  else if usuMail = 'Microsoft Office Outlook' then
    tipoMail := 'MSOutLook'
  else if usuMail = 'Outlook Express' then
    tipoMail := 'OLExpress'
  else if sisFlag = 'S' then
    tipoMail := 'SMTP'
  else if sisMail = 'Microsoft Office Outlook' then
    tipoMail := 'MSOutLook'
  else if sisMail = 'Outlook Express' then
    tipoMail := 'OLExpress'
  else
    tipoMail := 'OLExpress';
  try
    if vMailInfo.Assunto = '' then
        vMailInfo.Assunto := QRPrinter.Title;
    if (sisLink = 'S') and ((vMailInfo.TipoDoc = 'orcamento') or
      (vMailInfo.TipoDoc = 'pedidovenda')) then // Desviar para SendMail
    begin
      if F_SENDMAIL.ShowModal <> mrOk then
        exit;
      if tipoMail = 'SMTP' then // se for = ja foi enviado...
        exit;
    end;
    if tipoMail = 'SMTP' then
      F_SENDMAIL.ShowModal
    else if tipoMail = 'OLExpress' then
      MailByOLExpress
    else if tipoMail = 'MSOutLook' then
      MailByMSOutLook;
  except
    MessageBox(self.Handle, 'Envio de e-mail Falhou', 'Aviso', mb_ok);
    Abort;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.FirstPageClick(Sender: TObject);
begin
  SelectPage(1)
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.PrevPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber - 1);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.N50Click(Sender: TObject);
var
  mstr: string;
  mzoom, ec: Integer;
begin
  // called by all zoommenu items
  mstr := copy(TMenuItem(Sender).Name, 2, 12);
  val(mstr, mzoom, ec);
  if ec = 0 then
    QRPreview.zoom := mzoom;
  self.UpdateInfo;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.NextPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber + 1);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.LastPageClick(Sender: TObject);
begin
  if (QRPrinter.status = mpFinished) then
  begin
    SelectPage(QRPrinter.PageCount);
  end
  else
  begin
    SelectPage(QRPrinter.PageCount - 1);
  end
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.PrintClick(Sender: TObject);
begin
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spPrint, 'Print', eventHandled);
  if eventHandled then
    exit;

  if PrintMetafileFromPreview or (not(QRPrinter.parentreport is TQuickRep)) then
    QRPrinter.Print
  else
  begin
    FParentReport.Print;

    if QRPreview.QRPrinter = nil then
    begin
      QRPreview.QRPrinter := FParentReport.QRPrinter;
    end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.ExitClick(Sender: TObject);
begin
  Close;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.FormResize(Sender: TObject);
begin
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.FormShow(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.Show;
begin
  inherited Show;
  UpdateInfo;
  ZoomToWidthClick(ZoomToWidth);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.btzoomClick(Sender: TObject);
begin
  Zoommenu.Popup(btzoom.left + self.left, btzoom.top + btzoom.height +
    self.top);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  prevpage: Integer;
begin

  if QRPrinter.status <> mpFinished then
    exit;

  try
    if Key = VK_Escape then
    begin
      ExitClick(self);
      exit;
    end;

    if ActiveControl = ThumbGrid then
      exit;

    case Key of
      VK_Next:
        if Shift = [ssCtrl] then
          LastPageClick(self)
        else
          NextPageClick(self);
      VK_Prior:
        if Shift = [ssCtrl] then
          FirstPageClick(self)
        else
          PrevPageClick(self);
      VK_Home:
        FirstPageClick(self);
      VK_End:
        LastPageClick(self);
      VK_DOWN:
        begin
          if ((QRPreview.VertScrollBar.Position +
            QRPreview.VertScrollBar.Increment) < (QRPreview.VertScrollBar.Range
            - QRPreview.height)) then
            QRPreview.VertScrollBar.Position := QRPreview.VertScrollBar.Position
              + QRPreview.VertScrollBar.Increment
          else
          begin
            ThumbSelecting := true;
            NextPageClick(self);
            ThumbSelecting := false;
          end;
        end;
      VK_UP:
        begin
          if (QRPreview.VertScrollBar.Position -
            QRPreview.VertScrollBar.Increment) > 0 then
          begin
            QRPreview.VertScrollBar.Position := QRPreview.VertScrollBar.Position
              - QRPreview.VertScrollBar.Increment;
          end
          else
          begin
            ThumbSelecting := true;
            prevpage := QRPreview.PageNumber;
            PrevPageClick(self);
            ThumbSelecting := false;
            if prevpage > 1 then
              QRPreview.VertScrollBar.Position :=
                (QRPreview.VertScrollBar.Range - QRPreview.height) -
                QRPreview.VertScrollBar.Increment
            else
              QRPreview.VertScrollBar.Position := 0;
          end;
        end;
    end;
  except

  end;
end;

procedure TQRStandardPreview.FormPaint(Sender: TObject);
var
  x, y: Integer;
begin
  y := 0;
  while y < height do
  begin
    x := 0;
    while x < width do
    begin

      Canvas.Draw(x, y, imgFundo.Picture.Graphic);
      x := x + imgFundo.Picture.Graphic.width;
    end;
    y := y + imgFundo.Picture.Graphic.height;
  end;

end;

{ ----------------------------------------------------------------------------- }
function GetExtension(fstr: string): string;
var
  k: Integer;
begin
  Result := '';
  for k := length(fstr) downto 1 do
    if fstr[k] = '.' then
      break
    else
      Result := fstr[k] + Result;
end;

{ ----------------------------------------------------------------------------- }
function IsFileInUse(fName: string): Boolean;
var
  HFileRes: HFILE;
begin
  Result := false;
  if not fileexists(fName) then
    exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
  application.ProcessMessages;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.SaveClick(Sender: TObject);
var
  aExportFilter: TQRExportFilter;
  filtLibEntry: TQRExportFilterLibraryEntry;
  sdialog: TSaveDialog;
  sext, savefile: string;
  findx: Integer;
begin
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spSave, 'Save', eventHandled);
  if eventHandled then
    exit;

  aExportFilter := nil;
  sdialog := TSaveDialog.Create(application);
  try
    sdialog.Title := sqrSaveReport;
    sdialog.Filter := QRSaveExtensions[FParentReport.PreviewDefaultSaveType] +
      '|*' + QRSaveExtensions[FParentReport.PreviewDefaultSaveType] + '|' +
      QRExportFilterLibrary.SaveDialogFilterString;
    // sdialog.DefaultExt := QRSaveExtensions[FParentreport.PreviewDefaultSaveType];
    sdialog.Filename := '*' + QRSaveExtensions
      [FParentReport.PreviewDefaultSaveType];
    if not sdialog.Execute then
      exit;
    if IsFileInUse(sdialog.Filename) then
    begin
      showmessage('The file is read-only or in use - save abandoned.');
      exit;
    end;
    sext := ExtractFileExt(sdialog.Filename);
    savefile := sdialog.Filename;
    sext := upperCase(sext);
    // enforce an extension
    if sext = '' then
    begin
      findx := sdialog.FilterIndex - 1;
      if findx = 0 then
        sext := QRSaveExtensions[FParentReport.PreviewDefaultSaveType]
      else if findx = 1 then
        sext := 'QRP'
      else
      begin
        try
          sext := TQRExportFilterLibraryEntry(QRExportFilterLibrary.Filters
            [findx - 2]).Extension;
        except
          sext := QRSaveExtensions[FParentReport.PreviewDefaultSaveType]
        end;
      end;
      if sext[1] = '.' then
        sext := copy(sext, 2, 3);
      savefile := savefile + '.' + sext;
    end;
    if sext[1] = '.' then
      sext := copy(sext, 2, 3);
    if sext = 'QRP' then
    begin
      QRPrinter.Save(savefile);
      exit;
    end;
    filtLibEntry := QRExportFilterLibrary.GetFilterByExtension(sext);
    if filtLibEntry = nil then
      exit;
    try
      aExportFilter := filtLibEntry.ExportFilterClass.Create(savefile);
      if FParentReport.ParentComposite <> nil then
        TQRCompositeReport(FParentReport.ParentComposite)
          .ExportToFilter(aExportFilter)
      else
        FParentReport.ExportToFilter(aExportFilter);
    finally
      aExportFilter.Free
    end
  finally
    sdialog.Free;
  end;
end;

procedure StandardSetup;
begin
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.PrintSetupClick(Sender: TObject);
var
  prep: TCustomQuickrep;
  tagval: Integer;
begin

  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spPrintSetup, 'PrintSetup',
      eventHandled);
  if eventHandled then
    exit;
  try
    printer.Refresh;
    if TCustomQuickrep(QRPrinter.parentreport).ParentComposite <> nil then
    begin
      prep := TCustomQuickrep(QRPrinter.parentreport);
      TCustomQuickrep(QRPrinter.parentreport).PrinterSetup;
      tagval := TCustomQuickrep(QRPrinter.parentreport).tag;
      if tagval <> 0 then
        exit;
      QRPrinter.PrinterIndex := prep.PrinterSettings.PrinterIndex;
      // 8/02/05
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.PrinterIndex :=
        prep.UserPrinterSettings.PrinterIndex;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.FirstPage :=
        prep.UserPrinterSettings.FirstPage;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.LastPage :=
        prep.UserPrinterSettings.LastPage;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.OutputBin :=
        TQRBin(prep.UserPrinterSettings.CustomBinCode);
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.Collate :=
        prep.UserPrinterSettings.Collate;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.ColorOption :=
        prep.UserPrinterSettings.ColorOption;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.PrintQuality :=
        prep.UserPrinterSettings.PrintQuality;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.Copies :=
        prep.UserPrinterSettings.Copies;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.Duplex :=
        prep.UserPrinterSettings.ExtendedDuplex = 1;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.CustomBinCode :=
        prep.UserPrinterSettings.CustomBinCode;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.UseCustomBinCode
        := prep.PrinterSettings.UseCustomBinCode;
      TQRCompositeReport(prep.ParentComposite).PrinterSettings.Duplex :=
        prep.UserPrinterSettings.Duplex;
      QRPrinter.aPrinterSettings.OutputBin :=
        TQRBin(prep.UserPrinterSettings.CustomBinCode);
      QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
      QRPrinter.aPrinterSettings.ColorOption :=
        prep.UserPrinterSettings.ColorOption;
      QRPrinter.aPrinterSettings.PrintQuality :=
        prep.UserPrinterSettings.PrintQuality;
      QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
      QRPrinter.aPrinterSettings.Duplex :=
        prep.UserPrinterSettings.ExtendedDuplex = 1;
      QRPrinter.aPrinterSettings.CustomBinCode :=
        prep.UserPrinterSettings.CustomBinCode;
      QRPrinter.aPrinterSettings.UseCustomBinCode :=
        prep.PrinterSettings.UseCustomBinCode;
      QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
      QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
      QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
      QRPrinter.aPrinterSettings.ExtendedDuplex :=
        prep.UserPrinterSettings.ExtendedDuplex;
      prep.UserPrinterSettings.UseExtendedDuplex :=
        prep.UserPrinterSettings.ExtendedDuplex > 1;
      QRPrinter.aPrinterSettings.UseExtendedDuplex :=
        prep.UserPrinterSettings.UseExtendedDuplex;
      exit;
    end;
    if QRPrinter.parentreport is TCustomQuickrep then
    Begin
      TCustomQuickrep(QRPrinter.parentreport).PrinterSetup;
      tagval := TCustomQuickrep(QRPrinter.parentreport).tag;
      if tagval <> 0 then
        exit;
      prep := TCustomQuickrep(QRPrinter.parentreport);
      QRPrinter.PrinterIndex := prep.PrinterSettings.PrinterIndex;
      if prep.UserPrinterSettings.CustomBinCode >= Integer(Last) then
      begin
        QRPrinter.aPrinterSettings.UseCustomBinCode := true;
        QRPrinter.aPrinterSettings.CustomBinCode :=
          prep.UserPrinterSettings.CustomBinCode;
      end
      else
      begin
        QRPrinter.aPrinterSettings.UseCustomBinCode := false;
        QRPrinter.aPrinterSettings.OutputBin :=
          TQRBin(prep.UserPrinterSettings.CustomBinCode);
      end;
      QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
      QRPrinter.aPrinterSettings.ColorOption :=
        prep.UserPrinterSettings.ColorOption;
      QRPrinter.aPrinterSettings.PrintQuality :=
        prep.UserPrinterSettings.PrintQuality;
      QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
      QRPrinter.aPrinterSettings.Duplex :=
        prep.UserPrinterSettings.ExtendedDuplex = 1;
      QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
      QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
      QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
      prep.UserPrinterSettings.UseExtendedDuplex :=
        prep.UserPrinterSettings.ExtendedDuplex > 1;
      QRPrinter.aPrinterSettings.ExtendedDuplex :=
        prep.UserPrinterSettings.ExtendedDuplex;
      QRPrinter.aPrinterSettings.UseExtendedDuplex :=
        prep.UserPrinterSettings.UseExtendedDuplex;
      if not PrintMetafileFromPreview then
      begin
        // set the quickrep settings
        if prep.UserPrinterSettings.CustomBinCode >= Integer(Last) then
        begin
          prep.PrinterSettings.UseCustomBinCode := true;
          prep.PrinterSettings.CustomBinCode :=
            prep.UserPrinterSettings.CustomBinCode;
        end
        else
        begin
          prep.PrinterSettings.UseCustomBinCode := false;
          prep.PrinterSettings.OutputBin :=
            TQRBin(prep.UserPrinterSettings.CustomBinCode);
        end;
        prep.PrinterSettings.PrinterIndex :=
          prep.UserPrinterSettings.PrinterIndex;
        prep.PrinterSettings.Copies := prep.UserPrinterSettings.Copies;
        prep.PrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
        prep.PrinterSettings.FirstPage := prep.UserPrinterSettings.FirstPage;
        prep.PrinterSettings.LastPage := prep.UserPrinterSettings.LastPage;
        prep.PrinterSettings.UseStandardprinter :=
          prep.UserPrinterSettings.UseStandardprinter;
        prep.PrinterSettings.ExtendedDuplex :=
          prep.UserPrinterSettings.ExtendedDuplex;
        prep.PrinterSettings.UseExtendedDuplex :=
          prep.UserPrinterSettings.UseExtendedDuplex;
        prep.PrinterSettings.UseCustomPaperCode :=
          prep.UserPrinterSettings.UseCustomPaperCode;
        prep.PrinterSettings.CustomPaperCode :=
          prep.UserPrinterSettings.CustomPaperCode;
        prep.PrinterSettings.MemoryLimit :=
          prep.UserPrinterSettings.MemoryLimit;
        prep.PrinterSettings.PrintQuality :=
          prep.UserPrinterSettings.PrintQuality;
        prep.PrinterSettings.Collate := prep.UserPrinterSettings.Collate;
        prep.PrinterSettings.ColorOption :=
          prep.UserPrinterSettings.ColorOption;
        prep.PrinterSettings.Orientation :=
          prep.UserPrinterSettings.Orientation;
        prep.PrinterSettings.PaperSize := prep.UserPrinterSettings.PaperSize;
      end;
    end;
    if FParentReport is TCustomQuickrep then
      if TCustomQuickrep(FParentReport).PrintAfterSetup then
        PrintClick(self);

  finally
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.LoadClick(Sender: TObject);
begin
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spLoad, 'Load', eventHandled);
  if eventHandled then
    exit;

  with TOpenDialog.Create(application) do
    try
      Title := sqrLoadReport;
      Filter := SqrQRFile + ' (*.' + cQRPDefaultExt + ')|*.' + cQRPDefaultExt;
      if Execute then
        if fileexists(Filename) then
        begin
          QRPrinter.Load(Filename);
          ReportTitle := Filename;
          QRPreview.PageNumber := 1;
          QRPreview.PreviewImage.PageNumber := 1;
          // fix orientation bug. NOTE : this sould be done in qrprinter.load()
          FReportOrientation := QRPrinter.Orientation;
          QRPrinter.aPrinterSettings.Orientation := QRPrinter.Orientation;
          TQuickRep(QRPrinter.parentreport).Page.PaperSize :=
            QRPrinter.aPrinterSettings.PaperSize;
          TQuickRep(QRPrinter.parentreport).Page.Orientation :=
            QRPrinter.Orientation;
          QRPreview.UpdateZoom; // fixes thumb orientation
          // have to reset the thumbs with this call
          ResizeThumb(self);
          QRPreviewPageAvailable(self, 1);
          ThumbGrid.Row := 0;
          // PrintSetup.Enabled := False;
          PrintMetafileFromPreview := true;
          Print.Enabled := true;
          // SaveReport.Enabled := false;
          // SaveReport.visible := false;
        end
        else
          showmessage(SqrFileNotExist);
    finally
      Free;
    end;
end;

procedure TQRStandardPreview.QRPreviewPageAvailable(Sender: TObject;
  PageNum: Integer);
begin
  CancelButton.Enabled := true;
  if QRPrinter.PageCount = 1 then
    SelectPage(1);
  UpdateInfo;
  ThumbGrid.RowCount := QRPrinter.PageCount;
  ThumbGrid.Invalidate;
  if QRPrinter.status = mpFinished then
  begin
    PrintSetup.Enabled := true;
    Print.Enabled := true;
    SaveReport.Enabled := true;
    LoadReport.Enabled := true;
    FindButton.Enabled := true;
    GotoPageButton.Enabled := true;
    FirstPage.Enabled := true;
    nextPage.Enabled := true;
    PreviousPage.Enabled := true;
    LastPage.Enabled := true;
    copybutton.Enabled := true;
    btzoom.Enabled := true;
    ThumbGrid.RowCount := QRPrinter.PageCount;
    CancelButton.Enabled := false;
    Sleep(100);
    SelectPage(1); // added Gvs to force display of the first page in 64-bit
  end
  else
  begin
    ThumbGrid.RowCount := QRPrinter.PageCount - 1;
    PrintSetup.Enabled := false;
    Print.Enabled := false;
    SaveReport.Enabled := false;
    LoadReport.Enabled := false;
    FindButton.Enabled := false;
    { .$define  DISABLE_NAV_BUTTONS }
{$IFDEF DISABLE_NAV_BUTTONS}
    GotoPageButton.Enabled := false;
    FirstPage.Enabled := false;
    nextPage.Enabled := false;
    PreviousPage.Enabled := false;
    LastPage.Enabled := false;
{$ENDIF}
    copybutton.Enabled := false;
    btzoom.Enabled := false;
  end;

  // QR5  stop report after n pages
  if (QRPrinter.PageCount = FParentReport.PagesInPreview) and
    (FParentReport.PagesInPreview <> 0) then
    FParentReport.UserCancel := true;
end;

procedure TQRStandardPreview.QRPreviewProgressUpdate(Sender: TObject;
  Progress: Integer);
begin
  if Progress >= LastProgress + 5 then
  begin
    StatusBar.Panels[0].Text := IntToStr(Progress) + '%';
    LastProgress := Progress;
  end;
  // if (Progress = 0) then StatusBar.Panels[0].Text := '';
end;

procedure TQRStandardPreview.FormCreate(Sender: TObject);
var

  LFileName: string;
  Lfile: string;
  i: Integer;
  ResStream: TResourceStream;
begin

  HorzScrollbar.Tracking := true;
  VertScrollBar.Tracking := true;
  TResizeGrid(ThumbGrid).OnResize := ResizeThumb;
  ForceDirectories(ExtractFilePath(GetModuleName(HInstance)) + 'fonts');
  for i := 1 to 16 do
  begin
    ResStream := TResourceStream.Create(HInstance, 'font' + IntToStr(i),
      RT_RCDATA);
    try
      ResStream.Position := 0;
      Lfile := 'font_' + IntToStr(i);
      LFileName := ExtractFilePath(GetModuleName(HInstance)) + 'fonts\' + Lfile;
      if not fileexists(LFileName) then
      begin
        ResStream.SaveToFile(LFileName);
      end;
      AddFontResource(pchar(LFileName));
    finally
      ResStream.Free;
    end
  end;


end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.QRPreviewHyperlink(Sender: TObject;
  EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
begin
  StatusBar.Panels[2].Text := Link;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.ResizeThumb(Sender: TObject);
begin
  ThumbFontHeight := ThumbGrid.Canvas.TextHeight('P');
  ThumbGrid.DefaultColWidth := ThumbGrid.width - 4;
  if FReportOrientation = poPortrait then
  begin
    ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
    ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperWidth) *
      QRPrinter.PaperLength - ThumbFontHeight);
  end
  else
  begin
    ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
    ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperLength) *
      QRPrinter.PaperWidth - ThumbFontHeight);
  end;

  ThumbGrid.DefaultRowHeight := ThumbDrawHeight;
  ThumbLeftMargin := Round((ThumbGrid.DefaultColWidth - ThumbDrawWidth) / 2);
  ThumbTopMargin := Round((ThumbGrid.DefaultRowHeight - ThumbDrawHeight) / 2);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.ThumbGridDrawCell(Sender: TObject;
  ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
var
  APage: TMetafile;
begin
  APage := QRPrinter.GetPage(ARow + 1);
  if APage <> nil then
    PaintPageToCanvas(APage, ThumbGrid.Canvas,
      Rect(ARect.left + ThumbLeftMargin, ARect.top + 10, ARect.Right - 30,
      ARect.Bottom - 10), true);
  ThumbGrid.Canvas.Brush.Color := clBtnFace;
  ThumbGrid.Canvas.pen.Color := clblack;
  SetBkMode(ThumbGrid.Canvas.Handle, TRANSPARENT);
  ThumbGrid.Canvas.Textout(ARect.left, ARect.top, IntToStr(ARow + 1));
  SetBkMode(ThumbGrid.Canvas.Handle, OPAQUE);
  APage.Free;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.ThumbGridSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if ThumbUpdating or ThumbSelecting then
    exit;
  ThumbSelecting := true;
  if QRPreview.PageNumber <> (ARow + 1) then
    QRPreview.PageNumber := ARow + 1;
  // sleep(100);
  UpdateInfo;
  ThumbSelecting := false;
end;

procedure TQRStandardPreview.ToolButton2Click(Sender: TObject);
begin
  Close;
end;

{ ----------------------------------------------------------------------------- }
function TQRStandardPreview.GetTextSearch(var MatchCase: Boolean;
  var AText: string): Boolean;
var
  SrchDlg: TSearchDlg;
begin
  AText := '';
  Result := false;
  SrchDlg := TSearchDlg.Create(self);
  SrchDlg.ShowModal;
  if SrchDlg.cancel then
  begin
    SrchDlg.Free;
    exit;
  end;
  Result := true;
  SrchDlg.GetText(AText);
  MatchCase := SrchDlg.GetCase;
  SrchDlg.Free;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.FindButtonClick(Sender: TObject);
var
  FindStr: string;
  MatchCase: Boolean;
  i: Integer;
  APage: TMetafile;
begin
  if QRPrinter.status = mpBusy then
    exit;
  if GetTextSearch(MatchCase, FindStr) then
  begin
    SearchResultBox.Enabled := true;
    SearchTextLabel.Caption := FindStr;
    SearchResultBox.Items.Clear;
    for i := 1 to QRPrinter.PageCount do
    begin
      APage := QRPrinter.GetPage(i);
      try
        if StrInMetafile(FindStr, APage, MatchCase) then
          SearchResultBox.Items.AddObject(SqrPage + ' ' + IntToStr(i),
            TObject(i));
      finally
        APage.Free;
      end;
    end;
    if SearchResultBox.Items.Count = 0 then
    begin
      SearchResultBox.Items.Add(sqrSearchNoResult);
      SearchResultBox.Enabled := false;
    end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.GotoPageButtonClick(Sender: TObject);
var
  Pnum, k: Integer;
  PNStr: string;
  CaptionStr: string;
begin
  CaptionStr := format(SqrGotoPage, [QRPrinter.PageCount]);
  PNStr := format('%d', [QRPreview.PageNumber]);
  InputQuery(CaptionStr, sqrGoPage, PNStr);
  val(PNStr, Pnum, k);
  if (Pnum < 1) or (Pnum > QRPrinter.PageCount) then
    Pnum := 1;
  SelectPage(Pnum);
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.SearchResultBoxClick(Sender: TObject);
var
  Page: Integer;
begin
  With SearchResultBox Do
    If ItemIndex >= 0 Then
      Page := Integer(Items.Objects[ItemIndex])
    Else
      Page := 1;
  if (Page < 1) or (Page > QRPrinter.PageCount) then
    Page := 1;
  SelectPage(Page);

end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.QRPreviewMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  kd: Word;
begin
  kd := VK_DOWN;
  FormKeyDown(self, kd, []);
  Handled := true;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.btEmailClick(Sender: TObject);
begin
  SendMail();
end;

procedure TQRStandardPreview.btExecelClick(Sender: TObject);
begin

    TExportaCSV.DataSetToCSV(TFDQuery(TQuickRep(QRPrinter.ParentReport). DataSet), '', nil, nil);
end;

procedure TQRStandardPreview.btPdfClick(Sender: TObject);
var
  aExportFilter: TQRExportFilter;
  filtLibEntry: TQRExportFilterLibraryEntry;
  sdialog: TSaveDialog;
  sext, savefile: string;
  findx: Integer;
begin

  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spSave, 'Save', eventHandled);
  if eventHandled then
    exit;

  aExportFilter := nil;
  sdialog := TSaveDialog.Create(application);
  try
    sdialog.Title := sqrSaveReport;
    sdialog.Filter := 'pdf|*.pdf';
    sdialog.Filename := '*.pdf';
    if not sdialog.Execute then
      exit;
    if IsFileInUse(sdialog.Filename) then
    begin
      showmessage('O arquivo e somente leitura.');
      exit;
    end;
    sext := '.pdf';
    savefile := ExtractFileName(sdialog.Filename) + sext;;
    sext := upperCase(sext);
    if sext[1] = '.' then
      sext := copy(sext, 2, 3);
    filtLibEntry := QRExportFilterLibrary.GetFilterByExtension(sext);
    if filtLibEntry = nil then
      exit;
    try
      aExportFilter := filtLibEntry.ExportFilterClass.Create(savefile);
      if FParentReport.ParentComposite <> nil then
        TQRCompositeReport(FParentReport.ParentComposite)
          .ExportToFilter(aExportFilter)
      else
        FParentReport.ExportToFilter(aExportFilter);
    finally
      aExportFilter.Free
    end
  finally
    sdialog.Free;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TQRStandardPreview.CancelButtonClick(Sender: TObject);
begin
  // user cancels
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spCancel, 'Cancel', eventHandled);
  if eventHandled then
    exit;

  FParentReport.UserCancel := true;
end;

procedure TQRStandardPreview.copybuttonClick(Sender: TObject);
begin
  // copy to clipboard
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
    FParentReport.OnStandPrevEvent(self, spCopy, 'Copy', eventHandled);
  if eventHandled then
    exit;
  Clipboard.Assign(FQRPrinter.GetPage(QRPreview.PageNumber));
end;

{ ----------------------------------------------------------------------------- }
end.
