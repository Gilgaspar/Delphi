        ��  ��                  �  8   ��
 I P F I R E M O N K E Y         0 	        object TLayout
  Align = alClient
  Height = 750.000000000000000000
  Width = 1162.000000000000000000
  object TLayout
    StyleName = 'MyValidateEditStyle'
    DesignVisible = False
    Height = 24.000000000000000000
    Position.X = 536.000000000000000000
    Position.Y = 363.000000000000000000
    Width = 91.000000000000000000
    object TRectangle
      StyleName = 'background'
      Align = alContents
      Fill.Color = xFFFEFEFE
      Locked = True
      Height = 24.000000000000000000
      HitTest = False
      Stroke.Color = claSilver
      XRadius = 1.000000000000000000
      YRadius = 1.000000000000000000
      Width = 91.000000000000000000
      object TColorAnimation
        Duration = 0.200000002980232200
        PropertyName = 'Stroke.Color'
        StartValue = claSilver
        StopValue = xFFA5D9FF
        Trigger = 'IsMouseOver = true'
      end
      object TColorAnimation
        Duration = 0.200000002980232200
        Inverse = True
        PropertyName = 'Stroke.Color'
        StartValue = claSilver
        StopValue = xFFA5D9FF
        Trigger = 'IsMouseOver = false'
      end
      object TColorAnimation
        Duration = 0.500000000000000000
        PropertyName = 'Fill.Color'
        StartValue = claWhite
        StartFromCurrent = True
        StopValue = xFFFF0A0A
        Trigger = 'IsInvalid=True'
      end
      object TColorAnimation
        Duration = 0.500000000000000000
        PropertyName = 'Fill.Color'
        StartValue = xFFFF0A0A
        StartFromCurrent = True
        StopValue = xFFFFFEFE
        Trigger = 'IsInvalid=False'
      end
    end
    object TLayout
      StyleName = 'content'
      Align = alContents
      Locked = True
      Height = 24.000000000000000000
      Padding.Left = 4.000000000000000000
      Padding.Top = 4.000000000000000000
      Padding.Right = 4.000000000000000000
      Padding.Bottom = 4.000000000000000000
      Width = 91.000000000000000000
    end
    object TBrushObject
      StyleName = 'foreground'
      Brush.Color = claBlack
    end
    object TBrushObject
      StyleName = 'selection'
      Brush.Color = x802A8ADF
    end
    object TGlowEffect
      Softness = 0.200000002980232200
      GlowColor = x82005ACC
      Opacity = 0.899999976158142100
      Trigger = 'IsFocused=true'
      Enabled = False
    end
  end
  object TLayout
    StyleName = 'ValidateEditEffect'
    DesignVisible = False
    Height = 24.000000000000000000
    Position.X = 536.000000000000000000
    Position.Y = 363.000000000000000000
    Width = 91.000000000000000000
    object TRectangle
      StyleName = 'background'
      Align = alContents
      Fill.Color = xFFFEFEFE
      Locked = True
      Height = 24.000000000000000000
      HitTest = False
      Stroke.Color = claSilver
      XRadius = 1.000000000000000000
      YRadius = 1.000000000000000000
      Width = 91.000000000000000000
      object TColorAnimation
        Duration = 0.200000002980232200
        PropertyName = 'Stroke.Color'
        StartValue = claSilver
        StopValue = xFFA5D9FF
        Trigger = 'IsMouseOver = true'
      end
      object TColorAnimation
        Duration = 0.200000002980232200
        Inverse = True
        PropertyName = 'Stroke.Color'
        StartValue = claSilver
        StopValue = xFFA5D9FF
        Trigger = 'IsMouseOver = false'
      end
      object TInnerGlowEffect
        Softness = 0.500000000000000000
        GlowColor = xFFFF3A00
        Opacity = 0.399999976158142100
        Trigger = 'IsInvalid=True'
      end
    end
    object TLayout
      StyleName = 'content'
      Align = alContents
      Locked = True
      Height = 24.000000000000000000
      Padding.Left = 4.000000000000000000
      Padding.Top = 4.000000000000000000
      Padding.Right = 4.000000000000000000
      Padding.Bottom = 4.000000000000000000
      Width = 91.000000000000000000
    end
    object TBrushObject
      StyleName = 'foreground'
      Brush.Color = claBlack
    end
    object TBrushObject
      StyleName = 'selection'
      Brush.Color = x802A8ADF
    end
    object TGlowEffect
      Softness = 0.200000002980232200
      GlowColor = x82005ACC
      Opacity = 0.899999976158142100
      Trigger = 'IsFocused=true'
      Enabled = False
    end
  end
  object TLayout
    StyleName = 'wwdatagridextrastyle'
    Align = alClient
    Height = 750.000000000000000000
    Width = 1162.000000000000000000
    object TLayout
      StyleName = 'indicatorbrowse'
      Locked = True
      Height = 50.000000000000000000
      Position.X = 556.000000000000000000
      Position.Y = 350.000000000000000000
      Width = 50.000000000000000000
      object TPath
        Data.Path = {
          0500000000000000000000000000000001000000000000000000803F01000000
          0000803F0000003F010000000000000000000000030000000000000000000000}
        Locked = True
        Height = 10.000000000000000000
        Stroke.Color = claNull
        Width = 10.000000000000000000
      end
      object TGlowEffect
        StyleName = 'GlowEffect'
        Softness = 0.400000005960464500
        GlowColor = claWhite
        Opacity = 0.899999976158142100
      end
    end
    object TLayout
      StyleName = 'indicatoredit'
      Locked = True
      Height = 50.000000000000000000
      Position.X = 556.000000000000000000
      Position.Y = 350.000000000000000000
      Width = 50.000000000000000000
      object TPath
        StyleName = 'Path'
        Data.Path = {
          0D0000000000000000000000000000000100000000000000CDCCCC3D01000000
          CDCCCC3DCDCCCC3D01000000CDCCCC3D6666663F01000000000000006666663F
          01000000000000000000803F010000009A99993E0000803F010000009A99993E
          6666663F01000000CDCC4C3E6666663F01000000CDCC4C3ECDCCCC3D01000000
          9A99993ECDCCCC3D010000009A99993E00000000030000000000000000000000}
        Locked = True
        Height = 13.000000000000000000
        Stroke.Color = claNull
        Width = 6.000000000000000000
      end
      object TGlowEffect
        StyleName = 'GlowEffect'
        Softness = 0.400000005960464500
        GlowColor = claWhite
        Opacity = 0.899999976158142100
      end
    end
    object TLayout
      StyleName = 'SortDescendingImage'
      Locked = True
      Height = 50.000000000000000000
      Visible = False
      Width = 50.000000000000000000
      object TPath
        StyleName = 'path'
        Data.Path = {
          0A0000000000000000000000000000000100000000000000CDCCCC3D01000000
          CDCCCC3DCDCCCC3D01000000CDCCCC3D3333F33F01000000CDCC4C3E3333F33F
          01000000CDCC4C3ECDCCCC3D010000009A99993ECDCCCC3D010000009A99993E
          00000000010000009A99193E000000BF030000000000000000000000}
        Locked = True
        Height = 15.000000000000000000
        HitTest = False
        Stroke.Color = claNull
        Width = 10.000000000000000000
      end
    end
    object TLayout
      StyleName = 'SortAscendingImage'
      Locked = True
      Height = 50.000000000000000000
      Visible = False
      Width = 50.000000000000000000
      object TPath
        StyleName = 'path'
        Data.Path = {
          0A0000000000000000000000000000000100000000000000CDCCCC3D01000000
          CDCCCC3DCDCCCC3D01000000CDCCCC3D3333F33F01000000CDCC4C3E3333F33F
          01000000CDCC4C3ECDCCCC3D010000009A99993ECDCCCC3D010000009A99993E
          00000000010000009A99193E000000BF030000000000000000000000}
        Locked = True
        Height = 15.000000000000000000
        RotationAngle = 180.000000000000000000
        Stroke.Color = claNull
        Width = 10.000000000000000000
      end
    end
  end
end
  