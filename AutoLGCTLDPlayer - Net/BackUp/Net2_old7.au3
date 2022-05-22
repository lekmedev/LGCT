#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

;~ _CHBang()
Func ShareLGCT()
;~ 	Mbox("1")
	while 1
	_ADB_CMD("input swipe 250 1100 250 520  1060", $port)
	_ADB_CMD("input tap 250 520", $port)
	WEnd
EndFunc


ShareLGCT()

;~ AutoMain()
