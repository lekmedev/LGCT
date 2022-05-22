#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

_ADB_CMD("input swipe 63 1274 62 299 110", $port)
_ADB_CMD("input swipe 63 1274 62 299 110", $port)
Sleep(1000)
_ADB_CMD("input swipe 62 312 63 900 550", $port)
_ADB_CMD("input swipe 63 900 63 900 550", $port)

If _imgSearch("HungBang") = 1 Then
	For $i = 1 To 23
	_CtrlClickImg($x+54, $y+39)

Next

EndIf
