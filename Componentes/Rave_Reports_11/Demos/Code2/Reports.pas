Unit Reports;

Interface

Uses
  Windows, Classes, Controls, DB, DBCtrls, DBGrids, DBTables, Dialogs, ExtCtrls,
  Forms, Graphics, Grids, Math, Messages, StdCtrls, SysUtils, Variants,
  // used by GetPrinterDriver
  Printers, WinSpool,                   
  RpBase, RpDbUtil, RpDefine, RpDevice, RpMemo, RpSystem, RpRenderHTML, RpRender,
  RpRenderPDF, RpShell, RpLabel;

Type
  TFormReports = Class(TForm)
    btnClose: TButton;
    btnPrintLandscape: TButton;
    btnPrintPortrait: TButton;
    dsBioLife: TDataSource;
    dsCustomer: TDataSource;
    dsOrders: TDataSource;
    lblNevrona1: TLabel;
    MemoDesc: TMemo;
    rgAvailable: TRadioGroup;
    rsCodeBase: TRvSystem;
    RvRenderHTML1: TRvRenderHTML;
    RvRenderPDF1: TRvRenderPDF;
    tBioLife: TTable;
    tCustomer: TTable;
    tOrders: TTable;
    lblNevrona2: TLabel;

    Procedure FormCreate(Sender: TObject);
    Procedure btnCloseClick(Sender: TObject);
    Procedure btnPrintLandscapeClick(Sender: TObject);
    Procedure btnPrintPortraitClick(Sender: TObject);
    Procedure btnPrintCommon(Sender: TObject);
    Procedure rgAvailableClick(Sender: TObject);
    Procedure rsCodeBaseBeforePrint(Sender: TObject);
    Procedure rsCodeBasePrintHeader(Sender: TObject);
    Procedure rsCodeBasePrintFooter(Sender: TObject);

    Procedure rsTestPagePrint(Sender: TObject);
    Function uAutoSize(cFont: String; nPoints: Double; sTemp: String; nWidth: Double): Double;
  private
    { Private declarations }
    Procedure rsBioLifePrint(Sender: TObject);
    Procedure rsMultiLineListPrint(Sender: TObject);
    Procedure rsMasterDetailPrint(Sender: TObject);
  public
    { Public declarations }
    MemoBio: TMemoBuf;
  End;

Var
  FormReports: TFormReports;
  TitleLine: String;                    // text to used as report title
  FooterLine: String;                   // text to be printed on report footer
  RpSysReport: TBaseReport;

Implementation

{$R *.dfm}

Procedure TFormReports.FormCreate(Sender: TObject);
Begin
  //
End;

Procedure TFormReports.btnCloseClick(Sender: TObject);
Begin
  Close;
End;

Procedure TFormReports.btnPrintLandscapeClick(Sender: TObject);
Begin
  rsCodeBase.SystemPrinter.Orientation := poLandscape;
  btnPrintCommon(Sender);
End;

Procedure TFormReports.btnPrintPortraitClick(Sender: TObject);
Begin
  rsCodeBase.SystemPrinter.Orientation := poPortrait;
  btnPrintCommon(Sender);
End;

Procedure TFormReports.btnPrintCommon(Sender: TObject);
Var
  iSelected: Integer;
  sSelected: String;
Begin
  iSelected := rgAvailable.ItemIndex;
  sSelected := UpperCase(rgAvailable.Items.Strings[iSelected]);
  If (Pos('BITMAP', sSelected) > 0) Or (Pos('MEMO', sSelected) > 0) Then Begin
    rsCodeBase.OnPrint := rsBioLifePrint;

  End Else If Pos('LIST', sSelected) > 0 Then Begin
    rsCodeBase.OnPrint := rsMultiLineListPrint;

  End Else If Pos('MASTER', sSelected) > 0 Then Begin
    rsCodeBase.OnPrint := rsMasterDetailPrint;

  End Else If Pos('TEST', sSelected) > 0 Then Begin
    rsCodeBase.OnPrint := rsTestPagePrint; //Printer Test Report
    rsCodeBase.OnBeforePrint := Nil;
    rsCodeBase.OnPrintFooter := Nil;
    rsCodeBase.OnPrintHeader := Nil;
    rsCodeBase.SystemPrinter.MarginBottom := 0.0;
    rsCodeBase.SystemPrinter.MarginLeft := 0.0;
    rsCodeBase.SystemPrinter.MarginRight := 0.0;
    rsCodeBase.SystemPrinter.MarginTop := 0.0;
  End Else Begin
    //ReportTitle := 'Unknown';
  End;
  rsCodeBase.Execute;
  rsCodeBase.OnBeforePrint := rsCodeBaseBeforePrint;
  rsCodeBase.OnPrintHeader := rsCodeBasePrintHeader;
  rsCodeBase.OnPrintFooter := rsCodeBasePrintFooter;
End;

Procedure TFormReports.rgAvailableClick(Sender: TObject);
Var
  iSelected: Integer;
  sSelected: String;
