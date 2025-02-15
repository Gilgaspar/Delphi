// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxSynMemo.pas' rev: 32.00 (Windows)

#ifndef FrxsynmemoHPP
#define FrxsynmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Imm.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <frxCtrls.hpp>
#include <fs_iparser.hpp>
#include <frxPopupForm.hpp>
#include <fs_xml.hpp>
#include <fs_iinterpreter.hpp>
#include <Vcl.Menus.hpp>
#include <frxRes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxsynmemo
{
//-- forward type declarations -----------------------------------------------
struct TfrxCharAttributes;
class DELPHICLASS TfrxAttributeStyle;
class DELPHICLASS TfrxAttributeStyles;
class DELPHICLASS TfrxSynDialectStyle;
class DELPHICLASS TfrxSynDialectStyles;
class DELPHICLASS TfrxSynAttributes;
class DELPHICLASS TfrxBreakPoint;
class DELPHICLASS TfrxCompletionItem;
class DELPHICLASS TfrxCompletionList;
class DELPHICLASS TfrxCodeCompletionThread;
class DELPHICLASS TfrxSyntaxMemo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TCharAttr : unsigned char { caNo, caText, caComment, caKeyword, caString, caNumber };

struct DECLSPEC_DRECORD TfrxCharAttributes
{
public:
	System::Byte StyleIndex;
	bool IsSelBlock;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxAttributeStyle : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Byte FStyleID;
	System::Uitypes::TColor FFontColor;
	System::Uitypes::TFontStyles FFontStyle;
	System::Classes::TStrings* FKeywords;
	TCharAttr FAttrType;
	
protected:
	virtual void __fastcall SetCollection(System::Classes::TCollection* Value);
	
public:
	__fastcall virtual TfrxAttributeStyle(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxAttributeStyle(void);
	__property System::Byte StyleID = {read=FStyleID, nodefault};
	
__published:
	__property TCharAttr AttrType = {read=FAttrType, write=FAttrType, nodefault};
	__property System::Uitypes::TColor FontColor = {read=FFontColor, write=FFontColor, nodefault};
	__property System::Uitypes::TFontStyles FontStyle = {read=FFontStyle, write=FFontStyle, nodefault};
	__property System::Classes::TStrings* Keywords = {read=FKeywords};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxAttributeStyles : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxAttributeStyle* operator[](int Index) { return this->Items[Index]; }
	
private:
	TfrxAttributeStyle* FDefaultAttribute;
	System::Classes::TStringList* FIndexedList;
	HIDESBASE TfrxAttributeStyle* __fastcall GetItem(int Index);
	
public:
	System::Byte __fastcall GetUniqueID(void);
	__fastcall TfrxAttributeStyles(void);
	__fastcall virtual ~TfrxAttributeStyles(void);
	HIDESBASE TfrxAttributeStyle* __fastcall Add(void);
	TfrxAttributeStyle* __fastcall GetStyleByID(System::Byte ID);
	void __fastcall AssignStyleByID(System::Byte ID, Vcl::Graphics::TFont* aFont);
	void __fastcall AssignStyle(TfrxAttributeStyle* aStyle, Vcl::Graphics::TFont* aFont);
	System::Byte __fastcall FindStyleIDByKeyword(const System::UnicodeString Name, TCharAttr AttrType);
	__property TfrxAttributeStyle* Items[int Index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSynDialectStyle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TfrxAttributeStyles* FAttributeStyles;
	System::UnicodeString FKeywords;
	System::UnicodeString FCommentLine1;
	System::UnicodeString FCommentLine2;
	System::UnicodeString FCommentBlock1;
	System::UnicodeString FCommentBlock2;
	System::UnicodeString FStringQuotes;
	System::UnicodeString FHexSequence;
	System::UnicodeString FName;
	System::TObject* FOwner;
	void __fastcall SetName(const System::UnicodeString Value);
	
public:
	__fastcall TfrxSynDialectStyle(System::TObject* AOwner);
	__fastcall virtual ~TfrxSynDialectStyle(void);
	void __fastcall SaveTo(const System::UnicodeString Section, System::TObject* Ini);
	void __fastcall LoadFrom(const System::UnicodeString Section, System::TObject* Ini);
	__property TfrxAttributeStyles* AttributeStyles = {read=FAttributeStyles};
	__property System::UnicodeString Name = {read=FName, write=SetName};
	
__published:
	__property System::UnicodeString Keywords = {read=FKeywords, write=FKeywords};
	__property System::UnicodeString CommentLine1 = {read=FCommentLine1, write=FCommentLine1};
	__property System::UnicodeString CommentLine2 = {read=FCommentLine2, write=FCommentLine2};
	__property System::UnicodeString CommentBlock1 = {read=FCommentBlock1, write=FCommentBlock1};
	__property System::UnicodeString CommentBlock2 = {read=FCommentBlock2, write=FCommentBlock2};
	__property System::UnicodeString StringQuotes = {read=FStringQuotes, write=FStringQuotes};
	__property System::UnicodeString HexSequence = {read=FHexSequence, write=FHexSequence};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxSynDialectStyles : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxSynDialectStyle* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TList* FLIst;
	TfrxSynDialectStyle* FDefSynDialectStyle;
	int FActiveIndex;
	System::Classes::TNotifyEvent FActiveChanged;
	TfrxSynDialectStyle* __fastcall GetItem(int Index);
	TfrxSynDialectStyle* __fastcall GetActiveDialicet(void);
	TfrxAttributeStyles* __fastcall GetActiveStyles(void);
	void __fastcall SetActiveIndex(const int Value);
	
public:
	__fastcall TfrxSynDialectStyles(void);
	__fastcall virtual ~TfrxSynDialectStyles(void);
	TfrxSynDialectStyle* __fastcall Add(void);
	void __fastcall Clear(void);
	int __fastcall Count(void);
	void __fastcall SaveTo(const System::UnicodeString Section, System::TObject* Ini);
	void __fastcall LoadFrom(const System::UnicodeString Section, System::TObject* Ini);
	__property TfrxSynDialectStyle* Items[int Index] = {read=GetItem/*, default*/};
	__property TfrxSynDialectStyle* ActiveDialicet = {read=GetActiveDialicet};
	__property TfrxAttributeStyles* ActiveStyles = {read=GetActiveStyles};
	__property int ActiveIndex = {read=FActiveIndex, write=SetActiveIndex, nodefault};
	__property System::Classes::TNotifyEvent OnActiveChanged = {read=FActiveChanged, write=FActiveChanged};
};


typedef void __fastcall (__closure *TfrxCodeCompletionEvent)(const System::UnicodeString Name, TfrxCompletionList* List);

typedef System::DynamicArray<System::Byte> TfrxByteArr;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSynAttributes : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TfrxByteArr> _TfrxSynAttributes__1;
	
	
public:
	TfrxByteArr operator[](int Index) { return this->Line[Index]; }
	
private:
	_TfrxSynAttributes__1 FArray;
	int FCapacity;
	int FCount;
	bool FUpdating;
	TfrxSynDialectStyles* FDialectStyles;
	Fs_iparser::TfsParser* FParser;
	void __fastcall SetCapacity(int NewCapacity);
	void __fastcall SetCount(int NewCount);
	TfrxByteArr __fastcall GetLine(int Index);
	void __fastcall PutLine(int Index, const TfrxByteArr Value);
	void __fastcall ActiveChanged(System::TObject* Sender);
	
public:
	__fastcall TfrxSynAttributes(Fs_iparser::TfsParser* Parser, TfrxSynDialectStyles* DialectStyles);
	void __fastcall SetLineLen(int Index, int NewLen);
	void __fastcall Delete(int Index);
	TfrxByteArr __fastcall GetAllAttributes(void);
	void __fastcall SetAllAttributes(TfrxByteArr Attr);
	void __fastcall UpdateSyntax(int EndLine, System::Classes::TStringList* Text);
	void __fastcall UpdateSyntaxDialect(void);
	__property TfrxByteArr Line[int Index] = {read=GetLine, write=PutLine/*, default*/};
	__property int Count = {read=FCount, write=SetCount, nodefault};
	__property bool Updating = {read=FUpdating, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxSynAttributes(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxBreakPoint : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FCondition;
	System::UnicodeString FSpecialCondition;
	bool FEnabled;
	int FLine;
	
public:
	__property System::UnicodeString Condition = {read=FCondition, write=FCondition};
	__property bool Enabled = {read=FEnabled, write=FEnabled, nodefault};
	__property int Line = {read=FLine, write=FLine, nodefault};
	__property System::UnicodeString SpecialCondition = {read=FSpecialCondition, write=FSpecialCondition};
public:
	/* TObject.Create */ inline __fastcall TfrxBreakPoint(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBreakPoint(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TfrxItemType : unsigned char { itVar, itProcedure, itFunction, itProperty, itIndex, itConstant, itConstructor, itType, itEvent };

typedef System::Set<TfrxItemType, TfrxItemType::itVar, TfrxItemType::itEvent> TfrxItemTypes;

enum DECLSPEC_DENUM TfrxCompletionListType : unsigned char { cltRtti, cltScript, cltAddon };

typedef System::Set<TfrxCompletionListType, TfrxCompletionListType::cltRtti, TfrxCompletionListType::cltAddon> TfrxCompletionListTypes;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCompletionItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxCompletionItem* FParent;
	System::UnicodeString FName;
	System::UnicodeString FType;
	System::UnicodeString FParams;
	TfrxItemType FItemType;
	int FStartVisible;
	int FEndVisible;
	
public:
	__property System::UnicodeString Name = {read=FName};
	__property System::UnicodeString Typ = {read=FType};
	__property System::UnicodeString Params = {read=FParams};
	__property TfrxItemType ItemType = {read=FItemType, nodefault};
public:
	/* TObject.Create */ inline __fastcall TfrxCompletionItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCompletionItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCompletionList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxCompletionItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TStringList* FConstants;
	System::Classes::TStringList* FVariables;
	System::Classes::TStringList* FFunctions;
	System::Classes::TStringList* FClasses;
	bool FLocked;
	TfrxCompletionItem* __fastcall AddBaseVar(System::Classes::TStrings* varList, const System::UnicodeString Name, const System::UnicodeString sType, int VisibleStart = 0x0, int VisibleEnd = 0xffffffff, const System::UnicodeString ParentFunc = System::UnicodeString());
	TfrxCompletionItem* __fastcall GetItem(int Index);
	
public:
	__fastcall TfrxCompletionList(void);
	__fastcall virtual ~TfrxCompletionList(void);
	void __fastcall DestroyItems(void);
	int __fastcall Count(void);
	TfrxCompletionItem* __fastcall AddConstant(const System::UnicodeString Name, const System::UnicodeString sType, int VisibleStart = 0x0, int VisibleEnd = 0xffffffff, const System::UnicodeString ParentFunc = System::UnicodeString());
	TfrxCompletionItem* __fastcall AddVariable(const System::UnicodeString Name, const System::UnicodeString sType, int VisibleStart = 0x0, int VisibleEnd = 0xffffffff, const System::UnicodeString ParentFunc = System::UnicodeString());
	TfrxCompletionItem* __fastcall AddClass(const System::UnicodeString Name, const System::UnicodeString sType, int VisibleStart = 0x0, int VisibleEnd = 0xffffffff, const System::UnicodeString ParentFunc = System::UnicodeString());
	TfrxCompletionItem* __fastcall AddFunction(const System::UnicodeString Name, const System::UnicodeString sType, const System::UnicodeString Params, int VisibleStart = 0x0, int VisibleEnd = 0xffffffff, const System::UnicodeString ParentFunc = System::UnicodeString());
	TfrxCompletionItem* __fastcall Find(const System::UnicodeString Name);
	__property TfrxCompletionItem* Items[int Index] = {read=GetItem/*, default*/};
	__property bool Locked = {read=FLocked, write=FLocked, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxCodeCompletionThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::Classes::TStringList* FText;
	Fs_iinterpreter::TfsScript* FScript;
	Fs_iinterpreter::TfsScript* FOriginalScript;
	System::Classes::TStream* FILCode;
	Fs_xml::TfsXMLDocument* FXML;
	TfrxCompletionList* FCompletionList;
	System::UnicodeString FSyntaxType;
	HWND FMemoHandle;
	void __fastcall SyncScript(void);
	void __fastcall UpdateCode(void);
	void __fastcall FreeScript(void);
	void __fastcall FillCodeCompletion(void);
	
public:
	__fastcall virtual ~TfrxCodeCompletionThread(void);
	virtual void __fastcall Execute(void);
	__property Fs_iinterpreter::TfsScript* Script = {read=FOriginalScript, write=FOriginalScript};
public:
	/* TThread.Create */ inline __fastcall TfrxCodeCompletionThread(void)/* overload */ : System::Classes::TThread() { }
	/* TThread.Create */ inline __fastcall TfrxCodeCompletionThread(bool CreateSuspended)/* overload */ : System::Classes::TThread(CreateSuspended) { }
	
};


class PASCALIMPLEMENTATION TfrxSyntaxMemo : public Frxctrls::TfrxScrollWin
{
	typedef Frxctrls::TfrxScrollWin inherited;
	
private:
	int FActiveLine;
	bool FAllowLinesChange;
	System::Uitypes::TColor FBlockColor;
	System::Uitypes::TColor FBlockFontColor;
	System::StaticArray<int, 10> FBookmarks;
	int FCharHeight;
	int FCharWidth;
	Vcl::Graphics::TFont* FCommentAttr;
	Frxpopupform::TfrxPopupForm* FCompletionForm;
	Vcl::Stdctrls::TListBox* FCompletionLB;
	bool FDoubleClicked;
	bool FDown;
	bool FToggleBreakPointDown;
	int FGutterWidth;
	bool FIsMonoType;
	Vcl::Graphics::TFont* FKeywordAttr;
	int FMaxLength;
	System::UnicodeString FMessage;
	bool FModified;
	bool FMoved;
	Vcl::Graphics::TFont* FNumberAttr;
	System::Types::TPoint FOffset;
	System::Classes::TNotifyEvent FOnChangePos;
	System::Classes::TNotifyEvent FOnChangeText;
	TfrxCodeCompletionEvent FOnCodeCompletion;
	Fs_iparser::TfsParser* FParser;
	System::Types::TPoint FPos;
	Vcl::Graphics::TFont* FStringAttr;
	System::Types::TPoint FSelEnd;
	System::Types::TPoint FSelStart;
	int FTabStops;
	System::Types::TPoint FCompSelStart;
	System::Types::TPoint FCompSelEnd;
	bool FShowGutter;
	TfrxSynAttributes* FSynAttributes;
	TfrxSynDialectStyles* FSynDialectStyles;
	System::UnicodeString FSyntax;
	System::Types::TPoint FTempPos;
	System::Classes::TStringList* FText;
	Vcl::Graphics::TFont* FTextAttr;
	System::Classes::TStringList* FUndo;
	System::Types::TPoint FWindowSize;
	System::Classes::TStringList* FBreakPoints;
	System::Classes::TStringList* FCodeCompList;
	int FStartCodeCompPos;
	System::UnicodeString FCompleationFilter;
	Fs_xml::TfsXMLDocument* FScriptRTTIXML;
	TfrxCompletionList* FRttiCompletionList;
	TfrxCompletionList* FScriptCompletionList;
	TfrxCompletionList* FAddonCompletionList;
	TfrxCompletionList* FClassCompletionList;
	TfrxCodeCompletionThread* FCodeCompletionThread;
	Fs_iinterpreter::TfsScript* FScript;
	Vcl::Extctrls::TTimer* FTimer;
	bool FShowLineNumber;
	TfrxItemTypes FCodeComplitionFilter;
	TfrxCompletionListTypes FShowInCodeComplition;
	int FCodeCompletionWidth;
	int FCodeCompletionHeight;
	int FCodeCompletionMinHeight;
	int FCodeCompletionMinWidth;
	bool FMultiByteLang;
	Vcl::Graphics::TBitmap* FTmpCanvas;
	int __fastcall GetCharWidth(const System::UnicodeString Str);
	int __fastcall GetCharXPos(int X);
	TfrxCharAttributes __fastcall GetCharAttr(const System::Types::TPoint &Pos);
	int __fastcall GetLineBegin(int Index);
	int __fastcall GetPlainTextPos(const System::Types::TPoint &Pos);
	System::Types::TPoint __fastcall GetPosPlainText(int Pos);
	bool __fastcall GetRunLine(int Index);
	System::UnicodeString __fastcall GetSelText(void);
	HIDESBASE System::Classes::TStrings* __fastcall GetText(void);
	System::UnicodeString __fastcall LineAt(int Index, bool UseTrim = true);
	int __fastcall GetIdentEnd(int aPos);
	bool __fastcall IsCursorInStringBlock(void);
	int __fastcall LineLength(int Index);
	System::UnicodeString __fastcall Pad(int n);
	void __fastcall AddSel(void);
	void __fastcall AddUndo(void);
	void __fastcall ClearSel(void);
	void __fastcall ClearSyntax(int ClearFrom);
	void __fastcall CompletionFormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall CompletionLBDblClick(System::TObject* Sender);
	void __fastcall CompletionLBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall CompletionLBKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall CompletionLBKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall CorrectBookmark(int Line, int Delta);
	void __fastcall CorrectBreakPoints(int Line, int Delta);
	void __fastcall CreateSynArray(int EndLine);
	void __fastcall DoBackspace(void);
	void __fastcall DoChange(void);
	void __fastcall DoChar(System::WideChar Ch);
	void __fastcall DoCodeCompletion(void);
	void __fastcall BuildCClist(const System::UnicodeString sName);
	void __fastcall DoCtrlI(void);
	void __fastcall DoCtrlU(void);
	void __fastcall DoCtrlR(void);
	void __fastcall DoCtrlL(void);
	void __fastcall DoDel(void);
	void __fastcall DoDown(void);
	void __fastcall DoEnd(bool Ctrl);
	void __fastcall DoHome(bool Ctrl);
	void __fastcall DoLeft(void);
	void __fastcall DoPgUp(void);
	void __fastcall DoPgDn(void);
	void __fastcall DoReturn(void);
	void __fastcall DoRight(void);
	void __fastcall DoUp(void);
	void __fastcall EnterIndent(void);
	void __fastcall LinesChange(System::TObject* Sender);
	void __fastcall SetActiveLine(int Line);
	void __fastcall SetCommentAttr(Vcl::Graphics::TFont* Value);
	void __fastcall SetKeywordAttr(Vcl::Graphics::TFont* Value);
	void __fastcall SetNumberAttr(Vcl::Graphics::TFont* const Value);
	void __fastcall SetRunLine(int Index, const bool Value);
	void __fastcall SetSelText(const System::UnicodeString Value);
	void __fastcall SetShowGutter(bool Value);
	void __fastcall SetStringAttr(Vcl::Graphics::TFont* Value);
	void __fastcall SetSyntax(const System::UnicodeString Value);
	HIDESBASE void __fastcall SetText(System::Classes::TStrings* Value);
	void __fastcall SetTextAttr(Vcl::Graphics::TFont* Value);
	void __fastcall ShiftSelected(bool ShiftRight);
	void __fastcall ShowCaretPos(void);
	void __fastcall TabIndent(void);
	void __fastcall UnIndent(void);
	HIDESBASE void __fastcall UpdateScrollBar(void);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMIMEStartComp(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMIMEEndComp(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMIMECOMPOSITION(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMFRXSyncScript(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMFRXUpdateCode(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMFRXFillCodeCompletion(Winapi::Messages::TMessage &Message);
	bool __fastcall GetTextSelected(void);
	void __fastcall SetGutterWidth(const int Value);
	void __fastcall SetShowInCodeComplition(const TfrxCompletionListTypes Value);
	void __fastcall SetCodeCompletionWidth(const int Value);
	void __fastcall SetCodeCompletionHeight(const int Value);
	void __fastcall SetCodeCompletionMinHeight(const int Value);
	void __fastcall SetCodeCompletionMinWidth(const int Value);
	void __fastcall PopCopy(System::TObject* Sender);
	void __fastcall PopCut(System::TObject* Sender);
	void __fastcall PopPaste(System::TObject* Sender);
	void __fastcall PopDelete(System::TObject* Sender);
	void __fastcall PopSelectAll(System::TObject* Sender);
	TfrxAttributeStyles* __fastcall GetAttributeStyles(void);
	
protected:
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseWheelDown(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall MouseWheelUp(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	virtual void __fastcall OnHScrollChange(System::TObject* Sender);
	virtual void __fastcall OnVScrollChange(System::TObject* Sender);
	DYNAMIC void __fastcall Resize(void);
	System::UnicodeString __fastcall GetCompletionString(void);
	System::UnicodeString __fastcall GetFilter(System::UnicodeString aStr);
	void __fastcall DoTimer(System::TObject* Sender);
	virtual void __fastcall DoPPIChanged(int aNewPPI);
	
public:
	__fastcall virtual TfrxSyntaxMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxSyntaxMemo(void);
	virtual void __fastcall Paint(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall CompletionClose(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall SelectAll(void);
	void __fastcall SetPos(int x, int y);
	void __fastcall SetPosByCoords(int X, int Y);
	void __fastcall ShowMessage(const System::UnicodeString s);
	void __fastcall Undo(void);
	void __fastcall UpdateView(void);
	void __fastcall ClearBreakPoints(void);
	bool __fastcall Find(const System::UnicodeString SearchText, bool CaseSensitive, int &SearchFrom);
	int __fastcall GetPlainPos(void);
	System::Types::TPoint __fastcall GetPos(void);
	int __fastcall IsBookmark(int Line);
	void __fastcall AddBookmark(int Line, int Number);
	void __fastcall DeleteBookmark(int Number);
	void __fastcall GotoBookmark(int Number);
	void __fastcall AddNewBreakPoint(void);
	void __fastcall AddBreakPoint(int Number, const System::UnicodeString Condition, const System::UnicodeString Special);
	void __fastcall ToggleBreakPoint(int Number, const System::UnicodeString Condition);
	void __fastcall DeleteBreakPoint(int Number);
	void __fastcall DeleteF4BreakPoints(void);
	bool __fastcall IsBreakPoint(int Number);
	bool __fastcall IsActiveBreakPoint(int Number);
	System::UnicodeString __fastcall GetBreakPointCondition(int Number);
	System::UnicodeString __fastcall GetBreakPointSpecialCondition(int Number);
	void __fastcall FillRtti(void);
	void __fastcall SaveToIni(const System::UnicodeString IniPath, const System::UnicodeString Section, const System::UnicodeString FileName);
	void __fastcall LoadFromIni(const System::UnicodeString IniPath, const System::UnicodeString Section, const System::UnicodeString FileName);
	__property TfrxAttributeStyles* AttributeStyles = {read=GetAttributeStyles};
	__property TfrxCodeCompletionThread* CodeCompletionThread = {read=FCodeCompletionThread};
	__property int CodeCompletionMinWidth = {read=FCodeCompletionMinWidth, write=SetCodeCompletionMinWidth, default=300};
	__property int CodeCompletionMinHeight = {read=FCodeCompletionMinHeight, write=SetCodeCompletionMinHeight, default=100};
	__property int CodeCompletionWidth = {read=FCodeCompletionWidth, write=SetCodeCompletionWidth, default=300};
	__property int CodeCompletionHeight = {read=FCodeCompletionHeight, write=SetCodeCompletionHeight, default=100};
	__property int ActiveLine = {read=FActiveLine, write=SetActiveLine, nodefault};
	__property System::Uitypes::TColor BlockColor = {read=FBlockColor, write=FBlockColor, nodefault};
	__property System::Uitypes::TColor BlockFontColor = {read=FBlockFontColor, write=FBlockFontColor, nodefault};
	__property System::Classes::TStringList* BreakPoints = {read=FBreakPoints};
	__property Color = {default=-16777211};
	__property Vcl::Graphics::TFont* CommentAttr = {read=FCommentAttr, write=SetCommentAttr};
	__property TfrxItemTypes CodeComplitionFilter = {read=FCodeComplitionFilter, write=FCodeComplitionFilter, nodefault};
	__property TfrxCompletionListTypes ShowInCodeComplition = {read=FShowInCodeComplition, write=SetShowInCodeComplition, nodefault};
	__property TfrxSynDialectStyles* SynDialectStyles = {read=FSynDialectStyles};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property int TabStops = {read=FTabStops, write=FTabStops, nodefault};
	__property int GutterWidth = {read=FGutterWidth, write=SetGutterWidth, nodefault};
	__property Vcl::Graphics::TFont* KeywordAttr = {read=FKeywordAttr, write=SetKeywordAttr};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property bool MultiByteLang = {read=FMultiByteLang, write=FMultiByteLang, nodefault};
	__property Vcl::Graphics::TFont* NumberAttr = {read=FNumberAttr, write=SetNumberAttr};
	__property bool RunLine[int Index] = {read=GetRunLine, write=SetRunLine};
	__property System::UnicodeString SelText = {read=GetSelText, write=SetSelText};
	__property Vcl::Graphics::TFont* StringAttr = {read=FStringAttr, write=SetStringAttr};
	__property Vcl::Graphics::TFont* TextAttr = {read=FTextAttr, write=SetTextAttr};
	__property System::Classes::TStrings* Lines = {read=GetText, write=SetText};
	__property System::UnicodeString Syntax = {read=FSyntax, write=SetSyntax};
	__property Fs_iinterpreter::TfsScript* Script = {read=FScript, write=FScript};
	__property bool ShowGutter = {read=FShowGutter, write=SetShowGutter, nodefault};
	__property bool ShowLineNumber = {read=FShowLineNumber, write=FShowLineNumber, nodefault};
	__property bool TextSelected = {read=GetTextSelected, nodefault};
	__property Fs_xml::TfsXMLDocument* ScriptRTTIXML = {read=FScriptRTTIXML};
	__property System::Classes::TNotifyEvent OnChangePos = {read=FOnChangePos, write=FOnChangePos};
	__property System::Classes::TNotifyEvent OnChangeText = {read=FOnChangeText, write=FOnChangeText};
	__property TfrxCodeCompletionEvent OnCodeCompletion = {read=FOnCodeCompletion, write=FOnCodeCompletion};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyDown;
	__property PopupMenu;
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSyntaxMemo(HWND ParentWindow) : Frxctrls::TfrxScrollWin(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_FRX_SYNC_SCRIPT = System::Word(0x464);
static const System::Word WM_FRX_UPDATE_CODE = System::Word(0x465);
static const System::Word WM_FRX_FILL_CODE_COMPLETION = System::Word(0x466);
}	/* namespace Frxsynmemo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSYNMEMO)
using namespace Frxsynmemo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxsynmemoHPP
