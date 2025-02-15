unit cdDateEdit;

interface

uses
  Windows, Graphics, Forms, SysUtils, Classes, Messages, Controls, ComCtrls, StdCtrls, Mask;

type
  TcdCustomDateEdit = class(TCustomMaskEdit)
  private
    FCalendario: TMonthCalendar;
    FOnDropDown: TNotifyEvent;
    procedure uhu;
    procedure SetStyle(const Value: TComboBoxStyle);
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    Property Calendario: TMonthCalendar read FCalendario;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

type
  TcdDateEdit = class(TcdCustomDateEdit)
  private
  protected
  public
  published
  //property Style;
    property OnDropDown;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TcdDateEdit]);
end;

{ TcdCustomDateEdit }

procedure TcdCustomDateEdit.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    CBN_DBLCLK:
      DblClick;
    CBN_EDITCHANGE:;
    //Change;
    CBN_DROPDOWN:
      begin
        uhu;
      end;
  else
    TForm(Self.Parent).Caption := inttostr(Message.NotifyCode);
  end;

end;

constructor TcdCustomDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCalendario := TMonthCalendar.Create(Self);
//FCalendario.Parent := Self;
end;

destructor TcdCustomDateEdit.Destroy;
begin

  inherited;
end;

procedure TcdCustomDateEdit.SetStyle(const Value: TComboBoxStyle);
begin

end;

procedure TcdCustomDateEdit.uhu;
begin
  Self.ClientHeight := FCalendario.Height;
  Self.ClientWidth  := FCalendario.Width;

  FCalendario.Parent   := Self;
  FCalendario.Parent   := Self;
  FCalendario.Visible := True;
  FCalendario.Left := 0;
  FCalendario.Top  := 0;
  FCalendario.Repaint;

//MessageBox(Handle, 'uhu', 'uhu', MB_OK);
//Abort;
end;

{ TcdDateEdit }


end.