Begin
  iSelected := rgAvailable.ItemIndex;
  sSelected := UpperCase(rgAvailable.Items.Strings[iSelected]);
  TitleLine := 'DEMO';
  FooterLine := 'Rave Code Base Demo';
  btnPrintLandscape.Enabled := True;
  btnPrintPortrait.Enabled := True;
  If (Pos('BITMAP', sSelected) > 0) Or (Pos('MEMO', sSelected) > 0) Then Begin
    TitleLine := 'BioLife';
    FooterLine := 'Rave Code Base Demo with Bitmaps and Memos';
    MemoDesc.Lines.Text := 'FISH FACTS' + #13 +
      'source in rsBioLifePrint - 90 lines' + #13 +
      #13 +
      'This report uses the DbDemos BioLife data table.' + #13 +
      #13 +
      'It shows how to mix graphic, memo and data fields. Data fields ' +
      'are placed before and after the DataMemo field (Notes). Also reads a ' +
      'graphic field from the data table and displays it as a Bitmap. The ' +
      'size of both the bitmap and memo are calculated based upon the page width.';

  End Else If (Pos('LABEL', sSelected) > 0) Then Begin
    btnPrintLandscape.Enabled := False;
    btnPrintPortrait.Enabled := False;
    MemoDesc.Lines.Text := 'LABELS (no demo provided)' + #13 +
      #13 +
      'Rave Reports Users' + #13 +
      #13 +
      'Developer or Architect == version 8.0 or later' + #13 +
      'BEX (Borland Edition eXtended) == version 7.x or earlier' + #13 +
      #13 +
      'All you need to do is drop a LabelShell component on your form and ' +
      'set the properties. The "LabelBrand" property allows you to choose ' +
      'from many of the popular formats. Note, you can set the starting label ' +
      'with the "SkipNum" property.' + #13 +
      #13 +
      'Rave BE (Bundled / Borland Edition) - ALL versions' + #13 +
      #13 +
      'Labels can be done in code, but suggest that you look at the label ' +
      'report example in the visual demo.';

  End Else If (Pos('LIST', sSelected) > 0) Then Begin
    TitleLine := 'List Type Report';
    FooterLine := 'Rave Code Base Demo';
    MemoDesc.Lines.Text := 'LISTING' + #13 +
      'source in rsMultiLineListPrint - 108 lines' + #13 +
      #13 +
      'This report uses the DbDemos Customer data tables.' + #13 +
      #13 +
      'It is a multi-line list report with page breaks and headers. ' +
      'It includes formatting of Currency and Date fields.';

  End Else If (Pos('MASTER', sSelected) > 0) Then Begin
    TitleLine := 'MASTER DETAIL';
    FooterLine := 'Rave Code Base Demo';
    MemoDesc.Lines.Text := 'MASTER-DETAIL' + #13 +
      'source in rsMasterDetailPrint - 181 lines' + #13 +
      #13 +
      'It uses the DbDemos Customer and Orders data tables.' + #13 +
      #13 +
      'It shows Customer information "Master" followed by Order information ' +
      '"Details". It includes formatting of Currency and Date fields.';

  End Else If (Pos('TEST', sSelected) > 0) Then Begin
    btnPrintLandscape.Enabled := False;
    // TitleLine and FooterLine NOT used
    MemoDesc.Lines.Text := 'TEST PAGE' + #13 +
      'source in rsTestPagePrint - 436 lines' + #13 +
      #13 +
      'This report does not use any data tables.' + #13 +
      #13 +
      'This report will exercise the selected Printer and Printer Driver. ' +
      'It intentionally tries to print in the non-printable regions (waste areas)';

  End Else Begin
    btnPrintLandscape.Enabled := False;
    btnPrintPortrait.Enabled := False;
    MemoDesc.Lines.Text := 'Unknown';
  End;
End;

Procedure TFormReports.rsCodeBaseBeforePrint(Sender: TObject);
Begin
  With Sender As TBaseReport Do Begin
    // If necessary - Adjust Margins for printer limitations
    If Orientation = poPortrait Then Begin
      MarginTop := MaxValue([TopWaste, 0.40]);
      MarginLeft := MaxValue([LeftWaste, 0.6]); // Hole Punch Side
      If SupportDuplex Then Begin
        MarginRight := MaxValue([RightWaste, 0.6]);
      End Else Begin
        MarginRight := MaxValue([RightWaste, 0.40]);
      End;                              {if duplex else}
      MarginBottom := MaxValue([BottomWaste, 0.40]);
    End Else Begin
      MarginTop := MaxValue([TopWaste, 0.6]); // Hole Punch Side
      MarginLeft := MaxValue([LeftWaste, 0.5]);
      MarginRight := MaxValue([RightWaste, 0.5]);
      If SupportDuplex Then Begin
        MarginBottom := MaxValue([BottomWaste, 0.6]);
      End Else Begin
        MarginBottom := MaxValue([BottomWaste, 0.35]);
      End;                              {if duplex else}
    End;                                {if portrait else}
  End;                                  {with TBaseReport}
End;

Procedure TFormReports.rsCodeBasePrintHeader(Sender: TObject);
Begin
  With Sender As TBaseReport Do Begin
    // (Sender as TBaseReport).SetFont('Arial', 14);
    SetFont('Arial', 14);
    Bold := True;
    Home;
    PrintCenter(TitleLine, PageWidth / 2.0);
    SetFont('Arial', 9);
    Home;
    If CurrentPage > 1 Then Begin
      PrintRight('Page ' + IntToStr(CurrentPage), SectionRight);
    End;                                {if}
    NewLine;
    PrintRight(FormatDateTime('dddd d mmm yyyy', Date), SectionRight);
    Home;
  End;                                  // With TBaseReport
End;

Procedure TFormReports.rsCodeBasePrintFooter(Sender: TObject);
Begin
  With Sender As TBaseReport Do Begin
    GoToXY(1, PageHeight - BottomWaste);
    PrintCenter(FooterLine, PageWidth / 2.0);
  End;                                  // with TBaseReport
End;

// Report - BioLife - demos Bitmap and memo -------------------------

Procedure TFormReports.rsBioLifePrint(Sender: TObject);
Var
  lDoHeader: Boolean;
  nHeight, nTemp, nWidth, nX1, nY1: Double;
  sTemp: String;
  MyBitmap: TBitmap;
