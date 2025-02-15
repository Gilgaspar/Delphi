unit vcl.wwfltfld;
{
//
// Dialog to support TwwFilterDialog field property selection
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 1/12/98 - Field Display Label changes lost occasionally.
}

interface
{$i wwIfDef.pas}

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, db,
  {$ifdef wwDelphi6Up}
  designintf,
  {$else}
  dsgnintf,
  {$endif}
//   wwTable, dbtables, wwqbe, wwquery
   sysutils, dialogs,
  TabNotBk, Tabs, ExtCtrls, wwDBLook, wwcommon, wwstr,
  wwdbcomb, wwdbgrid, Wwdbdlg, wwidlg, wwprpfld, wwfltdlg;

type
TSelFilterFieldsForm = class(TForm)
    GroupBox1: TGroupBox;
    DstList: TListBox;
    AddButton: TButton;
    Button3: TButton;
    Panel1: TPanel;
    FieldDisplay: TEdit;
    Label1: TLabel;
    OKCancelPanel: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    function InDestList(Value: string): Boolean;
    procedure ExcludeItems;
    procedure ExcludeBtnClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DstListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DstListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DstListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DstListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DstListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FieldDisplayExit(Sender: TObject);
  private
    curField: TField;
    dragFromRow: integer;
    initialized: boolean;
    SrcListItems: TStrings;
    SelectedList: TStrings;
    Dialog: TwwFilterDialog;

    procedure UpdateFieldDisplay;
    Function GetSelectedListIndex(value: string): integer;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

end;

function wwSelectFilterableFields(
   ADialog: TwwFilterDialog;
   FieldList: TStrings): boolean;

implementation

{$R *.DFM}

uses wwdbedit;

function max(x,y: integer): integer;
begin
   if x>y then result:= x else result:= y;
end;

destructor TSelFilterFieldsForm.Destroy;
begin
   SrcListItems.Free;
   SelectedList.Free;
   inherited Destroy;
end;

constructor TSelFilterFieldsForm.Create(AOwner: TComponent);
begin
   initialized:= False;
   inherited Create(AOwner);
   curField:= Nil;
   SrcListItems:= TStringList.create;
   SelectedList:= TStringlist.create;
end;

function wwSelectFilterableFields(
   ADialog: TwwFilterDialog;
   FieldList: TStrings): boolean;
var tempPos, i, idx: integer;
   dbInfo: TwwDBFieldInfo;
   FieldName: wwSmallString;
begin
   Result:= False;
   with TSelFilterFieldsForm.create(Application) do
   try
      Dialog:= ADialog;
      if (dialog.datasource=nil) then begin
         MessageDlg('Data source must reference a DataSet', mtError,
                        [mbok], 0);
         exit;
      end;
      if not dialog.datasource.dataset.active then begin
         MessageDlg('Cannot edit field properties.  Dataset must be active.',
                    mtError, [mbok], 0);
         exit;
      end;

      Dialog.InitFields;
      SrcListItems.clear;
      for i:= 0 to Dialog.AllFields.count-1 do begin
//         if not wwValidFilterableFieldType(TwwDBFieldInfo(Dialog.AllFields[i]).FieldType) then continue;
         if not wwValidFilterableFieldType(TwwDBFieldInfo(Dialog.AllFields[i]).FieldType) then
         begin
            if (Dialog.FilterMethod <> fdByFilter) or
               (TwwDBFieldInfo(Dialog.AllFields[i]).FieldType<>ftBlob) then
               continue;
         end;
         SrcListItems.add(TwwDBFieldInfo(Dialog.AllFields[i]).PhysicalFieldName);
      end;

      for i:= 0 to FieldList.count-1 do
      begin
         tempPos:= 1;
         FieldName:= strGetToken(FieldList[i], ';', temppos);
         dbInfo:= Dialog.GetDBInfoForField(FieldName);
         if dbInfo<>Nil then
            DstList.items.add(FieldName);
      end;
      SelectedList.Assign(FieldList);
      Result := ShowModal = IDOK;

      if Result then begin
         FieldList.clear;
         for i:= 0 to DstList.items.count-1 do begin
            idx:= GetSelectedListIndex(DstList.items[i]);
            if idx>=0 then FieldList.add(SelectedList[idx]);
         end;
      end;

   finally
      Free;
   end;
