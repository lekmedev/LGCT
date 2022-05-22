#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557



Func ClickIntoPB()
	While 1
		If _imgSearch("do") Then
			MouseMove($x, $y)
			_CtrlClickImg($x, $y)
			_CtrlClickImg($x, $y)
			_CtrlClickImg($x, $y)
			_ClickUtilSeeImg("iconDay", 135, 284)
			Mbox("done")
			_ClickUtilSeeImg("do", 247, 164)
		EndIf
	WEnd
EndFunc   ;==>PB

Func Pban()


	EndFunc
;~ AutoMain()


;~ 247, 164





;~  _checkTQ()
;~ _RegClone()
;~ _Clone()