Begin
  MemoBio := TMemoBuf.Create;
  MyBitmap := TBitmap.Create;
  If tBioLife.State = dsInActive Then tBioLife.Active := True;
  With Sender As TBaseReport Do Begin
    lDoHeader := True;
    If PageWidth > 12 Then Begin
      nWidth := PageWidth / 6.5;        // Calculate Width of Bitmap
    End Else Begin
      nWidth := PageWidth / 4.0;        // Calculate Width of Bitmap
    End;
    // Set the Memo Start and Ending positions
    MemoBio.PrintStart := SectionLeft + nWidth + 0.25;
    MemoBio.PrintEnd := SectionRight - 0.5;
    tBioLife.First;
    While Not tBioLife.Eof Do Begin
      // Retrieve the memo then see if it will fit on the current page
      MemoBio.Text := tBioLife.FieldByName('Notes').AsString;
      If LinesLeft < (MemoLines(MemoBio) + 4) Then Begin
        NewPage;                        // Memo does NOT fit - force a new page
        lDoHeader := True;              // Re-Do the Header
      End;
      If lDoHeader Then Begin
        Bold := True;
        NewLine;
        NewLine;
        NewLine;
        PrintLeft('Common Name', SectionLeft + nWidth + 0.25);
        PrintRight('Category', SectionRight - 0.5);
        SetPen(clBlack, psSolid, -2, pmCopy);
        MoveTo(SectionLeft, LineBottom);
        LineTo(SectionRight, LineBottom);
        NewLine;
        NewLine;
        Bold := False;
        lDoHeader := False;
      End;                              // if lDoHeader
      // BioLife table - Available Fields
      // 00 Species_No    8 Float        04 Length_cm     8 Float
      // 01 Category     16 String       05 Length_in     8 Float
      // 02 Common_Name  31 String       06 Notes         - Memo
      // 03 Species_Name 41 String       07 Graphic       - Graphic (BMP)

      // Get the bitmap - size it - print it
      MyBitmap.Assign(TBLOBField(tBioLife.Fields[7]));
      nX1 := SectionLeft;
      nY1 := LineTop;
      nHeight := CalcGraphicHeight(nWidth, MyBitmap); // Height
      PrintBitmapRect(nX1, nY1, nX1 + nWidth, nY1 + nHeight, MyBitmap);
      // Now print two data fields (starting position Top of Graphic)
      PrintLeft(tBioLife.FieldByName('Common_Name').AsString, SectionLeft + nWidth + 0.25);
      PrintRight(tBioLife.FieldByName('Category').AsString, SectionRight - 0.5);
      NewLine;
      NewLine;
      // Print the Memo field
      PrintMemo(MemoBio, 0, False);
      NewLine;
      // Now print 3 data fields "below" the memo
      PrintLeft(tBioLife.FieldByName('Species Name').AsString, SectionLeft + nWidth + 0.25);

      nTemp := tBioLife.FieldByName('Length (cm)').AsFloat;
      sTemp := FloatToStrF(nTemp, ffNumber, 15, 0);
      PrintRight(sTemp + ' cm', SectionRight - 1.5);

      nTemp := tBioLife.FieldByName('Length_in').AsFloat;
      sTemp := FloatToStrF(nTemp, ffNumber, 15, 1);
      PrintRight(sTemp + ' inches', SectionRight - 0.5);
      NewLine;
      // Draw a horizontal line
      SetPen(clBlack, psSolid, -1, pmCopy);
      MoveTo(SectionLeft, LineBottom);
      LineTo(SectionRight, LineBottom);
      NewLine;
      NewLine;
      tBioLife.Next;
    End;                                // While NOT EOF
  End;                                  // With TBaseReport
  MyBitmap.Free;
  tBioLife.Active := False;
End;

// Report - Master-Detail - demo  -----------------------------------

Procedure TFormReports.rsMasterDetailPrint(Sender: TObject);
Var
  lDoHeader, lDoHeaderDetails: Boolean;
  nTemp: Double;
  sTemp: String;
