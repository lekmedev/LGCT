#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

;~ _CHBang()
If _imgSearchW("netVT", 1000) = 0 or _imgSearchW("pbang", 1000) = 0  Then
		_CtrlClickInGame(235, 420)
		Sleep(1000)
	Else
		_ADB_CMD("input swipe 528 1081 528 890 300", $port)
		Sleep(1000)
		_CtrlClickInGame(44, 416)
		Sleep(1000)
	EndIf
;~ AutoMain()
