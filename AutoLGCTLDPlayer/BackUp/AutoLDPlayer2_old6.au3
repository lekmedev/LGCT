#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557



Func ClickIntoPB()
	While 1
		If _imgSearch("do") Then
			MouseMove($x+10, $y+10)
			_CtrlClickImg($x+10, $y+10)
			_CtrlClickImg($x+10, $y+10)
			_CtrlClickImg($x+10, $y+10)
		EndIf
	WEnd
EndFunc   ;==>ClickIntoPB

Func Pban()
	while 1
		Sleep(100)

		If _imgSearch("skippb") Then
			Return
			EndIf
		_CtrlClickInGame(249, 168)
	WEnd
EndFunc   ;==>Pban

249, 168
;~ AutoMain()


;~ 247, 164





;~  _checkTQ()
;~ _RegClone()
;~ _Clone()
