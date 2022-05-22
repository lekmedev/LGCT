#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557


ClickIntoPB()

Func ClickIntoPB()
	for $j = 1 to 12
	For $i = 1 to 14
		Sleep(30)
		_CtrlClickInGame($i*18, 360)
	Next
	next
EndFunc   ;==>ClickIntoPB
139
12
;~ AutoMain()








;~  _checkTQ()
;~ _RegClone()
;~ _Clone()
