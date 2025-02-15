unit QRNewXLSXFiltProcs;

interface
uses windows, classes, sysutils;

type

   TAppParams = record
      creator : string;
      sheetname : string;
      company : string;
      LastCell : string;
      numstrings : string;
   end;

var
   appParams : TAppParams;
   fontlist : TStringlist;
   fillslist : TStringlist;
   styleslist : TStringlist;
   colwidths : TStringlist;
   procedure Load_app_file( alist : TStringlist);
   procedure Load_core_file( alist : TStringlist);
   procedure Load_ContentTypes_file( alist : TStringlist);
   procedure Load_dotrels_file( alist : TStringlist);
   procedure Load_workbookdotrels_file( alist : TStringlist);
   procedure Load_workbook_file( alist : TStringlist; sheetname : string);
   procedure Load_sheet1prolog( alist : TStringlist);
   function num2XLCol( n : integer ) : string;
   procedure MakeStyles( alist : TStringlist);

implementation

function num2XLCol( n : integer ) : string;
var
    major, minor : integer;
begin
    // row 0 is A. row 26 is AA
    if n<=25 then
       result := ''+chr(ord('A') + n)
    else
    begin
        major := n div 26;
        minor := n mod 26;
        result := ''+chr(ord('A') + major-1) + chr(ord('A') + minor)
    end;
end;

procedure MakeStyles( alist : TStringlist);
var
  n : integer;
begin
    alist.add('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
    alist.add('<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">');
    alist.add('<fonts count="'+inttostr(fontlist.Count)+'" >');
    for n := 0 to fontlist.Count-1 do
    begin
         alist.Add(fontlist[n]);
    end;
    alist.Add('</fonts>');
{$ifdef XXXX}
    // add one fill
    alist.Add('<fills count="1"><fill><patternFill patternType="none"/></fill></fills>');
{$else}
    alist.add('<fills count="'+inttostr(fillslist.Count)+'" >');
    for n := 0 to fillslist.Count-1 do
    begin
         alist.Add(fillslist[n]);
    end;
    alist.Add('</fills>');
{$endif}
    // add one border
    alist.Add('<borders count="1"><border><left/><right/><top/><bottom/><diagonal/></border></borders>');
    alist.Add('<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>');
    // <cellXfs count="3"> one for each font
{$ifdef XXXX}
    alist.add('<cellXfs count="'+inttostr(fontlist.Count)+'" >');
    for n := 0 to fontlist.Count-1 do
    begin
         alist.Add('        <xf numFmtId="0" fontId="'+inttostr(n)+'" fillId="0" borderId="0" xfId="0" applyFont="1"/>');
    end;
{$else}
    alist.add('<cellXfs count="'+inttostr(styleslist.Count)+'" >');
    for n := 0 to styleslist.Count-1 do
    begin
         alist.Add(styleslist[n]);
    end;
{$endif}
    alist.add('</cellXfs>');
    alist.add('</styleSheet>');
end;

procedure Load_sheet1prolog( alist : TStringlist);
var
    n : integer;
begin
    alist.add('<?xml version="1.0" encoding="utf-8"?>');
    alist.add('<x:worksheet xmlns:x="http://schemas.openxmlformats.org/spreadsheetml/2006/main">');

    if colwidths.Count > 0 then
    begin
       alist.add('<x:cols>');
       for n := 0 to colwidths.Count-1 do
              alist.add(colwidths[n]);
       alist.add('</x:cols>');
    end;
    alist.add('    <x:sheetData>');
end;

procedure Load_workbook_file( alist : TStringlist; sheetname : string);
begin
    alist.add('<?xml version="1.0" encoding="utf-8"?>');
    alist.add('<x:workbook xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:x="http://schemas.openxmlformats.org/spreadsheetml/2006/main">');
    alist.add('    <x:sheets>');
    alist.add('        <x:sheet name="'+sheetname+'" sheetId="1" r:id="rId1"/>');
    alist.add('    </x:sheets>');
    alist.add('</x:workbook>');
end;

procedure Load_app_file( alist : TStringlist);
begin
    alist.add('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
    alist.add('<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">');
    alist.add('    <Application>Microsoft Excel</Application>');
    alist.add('    <DocSecurity>0</DocSecurity>');
    alist.add('    <ScaleCrop>false</ScaleCrop>');
    alist.add('    <HeadingPairs>');
    alist.add('        <vt:vector size="2" baseType="variant">');
    alist.add('            <vt:variant>');
    alist.add('                <vt:lpstr>Worksheets</vt:lpstr>');
    alist.add('            </vt:variant>');
    alist.add('            <vt:variant>');
    alist.add('                <vt:i4>1</vt:i4>');
    alist.add('            </vt:variant>');
    alist.add('        </vt:vector>');
    alist.add('    </HeadingPairs>');
    alist.add('    <TitlesOfParts>');
    alist.add('        <vt:vector size="1" baseType="lpstr">');
    alist.add('            <vt:lpstr>'+appParams.sheetname+'</vt:lpstr>');
    alist.add('        </vt:vector>');
    alist.add('    </TitlesOfParts>');
    alist.add('    <Company>'+appParams.company+'</Company>');
    alist.add('    <LinksUpToDate>false</LinksUpToDate>');
    alist.add('    <SharedDoc>false</SharedDoc>');
    alist.add('    <HyperlinksChanged>false</HyperlinksChanged>');
    alist.add('    <AppVersion>14.0300</AppVersion>');
    alist.add('</Properties>');
end;

procedure Load_core_file( alist : TStringlist);
var
  tstr : string;
begin
    alist.add('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
    tstr := 'xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
    alist.add('<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" ' + tstr);
    alist.add('    <dc:creator>'+appParams.creator+'</dc:creator>');
    alist.add('    <cp:lastModifiedBy>'+appParams.creator+'</cp:lastModifiedBy>');
    alist.add('    <dcterms:created xsi:type="dcterms:W3CDTF">2014-07-22T09:23:12Z</dcterms:created>');
    alist.add('    <dcterms:modified xsi:type="dcterms:W3CDTF">2014-07-22T09:23:12Z</dcterms:modified>');
    alist.add('</cp:coreProperties>');
end;

procedure Load_ContentTypes_file( alist : TStringlist);
begin
    alist.add('<?xml version="1.0" encoding="utf-8"?>');
    alist.add('<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">');
    alist.add('    <Default Extension="xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>');
    alist.add('    <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>');
    alist.add('    <Override PartName="/xl/worksheets/sheet.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>');
    alist.add('    <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>');
    alist.add('</Types>');
end;

procedure Load_dotrels_file( alist : TStringlist);
begin
    alist.add('<?xml version="1.0" encoding="utf-8"?>');
    alist.add('<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">');
    alist.add('    <Relationship Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="/xl/workbook.xml" Id="R9e4add5772f8421c"/>');
    alist.add('</Relationships>');
end;

procedure Load_workbookdotrels_file( alist : TStringlist);
begin
    alist.add('<?xml version="1.0" encoding="utf-8"?>');
    alist.add('<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">');
    alist.add('    <Relationship Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="/xl/worksheets/sheet.xml" Id="rId1"/>');
    alist.add('    <Relationship Target="/xl/styles.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Id="rId2"/>');
    alist.add('</Relationships>');
end;

end.
