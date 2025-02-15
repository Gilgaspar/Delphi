{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRDEFS.PAS - CONDITIONAL DEFINES, INCLUDED IN ALL FILES ::
  ::                                                         ::
  :: Copyright (c) 2001 A Lochert                            ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

{$ifdef ver270}
  {$define USE_LIFECYCLE}
{$endif}
{$ifdef ver280}
  {$define USE_LIFECYCLE}
{$endif}




{$ifdef ver130}
{$define ver120}
{$endif}
{$IFDEF VER125}
{$DEFINE VER110}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE VER110}
{$ENDIF}
{$define VER36PRO}
{$define VER36}

