unit vcl.wwintl;
{
//
// Components : TwwInternational
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 11/10/97 - Add Bold, Italic, Underline for PopupMenuLabels
//
// 12/23/98 - Include Redo hint for richedit editor in Delphi 4
// 1/12/04 - The connected property of wwInternational is not set in some cases
}

{$i wwIfDef.pas}

{$ifdef wwDelphi3Up}
{$DEFINE NEWIPSETUP}
{$endif}
{$ifdef VER93}
{$DEFINE NEWIPSETUP}
{$endif}

{$C PRELOAD}

interface

uses
  Consts, SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, wwstr, db, wwframe,
  system.Types, system.UITypes,
{$ifdef NEWIPSETUP}
  Registry,
{$endif}
  Buttons;

const
  wwMonthCalendarPopupStartYearDefault = 2000;

type

  TwwPictureValidationError = procedure (Sender: TObject;
     Field: TField; var Msg: string; var DoDefault: boolean) of object;

  TwwCompatibilityIntl = class(TPersistent)
  private
     FRichEditEnableZoom: boolean;
  published
     property RichEditEnableZoom: boolean read FRichEditEnableZoom write FRichEditEnableZoom;
  end;

  TwwUserMessagesIntl = class(TPersistent)
  private
     FwwDBGridDiscardChanges: string;
     FPictureValidateError: string;
     FLocateNoMatches: string;
     FLocateNoMoreMatches: string;
     FMemoChangesWarning:string;
     FRichEditExitWarning: string;
     FRichEditClearWarning: string;
     FRichEditSpellCheckComplete: string;
     FRichEditMSWordNotFound: string;
{     FRichEditLoadWarning: string;}
     FFilterDlgNoCriteria: string;
     FRecordViewExitWarning: string;
  published
     property wwDBGridDiscardChanges: string read FwwDBGridDiscardChanges write FwwDBGridDiscardChanges;
     property PictureValidateError: string read FPictureValidateError write FPictureValidateError;
     property LocateNoMatches: string read FLocateNoMatches write FLocateNoMatches;
     property LocateNoMoreMatches: string read FLocateNoMoreMatches write FLocateNoMoreMatches;
     property MemoChangesWarning: string read FMemoChangesWarning write FMemoChangesWarning;
     property RichEditExitWarning: string read FRichEditExitWarning write FRichEditExitWarning;
     property RichEditClearWarning: string read FRichEditClearWarning write FRichEditClearWarning;
     property RichEditSpellCheckComplete: string read FRichEditSpellCheckComplete write FRichEditSpellCheckComplete;
     property RichEditMSWordNotFound: string read FRichEditMSWordNotFound write FRichEditMSWordNotFound;

     {     property RichEditLoadWarning: string read FRichEditLoadWarning write FRichEditLoadWarning;}
     property FilterDlgNoCriteria : string read FFilterDlgNoCriteria write FFilterDlgNoCriteria;
     property RecordViewExitWarning: string read FRecordViewExitWarning write FRecordViewExitWarning;
  end;

  TwwValidationFeedback = class(TPersistent)
  private
     FErrorForeColor: TColor;
     FErrorBackColor: TColor;
  published
     property ErrorForeColor: TColor read FErrorForeColor write FErrorForeColor default clNone;
     property ErrorBackColor: TColor read FErrorBackColor write FErrorBackColor default clNone;
  end;

  TwwFilterDialogIntl = class(TPersistent)
  private
      FBtnViewSummary : string;
      FBtnViewSummaryHint  : string;
      FViewSummaryNotText : string;
      FBtnNewSearch  : string;
      FBtnNewSearchHint  : string;
      FFieldOrderLabel  : string;
      FFieldOrderHint : string;
      FAlphabeticLabel : string;
      FLogicalLabel : string;
      FAllFieldsLabel : string;
      FSearchedFieldsLabel : string;
      FStartingRangeLabel : string;
      FEndingRangeLabel : string;
      FStartingRangeHint : string;
      FEndingRangeHint: string;
      FBtnClearMin : string;
      FBtnClearMax : string;
      FBtnClearFiltervalue : string;
      FBtnClearMinHint : string;
      FBtnClearMaxHint : string;
      FBtnClearFilterValueHint : string;
      FByValueLabel  : string;
      FByRangeLabel  : string;
      FFieldValueLabel  : string;
      FFieldValueHint  : string;
      FSearchTypeLabel  : string;
      FSearchTypeHint  : string;
      FMatchExactLabel  : string;
      FMatchStartLabel  : string;
      FMatchAnyLabel  : string;
      FCaseSensitiveLabel  : string;
      FCaseSensitiveHint  : string;
      FNonMatchingLabel   : string;
      FNonMatchingHint    : string;
      FSummaryFieldLabel: string;
      FSummarySearchLabel: string;
      FSummaryValueLabel : string;
      {$ifdef wwdelphi4up}
      FSummaryCaption: string;
      {$endif}
      FFieldsLabel: string;
      FValueRangeTabHint : string;
      FAllSearchedTabHint : string;

  published
      property BtnViewSummary : string read     FBtnViewSummary write FBtnViewSummary;
      property BtnViewSummaryHint  : string read FBtnViewSummaryHint write FBtnViewSummaryHint;
      property BtnNewSearch  : string read      FBtnNewSearch write FBtnNewSearch;
      property BtnNewSearchHint  : string read  FBtnNewSearchHint write FBtnNewSearchHint;
      property FieldOrderLabel  : string read   FFieldOrderLabel write FFieldOrderLabel;
      property FieldOrderHint : string read     FFieldOrderHint write FFieldOrderHint;
      property AlphabeticLabel : string read    FAlphabeticLabel write FAlphabeticLabel;
      property LogicalLabel : string read       FLogicalLabel write FLogicalLabel;
      property AllFieldsLabel : string read     FAllFieldsLabel write FAllFieldsLabel;
      property SearchedFieldsLabel : string read FSearchedFieldsLabel write FSearchedFieldsLabel;
      property StartingRangeLabel : string read FStartingRangeLabel write FStartingRangeLabel;
      property EndingRangeLabel : string read   FEndingRangeLabel write FEndingRangeLabel;
      property StartingRangeHint : string read FStartingRangeHint write FStartingRangeHint;
      property EndingRangeHint: string read     FEndingRangeHint write FEndingRangeHint;
      property BtnClearMin : string read        FBtnClearMin write FBtnClearMin;
      property BtnClearMax : string read        FBtnClearMax write FBtnClearMax;
      property BtnClearFilterValue : string read FBtnClearFilterValue write FBtnClearFilterValue;
      property BtnClearMinHint : string read    FBtnClearMinHint write FBtnClearMinHint;
      property BtnClearMaxHint : string read    FBtnClearMaxHint write FBtnClearMaxHint;
      property BtnClearFilterValueHint : string read FBtnClearFilterValueHint write FBtnClearFilterValueHint;
      property ByValueLabel  : string read      FByValueLabel write FByValueLabel;
      property ByRangeLabel  : string read      FByRangeLabel write FByRangeLabel;
      property FieldValueLabel  : string read   FFieldValueLabel write FFieldValueLabel;
      property FieldValueHint  : string read   FFieldValueHint write FFieldValueHint;
      property SearchTypeLabel  : string read   FSearchTypeLabel write FSearchTypeLabel;
      property SearchTypeHint  : string read   FSearchTypeHint write FSearchTypeHint;
      property MatchExactLabel  : string read   FMatchExactLabel write FMatchExactLabel;
      property MatchStartLabel  : string read   FMatchStartLabel write FMatchStartLabel;
      property MatchAnyLabel  : string read     FMatchAnyLabel write FMatchAnyLabel;
      property CaseSensitiveLabel  : string read FCaseSensitiveLabel write FCaseSensitiveLabel;
      property CaseSensitiveHint  : string read FCaseSensitiveHint write FCaseSensitiveHint;
      property NonMatchingLabel  : string read FNonMatchingLabel write FNonMatchingLabel;
      property NonMatchingHint  : string read FNonMatchingHint write FNonMatchingHint;
      property SummaryFieldLabel: string read FSummaryFieldLabel write FSummaryFieldLabel;
      property SummarySearchLabel: string read FSummarySearchLabel write FSummarySearchLabel;
      property SummaryValueLabel : string read FSummaryValueLabel write FSummaryValueLabel;
      {$ifdef wwdelphi4up}
      property SummaryCaption : string read FSummaryCaption write FSummaryCaption;
      {$endif}
      property FieldsLabel: string read FFieldsLabel write FFieldsLabel;
      property ValueRangeTabHint : string read FValueRangeTabHint write FValueRangeTabHint;
      property AllSearchedTabHint : string read FAllSearchedTabHint write FAllSearchedTabHint;
      property ViewSummaryNotText : string read FViewSummaryNotText write FViewSummaryNotText;

  end;

  TwwRichEditMenuLabels = class(TPersistent)
  private
     FFileCaption: string;
     FLoadCaption: string;
     FSaveAsCaption: string;
     FSaveExitCaption: string;
     FPrintCaption: string;
     FPrintPreviewCaption: string;     
     FPageSetupCaption: string;
     FExitCaption: string;

     FEditCaption: string;
     FUndoCaption: string;
     FCutCaption: string;
     FCopyCaption: string;
     FPasteCaption: string;
     FClearCaption: string;
     FSelectallCaption: string;
     FFindCaption: string;
     FFindNextCaption: string;
     FReplaceCaption: string;
     FInsertObjectCaption: string;
     FSpellCheckCaption: string;
     {$ifdef wwdelphi4up}
     FInsertCaption: string;
     FRulerCaption: string;
     FRedoCaption: string;
     {$endif}

     FViewCaption: string;
     FToolbarCaption: string;
     FFormatBarCaption: string;
     FViewStatusBarCaption: string;
     FOptionsCaption: string;

     FFormatCaption: string;
     FToolCaption: string;     
     FFontCaption: string;
     FBulletStyleCaption: string;
     FParagraphCaption: string;
     FTabsCaption: string;

     FHelpCaption: string;
  published
     property FileCaption : string read FFileCaption write FFileCaption;
     property LoadCaption : string read FLoadCaption write FLoadCaption;
     property SaveAsCaption : string read FSaveAsCaption write FSaveAsCaption;
     property SaveExitCaption : string read FSaveExitCaption write FSaveExitCaption;
     property PrintCaption : string read FPrintCaption write FPrintCaption;
     property PrintPreviewCaption : string read FPrintPreviewCaption write FPrintPreviewCaption;
     property PageSetupCaption : string read FPageSetupCaption write FPageSetupCaption;
     property ExitCaption : string read FExitCaption write FExitCaption;

     property EditCaption : string read FEditCaption write FEditCaption;
     property UndoCaption : string read FUndoCaption write FUndoCaption;
     property CutCaption : string read FCutCaption write FCutCaption;
     property CopyCaption : string read FCopyCaption write FCopyCaption;
     property PasteCaption : string read FPasteCaption write FPasteCaption;
     property ClearCaption : string read FClearCaption write FClearCaption;
     property SelectallCaption : string read FSelectallCaption write FSelectallCaption;
     property FindCaption : string read FFindCaption write FFindCaption;
     property FindNextCaption : string read FFindNextCaption write FFindNextCaption;
     property ReplaceCaption : string read FReplaceCaption write FReplaceCaption;
     property InsertObjectCaption : string read FInsertObjectCaption write FInsertObjectCaption;
     property ToolCaption : string read FToolCaption write FToolCaption;
     property SpellCheckCaption : string read FSpellCheckCaption write FSpellCheckCaption;
     {$ifdef wwdelphi4up}
     property InsertCaption : string read FInsertCaption write FInsertCaption;
     property RulerCaption: string read FRulerCaption write FRulerCaption;
     property RedoCaption: string read FRedoCaption write FRedoCaption;
     {$endif}
     property ViewCaption : string read FViewCaption write FViewCaption;
     property ToolbarCaption : string read FToolbarCaption write FToolbarCaption;
     property FormatBarCaption : string read FFormatBarCaption write FFormatBarCaption;
     property ViewStatusBarCaption : string read FViewStatusBarCaption write FViewStatusBarCaption;
     property OptionsCaption : string read FOptionsCaption write FOptionsCaption;

     property FormatCaption : string read FFormatCaption write FFormatCaption;
     property FontCaption : string read FFontCaption write FFontCaption;
     property BulletStyleCaption : string read FBulletStyleCaption write FBulletStyleCaption;
     property ParagraphCaption : string read FParagraphCaption write FParagraphCaption;
     property TabsCaption : string read FTabsCaption write FTabsCaption;

     property HelpCaption : string read FHelpCaption write FHelpCaption;
  end;

  TwwRichEditPopupMenuLabels = class(TPersistent)
  private
   {PopupMenu Captions for accelerators}
     FEditCaption: string;
     FViewCaption: string;
     FCutCaption: string;
     FCopyCaption: string;
     FPasteCaption: string;
     FFontCaption: string;
     FBulletStyleCaption: string;
     FBoldCaption: string;
     FItalicCaption: string;
     FUnderlineCaption: string;
     FParagraphCaption: string;
     FTabsCaption: string;
     FFindCaption: string;
     FReplaceCaption: string;
     FInsertObjectCaption: string;
     FSpellCheckCaption: string;
     FObjectPropertiesCaption: string;
  published
    {PopupMenu Captions for accelerators}
     property EditCaption : string read FEditCaption write FEditCaption;
     property ViewCaption : string read FViewCaption write FViewCaption;
     property CutCaption : string read FCutCaption write FCutCaption;
     property CopyCaption : string read FCopyCaption write FCopyCaption;
     property PasteCaption : string read FPasteCaption write FPasteCaption;
     property FontCaption : string read FFontCaption write FFontCaption;
     property BulletStyleCaption : string read FBulletStyleCaption write FBulletStyleCaption;
     property BoldCaption : string read FBoldCaption write FBoldCaption;
     property ItalicCaption : string read FItalicCaption write FItalicCaption;
     property UnderlineCaption : string read FUnderlineCaption write FUnderlineCaption;
     property ParagraphCaption : string read FParagraphCaption write FParagraphCaption;
     property TabsCaption : string read FTabsCaption write FTabsCaption;
     property FindCaption : string read FFindCaption write FFindCaption;
     property ReplaceCaption : string read FReplaceCaption write FReplaceCaption;
     property InsertObjectCaption : string read FInsertObjectCaption write FInsertObjectCaption;
     property ObjectPropertiesCaption : string read FObjectPropertiesCaption write FObjectPropertiesCaption;
     property SpellCheckCaption : string read FSpellCheckCaption write FSpellCheckCaption;
  end;

  TwwRichEditParagraphDlg = class(TPersistent)
  private
     FParagraphDlgCaption: string;
     FIndentationGroupBoxCaption: string;
     FLeftEditCaption: string;
     FRightEditCaption: string;
     FFirstLineEditCaption: string;
     FAlignmentCaption: string;
     FLeftEditHint: string;
     FRightEditHint: string;
     FFirstLineEditHint: string;
     FSpacingGroupCaption: string;
     FBeforeParagraphCaption: string;
     FAfterParagraphCaption: string;
     FWithinParagraphCaption: string;
     FWithinParagraphAtCaption: string;
     FAlignmentHint: string;
     FAlignLeft:string;
     FAlignRight:string;
     FAlignCenter:string;
     FAlignJustify:string;
     {$ifdef wwdelphi4up}
     FSpacingSingle,
     FSpacing1_5,
     FSpacingDouble,
     FSpacingAtLeast,
     FSpacingExactly,
     FSpacingMultiple: string;
     {$endif}
     FHelpContext: integer;
  published
     property ParagraphDlgCaption : string read FParagraphDlgCaption write FParagraphDlgCaption;
     property IndentationGroupBoxCaption : string read FIndentationGroupBoxCaption
                                                 write FIndentationGroupBoxCaption;
     property LeftEditHint : string read FLeftEditHint write FLeftEditHint;
     property RightEditHint : string read FRightEditHint write FRightEditHint;
     property FirstLineEditHint : string read FFirstLineEditHint write FFirstLineEditHint;
     property AlignmentHint : string read FAlignmentHint write FAlignmentHint;
     property LeftEditCaption : string read FLeftEditCaption write FLeftEditCaption;
     property RightEditCaption : string read FRightEditCaption write FRightEditCaption;
     property FirstLineEditCaption : string read FFirstLineEditCaption write FFirstLineEditCaption;
     property SpacingGroupCaption: string read FSpacingGroupCaption write FSpacingGroupCaption;
     property BeforeParagraphCaption: string read FBeforeParagraphCaption write FBeforeParagraphCaption;
     property AfterParagraphCaption: string read FAfterParagraphCaption write FAfterParagraphCaption;
     property WithinParagraphCaption: string read FWithinParagraphCaption write FWithinParagraphCaption;
     property WithinParagraphAtCaption: string read FWithinParagraphAtCaption write FWithinParagraphAtCaption;
     property AlignmentCaption : string read FAlignmentCaption write FAlignmentCaption;
     property AlignLeft : string read FAlignLeft write FAlignLeft;
     property AlignRight : string read FAlignRight write FAlignRight;
     property AlignCenter : string read FAlignCenter write FAlignCenter;
     property AlignJustify : string read FAlignJustify write FAlignJustify;
     {$ifdef wwdelphi4up}
     property SpacingSingle: string read FSpacingSingle write FSpacingSingle;
     property Spacing1_5: string read FSpacing1_5 write FSpacing1_5;
     property SpacingDouble : string read FSpacingDouble write FSpacingDouble;
     property SpacingAtLeast: string read FSpacingAtLeast write FSpacingAtLeast;
     property SpacingExactly : string read FSpacingExactly write FSpacingExactly;
     property SpacingMultiple: string read FSpacingMultiple write FSpacingMultiple;
     {$endif}
     property HelpContext: integer read FHelpContext write FHelpContext default 0;
  end;

  TwwRichEditTabDlg = class(TPersistent)
  private
     FTabDlgCaption: string;
     FTabGroupBoxCaption: string;
     FSetTabButtonCaption: string;
     FClearTabButtonCaption: string;
     FClearAllButtonCaption: string;

     FTabPositionEditHint: string;
     FListBoxHint: string;
     FSetButtonHint: string;
     FClearButtonHint: string;
     FClearAllButtonHint:string;
     FHelpContext: integer;
  published
     property TabDlgCaption : string read FTabDlgCaption write FTabDlgCaption;
     property HelpContext: integer read FHelpContext write FHelpContext default 0;
     property TabGroupBoxCaption : string read FTabGroupBoxCaption write FTabGroupBoxCaption;
     property SetTabButtonCaption : string read FSetTabButtonCaption write FSetTabButtonCaption;
     property ClearTabButtonCaption : string read FClearTabButtonCaption write FClearTabButtonCaption;
     property ClearAllButtonCaption : string read FClearAllButtonCaption write FClearAllButtonCaption;
     property TabPositionEditHint : string read FTabPositionEditHint write FTabPositionEditHint;
     property ListBoxHint : string read FListBoxHint write FListBoxHint;
     property SetButtonHint : string read FSetButtonHint write FSetButtonHint;
     property ClearButtonHint : string read FClearButtonHint write FClearButtonHint;
     property ClearAllButtonHint : string read FClearAllButtonHint write FClearAllButtonHint;
  end;


  TwwDBRichEditIntl = class(TPersistent)
  private
      FFontNameComboHint : string;
      FFontSizeComboHint : string;

      FNewButtonHint : string;
      FLoadButtonHint : string;
      FSaveAsButtonHint : string;
      FPrintButtonHint : string;
      FPrintPreviewButtonHint : string;      
      FFindButtonHint : string;
      FCutButtonHint : string;
      FCopyButtonHint : string;
      FUndoButtonHint : string;
      {$ifdef wwDelphi4Up}
      FRedoButtonHint : string;
      {$endif}
      FZoomComboHint: string;
      FPasteButtonHint : string;
      FBoldButtonHint :string;
      FColorButtonHint : string;
      FUnderlineButtonHint : string;
      FItalicButtonHint : string;
      FLeftButtonHint : string;
      FCenterButtonHint : string;
      FRightButtonHint : string;
      FJustifyButtonHint : string;
      FBulletButtonHint : string;
      FNumberingButtonHint : string;
      FHighlightButtonHint: string;
      FFormatCaptionHint: string;

      FSaveExitHint : string;
      FPageSetupHint: string;
      FExitHint: string;

      FClearHint: string;
      FSelectAllHint: string;
      FFindNextHint: string;
      FReplaceHint: string;
      FInsertObjectHint: string;
      FSpellCheckHint: string;

      FToolbarHint: string;
      FFormatBarHint: string;
      FViewStatusBarHint : string;
      FOptionsHint: string;

      FFontHint: string;
      FParagraphHint: string;
      FTabsHint: string;

      FMenuLabels: TwwRichEditMenuLabels;
      FPopupMenuLabels:TwwRichEditPopupMenuLabels;
      FParagraphDialog:TwwRichEditParagraphDlg;
      FTabDialog:TwwRichEditTabDlg;

      FCAPLockCaption: string;
      FNUMLockCaption: string;

  public
      destructor Destroy; override;
  published
      property FontNameComboHint : string read FFontNameComboHint write FFontNameComboHint;
      property FontSizeComboHint : string read FFontSizeComboHint write FFontSizeComboHint;

      property NewButtonHint : string read FNewButtonHint write FNewButtonHint;
      property LoadButtonHint : string read FLoadButtonHint write FLoadButtonHint ;
      property SaveAsButtonHint : string read FSaveAsButtonHint write FSaveAsButtonHint ;
      property PrintButtonHint : string read FPrintButtonHint write FPrintButtonHint;
      property PrintPreviewButtonHint : string read FPrintPreviewButtonHint write FPrintPreviewButtonHint;      
      property FindButtonHint : string read FFindButtonHint write FFindButtonHint;
      property CutButtonHint : string read FCutButtonHint write FCutButtonHint;
      property CopyButtonHint : string read FCopyButtonHint write FCopyButtonHint;
      property UndoButtonHint : string read FUndoButtonHint write FUndoButtonHint;
      {$ifdef wwDelphi4Up}
      property RedoButtonHint : string read FRedoButtonHint write FRedoButtonHint;
      {$endif}
      property ZoomComboHint: string read FZoomComboHint write FZoomComboHint;
      property PasteButtonHint : string read FPasteButtonHint write FPasteButtonHint;
      property BoldButtonHint : string read FBoldButtonHint write FBoldButtonHint;
      property ColorButtonHint : string read FColorButtonHint write FColorButtonHint;
      property UnderlineButtonHint : string read FUnderlineButtonHint write FUnderlineButtonHint;
      property ItalicButtonHint : string read FItalicButtonHint write FItalicButtonHint;
      property LeftButtonHint : string read FLeftButtonHint write FLeftButtonHint;
      property CenterButtonHint : string read FCenterButtonHint write FCenterButtonHint;
      property RightButtonHint : string read FRightButtonHint write FRightButtonHint;
      property JustifyButtonHint : string read FJustifyButtonHint write FJustifyButtonHint;
      property BulletButtonHint : string read FBulletButtonHint write FBulletButtonHint;
      property NumberingButtonHint : string read FNumberingButtonHint write FNumberingButtonHint;
      property HighlightButtonHint : string read FHighlightButtonHint write FHighlightButtonHint;
      property FormatCaptionHint: string read FFormatCaptionHint write FFormatCaptionHint;

      property SaveExitHint : string read FSaveExitHint write FSaveExitHint;
      property PageSetupHint : string read FPageSetupHint write FPageSetupHint;
      property ExitHint : string read FExitHint write FExitHint;

      property ClearHint : string read FClearHint write FClearHint ;
      property SelectAllHint : string read FSelectAllHint write FSelectAllHint;
      property FindNextHint : string read FFindNextHint write FFindNextHint;
      property ReplaceHint : string read FReplaceHint write FReplaceHint;
      property InsertObjectHint : string read FInsertObjectHint write FInsertObjectHint;
      property SpellCheckHint : string read FSpellCheckHint write FSpellCheckHint;

      property ToolbarHint : string read FToolbarHint write FToolbarHint;
      property FormatBarHint : string read FFormatBarHint write FFormatBarHint;
      property ViewStatusBarHint : string read FViewStatusBarHint write FViewStatusBarHint;
      property OptionsHint : string read FOptionsHint write FOptionsHint;

      property FontHint : string read FFontHint write FFontHint;
      property ParagraphHint : string read FParagraphHint write FParagraphHint;
      property TabsHint : string read FTabsHint write FTabsHint;

      property CAPLockCaption : string read FCAPLockCaption write FCAPLockCaption;
      property NUMLockCaption : string read FNUMLockCaption write FNUMLockCaption;

      property MenuLabels : TwwRichEditMenuLabels read FMenuLabels write FMenuLabels;
      property PopupMenuLabels : TwwRichEditPopupMenuLabels read FPopupMenuLabels write FPopupMenuLabels;
      property ParagraphDialog : TwwRichEditParagraphDlg read FParagraphDialog write FParagraphDialog;
      property TabDialog : TwwRichEditTabDlg read FTabDialog write FTabDialog;

  end;

  TwwSearchDialogIntl = class(TPersistent)
  private
    FSearchCharLabel: string;
    FSearchCharShortLabel: string;
    FSearchByLabel: string;
    FStatusRecLabel: string;
    FStatusOfLabel: string;
    FSearchCharHint: string;
    FSearchByHint: string;
  published
    property SearchCharLabel: string read FSearchCharLabel write FSearchCharLabel;
    property SearchCharShortLabel: string read FSearchCharShortLabel write FSearchCharShortLabel;
    property SearchByLabel: string read FSearchByLabel write FSearchByLabel;
    property StatusRecLabel: string read FStatusRecLabel write FStatusRecLabel;
    property StatusOfLabel : string read FStatusOfLabel write FStatusOfLabel;
    property SearchCharHint: string read FSearchCharHint write FSearchCharHint;
    property SearchByHint: string read FSearchByHint write FSearchByHint;
  end;

  TwwMonthCalendarIntl = class(TPersistent)
  private
    FPopupYearLabel: string;
    FEnterYearPrompt : string;
    FPopupYearStart: integer;
  published
    property PopupYearLabel: string read FPopupYearLabel write FPopupYearLabel;
    property EnterYearPrompt: string read FEnterYearPrompt write FEnterYearPrompt;
    property PopupYearStart: integer read FPopupYearStart write FPopupYearStart default wwMonthCalendarPopupStartYearDefault;
  end;

  TwwGridTitleMenuIntl = class(TPersistent)
  private
     FSortSmallesttoLargestCaption: string;
     FSortLargesttoSmallestCaption: string;
     FClearFilterCaption: string;
     FNumberFiltersCaption: string;
     FNumberFiltersCaptionEquals: string;
     FNumberFiltersCaptionDoesNotEqual: string;
     FNumberFiltersCaptionLessThan: string;
     FNumberFiltersCaptionGreaterThan: string;
     FNumberFiltersCaptionBetween: string;
     FDateFiltersCaption: string;
     FDateFiltersCaptionEquals: string;
     FDateFiltersCaptionBefore: string;
     FDateFiltersCaptionAfter: string;
     FDateFiltersCaptionBetween: string;
     FDateFiltersCaptionTomorrow: string;
     FDateFiltersCaptionToday: string;
     FDateFiltersCaptionYesterday: string;
     FDateFiltersCaptionNextWeek: string;
     FDateFiltersCaptionThisWeek: string;
     FDateFiltersCaptionLastWeek: string;
     FDateFiltersCaptionNextMonth: string;
     FDateFiltersCaptionThisMonth: string;
     FDateFiltersCaptionLastMonth: string;
     FDateFiltersCaptionNextQuarter: string;
     FDateFiltersCaptionThisQuarter: string;
     FDateFiltersCaptionLastQuarter: string;
     FDateFiltersCaptionNextYear: string;
     FDateFiltersCaptionThisYear: string;
     FDateFiltersCaptionLastYear: string;

     FTextFiltersCaption: string;
     FTextFiltersCaptionEquals: string;
     FTextFiltersCaptionDoesNotEqual: string;
     FTextFiltersCaptionStartsWith: string;
     FTextFiltersCaptionDoesNotStartWith: string;
     FTextFiltersCaptionContains: string;
     FTextFiltersCaptionDoesNotContain: string;
     FTextFiltersCaptionEndsWith: string;
     FTextFiltersCaptionDoesNotEndWith: string;
     FClearGroupByCaption: string;
     FGroupByCaption: string;
     FColumnsCaption: string;
     FColumnsCaptionRemove: string;
     FColumnsCaptionAddAfter: string;
     FColumnsCaptionAddBefore: string;
     FBetweenDialogLargestCaption: string;
     FBetweenDialogSmallestCaption: string;
     FBetweenDialogOldestCaption: string;
     FBetweenDialogNewestCaption: string;
     FBetweenDialogCaption: string;
     FSelectColumnsDialogCaption: string;

  published
     property SortSmallesttoLargestCaption: string read FSortSmallestToLargestCaption write FSortSmallestToLargestCaption;
     property SortLargesttoSmallestCaption: string read FSortLargesttoSmallestCaption write FSortLargesttoSmallestCaption;

     property ClearFilterCaption: string read FClearFilterCaption write FClearFilterCaption;
     property NumberFiltersCaption: string read FNumberFiltersCaption write FNumberFiltersCaption;
     property NumberFiltersCaptionEquals: string read FNumberFiltersCaptionEquals write FNumberFiltersCaptionEquals;
     property NumberFiltersCaptionDoesNotEqual: string read FNumberFiltersCaptionDoesNotEqual write FNumberFiltersCaptionDoesNotEqual;
     property NumberFiltersCaptionLessThan: string read FNumberFiltersCaptionLessThan write FNumberFiltersCaptionLessThan;
     property NumberFiltersCaptionGreaterThan: string read FNumberFiltersCaptionGreaterThan write FNumberFiltersCaptionGreaterThan;
     property NumberFiltersCaptionBetween: string read FNumberFiltersCaptionBetween write FNumberFiltersCaptionBetween;
     property DateFiltersCaption: string read FDateFiltersCaption write FDateFiltersCaption;
     property DateFiltersCaptionEquals: string read FDateFiltersCaptionEquals write FDateFiltersCaptionEquals;
     property DateFiltersCaptionBefore: string read FDateFiltersCaptionBefore write FDateFiltersCaptionBefore;
     property DateFiltersCaptionAfter: string read FDateFiltersCaptionAfter write FDateFiltersCaptionAfter;
     property DateFiltersCaptionBetween: string read FDateFiltersCaptionBetween write FDateFiltersCaptionBetween;
     property DateFiltersCaptionTomorrow: string read FDateFiltersCaptionTomorrow write FDateFiltersCaptionTomorrow;
     property DateFiltersCaptionToday: string read FDateFiltersCaptionToday write FDateFiltersCaptionToday;
     property DateFiltersCaptionYesterday: string read FDateFiltersCaptionYesterday write FDateFiltersCaptionYesterday;
     property DateFiltersCaptionNextWeek: string read FDateFiltersCaptionNextWeek write FDateFiltersCaptionNextWeek;
     property DateFiltersCaptionThisWeek: string read FDateFiltersCaptionThisWeek write FDateFiltersCaptionThisWeek;
     property DateFiltersCaptionLastWeek: string read FDateFiltersCaptionLastWeek write FDateFiltersCaptionLastWeek;
     property DateFiltersCaptionNextMonth: string read FDateFiltersCaptionNextMonth write FDateFiltersCaptionNextMonth;
     property DateFiltersCaptionThisMonth: string read FDateFiltersCaptionThisMonth write FDateFiltersCaptionThisMonth;
     property DateFiltersCaptionLastMonth: string read FDateFiltersCaptionLastMonth write FDateFiltersCaptionLastMonth;
     property DateFiltersCaptionNextQuarter: string read FDateFiltersCaptionNextQuarter write FDateFiltersCaptionNextQuarter;
     property DateFiltersCaptionThisQuarter: string read FDateFiltersCaptionThisQuarter write FDateFiltersCaptionThisQuarter;
     property DateFiltersCaptionLastQuarter: string read FDateFiltersCaptionLastQuarter write FDateFiltersCaptionLastQuarter;
     property DateFiltersCaptionNextYear: string read FDateFiltersCaptionNextYear write FDateFiltersCaptionNextYear;
     property DateFiltersCaptionThisYear: string read FDateFiltersCaptionThisYear write FDateFiltersCaptionThisYear;
     property DateFiltersCaptionLastYear: string read FDateFiltersCaptionLastYear write FDateFiltersCaptionLastYear;

     property TextFiltersCaption: string read FTextFiltersCaption write FTextFiltersCaption;
     property TextFiltersCaptionEquals: string read FTextFiltersCaptionEquals write FTextFiltersCaptionEquals;
     property TextFiltersCaptionDoesNotEqual: string read FTextFiltersCaptionDoesNotEqual write FTextFiltersCaptionDoesNotEqual;
     property TextFiltersCaptionStartsWith: string read FTextFiltersCaptionStartsWith write FTextFiltersCaptionStartsWith;
     property TextFiltersCaptionDoesNotStartWith: string read FTextFiltersCaptionDoesNotStartWith write FTextFiltersCaptionDoesNotStartWith;
     property TextFiltersCaptionContains: string read FTextFiltersCaptionContains write FTextFiltersCaptionContains;
     property TextFiltersCaptionDoesNotContain: string read FTextFiltersCaptionDoesNotContain write FTextFiltersCaptionDoesNotContain;
     property TextFiltersCaptionEndsWith: string read FTextFiltersCaptionEndsWith write FTextFiltersCaptionEndsWith;
     property TextFiltersCaptionDoesNotendWith: string read FTextFiltersCaptionDoesNotEndWith write FTextFiltersCaptionDoesNotEndWith;

     property ClearGroupByCaption: string read FClearGroupByCaption write FClearGroupByCaption;
     property GroupByCaption: string read FGroupByCaption write FGroupByCaption;
     property ColumnsCaption: string read FColumnsCaption write FColumnsCaption;
     property ColumnsCaptionRemove: string read FColumnsCaptionRemove write FColumnsCaptionRemove;
     property ColumnsCaptionAddAfter: string read FColumnsCaptionAddAfter write FColumnsCaptionAddAfter;
     property ColumnsCaptionAddBefore: string read FColumnsCaptionAddBefore write FColumnsCaptionAddBefore;

     property BetweenDialogLargestCaption: string read FBetweenDialogLargestCaption write FBetweenDialogLargestCaption;
     property BetweenDialogSmallestCaption: string read FBetweenDialogSmallestCaption write FBetweenDialogSmallestCaption;
     property BetweenDialogOldestCaption: string read FBetweenDialogOldestCaption write FBetweenDialogOldestCaption;
     property BetweenDialogNewestCaption: string read FBetweenDialogNewestCaption write FBetweenDialogNewestCaption;
     property BetweenDialogCaption: string read FBetweenDialogCaption write FBetweenDialogCaption;
     property SelectColumnsDialogCaption: string read FSelectColumnsDialogCaption write FSelectColumnsDialogCaption;

  end;


  TwwLocateDialogIntl = class(TPersistent)
  private
    FFieldValueLabel: string;
    FSearchTypeLabel: string;
    FCaseSensitiveLabel: string;
    FMatchExactLabel: string;
    FMatchStartLabel: string;
    FMatchAnyLabel: string;
    FFieldsLabel: string;
    FButtonFirst: string;
    FButtonNext: string;
    FButtonCancel: string;
    FButtonClose: string;
    FFieldValueHint: string;
    FCaseSensitiveHint: string;
    FMatchExactHint: string;
    FMatchStartHint: string;
    FMatchAnyHint: string;
    FButtonFirstHint: string;
    FButtonNextHint: string;
    FFieldNameHint: string;
  published
    property FieldValueLabel: string read FFieldValueLabel write FFieldValueLabel;
    property SearchTypeLabel: string read FSearchTypeLabel write FSearchTypeLabel;
    property CaseSensitiveLabel: string read FCaseSensitiveLabel write FCaseSensitiveLabel;
    property MatchExactLabel: string read FMatchExactLabel write FMatchExactlabel;
    property MatchStartLabel: string read FMatchStartLabel write FMatchStartLabel;
    property MatchAnyLabel: string read FMatchAnyLabel write FMatchAnyLabel;
    property FieldsLabel: string read FFieldsLabel write FFieldsLabel;
    property BtnFirst: string read FButtonFirst write FButtonFirst;
    property BtnNext: string read FButtonNext write FButtonNext;
    property BtnCancel: string read FButtonCancel write FButtonCancel;
    property BtnClose: string read FButtonClose write FButtonClose;

    property FieldValueHint: string read FFieldValueHint write FFieldValueHint;
    property CaseSensitiveHint: string read FCaseSensitiveHint write FCaseSensitiveHint;
    property MatchExactHint: string read FMatchExactHint write FMatchExactHint;
    property MatchStartHint: string read FMatchStartHint write FMatchStartHint;
    property MatchAnyHint: string read FMatchAnyHint write FMatchAnyHint;
    property BtnFirstHint: string read FButtonFirstHint write FButtonFirstHint;
    property BtnNextHint: string read FButtonNextHint write FButtonNextHint;

    property FieldNameHint: string read FFieldNameHint write FFieldNameHint;
  end;

  TwwDBNavigatorIntlHints = class(TPersistent)
  private
    FFirstHint: string;
    FPriorHint: string;
    FNextHint: string;
    FLastHint: string;
    FInsertHint: string;
    FDeleteHint: string;
    FEditHint: string;
    FPostHint: string;
    FCancelHint: string;
    FRefreshHint: string;
    FPriorPageHint: string;
    FNextPageHint: string;
    FSaveBookmarkHint: string;
    FRestoreBookmarkHint: string;
    FRecordViewDialogHint: string;
    FLocateDialogHint: string;
    FFilterDialogHint: string;
    FSearchDialogHint: string;
  public
    constructor Create;
  published
    property FirstHint: string read FFirstHint write FFirstHint;
    property PriorHint: string read FPriorHint write FPriorHint;
    property NextHint: string read FNextHint write FNextHint;
    property LastHint: string read FLastHint write FLastHint;
    property InsertHint: string read FInsertHint write FInsertHint;
    property DeleteHint: string read FDeleteHint write FDeleteHint;
    property EditHint: string read FEditHint write FEditHint;
    property PostHint: string read FPostHint write FPostHint;
    property CancelHint: string read FCancelHint write FCancelHint;
    property RefreshHint: string read FRefreshHint write FRefreshHint;
    property PriorPageHint: string read FPriorPageHint write FPriorPageHint;
    property NextPageHint: string read FNextPageHint write FNextPageHint;
    property SaveBookmarkHint: string read FSaveBookmarkHint write FSaveBookmarkHint;
    property RestoreBookmarkHint: string read FRestoreBookmarkHint write FRestoreBookmarkHint;
    property RecordViewDialogHint: string read FRecordViewDialogHint write FRecordViewDialogHint;
    property LocateDialogHint: string read FLocateDialogHint write FLocateDialogHint;
    property FilterDialogHint: string read FFilterDialogHint write FFilterDialogHint;
    property SearchDialogHint: string read FSearchDialogHint write FSearchDialogHint;
  end;

  TwwADOIntl = class(TPersistent)
  private
    FUseLocateWhenFindingValue: boolean;
  published
    property UseLocateWhenFindingValue: boolean read
             FUseLocateWhenFindingValue write FUseLocateWhenFindingValue default True;
  end;

  TwwDBNavigatorIntl = class(TPersistent)
  private
    FConfirmDeleteMessage: string;
    FHints: TwwDBNavigatorIntlHints;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ConfirmDeleteMessage: string read FConfirmDeleteMessage write FConfirmDeleteMessage;
    property Hints: TwwDBNavigatorIntlHints read FHints write FHints;
  end;

  TwwCheckBoxInGridStyle = (cbStyleAuto, cbStyleCheckmark, cbStyleXmark,
     cbStyleCheckmarkFlat);
  TwwGridPaintStyle = (gpsBitmapCanvas, gpsDynamicDeviceContext);

  TwwOnInitInfoPowerDialogEvent = procedure(InfoPowerComponent: TObject; Dialog : TCustomForm) of object;

  TwwIntl = class(TComponent)
  private
    FADO: TwwADOIntl;
    FNavigator: TwwDBNavigatorIntl;
    FSearchDialog: TwwSearchDialogIntl;
    FLocateDialog: TwwLocateDialogIntl;
    FMonthCalendar: TwwMonthCalendarIntl;
    FGridTitleMenu: TwwGridTitleMenuIntl;
    FOKCancelBitmapped: boolean;
    FDialogFontStyle: TFontStyles;
    FBtnOKCaption: string;
    FBtnCancelCaption: string;
    FConnected: Boolean;
    FUserMessages: TwwUserMessagesIntl;
    FCompatibility: TwwCompatibilityIntl;
    FFilterDialog: TwwFilterDialogIntl;
    FValidationFeedback: TwwValidationFeedback;
    FRichEdit: TwwDBRichEditIntl;
    FIPVersion: string;
    FIniFileName: string;
    FRegistrationNo: string;
    FFastSQLCancelRange: boolean;
    FCheckBoxInGridStyle: TwwCheckBoxInGridStyle;
    FGridPaintStyle : TwwGridPaintStyle;

    FUseLocateMethodForSearch: boolean;
