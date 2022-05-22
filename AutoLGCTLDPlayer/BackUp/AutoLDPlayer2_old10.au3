#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557


ClickIntoPB()

Func ClickIntoPB()
	For $i = 5 To 1 Step -1
    MsgBox($MB_SYSTEMMODAL, "", "Count down!" & @CRLF & $i)
Next



EndFunc   ;==>ClickIntoPB


;~ AutoMain()








;~  _checkTQ()
;~ _RegClone()
;~ _Clone()
