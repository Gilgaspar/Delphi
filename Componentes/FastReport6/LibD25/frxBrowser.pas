{******************************************}
{                                          }
{             FastReport 6                 }
{      Interface for Browser Components    }
{                                          }
{         Copyright (c) 2021               }
{         by Alexander Syrykh              }
{          Fast Reports Inc.               }
{                                          }
{                                          }
{******************************************}
unit frxBrowser;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls;

type

  TTestURLEvent = function(URL: String): Boolean of object;

  TNavComplete = procedure(const Value: OleVariant) of object;

  TfrxBrowserClass =  class of TWinControl;

  IfrxWebBrowser = interface(IUnknown)
  ['{FAA83A31-6D9B-4C9D-8C3D-A6F8F61F85B8}']
    function GetNavigateHistory : TStringList; stdcall;
    function GetOnDocumentComplet : TNotifyEvent; stdcall;
    function GetOnTestURL : TTestURLEvent; stdcall;
    function GetURL : String; stdcall;
    function GetDocument: IDispatch; stdcall;
    procedure SetNavigateHistory(const Value: TStringList); stdcall;
    procedure SetOnDocumentComplet(const Value: TNotifyEvent); stdcall;
    procedure SetURL(const Value: String); stdcall;
    procedure SetOnTestURL(const Value: TTestURLEvent); stdcall;
    procedure SetOnNavComplete(const Value: TNavComplete); stdcall;
    procedure CloseQuery(var CanClose: Boolean); stdcall;
    procedure NavigateURL(aURL: String); stdcall;
    procedure BrowserConfiguration; stdcall;
  end;

var
  frxBrowserGlobal : TfrxBrowserClass;

implementation

initialization
  frxBrowserGlobal := nil;
end.

