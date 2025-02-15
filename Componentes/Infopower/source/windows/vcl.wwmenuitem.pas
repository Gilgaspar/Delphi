unit vcl.wwmenuitem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ImgList, Menus,
  system.Types, system.UITypes;

type
  TwwMenuItem = class(TMenuItem)
  protected
    procedure AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
      State: TOwnerDrawState; TopLevel: Boolean); override;
  end;

  procedure Register;

implementation

uses uxtheme, themes;

type TwwGradientDirection = (gdVertical, gdHorizontal);

procedure Register;
begin
   RegisterClass(TwwMenuItem);
end;

procedure DoDrawVistaText(MenuItem: TMenuItem; ACanvas: TCanvas;
  const ACaption: string; var Rect: TRect; Selected: Boolean; Flags: Longint);
const
  MenuStates: array[Boolean] of Cardinal = (MPI_DISABLED, MPI_NORMAL);
var
  Text: UnicodeString;
  ParentMenu: TMenu;
  Options: TDTTOpts;
begin
  // Setup Options
{$IF NOT DEFINED(CLR)}
  FillChar(Options, SizeOf(Options), 0);
{$ENDIF}
  Options.dwSize := SizeOf(Options);
  Options.dwFlags := DTT_TEXTCOLOR or DTT_COMPOSITED;
  if Flags and DT_CALCRECT = DT_CALCRECT then
    Options.dwFlags := Options.dwFlags or DTT_CALCRECT;

  // Set text color
  Options.crText := ColorToRGB(ACanvas.Font.Color);

  // Adjust flags for BiDi
  ParentMenu := MenuItem.GetParentMenu;
  if (ParentMenu <> nil) and (ParentMenu.IsRightToLeft) then
  begin
    if Flags and DT_LEFT = DT_LEFT then
      Flags := Flags and (not DT_LEFT) or DT_RIGHT
    else if Flags and DT_RIGHT = DT_RIGHT then
      Flags := Flags and (not DT_RIGHT) or DT_LEFT;
    Flags := Flags or DT_RTLREADING;
  end;

  // Tweak menu item text
  Text := ACaption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or
    (Text[1] = cHotkeyPrefix) and (Text[2] = #0)) then Text := Text + ' ';

  // Draw menu item text
  with ACanvas do
  begin
    Brush.Style := bsClear;
    if MenuItem.Default then
      Font.Style := Font.Style + [fsBold];
    DrawThemeTextEx(StyleServices.Theme[teMenu], ACanvas.Handle, MENU_POPUPITEM,
      MenuStates[MenuItem.Enabled], Text, Length(Text), Flags, Rect, Options);
  end;
end;

function FillGradient(DC: HDC; ARect: TRect; ColorCount: Integer;
  StartColor, EndColor: TColor; ADirection: TwwGradientDirection): Boolean;
var
  StartRGB: array [0..2] of Byte;
  RGBKoef: array [0..2] of Double;
  Brush: HBRUSH;
  AreaWidth, AreaHeight, I: Integer;
  ColorRect: TRect;
  RectOffset: Double;
begin
  RectOffset := 0;
  Result := False;
  if ColorCount < 1 then
    Exit;
  StartColor := ColorToRGB(StartColor);
  EndColor := ColorToRGB(EndColor);
  StartRGB[0] := GetRValue(StartColor);
  StartRGB[1] := GetGValue(StartColor);
  StartRGB[2] := GetBValue(StartColor);
  RGBKoef[0] := (GetRValue(EndColor) - StartRGB[0]) / ColorCount;
  RGBKoef[1] := (GetGValue(EndColor) - StartRGB[1]) / ColorCount;
  RGBKoef[2] := (GetBValue(EndColor) - StartRGB[2]) / ColorCount;
  AreaWidth := ARect.Right - ARect.Left;
  AreaHeight :=  ARect.Bottom - ARect.Top;
  case ADirection of
    gdHorizontal:
      RectOffset := AreaWidth / ColorCount;
    gdVertical:
      RectOffset := AreaHeight / ColorCount;
  end;
  for I := 0 to ColorCount - 1 do
  begin
    Brush := CreateSolidBrush(RGB(
      StartRGB[0] + Round((I + 1) * RGBKoef[0]),
      StartRGB[1] + Round((I + 1) * RGBKoef[1]),
      StartRGB[2] + Round((I + 1) * RGBKoef[2])));
    case ADirection of
      gdHorizontal:
        SetRect(ColorRect, Round(RectOffset * I), 0, Round(RectOffset * (I + 1)), AreaHeight);
      gdVertical:
        SetRect(ColorRect, 0, Round(RectOffset * I), AreaWidth, Round(RectOffset * (I + 1)));
    end;
    OffsetRect(ColorRect, ARect.Left, ARect.Top);
    FillRect(DC, ColorRect, Brush);
    DeleteObject(Brush);
  end;
  Result := True;
end;

procedure TwwMenuItem.AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
  State: TOwnerDrawState; TopLevel: Boolean);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
