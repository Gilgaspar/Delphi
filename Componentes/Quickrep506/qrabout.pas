{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRAbout.PAS - QuickReport About box with registration   ::
  ::                                                         ::
  :: Copyright (c) 2008 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}
{.$define DEMO}
unit QRAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, OleCtrls, ShellAPI;

type
  { TQRAboutbox, About box with registration form and services }
  TQRAboutBox = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    VisitLabel: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Image2: TImage;
    Shape1: TShape;
    Image3: TImage;
    Label4: TLabel;
    Label6: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  end;

implementation

{$R *.DFM}

uses QR5Const;

{ TQRAboutBox }

procedure TQRAboutBox.Button3Click(Sender: TObject);
begin
  Close;
end;
{.$define DEMO}
procedure TQRAboutBox.FormCreate(Sender: TObject);
begin
{$ifdef DEMO}
   label1.caption := 'Version 5.06 Win64 Trial';
{$else}
   label1.caption := 'Version 5.06.2 Win64';
{$endif}
  label6.caption := 'Build 14 (14/09/2015)';
  VisitLabel.Caption := SqrAboutInfo;

  Label3.Cursor := crHandPoint;
end;

procedure TQRAboutBox.Label3Click(Sender: TObject);
const
  QRPage = 'www.quickreport.co.uk';
begin
  ShellExecute(Handle, 'open', QRPage, nil, nil, SW_SHOW);
end;

end.
