unit QRNewXLSXFilt;
////////////////////////////////////////////////////////////////////////////
//  Unit : QRNewXLSXFilt
//
//  TQRNewXMLSSAbstractExportFilter -> TQRXLSXDocumentFilter
//
//  The XLSX Export document for XL spreadsheet -
//
//  (c) 2014 QBS Software
//
//
////////////////////////////////////////////////////////////////////////////
{$include QRDefs.inc}
interface
uses windows, classes, controls, stdctrls, sysutils, graphics, buttons,
     forms, extctrls, dialogs, printers, db, ComCtrls,
     QRPrntr, Quickrpt, QR5Const, qrctrls, grids{$ifndef DXE}, system.UITypes, system.zip{$endif};

const
     CRLF = chr($0D) + chr($0A);
     // ascii
     ORD0 = ord('0');
     ORDA = ord('A');
type
   XLXSTextItem = record
       row, col : integer;
       X,Y : extended;
       text, fontname : string;
       exportAs : TExporttype;
       fontbold, fontitalic, fontstrike : boolean;
       fontsize : integer;
       fontcolor : TColor;
       controlName : string;
       XLNumFormat : TXLNumFormat;
   end;

  TQXLSXAbstractExportFilter = class(TQRExportFilter)
  private
    FStream : TStream;
    FLineCount,
    FColCount : integer;
    FPageProcessed : boolean;
  protected
    function GetText(X, Y : extended; var Font : graphics.TFont) : string;
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    procedure WriteToStream(const AText : string);
    procedure WriteLnToStream(const AText : string);
    procedure CreateStream(Filename : string); virtual;
    procedure CloseStream; virtual;
    procedure ProcessPage; virtual;
    procedure StorePage; virtual;
    property Stream : TStream read FStream write FStream;
    property PageProcessed : boolean read FPageProcessed write FPageProcessed;
    property LineCount : integer read FLineCount write FLineCount;
    property ColCount : integer read FColCount write FColCount;
  public
    constructor Create( filename : string );override;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure Finish; override;
    procedure EndPage; override;
    procedure NewPage; override;
    //procedure TextOut(X, Y : extended; Text : string; exportAs : TExportType; xlColumn : integer);virtual;
  end;

  TQRXLSXDocumentFilter = class(TQXLSXAbstractExportFilter)
  private
    FFreeStream : boolean;
    // doc filter properties
    FLastRecordNum : longint;
    FPagenumber : longint;
    //FDocType : string;
    //FCreator : string;
    FTitle : string;
    //FAuthor,
    FLastAuthor,
    FCreated,
    FLastSaved,
    FXLStyleURL : string;
    FConcatenating : boolean;
    FXLEncoding: string;
    FItems : array of XLXSTextItem;
    FSortList : TStringlist;
    FStylenames : TStringlist;
    FFontTags : TStringlist;
    FItemcount : integer;
    // the xml files requited for xlsx
    Content_Types : TStringlist;// in /root ([Content_Types].xml
    dotrels : TStringlist;  // /root/_rels  (.rels is xml )
    app : TStringlist; // /root/docProps
    core : TStringlist; // /root/docProps
    sharedStrings : TStringlist; // /root/xl
    styles : TStringlist; // /root/xl
    workbook : TStringlist;// /root/xl
    theme1 : TStringlist; // /root/xl/theme
    sheet1 : TStringlist; // /root/xl/worksheets
    workbook_xml_rels  : TStringlist; // /root/xl/.rels

    celldupcheck : TStringlist;

    FPageYOffset : extended;
    FMaxYValue : extended;
    rowno, colno, maxcols : integer;
    procedure SetWorkSheetName( value : string);
    function getWorkSheetName: string;
{$ifdef NOT_USED_YET}
    procedure SetCreator( value : string);
    function getCreator: string;
    function getAuthor: string;
    procedure SetAuthor( value : string);
    procedure SetCompany( value : string);
    function getCompany: string;
    procedure SetOpenWidth( value : integer);
    function getOpenWidth: integer;
    function getOpenHeight: integer;
    procedure SetOpenHeight( value : integer);
{$endif}
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    function GetStreaming : boolean; override;
    procedure CreateStream(Filename : string); override;
    procedure CloseStream; override;
    procedure ProcessItems;
    procedure LoadProlog;
    procedure ProcessPage; override;
 public
    constructor Create( filename : string );override;
    destructor Destroy; override;
    procedure TextOutRec( ExportInfo : TExportInfoRec); override;
    procedure NewDocument( doclist : TStringlist; PaperWidth, PaperHeight : double;
              Papername, orient : string);
    //procedure TextOut(X, Y : extended; Text : string; exportAs : TExportType; xlColumn : integer);override;
    procedure SetColWidths( startcol, endcol : integer; cwidth : extended );
    procedure Start(PaperWidth, PaperHeight : integer; Font : graphics.TFont); override;
    procedure EndConcat;
    procedure Finish; override;
    procedure NewPage; override;
    procedure EndPage; override;
    procedure SetDocumentProperties( author, title, company : string );
    property Stream;
    property FreeStream : boolean read FFreeStream write FFreeStream;
    property Title : string read FTitle write FTitle;
    property LastAuthor : string read FLastAuthor write FLastAuthor;
    property Created : string read FCreated write FCreated;
    property LastSaved : string read FLastSaved write FLastSaved;
    property XLEncoding: string read FXLEncoding write FXLEncoding;
    property XLStyleURL : string read FXLStyleURL write FXLStyleURL;
    property Concatenating : boolean read FConcatenating write FConcatenating;
{$ifdef NOT_USED_YET}
    property OpenWidth : integer read getOpenWidth  write setOpenWidth;
    property OpenHeight : integer read getOpenHeight  write setOpenHeight;
    property Creator : string read getCreator write setCreator;
    property Author : string read getAuthor write setAuthor;
    property Company : string read getCompany write setCompany;
{$endif}
    property WorkSheetname : string read getWorkSheetname write setWorkSheetname;
  end;

  TQRXLSXFilter = class(TComponent)
  private
    procedure SetWorkSheetName( value : string);
    function getWorkSheetName: string;
{$ifdef NOT_USED_YET}
    procedure SetCreator( value : string);
    function getCreator: string;
    function getAuthor: string;
    procedure SetAuthor( value : string);
    procedure SetCompany( value : string);
    function getCompany: string;
    procedure SetOpenWidth( value : integer);
    function getOpenWidth: integer;
    function getOpenHeight: integer;
    procedure SetOpenHeight( value : integer);
{$endif}
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
{$ifdef NOT_USED_YET}
    property OpenWidth : integer read getOpenWidth  write setOpenWidth;
    property OpenHeight : integer read getOpenHeight  write setOpenHeight;
    property Creator : string read getCreator write setCreator;
    property Author : string read getAuthor write setAuthor;
    property Company : string read getCompany write setCompany; }
{$endif}
    property WorkSheetname : string read getWorkSheetname write setWorkSheetname;
  end;

  function EntityReplace( var ctext : string ) : string;
  function ColTrans( ct : TColor ) : string;

