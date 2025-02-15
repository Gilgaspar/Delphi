unit vcl.wwdatsrc;
{
//
// Components : TwwDataSource
//
// Copyright (c) 1995,1998 by Woll2Woll Software
//
}

interface

{$i wwIfDef.pas}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DB;

type
  TwwDataSource = class(TDataSource)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('InfoPower', [TwwDataSource]);
end;

end.
