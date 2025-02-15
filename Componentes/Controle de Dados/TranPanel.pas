unit TranPanel;
//unit utranspanel;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Forms, Graphics, StdCtrls;

type
  TTranPanel = class(TCustomcontrol)
    private
    Fborder : Boolean;
    Procedure Setborder(value : boolean);
    protected
        procedure Paint; override;
    public
        procedure CreateParams(var Params: TCreateParams); override;
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
    published
        Property Border:Boolean read Fborder write Setborder;
        Property Visible;
        property Enabled;
        Property Align;
        property OnClick;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Controle de  Dados', [TTranPanel]);
end;

procedure TTranPanel.CreateParams(var Params: TCreateParams);
begin
     { call the create of the params }
     inherited CreateParams(Params);
     Params.ExStyle := Params.ExStyle + WS_EX_Transparent;
     ControlStyle := ControlStyle - [csOpaque] + [csAcceptsControls]
end;

constructor TTranPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 185;
  Height := 41;
end;

destructor TTranPanel.Destroy;
begin
     inherited Destroy;
end;

procedure TTranPanel.Paint;
begin
  If Fborder or (csDesigning in ComponentState) then
   begin
     Canvas.brush.color := clbtnshadow;
     Canvas .framerect(clientrect);
   end;
end;

Procedure TTranpanel.Setborder(value : boolean);
begin
if value <> Fborder then
begin
  Fborder := value;
  invalidate;
end;
end;

end.
