#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

;~ if _imgSearch("inQuestVT") = 1 Then
;~ 	mbox("1")
;~ 	EndIf

;~ _ADB_CMD("input swipe 690 233 460 233 350", $port)
;~ 	_ADB_CMD("input swipe 460 233 460 233 550", $port)
;~ 	Sleep(1000)
;~ AdlibRegister("_ClearApp", 30000)
;~ 	While 1
;~ 		Sleep(100)
;~ 		If _imgSearch("chtr") = 1 Then
;~ 			_CtrlClickInGame($x + 65, $y)
;~ 			Mbox("Click")
;~ 		EndIf
;~ 	WEnd
;~ Ctruong()
;~ AutoMain()


_BossWar()