Begin
  // ChildTable.MasterSource := dsParentTable;
  // ChildTable.MasterFields := primarykey;
  // ChildTable.IndexName := primarykey;
  tOrders.MasterSource := dsCustomer;
  tOrders.MasterFields := 'CustNo';
  tOrders.IndexName := 'CustNo';
  tCustomer.IndexName := 'ByCompany';   // CustNo or Company
  If tCustomer.State = dsInActive Then tCustomer.Active := True;
  If tOrders.State = dsInActive Then tOrders.Active := True;
  With Sender As TBaseReport Do Begin
    lDoHeader := True;
    tCustomer.First;
    While Not tCustomer.Eof Do Begin
      If lDoHeader Then Begin
        Bold := True;
        NewLine;
        NewLine;
        NewLine;
        PrintLeft('Number', SectionLeft + 0.25);
        PrintLeft('Company', SectionLeft + 1.0);
        PrintCenter('Tax Rate', SectionLeft + 6.5);
        SetPen(clBlack, psSolid, -2, pmCopy);
        MoveTo(SectionLeft, LineBottom);
        LineTo(SectionRight, LineBottom);
        NewLine;
        NewLine;
        Bold := False;
        lDoHeader := False;
      End;                              // if lDoHeader
      // Customer Table - Available Fields
      // 00 CustNo     8 Float           07 Country       21 String
      // 01 Company   31 String          08 Phone         16 String
      // 02 Addr1     31 String          09 FAX           16 String
      // 03 Addr2     31 String          10 TaxRate        8 Float
      // 04 City      16 String          11 Contact       21 String
      // 05 State     21 String          12 LastInvoiceDate  8 DateTime
      // 06 Zip       11 String

      // Now print customer details
      PrintLeft(tCustomer.FieldByName('CustNo').AsString, SectionLeft + 0.25);
      PrintLeft(tCustomer.FieldByName('Company').AsString, SectionLeft + 1.0);
      sTemp := tCustomer.FieldByName('Phone').AsString + ' Phone';
      PrintRight(sTemp, SectionLeft + 5.25);
      // Get and Format TaxRate if greater than zero
      nTemp := tCustomer.FieldByName('TaxRate').AsFloat;
      sTemp := '-';
      If nTemp > 0 Then Begin
        sTemp := FloatToStrF(nTemp, ffNumber, 15, 5);
      End;
      PrintCenter(sTemp, SectionLeft + 6.5);
      NewLine;

      sTemp := tCustomer.FieldByName('Contact').AsString + '  Contact';
      PrintRight(sTemp, SectionLeft + 5.31);
      // Only print address line 1 if it is NOT blank
      sTemp := tCustomer.FieldByName('Addr1').AsString;
      If Length(sTemp) > 0 Then Begin
        PrintLeft(sTemp, SectionLeft + 1.0);
        NewLine;
      End;
      // Only print address line 2 if it is NOT blank
      sTemp := tCustomer.FieldByName('Addr2').AsString;
      If Length(sTemp) > 0 Then Begin
        PrintLeft(sTemp, SectionLeft + 1.0);
        NewLine;
      End;

      // Only print address line 2 if it is NOT blank
      sTemp := tCustomer.FieldByName('Country').AsString;
      If sTemp = 'US' Then Begin
        // Combine / format the City State Zip line
        sTemp := tCustomer.FieldByName('City').AsString + ', ' +
          tCustomer.FieldByName('State').AsString + ' ' +
          tCustomer.FieldByName('Zip').AsString;
      End Else Begin
        sTemp := tCustomer.FieldByName('City').AsString + ', ' +
          tCustomer.FieldByName('Country').AsString + ' ' +
          tCustomer.FieldByName('Zip').AsString;
      End;
      PrintLeft(sTemp, SectionLeft + 1.0);

      // Always put FAX number to right of city state line
      sTemp := tCustomer.FieldByName('FAX').AsString + ' FAX';
      PrintRight(sTemp, SectionLeft + 5.125);
      // Format Last Invoice Date
      PrintCenter(FormatDateTime('ddd d mmm yyyy',
        tCustomer.FieldByName('LastInvoiceDate').AsFloat), SectionLeft + 6.5);
      NewLine;

      // Now do the Details loop ------------------------------------
      lDoHeaderDetails := True;
      While Not tOrders.Eof Do Begin
        If lDoHeaderDetails Then Begin
          Bold := True;
          NewLine;
          PrintLeft('Order No', SectionLeft + 1.0);
          PrintRight('Ship Date', SectionLeft + 2.5);
          PrintRight('Items', SectionLeft + 4.75);
          PrintRight('Freight', SectionLeft + 5.75);
          PrintRight('Paid', SectionLeft + 6.75);
          SetPen(clBlack, psSolid, -1, pmCopy);
          MoveTo(SectionLeft + 1.0, LineBottom);
          LineTo(SectionRight, LineBottom);
          NewLine;
          Bold := False;
          lDoHeaderDetails := False;
        End;                            // if do Details Headers
        // Orders Table - Available Fields
        // 00 OrderNo        8 Float          11 ShipToCountry  21 String
        // 01 CustNo         8 Float          12 ShipToPhone    16 String
        // 02 SaleDate       8 DateTime       13 ShipVIA         8 String
        // 03 ShipDate       8 DateTime       14 PO             16 String
        // 04 EmpNo          4 Integer        15 Terms           7 String
        // 05 ShipToContact 21 String         16 PaymentMethod   8 String
        // 06 ShipToAddr1   31 String         17 ItemsTotal      8 Currency
        // 07 ShipToAddr2   31 String         18 TaxRate         8 Float
        // 08 ShipToCity    16 String         19 Freight         8 Currency
        // 09 ShipToState   21 String         20 AmountPaid      8 Currency
        // 10 ShipToZip     11 String

        //PrintLeft(tOrders.FieldByName('CustNo').AsString, SectionLeft + 0.25);
        PrintLeft(tOrders.FieldByName('OrderNo').AsString, SectionLeft + 1.0);
        // Get and Format ShipDate
        PrintRight(FormatDateTime('dd mmm yyyy',
          tOrders.FieldByName('ShipDate').AsFloat), SectionLeft + 2.5);
        // Get and Format ItemsTotal if greater than zero
        nTemp := tOrders.FieldByName('ItemsTotal').AsFloat;
        sTemp := '-';
        If nTemp > 0 Then Begin
          sTemp := FloatToStrF(nTemp, ffNumber, 15, 2);
        End;
        PrintRight(sTemp, SectionLeft + 4.75);
        // Get and Format Freight if greater than zero
        nTemp := tOrders.FieldByName('Freight').AsFloat;
        sTemp := '-';
        If nTemp > 0 Then Begin
          sTemp := FloatToStrF(nTemp, ffNumber, 15, 2);
        End;
        PrintRight(sTemp, SectionLeft + 5.75);
        // Get and Format AmountPaid if greater than zero
        nTemp := tOrders.FieldByName('AmountPaid').AsFloat;
        sTemp := '-';
        If nTemp > 0 Then Begin
          sTemp := FloatToStrF(nTemp, ffNumber, 15, 2);
        End;
        PrintRight(sTemp, SectionLeft + 6.75);
        // if you want to do calculations, you could do that with Delphi code
        // nTotal := nTotal + nTemp;
        NewLine;
        tOrders.Next;
        If LinesLeft < 1 Then Begin
          NewPage;                      // if does NOT fit - force a new page
          NewLine;
          NewLine;
          NewLine;
          lDoHeader := True;            // Re-Do the Header
          lDoHeaderDetails := True;     // Re-Do the Header
        End;
      End;                              // While tOrders Not EOF

      // Draw a horizontal line
      SetPen(clBlack, psSolid, -3, pmCopy);
      MoveTo(SectionLeft, LineBottom);
      LineTo(SectionRight, LineBottom);
      NewLine;
      NewLine;
      tCustomer.Next;                   // Get the next Customer

      If LinesLeft < (6 + tOrders.RecordCount) Then Begin
        NewPage;                        // if does NOT fit - force a new page
        lDoHeader := True;              // Re-Do the Header
      End;
    End;                                // While NOT EOF
  End;                                  // With TBaseReport
  tCustomer.Active := False;
  tOrders.Active := False;
End;

// Report - Multi-Line List style - demos  --------------------------

Procedure TFormReports.rsMultiLineListPrint(Sender: TObject);
Var
  lDoHeader: Boolean;
  nTemp: Double;
  sTemp: String;