//    FUseLocateMethodForFind: boolean;
    FDefaultEpochYear: Integer;
    FFilterMemoSize: integer;
    FOnValidationErrorUsingMask: TwwPictureValidationError;
    FOnInitInfoPowerDialog: TwwOnInitInfoPowerDialogEvent;

    Procedure SetConnected(val: boolean);
    Procedure SetIPVersion(val: string);
    {$ifdef NEWIPSETUP}
    Procedure SetRegistrationNo(val: string);
    {$endif}

    Procedure SetCheckboxInGridStyle(val: TwwCheckboxInGridStyle);
    Procedure SetGridPaintStyle(val: TwwGridPaintStyle);

  protected
    Procedure Loaded; override;
    Procedure Connect;

  public
    EssentialsWarningDisplayed: boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ValidationErrorUsingMask(Component: TComponent; Field: TField; Msg: string=''); virtual;
    //procedure ValidationErrorUsingMask(Component: TComponent; Field: TField); virtual;
    property FastSQLCancelRange: boolean read FFastSQLCancelRange write FFastSQLCancelRange;

    {$ifndef wwDelphi3Up}
    property UseLocateMethodForSearch: boolean read FUseLocateMethodForSearch write FUseLocateMethodForSearch default True;
    {$ENDIF}

  published
     property ADO: TwwADOIntl read FADO write FADO;
     property Navigator: TwwDBNavigatorIntl read FNavigator write FNavigator;
     property SearchDialog: TwwSearchDialogIntl read FSearchDialog write FSearchDialog;
     property LocateDialog: TwwLocateDialogIntl read FLocateDialog write FLocateDialog;
     property MonthCalendar: TwwMonthCalendarIntl read FMonthCalendar write FMonthCalendar;
     property GridTitleMenu: TwwGridTitleMenuIntl read FGridTitleMenu write FGridTitleMenu;
     property FilterDialog: TwwFilterDialogIntl read FFilterDialog write FFilterDialog;
     property ValidationFeedback: TwwValidationFeedback read FValidationFeedback write FValidationFeedback;
     property RichEdit: TwwDBRichEditIntl read FRichEdit write FRichEdit;
     property UserMessages: TwwUserMessagesIntl read FUserMessages write FUserMessages;
     property Compatibilty: TwwCompatibilityIntl read FCompatibility write FCompatibility;
     property OKCancelBitmapped: boolean read FOKCancelBitmapped write FOKCancelBitmapped;
     property BtnOKCaption: string read FBtnOKCaption write FBtnOKCaption;
     property BtnCancelCaption: string read FBtnCancelCaption write FBtnCancelCaption;
     property CheckBoxInGridStyle: TwwCheckBoxInGridStyle read FCheckBoxInGridStyle write SetCheckboxInGridStyle;
     property GridPaintStyle: TwwGridPaintStyle read FGridPaintStyle write SetGridPaintStyle default gpsDynamicDeviceContext;
     property VersionInfoPower: string read FIPVersion write SetIPVersion;
     property FilterMemoSize: integer read FFilterMemoSize write FFilterMemoSize;
     property IniFileName: string read FIniFileName write FIniFileName;
     {$ifdef wwDelphi3Up}
     property UseLocateMethodForSearch: boolean read FUseLocateMethodForSearch write FUseLocateMethodForSearch default True;
     {$ENDIF}
     property DialogFontStyle: TFontStyles read FDialogFontStyle write FDialogFontStyle;
     property DefaultEpochYear: integer read FDefaultEpochYear write FDefaultEpochYear default 1950;
     {$ifdef NEWIPSETUP}
     property RegistrationNo: string read FRegistrationNo write SetRegistrationNo;
     {$endif}
     property OnValidationErrorUsingMask: TwwPictureValidationError read FOnValidationErrorUsingMask write FOnValidationErrorUsingMask;
     property OnInitInfoPowerDialog: TwwOnInitInfoPowerDialogEvent read FOnInitInfoPowerDialog write FOnInitInfoPowerDialog;
     property Connected: boolean read FConnected write SetConnected;
  end;


