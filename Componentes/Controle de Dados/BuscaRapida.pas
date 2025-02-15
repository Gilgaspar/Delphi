unit BuscaRapida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBClient, DBGrids, StdCtrls, SimpleDS, extCtrls, strUtils,
  FireDAC.Comp.Client;

type
  TBuscaRapida = class(TLabel)
  private
    FGrid: TDBGrid;
    FDataSet: TDataSet;
    FTimer: Ttimer;
    FKey: Char;
    FCadeia: String;
    FAntKeyPress: TKeyPressEvent;
    FEnableSearch: Boolean;
    procedure ExecutaBusca(Key: Char);
    procedure SetGrid(Value: TDBGrid);
    function GetDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
    procedure doTimer(Sender: TObject);
    procedure grKeyPress(Sender: TObject; var Key: Char);
  protected

  public
    constructor Create(AOwner: TComponent); override;
  published
    property EnableSearch: Boolean read FEnableSearch write FEnableSearch default True;
    property Grid: TDBGrid read fGrid write SetGrid;
    property GridDataset: TDataSet read FDataSet write SetDataSet;
    property Key: Char read fKey write fKey;
  end;

const
  Chars: string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890 /.,-';

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TBuscaRapida]);
end;

{ TBuscaRapida }

constructor TBuscaRapida.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clSkyBlue;
//Align := alBottom;
  Visible := False;

  Application.ProcessMessages;

  FTimer := TTimer.Create(Self);
  FTimer.Enabled  := False;
  FTimer.Interval := 3000;
  FTimer.OnTimer  := doTimer;
  EnableSearch:=True;
end;

procedure TBuscaRapida.ExecutaBusca(Key: Char);
var
  Campo, Indice: string;
  strLoc: String;
  dblLoc: Double;
  intLoc: Integer;
  indexFName,
  indexName: String;
begin
  if EnableSearch and (fDataSet <> nil) and (fDataSet.Active) then
  begin
    if Key = #8 then
       FCadeia := LeftStr(FCadeia, Length(FCadeia) - 1)
    else
    begin
      try

        try
        //DBx
          indexFName := TSimpleDataSet(fDataSet).IndexFieldNames;
          indexName  := TSimpleDataSet(fDataSet).IndexName;
        except
        //FDac
          indexFName := TFDQuery(fDataSet).IndexFieldNames;
          indexName  := TFDQuery(fDataSet).IndexName;
        end;
        Indice := indexFName;

        if indexName<>'' then begin
           Indice:=indexName;
           if LowerCase(RightStr(Indice, 5))='_desc' then
              Indice:=LeftStr(Indice, Length(Indice)-5);
        end;

        if Pos(';', Indice)>0 then
           Campo := Copy(Indice, 1, Pos(';', Indice)-1) else
           Campo := Indice;
        if Campo = '' then
           Campo := FGrid.SelectedField.FieldName;

        FCadeia := UpperCase(FCadeia + Key);

      //ignora se campo editável...
        if (dgEditing in FGrid.Options) and (FGrid.Columns.Items[FGrid.SelectedIndex].ReadOnly = False) then
        begin
          FCadeia := '';
        end;

        if (FCadeia<>'') then
        begin
          if (fDataSet.FieldByName(Campo).DataType in [ftSmallInt, ftWord, ftInteger, ftCurrency, ftBCD, ftFloat]) then
          begin
            try
              strLoc := FCadeia;
              if Key in ['.', ','] then begin
                 if Key <> FormatSettings.DecimalSeparator then
                    Key := FormatSettings.DecimalSeparator;
                    FCadeia[Length(FCadeia)] := FormatSettings.DecimalSeparator;
                    strLoc := FCadeia + '0';
              end;
              dblLoc := StrToFloatDef(strLoc, 0);
              intLoc := Round(dblLoc);
              case fDataSet.FieldByName(Campo).DataType of
                ftSmallInt: fDataSet.Locate(Campo, intLoc, []);
                ftWord:     fDataSet.Locate(Campo, intLoc, []);
                ftInteger:  fDataSet.Locate(Campo, intLoc, []);
                ftCurrency: fDataSet.Locate(Campo, dblLoc, []);
                ftBCD:      fDataSet.Locate(Campo, dblLoc, []);
                ftFloat:    fDataSet.Locate(Campo, dblLoc, []);
              else
                fDataSet.Locate(Campo, FCadeia, [loPartialKey])
              end;
            except
              if not fDataSet.Locate(Campo, FCadeia, [loPartialKey, loCaseInsensitive]) then
                 FCadeia := LeftStr(FCadeia, Length(FCadeia) - 1);
            end;
          end else
          if not fDataSet.Locate(Campo, FCadeia, [loPartialKey, loCaseInsensitive]) then
             FCadeia := LeftStr(FCadeia, Length(FCadeia) - 1);
          if Pos(Key, Chars) <= 0 then
             FCadeia := '';
          FTimer.Enabled := False;
        end;
      except
        on ex:Exception do begin
           FCadeia := '';
           strLoc:=ex.message;
         //MensagemPadrao('Erro: ' + ex.message);
        end;
      end;
    end;

    Caption:= 'Pesquisando: ' + FCadeia;
    Visible := FCadeia <> '';
    FTimer.Enabled := True;
  end;
end;

function TBuscaRapida.GetDataSet: TDataSet;
begin
  Result := FDataSet;
  if FGrid <> nil then
     if FGrid.DataSource <> nil then
        Result := FGrid.DataSource.DataSet;
  if Grid <> nil then
     if Grid.DataSource <> nil then
        Result := Grid.DataSource.DataSet;
end;

procedure TBuscaRapida.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TBuscaRapida.SetGrid(Value: TDBGrid);
begin
  fGrid := Value;
  if Value = nil then
     fDataSet := nil
  else begin
    FAntKeyPress := FGrid.OnKeyPress;
    FGrid.OnKeyPress := grKeyPress;
    if fGrid.DataSource <> nil then
       fDataSet := fGrid.DataSource.DataSet;
  end;
end;

procedure TBuscaRapida.grKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  ExecutaBusca(Key);
  if Assigned(FAntKeyPress) and (Sender <> nil) then
     FAntKeyPress(Sender, Key);
end;

procedure TBuscaRapida.doTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  FCadeia := '';
  Visible := False;
end;

end.