implementation

uses QRNewXLSXFiltProcs;

var
   {xmlCreator, xmlAuthor, xmlCompany, }xmlWorkSheetname : string;
   //xmlOpenWidth, xmlOpenHeight : integer;

//-------------------------------------------
procedure TQRXLSXDocumentFilter.SetWorkSheetName( value : string);
begin
     xmlWorkSheetName := value;
end;

function TQRXLSXDocumentFilter.getWorkSheetName: string;
begin
      result := xmlWorkSheetName;
end;

{$ifdef NOT_USED_YET}
function TQRXLSXDocumentFilter.getCreator: string;
begin
      result := xmlCreator;
end;

procedure TQRXLSXDocumentFilter.SetCreator( value : string);
begin
     xmlCreator := value;
end;

function TQRXLSXDocumentFilter.getAuthor: string;
begin
      result := xmlAuthor;
end;

procedure TQRXLSXDocumentFilter.SetAuthor( value : string);
begin
     xmlCreator := value;
end;

procedure TQRXLSXDocumentFilter.SetCompany( value : string);
begin
     xmlCompany := value;
end;

function TQRXLSXDocumentFilter.getCompany: string;
begin
      result := xmlCompany;
end;

procedure TQRXLSXDocumentFilter.SetOpenWidth( value : integer);
begin
     xmlOpenWidth := value;
