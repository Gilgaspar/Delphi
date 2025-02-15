{---------------------------------------------------------------------------------
   QR6 version
   
   amended to be a plugin replacement for some TDOMDocument cproperies and methods

  1. fixed LoadXML - short lines were being lost
----------------------------------------------------------------------------------}

unit qrxmldom;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants;

type
  TDictionary = class(TObject)
       private
          //FCount : integer;
          function GetCount : integer;
       protected
          keys, values : TStringlist;
       public
          procedure Add( key, value : string );
          procedure Clear;
          function Key(index : integer) : string;
          function KeyExists( key : string ) : boolean;
          function Value( key : string ) : string;
          function getNamedItem( key : string ) : string;
          procedure RemoveKey( key : string );
          constructor Create;
          destructor Destroy;override;
          property Count : integer read GetCount;
  end;

  TQRDocnode = class(TObject)
   public
      Nodes : TStringlist;
      Attributes : TDictionary;
      nodeValue : string;
      Name : string;
      //ParentNode : TQRDocnode;
      constructor Create ;
      destructor Destroy; override;
      procedure Clear;
      procedure AddNode( aNode : TQRDocnode );
      procedure Walk;
      procedure getElementsByTagName( tagname : string; var elist : TStringlist );
      function GetNodeByName( nodename : string ) : TQRDocnode;
      function GetNodeByNameandAttr( nodename, attname, attval : string ) : TQRDocnode;
      property Get_Text : string read nodeValue;
 end;

 TQRDomDocument = class(TObject)
    private
      FTopNode : TQRDocnode;
      FDocumentLoaded : boolean;
    public
      procedure GetAttributes( node : TQRDocnode; pline : string; var nodeDone : boolean);
      procedure loadXMLFile( filename : string);
      procedure loadXML( instring : string); overload;
      procedure loadXML( Docstream : TMemorystream);overload;
      procedure loadXML( xmlList : TStringlist);overload;
      procedure Save( filename : string);
      function GetNodeByName( nodename : string ) : TQRDocnode;
      function Get_Xml : string;
      procedure Clear;
      constructor create;
      destructor Destroy; override;
      property Doctop : TQRDocnode read  FTopNode write FTopNode;
      property DocumentLoaded : boolean read  FDocumentLoaded;
 end;

 var
    xmlequals : TStringlist;
    nodecount : integer;
    indent : integer;
    function copyToChar( s : string; start : integer; ToChar : char; var lastPos : integer ): string;
    function copyBackToChar( s : string; start : integer; ToChar : char; var lastPos : integer ): string;

implementation

// TQRDomDocument
constructor TQRDomDocument.Create;
begin
   FTopnode := TQRDocnode.Create;
   xmlequals := nil;
end;

destructor TQRDomDocument.Destroy;
begin
   if FTopnode <> nil then
              FTopNode.Free;
   if xmlequals <> nil then
      xmlequals.Free;
   inherited;
end;

procedure TQRDomDocument.Clear;
begin
    FTopNode.Clear;
    FDocumentLoaded := false;
end;

procedure TQRDomDocument.Save( filename : string);
begin
end;

function TQRDomDocument.Get_Xml : string;
begin
   result := ' ';
end;

function TQRDomDocument.GetNodeByName( nodename : string ) : TQRDocnode;
begin
    result := FTopNode.GetNodeByName( nodename);
end;

procedure TQRDomDocument.loadXMLFile( filename : string);
var
    tmplist : TStringlist;
begin
    tmplist := TStringlist.Create;
    tmplist.LoadFromFile(filename);
    loadXML( tmplist);
    tmplist.Free;
end;

procedure TQRDomDocument.loadXML( instring : string);
var
    tmplist : TStringlist;
begin
    tmplist := TStringlist.Create;
    tmplist.Text := instring;
    loadXML( tmplist);
    tmplist.Free;
end;

procedure TQRDomDocument.loadXML( Docstream : TMemorystream);
var
    tmplist : TStringlist;
begin
    tmplist := TStringlist.Create;
    tmplist.LoadFromStream(Docstream);
    loadXML( tmplist);
    tmplist.Free;
end;

procedure TQRDomDocument.loadXML( xmllist : TStringlist);
var
      nodestack : TStringlist;
      N : int64;
      p : integer;
      line : string;
      newNode : TQRDocnode;
      nodeFinished : boolean;
      procedure Push( pnode : TQRDocnode);
      begin
          nodestack.AddObject( pnode.Name, pnode);
          //XMLForm.memo1.Lines.Add('Push : ' + pnode.name);
      end;
      function CurrParent : TQRDocnode;
      begin
            if nodestack.count > 0 then
              result := TQRDocnode(nodestack.Objects[nodestack.count-1])
            else
              result := nil;
      end;
      procedure Pop;
      begin
          if nodestack.count>0 then
          begin
              //XMLForm.memo1.Lines.Add('Pop : ' + TQRDocnode(nodestack.Objects[nodestack.count-1]).name);
              //TQRDocnode(nodestack.Objects[nodestack.count-1]).free;
              nodestack.Delete(nodestack.count-1);
          end;
      end;