{$ifndef GRIDESSENTIALS}

  TwwController = class(TComponent)
  private
    FFrame: TwwEditFrame;
    FButtonEffects: TwwButtonEffects;
    FControlList: TList;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyFrame;
    procedure AddControl(Control: TControl);
    procedure RemoveControl(Control: TControl);
  published
    property Frame: TwwEditFrame read FFrame write FFrame;
    property ButtonEffects: TwwButtonEffects read FButtonEffects write FButtonEffects;
    property ControlList: TList read FControlList;
  end;
{$ENDIF}

  Function wwCreateCommonButton(AOwner: TForm;
   ButtonKind: TBitBtnKind): TComponent;


procedure Register;


var wwInternational: TwwIntl;

implementation

uses
{$ifndef GRIDESSENTIALS}
     wwrcdpnl,
{$endif}
   StdCtrls, wwcommon;

constructor TwwIntl.Create(AOwner: TComponent);
{$ifdef NEWIPSETUP}
var ipReg: TRegIniFile;
{$endif}
begin
   inherited Create(AOwner);
   {$ifdef IPTRIAL}
   FIPVersion:= 'IPStudioWin 12.0.1 Trial ';
   {$else}
   FIPVersion:= 'IPStudio 12.0.1.1';
   {$endif}

   {$ifdef NEWIPSETUP}
   if csDesigning in ComponentState then begin
      ipreg := TRegIniFile.create('');
      FRegistrationNo:=
         ipreg.ReadString('\Software\Woll2Woll\InfoPowerXE7', 'Reg. No.', '');
      ipreg.free;
   end;
   {$endif}
   FFastSQLCancelRange:= True;
   FUseLocateMethodForSearch:= True;
   FDefaultEpochYear := 1950;
   FFilterMemoSize:= $10000; { 64k }

   FValidationFeedback:= TwwValidationFeedback.create;
   with FValidationFeedback do
   begin
      FErrorForeColor:= clNone;
      FErrorBackColor:= clNone;
   end;

   FFilterDialog:= TwwFilterDialogIntl.create;
   with FFilterDialog do
   begin
      FBtnViewSummary := 'View Su&mmary';
      FBtnViewSummaryHint  := 'View summary of current search criteria';
      FBtnNewSearch  := '&New Search';
      FBtnNewSearchHint  := 'Start a new search';
      FFieldOrderLabel  := 'Field Order';
      FFieldOrderHint := 'Sort field list alphabetically or in their natural logical order';
      FAlphabeticLabel := 'Alpha&betic';
      FLogicalLabel := '&Logical';
      FAllFieldsLabel := '&All';
      FSearchedFieldsLabel := '&Searched';
      FStartingRangeLabel := '&Starting Range';
      FEndingRangeLabel := 'En&ding Range';
      FBtnClearMin := '&Clear';
      FBtnClearMax := 'Cl&ear';
      FBtnClearFilterValue := '&Clear';
      FStartingRangeHint := 'Enter starting range for field';
      FEndingRangeHint := 'Enter ending range for field';
      FBtnClearMinHint := 'Clear starting range for field';
      FBtnClearMaxHint := 'Clear ending range for field';
      FBtnClearFilterValueHint:= 'Clear the current field''s search value';
      FByValueLabel  := 'By &Value';
      FByRangeLabel  := 'By &Range';
      FFieldValueLabel  := 'Field &Value';
      FFieldValueHint:= 'Enter field''s search value';
      FSearchTypeLabel  := 'Search Type';
      FSearchTypeHint:= 'Specify how the Field Value should be compared';
      FMatchExactLabel  := '&Exact Match';
      FMatchStartLabel  := '&Partial Match at Beginning';
      FMatchAnyLabel  := 'Partial Match Any&where';
      FCaseSensitiveLabel  := 'Case Sensi&tive';
      FCaseSensitiveHint  := 'Searching is case-sensitive';
      FNonMatchingLabel := 'N&on-matching records';
      FNonMatchingHint := 'Show records that do not match the field value criteria';
      FSummaryFieldLabel:= 'Field';
      FSummarySearchLabel:= 'Search Type';
      FSummaryValueLabel := 'Value';
      {$ifdef wwdelphi4up}
      FSummaryCaption:= ''; { Use default }
      {$endif}
      FFieldsLabel:= '&Fields';
      FValueRangeTabHint := 'Search fields by value or by range';
      FAllSearchedTabHint := 'Show all fields or only currently searched fields';
      FViewSummaryNotText := 'NOT';
   end;

   FRichEdit := TwwDBRichEditIntl.create;
   with FRichEdit do
   begin
      FFontNameComboHint := '字体 | 更改选中文本的字体';
      FFontSizeComboHint := '字体大小 | 更改选中文本的字体大小';

      FNewButtonHint := '新建 | 创建新的文档';
      FLoadButtonHint := '载入 | 载入文件';
      FSaveAsButtonHint := '另存为 | 保存文件';
      FPrintButtonHint := '打印 | 打印文档';
      FPrintPreviewButtonHint := '打印预览 | 预览打印文档';
      FFindButtonHint := '查找 | 查找指定文本';
      FCutButtonHint := '剪切 | 剪切选中的文本到剪贴板';
      FCopyButtonHint := '复制 | 复制选中的文本到剪贴板';
      FUndoButtonHint := '撤销 | 取消上一个操作';
      {$ifdef wwDelphi4Up}
      FRedoButtonHint := '重做 | 重新上一步操作';
      {$endif}
      FZoomComboHint := '放大 | 放大文本';
      FPasteButtonHint := '粘贴 | 插入剪贴板内容';
      FBoldButtonHint := '加粗 | 加粗选中的文本(切换)';
      FColorButtonHint := '颜色 | 将选中的文本改为指定颜色';
      FUnderlineButtonHint := '下划线 | 给选中的文本加上下划线(切换)';
      FItalicButtonHint := '斜体 | 选中文本改为斜体(切换)';
      FLeftButtonHint := '左对齐 | 段落左对齐 (切换)';
      FCenterButtonHint := '对中 | 段落对中(切换)';
      FRightButtonHint := '右对齐 | 段落右对齐(切换)';
      FJustifyButtonHint := '对齐 | 段落对齐 (切换)';
      FBulletButtonHint := '项目编号 | 在本行插入项目编号(切换)';
      FNumberingButtonHint:= '数字编号 | 给选中的文本插入数字编号';
      FHighlightButtonHint:= '高亮文本 | 加亮选中的文本';
      FFormatCaptionHint:= '格式化 | 格式化选中的文本';
      FSaveExitHint := '保存并退出 | 保存变更并退出编辑器';
      FPageSetupHint:='页面设置 | 改变页面布局设置';
      FExitHint:= '退出';

      FClearHint:= '清除选择';
      FSelectAllHint:= '选择全部文本';
      FFindNextHint:= '查找下一个匹配的文本';
      FReplaceHint:='用不同的文本替换指定文本';
      FInsertObjectHint:='插入新的嵌入对象';
      FSpellCheckHint:='拼写检查';

      FToolbarHint:= '显示或隐藏工具栏';
      FFormatBarHint:= '显示或隐藏格式栏';
      FViewStatusBarHint :='显示或隐藏状态栏';
      FOptionsHint:='设置选项';

      FFontHint:='为当前选择的文本选择字体';
      FParagraphHint:= '格式化当前或选定的段落(s)';
      FTabsHint:='设置制表符';

      FMenuLabels:= TwwRichEditMenuLabels.create;
      MenuLabels.FileCaption := '(&F)文件';
      MenuLabels.LoadCaption := '(&L)载入';
      MenuLabels.SaveAsCaption := '(&A)另存为';
      MenuLabels.SaveExitCaption := '(&S)保存并退出';
      MenuLabels.PrintCaption := '(&P)打印';
      MenuLabels.PrintPreviewCaption := '(&v)预览';
      MenuLabels.PageSetupCaption := '(&P)页面设置';
      MenuLabels.ExitCaption := '(&x)退出';

      MenuLabels.EditCaption := '(&E)编辑';
      MenuLabels.UndoCaption := '(&U)撤销';
      MenuLabels.CutCaption := '(&t)剪切';
      MenuLabels.CopyCaption := '(&)复制';
      MenuLabels.PasteCaption := '(&P)粘贴';
      MenuLabels.ClearCaption := '(&a)清除';
      MenuLabels.SelectallCaption := '(&l)全选';
      MenuLabels.FindCaption:= '(&F)查找';
      MenuLabels.FindNextCaption:='（&N)查找下一个';
      MenuLabels.ReplaceCaption:= '(&e)替换';
      MenuLabels.InsertObjectCaption:= '(&O)对象...';
      MenuLabels.SpellCheckCaption:= '(&S)检查拼写';
