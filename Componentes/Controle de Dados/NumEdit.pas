unit NumEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math;

type
  TNumEdit = class(TCustomMemo)
  private
    { Private declarations }
    
  protected
    { Protected declarations }
  procedure KeyPress(var Key: Char); override;
  public
    Constructor Create(AOwner : TComponent); override;
  published
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor; 
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Text;
    property TabOrder;
    property Visible;
    
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de Dados', [TNumEdit]);
end;

constructor TNumEdit.Create(AOwner : TComponent);
begin
 inherited Create(AOwner); // chama o construtor original

 AutoSize := True;
 Alignment := taLeftJustify;
 Width  := 121;
 Height := 21;
 WantReturns := False;
end;

procedure TNumEdit.KeyPress(var Key : Char);
begin
  If Not (Key in ['0'..'9',#8]) Then
  Key := #0;
  inherited
end;



end.