begin
      nodecount := 1;
      xmlequals := TStringlist.Create;
      nodestack := TStringlist.Create;
      // skipping headers and doctype looking for <QRXDocument>
      N := 0;
      while N < xmllist.Count do
      begin
          line := trim(xmllist[N]);
          if length(line) < 3 then
          begin
              inc(N);
              continue;
          end;
          if pos(  '<QXDoc', line) = 1 then
          begin
               GetAttributes( Doctop, line, nodeFinished );
               push(Doctop);
               inc(N);
               break;
          end;
          inc(N);
      end;
      if nodestack.Count=0 then
      begin
         //showmessage('No top node');
         exit;
      end;
      while N < xmllist.Count do
      begin
          line := trim(xmllist[N]);
          if length(line) >= 2 then
          begin
             if (line[1]='<') and (line[2]='/') then
             begin
               Pop;
               if nodestack.count=0 then
                   break;// end of top node so stop
             end
             else if (line[1]='<')then
             begin
               // start of node
               newNode := TQRDocnode.Create;
               inc(nodecount);
               GetAttributes( newNode, line, nodeFinished );
               //newNode.ParentNode := CurrParent;
               CurrParent.AddNode(newNode);
               if not nodeFinished then
                            push(newnode);
             end
             else if CurrParent<>nil then
                   CurrParent.nodeValue := currParent.nodeValue + CopyToChar( line, 1, '<', p);
                   //CurrParent.Value := currParent.Value + 'x';
          end
          else if CurrParent<>nil then
                   CurrParent.nodeValue := currParent.nodeValue + CopyToChar( line, 1, '<', p);

          inc(N);
      end;
      xmllist.Free; // it was created in the calling method
      FDocumentLoaded := true;
end;

procedure TQRDomDocument.GetAttributes( node : TQRDocnode; pline : string; var nodeDone : boolean);
var
    k, p, lpos : integer;
    tstr, vstr : string;
begin
     //<nodename att1="att1v">value</nodename>
     //xmlequals := TStringlist.Create;
     nodeDone := false;
     if pos( '=', pline) > 0 then
     begin
         node.Name := CopyToChar( pline, 2, ' ', p);
         tstr := '/' + node.Name;
         nodeDone := pos(tstr, pline) > 0;
     end
     else
     begin
{$ifdef NOVALS}
         node.Name := CopyToChar( pline, 2, '>', p);
         tstr := '/' + node.Name;
         nodeDone := pos(tstr, pline) > 0;
{$else}
         node.Name := CopyToChar( pline, 2, '>', p);
         tstr := '';
         for k := p+1 to length(pline) do
         begin
             if pline[k] = '<' then
             begin
                nodeDone := true;
                break;
             end;
             tstr := tstr + pline[k];
         end;
         node.nodeValue := tstr;
{$endif}
         exit; // no attributes
     end;
     for k := 1 to length(pline) do
       if pline[k]='=' then
           xmlequals.Add(inttostr(k));
     for k := 0 to xmlequals.Count-1 do
     begin
         p := strtoint(xmlequals[k]);
         tstr := CopyBackToChar( pline, p-1, ' ', lpos);
         vstr :=     CopyToChar( pline, p+2, '"', lpos);
         node.Attributes.Add(tstr, vstr);
     end;
     p := pos( '>', pline );
     if p > 0 then
        tstr := CopyToChar( pline, p+1, '<', lpos);
     node.nodeValue := node.nodeValue + tstr;
     xmlequals.clear;
end;

// QRDocnode
constructor TQRDocNode.Create;
begin
     Nodes := TStringlist.Create;
     Attributes := TDictionary.Create;
end;

destructor TQRDocNode.Destroy;
begin
    Clear;
    nodeValue := '';
    name := '';
    //parentNode := nil;
    Attributes.Free;
    //FreeAndNil(Nodes);
    Nodes.free;
    Nodes := nil;
    inherited;
    dec(nodecount);
end;

procedure TQRDocNode.Clear;
var
   k : integer;
begin
   //xmlform.Memo1.Lines.Add('Clearing ' + Name);
   Attributes.Clear;
   for k := 0 to Nodes.Count-1 do
   begin
       TQRDocnode(Nodes.Objects[k]).free;
       Nodes.Objects[k] := nil;
   end;
   Nodes.Clear;