//      {$ifdef wwdelphi4up}
      MenuLabels.InsertCaption:= '(&I)插入';
      MenuLabels.RulerCaption:= '(&R)规则';
//      {$endif}

      MenuLabels.ViewCaption := '(&V)视图';
      MenuLabels.ToolbarCaption:= '(&T)工具栏';
      MenuLabels.FormatBarCaption:='(&F)格式栏';
      MenuLabels.ViewStatusBarCaption:='(&S)状态栏';
      MenuLabels.OptionsCaption:= '(&O)设置';

      MenuLabels.FormatCaption:= '(&o)格式化';
      MenuLabels.FontCaption:= '(&F)字体';
      MenuLabels.BulletStyleCaption:='(&B)项目编号类型';
      MenuLabels.ParagraphCaption:='(&P)段落';
      MenuLabels.TabsCaption := '(&T)制表符';
      MenuLabels.ToolCaption:= '(&T)工具';

      MenuLabels.HelpCaption := '帮助';

      FPopupMenuLabels:= TwwRichEditPopupMenuLabels.create;
      {PopupMenu Captions for accelerators}
      PopupMenuLabels.EditCaption:= '(&E)编辑';
      PopupMenuLabels.ViewCaption:= '(&V)视图';
      PopupMenuLabels.CutCaption:= '(&t)剪切';
      PopupMenuLabels.CopyCaption:= '(&C)复制';
      PopupMenuLabels.PasteCaption:= '(&P)粘贴';
      PopupMenuLabels.FontCaption:= '(&F)字体';
      PopupMenuLabels.BulletStyleCaption:= '(&B)项目编号类型';
      PopupMenuLabels.BoldCaption:='(&o)粗体';
      PopupMenuLabels.ItalicCaption:='(&I)斜体';
      PopupMenuLabels.UnderlineCaption:='(&U)下划线';
      PopupMenuLabels.ParagraphCaption:='(&a)段落';
      PopupMenuLabels.TabsCaption:= '(&T)制表符';
      PopupMenuLabels.FindCaption:='(&d)查找';
      PopupMenuLabels.ReplaceCaption:='(&R)替换';
      PopupMenuLabels.InsertObjectCaption:='(&O)插入对象...';
      PopupMenuLabels.ObjectPropertiesCaption:= '(&r)对象属性';
      PopupMenuLabels.SpellCheckCaption:='(&S)检查拼写';

      CAPLockCaption := 'CAP';
      NUMLockCaption := 'NUM';

      FParagraphDialog:= TwwRichEditParagraphDlg.create;

      ParagraphDialog.ParagraphDlgCaption:='段落';
      ParagraphDialog.IndentationGroupBoxCaption:='Indentation';

      ParagraphDialog.LeftEditCaption:='左:';
      ParagraphDialog.RightEditCaption:='右:';
      ParagraphDialog.FirstLineEditCaption:='第一行:';
      ParagraphDialog.AlignmentCaption:='对齐';

      ParagraphDialog.SpacingGroupCaption:='间距';
      ParagraphDialog.BeforeParagraphCaption:='(&B)前';
      ParagraphDialog.AfterParagraphCaption:='(&e)后';
      ParagraphDialog.WithinParagraphCaption:='(&n)行距';
      ParagraphDialog.WithinParagraphAtCaption:='(&A)位于';

      ParagraphDialog.FLeftEditHint:='左缩进';
      ParagraphDialog.FRightEditHint:='右缩进';
      ParagraphDialog.FFirstLineEditHint:='段落缩进第一行';
      ParagraphDialog.FAlignmentHint:='更改段落的对齐方式';

      ParagraphDialog.AlignLeft:= '左';
      ParagraphDialog.AlignRight:= '右';
      ParagraphDialog.AlignCenter:= '中';
      ParagraphDialog.AlignJustify:= '对齐';

      FTabDialog:= TwwRichEditTabDlg.create;

      TabDialog.TabDlgCaption:='制表符';
      TabDialog.FTabGroupBoxCaption:='(&T)制表符位置';
      TabDialog.FSetTabButtonCaption:='设置';
      TabDialog.FClearTabButtonCaption:='清除';
      TabDialog.FClearAllButtonCaption:='全部清除';

      TabDialog.FTabPositionEditHint:='制表符位置编辑框';
      TabDialog.FListBoxHint:='制表符位置列表';
      TabDialog.FSetButtonHint:='设置新的制表符位置';
      TabDialog.FClearButtonHint:='清除选中的制表符位置';
      TabDialog.FClearAllButtonHint:= '清除全部制表符';
   end;

   FNavigator := TwwDBNavigatorIntl.Create;

   FADO:= TwwADOIntl.create;
   FADO.UseLocateWhenFindingValue:=true;


   FMonthCalendar := TwwMonthCalendarIntl.create;
   with FMonthCalendar do
   begin
      PopupYearLabel := '编辑年';
      EnterYearPrompt := '输入有效的年';
      PopupYearStart:= wwMonthCalendarPopupStartYearDefault;
   end;

   FGridTitleMenu := TwwGridTitleMenuIntl.Create;
   with FGridTitleMenu do
   begin
{     SortSmallesttoLargestCaption:=
     SortLargesttoSmallestCaption:=
     ClearFilterCaption:=
     NumberFiltersCaption:=
     NumberFiltersCaptionEquals:=
     NumberFiltersCaptionDoesNotEqual:=
     NumberFiltersCaptionLessThan:=
     NumberFiltersCaptionGreaterThan:=
     NumberFiltersCaptionBetween:=
     DateFiltersCaption:=
     DateFiltersCaptionEquals:=
     DateFiltersCaptionBefore:=
     DateFiltersCaptionAfter:=
     DateFiltersCaptionBetween:=
     DateFiltersCaptionTomorrow:=
     DateFiltersCaptionToday:=
     DateFiltersCaptionYesterday:=
     DateFiltersCaptionNextWeek:=
     DateFiltersCaptionThisWeek:=
     DateFiltersCaptionLastWeek:=
     DateFiltersCaptionNextMonth:=
     DateFiltersCaptionThisMonth:=
     DateFiltersCaptionLastMonth:=
     DateFiltersCaptionNextQuarter:=
     DateFiltersCaptionThisQuarter:=
     DateFiltersCaptionLastQuarter:=
     DateFiltersCaptionNextYear:=
     DateFiltersCaptionThisYear:=
     DateFiltersCaptionLastYear:=
     TextFiltersCaption:=
     TextFiltersCaptionEquals:=
     TextFiltersCaptionDoesNotEqual:=
     TextFiltersCaptionStartsWith:=
     TextFiltersCaptionDoesNotStartWith:=
     TextFiltersCaptionContains:=
     TextFiltersCaptionDoesNotContain:=
     ClearGroupByCaption:=
     GroupByCaption:=
     ColumnsCaption:=
     ColumnsCaptionRemove:=
     ColumnsCaptionAddAfter:=
     ColumnsCaptionAddBefore:= }
   end;

   FSearchDialog:= TwwSearchDialogIntl.create;
   with FSearchDialog do
   begin
      SearchCharLabel:= '(&S)搜索字符';
      SearchCharShortLabel:= '(&S)搜索单个字符';
      SearchByLabel:= '(&B)搜索';
      StatusRecLabel:= '记录 #';
      StatusOfLabel := '的';
      SearchCharHint:= '输入字符的渐进式搜索';
      SearchByHint:= '增量搜索和排序顺序';
   end;
   FLocateDialog:= TwwLocateDialogIntl.create;
   with FLocateDialog do
   begin
      FieldValueLabel:= '(&V)字段值';
      SearchTypeLabel:= '&S搜索类型';
      CaseSensitiveLabel:= '&C区分大小写';
      MatchExactLabel:= '&E严格匹配';
      MatchStartLabel:= '&P开头部分匹配';
      MatchAnyLabel:= '&A任意位置匹配';
      FieldsLabel:= '&F字段';
      BtnFirst:= '&r第一条';
      BtnNext:= '&N下一条';
      BtnCancel:= '取消';
      BtnClose:= '关闭';
      FieldValueHint:= '输入搜索字段的值';
      CaseSensitiveHint:= '搜索区分大小写';
      MatchExactHint:= '严格匹配';
      MatchStartHint:= '字段前段部分匹配';
      MatchAnyHint:= '字段任意位置匹配';
      BtnFirstHint:= '查找第一条匹配的记录';
      BtnNextHint:= '从当前记录开始查找下一条匹配的记录';
      FieldNameHint:= '选择要匹配的字段';
   end;

   FCompatibility := TwwCompatibilityIntl.create;
   FCompatibility.RichEditEnableZoom:=true;

   FUserMessages:= TwwUserMessagesIntl.create;
   with FUserMessages do
   begin
      wwDBGridDiscardChanges:= 'Cancelar altera珲es ?';
      PictureValidateError:= 'Mascara invalida';
      LocateNoMatches:= 'Nada localizado';
      LocateNoMoreMatches:= 'Sem mais ocorrencias';
      MemoChangesWarning:= 'As altera珲es ser鉶 perdidas';
      RichEditExitWarning:= 'Descartar altera珲es ? ';
      RichEditClearWarning:= 'Limpar a digita玢o';
      RichEditSpellCheckComplete:= '拼写检查完毕。';
      RichEditMSWordNotFound:= 'Palavras n鉶 encontradas';
{      RichEditLoadWarning:= 'Replace current contents with Rich Text from a file?';}
      FilterDlgNoCriteria:= 'Sem ocorrencias';
      RecordViewExitWarning:= 'Sair ?';
   end;
   FOKCancelBitmapped:= True;
   FBtnOKCaption:= '(&O)确定';
   FBtnCancelCaption:= '取消';
   FIniFileName := '';
   FCheckBoxInGridStyle:= cbStyleAuto;
   FGridPaintStyle:= gpsDynamicDeviceContext;

   FDialogFontStyle := [];  // Default is non-bold for 32 bit programs