end;

function TQRXLSXDocumentFilter.getOpenWidth: integer;
begin
      result := xmlOpenWidth;
end;

procedure TQRXLSXDocumentFilter.SetOpenHeight( value : integer);
begin
     xmlOpenHeight := value;
end;

function TQRXLSXDocumentFilter.getOpenHeight: integer;
begin
      result := xmlOpenHeight;
end;
//---------------------------------------------
{$endif}

constructor TQRXLSXFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRXLSXDocumentFilter);
end;

destructor TQRXLSXFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRXLSXDocumentFilter);
  inherited Destroy;
end;

 //-------------------------------------------
procedure TQRXLSXFilter.SetWorkSheetName( value : string);
begin
     xmlWorkSheetName := value;
end;

function TQRXLSXFilter.getWorkSheetName: string;
begin
      result := xmlWorkSheetName;
end;

{$ifdef NOT_USED_YET}
function TQRXLSXFilter.getCreator: string;
begin
      result := xmlCreator;
end;

procedure TQRXLSXFilter.SetCreator( value : string);
begin
     xmlCreator := value;
end;

function TQRXLSXFilter.getAuthor: string;
begin
      result := xmlAuthor;
end;

procedure TQRXLSXFilter.SetAuthor( value : string);
begin
     xmlCreator := value;
end;

procedure TQRXLSXFilter.SetCompany( value : string);
begin
     xmlCompany := value;
end;

function TQRXLSXFilter.getCompany: string;
begin
      result := xmlCompany;
end;

procedure TQRXLSXFilter.SetOpenWidth( value : integer);
begin
     xmlOpenWidth := value;
end;

function TQRXLSXFilter.getOpenWidth: integer;
begin
      result := xmlOpenWidth;
end;

procedure TQRXLSXFilter.SetOpenHeight( value : integer);
begin
     xmlOpenHeight := value;
end;

function TQRXLSXFilter.getOpenHeight: integer;
begin
      result := xmlOpenHeight;
end;
//---------------------------------------------
{$endif}

{TQXLSXAbstractExportFilter}
constructor TQXLSXAbstractExportFilter.Create( filename : string);
begin
     inherited Create(filename);
end;

function TQXLSXAbstractExportFilter.GetFilterName : string;
begin
  result := 'QRAbstract'; // Do not translate
end;

function TQXLSXAbstractExportFilter.GetDescription : string;
begin
  Result := '';
end;

function TQXLSXAbstractExportFilter.GetExtension : string;
begin
  Result := 'xlsx';
end;

procedure TQXLSXAbstractExportFilter.Start(PaperWidth, PaperHeight : integer; Font : graphics.TFont);
begin
    Active := true;
end;

procedure TQXLSXAbstractExportFilter.CreateStream(Filename : string);
begin
end;

procedure TQXLSXAbstractExportFilter.CloseStream;
begin
end;

procedure TQXLSXAbstractExportFilter.WriteToStream(const AText : string);
begin
end;

procedure TQXLSXAbstractExportFilter.WriteLnToStream(const AText : string);
begin
end;

procedure TQXLSXAbstractExportFilter.Finish;
begin
  inherited Finish;
end;

procedure TQXLSXAbstractExportFilter.NewPage;
begin
  FPageProcessed := False;
  inherited NewPage;
end;

procedure TQXLSXAbstractExportFilter.EndPage;
begin
  ProcessPage;
  inherited EndPage;
end;

