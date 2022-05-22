#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:10; CLASS:LDPlayerMainFrame]")
$port = 5573
;~ _RegClone()


;~ GateCard()



;~ AutoMain()



;~ Mbox("Tiec")
$iniFileToTiec = (IniRead("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec"&StringTrimRight((StringTrimLeft(@ScriptName,16)),4)&".ini","A","IDtiec",0))
_AnTiec()