end;

{$ifndef GRIDESSENTIALS}

constructor TwwController.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FFrame:= TwwEditFrame.create(self);
   FButtonEffects:= TwwButtonEffects.create(self, nil);
   FControlList:= TList.create;

  if wwGridEssentials then
  begin
      DisplayProfessionalVersionOnlyMessage(self, 'TwwController is only supported in the professional version');
  end;

end;

destructor TwwController.Destroy;
begin
  FControlList.Free;
  FFrame.Free;
  FButtonEffects.Free;
  inherited Destroy;
end;

procedure TwwController.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;
    curControl: TWinControl;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and not (csDestroying in ComponentState) then // 10/5/00 - Fix design-time delete problem
  begin
     for i:= FControlList.count-1 downto 0 do begin
        curControl:= TWinControl(FControlList[i]);
        if curControl = AComponent then
        begin
           FControlList.Delete(i);
           exit;
        end
     end
  end
end;

procedure TwwController.AddControl(Control: TControl);
begin
   FControlList.Add(Control);
end;

procedure TwwController.RemoveControl(Control: TControl);
begin
   FControlList.Remove(Control);
end;

procedure TwwController.ApplyFrame;
var i: integer;
    curControl: TComponent;//WinControl;
    tempFrame: TwwEditFrame;
    tempButtonEffects: TwwButtonEffects;
