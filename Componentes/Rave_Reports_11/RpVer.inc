{$IFDEF VER120} { Delphi 4.0 }
  {$DEFINE LEVEL4 }
  {$DEFINE DELPHI }
{$ENDIF}
{$IFDEF VER125} { C++Builder 4.0 }
  {$DEFINE LEVEL4 }
  {$DEFINE CBUILDER }
{$ENDIF}
{$IFDEF VER130} { Delphi 5.0/C++Builder 5.0 }
  {$DEFINE LEVEL5 }
  {$DEFINE LEVEL4 }
{$ENDIF}
{$IFDEF ConditionalExpressions}
 {$IF Defined(VER330)} { Delphi 10.3 Rio }
    {$Define LEVEL5}
    {$Define LEVEL6}
    {$Define LEVEL2006 }
    {$Define LEVEL2009 }
    {$Define LEVEL2010 }
    {$Define LevelXE}
    {$DEFINE LEVELD10_3 }
  {$IFEND}
  {$IF Defined(VER320)} { Delphi 10.2 Tokyo }
    {$DEFINE LEVELD10_2 }
  {$IFEND}
  {$IF Defined(VER310) or Defined(LevelD10_2)} { Delphi 10 Berlin }
    {$DEFINE LEVELD10_1 }
  {$IFEND}
  {$IF Defined(VER300) or Defined(LevelD10_1)} { Delphi 10 Seattle }
    {$DEFINE LEVELD10 }
  {$IFEND}
  {$IF Defined(VER290) or Defined(LevelD10)} { Delphi XE8 }
    {$DEFINE LEVELXE8 }
  {$IFEND}
  {$IF Defined(VER280) or Defined(LevelXE8)} { Delphi XE7 }
    {$DEFINE LEVELXE7 }
  {$IFEND}
  {$IF Defined(VER270) or Defined(LevelXE7)} { Delphi XE6 }
    {$DEFINE LEVELXE6 }
  {$IFEND}
  {$IF Defined(VER260) or Defined(LevelXE6)} { Delphi XE5 }
    {$DEFINE LEVELXE5 }
  {$IFEND}
  {$IF Defined(VER250) or Defined(LevelXE5)} { Delphi XE4 }
    {$DEFINE LEVELXE4 }
  {$IFEND}
  {$IF Defined(VER240) or Defined(LevelXE4)} { Delphi XE3 }
    {$DEFINE LEVELXE3 }
  {$IFEND}
  {$IF Defined(VER230) or Defined(LevelXE3)} { Delphi XE2 }
    {$DEFINE LEVELXE2 }
  {$IFEND}
  {$IF Defined(VER220) or Defined(LevelXE2)} { Delphi XE }
    {$DEFINE LEVELXE }
  {$IFEND}
  {$IF Defined(VER210) or Defined(LevelXE)} { Delphi 2010 }
    {$DEFINE LEVEL2010 }
  {$IFEND}
  {$IF Defined(VER200) or Defined(Level2010)} { Delphi 2009 }
    {$DEFINE LEVEL2009 }
  {$IFEND}
  {$IF Defined(VER190) or Defined(Level2009)} { Delphi 2007 }
    {$DEFINE LEVEL2007 }
  {$IFEND}
  {$IF Defined(VER180) or Defined(Level2007)} { Delphi 2006 }
    {$DEFINE LEVEL2006 }
  {$IFEND}
  {$IF Defined(VER170) or Defined(Level2006)} { Delphi 2005 }
    {$DEFINE LEVEL2005 }
  {$IFEND}
  {$IF Defined(VER160) or Defined(Level2005)} { Delphi 8.0 }
    {$DEFINE LEVEL8 }
  {$IFEND}
  {$IF Defined(VER150) or Defined(Level8)} { Delphi 7.0 }
    {$DEFINE LEVEL7 }
  {$IFEND}
  {$IF Defined(VER140) or Defined(Level7)} { Delphi 6.0/C++Builder 6.0 }
    {$DEFINE LEVEL6 }
  {$IFEND}
  {$DEFINE LEVEL5 }
  {$DEFINE LEVEL4 }
{$ENDIF}
{$IFDEF BCB}
  {$DEFINE CBUILDER }
{$ELSE}
  {$DEFINE DELPHI }
{$ENDIF}