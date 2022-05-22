#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:3; CLASS:LDPlayerMainFrame]")
$port = 5559

if _ReadIni(@ScriptDir & "\Data\Account\Tiec\file" & WinGetTitle($WindowHandle) & ".ini", "General", "TK", 1) <> "" then
_AnTiec()
Else
AutoMain()
EndIf