begin
   for i:= 0 to FControlList.count-1 do begin
      curControl:= TWinControl(FControlList[i]);
      if curControl<>nil then
      begin
         tempFrame:= TwwEditFrame.Get(curControl);
         tempFrame.Assign(Frame);
         if CurControl is TwwRecordViewPanel then
            TwwRecordViewPanel(curControl).RecreateControls;

         tempButtonEffects:= TwwButtonEffects.Get(curControl);
         if TempButtonEffects<>nil then
            tempButtonEffects.Assign(ButtonEffects);
         if curControl is TWinControl then
            if TWinControl(curControl).HandleAllocated then
               SendMessage(TWinControl(curControl).Handle, cm_recreateWnd, 0, 0);
      end
   end
end;

{$ENDIF}
destructor TwwDBRichEditIntl.Destroy;
begin
  MenuLabels.Free;
  PopupMenuLabels.Free;
  ParagraphDialog.Free;
  TabDialog.Free;
  inherited destroy;
end;

destructor TwwIntl.Destroy;
begin
  FValidationFeedback.Free;
  FSearchDialog.Free;
  FLocateDialog.Free;
  FFilterDialog.Free;
  FMonthCalendar.Free;
  FGridTitleMenu.Free;
  FCompatibility.Free;
  FUserMessages.Free;
  FNavigator.Free;
  FRichEdit.Free;
  FADO.Free;
  inherited Destroy;
  if self=wwInternational then wwInternational:= nil;
end;

Procedure TwwIntl.Loaded;
begin
   inherited Loaded;
   if Connected then Connect;
end;

constructor TwwDBNavigatorIntl.Create;
begin
  inherited Create;
  FConfirmDeleteMessage := 'Confirma a exclu鉶 do registro ?';
  FHints := TwwDBNavigatorIntlHints.Create;
end;

destructor TwwDBNavigatorIntl.Destroy;
begin
  FHints.Free;
  inherited Destroy;
end;

constructor TwwDBNavigatorIntlHints.Create;
begin
  inherited Create;
  FFirstHint := 'Primeiro';
  FPriorHint := 'Anterior';
  FNextHint := 'Proximo';
  FLastHint := 'Ultimo';
  FInsertHint := 'Inserir';
  FDeleteHint := 'Apagar';
  FEditHint := 'Editar';
  FPostHint := 'Gravar';
  FCancelHint := 'Cancelar';
  FRefreshHint := 'Atualizar';
  FPriorPageHint := 'Pagina Anterior';
  FNextPageHint := 'Proxima pagina';
  FSaveBookmarkHint := 'Salvar posi玢o';
  FRestoreBookmarkHint := 'Voltar posi玢o';
  FRecordViewDialogHint := 'Visualizar';
  FFilterDialogHint := 'Filtro';
  FLocateDialogHint := 'Localizar';
  FSearchDialogHint := 'Pesquisar';
end;

{$ifdef NEWIPSETUP}
Procedure TwwIntl.SetRegistrationNo(val: string);
begin
end;
{$endif}

Procedure TwwIntl.SetIPVersion(val: string);
begin
end;

Procedure TwwIntl.SetConnected(val: boolean);
begin
    FConnected:= val;
    if not val then exit;
    Connect;
end;

Procedure TwwIntl.SetCheckboxInGridStyle(val: TwwCheckboxInGridStyle);
begin
   FCheckBoxInGridStyle:= val;
   if connected and (wwInternational<>self) then
      wwInternational.CheckboxInGridStyle:= val;
end;

Procedure TwwIntl.SetGridPaintStyle(val: TwwGridPaintStyle);
begin
   FGridPaintStyle:= val;
   if connected and (wwInternational<>self) then
      wwInternational.GridPaintStyle:= val;
end;