end;

procedure TQRDocNode.AddNode( aNode : TQRDocnode );
begin
     Nodes.AddObject(aNode.Name, aNode);
end;

function TQRDocnode.GetNodeByNameandAttr( nodename, attname, attval : string ) : TQRDocnode;
var
   k : integer;
   node : TQRDocnode;
   attstr : string;
begin
    attstr := self.Attributes.Value(attname);
    if (self.Name = nodename) and (attstr=attval) then
    begin
       result := self;
       exit;
    end;
    result := nil;
    for k := 0 to Nodes.Count-1 do
    begin
       node := TQRDocnode(Nodes.Objects[k]);
       result := node.GetNodeByNameandAttr( nodename, attname, attval);
       if result <> nil then break;
    end;
end;

function TQRDocnode.GetNodeByName( nodename : string ) : TQRDocnode;
var
   k : integer;
   node : TQRDocnode;
begin
    if self.Name = nodename then
    begin
       result := self;
       exit;
    end;
    result := nil;
    for k := 0 to Nodes.Count-1 do
    begin
       node := TQRDocnode(Nodes.Objects[k]);
       result := node.GetNodeByName(nodename);
       if result <> nil then break;
    end;
end;

procedure TQRDocnode.getElementsByTagname( tagname : string; var elist: TStringlist);
var
   k : integer;
   node : TQRDocnode;
begin
      if self.Name = tagname then
         if assigned(elist) then
           elist.AddObject( self.Name, self );
    for k := 0 to Nodes.Count-1 do
    begin
       node := TQRDocnode(Nodes.Objects[k]);
       node.getElementsByTagname(tagname, elist);
    end;
end;

procedure TQRDocNode.Walk;
var
   k : integer;
   node : TQRDocnode;
   valstr : string;
begin
   inc(indent,4);
   //k := length(nodeValue);
   valstr := copy( nodeValue, 1, 50 );
   //xmlform.Memo1.Lines.Add(copy(spaces, 1, indent)+'Node ' + Name + ' ' + valstr + '  ' + inttostr(k));
   //for k := 0 to Attributes.Count-1 do
           //xmlform.Memo1.Lines.Add(copy(spaces, 1, indent)+'   ' + Attributes.keys[k] + ' : ' + attributes.values[k]);

   for k := 0 to Nodes.Count-1 do
   begin
       node := TQRDocnode(Nodes.Objects[k]);
       node.Walk;
   end;
   dec(indent,4);
end;

// TDictionary
constructor TDictionary.Create;
begin
    keys := TStringlist.create;
    keys.Duplicates := dupIgnore;
    values := TStringlist.create;
end;

destructor TDictionary.Destroy;
begin
    clear;
    keys.Free;
    values.Free;
    inherited Destroy;
end;

procedure TDictionary.clear;
begin
    keys.clear;
    values.clear;
end;

function TDictionary.Key(index : integer) : string;
begin
   if index < Count then
        result := keys[index]
   else
        result := '';
end;

function TDictionary.GetCount : integer;
begin
   result := keys.count;
end;

procedure TDictionary.Add( key, value : string );
begin
    keys.add( key);
    values.add(value);
end;

function TDictionary.KeyExists( key : string ) : boolean;
begin
     result := keys.indexof( key) >= 0;
end;

function TDictionary.getNamedItem( key : string ) : string;
begin
    result := Value(key);
end;

function TDictionary.Value( key : string ) : string;
var
   p : integer;
begin
     p := keys.indexof( key);
     if p < 0 then
         result := ''
     else
         result := values[p];
end;

procedure TDictionary.RemoveKey( key : string );
var
   p : integer;
begin
     p := keys.indexof( key);
     if p < 0 then exit;
     values.Delete(p);
     keys.Delete(p);
end;

{-------------------------------- utilities -----------------------------}
function copyToChar( s : string; start : integer; ToChar : char; var lastPos : integer ): string;
var
   k : integer;
begin
   result := '';
   lastPos := -1;
   for k := start to length(s) do
   begin
       lastPos := k;
       if s[k]='>' then break;
       if s[k]=''+ ToChar then break;
       result := result + s[k];
   end;
   result := trim(result);
end;

function copyBackToChar( s : string; start : integer; ToChar : char; var lastPos : integer ): string;
var
   k : integer;
begin
   result := '';
   lastPos := -1;
   for k := start downto 1 do
   begin
       lastPos := k;
       if s[k]=''+ ToChar then break;
       result := s[k] + result;
   end;
   result := trim(result);
end;

end.