Begin
  If tCustomer.State = dsInActive Then tCustomer.Active := True;
  With Sender As TBaseReport Do Begin
    lDoHeader := True;
    tCustomer.IndexName := 'ByCompany'; // CustNo or Company
    tCustomer.First;
    While Not tCustomer.Eof Do Begin
      If lDoHeader Then Begin
        Bold := True;
        NewLine;
        NewLine;
        NewLine;
        PrintLeft('Number', SectionLeft + 0.25);
        PrintLeft('Company', SectionLeft + 1.0);
        PrintCenter('Tax Rate', SectionLeft + 6.5);
        SetPen(clBlack, psSolid, -2, pmCopy);
        MoveTo(SectionLeft, LineBottom);
        LineTo(SectionRight, LineBottom);
        NewLine;
        NewLine;
        Bold := False;
        lDoHeader := False;
      End;                              // if lDoHeader
      // Customer table - Available Fields
      // 00 CustNo     8 Float        07 Country     21 String
      // 01 Company   31 String       08 Phone       16 String
      // 02 Addr1     31 String       09 FAX         16 String
      // 03 Addr2     31 String       10 TaxRate      8 Float
      // 04 City      16 String       11 Contact     21 String
      // 05 State     21 String       12 LastInvoiceDate  8 DateTime
      // 06 Zip       11 String

      // Now print customer details
      PrintLeft(tCustomer.FieldByName('CustNo').AsString, SectionLeft + 0.25);
      PrintLeft(tCustomer.FieldByName('Company').AsString, SectionLeft + 1.0);
      sTemp := tCustomer.FieldByName('Phone').AsString + ' Phone';
      PrintRight(sTemp, SectionLeft + 5.25);

      nTemp := tCustomer.FieldByName('TaxRate').AsFloat;
      If nTemp > 0 Then Begin
        sTemp := FloatToStrF(nTemp, ffNumber, 15, 5);
        PrintCenter(sTemp, SectionLeft + 6.5);
      End;
      NewLine;

      sTemp := tCustomer.FieldByName('Contact').AsString + '  Contact';
      PrintRight(sTemp, SectionLeft + 5.31);
      // Only print address line 1 if it is NOT blank
      sTemp := tCustomer.FieldByName('Addr1').AsString;
      If Length(sTemp) > 0 Then Begin
        PrintLeft(sTemp, SectionLeft + 1.0);
        NewLine;
      End;
      // Only print address line 2 if it is NOT blank
      sTemp := tCustomer.FieldByName('Addr2').AsString;
      If Length(sTemp) > 0 Then Begin
        PrintLeft(sTemp, SectionLeft + 1.0);
        NewLine;
      End;

      // Only print address line 2 if it is NOT blank
      sTemp := tCustomer.FieldByName('Country').AsString;
      If sTemp = 'US' Then Begin
        // Combine / format the City State Zip line
        sTemp := tCustomer.FieldByName('City').AsString + ', ' +
          tCustomer.FieldByName('State').AsString + ' ' +
          tCustomer.FieldByName('Zip').AsString;
      End Else Begin
        sTemp := tCustomer.FieldByName('City').AsString + ', ' +
          tCustomer.FieldByName('Country').AsString + ' ' +
          tCustomer.FieldByName('Zip').AsString;
      End;

      PrintLeft(sTemp, SectionLeft + 1.0);

      // Always put FAX number to right of city state line
      sTemp := tCustomer.FieldByName('FAX').AsString + ' FAX';
      PrintRight(sTemp, SectionLeft + 5.125);

      PrintCenter(FormatDateTime('ddd d mmm yyyy',
        tCustomer.FieldByName('LastInvoiceDate').AsFloat), SectionLeft + 6.5);
      NewLine;

      // Draw a horizontal line
      SetPen(clBlack, psSolid, -1, pmCopy);
      MoveTo(SectionLeft, LineBottom);
      LineTo(SectionRight, LineBottom);
      NewLine;
      NewLine;
      If LinesLeft < 4 Then Begin
        NewPage;                        // if does NOT fit - force a new page
        lDoHeader := True;              // Re-Do the Header
      End;
      tCustomer.Next;
    End;                                // While NOT EOF
  End;                                  // With TBaseReport
  tCustomer.Active := False;
End;

// Report - Test Page in color - exercise printer driver ------------

Procedure TFormReports.rsTestPagePrint(Sender: TObject);
Const
  PlatNames: Array[0..2] Of String = ('Win32s', 'Windows 95', 'Windows NT');
Var
  OVI: TOsVersionInfo;
  iBuild, iTemp: Integer;
  //iBlue, iGreen, iRed, iX, iY
  nBottom, nLeft, nRight, nTemp, nTop: Double;
  sName, sPrtName, sTemp, sX1, sX2, sY1, sY2: String;
  iMin, iMax: TPoint;
  // get printer driver information
  hPrinter: THandle;
  Count: DWORD;
  Buffer: PChar;