procedure TQXLSXAbstractExportFilter.ProcessPage;
begin
  FPageProcessed := True;
end;

procedure TQXLSXAbstractExportFilter.StorePage;
begin
end;

function TQXLSXAbstractExportFilter.GetText(X, Y : extended; var Font : graphics.TFont) : string;
begin
end;

{TQRXLSXDocumentFilter}
function TQRXLSXDocumentFilter.GetFilterName : string;
begin
  Result := SqrXLSXDocument;
end;

function TQRXLSXDocumentFilter.GetDescription : string;
begin
  Result := SqrXLSXDocument;
end;

function TQRXLSXDocumentFilter.GetExtension : string;
begin
  Result := 'xlsx'; // Do not translate
end;

function TQRXLSXDocumentFilter.GetStreaming : boolean;
begin
  Result := false;// stream multipage report mode
end;

procedure TQRXLSXDocumentFilter.CreateStream(Filename : string);
begin
  if Filename = '' then
  begin
    FStream := TMemoryStream.Create;
    FreeStream := false;
  end else
  begin
    FreeStream := true;
    inherited CreateStream(Filename);
  end;
end;

procedure TQRXLSXDocumentFilter.CloseStream;
begin
  // the stream is not freed if it's a memory stream
  if FreeStream then
    inherited CloseStream;
end;

constructor TQRXLSXDocumentFilter.Create( filename : string );
begin
   inherited Create( filename);
   FItemcount := 0;
   FSortList := TStringlist.Create;
   FSortlist.Sorted := true;
   FSortlist.Duplicates := dupAccept;
   FStylenames := TStringlist.Create;
   FFontTags := TStringlist.Create;
   FMaxYValue := 0.0;
   FLastRecordNum := 0;
   FPagenumber := 1;
   {
   xmlCreator := 'QRXLSXDocumentFilter';
   xmlOpenWidth := 1000;
   xmlOpenHeight := 600;
   }
   FCreated := datetostr( date );
   FLastsaved := FCreated;
   FXLEncoding := 'UTF-8';// west europe latin, 1250 is east europe.
   // xlsx component files
   dotrels := TStringlist.Create;
   core := TStringlist.Create;
   app := TStringlist.Create;
   Content_Types := TStringlist.Create;
   workbook_xml_rels  := TStringlist.Create;
   workbook  := TStringlist.Create;
   sheet1 := TStringlist.Create;
   sharedStrings := TStringlist.Create;
   styles := TStringlist.Create;
   theme1 := TStringlist.Create;
   fontlist := TStringlist.Create;
   styleslist := TStringlist.Create;
   fillslist := TStringlist.Create;
   colwidths := TStringlist.Create;
   celldupcheck := TStringlist.Create;
   appParams.sheetname := xmlWorkSheetname;
   fontlist.add('<font><sz val="10"/><name val="Arial"/><color rgb="FF000000"/></font>');
   styleslist.Add('<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>');
   fillslist.Add('<fill><patternFill patternType="none"/></fill>');
   fillslist.Add('<fill><patternFill patternType="solid"><fgColor rgb="BADBADEF"/></patternFill></fill>');
   fillslist.Add('<fill><patternFill patternType="solid"><fgColor rgb="FADEFADE"/></patternFill></fill>');
end;

destructor TQRXLSXDocumentFilter.Destroy;
begin
   FSortList.Free;
   FStylenames.Free;
   FFonttags.Free;
   dotrels.Free;
   core.Free;
   app.Free;
   Content_Types.Free;
   workbook_xml_rels.Free;
   workbook.Free;
   sheet1.Free;
   sharedStrings.Free;
   styles.Free;
   theme1.Free;
   fontlist.Free;
   styleslist.Free;
   fillslist.Free;
   colwidths.Free;
   celldupcheck.Free;
   inherited Destroy;
end;

procedure TQRXLSXDocumentFilter.ProcessPage;
begin
  FPageProcessed := True;
  StorePage;
end;