end;

Function TSelFilterFieldsForm.GetSelectedListIndex(value: string): integer;
var j: integer;
begin
   result:= -1;
   for j:= 0 to SelectedList.count-1 do begin

      // 2/12/06 - Use Ansi functions
      if AnsiPos(AnsiUppercase(value), AnsiUppercase(SelectedList[j]))=1 then
      begin
         result:= j;
         break;
      end
   end
end;

function TSelFilterFieldsForm.InDestList(Value: string): Boolean;
begin
  Result := False;
  if DstList.Items.IndexOf(Value) > -1 then
    Result := True;
end;


procedure TSelFilterFieldsForm.ExcludeItems;
var
  I: Integer;
  idx: integer;
  FirstSelection: integer;
begin
  with DstList do
  begin
    I := 0;
    FirstSelection:= -1;
    while SelCount > 0 do
    begin
      if Selected[I] then
      begin
        FirstSelection:= i;
        idx:= GetSelectedListIndex(Items[i]);
        if idx>=0 then SelectedList.Delete(idx);
        Items.Delete(I);
      end
      else
        Inc(I);
    end;
    if Items.Count <> 0 then
    begin
       if FirstSelection>=DstList.Items.Count then
          FirstSelection:= DstList.Items.Count-1; {1/22/97}
       DstList.ItemIndex:= FirstSelection;
    end
  end;

  if (DstList.Items.Count>0) then begin
     DstList.Selected[max(0, FirstSelection)]:= True;
     UpdateFieldDisplay;
  end

end;

procedure TSelFilterFieldsForm.ExcludeBtnClick(Sender: TObject);
begin
   ExcludeItems;
end;

procedure TSelFilterFieldsForm.Button3Click(Sender: TObject);
begin
   ExcludeItems;
end;

procedure TSelFilterFieldsForm.AddButtonClick(Sender: TObject);
var i, idx: integer;
    tempList: TStrings;
    Append: boolean;
begin
   tempList:= TStringlist.create;
   try
      if wwDlgSelectFilterFields(SrcListItems, DstList.items, tempList) then
      begin
         Append:= DstList.itemIndex>=DstList.items.count-1;
         for i:= 0 to tempList.count-1 do begin
            if Append then DstList.items.add(tempList[i])
            else DstList.items.insert(DstList.itemIndex+i+1, tempList[i]);
            idx:= GetSelectedListIndex(tempList[i]);
            if idx<0 then selectedList.add(tempList[i]);
         end
      end
   finally
      tempList.free;
   end;

   if (DstList.Items.Count>0) then begin
{      DstList.Selected[max(0, DstList.itemIndex)]:= True;}
      UpdateFieldDisplay;
   end

end;

procedure TSelFilterFieldsForm.DstListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var row: integer;
    dragString,dsplyString: string;
begin
   if not (Sender is TListbox) then exit;
   if not (Source is TListbox) then exit;

   if (Source=DstList) and (Sender=DstList) then
   begin
      row := y  div DstList.ItemHeight + DstList.TopIndex;
      if row>DstList.items.count then row:= DstList.items.count;
      if dragFromRow>=DstList.items.count then exit;
      if row=dragFromRow then exit;
      dragString:= DstList.items[dragFromRow];
      dsplyString:=SelectedList[dragFromRow]; {1/12/98 - Get display string of dragged row}

      DstList.items.delete(dragFromRow);
      SelectedList.delete(dragFromRow);       {1/12/98 - Delete string from SelectedList also}
      if (row>DstList.items.count) then
      begin
         DstList.items.add(dragString);
         DstList.Selected[DstList.items.count]:= True;
         SelectedList.Add(dsplyString);       {1/12/98 - Add string to SelectedList also}
      end
      else begin
         DstList.items.insert(row, dragString);
         DstList.Selected[row]:= True;
         SelectedList.Insert(row,dsplyString);{1/12/98 - Insert string to SelectedList also}
      end;

      UpdateFieldDisplay;
   end;