Begin
  // All parts of this printout have been included because some OS and
  // printer driver combination have had problems with one or more of
  // these capabilities.
  RpSysReport := Sender As TBaseReport;
  With Sender As TBaseReport Do Begin
    NoNTColorFix := True;               // True = Disable NT Color Conversion
    SetFont('Arial', 8);

    // Draw series of Red thin line boxes (0.1 inch spacing)
    SetPen(clRed, psSolid, -1, pmCopy); // 21 Sep 2002
    nLeft := PageWidth * 0.25;
    nTemp := PageHeight * 4 / 11;
    For iTemp := 1 To 10 Do Begin
      If iTemp = 1 Then SetPen(clBlue, psSolid, -1, pmCopy);
      If iTemp = 2 Then SetPen(clRed, psSolid, -1, pmCopy);
      If iTemp = 3 Then SetPen(clGreen, psSolid, -1, pmCopy);
      If iTemp = 4 Then SetPen(clOlive, psSolid, -1, pmCopy);
      If iTemp = 5 Then SetPen(clLime, psSolid, -1, pmCopy);
      If iTemp = 6 Then SetPen(clAqua, psSolid, -1, pmCopy);
      If iTemp = 7 Then SetPen(clYellow, psSolid, -1, pmCopy);
      If iTemp = 8 Then SetPen(clGray, psSolid, -1, pmCopy);
      If iTemp = 9 Then SetPen(clBlack, psDash, 1, pmCopy);
      If iTemp = 10 Then SetPen(clBlack, psSolid, -1, pmCopy);
      SectionBottom := SectionBottom - 0.1;
      SectionLeft := SectionLeft + 0.1;
      SectionRight := SectionRight - 0.1;
      SectionTop := SectionTop + 0.1;
      // Draw Box around edge of paper
      Rectangle(SectionLeft, SectionTop, SectionRight, SectionBottom);
      GoToXY(SectionLeft, SectionTop + 0.08);
      PrintLeft(IntToStr(iTemp), SectionLeft + nLeft + 0.2 * iTemp);
      If iTemp = 1 Then PrintLeft('Blue', SectionLeft + 1.2);
      If iTemp = 2 Then PrintLeft('Red', SectionLeft + 1.1);
      If iTemp = 3 Then PrintLeft('Green', SectionLeft + 1.0);
      If iTemp = 4 Then PrintLeft('Olive', SectionLeft + 0.9);
      If iTemp = 5 Then PrintLeft('Lime', SectionLeft + 0.8);
      If iTemp = 6 Then PrintLeft('Aqua', SectionLeft + 0.7);
      If iTemp = 7 Then PrintLeft('Yellow', SectionLeft + 0.6);
      If iTemp = 8 Then PrintLeft('Gray', SectionLeft + 0.5);
      If iTemp = 9 Then PrintLeft('Black Dash', SectionLeft + 0.4);
      If iTemp = 10 Then PrintLeft('Black Solid', SectionLeft + 0.3);
      GoToXY(SectionLeft, nTemp + 0.2 * iTemp);
      PrintLeft(IntToStr(iTemp), SectionLeft);
    End;                                {for}

    // Draw Thicker Black Line Box AT waste settings
    SetPen(clBlack, psSolid, -2, pmCopy);
    Rectangle(LeftWaste, TopWaste, PageWidth - RightWaste, PageHeight - BottomWaste);

    // Print in center Title
    GoToXY(SectionLeft, (PageHeight * 3.33 / 11.0));
    SetFont('Arial', 10);
{$IFDEF VER130}
    sTemp := '5';
{$ENDIF}
{$IFDEF VER140}
    sTemp := '6';
{$ENDIF}
{$IFDEF VER150}
    sTemp := '7';
{$ENDIF}
    PrintCenter('Version ' + sTemp + '.511.a', PageWidth / 2.0);
    sTemp := 'Printer Driver Test';
    uAutoSize('Arial', 48, sTemp, PageWidth - 2.5);

    NewLine;
    LineBottom := (2 * LineMiddle + LineBottom) / 3.0;
    PrintCenter(sTemp, PageWidth / 2.0);

    // Print in center Printer Driver Name
    iTemp := PrinterIndex;
    sPrtName := Printers[iTemp];
    uAutoSize('Arial', 24, sPrtName, PageWidth - 2.5);
    NewLine;
    PrintCenter(sPrtName, PageWidth / 2.0);
    SetFont('Arial', 8);
    NewLine;

    // Open Printer Driver and Get Info
    If OpenPrinter(PChar(sPrtName), hPrinter, Nil) Then Try
      // retrieve size needed
      GetPrinterDriver(hPrinter, Nil, 2, Nil, Count, Count);
      If Count > 0 Then Begin
        GetMem(Buffer, Count);
        Try
          // Retrieve aAtual Driver Data
          GetPrinterDriver(hPrinter, Nil, 2, PByte(Buffer), Count, Count);
          //sTemp := 'Name: ' + PDriverInfo2(Buffer).pName;
          //PrintCenter(sTemp, PageWidth / 2.0);
          //NewLine;
          sTemp := 'Version: ' + IntToStr(PDriverInfo2(Buffer)^.cVersion) +
            '     Environment: ' + PDriverInfo2(Buffer)^.pEnvironment;
          PrintCenter(sTemp, PageWidth / 2.0);
          NewLine;
          sTemp := 'Path: ' + PDriverInfo2(Buffer)^.pDriverPath;
          PrintCenter(sTemp, PageWidth / 2.0);
          NewLine;
          sTemp := 'DataPath: ' + PDriverInfo2(Buffer)^.pDataFile;
          PrintCenter(sTemp, PageWidth / 2.0);
          NewLine;
          sTemp := 'Config ' + PDriverInfo2(Buffer)^.pConfigFile;
          PrintCenter(sTemp, PageWidth / 2.0);
          NewLine;
          NewLine;
        Finally
          FreeMem(Buffer, Count);
        End;
      End;
    Finally
      ClosePrinter(hPrinter);
    End;

    // Get then Print in center OS info
    SetFont('Arial', 24);

    // OSVERSIONINFO osvi;
    // char  szVersion [80];
    // memset(&osvi, 0, sizeof(OSVERSIONINFO));
    // osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
    // GetVersionEx (&osvi);

    OVI.dwOSVersionInfoSize := SizeOf(OVI);
    // Get / Display Operating System Version Information
    GetVersionEx(OVI);

    // (high-order word contains major and minor version numbers.)
    // Operating System build number in low-order word.
    // dwBuildNumber - is in 3rd low order word
    iBuild := (OVI.dwBuildNumber And $FFFF);
    sName := PlatNames[OVI.dwPlatformId];
    // Change Windows OS Name if it is Win98, WinME or Win2000
    If (OVI.dwPlatformId = 1) Then Begin
      If (OVI.dwMinorVersion > 89) Then Begin
        If iBuild = 3000 Then Begin
          sName := 'Windows Millennium Edition';
        End Else Begin
          sName := 'Windows ME';
        End;
      End Else If (OVI.dwMinorVersion > 9) Then Begin
        If iBuild = 2222 Then Begin
          sName := 'Windows 98 Second Edition';
        End Else Begin
          sName := 'Windows 98';
        End;
      End;                              {if else}
    End;                                {if}
    If (OVI.dwPlatformId = 2) And (OVI.dwMajorVersion = 5) Then Begin
      If iBuild = 2195 Then Begin
        sName := 'Windows 2000';
      End Else If iBuild = 2151 Then Begin
        sName := 'Windows 2000 RC3';
      End Else If iBuild = 2128 Then Begin
        sName := 'Windows 2000 RC2';
      End Else If iBuild < 2195 Then Begin
        sName := 'Windows 2000 RC/Beta';
      End Else Begin
        sName := 'Windows 2000';
      End;                              {if else}
    End;                                {if}
    {szCSDVersion Contains a zero-terminated string that provides
     arbitrary additional information about operating system.}
    sTemp := ' ' + TRIM(sName + ' ' + OVI.szCSDVersion) + ' (' +
      Format('Version %u.%.2u Build %u',
      [OVI.dwMajorVersion, OVI.dwMinorVersion, iBuild]) + ')';
    uAutoSize('Arial', 24, sTemp, PageWidth - 2.5);
    PrintCenter(sTemp, PageWidth / 2.0);

    // Now test and report supported custom paper sizes
    SetFont('Arial', 10);
    RPDev.GetCustomExtents(iMin, iMax);
    sX1 := FloatToStrF(iMin.X / 254, ffNumber, 15, 3);
    sX2 := FloatToStrF(iMax.X / 254, ffNumber, 15, 3);
    sY1 := FloatToStrF(iMin.Y / 254, ffNumber, 15, 3);
    sY2 := FloatToStrF(iMax.Y / 254, ffNumber, 15, 3);
    NewLine;
    PrintCenter('Custom Paper Size Support', PageWidth / 2.0);
    If (iMin.X + iMin.y + iMax.X + iMax.Y) > 1 Then Begin
      sTemp := 'Widths = ' + sX1 + ' to ' + sX2;
      uAutoSize('Arial', 10, sTemp, PageWidth - 2.5);
      NewLine;
      PrintCenter(sTemp, PageWidth / 2.0);

      sTemp := 'Heights = ' + sY1 + ' to ' + sY2;
      uAutoSize('Arial', 10, sTemp, PageWidth - 2.5);
    End Else Begin
      sTemp := 'NOT supported';
    End;
    NewLine;
    PrintCenter(sTemp, PageWidth / 2.0);
    If Not SupportPaper(DMPAPER_USER) Then Begin
      FontColor := clRed;
      NewLine;
      PrintCenter('Driver Reports NO Custom Size Support', PageWidth / 2.0);
    End;

    // Print some graphic shapes with and without lines
    // create yellow box with NO lines
    SetPen(clNone, psClear, 1, pmCopy); // 21 Sep 2002
    SetBrush(clYellow, bsSolid, Nil);
    nLeft := 1.1;
    nRight := nLeft + MinValue([2.0, (PageWidth / 4.0)]);

    Rectangle(nLeft, nLeft, nRight, nRight);

    SetBrush(clSilver, bsSolid, Nil);
    Rectangle(nLeft + 0.5, nLeft + 0.5, nRight - 0.5, nRight - 0.5);
    // create yellow ellipse
    SetBrush(clYellow, bsSolid, Nil);
    SetPen(clRed, psSolid, -4, pmCopy);
    nTop := MinValue([1.75, (PageHeight * 1.75 / 11.0)]);
    nLeft := MinValue([4.0, (PageWidth * 4.0 / 8.5)]);
    nRight := MinValue([7.0, (PageWidth * 7.0 / 8.5)]);
    nBottom := MinValue([3.25, (PageHeight * 3.25 / 11.0)]);
    Ellipse(nLeft, nTop, nRight, nBottom);

    SetPen(clSilver, psSolid, -1, pmCopy);
    SetBrush(clSilver, bsSolid, Nil);
    nTop := MinValue([2.0, (PageHeight * 2.0 / 11.0)]);
    nLeft := MinValue([5.0, (PageWidth * 5.0 / 8.5)]);
    nRight := MinValue([6.0, (PageWidth * 6.0 / 8.5)]);
    nBottom := MinValue([3.0, (PageHeight * 3.0 / 11.0)]);
    Ellipse(nLeft, nTop, nRight, nBottom);

    // Print waste margin numbers
    SetFont('Arial', 18);
    GoToXY(2.0, 1.25);
    sTemp := FloatToStrF(TopWaste, ffNumber, 15, 4);
    PrintCenter(sTemp, PageWidth / 2.0);
    GoToXY(1.2, PageHeight / 2.0);
    sTemp := FloatToStrF(LeftWaste, ffNumber, 15, 4);
    Print(sTemp);
    GoToXY(PageWidth - 1.9, PageHeight / 2.0);
    sTemp := FloatToStrF(RightWaste, ffNumber, 15, 4);
    Print(sTemp);
    GoToXY(2.0, PageHeight - 1.1);
    sTemp := FloatToStrF(BottomWaste, ffNumber, 15, 4);
    PrintCenter(sTemp, PageWidth / 2.0);

    // Draw solid boxes (0.1 inch wide) at each waste margin
    SetBrush(clRed, bsSolid, Nil);
    SetPen(clNone, psClear, 1, pmCopy); // 21 Sep 2002
    nLeft := (PageWidth / 2.0) - 1.0;
    Rectangle(nLeft, TopWaste, nLeft + 2.0, TopWaste + 0.1);
    nTemp := PageHeight - BottomWaste;
    Rectangle(nLeft, nTemp, nLeft + 2.0, nTemp - 0.1);
    nLeft := (PageHeight / 2.0) - 1.0;
    Rectangle(LeftWaste, nLeft, LeftWaste + 0.1, nLeft + 2.0);
    nTemp := PageWidth - RightWaste;
    Rectangle(nTemp, nLeft, nTemp - 0.1, nLeft + 2.0);

    SetFont('Arial', 8);
    GoToXY(2.0, 1.5);
    sTemp := 'It is possible that the words LEFT, RIGHT, TOP, BOTTOM';
    PrintCenter(sTemp, PageWidth - 3.0);
    NewLine;
    sTemp := 'may be missing or cut in half by the waste margin line';
    PrintCenter(sTemp, PageWidth - 3.0);

    // Print words on left & right waste margin
    SetFont('Courier New', 36);
    Bold := True;
    nLeft := LeftWaste + 0.01;
    nRight := PageWidth - RightWaste;
    GoToXY(nLeft, 1.0);
    PrintCenter('L', nLeft);
    PrintCenter('R', nRight);
    NewLine;
    PrintCenter('E', nLeft);
    PrintCenter('I', nRight);
    NewLine;
    PrintCenter('F', nLeft);
    PrintCenter('G', nRight);
    NewLine;
    PrintCenter('T', nLeft);
    PrintCenter('H', nRight);
    NewLine;
    PrintCenter('T', nRight);

    LineMiddle := TopWaste;
    PrintCenter('TOP', PageWidth - 2.0);

    LineMiddle := (PageHeight - BottomWaste);
    PrintCenter('BOTTOM', PageWidth - 2.0);

    // Print Angled Text in Colors
    SetFont('Courier New', 12);
    GoToXY(2.0, (PageHeight * 3.75 / 11.0));
    sTemp := '01234567890';
    PrintLeft(sTemp, 0.0);
    sTemp := '09876543210';
    PrintRight(sTemp, PageWidth);

    // Draw solid boxes (0.1 inch wide) going thru each waste margin
    SetBrush(clGreen, bsSolid, Nil);
    SetPen(clNone, psClear, 1, pmCopy); // 21 Sep 2002
    nLeft := PageWidth * 0.25;
    Rectangle(nLeft, 0, nLeft + 0.1, 1.0);
    nTemp := PageHeight - 1.0;
    Rectangle(nLeft, nTemp, nLeft + 0.1, PageHeight);
    nLeft := (PageHeight * 0.75);
    Rectangle(0, nLeft, 1.0, nLeft + 0.1);
    nTemp := PageWidth - 1.0;
    Rectangle(nTemp, nLeft, PageWidth, nLeft + 0.1);

    // Print Angled Text in Colors
    SetFont('Arial', 36);
    FontRotation := 45;
    nLeft := 0.9;
    nTemp := (PageWidth * 0.6 / 8.5);
    GoToXY(nLeft + nTemp * 1, PageHeight - 4.0);
    FontColor := clBlue;                // RGB(192,192,64);
    Print('Blue');
    GoToXY(nLeft + nTemp * 2, PageHeight - 4.0);
    FontColor := clRed;
    Print('Red');
    GoToXY(nLeft + nTemp * 3, PageHeight - 4.0);
    FontColor := clGreen;
    Print('Green');
    GoToXY(nLeft + nTemp * 4, PageHeight - 4.0);
    FontColor := clOlive;
    Print('Olive');
    GoToXY(nLeft + nTemp * 5, PageHeight - 4.0);
    FontColor := clLime;
    Print('Lime');
    GoToXY(nLeft + nTemp * 6, PageHeight - 4.0);
    FontColor := clAqua;
    Print('Aqua');
    GoToXY(nLeft + nTemp * 7, PageHeight - 4.0);
    FontColor := clYellow;
    Print('Yellow');
    GoToXY(nLeft + nTemp * 8, PageHeight - 4.0);
    FontColor := clSilver;
    Print('Silver');
    GoToXY(nLeft + nTemp * 9, PageHeight - 4.0);
    FontColor := clGray;
    Print('Gray');

    SetFont('Arial', 18);
    FontRotation := 0;

    // Print two columns of colored text
    GoToXY(1.0, PageHeight - 3.6);      // 7.4
    SetFont('Arial', 18);
    FontColor := clBlue;
    PrintCenter('Blue', LeftWaste + 1.5);
    PrintCenter('Blue', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clRed;
    PrintCenter('Red', LeftWaste + 1.5);
    PrintCenter('Red', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clGreen;
    PrintCenter('Green', LeftWaste + 1.5);
    PrintCenter('Green', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clOlive;
    PrintCenter('Olive', LeftWaste + 1.5);
    PrintCenter('Olive', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clLime;
    PrintCenter('Lime', LeftWaste + 1.5);
    PrintCenter('Lime', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clAqua;
    PrintCenter('Aqua', LeftWaste + 1.5);
    PrintCenter('Aqua', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clYellow;
    PrintCenter('Yellow', LeftWaste + 1.5);
    PrintCenter('Yellow', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clSilver;
    PrintCenter('Silver', LeftWaste + 1.5);
    PrintCenter('Silver', PageWidth - RightWaste - 1.5);
    NewLine;
    FontColor := clGray;
    PrintCenter('Gray', LeftWaste + 1.5);
    PrintCenter('Gray', PageWidth - RightWaste - 1.5);

    // Print center column of "bullets"
    GoToXY(2.0, PageHeight - 3.6);
    SetFont('Symbol', 14);
    FontColor := clBlack;
    nTemp := (PageWidth / 2.0) - 0.9;
    PrintCenter(Chr(183), nTemp);       // Bullet - Dot
    NewLine;
    PrintCenter(Chr(184), nTemp);       // Division
    NewLine;
    PrintCenter(Chr(185), nTemp);       // Not Equal
    NewLine;
    PrintCenter(Chr(196), nTemp);       // Circle Cross
    NewLine;
    PrintCenter(Chr(197), nTemp);       // Circle Cross
    NewLine;
    PrintCenter(Chr(210), nTemp);       // Registered Mark
    NewLine;
    PrintCenter(Chr(211), nTemp);       // CopyRight Mark
    NewLine;
    PrintCenter(Chr(212), nTemp);       // Trade Mark

    GoToXY(2.0, PageHeight - 3.6);
    SetFont('Arial', 14);
    nTemp := (PageWidth / 2.0) - 0.6;
    PrintLeft('183 - Dot', nTemp);
    NewLine;
    PrintLeft('184 - Division', nTemp);
    NewLine;
    PrintLeft('185 - Not Equal', nTemp);
    NewLine;
    PrintLeft('196 - Circle X', nTemp);
    NewLine;
    PrintLeft('197 - Circle Cross', nTemp);
    NewLine;
    PrintLeft('210 - Registered', nTemp);
    NewLine;
    PrintLeft('211 - CopyRight', nTemp);
    NewLine;
    PrintLeft('212 - Trade Mark', nTemp);
  End;                                  {with RpSysReport}
  // No Tables Opened
End;

Function TFormReports.uAutoSize(cFont: String; nPoints: Double; sTemp: String;
  nWidth: Double): Double;              // --------------------------
Begin
  //With RpSysReport As TBaseReport Do Begin
  RpSysReport.SetFont(cFont, nPoints);
  While RpSysReport.TextWidth(sTemp) >= nWidth Do Begin
    nPoints := nPoints - 0.1;
    RpSysReport.SetFont(cFont, nPoints);
  End;                                  {while}
  //End;                                  {with}
  Result := nPoints;
End;

End.

