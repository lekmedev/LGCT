#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

ClickIntoPB()


Func ClickIntoPB()
	While 1
		If _imgSearch("do",0 ,0 , 280, 395) or _imgSearch("Boss") Then
			MouseMove($x + 10, $y + 10)
			_CtrlClickImg($x + 10, $y + 10)
			_CtrlClickImg($x + 10, $y + 10)
			_CtrlClickImg($x + 10, $y + 10)
			Pban()
		EndIf
	WEnd
EndFunc   ;==>ClickIntoPB

Func Pban()
	While 1
		Sleep(100)
;~ 		If _imgSearch("skippb") Then
			_ClickUtilSeeImg("do", 249, 168)
;~ 			Return
;~ 		EndIf
	WEnd
EndFunc   ;==>Pban

;~ 249, 168
;~ AutoMain()


;~ 247, 164





;~  _checkTQ()
;~ _RegClone()
;~ _Clone()