procedure TQRXLSXDocumentFilter.SetDocumentProperties( author, title, company : string );
begin
      {xmlAuthor := author;
      FTitle := title;
      xmlCompany := company;  }
end;

procedure TQRXLSXDocumentFilter.LoadProlog;
begin
end;


// places a blank document in the stringlist
procedure TQRXLSXDocumentFilter.NewDocument( doclist : TStringlist; PaperWidth, PaperHeight : double;
              Papername, orient : string);
begin
end;

// Overridden Start
procedure TQRXLSXDocumentFilter.Start(PaperWidth, PaperHeight : integer; Font : graphics.TFont);
begin
    inherited;
end;

function GetY( pstr : string ) : integer;
var
    tstr : string;
    p, ec : integer;
begin
    p := pos(':', pstr);
    tstr := copy( pstr,1,p-1);
    val( tstr, p, ec);
    result := p;
end;

// CAUTION : these routines are sensitive to the layout of FSortlist.
function GetItem( pstr : string ) : integer;
var
    tstr : string;
    p, ec : integer;
begin
    //p := pos(':', pstr);
    tstr := copy( pstr,13,5);
    val( tstr, p, ec);
    result := p;
end;

procedure TQRXLSXDocumentFilter.SetColWidths( startcol, endcol : integer; cwidth : extended );
begin
     if (endcol < startcol) or (cwidth < 0.0) then exit;
     colwidths.Add('  <x:col min="'+inttostr(startcol)+'" max="'+inttostr(endcol)+'" width="'+floattostr(cwidth)+'" />');
end;

procedure TQRXLSXDocumentFilter.ProcessItems;
var
    currY, currItem, k, stylenum : integer;
    currText, cellREF : string;
    currExpType : TExportType;
    reqCol : integer;
{$ifndef DXE}
    zipFile : TZipfile;
    zstream : TMemorystream;
    zcomp : TZipCompression;
{$endif}
begin
     Load_sheet1prolog(sheet1);// this should be in 'Start' to allow concatenating
    //FSortList.SaveToFile('sortlist.txt'); // debugging
    if FSortList.count = 0 then exit;
    rowno := 1;
    colno := 0;
    k := 0;
    maxcols := 0;
    currY := getY( FSortList[0]);
    sheet1.add('   <x:row>');
    while k < FSortlist.count do
    begin
        currItem := GetItem( FSortList[k]);
        currText := FItems[currItem].text;
{$ifdef DEMO}
         if random < 0.2 then currtext := 'QR Trial';
{$endif}
        currExpType := FItems[currItem].exportAs;
        reqCol := FItems[currItem].col;
        stylenum := FItems[currItem].fontsize;
        cellRef := num2XLCol(reqCol)+inttostr(rowno);
        if celldupcheck.IndexOf(cellRef ) <> -1 then
        begin
            showmessage('Duplicate cell reference detected - please check ''XLColumn'' properties');
            exit;
        end;
        celldupcheck.Add(cellRef);
        if currExpType = exptText then
          sheet1.add('    <x:c r="'+cellRef+'" t="inlineStr" s="'+inttostr(stylenum)+'"><x:is><x:t>'+currText+'</x:t> </x:is></x:c>')
        else if currExpType = exptNumeric then
          sheet1.add('    <x:c r="'+cellRef+'" s="'+inttostr(stylenum)+'"><x:v>'+currText+'</x:v></x:c>')
        else if currExpType = exptFormula then
          sheet1.add('    <x:c r="'+cellRef+'" s="'+inttostr(stylenum)+'"><x:f>'+currText+'</x:f></x:c>');
        inc(colno);
        if colno > maxcols then maxcols := colno;
        inc(k);
        if k = FSortlist.Count then break;
        if currY <> getY( FSortList[k]) then
        begin
            currY := getY( FSortList[k]);
            sheet1.add('   </x:row>');
            inc(rowno);
            sheet1.add('   <x:row>');
            colno := 0;
        end;
    end;
    appParams.LastCell := num2XLCol(colno-1)+inttostr(rowno);
    // from here on the code should be in Finish to allow concatenating into the same worksheet
    sheet1.add('   </x:row>');
    sheet1.add(' </x:sheetData>');
    sheet1.add(' </x:worksheet>');

    Load_ContentTypes_file(Content_Types);
    Load_dotrels_file(dotrels);
    Load_workbookdotrels_file(workbook_xml_rels);
    Load_workbook_file(workbook, worksheetname);
    MakeStyles(styles);
{$ifndef DXE}
    zcomp := TZipCompression.zcDeflate;
    zipfile := TZipfile.Create;
    zipfile.Open(filename,Tzipmode.zmWrite);
    zstream := TMemorystream.Create;
    Content_Types.SaveToStream(zstream, TEncoding.UTF8);
    zstream.Position := 0;
    zipfile.Add(zstream, '[Content_Types].xml', zcomp);

    zstream.Clear;
    dotrels.SaveToStream(zstream, TEncoding.UTF8);
    zstream.Position := 0;
    zipfile.Add(zstream, '_rels/.rels', zcomp);

    zstream.Clear;
    workbook_xml_rels.SaveToStream(zstream, TEncoding.UTF8);
    zstream.Position := 0;
    zipfile.Add(zstream, 'xl/_rels/workbook.xml.rels', zcomp);

    zstream.Clear;
    workbook.SaveToStream(zstream, TEncoding.UTF8);
    zstream.Position := 0;
    zipfile.Add(zstream, 'xl/workbook.xml', zcomp);

    zstream.Clear;
    styles.SaveToStream(zstream, TEncoding.UTF8);
    zstream.Position := 0;
    zipfile.Add(zstream, 'xl/styles.xml', zcomp);

    zstream.Clear;
    sheet1.SaveToStream(zstream, TEncoding.UTF8);
    zstream.Position := 0;
    zipfile.Add(zstream, 'xl/worksheets/sheet.xml', zcomp);
    zstream.Free;
    zipfile.Close;
    zipfile.Free;
{$endif}
end;

