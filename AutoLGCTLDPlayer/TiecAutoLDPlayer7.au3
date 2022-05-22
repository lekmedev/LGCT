#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:7; CLASS:LDPlayerMainFrame]")
$port = 5567
;~ _RegClone()


;~ GateCard()



;~ AutoMain()

;~ While 1
;~ 		If _imgSearch("xntiec") Then
;~ 			Sleep(1000)
;~ 			_CtrlClickInGame(257, 21)
;~ 			Sleep(1000)
;~ 			_CtrlClickInGame(139, 89)
;~ 			Sleep(2000)
;~ 			_CtrlClickInGame(224, 232)
;~ 			ExitLoop
;~ 		ElseIf _imgSearch("xntiec2") Then
;~ 			Sleep(2000)
;~ 			_CtrlClickInGame(224, 232)
;~ 			ExitLoop
;~ EndIf

;~ Mbox("Tiec")
$iniFileToTiec = (IniRead("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec"&StringTrimRight((StringTrimLeft(@ScriptName,16)),4)&".ini","A","IDtiec",0))
_AnTiec()