//  Gradient2Start            = $00d8baab;
//  Gradient2End              = $00efe8e4;
  Gradient2Start            = $0069D6FF;
  Gradient2End              = $0096E4FF;

var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  Alignment: TPopupAlignment;
  DrawImage, DrawGlyph: Boolean;
  GlyphRect, SaveRect: TRect;
  DrawStyle: Longint;
  Glyph: TBitmap;
  OldBrushColor: TColor;
  Selected: Boolean;
  Win98Plus: Boolean;
  Win2K: Boolean;
  WinXP: Boolean;
  WinXPFlatMenus: Boolean;
  WinVista: Boolean;
  LTheme: HTheme;

  procedure VistaDraw(RightToLeft: Boolean);
  const
    ItemStates: array[Boolean] of Cardinal = (MPI_DISABLED, MPI_NORMAL);
    TopLevelItemStates: array[Boolean] of Cardinal = (MBI_DISABLED, MBI_NORMAL);
    CheckMarkBkgs: array[Boolean] of Cardinal = (MCB_DISABLED, MCB_NORMAL);
    CheckMarkStates: array[Boolean {Enabled}, Boolean {RadioItem}] of Cardinal =
      ((MC_CHECKMARKDISABLED, MC_BULLETDISABLED), (MC_CHECKMARKNORMAL, MC_BULLETNORMAL));
  var
    LShortCut: string;
    LColorRef: TColorRef;
    LSize, LCheckSize: TSize;
    LMargins, LCheckMargins: Margins;
    LGutterRect, LCheckRect, LBitmapRect: TRect;
  begin
    with ACanvas do
    begin
      if TopLevel then
      begin
        if (odSelected in State) or (odHotLight in State) then
        begin
          Brush.Color := clMenuHighlight;
          GetThemeColor(StyleServices.Theme[teMenu], MENU_BARITEM,
            TopLevelItemStates[Enabled], TMT_TEXTCOLOR, LColorRef);
          Font.Color := LColorRef;
        end
        else
          Brush.Color := clMenuBar;
        FillRect(ARect);
      end
      else
      begin
        DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
          MENU_POPUPBACKGROUND, 0, ARect, nil);

        GetThemeColor(StyleServices.Theme[teMenu], MENU_POPUPITEM,
          ItemStates[Enabled], TMT_TEXTCOLOR, LColorRef);
        Font.Color := LColorRef;
      end;

      // Determine rect for check marks
      GetThemePartSize(StyleServices.Theme[teMenu], Handle, MENU_POPUPCHECK,
        CheckMarkStates[Enabled, RadioItem], nil, TS_TRUE, LCheckSize);
      GetThemeMargins(StyleServices.Theme[teMenu], Handle, MENU_POPUPCHECK,
        CheckMarkStates[Enabled, RadioItem], TMT_CONTENTMARGINS, nil, LCheckMargins);
      with ARect, LCheckMargins do
        if not RightToLeft then
          LCheckRect := Rect(Left, Top,
            Left + LCheckSize.cx + cxRightWidth + cxRightWidth,
            Top + LCheckSize.cy + cyBottomHeight + cyBottomHeight)
        else
          LCheckRect := Rect(Right - LCheckSize.cx - cxRightWidth - cxRightWidth,
            Top, Right, Top + LCheckSize.cy + cyBottomHeight + cyBottomHeight);

      // Calculate glyph rect
      GlyphRect := LCheckRect;
      if Assigned(ImageList) then
      begin
        if ImageList.Height > LCheckSize.cy then
          Inc(GlyphRect.Bottom, ImageList.Height - LCheckSize.cy);
        if ImageList.Width > LCheckSize.cx then
          if not RightToLeft then
            Inc(GlyphRect.Right, ImageList.Width - LCheckSize.cx)
          else
            Dec(GlyphRect.Left, ImageList.Width - LCheckSize.cx);
        OffsetRect(LCheckRect, (GlyphRect.Right - LCheckRect.Right) div 2,
          (GlyphRect.Bottom - LCheckRect.Bottom) div 2);
      end;

      // Calculate rect for gutter and draw it
      LGutterRect := GlyphRect;
      if RightToLeft then
        LGutterRect.Right := GlyphRect.Left;
      GetThemePartSize(StyleServices.Theme[teMenu], Handle,
        MENU_POPUPGUTTER, 0, nil, TS_TRUE, LSize);
      GetThemeMargins(StyleServices.Theme[teMenu], Handle,
        MENU_POPUPGUTTER, 0, TMT_SIZINGMARGINS, nil, LMargins);
      if not RightToLeft then
      begin
        Inc(LGutterRect.Right, LSize.cx + LCheckMargins.cxLeftWidth);
        Inc(LGutterRect.Right, LMargins.cxLeftWidth);
      end
      else
      begin
        Dec(LGutterRect.Left, LSize.cx + LCheckMargins.cxRightWidth);
        Dec(LGutterRect.Right, LMargins.cxRightWidth);
      end;
      if not TopLevel then
        DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
          MENU_POPUPGUTTER, 0, LGutterRect, nil);

      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;

      if Caption <> cLineCaption then
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.Count) or Checked and ((Bitmap = nil) or
          Bitmap.Empty));
        if DrawImage or Assigned(Bitmap) and not Bitmap.Empty then
        begin
          if DrawImage then
          begin
            // Draw glyph
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
            begin
              // If checked paint in background
              if Checked then begin

