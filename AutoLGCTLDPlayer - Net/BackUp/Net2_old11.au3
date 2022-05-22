#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

_ADB_CMD("input swipe 63 1274 62 299 110", $port)
_ADB_CMD("input swipe 63 1274 62 299 110", $port)
Sleep(1000)
_ADB_CMD("input swipe 62 312 63 900 550", $port)
_ADB_CMD("input swipe 63 900 63 900 550", $port)
Sleep(300)
_ADB_CMD("input swipe 62 312 63 316 550", $port)
_ADB_CMD("input swipe 63 316 63 316 550", $port)
Sleep(300)
_OKIF("HungBang")
If _imgSearch("maxHB") = 1 Then
		While 1
	_CtrlClickImg($x + 54, $y + 39)
	Sleep(500)
	If _imgSearch("maxHB") = 1 Then
		ExitLoop
	EndIf
WEnd
EndIf


