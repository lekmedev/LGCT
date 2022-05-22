#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:3; CLASS:LDPlayerMainFrame]")
$port = 5559
;~ _RegClone()


;~ GateCard()

;~ _ClickUtilSeeImg("searchTiec", 187, 190, 1000)
;~ 	Sleep(700)
;~ While 1
;~ 	If _imgSearch("kTiec") = 1 Then
;~ 		$motiec = 1
;~ 			Return
;~ 		Mbox("11")
;~ 	EndIf
;~ WEnd
;~ AutoMain()



;~ Mbox("Tiec")
$iniFileToTiec = (IniRead("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec"&StringTrimRight((StringTrimLeft(@ScriptName,16)),4)&".ini","A","IDtiec",0))
_AnTiec()