Procedure TwwIntl.Connect;
var wwFilterDialog: TwwFilterDialogIntl;
begin
    wwInternational.FConnected:= true; // 1/12/04 - The connected property of wwInternational is not set in some cases

    if self=wwInternational then exit;

    with validationFeedback do begin
      wwInternational.ValidationFeedback.ErrorBackColor:= FErrorBackColor;
      wwInternational.ValidationFeedback.ErrorForeColor:= FErrorForeColor;
    end;

    wwFilterDialog:= wwInternational.FilterDialog;

    with FilterDialog do begin
      wwFilterDialog.BtnViewSummary := FBtnViewSummary;
      wwFilterDialog.BtnViewSummaryHint  := FBtnViewSummaryHint;
      wwFilterDialog.BtnNewSearch  := FBtnNewSearch;
      wwFilterDialog.BtnNewSearchHint  := FBtnNewSearchHint;
      wwFilterDialog.FieldOrderLabel  := FFieldOrderLabel;
      wwFilterDialog.FieldOrderHint := FFieldOrderHint;
      wwFilterDialog.AlphabeticLabel := FAlphabeticLabel;
      wwFilterDialog.LogicalLabel := FLogicalLabel;
      wwFilterDialog.AllFieldsLabel := FAllFieldsLabel;
      wwFilterDialog.SearchedFieldsLabel := FSearchedFieldsLabel;
      wwFilterDialog.StartingRangeLabel :=  FStartingRangeLabel;
      wwFilterDialog.EndingRangeLabel := FEndingRangeLabel;
      wwFilterDialog.StartingRangeHint := FStartingRangeHint;
      wwFilterDialog.EndingRangeHint := FEndingRangeHint;
      wwFilterDialog.BtnClearMin := FBtnClearMin;
      wwFilterDialog.BtnClearMax := FBtnClearMax;
      wwFilterDialog.BtnClearFilterValue := FBtnClearFilterValue;
      wwFilterDialog.BtnClearMinHint := FBtnClearMinHint;
      wwFilterDialog.BtnClearMaxHint := FBtnClearMaxHint;
      wwFilterDialog.BtnClearFilterValueHint := FBtnClearFilterValueHint;
      wwFilterDialog.ByValueLabel  := FByValueLabel;
      wwFilterDialog.ByRangeLabel  :=  FByRangeLabel;
      wwFilterDialog.FieldValueLabel  := FFieldValueLabel;
      wwFilterDialog.FieldValueHint  := FFieldValueHint;
      wwFilterDialog.SearchTypeLabel  :=  FSearchTypeLabel;
      wwFilterDialog.SearchTypeHint :=  FSearchTypeHint;
      wwFilterDialog.MatchExactLabel  := FMatchExactLabel;
      wwFilterDialog.MatchStartLabel  := FMatchStartLabel;
      wwFilterDialog.MatchAnyLabel  := FMatchAnyLabel;
      wwFilterDialog.CaseSensitiveLabel := FCaseSensitiveLabel;
      wwFilterDialog.CaseSensitiveHint := FCaseSensitiveHint;
      wwFilterDialog.NonMatchingLabel := NonMatchingLabel;
      wwFilterDialog.NonMatchingHint := NonMatchingHint;
      wwFilterDialog.SummaryFieldLabel  := FSummaryFieldLabel;
      wwFilterDialog.SummarySearchLabel := FSummarySearchLabel;
      wwFilterDialog.SummaryValueLabel := FSummaryValueLabel;
      {$ifdef wwdelphi4up}
      wwFilterDialog.SummaryCaption:= FSummaryCaption;
      {$endif}
      wwFilterDialog.FieldsLabel:= FFieldsLabel;
      wwFilterDialog.ValueRangeTabHint:= FValueRangeTabHint;
      wwFilterDialog.AllSearchedTabHint:= FAllSearchedTabHint;
      wwFilterDialog.ViewSummaryNotText:= FViewSummaryNotText;
    end;

    with RichEdit do begin
       wwInternational.RichEdit.FontNameComboHint := FFontNameComboHint;
       wwInternational.RichEdit.FontSizeComboHint := FFontSizeComboHint;
       wwInternational.RichEdit.NewButtonHint := FNewButtonHint;
       wwInternational.RichEdit.LoadButtonHint:=FLoadButtonHint;
       wwInternational.RichEdit.SaveAsButtonHint:=FSaveAsButtonHint;
       wwInternational.RichEdit.PrintButtonHint:=FPrintButtonHint;
       wwInternational.RichEdit.PrintPreviewButtonHint:=FPrintPreviewButtonHint;       
       wwInternational.RichEdit.FindButtonHint:=FFindButtonHint;
       wwInternational.RichEdit.CutButtonHint:=FCutButtonHint;
       wwInternational.RichEdit.CopyButtonHint:=FCopyButtonHint;
       wwInternational.RichEdit.UndoButtonHint:=FUndoButtonHint;
       {$ifdef wwDelphi4Up}
       wwInternational.RichEdit.RedoButtonHint:=FRedoButtonHint;
       {$endif}
       wwInternational.RichEdit.ZoomComboHint:=FZoomComboHint;
       wwInternational.RichEdit.PasteButtonHint:=FPasteButtonHint;
       wwInternational.RichEdit.BoldButtonHint:=FBoldButtonHint;
       wwInternational.RichEdit.ColorButtonHint:=FColorButtonHint;
       wwInternational.RichEdit.UnderlineButtonHint:=FUnderlineButtonHint;
       wwInternational.RichEdit.ItalicButtonHint:=FItalicButtonHint;
       wwInternational.RichEdit.LeftButtonHint:=FLeftButtonHint;
       wwInternational.RichEdit.CenterButtonHint:=FCenterButtonHint;
       wwInternational.RichEdit.RightButtonHint:=FRightButtonHint;
       wwInternational.RichEdit.JustifyButtonHint:=FJustifyButtonHint;
       wwInternational.RichEdit.BulletButtonHint:=FBulletButtonHint;
       wwInternational.RichEdit.NumberingButtonHint:=FNumberingButtonHint;
       wwInternational.RichEdit.HighlightButtonHint:=FHighlightButtonHint;
       wwInternational.RichEdit.FormatCaptionHint:=FFormatCaptionHint;

       wwInternational.RichEdit.SaveExitHint:=FSaveExitHint;
       wwInternational.RichEdit.PageSetupHint:=FPageSetupHint;
       wwInternational.RichEdit.ExitHint:=FExitHint;
       wwInternational.RichEdit.ClearHint:=FClearHint;
       wwInternational.RichEdit.SelectAllHint:=FSelectAllHint;
       wwInternational.RichEdit.FindNextHint:=FFindNextHint;
       wwInternational.RichEdit.ReplaceHint:=FReplaceHint;
       wwInternational.RichEdit.InsertObjectHint:=FInsertObjectHint;
       wwInternational.RichEdit.SpellCheckHint:=FSpellCheckHint;
       wwInternational.RichEdit.ToolbarHint:=FToolbarHint;
       wwInternational.RichEdit.FormatBarHint:=FFormatBarHint;
       wwInternational.RichEdit.ViewStatusBarHint:=FViewStatusBarHint;
       wwInternational.RichEdit.OptionsHint:=FOptionsHint;
       wwInternational.RichEdit.FFontHint:=FFontHint;
       wwInternational.RichEdit.ParagraphHint:=FParagraphHint;
       wwInternational.RichEdit.TabsHint:=FTabsHint;

       wwInternational.RichEdit.CAPLockCaption:=FCAPLockCaption;
       wwInternational.RichEdit.NUMLockCaption:=FNUMLockCaption;

       wwInternational.RichEdit.MenuLabels.FileCaption:=FMenuLabels.FileCaption;
       wwInternational.RichEdit.MenuLabels.LoadCaption:=FMenuLabels.LoadCaption;
       wwInternational.RichEdit.MenuLabels.SaveAsCaption:=FMenuLabels.SaveAsCaption;
       wwInternational.RichEdit.MenuLabels.SaveExitCaption:=FMenuLabels.SaveExitCaption;
       wwInternational.RichEdit.MenuLabels.PrintCaption:=FMenuLabels.PrintCaption;
       wwInternational.RichEdit.MenuLabels.PrintPreviewCaption:=FMenuLabels.PrintPreviewCaption;
       wwInternational.RichEdit.MenuLabels.PageSetupCaption:=FMenuLabels.PageSetupCaption;
       wwInternational.RichEdit.MenuLabels.ExitCaption:=FMenuLabels.ExitCaption;
       wwInternational.RichEdit.MenuLabels.EditCaption:=FMenuLabels.EditCaption;
       wwInternational.RichEdit.MenuLabels.UndoCaption:=FMenuLabels.UndoCaption;
       wwInternational.RichEdit.MenuLabels.CutCaption:=FMenuLabels.CutCaption;
       wwInternational.RichEdit.MenuLabels.CopyCaption:=FMenuLabels.CopyCaption;
       wwInternational.RichEdit.MenuLabels.PasteCaption:=FMenuLabels.PasteCaption;
       wwInternational.RichEdit.MenuLabels.ClearCaption:=FMenuLabels.ClearCaption;
       wwInternational.RichEdit.MenuLabels.SelectallCaption:=FMenuLabels.SelectallCaption;
       wwInternational.RichEdit.MenuLabels.FindCaption:=FMenuLabels.FindCaption;
       wwInternational.RichEdit.MenuLabels.FindNextCaption:=FMenuLabels.FindNextCaption;
       wwInternational.RichEdit.MenuLabels.ReplaceCaption:=FMenuLabels.ReplaceCaption;
       wwInternational.RichEdit.MenuLabels.InsertObjectCaption:=FMenuLabels.InsertObjectCaption;
       wwInternational.RichEdit.MenuLabels.ToolCaption:=FMenuLabels.ToolCaption;
       wwInternational.RichEdit.MenuLabels.SpellCheckCaption:=FMenuLabels.SpellCheckCaption;
       {$ifdef wwdelphi4up}
       wwInternational.RichEdit.MenuLabels.InsertCaption:=FMenuLabels.InsertCaption;
       wwInternational.RichEdit.MenuLabels.RulerCaption:=FMenuLabels.RulerCaption;
       wwInternational.RichEdit.MenuLabels.RedoCaption:=FMenuLabels.RedoCaption;
       {$endif}
       wwInternational.RichEdit.MenuLabels.ViewCaption:=FMenuLabels.ViewCaption;
       wwInternational.RichEdit.MenuLabels.ToolbarCaption:=FMenuLabels.ToolbarCaption;
       wwInternational.RichEdit.MenuLabels.FormatBarCaption:=FMenuLabels.FormatBarCaption;
       wwInternational.RichEdit.MenuLabels.ViewStatusBarCaption:=FMenuLabels.ViewStatusBarCaption;
       wwInternational.RichEdit.MenuLabels.OptionsCaption:=FMenuLabels.OptionsCaption;
       wwInternational.RichEdit.MenuLabels.FormatCaption:=FMenuLabels.FormatCaption;

       wwInternational.RichEdit.MenuLabels.FontCaption:=FMenuLabels.FontCaption;
       wwInternational.RichEdit.MenuLabels.BulletStyleCaption:=FMenuLabels.BulletStyleCaption;
       wwInternational.RichEdit.MenuLabels.ParagraphCaption:=FMenuLabels.ParagraphCaption;
       wwInternational.RichEdit.MenuLabels.TabsCaption:=FMenuLabels.TabsCaption;
       wwInternational.RichEdit.MenuLabels.HelpCaption:=FMenuLabels.HelpCaption;

       wwInternational.RichEdit.PopupMenuLabels.EditCaption:=FPopupMenuLabels.EditCaption;
       wwInternational.RichEdit.PopupMenuLabels.ViewCaption:=FPopupMenuLabels.ViewCaption;
       wwInternational.RichEdit.PopupMenuLabels.CutCaption:=FPopupMenuLabels.CutCaption;
       wwInternational.RichEdit.PopupMenuLabels.CopyCaption:=FPopupMenuLabels.CopyCaption;
       wwInternational.RichEdit.PopupMenuLabels.PasteCaption:=FPopupMenuLabels.PasteCaption;
       wwInternational.RichEdit.PopupMenuLabels.FontCaption:=FPopupMenuLabels.FontCaption;
       { 11/10/97 - Add Bold, Italic, Underline }
       wwInternational.RichEdit.PopupMenuLabels.BoldCaption:=FPopupMenuLabels.BoldCaption;
       wwInternational.RichEdit.PopupMenuLabels.ItalicCaption:=FPopupMenuLabels.ItalicCaption;
       wwInternational.RichEdit.PopupMenuLabels.UnderlineCaption:=FPopupMenuLabels.UnderlineCaption;
       wwInternational.RichEdit.PopupMenuLabels.BulletStyleCaption:=FPopupMenuLabels.BulletStyleCaption;
       wwInternational.RichEdit.PopupMenuLabels.ParagraphCaption:=FPopupMenuLabels.ParagraphCaption;
       wwInternational.RichEdit.PopupMenuLabels.TabsCaption:=FPopupMenuLabels.TabsCaption;
       wwInternational.RichEdit.PopupMenuLabels.FindCaption:=FPopupMenuLabels.FindCaption;
       wwInternational.RichEdit.PopupMenuLabels.ReplaceCaption:=FPopupMenuLabels.ReplaceCaption;
       wwInternational.RichEdit.PopupMenuLabels.InsertObjectCaption:=FPopupMenuLabels.InsertObjectCaption;
       wwInternational.RichEdit.PopupMenuLabels.ObjectPropertiesCaption:=FPopupMenuLabels.ObjectPropertiesCaption;
       wwInternational.RichEdit.PopupMenuLabels.SpellCheckCaption:=FPopupMenuLabels.SpellCheckCaption;

       wwInternational.RichEdit.ParagraphDialog.ParagraphDlgCaption:=FParagraphDialog.ParagraphDlgCaption;
       wwInternational.RichEdit.ParagraphDialog.IndentationGroupBoxCaption:=FParagraphDialog.IndentationGroupBoxCaption;
       wwInternational.RichEdit.ParagraphDialog.LeftEditCaption:=FParagraphDialog.LeftEditCaption;
       wwInternational.RichEdit.ParagraphDialog.RightEditCaption:=FParagraphDialog.RightEditCaption;
       wwInternational.RichEdit.ParagraphDialog.FirstLineEditCaption:=FParagraphDialog.FirstLineEditCaption;
       wwInternational.RichEdit.ParagraphDialog.AlignmentCaption:=FParagraphDialog.AlignmentCaption;
       wwInternational.RichEdit.ParagraphDialog.LeftEditHint:=FParagraphDialog.FLeftEditHint;
       wwInternational.RichEdit.ParagraphDialog.RightEditHint:=FParagraphDialog.FRightEditHint;
       wwInternational.RichEdit.ParagraphDialog.FirstLineEditHint:=FParagraphDialog.FFirstLineEditHint;
       wwInternational.RichEdit.ParagraphDialog.AlignmentHint:=FParagraphDialog.FAlignmentHint;
       wwInternational.RichEdit.ParagraphDialog.AlignLeft:= FParagraphDialog.AlignLeft;
       wwInternational.RichEdit.ParagraphDialog.AlignRight:= FParagraphDialog.AlignRight;
       wwInternational.RichEdit.ParagraphDialog.AlignJustify:= FParagraphDialog.AlignJustify;
       wwInternational.RichEdit.ParagraphDialog.AlignCenter:= FParagraphDialog.AlignCenter;

       wwInternational.RichEdit.ParagraphDialog.SpacingGroupCaption:= FParagraphDialog.SpacingGroupCaption;
       wwInternational.RichEdit.ParagraphDialog.BeforeParagraphCaption:= FParagraphDialog.BeforeParagraphCaption;
       wwInternational.RichEdit.ParagraphDialog.AfterParagraphCaption:= FParagraphDialog.AfterParagraphCaption;
       wwInternational.RichEdit.ParagraphDialog.WithinParagraphCaption:= FParagraphDialog.WithinParagraphCaption;
       wwInternational.RichEdit.ParagraphDialog.WithinParagraphAtCaption:= FParagraphDialog.WithinParagraphAtCaption;

       {$ifdef wwdelphi4up}
       wwInternational.RichEdit.ParagraphDialog.SpacingSingle:= FParagraphDialog.SpacingSingle;
       wwInternational.RichEdit.ParagraphDialog.Spacing1_5:= FParagraphDialog.Spacing1_5;
       wwInternational.RichEdit.ParagraphDialog.SpacingDouble:= FParagraphDialog.SpacingDouble;
       wwInternational.RichEdit.ParagraphDialog.SpacingAtLeast:= FParagraphDialog.SpacingAtLeast;
       wwInternational.RichEdit.ParagraphDialog.SpacingExactly:= FParagraphDialog.SpacingExactly;
       wwInternational.RichEdit.ParagraphDialog.SpacingMultiple:= FParagraphDialog.SpacingMultiple;
       wwInternational.RichEdit.ParagraphDialog.HelpContext:= FParagraphDialog.HelpContext;
       {$endif}

       wwInternational.RichEdit.TabDialog.TabDlgCaption:=FTabDialog.TabDlgCaption;
       wwInternational.RichEdit.TabDialog.TabGroupBoxCaption:=FTabDialog.FTabGroupBoxCaption;
       wwInternational.RichEdit.TabDialog.SetTabButtonCaption:=FTabDialog.FSetTabButtonCaption;
       wwInternational.RichEdit.TabDialog.ClearTabButtonCaption:=FTabDialog.FClearTabButtonCaption;
       wwInternational.RichEdit.TabDialog.ClearAllButtonCaption:=FTabDialog.FClearAllButtonCaption;
       wwInternational.RichEdit.TabDialog.TabPositionEditHint:=FTabDialog.FTabPositionEditHint;
       wwInternational.RichEdit.TabDialog.ListBoxHint:=FTabDialog.FListBoxHint;
       wwInternational.RichEdit.TabDialog.SetButtonHint:=FTabDialog.FSetButtonHint;
       wwInternational.RichEdit.TabDialog.ClearButtonHint:=FTabDialog.FClearButtonHint;
       wwInternational.RichEdit.TabDialog.ClearAllButtonHint:= FTabDialog.FClearAllButtonHint;
       wwInternational.RichEdit.TabDialog.HelpContext:= FTabDialog.HelpContext;
    end;

    with SearchDialog do begin
       wwInternational.SearchDialog.SearchCharLabel:= FSearchCharLabel;
       wwInternational.SearchDialog.SearchCharShortLabel:= FSearchCharShortLabel;
       wwInternational.SearchDialog.SearchByLabel:= FSearchByLabel;
       wwInternational.SearchDialog.StatusRecLabel:= FStatusRecLabel;
       wwInternational.SearchDialog.StatusOfLabel:= FStatusOfLabel;
       wwInternational.SearchDialog.SearchCharHint:= FSearchCharHint;
       wwInternational.SearchDialog.SearchByHint:= FSearchByHint;
    end;

    with MonthCalendar do begin
       wwInternational.MonthCalendar.PopupYearLabel := FPopupYearLabel;
       wwInternational.MonthCalendar.EnterYearPrompt:= FEnterYearPrompt;
       wwInternational.MonthCalendar.PopupYearStart:= FPopupYearStart; // 3/12/09
    end;

    with GridTitleMenu do begin
      wwInternational.GridTitleMenu.SortSmallesttoLargestCaption:= FSortSmallesttoLargestCaption;
      wwInternational.GridTitleMenu.SortLargesttoSmallestCaption:= FSortLargesttoSmallestCaption;
      wwInternational.GridTitleMenu.ClearFilterCaption:= FClearFilterCaption;
      wwInternational.GridTitleMenu.NumberFiltersCaption:= FNumberFiltersCaption;
      wwInternational.GridTitleMenu.NumberFiltersCaptionEquals:= FNumberFiltersCaptionEquals;
      wwInternational.GridTitleMenu.NumberFiltersCaptionDoesNotEqual:= FNumberFiltersCaptionDoesNotEqual;
      wwInternational.GridTitleMenu.NumberFiltersCaptionLessThan:= FNumberFiltersCaptionLessThan;
      wwInternational.GridTitleMenu.NumberFiltersCaptionGreaterThan:= FNumberFiltersCaptionGreaterThan;
      wwInternational.GridTitleMenu.NumberFiltersCaptionBetween:= FNumberFiltersCaptionBetween;
      wwInternational.GridTitleMenu.DateFiltersCaption:= FDateFiltersCaption;
      wwInternational.GridTitleMenu.DateFiltersCaptionEquals:= FDateFiltersCaptionEquals;
      wwInternational.GridTitleMenu.DateFiltersCaptionBefore:= FDateFiltersCaptionBefore;
      wwInternational.GridTitleMenu.DateFiltersCaptionAfter:= FDateFiltersCaptionAfter;
      wwInternational.GridTitleMenu.DateFiltersCaptionBetween:= FDateFiltersCaptionBetween;
      wwInternational.GridTitleMenu.DateFiltersCaptionTomorrow:= FDateFiltersCaptionTomorrow;
      wwInternational.GridTitleMenu.DateFiltersCaptionToday:= FDateFiltersCaptionTomorrow;
      wwInternational.GridTitleMenu.DateFiltersCaptionYesterday:= FDateFiltersCaptionYesterday;
      wwInternational.GridTitleMenu.DateFiltersCaptionNextWeek:= FDateFiltersCaptionNextWeek;
      wwInternational.GridTitleMenu.DateFiltersCaptionThisWeek:= FDateFiltersCaptionThisWeek;
      wwInternational.GridTitleMenu.DateFiltersCaptionLastWeek:= FDateFiltersCaptionLastWeek;
      wwInternational.GridTitleMenu.DateFiltersCaptionNextMonth:= FDateFiltersCaptionNextMonth;
      wwInternational.GridTitleMenu.DateFiltersCaptionThisMonth:= FDateFiltersCaptionThisMonth;
      wwInternational.GridTitleMenu.DateFiltersCaptionLastMonth:= FDateFiltersCaptionLastMonth;
      wwInternational.GridTitleMenu.DateFiltersCaptionNextQuarter:= FDateFiltersCaptionNextQuarter;
      wwInternational.GridTitleMenu.DateFiltersCaptionThisQuarter:= FDateFiltersCaptionThisQuarter;
      wwInternational.GridTitleMenu.DateFiltersCaptionLastQuarter:= FDateFiltersCaptionLastQuarter;
      wwInternational.GridTitleMenu.DateFiltersCaptionNextYear:= FDateFiltersCaptionNextYear;
      wwInternational.GridTitleMenu.DateFiltersCaptionThisYear:= FDateFiltersCaptionThisYear;
      wwInternational.GridTitleMenu.DateFiltersCaptionLastYear:= FDateFiltersCaptionLastYear;
      wwInternational.GridTitleMenu.TextFiltersCaption:= FTextFiltersCaption;
      wwInternational.GridTitleMenu.TextFiltersCaptionEquals:= FTextFiltersCaptionEquals;
      wwInternational.GridTitleMenu.TextFiltersCaptionDoesNotEqual:= FTextFiltersCaptionDoesNotEqual;
      wwInternational.GridTitleMenu.TextFiltersCaptionStartsWith:=  FTextFiltersCaptionStartsWith;
      wwInternational.GridTitleMenu.TextFiltersCaptionDoesNotStartWith:= FTextFiltersCaptionDoesNotStartWith;
      wwInternational.GridTitleMenu.TextFiltersCaptionContains:=  FTextFiltersCaptionContains;
      wwInternational.GridTitleMenu.TextFiltersCaptionDoesNotContain:= FTextFiltersCaptionDoesNotContain;
      wwInternational.GridTitleMenu.TextFiltersCaptionEndsWith:=  FTextFiltersCaptionEndsWith;
      wwInternational.GridTitleMenu.TextFiltersCaptionDoesNotEndWith:= FTextFiltersCaptionDoesNotEndWith;
      wwInternational.GridTitleMenu.ClearGroupByCaption:= FClearGroupByCaption;
      wwInternational.GridTitleMenu.GroupByCaption:=  FGroupByCaption;
      wwInternational.GridTitleMenu.ColumnsCaption:= FColumnsCaption;
      wwInternational.GridTitleMenu.ColumnsCaptionRemove:= FColumnsCaptionRemove;
      wwInternational.GridTitleMenu.ColumnsCaptionAddAfter:= FColumnsCaptionAddAfter;
      wwInternational.GridTitleMenu.ColumnsCaptionAddBefore:= FColumnsCaptionAddBefore;
      // 3/22/10 - Missing Between caption updating
      wwInternational.GridTitleMenu.BetweenDialogLargestCaption:= FBetweenDialogLargestCaption;
      wwInternational.GridTitleMenu.BetweenDialogSmallestCaption:= FBetweenDialogSmallestCaption;
      wwInternational.GridTitleMenu.BetweenDialogOldestCaption:= FBetweenDialogOldestCaption;
      wwInternational.GridTitleMenu.BetweenDialogNewestCaption:= FBetweenDialogNewestCaption;
      wwInternational.GridTitleMenu.BetweenDialogCaption:= FBetweenDialogCaption;
      wwInternational.GridTitleMenu.SelectColumnsDialogCaption:= FSelectColumnsDialogCaption;

    end;

    with LocateDialog do
    begin
      wwInternational.LocateDialog.FieldValueLabel:= FFieldValueLabel;
      wwInternational.LocateDialog.SearchTypeLabel:= FSearchTypelabel;
      wwInternational.LocateDialog.CaseSensitiveLabel:= FCaseSensitiveLabel;
      wwInternational.LocateDialog.MatchExactLabel:= FMatchExactLabel;
      wwInternational.LocateDialog.MatchStartLabel:= FMatchStartLabel;
      wwInternational.LocateDialog.MatchAnyLabel:= FMatchAnyLabel;
      wwInternational.LocateDialog.FieldsLabel:= FFieldsLabel;
      wwInternational.LocateDialog.BtnFirst:= FButtonFirst;
      wwInternational.LocateDialog.BtnNext:= FButtonNext;
      wwInternational.LocateDialog.BtnCancel:= FButtonCancel;
      wwInternational.LocateDialog.BtnClose:= FButtonClose;

      wwInternational.LocateDialog.FieldValueHint:= FFieldValueHint;
      wwInternational.LocateDialog.CaseSensitiveHint:= FCaseSensitiveHint;
      wwInternational.LocateDialog.MatchExactHint:= FMatchExactHint;
      wwInternational.LocateDialog.MatchStartHint:= FMatchStartHint;
      wwInternational.LocateDialog.MatchAnyHint:= FMatchAnyHint;
      wwInternational.LocateDialog.BtnFirstHint:= FButtonFirstHint;
      wwInternational.LocateDialog.BtnNextHint:= FButtonNextHint;

      wwInternational.LocateDialog.FieldNameHint:= FFieldNameHint;
    end;

    with ADO do
    begin
      wwInternational.ADO.UseLocateWhenFindingValue := FUseLocateWhenFindingValue;
    end;

    with Navigator do
    begin
      wwInternational.Navigator.ConfirmDeleteMessage := FConfirmDeleteMessage;
      with Hints do
      begin
        wwInternational.Navigator.Hints.FirstHint := FFirstHint;
        wwInternational.Navigator.Hints.PriorHint := FPriorHint;
        wwInternational.Navigator.Hints.NextHint := FNextHint;
        wwInternational.Navigator.Hints.LastHint := FLastHint;
        wwInternational.Navigator.Hints.InsertHint := FInsertHint;
        wwInternational.Navigator.Hints.DeleteHint := FDeleteHint;
        wwInternational.Navigator.Hints.EditHint := FEditHint;
        wwInternational.Navigator.Hints.PostHint := FPostHint;
        wwInternational.Navigator.Hints.CancelHint := FCancelHint;
        wwInternational.Navigator.Hints.RefreshHint := FRefreshHint;
        wwInternational.Navigator.Hints.PriorPageHint := FPriorPageHint;
        wwInternational.Navigator.Hints.NextPageHint := FNextPageHint;
        wwInternational.Navigator.Hints.SaveBookmarkHint := FSaveBookmarkHint;
        wwInternational.Navigator.Hints.RestoreBookmarkHint := FRestoreBookmarkHint;
        wwInternational.Navigator.Hints.RecordViewDialogHint := FRecordViewDialogHint;
        wwInternational.Navigator.Hints.LocateDialogHint := FLocateDialogHint;
        wwInternational.Navigator.Hints.FilterDialogHint := FFilterDialogHint;
        wwInternational.Navigator.Hints.SearchDialogHint := FSearchDialogHint;
      end;
    end;

    wwInternational.OKCancelBitmapped:= FOKCancelBitmapped;

    with Compatibilty do
    begin
      wwInternational.Compatibilty.RichEditEnableZoom:= FRichEditEnableZoom;
    end;

    with UserMessages do
    begin
      wwInternational.UserMessages.wwDBGridDiscardChanges:= FwwDBGridDiscardChanges;
      wwInternational.UserMessages.PictureValidateError:= FPictureValidateError;
      wwInternational.UserMessages.LocateNoMatches:= FLocateNoMatches;
      wwInternational.UserMessages.LocateNoMoreMatches:= FLocateNoMoreMatches;
      wwInternational.UserMessages.MemoChangesWarning:= FMemoChangesWarning;
      wwInternational.UserMessages.RichEditExitWarning:= FRichEditExitWarning;
      wwInternational.UserMessages.RichEditClearWarning:= FRichEditClearWarning;
      wwInternational.UserMessages.RichEditSpellCheckComplete:= FRichEditSpellCheckComplete;
      wwInternational.UserMessages.RichEditMSWordNotFound:= FRichEditMSWordNotFound;
{      wwInternational.UserMessages.RichEditLoadWarning:= FRichEditLoadWarning;}
      wwInternational.UserMessages.FilterDlgNoCriteria:= FFilterDlgNoCriteria;
      wwInternational.UserMessages.RecordViewExitWarning:= FRecordViewExitWarning;
    end;

    wwInternational.BtnOKCaption:= FBtnOKCaption;
    wwInternational.BtnCancelCaption:= FBtnCancelCaption;
    if (FIniFileName = '.ini') or (FIniFileName = '') then
       wwInternational.IniFileName:= ''
    else
       wwInternational.IniFileName:= FIniFileName+'.ini';

    wwInternational.CheckBoxInGridStyle:= FCheckBoxInGridStyle;
    wwInternational.GridPaintStyle:= FGridPaintStyle;
    wwInternational.OnValidationErrorUsingMask:= FOnValidationErrorUsingMask;

    wwInternational.DialogFontStyle:= FDialogFontStyle;
    wwInternational.UseLocateMethodForSearch:= FUseLocateMethodForSearch;
    wwInternational.FastSQLCancelRange:= FFastSQLCancelRange;
    wwInternational.DefaultEpochYear:= FDefaultEpochYear;
    wwInternational.FilterMemoSize:= FFilterMemoSize;
