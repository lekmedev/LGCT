#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

$iniFileToTiec = (IniRead("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec"&StringTrimRight((StringTrimLeft(@ScriptName,16)),4)&".ini","A","IDtiec",0))
_AnTiec()