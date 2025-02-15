unit vcl.wwrichedspellxp;
//
// Component : TwwDBRichEditMSWord
//
// Copyright (c) 1999-2001 by Woll2Woll Software
//
// 4/18/00 - Fixed open failure by changing last paramater to true
// 8/30/07 - Support spell check without subclassing
//
{$i wwIfDef.pas}

interface

uses classes, wwriched;

type
  TwwDBRichEditMSWord = class(TwwDBRichEdit)
   public
     Function MSWordSpellChecker: boolean; override;
  end;

  Function MSWordSpellChecker(RichEdit: TwwDBRichEdit): boolean;  

procedure Register;

implementation

//{$R wwrichsp.RES}

uses
     wordxp, oleserver, activex,
     sysutils, dialogs, forms, controls,
     wwintl;

type
 TwwWordApplication=class(TWordApplication)
  private
    ValidServer: boolean;
  protected
    function GetServer: IUnknown; override;
 end;

function CreateComObject(const ClassID: TGUID; var Status: HResult): IUnknown;
begin
  Status:= CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
    CLSCTX_LOCAL_SERVER, IUnknown, Result);
end;

function TwwWordApplication.GetServer: IUnknown;
var Status: HResult;
begin
  case ConnectKind of
    ckNewInstance:
      Result := CreateComObject(ServerData^.ClassId, Status)
    else Result:= inherited GetServer;
  end;
  ValidServer:= (Result<>nil);
  if not ValidServer then abort; //OleCheck(Status);
end;

function SpellCheckWithCom(RichEdit: TwwDBRichEdit; var ErrorStarting: boolean): boolean;
var
  RouteDocument, OriginalFormat, SaveChanges: OLEVariant;
  BoolFalse, BoolTrue, EmptyString, Format, FileNameOLE: OLEVariant;
  WordApplication: TwwWordApplication;
  FileName:string;
  NoErrors: boolean;
  Data: OLEVariant;
begin
  with RichEdit do begin
    result:= False;
    if not wwGetUniqueFileName(FileName) then begin
       ShowMessage('Fail to create temporary file.');
       exit;
    end;

    ILines.SaveToFile(FileName);

    Screen.cursor:= crHourGlass;
    NoErrors:= False;

    WordApplication:= TwwWordApplication.create(RichEdit);
    try
       WordApplication.ConnectKind:= ckNewInstance;

       with WordApplication do begin
         ErrorStarting:= True;
         Connect;
         ErrorStarting:= not Validserver;
         if not ValidServer then begin
            exit;
         end;

         WindowState:= wdWindowStateMinimize;

         Data:= RichEdit.text;

         FileNameOLE := FileName;
         BoolFalse:= False;
         BoolTrue:= True;
         EmptyString:= '';
         Format:= wdOpenFormatAuto;
//         Documents.Open(FileNameOLE, BoolFalse, BoolFalse,
//            BoolFalse, EmptyString, EmptyString, BoolFalse,
//            EmptyString, EmptyString, format, BoolFalse, BoolTrue); { 4/18/00 - Changed last paramater to true }
         Documents.Open2000(FileNameOLE, BoolFalse, BoolFalse,
            BoolFalse, EmptyString, EmptyString, BoolFalse,
            EmptyString, EmptyString, format, BoolFalse, BoolTrue); { 4/18/00 - Changed last paramater to true }
         Visible := False;

         NoErrors:= (ActiveDocument.SpellingErrors.Count=0) and
                    (ActiveDocument.GrammaticalErrors.Count=0);

         if not NoErrors then
         begin
           RichEdit.StartMSWordMonitoring(FileName);
           try
              ActiveDocument.CheckGrammar;
           finally
              RichEdit.StopMSWordMonitoring;
           end;
           ActiveDocument.Save;
         end;
         SaveChanges:= wdDoNotSaveChanges;
         OriginalFormat:= wdOriginalDocumentFormat;
         RouteDocument:= False;
         ActiveDocument.Close(SaveChanges, OriginalFormat, RouteDocument);

         Quit(SaveChanges, OriginalFormat, RouteDocument);
       end;
    finally
       WordApplication.Free;
       if (not ErrorStarting) then
          if (not NoErrors) then
             ILines.LoadFromFile(FileName);
       DeleteFile(FileName);
       Application.BringToFront;
       Screen.Cursor:= crArrow;
    end;
    if Not ErrorStarting then
       result:= not NoErrors
    else result:= false
  end;
end;


Function MSWordSpellChecker(RichEdit: TwwDBRichEdit): boolean;
var
    ErrorStarting: boolean;
begin
   try
      result:= SpellCheckWithCom(RichEdit, ErrorStarting);
   except
      if ErrorStarting then begin
         result:= False;
         MessageDlg(wwInternational.UserMessages.RichEditMSWordNotFound,
                    mtInformation, [mbOK], 0);
         exit;
      end;
      raise;
   end;

   if (not result) and (wwInternational.UserMessages.RichEditSpellCheckComplete<>'') then
      MessageDlg(wwInternational.UserMessages.RichEditSpellCheckComplete,
                    mtInformation, [mbOK], 0);
end;

Function TwwDBRichEditMSWord.MSWordSpellChecker: boolean;
begin
   result:= vcl.wwrichedspellxp.MSWordSpellChecker(self);
end;

procedure Register;
begin
  RegisterComponents('IP Controls', [TwwDBRichEditMSWord]);
end;

end.