end;


procedure TSelFilterFieldsForm.DstListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept:= True;
end;

procedure TSelFilterFieldsForm.DstListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (not(ssCtrl in shift)) and (not(ssShift in shift)) then begin
      dragFromRow := y  div DstList.ItemHeight + DstList.TopIndex;
      DstList.BeginDrag(False);
   end;
end;

procedure TSelFilterFieldsForm.DstListClick(Sender: TObject);
begin
    if (Dialog.FilterMethod<>fdByQueryModify) then exit;
    if DstList.itemIndex>=0 then UpdateFieldDisplay;
end;

procedure TSelFilterFieldsForm.UpdateFieldDisplay;
var
   idx: integer;
   curpos: integer;
   physicalFieldName, tempName, FieldName: wwSmallString;
   tempField: TField;
begin
    if DstList.itemIndex>=0 then begin
       PhysicalFieldName:= DstList.items[DstList.itemIndex];
       if  Dialog.Datasource.Dataset.FieldDefs.IndexOf(PhysicalFieldName)<0 then begin
         FieldDisplay.enabled:= True;
         idx:= GetSelectedListIndex(DstList.items[DstList.itemIndex]);
         if idx>=0 then begin
            curpos:=1;
            FieldName:= strGetToken(SelectedList[idx], ';', curpos);
            tempName:= strGetToken(SelectedList[idx], ';', curpos);
            if tempName<>'' then FieldDisplay.text:= tempName
            else FieldDisplay.text:= FieldName;
         end
         else FieldDisplay.text:= PhysicalFieldName
       end
       else begin
          tempField:=Dialog.DataSource.DataSet.FindField(PhysicalFieldName);
          if tempField=nil then FieldDisplay.Text:= PhysicalFieldName
          else FieldDisplay.Text:= tempField.DisplayLabel;
          FieldDisplay.enabled:= False;
       end
    end;
end;

procedure TSelFilterFieldsForm.FormShow(Sender: TObject);
begin
   if (Dialog.FilterMethod= fdByFilter) then Panel1.visible:= False;

   if (DstList.Items.Count>0) then
   begin
      DstList.Selected[max(0, DstList.itemIndex)]:= True;
      UpdateFieldDisplay;
   end
end;

procedure TSelFilterFieldsForm.FormResize(Sender: TObject);
  function Adjustpixels(val: integer): integer;
  begin
     result:= (Screen.pixelsPerInch * val) div 96
  end;
begin
    OKCancelPanel.Top:= self.Height - AdjustPixels(125);
    if not Panel1.visible then begin
       DstList.height:= Groupbox1.height - AdjustPixels(8);
    end
    else begin
       DstList.height:= Groupbox1.height - Panel1.height - AdjustPixels(10);
    end
end;

procedure TSelFilterFieldsForm.DstListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_delete then ExcludeItems
  else if Key=vk_insert then AddButtonClick(Sender);
end;

procedure TSelFilterFieldsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=vk_f1) then wwALinkHelp(Handle, 'TwwFilterDialog_SelectedFields')
end;

{1/12/98- Update Currently Selected Listbox Item after FieldDisplay has been changed and exited}
procedure TSelFilterFieldsForm.FieldDisplayExit(Sender: TObject);
var idx,x: integer;
    FieldName:string;
begin
    if FieldDisplay.modified then begin
       idx:= DstList.itemindex;
       if idx>=0 then begin
          x:=1;
          FieldName := strGetToken(SelectedList[idx], ';', x);
          SelectedList[idx] := FieldName + ';' + FieldDisplay.Text
       end;
    end;
end;


end.
