unit EditUpDn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Comctrls;

type
  TEditUpDn = class(TEdit)
  UpDn: TUpDown;
  private
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize);
  protected
    procedure CreateWnd; override;
  public
    Constructor Create(AOwner : TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TEditUpDn]);
end;

{ TEditUpDn }

constructor TEditUpDn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner); //chama o construtor original
  UpDn:=TUpDown.Create(Self);
  UpDn.Parent:=Self;
  updn.Associate := Self;
  updn.Height := Height - 2;
  updn.Left := Left + Width - updn.Width - 1;
  updn.Top  := Top + 1;
end;

procedure TEditUpDn.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - UpDn.Width - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));  {debug}
end;

procedure TEditUpDn.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TEditUpDn.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
//  MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else if UpDn<>nil then
  begin
    if NewStyleControls and Ctl3D then
      updn.SetBounds(Width - updn.Width - 5, 0, updn.Width, Height - 5)
    else updn.SetBounds (Width - updn.Width, 1, updn.Width, Height - 3);
    SetEditRect;
  end;
end;


end.
