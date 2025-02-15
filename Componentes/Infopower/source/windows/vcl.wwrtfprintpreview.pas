unit vcl.wwrtfprintpreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ToolWin, RichEdit, wwriched,
  Menus, ImgList, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Wwdbspin, wwcommon;

type
  TwwRtfPreviewForm = class(TForm)
    ToolBar1: TToolBar;
    ScrollBox1: TScrollBox;
    PaintBox1: TPaintBox;
    PrintDialog: TPrintDialog;
    RichEditButtonIcons: TImageList;
    PopupMenu1: TPopupMenu;
    N5001: TMenuItem;
    N2001: TMenuItem;
    N1501: TMenuItem;
    N10001: TMenuItem;
    N751: TMenuItem;
    N501: TMenuItem;
    N251: TMenuItem;
    Auto1: TMenuItem;
    zoomCombo: TwwDBComboBox;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    Label1: TLabel;
    wwDBSpinEdit1: TwwDBSpinEdit;
    procedure PaintBox1Paint(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure wwDBSpinEdit1Change(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure zoomComboChange(Sender: TObject);
  private
    { Private declarations }
    FMetafile: TMetafile;
    FRichedit: TwwCustomRichedit;
    FPages : Array of richedit.TCharRange;
    FPagerect: TRect;
    FPrintRect: TRect;
    FZoomFactor: double;
    NumPages: integer;

    Procedure PreparePreview( aRichedit: TwwCustomRichedit );
    Procedure Paginate;
    Procedure DrawPage( pagenum: Integer );
    Function RenderPage( pagenum: Integer; render: BOOL = true ): Integer;
    procedure VerifyPagenum(pagenum: Integer);
    procedure PrintHeader(cv: TCanvas);
//    function TwipsToPrinterPixels(Twips: integer): integer;
    procedure UpdateZoom;
    Procedure DrawScaled( Canvas: TCanvas; const outrect: TRect;
       image: TGraphic; iwidth, iheight: Integer );
  public
    { Public declarations }
    Destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    class procedure Preview( arichedit: TwwCustomRichedit );

  end;

var
  wwRtfPreviewForm: TwwRtfPreviewForm;

implementation

{$R *.dfm}

uses printers;


Type
  TPageInfo = record
    width, height: Integer; { physical width and height, in dots }
    offsetX, offsetY: Integer;{ nonprintable margin, in dots }
    resX, resY: Integer; { logical resolution, dots per inch }
  End;

Procedure GetPageinfo( Var info: TPageInfo; index: Integer = -1 );
  Begin
    If index > -1 Then
      Printer.PrinterIndex := index;
    With Printer Do Begin
      info.resX := GetDeviceCaps( handle, LOGPIXELSX );
      info.resY := GetDeviceCaps( handle, LOGPIXELSY );
      info.offsetX := GetDeviceCaps( handle, PHYSICALOFFSETX );
      info.offsetY := GetDeviceCaps( handle, PHYSICALOFFSETY );
      info.width := GetDeviceCaps( handle, PHYSICALWIDTH );
      info.height := GetDeviceCaps( handle, PHYSICALHEIGHT );
    End; { With }
  End;

Procedure DotsToTwips( Var value: Integer; dpi: Integer );
  Begin
    value := MulDiv( value, 1440, dpi );
  End;

{-- DrawScaled --------------------------------------------------------}
{: Draw an image scaled isotropically so it fits into the outrect
   of the canvas.
@Param Canvas is the output device
@Param outrect is the available space on the device
@Param image is the graphic element to render
@Param iwidth is the elements width
@Param iheight is the elements height
@Precondition Canvas <> nil, passed width and height > 0
@Desc If the graphic is drawn scaled to fit the output area, while
  preserving the aspect ratio. If a Nil graphic is passed we exit
  without doing anything.
}{ Created 21.6.2001 by P. Below
-----------------------------------------------------------------------}
Procedure TwwRtfPreviewForm.DrawScaled( Canvas: TCanvas; const outrect: TRect;
    image: TGraphic; iwidth, iheight: Integer );
  Var
    imageaspect, outputaspect: Double;
    r: TRect;
    outwidth, outheight: Integer;
  Begin { DrawScaled }
    Assert( Assigned( Canvas ), 'DrawScaled: no canvas');
    Assert( iwidth > 0, 'DrawScaled: width cannot be negative' );
    Assert( iheight > 0, 'DrawScaled: height cannot be negative' );

    If not Assigned( image ) Then Exit;

    outwidth := outrect.right - outrect.left;
    outheight:= outrect.bottom - outrect.top;
    imageaspect:= iwidth / iheight;
    outputaspect := outwidth / outheight;
    r:= Rect( 0,0,0,0);
    If (imageaspect > outputaspect) Then Begin
      r.right := outwidth;
      r.Bottom := round( outwidth / imageaspect );
      OffsetRect( r,
                  outrect.left, outrect.top);

//      OffsetRect( r,
//                  outrect.left,
//                  outrect.top + ( outheight - r.bottom ) div 2
//                );

    End { If }
    Else Begin
      r.bottom := outheight;
      r.right := Round( outheight * imageaspect );
      OffsetRect( r,
                  outrect.left + ( outwidth - r.right ) div 2,
                  outrect.top
                );
    End; { Else }
//    r.left:= r.left + 300;

    Canvas.StretchDraw( r, image );
  End; { DrawScaled }

destructor TwwRtfPreviewForm.Destroy;
begin
  PaintBox1.OnPaint := nil;
  Fmetafile.Free;
  inherited;
end;

constructor TwwRtfPreviewForm.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FZoomFactor:= 1.0;

end;

Procedure TwwRtfPreviewForm.VerifyPagenum( pagenum: Integer );
Begin
  If pagenum >= Length( FPages ) Then
    SetLength( FPages, pagenum+32 );
End;

procedure TwwRtfPreviewForm.wwDBSpinEdit1Change(Sender: TObject);
begin
  Drawpage(trunc(wwdbspinedit1.value-1));
end;

procedure TwwRtfPreviewForm.zoomComboChange(Sender: TObject);
begin
//   if select then
   begin
      if (zoomcombo.value='500') then
         FZoomFactor:= 5.0
      else if (zoomcombo.value='200') then
         FZoomFactor:= 2.0
      else if (zoomcombo.value='100') then
         FZoomFactor:= 1.0
      else if (zoomcombo.value='75') then
         FZoomFactor:= 0.75
      else if (zoomcombo.value='50') then
         FZoomFactor:= 0.5
      else if (zoomCombo.value='自适应宽度') then
         FZoomFactor:= -1;
      UpdateZoom;
   end;

end;

procedure TwwRtfPreviewForm.DrawPage(pagenum: Integer);
  Function VerifyPagination: Boolean;
    Begin
      Result := FPages[0].cpMax > Fpages[0].cpMin;
    End;
begin
  VerifyPagenum( pagenum );
  If not VerifyPagination Then
    Paginate;
  RenderPage( pagenum );
  FRichedit.Perform( EM_FORMATRANGE, 0, 0 );
  PaintBox1.Invalidate;
end;

procedure TwwRtfPreviewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=vk_next then
      wwdbspinedit1.Value:= wwdbspinedit1.value+1
   else if key=vk_prior then
      wwdbspinedit1.value:= wwdbspinedit1.value - 1
   else if key=vk_up then
   begin
      scrollbox1.VertScrollBar.Position:= wwmax(1, scrollbox1.vertscrollbar.position - scrollbox1.vertscrollbar.increment);
//      sysutils.abort;
      key:= 0;
   end
   else if key=vk_down then begin
      scrollbox1.VertScrollBar.Position:= wwmin(scrollbox1.VertScrollBar.range, scrollbox1.vertscrollbar.position + scrollbox1.vertscrollbar.increment);
//      sysutils.abort;
      key:= 0;
   end;
        

end;

procedure TwwRtfPreviewForm.FormShow(Sender: TObject);
begin
zoomcombo.Items.Add('500%' + #9 + '500');
zoomcombo.Items.Add('200%' + #9 + '200');
zoomcombo.Items.Add('100%' + #9 + '100');
zoomcombo.Items.Add('75%' + #9 + '75');
zoomcombo.Items.Add('50%' + #9 + '50');
zoomcombo.Items.Add('自适应宽度' + #9 +  '自适应宽度');
zoomcombo.Items.Add('整页' + #9 +  '整页');
zoomCombo.ItemIndex:= 5;
UpdateZoom;
scrollbox1.SetFocus;
{
zoomcombo.Items.AddObject('200%', '200');
zoomcombo.Items.AddObject('100%', '100');
zoomcombo.Items.AddObject('75%', '75');
zoomcombo.Items.AddObject('50%', '50');
zoomcombo.Items.AddObject('自适应宽度', '自适应宽度');
zoomcombo.Items.AddObject('Fit Page', 'FitPage');
 }

 if FRichEdit.PrintPreviewCaption<>'' then
    self.Caption:= FRichEdit.PrintPreviewCaption;
 
end;

procedure TwwRtfPreviewForm.Paginate;
var
  info: TPageInfo;
  pagenum, lastchar, len: Integer;
  Procedure RectToTwips( Var rect: TRect );
  Begin
    DotsToTwips( rect.left, info.resX );
    DotsToTwips( rect.right, info.resX );
    DotsToTwips( rect.top, info.resY );
    DotsToTwips( rect.bottom, info.resY );
  End;
begin
  GetPageinfo( info );
  FPagerect := Rect( 0, 0, info.width, info.height );
  RectToTwips( FPagerect );
  FPrintrect := FRichedit.PageRect;
  If IsRectEmpty( FprintRect ) Then Begin
    // use a default output rect with 1 inch magin top and bottom
    // and 1 inch right and left
//    Fprintrect := FPagerect;
//    InflateRect( FPrintrect, -1440, -1440 );
    FPrintRect:= FRichEdit.GetPrinterRect;

  End
  Else
    RectToTwips( FPrintrect );

  pagenum := 0;
  lastchar := 0;
  len := FRichedit.GetTextLen;
  Screen.Cursor := crHourglass;
//Scrollbar.Min := 0;
//Scrollbar.Max := 0;
  Try
    While lastchar < len Do Begin
      VerifyPagenum( pagenum );
      FPages[pagenum].cpMin := lastchar;
      FPages[pagenum].cpMax := len;
      lastchar := RenderPage( pagenum, false );
      If lastchar <= FPages[pagenum].cpMin Then
         lastchar := len
      Else Begin
        FPages[pagenum].cpMax := lastchar-1;
//      Scrollbar.Max := pagenum;
        Inc( pagenum );
      End;
      FRichEdit.TotalPages:= pagenum;
    End;
  Finally
    Screen.Cursor := crDefault;
    NumPages:= pageNum;
    wwdbspinedit1.MaxValue:= numpages;
  End; { Finally }

end;

procedure TwwRtfPreviewForm.PaintBox1Paint(Sender: TObject);
var
  cv: TCanvas;
  r: TRect;
begin
  cv:= (sender as TPaintbox).canvas;
  r:= TPaintBox(sender).clientrect;
  cv.FillRect(r);
  cv.Pen.Color:= clBlack;
  InflateRect(r, -1, -1);
  cv.Rectangle(r);
  InflateRect(r, -1, -1);

  DrawScaled( cv, r,
              Fmetafile, Fmetafile.mmWidth, Fmetafile.mmHeight );
end;

procedure TwwRtfPreviewForm.UpdateZoom;
var vertScrollOffset: integer;
    desiredHeight1, desiredHeight2, desiredWidth1, desiredWidth2: integer;
    desiredWidth, desiredheight: integer;
    savePosition: integer;
begin
  savePosition:=      ScrollBox1.VertScrollBar.Position;
  ScrollBox1.VertScrollBar.Position:=0;

  if (zoomCombo.value='自适应宽度') then
  begin
     vertScrollOffset:= GetSystemMetrics(SM_CXHThumb) + 1;
     PaintBox1.Left:= Trunc(Screen.PixelsPerInch * 0.1);
     PaintBox1.Width:= ScrollBox1.Width - Trunc(PaintBox1.Left * 2.5 + VertScrollOffset);
     PaintBox1.Top:= Trunc(Screen.PixelsPerInch * 0.1);
     PaintBox1.Height:= Trunc(PaintBox1.Width * Printer.PageHeight/Printer.PageWidth);
     ScrollBox1.VertScrollBar.Range:= PaintBox1.Height + 4 + Trunc(Screen.PixelsPerInch * 0.15);
     ScrollBox1.HorzScrollBar.Range:= PaintBox1.Width + Trunc(Screen.PixelsPerInch * 0.1);
  end
  else if (zoomCombo.value='整页') then
  begin
     PaintBox1.Left:= Trunc(Screen.PixelsPerInch * 0.1);
     PaintBox1.Top:= Trunc(Screen.PixelsPerInch * 0.1);

     DesiredWidth1:= ScrollBox1.Width - Trunc(PaintBox1.Left * 2);
     DesiredHeight1:= Trunc(DesiredWidth1 * Printer.PageHeight/Printer.PageWidth);
     DesiredHeight2:= ScrollBox1.Height - Trunc(PaintBox1.Top * 2);
     DesiredWidth2:= Trunc(DesiredHeight2 * Printer.PageWidth/Printer.PageHeight);

     if DesiredWidth1>DesiredWidth2 then
     begin
        DesiredWidth:= DesiredWidth2;
        DesiredHeight:= DesiredHeight2;
     end
     else begin
        DesiredWidth:= DesiredWidth1;
        DesiredHeight:= DesiredHeight1;
     end;

     PaintBox1.Height:= DesiredHeight;
     PaintBox1.Width:= DesiredWidth;
     ScrollBox1.VertScrollBar.Range:= PaintBox1.Height + 4 + Trunc(Screen.PixelsPerInch * 0.15);
     ScrollBox1.HorzScrollBar.Range:= PaintBox1.Width + Trunc(Screen.PixelsPerInch * 0.1);
  end
  else begin
     PaintBox1.Left:= Trunc(Screen.PixelsPerInch * 0.1);
     PaintBox1.Top:= Trunc(Screen.PixelsPerInch * 0.1);
     PaintBox1.Width:= Trunc(Screen.PixelsPerInch * Printer.PageWidth/GetDeviceCaps(Printer.Handle, LOGPIXELSX) * FZoomFactor) + 4;
     PaintBox1.Height:= Trunc(Screen.PixelsPerInch * Printer.PageHeight/GetDeviceCaps(Printer.Handle, LOGPIXELSY) * FZoomFactor) + 4;
     ScrollBox1.VertScrollBar.Range:= PaintBox1.Height + 4 + Trunc(Screen.PixelsPerInch * 0.15);
     ScrollBox1.HorzScrollBar.Range:= PaintBox1.Width + 4 + Trunc(Screen.PixelsPerInch * 0.1);

  end;
  ScrollBox1.VertScrollBar.Position:= savePosition;
end;

procedure TwwRtfPreviewForm.PreparePreview(aRichedit: TwwCustomRichedit);
begin
  FMetafile:= TMetafile.Create;
  FRichedit:= aRichedit;
  SetLength( FPages, 256 );
  UpdateZoom;
  DrawPage( 0 );
end;

class procedure TwwRtfPreviewForm.Preview(arichedit: TwwCustomRichedit);
begin
  assert( assigned( arichedit ));
  With TwwRtfPreviewform.Create( application ) Do
  Try
    PreparePreview( arichedit );
//    Show;
    Showmodal;
  Finally
    Free;
  End; { Finally }

end;

{  function TwwRTFPreviewForm.TwipsToPrinterPixels(Twips: integer): integer;
  var PrinterPixelsPerInch: integer;
  begin
     PrinterPixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
     result:= (Twips * PrinterPixelsPerInch) div 1440;
  end;
 }


procedure TwwRTFPreviewForm.PrintHeader(cv: TCanvas);
var
  HeaderRect: TRect;
  LeftText, RightText, Centertext: string;
  rc: TRect;
  Logx, logy: integer;
  PrnPhysPageSize, PrnPageOffset: TPoint;
  tempPageNumber: integer;
  DoDefault: boolean;
  th: integer;

  function TwipsToPrinterPixels(Twips: integer): integer;
  var PrinterPixelsPerInch: integer;
  begin
     PrinterPixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
     result:= (Twips * PrinterPixelsPerInch) div 1440;
  end;
begin

   tempPageNumber:= trunc(wwdbspinedit1.value);

   LogX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
   LogY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
   Escape( Printer.Handle, GETPHYSPAGESIZE, 0, nil, @PrnPhysPageSize);

  with Printer, FRichEdit do begin
    if IsRectEmpty(FRichEdit.PageRect) then
    begin
      rc:= GetPrinterRect;
    end
    else begin
      rc.left := (PageRect.Left * 1440) div LogX;
      rc.top := (PageRect.Top * 1440) div LogY;
      rc.right := (PageRect.Right * 1440) div LogX;
      rc.bottom := (PageRect.Bottom * 1440) div LogY;
    end;
  end;

  with self.FRichedit do
  begin
     Escape( Printer.Handle, GETPRINTINGOFFSET, 0, nil, @PrnPageOffset);
     HeaderRect:=
       Rect(TwipsToPrinterPixels(rc.left),
            Trunc(PrintHeader.VertMargin*LogY) - PrnPageOffset.y,
            TwipsToPrinterPixels(rc.right),
            TwipsToPrinterPixels(rc.Top));
  end;

  LeftText:= FRichEdit.PrintHeader.LeftText;
  CenterText:= FRichEdit.PrintHeader.CenterText;
  RightText:= FRichEdit.PrintHeader.RightText;
  FRichEdit.DoPrintHeader(HeaderRect, tempPageNumber, LeftText, CenterText, RightText, DoDefault);

  cv.Font.Assign(FRichEdit.PrintHeader.Font);
  if (Printer.Fonts.IndexOf(FRichEdit.PrintHeader.Font.Name)<0) then
     cv.Font.Name:= 'Arial' ;
  cv.Font.Size:= Trunc((cv.Font.Size * LogX) / Screen.PixelsPerInch);

  if LeftText<>'' then cv.TextOut(HeaderRect.Left, HeaderRect.Top, LeftText);
  if RightText<>'' then cv.TextOut(HeaderRect.Right-cv.TextWidth(RightText), HeaderRect.Top, RightText);
  if CenterText<>'' then cv.TextOut(HeaderRect.Left+
      (HeaderRect.Right-HeaderRect.Left-cv.TextWidth(CenterText)) div 2,
       HeaderRect.Top, CenterText);

  if FRichEdit.PrintHeader.LineSeparator then
  begin
     cv.Pen.Width:= TwipsToPrinterPixels(6);
     cv.MoveTo(HeaderRect.Left, HeaderRect.Top + cv.TextHeight('H') + TwipsToPrinterPixels(28));
     cv.LineTo(HeaderRect.Right, HeaderRect.Top + cv.TextHeight('H') + TwipsToPrinterPixels(28));;
  end;

  // Footer
  cv.Font.Assign(FRichEdit.PrintFooter.Font);
  if (Printer.Fonts.IndexOf(FRichEdit.PrintFooter.Font.Name)<0) then
     cv.Font.Name:= 'Arial' ;
  cv.Font.Size:= Trunc((cv.Font.Size * LogX) / Screen.PixelsPerInch);
  th:= cv.TextHeight('H');

  with FRichEdit do
     HeaderRect:=
       Rect(TwipsToPrinterPixels(rc.left),
//            Trunc(PrnPhysPageSize.Y - PrintFooter.VertMargin*LogY)-PrnPageOffset.Y,
            Trunc(PrnPhysPageSize.Y - PrintFooter.VertMargin*LogY - TwipsToPrinterPixels(720)),
            TwipsToPrinterPixels(rc.right),
//            PrnPhysPageSize.Y);
            Trunc(PrnPhysPageSize.Y - PrintFooter.VertMargin*LogY - PrnPageOffset.Y));
//            Trunc(PrnPhysPageSize.Y - PrintFooter.VertMargin*LogY));
  LeftText:= FRichEdit.PrintFooter.LeftText;
  CenterText:= FRichEdit.PrintFooter.CenterText;
  RightText:= FRichEdit.PrintFooter.RightText;
  FRichEdit.DoPrintFooter(HeaderRect, tempPageNumber, LeftText, CenterText, RightText, DoDefault);

  if LeftText<>'' then cv.TextOut(HeaderRect.Left, HeaderRect.Bottom - th, LeftText);
  if RightText<>'' then cv.TextOut(HeaderRect.Right-cv.TextWidth(RightText), HeaderRect.Bottom-th, RightText);
  if CenterText<>'' then
     cv.TextOut(HeaderRect.Left+
             (HeaderRect.Right-HeaderRect.Left-cv.TextWidth(CenterText)) div 2,
              HeaderRect.Bottom-th, CenterText);

  if FRichEdit.PrintFooter.LineSeparator then
  begin
     cv.Pen.Width:= TwipsToPrinterPixels(6);
     cv.MoveTo(HeaderRect.Left, HeaderRect.Bottom - cv.TextHeight('H') - TwipsToPrinterPixels(28));
     cv.LineTo(HeaderRect.Right, HeaderRect.Bottom - cv.TextHeight('H') - TwipsToPrinterPixels(28));;

//     cv.MoveTo(HeaderRect.Left, HeaderRect.Top + cv.TextHeight('H') + TwipsToPrinterPixels(28));
//     cv.LineTo(HeaderRect.Right, HeaderRect.Top + cv.TextHeight('H') + TwipsToPrinterPixels(28));;
  end;


end;

Function TwwRtfPreviewForm.RenderPage(pagenum: Integer; render: BOOL): Integer;
var
  mfc: TMetafilecanvas;
  fmt: TFormatRange;
  PrnPhysPageSize: TPoint;
//  LogY: integer;
begin
  FMetafile.Clear;
  mfc:= TMetafilecanvas.Create( Fmetafile, Printer.handle );

  //LogY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);

  Try
    mfc.Brush.Color := clWhite;
    mfc.Brush.Style := bsSolid;
    Escape( Printer.Handle, GETPHYSPAGESIZE, 0, nil, @PrnPhysPageSize);
    mfc.FillRect( Rect(0,0,Printer.PageWidth, Printer.PageHeight ));

    PrintHeader(mfc);
    fmt.hdc := mfc.Handle;
    fmt.hdcTarget := printer.Handle;
    fmt.rc := FPrintrect;
    fmt.rcPage := FPageRect;
    fmt.chrg := Fpages[ pagenum ];
    Result := FRichedit.Perform( EM_FORMATRANGE, WPARAM(render),
                                 LPARAM(@fmt));
  Finally
    mfc.free;

  End; { Finally }
end;

procedure TwwRtfPreviewForm.ScrollBox1Resize(Sender: TObject);
begin
  if (zoomCombo.value='自适应宽度') or  (zoomCombo.value='整页') then
  begin
    UpdateZoom;
  end;

   
end;

procedure TwwRtfPreviewForm.ToolButton1Click(Sender: TObject);
var
  pagenum: Integer;
  info: TPageInfo;
begin
  With PrintDialog Do Begin
    Minpage := 1;
    Maxpage := 1;
    FromPage := MinPage;
    ToPage := MaxPage;
    If not Execute Then Exit;
  End;
  GetPageinfo( info );
  Printer.BeginDoc;
  Try
    Screen.Cursor := crHourglass;
    For pagenum := PrintDialog.Frompage-1 To PrintDialog.ToPage-1
    Do Begin
      RenderPage( pagenum );
      Printer.Canvas.Draw( -info.offsetX, -info.offsetY, FMetafile );
      If pagenum < (PrintDialog.ToPage-1) Then
        Printer.NewPage;
    End;
  Finally
    Screen.Cursor := crDefault;
    Printer.EndDoc;
  End; { Finally }
end;


procedure TwwRtfPreviewForm.ToolButton2Click(Sender: TObject);
begin
   printdialog.collate:= True;
   printdialog.MinPage:= 1;
   printDialog.MaxPage:= NumPages;
   printDialog.FromPage:=1;
   printDialog.ToPage:= NumPages;
   if printdialog.execute then
   begin
      FRichEdit.Patch[8]:= wwMax(1, printDialog.FromPage);
      FRichEdit.Patch[9]:= wwMin(printDialog.ToPage, printDialog.MaxPage);
      try
         FRichedit.Print(FRichEdit.PrintJobName);      
      finally
        FRichEdit.Patch[8]:= 0;
        FRichEdit.Patch[9]:= 0;
      end;
   end
end;

procedure TwwRtfPreviewForm.ToolButton5Click(Sender: TObject);
begin
  Close;
end;

end.