// overridden Finish
procedure TQRXLSXDocumentFilter.Finish;
begin
    if fconcatenating then exit;
    ProcessItems;
    inherited;
end;

procedure TQRXLSXDocumentFilter.EndConcat;
begin
     fconcatenating := false;
     Finish;
end;

procedure TQRXLSXDocumentFilter.TextOutRec( ExportInfo : TExportInfoRec);
var
  //I  : integer;
  nItem : XLXSTextItem;
  sortstr, colorstr, xlsxcolstr, boldstr, italicstr, xfontstr, xstylestr, xfillstr, hastr : string;
  xfindex, xsindex, xfillind : integer;
begin
       nItem.col := ExportInfo.Column;
       nItem.X := ExportInfo.Xpos;
       nItem.Y := ExportInfo.Ypos + FPageYOffset;
       if nItem.Y > FMaxYValue then FMaxYValue := nItem.Y;
       nItem.text := EntityReplace(ExportInfo.Text);
       nItem.exportAs := ExportInfo.exportAs;
       nItem.XLNumFormat := ExportInfo.XLNumFormat;
       nItem.controlName := ExportInfo.controlName;
       // old style stuff  ?
       nItem.fontname := ExportInfo.Font.Name;
       nItem.fontsize := ExportInfo.Font.Size;
       nItem.fontbold := fsBold in ExportInfo.Font.Style;
       nItem.fontitalic := fsItalic in ExportInfo.Font.Style;
       nItem.fontstrike := fsStrikeout in ExportInfo.Font.Style;
       nItem.fontcolor := ExportInfo.Font.Color;
       colorstr := colTrans(Nitem.fontcolor);
       if nItem.fontcolor<0 then nItem.fontcolor := 0;
       if trim(nItem.controlName)='' then
              nItem.controlName := 'noname';
       //xlsx style stuff
       // <font><i/><b/><sz val="10"/><name val="Arial"/><color rgb="FF7F7F7F"/></font>
       xlsxcolstr := colorstr;
       boldstr := '';
       if nItem.fontbold then boldstr := '<b/>';
       italicstr := '';
       if nItem.fontitalic then italicstr := '<i/>';
       xfontstr := '<font>'+boldstr+italicstr+'<sz val="'+inttostr(nItem.fontsize)+'"/><name val="'+nItem.fontname+'"/><color rgb="'+xlsxcolstr+'"/></font>';
       xfindex := fontlist.IndexOf(xfontstr);
       if xfindex = -1 then
       begin
           fontlist.Add(xfontstr);
           xfindex := fontlist.Count-1;
       end;
       xfillind := 0;
       if exportinfo.BGColor<>clWhite then
       begin
            xfillstr := '<fill><patternFill patternType="solid"><fgColor rgb="'+colTrans(exportinfo.BGColor)+'"/></patternFill></fill>';
            xfillind := fillslist.IndexOf(xfillstr);
            if xfillind = -1 then
            begin
                fillslist.Add(xfillstr);
                xfillind := fillslist.Count-1;
            end;
       end;
       if exportInfo.Alignment=taLeftJustify then hastr := 'left'
       else if exportInfo.Alignment=taRightJustify then hastr := 'right'
       else hastr := 'center';
       xstylestr := '<xf numFmtId="'+inttostr(integer(nItem.XLNumFormat))+'" fontId="'+inttostr(xfindex)+'" fillId="'+inttostr(xfillind)+'" borderId="0" xfId="0">'+
                    '<alignment vertical="center" horizontal="'+hastr+'"/></xf>';
       xsindex := styleslist.IndexOf(xstylestr);
       if xsindex = -1 then
       begin
           styleslist.Add(xstylestr);
           xsindex := styleslist.Count-1;
       end;
       nitem.fontsize := xsindex;// fontsize is now the style index

       setlength(FItems,FItemcount+1);
       FItems[FItemcount] := nItem;
       sortstr := format( '%5d:%5d:%5d',[trunc(nItem.Y), nItem.col, FItemcount]);
       sortstr := stringreplace( sortstr, ' ','0',[rfReplaceall]);
       sortstr := sortstr+':'+nItem.text;
       FSortList.Add(sortstr);
       inc(FItemcount);
