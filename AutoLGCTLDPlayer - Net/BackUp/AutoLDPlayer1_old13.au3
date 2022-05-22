#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

_Wait4Image($WindowHandle, "HGicon")
_OKIF($WindowHandle, "HGin")
Local $a = TimerInit()
While 1
	If _imgSearch($WindowHandle, "HGred") = 1 Then
		_CtrlClick($WindowHandle, $x+140,$y+30)
		Sleep(200)
	While 1
		If _imgSearch($WindowHandle, $bmp,$top,$left,$bot,$right) = 1 Then
;~ 			Mbox("iconDay")
			_CtrlClick($WindowHandle, $x, $y)
			Sleep(200)

			Return
		EndIf
	WEnd
		Sleep(100)
		ExitLoop
	EndIf
	if TimerDiff($a) > 2000 Then
		ExitLoop
	EndIf
WEnd


AutoMain($WindowHandle, $port)