//                 FillGradient(ACanvas.Handle, lCheckRect, 256, Gradient2Start, Gradient2End, gdVertical);
                 ACanvas.Brush.Color:= Gradient2Start;

                 aCanvas.FillRect(lCheckRect);

//                 DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
//                  MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[Enabled], LCheckRect, nil);
//                 DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
//                   MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[Enabled], LCheckRect, nil);
              end;

              with GlyphRect do
                ImageList.Draw(ACanvas, Left + ((Right - Left - ImageList.Width) div 2),
                  Top + ((Bottom - Top - ImageList.Height) div 2), ImageIndex, Enabled)
            end
            else
            begin
              // Draw check mark
              if not TopLevel then
              begin
                DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
                  MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[Enabled], LCheckRect, nil);
                DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
                  MENU_POPUPCHECK, CheckMarkStates[Enabled, RadioItem], LCheckRect, nil);
              end;
            end;
          end
          else
          begin
            // Need to add BitmapWidth/Height properties for TMenuItem if we're to
            // support them. Right now let's hardcode them to 16x16.
            LBitmapRect := Rect(0, 0, 16, 16);
            with GlyphRect do
              OffSetRect(LBitmapRect, Left + ((Right - Left - 16) div 2),
                Top + ((Bottom - Top - 16) div 2));
            // Make sure image is within glyph bounds
            if Bitmap.Width < LCheckSize.cx then
              with LBitmapRect do
              begin
                Left := Left + ((Right - Left) - Bitmap.Width) div 2;
                Right := Left + Bitmap.Width;
              end;
            if Bitmap.Height < LCheckSize.cy then
              with LBitmapRect do
              begin
                Top := Top + ((Bottom - Top) - Bitmap.Height) div 2;
                Bottom := Top + Bitmap.Height;
              end;
            StretchDraw(LBitmapRect, Bitmap);
          end;
        end;
      end;

      // Draw menu highlight
      if Selected and not TopLevel then
        DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
          MENU_POPUPITEM, MPI_HOT, ARect, nil);

      // Calculate size of rect for Caption
      GetThemeMargins(StyleServices.Theme[teMenu], Handle,
        MENU_POPUPITEM, MPI_NORMAL, TMT_SIZINGMARGINS, nil, LMargins);
      if not TopLevel then
      begin
        if not RightToLeft then
        begin
          ARect.Left := LGutterRect.Right;
          Inc(ARect.Left, LMargins.cxLeftWidth);
        end
        else
        begin
          ARect.Right := LGutterRect.Left;
          Dec(ARect.Right, LMargins.cxLeftWidth);
        end;

        if Caption <> cLineCaption then
        begin
          GetThemePartSize(StyleServices.Theme[teMenu], Handle,
            MENU_POPUPSUBMENU, MSM_NORMAL, nil, TS_TRUE, LSize);
          if not RightToLeft then
            Dec(ARect.Right, LSize.cx)
          else
            Inc(ARect.Left, LSize.cx);
        end;
      end
      else
      begin
        if (Assigned(ImageList) and (ImageIndex <> -1)) or (Bitmap <> nil) then
        begin
          if not RightToLeft then
            Inc(ARect.Left, GlyphRect.Right - GlyphRect.Left)
          else
            Dec(ARect.Right, GlyphRect.Right - GlyphRect.Left);
        end
        else
        begin
          if not RightToLeft then
            Inc(ARect.Left, LMargins.cxLeftWidth)
          else
            Dec(ARect.Right, LMargins.cxLeftWidth);
        end;
      end;

      // Draw Caption + ShortCut or separator line
      if Caption <> cLineCaption then
      begin
        DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
        if (odNoAccel in State) then
          DrawStyle := DrawStyle or DT_HIDEPREFIX;
        // Calculate vertical layout
        SaveRect := ARect;
        DoDrawVistaText(Self, ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
        if RightToLeft then
        begin
          // DT_CALCRECT does not take into account alignment
          ARect.Left := SaveRect.Left;
          ARect.Right := SaveRect.Right;
        end;
        OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);

        DoDrawVistaText(Self, ACanvas, Caption, ARect, Selected, DrawStyle);
        if (ShortCut <> 0) and not TopLevel and (GetCount=0) then //(FItems = nil) then
        begin
          LShortCut := ShortCutToText(ShortCut);
          if not RightToLeft then
          begin
            ARect.Left := ARect.Right;
            ARect.Right := SaveRect.Right - LSize.cx - LMargins.cxLeftWidth;
          end
          else
          begin
            with LSize, LMargins do
              ARect.Left := cx + cx + cxLeftWidth + cxRightWidth;
            ARect.Right := ARect.Left + ACanvas.TextWidth(LShortCut);
          end;
          DoDrawText(ACanvas, LShortCut, ARect, Selected, DT_RIGHT);
        end;
      end
      else
      begin
        if not RightToLeft then
          ARect.Left := LGutterRect.Right + 1
        else
          ARect.Right := LGutterRect.Left - 1;
        GetThemeMargins(StyleServices.Theme[teMenu], Handle,
          MENU_POPUPSEPARATOR, 0, TMT_SIZINGMARGINS, nil, LMargins);
        Dec(ARect.Bottom, LMargins.cyBottomHeight);
        DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
          MENU_POPUPSEPARATOR, 0, ARect, nil);
      end;
    end;
  end;

  procedure NormalDraw;
  begin
    with ACanvas do
    begin
      if (WinXP and WinXPFlatMenus) or (WinXP and StyleServices.Enabled) then
      begin
        if (odSelected in State) or (odHotLight in State) then
        begin
          if StyleServices.Enabled then
            Brush.Color := clMenuHighlight
          else
            Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end
        else if TopLevel then
          Brush.Color := clMenuBar
      end;
      //ImageList := GetImageList;
      { With XP, we need to always fill in the rect, even when selected }
      if not Selected or WinXP then
        FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Left := ARect.Left + 1;
      GlyphRect.Top := ARect.Top + 1;
      if Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := 0;
        GlyphRect.Right := -4;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.Count) or Checked and ((Bitmap = nil) or
          Bitmap.Empty));
        if DrawImage or Assigned(Bitmap) and not Bitmap.Empty then
        begin
          DrawGlyph := True;

          if DrawImage then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            { Need to add BitmapWidth/Height properties for TMenuItem if we're to
              support them.  Right now let's hardcode them to 16x16. }
            GlyphRect.Right := GlyphRect.Left + 16;
            GlyphRect.Bottom := GlyphRect.Top + 16;
          end;

          { Draw background pattern brush if selected }
          if Checked and not WinXP then
          begin
            Inc(GlyphRect.Right);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Inc(GlyphRect.Left);
            Inc(GlyphRect.Top);
          end;

          if DrawImage then
          begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
              ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, ImageIndex,
                Enabled)
            else
            begin
              { Draw a menu check }
              Glyph := TBitmap.Create;
              try
                Glyph.Transparent := True;
{$IF DEFINED(CLR)}
                Glyph.Handle := LoadBitmap(0, OBM_CHECK);
{$ELSE}
                Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
{$ENDIF}
                OldBrushColor := Font.Color;
                Font.Color := clBtnText;
                Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                  GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
                Font.Color := OldBrushColor;
              finally
                Glyph.Free;
              end;
            end;
          end
          else
          begin
            SaveRect := GlyphRect;
            { Make sure image is within glyph bounds }
            if Bitmap.Width < GlyphRect.Right - GlyphRect.Left then
              with GlyphRect do
              begin
                Left := Left + ((Right - Left) - Bitmap.Width) div 2 + 1;
                Right := Left + Bitmap.Width;
              end;
            if Bitmap.Height < GlyphRect.Bottom - GlyphRect.Top then
              with GlyphRect do
              begin
                Top := Top + ((Bottom - Top) - Bitmap.Height) div 2 + 1;
                Bottom := Top + Bitmap.Height;
              end;
            StretchDraw(GlyphRect, Bitmap);
            GlyphRect := SaveRect;
          end;

          if Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if (ImageList <> nil) and not TopLevel then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            GlyphRect.Right := GlyphRect.Left;
            GlyphRect.Bottom := GlyphRect.Top;
          end;
          DrawGlyph := False;
        end;
      end;
      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;

      if Checked or Selected and DrawGlyph then
        if not WinXP then
          DrawEdge(Handle, GlyphRect, EdgeStyle[Checked], BF_RECT);

      if Selected then
      begin
        if DrawGlyph then ARect.Left := GlyphRect.Right + 1;
        if not (Win98Plus and TopLevel) then
          Brush.Color := clHighlight;
        FillRect(ARect);
      end;
      if TopLevel and Win98Plus and not (WinXP and WinXPFlatMenus) then
      begin
        if Selected then
          DrawEdge(Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
        else if odHotLight in State then
          DrawEdge(Handle, ARect, BDR_RAISEDINNER, BF_RECT);
        if not Selected then
          OffsetRect(ARect, 0, -1);
      end;

      if not (Selected and DrawGlyph) then
        ARect.Left := GlyphRect.Right + 1;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);

      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      if Win2K and (odNoAccel in State) then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
      if TopLevel and Selected and Win98Plus and not WinXP then
        OffsetRect(ARect, 1, 0);

      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle);
      if (ShortCut <> 0) and not TopLevel and not (WinVista and (GetCount>0)) then //(FItems <> nil)) then
      begin
        ARect.Left := ARect.Right;
        ARect.Right := SaveRect.Right - 10;
        DoDrawText(ACanvas, ShortCutToText(ShortCut), ARect, Selected, DT_RIGHT);
      end;

    end;
  end;

  procedure BiDiDraw;
  var
    S: string;
  begin
    with ACanvas do
    begin
      if (WinXP and WinXPFlatMenus) or (WinXP and StyleServices.Enabled) then
      begin
        if (odSelected in State) or (odHotLight in State) then
        begin
          if StyleServices.Enabled then
            Brush.Color := clMenuHighlight
          else
            Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end
        else if TopLevel then
          Brush.Color := clMenuBar
      end;
      //ImageList := GetImageList;
      { With XP, we need to always fill in the rect, even when selected }
      if not Selected or (WinXP and not Checked) then
        FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Right := ARect.Right - 1;
      GlyphRect.Top := ARect.Top + 1;
      if Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := GlyphRect.Right + 2;
        GlyphRect.Right := 0;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.Count) or Checked and ((Bitmap = nil) or
          Bitmap.Empty));
        if DrawImage or Assigned(Bitmap) and not Bitmap.Empty then
        begin
          DrawGlyph := True;

          if DrawImage then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            { Need to add BitmapWidth/Height properties for TMenuItem if we're to
              support them.  Right now let's hardcode them to 16x16. }
            GlyphRect.Left := GlyphRect.Right - 16;
            GlyphRect.Bottom := GlyphRect.Top + 16;
          end;

          { Draw background pattern brush if selected }
          if Checked then
          begin
            Dec(GlyphRect.Left);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Dec(GlyphRect.Right);
            Inc(GlyphRect.Top);
          end;

          if DrawImage then
          begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
              ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, ImageIndex,
                Enabled)
            else
            begin
              { Draw a menu check }
              Glyph := TBitmap.Create;
              try
                Glyph.Transparent := True;
{$IF DEFINED(CLR)}
                Glyph.Handle := LoadBitmap(0, OBM_CHECK);
{$ELSE}
                Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
{$ENDIF}
                OldBrushColor := Font.Color;
                Font.Color := clBtnText;
                Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                  GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
                Font.Color := OldBrushColor;
              finally
                Glyph.Free;
              end;
            end;
          end
          else
          begin
            SaveRect := GlyphRect;
            { Make sure image is within glyph bounds }
            if Bitmap.Width < GlyphRect.Right - GlyphRect.Left then
              with GlyphRect do
              begin
                Right := Right - ((Right - Left) - Bitmap.Width) div 2 + 1;
                Left := Right - Bitmap.Width;
              end;
            if Bitmap.Height < GlyphRect.Bottom - GlyphRect.Top then
              with GlyphRect do
              begin
                Top := Top + ((Bottom - Top) - Bitmap.Height) div 2 + 1;
                Bottom := Top + Bitmap.Height;
              end;
            StretchDraw(GlyphRect, Bitmap);
            GlyphRect := SaveRect;
          end;

          if Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if (ImageList <> nil) and not TopLevel then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            GlyphRect.Left := GlyphRect.Right;
            GlyphRect.Bottom := GlyphRect.Top;
          end;
          DrawGlyph := False;
        end;
      end;
      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;

      if Checked or Selected and DrawGlyph and not WinXP then
        DrawEdge(Handle, GlyphRect, EdgeStyle[Checked], BF_RECT);

      if Selected then
      begin
        if DrawGlyph then ARect.Right := GlyphRect.Left - 1;
        if not (Win98Plus and TopLevel) then
          Brush.Color := clHighlight;
        FillRect(ARect);
      end;
      if TopLevel and Win98Plus and not (WinXP and WinXPFlatMenus) then
      begin
        if Selected then
          DrawEdge(Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
        else if odHotLight in State then
          DrawEdge(Handle, ARect, BDR_RAISEDINNER, BF_RECT);
        if not Selected then
          OffsetRect(ARect, 0, -1);
      end;
      if not (Selected and DrawGlyph) then
        ARect.Right := GlyphRect.Left - 1;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      if Win2K and (odNoAccel in State) then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
      { the DT_CALCRECT does not take into account alignment }
      ARect.Left := SaveRect.Left;
      ARect.Right := SaveRect.Right;
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
      if TopLevel and Selected and Win98Plus then
        OffsetRect(ARect, 1, 0);
      DoDrawText(ACanvas, Caption, ARect, Selected, DrawStyle);
      if (ShortCut <> 0) and not TopLevel and not (WinVista and (GetCount>0)) then  //(FItems <> nil)) then
      begin
        S := ShortCutToText(ShortCut);
        ARect.Left := 10;
        ARect.Right := ARect.Left + ACanvas.TextWidth(S);
        DoDrawText(ACanvas, S, ARect, Selected, DT_RIGHT);
      end;
    end;
  end;

begin
  ParentMenu := GetParentMenu;
  ImageList := GetImageList;
  Selected := odSelected in State;
  Win98Plus := (Win32MajorVersion > 4) or
    ((Win32MajorVersion = 4) and (Win32MinorVersion > 0));
  Win2K := (Win32MajorVersion > 4) and (Win32Platform = VER_PLATFORM_WIN32_NT);
  WinXP := CheckWin32Version(5, 1);
  if WinXP and StyleServices.Available then
    WinXPFlatMenus := GetThemeSysBool(0, TMT_FLATMENUS)
  else
    WinXPFlatMenus := False;
  if (ParentMenu <> nil) and (ParentMenu.OwnerDraw or (ImageList <> nil)) and
    (Assigned(OnAdvancedDrawItem) or Assigned(OnDrawItem)) then
  begin
    DrawItem(ACanvas, ARect, Selected);
    if Assigned(OnAdvancedDrawItem) then
      OnAdvancedDrawItem(Self, ACanvas, ARect, State);
  end else
  begin
    // Detect if we're running on Vista, and if a menu theme is available
    LTheme := 0;
    WinVista := CheckWin32Version(6, 0);
    if WinVista then
      LTheme := StyleServices.Theme[teMenu];
    if LTheme <> 0 then
      VistaDraw((ParentMenu <> nil) and (ParentMenu.IsRightToLeft))
    else
      if (ParentMenu <> nil) and (not ParentMenu.IsRightToLeft) then
        NormalDraw
      else
        BiDiDraw;
  end;
end;

(*
procedure TForm14.Cut1AdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; State: TOwnerDrawState);
const    CheckMarkBkgs: array[Boolean] of Cardinal = (MCB_DISABLED,     MCB_NORMAL);
    CheckMarkStates: array[Boolean {Enabled}, Boolean {RadioItem}] of Cardinal =
      ((MC_CHECKMARKDISABLED, MC_BULLETDISABLED), (MC_CHECKMARKNORMAL, MC_BULLETNORMAL));
var
  lCheckRect, glyphrect: TRect;

    LSize, LCheckSize: TSize;
    LMargins, LCheckMargins: _Margins;
    menuItem: TMenuItem;
    ImageList: TCustomImageList;

begin
  //ACanvas.Brush.Color:=  clMenuHighlight;
  //ACanvas.FillRect(ARect);
  menuItem:= sender as TMenuItem;
  ImageList := menuItem.GetImageList;

  with ACAnvas do begin
      GetThemePartSize(StyleServices.Theme[teMenu], ACanvas.Handle, MENU_POPUPCHECK,
        CheckMarkStates[Enabled, false], nil, TS_TRUE, LCheckSize);
      GetThemeMargins(StyleServices.Theme[teMenu], ACanvas.Handle, MENU_POPUPCHECK,
        CheckMarkStates[Enabled, false], TMT_CONTENTMARGINS, nil, LCheckMargins);

      with ARect, lCheckMargins do
          LCheckRect := Rect(Left, Top,
            Left + LCheckSize.cx + cxRightWidth + cxRightWidth,
            Top + LCheckSize.cy + cyBottomHeight + cyBottomHeight);
  end;
  GlyphRect := LCheckRect;
  with MenuItem do begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then begin
                DrawThemeBackground(StyleServices.Theme[teMenu], ACanvas.Handle,
                  MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[Enabled], LCheckRect, nil);
              with GlyphRect do
                ImageList.Draw(ACanvas, Left + ((Right - Left - ImageList.Width) div 2),
                  Top + ((Bottom - Top - ImageList.Height) div 2), ImageIndex, Enabled);
               exit;
            end;

  exit;
  with ACAnvas do begin
      GetThemePartSize(StyleServices.Theme[teMenu], ACanvas.Handle, MENU_POPUPCHECK,
        CheckMarkStates[Enabled, false], nil, TS_TRUE, LCheckSize);
      GetThemeMargins(StyleServices.Theme[teMenu], ACanvas.Handle, MENU_POPUPCHECK,
        CheckMarkStates[Enabled, false], TMT_CONTENTMARGINS, nil, LCheckMargins);

      with ARect, lCheckMargins do
          LCheckRect := Rect(Left, Top,
            Left + LCheckSize.cx + cxRightWidth + cxRightWidth,
            Top + LCheckSize.cy + cyBottomHeight + cyBottomHeight);
  end;
  DrawThemeBackground(StyleServices.Theme[teMenu], ACanvas.Handle,
                  MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[Enabled], LCheckRect, nil);
  DrawThemeBackground(StyleServices.Theme[teMenu], ACanvas.Handle,
                  MENU_POPUPCHECK, CheckMarkStates[Enabled, false], LCheckRect, nil);
//  DrawThemeBackground(StyleServices.Theme[teMenu], ACanvas.Handle,
//                  MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[Enabled], ARect, nil);
//  DrawThemeBackground(StyleServices.Theme[teMenu], ACanvas.Handle,
//                  MENU_POPUPCHECK, CheckMarkStates[Enabled, false], ARect, nil);

//       DrawThemeBackground(StyleServices.Theme[teMenu], Handle,
//          MENU_POPUPITEM, MPI_HOT, ARect, nil);

  end;


end;

*)

end.