end;

procedure TQRXLSXDocumentFilter.EndPage;
begin
     //do nothing;
end;

procedure TQRXLSXDocumentFilter.NewPage;
begin
     inc(FPagenumber);
     FPageYoffset := FMaxYvalue;
end;

function EntityReplace( var ctext : string ) : string;
begin
     ctext :=  stringreplace( ctext, '&', '&amp;', [rfReplaceAll] ); // must be first
     ctext :=  stringreplace( ctext, '<', '&lt;', [rfReplaceAll] );
     ctext :=  stringreplace( ctext, '>', '&gt;', [rfReplaceAll] );
     ctext :=  stringreplace( ctext, '''', '&apos;', [rfReplaceAll] );
     ctext :=  stringreplace( ctext, '"', '&quot;', [rfReplaceAll] );
     result := ctext;
end;

function ColTrans( ct : TColor ) : string;
var
   tempstr : string;
begin
    if ct < 0 then
    begin
        ct := ct and $FFFFFF;
    end;
    tempstr := format ( '%6.6x', [longint(ct)]);
    result := 'FF' + copy( tempstr, 5, 2 ) +copy( tempstr, 3, 2 )  +copy( tempstr, 1, 2 ) ;
end;
// strip off file extension
function basename( fname : string ) : string;
var
   p : integer;
   ps,fs : string;
begin
    basename := fname;
    ps:=sysutils.ExtractFilePath(fname);
    fs:=sysutils.ExtractFileName(fname);
    p := pos( '.', fs );
    if p = 0 then exit;
    basename := ps + copy( fs, 1, p - 1 );
end;

initialization
   xmlWorkSheetname := 'Untitled Sheet';


end.