end;

procedure TwwIntl.ValidationErrorUsingMask(
   Component: TComponent; Field: TField; msg: string='');
var 
    doDefault: boolean;
begin
  if msg='' then
     msg:= Format(SMaskEditErr, ['']);
  DoDefault:= True;
  if Assigned(FOnValidationErrorUsingMask) then
     FOnValidationErrorUsingMask(Component, Field, msg, doDefault);
  if doDefault then
  begin
     MessageBeep(0);
     raise EInvalidOperation.create(msg);
  end
end;



procedure Register;
begin
end;


Function wwCreateCommonButton(AOwner: TForm;
   ButtonKind: TBitBtnKind): TComponent;
var bitbtn: TBitBtn;
    {$ifdef wwDelphi2008Up}
    btn: TCustomButton;
    {$else}
//    btn: TButton;
    btn: TCustomButton;
    {$endif}
begin
   bitbtn:= nil; { Make compiler happy }
   if wwInternational.OKCancelBitmapped then
   begin
      bitbtn:= TBitBtn.Create(AOwner);
      btn:= bitBtn;
   end
   else begin
      btn:= TButton.Create(AOwner)
   end;

   with btn do begin
      Parent:= AOwner;
      Visible := False;
      Width := (screen.pixelsperinch * 77) div 96;
      Height := (screen.pixelsperinch * 24) div 96;
   end;

   if wwInternational.OKCancelBitmapped then with bitBtn do begin
      Margin := 2;
      Kind := ButtonKind;
      Layout := blGlyphLeft;
      NumGlyphs := 2;
      Spacing := -1;
      Width := (screen.pixelsperinch * 77) div 96;
      Height := (screen.pixelsperinch * 27) div 96;

      Font.Color := clWindowText;
      Font.Height := -11;
      Font.Name := 'MS Sans Serif';
      Font.Style:= wwInternational.DialogFontStyle;
   end;

   with btn do begin
      case ButtonKind of
         bkOK: begin
            wwSetString(btn, 'Caption', wwInternational.BtnOKCaption);
            //Caption := wwInternational.BtnOKCaption;
            ModalResult:= mrOK;
           end;
         bkCancel: begin
            wwSetString(btn, 'Caption', wwInternational.BtnCancelCaption);
            //Caption:= wwInternational.BtnCancelCaption;
            ModalResult:= mrCancel;
            Cancel:= True; {1/22/97 - Non-bitmapped buttons require this }
           end;
         bkHelp:
            wwSetString(btn, 'Caption', '-');
            //Caption:= 'Help';
      end;
   end;

   result:= btn;
end;

procedure InitMainIntl;
begin
  wwInternational:= TwwIntl.create(Application);
end;


initialization
  InitMainIntl;
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TwwIntl, TControl);
  GroupDescendentsWith(TwwController, TControl);
finalization
  wwInternational.Free;
end.


