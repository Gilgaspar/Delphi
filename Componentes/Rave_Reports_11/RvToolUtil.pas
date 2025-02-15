{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RvToolUtil;

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Forms, StdCtrls, Buttons, IniFiles, TypInfo, Graphics;

type
  TRaveSettings = class
  protected
    FSectionList: TStringList;
    FSection: string;
    FIniFile: TMemIniFile;
    FChanged: boolean;
    FCacheSaves: boolean;
    //
    function GetSection: string;
  public
    constructor Create(FileName: string); virtual;
    destructor Destroy; override;

    function ReadInteger(AIdent: string; ADefault: integer): integer;
    function ReadBool(AIdent: string; ADefault: boolean): boolean;
    function ReadString(AIdent: string; ADefault: string): string;
    function ReadFloat(AIdent: string; ADefault: extended): extended;

    procedure WriteInteger(AIdent: string; AValue: integer);
    procedure WriteBool(AIdent: string; AValue: boolean);
    procedure WriteString(AIdent: string; AValue: string);
    procedure WriteFloat(AIdent: string; AValue: extended);

    function LockSection(ASection: string): TRaveSettings;
    procedure UnlockSection;
    procedure EraseSection;
    procedure ReadSectionValues(const ASection: string; AStrings: TStrings);
    procedure DeleteKey(AIdent: string);
    procedure Save;
    //
    property CacheSaves: boolean read FCacheSaves write FCacheSaves;
    property Changed: boolean read FChanged;
    property Section: string read GetSection;
  end; { TRaveSettings }

var
  RavePath: string; { File path for Rave IDE }
  TransCharset: {$IFDEF Level6}TFontCharset{$ELSE}byte{$ENDIF};

  function RaveSettings: TRaveSettings;
  procedure SaveToolWin(ToolWin: TForm);
  procedure PrepareToolWin(ToolWin: TForm);
  procedure RestoreToolWin(ToolWin: TForm);
  procedure FixupButtons(Form: TForm);
  procedure FormTrans(Form: TForm);
  function ShowOptionalDialog(AOwner: TComponent;
                              FormCaption: string;
                              Msg: string;
                              Key: string) : boolean;

implementation

uses
  Windows,
  ShlObj,
  RpDefine,
  RvUtil;

var
  GlobalSettings: TRaveSettings = nil;

function RaveSettings: TRaveSettings;
var
  TempBuf: array[0..MAX_PATH] of char;
  IniPath: string;
begin { RaveSettings }
  ShGetSpecialFolderPath(0, TempBuf, CSIDL_PERSONAL, false);
  IniPath := IncludeTrailingPathDelimiter(TempBuf);
  if not Assigned(GlobalSettings) then begin
    GlobalSettings := TRaveSettings.Create(IniPath + 'Rave110.ini');
  end; { if }
  Result := GlobalSettings;
end;  { RaveSettings }

{ TRaveSettings }

constructor TRaveSettings.Create(FileName: string);
begin
  inherited Create;
  FIniFile := TMemIniFile.Create(FileName);
  FSectionList := TStringList.Create;
end;

procedure TRaveSettings.DeleteKey(AIdent: string);
begin
  FIniFile.DeleteKey(Section,AIdent);
  FChanged := true;
end;

destructor TRaveSettings.Destroy;
begin
  Save;
  FreeAndNil(FIniFile);
  FreeAndNil(FSectionList);
  inherited;
end;

procedure TRaveSettings.EraseSection;
begin
  FIniFile.EraseSection(Section);
  FChanged := true;
end;

function TRaveSettings.GetSection: string;
begin
  Result := FSectionList[0];
end;

function TRaveSettings.LockSection(ASection: string): TRaveSettings;
begin
  Result := self;
  FSectionList.Insert(0,ASection);
end;

function TRaveSettings.ReadBool(AIdent: string; ADefault: boolean): boolean;
begin
  Result := FIniFile.ReadBool(Section,AIdent,ADefault);
end;

function TRaveSettings.ReadFloat(AIdent: string; ADefault: extended): extended;
begin
  Result := FIniFile.ReadFloat(Section,AIdent,ADefault);
end;

function TRaveSettings.ReadInteger(AIdent: string;
  ADefault: integer): integer;
begin
  Result := FIniFile.ReadInteger(Section,AIdent,ADefault);
end;

procedure TRaveSettings.ReadSectionValues(const ASection: string;
  AStrings: TStrings);
begin
  FIniFile.ReadSectionValues(ASection,AStrings);
end;

function TRaveSettings.ReadString(AIdent, ADefault: string): string;
begin
  Result := FIniFile.ReadString(Section,AIdent,ADefault);
end;

procedure TRaveSettings.Save;
begin
  FIniFile.UpdateFile;
  FChanged := false;
end;

procedure TRaveSettings.UnlockSection;
begin
  FSectionList.Delete(0);
  if Changed and not CacheSaves then begin
    Save;
  end; { if }
end;

procedure TRaveSettings.WriteBool(AIdent: string; AValue: boolean);
begin
  FIniFile.WriteBool(Section,AIdent,AValue);
  FChanged := true;
end;

procedure TRaveSettings.WriteFloat(AIdent: string; AValue: extended);
begin
  FIniFile.WriteFloat(Section,AIdent,AValue);
  FChanged := true;
end;

procedure TRaveSettings.WriteInteger(AIdent: string; AValue: integer);
begin
  FIniFile.WriteInteger(Section,AIdent,AValue);
  FChanged := true;
end;

procedure TRaveSettings.WriteString(AIdent, AValue: string);
begin
  FIniFile.WriteString(Section,AIdent,AValue);
  FChanged := true;
end;

{ Call this proc in a form's OnDestroy event to save the current state }

procedure SaveToolWin(ToolWin: TForm);

begin { SaveToolWin }
  with RaveSettings.LockSection({Trans-}'Dialogs_' + ToolWin.Name) do try
    WriteInteger({Trans-}'Left',ToolWin.Left);
    WriteInteger({Trans-}'Top',ToolWin.Top);
    if (ToolWin.BorderStyle = bsSizeToolWin) or (ToolWin.BorderStyle = bsSizeable) then begin
      WriteInteger({Trans-}'Height',ToolWin.Height);
      WriteInteger({Trans-}'Width',ToolWin.Width);
    end; { if }
  finally
    UnlockSection;
  end; { with }
end;  { SaveToolWin }

{ Call this proc in a form's OnCreate event to prepare the Position property }

procedure PrepareToolWin(ToolWin: TForm);

begin { PrepareToolWin }
  with RaveSettings.LockSection({Trans-}'Dialogs_' + ToolWin.Name) do try
    if ReadInteger({Trans-}'Left',-1) = -1 then begin // No settings yet
      ToolWin.Position := poMainFormCenter;
    end else begin // Key already exists
      ToolWin.Position := poDesigned;
    end; { else }
  finally
    UnlockSection;
  end; { with }
end;  { PrepareToolWin }

{ Call this proc in a form's OnShow event to restore the forms state }

procedure RestoreToolWin(ToolWin: TForm);

begin { RestoreToolWin }
  with RaveSettings.LockSection({Trans-}'Dialogs_' + ToolWin.Name) do try
  //ToolWin.Left := MinI(ReadInteger({Trans-}'Left',ToolWin.Left),Screen.Width - 32);
  //ToolWin.Top := MinI(ReadInteger({Trans-}'Top',ToolWin.Top),Screen.Height - 32);
    ToolWin.Left := MinI(ReadInteger({Trans-}'Left',ToolWin.Left),Screen.DesktopWidth - 32);
    ToolWin.Top := MinI(ReadInteger({Trans-}'Top',ToolWin.Top),Screen.DesktopHeight - 32);
    if (ToolWin.BorderStyle = bsSizeToolWin) or (ToolWin.BorderStyle = bsSizeable) then begin
      ToolWin.Width := ReadInteger({Trans-}'Width',ToolWin.Width);
      ToolWin.Height := ReadInteger({Trans-}'Height',ToolWin.Height);
    end; { if }
  finally
    UnlockSection;
  end; { with }
end;  { RestoreToolWin }

procedure FixupButtons(Form: TForm);
var
  I1: integer;
begin { FixupButtons }
  for I1 := 0 to Form.ComponentCount - 1 do begin
    if Form.Components[I1] is TSpeedButton then begin
      with TSpeedButton(Form.Components[I1]) do begin
        if Assigned(Glyph) then begin
          Caption := ''; // Remove caption if a glyph is assigned
        end; { if }
      end; { with }
    end; { if }
  end; { for }
end;  { FixupButtons }

procedure FormTrans(Form: TForm);

var
  I1: integer;
  S1: string;
  S2: string;
  C1: TComponent;
  StringsType: PTypeInfo;

  procedure TransStrProp(Name: string);
  var
    PropInfo: PPropInfo;
  begin { TransStrProp }
    PropInfo := GetPropInfo(C1.ClassInfo,Name);
    if Assigned(PropInfo) and (PropInfo.PropType^.Kind = tkLString) then begin
      S1 := GetStrProp(C1,PropInfo);
      if S1 <> '' then begin
        S2 := Trans(S1);
        if S1 <> S2 then begin
          SetStrProp(C1,PropInfo,S2);
        end; { if }
      end; { if }
    end; { if }
  end;  { TransStrProp }

  procedure TransStringsProp(Name: string);
  var
    PropInfo: PPropInfo;
    StringList: TStringList;
    I1: integer;
  begin { TransStringsProp }
    PropInfo := GetPropInfo(C1.ClassInfo,Name);
    if Assigned(PropInfo) and (PropInfo.PropType^ = StringsType) then begin
      StringList := TStringList.Create;
      try
        StringList.Assign(TPersistent(GetOrdProp(C1,PropInfo)));
        for I1 := 0 to StringList.Count - 1 do begin
          StringList[I1] := Trans(StringList[I1]);
        end; { for }
        SetOrdProp(C1,PropInfo,integer(StringList));
      finally
        StringList.Free;
      end; { tryf }
    end; { if }
  end;  { TransStringsProp }

  procedure SetCharset;
  var
    PropInfo: PPropInfo;
  begin { SetCharset }
    PropInfo := GetPropInfo(C1.ClassInfo,'Font');
    if Assigned(PropInfo) and (PropInfo.PropType^ = TypeInfo(TFont)) then begin
      TFont(GetOrdProp(C1,PropInfo)).Charset := TransCharset;
    end; { if }
  end;  { SetCharset }

begin { FormTrans }
  Form.Font.Charset := TransCharset;
  if Addr(Trans) = Addr(DefaultTrans) then Exit;
  StringsType := TStrings.ClassInfo;
  C1 := Form;
  TransStrProp('Caption');
  for I1 := 0 to Form.ComponentCount - 1 do begin
    C1 := Form.Components[I1];
    SetCharset;
    TransStrProp('Caption');
    TransStrProp('Hint');
    TransStringsProp('Items');
  end; { for }
end;  { FormTrans }

function ShowOptionalDialog(AOwner: TComponent;
                            FormCaption: string;
                            Msg: string;
                            Key: string) : boolean;

var
  OptionalDialog: TForm;
  BasePanel: TPanel;
  LabelPanel: TPanel;
  BtnPanel: TPanel;
  MsgLabel: TLabel;
  BtnOkay: TBitBtn;
  CheckBox: TCheckBox;
  MaxMsg: string;
  TmpMsg: string;
  MaxMsgWidth: double;
  CurrLineWidth: integer;
  MsgLines: double;
  NumCRs: integer;
  NumLFs: integer;
  I1: integer;
  D1: integer;

begin
  OptionalDialog := TForm.Create(AOwner);
  with OptionalDialog do try
    SetBounds(341, 179, 336, 121);
    Caption := Trans('Message Dialog');
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := {Trans-}'Arial';
    Font.Style := [];
    Scaled := false;
    PixelsPerInch := 96;
    BorderStyle := bsDialog;
{$IFNDEF LEVEL5}
    Position := poScreenCenter;
{$ELSE}
    Position := poMainFormCenter;
{$ENDIF}
    BasePanel := TPanel.Create(OptionalDialog);
    with BasePanel do begin
      Parent := OptionalDialog;
      SetBounds(0,0, 328, 94);
      Align := alClient;
      Caption := '';
      TabOrder := 0;
      LabelPanel := TPanel.Create(OptionalDialog);
      with LabelPanel do begin
        Parent := OptionalDialog;
        BevelOuter := bvNone;
        SetBounds(10, 10, Parent.Width - 22, Parent.Height - 22);
      { BorderWidth := 10; Causes problems with Delphi 4.00 and 4.01 }
        Caption := '';
        TabOrder := 0;
        MsgLabel := TLabel.Create(OptionalDialog);
        with MsgLabel do begin
          Parent := LabelPanel;
          SetBounds(11, 11, 306, 31);
          Align := alClient;
          AutoSize := false;
          WordWrap := true;
        end; { with }
        BtnPanel := TPanel.Create(OptionalDialog);
        with BtnPanel do begin
          Parent := LabelPanel;
          SetBounds(11, 42, 306, 35);
          Align := alBottom;
          BevelOuter := bvNone;
          TabOrder := 0;
          CheckBox := TCheckBox.Create(OptionalDialog);
          with CheckBox do begin
            Parent := BtnPanel;
            Caption := Trans('Show this Message Next Time');
            SetBounds(1, 10, Canvas.TextWidth(Caption) + 18, 15);
            State := cbChecked;
            TabOrder := 1;
          end; { with }
          BtnOkay := TBitBtn.Create(OptionalDialog);
          with BtnOkay do begin
            Parent := BtnPanel;
            SetBounds(Parent.Width - 75 - LabelPanel.BorderWidth, 5, 75, 25);
            Caption := Trans('&OK');
            ModalResult := mrOk;
            TabOrder := 0;
          end; { with }
        end; { with }
      end; { with }
    end; { with }

    with RaveSettings.LockSection('Dialogs') do try
      Checkbox.Checked := ReadBool(Key,true);
    finally
      UnlockSection;
    end; { with }
    Result := Checkbox.Checked;

    if not Result then begin
      Exit;
    end; { if }

    I1 := 1;
    while (I1 + 80 < Length(Msg)) and (Length(Msg) > 80) do begin
      I1 := I1 + 80;
      while (I1 < Length(Msg)) and (I1 > 1) and (Msg[I1] <> ' ') do begin
        Dec(I1);
      end; { while }
      if Msg[I1] = ' ' then begin
        Msg[I1] := #13;
      end; { if }
    end; { for }
    MsgLabel.Caption := Msg;

    NumCRs := 0;
    NumLFs := 0;
    CurrLineWidth := 0;
    MaxMsg := '';
    MaxMsgWidth := 0;
    TmpMsg := '';
    MsgLines := 1;
    for I1 := 1 to Length(Msg) do begin
      if Msg[I1] = #13 then begin
        NumCRs := NumCRs + 1;
        CurrLineWidth := 0;
        TmpMsg := '';
        if I1 = Length(Msg) then begin
          MsgLines := MsgLines + MaxI(NumLFs,NumCRs);
        end; { if }
      end else if Msg[I1] = #10 then begin
        NumLFs := NumLFs + 1;
        CurrLineWidth := 0;
        TmpMsg := '';
        if I1 = Length(Msg) then begin
          MsgLines := MsgLines + MaxI(NumLFs,NumCRs);
        end; { if }
      end else begin
        if (I1 > 1) and ((Msg[I1-1] = #13) or (Msg[I1-1] = #10)) then begin
          MsgLines := MsgLines + MaxI(NumLFs,NumCRs);
          NumLFs := 0;
          NumCRs := 0;
        end; { if }
        TmpMsg := TmpMsg + Msg[I1];
        CurrLineWidth := CurrLineWidth + 1;
        if CurrLineWidth > MaxMsgWidth then begin
          MaxMsg := TmpMsg;
          MaxMsgWidth := CurrLineWidth;
        end; { if }
      end; { else }
    end; { for }

    D1 := OptionalDialog.Canvas.TextWidth(MaxMsg) - MsgLabel.Width;
    OptionalDialog.Width := Trunc(MaxI(OptionalDialog.Width + Trunc(D1),OptionalDialog.Width));
    D1 := (OptionalDialog.Canvas.TextHeight(MaxMsg) * Trunc(MsgLines)) - MsgLabel.Height;
    OptionalDialog.Height := Trunc(MaxI(OptionalDialog.Height + D1,OptionalDialog.Height));

    BtnOkay.Left := OptionalDialog.Width - 105;
    LabelPanel.Height := BasePanel.Height - 20;
    LabelPanel.Width := BasePanel.Width - 20;

    ShowModal;

    if Checkbox.Checked <> Result then begin
      Result := Checkbox.Checked;
      with RaveSettings.LockSection('Dialogs') do try
        WriteBool(Key,Result);
      finally
        UnlockSection;
      end; { with }
    end; { if }
  finally
    free;
  end; { with }
end;

initialization
  RavePath := ExtractFilePath(ParamStr(0));
finalization
  FreeAndNil(GlobalSettings);
end.