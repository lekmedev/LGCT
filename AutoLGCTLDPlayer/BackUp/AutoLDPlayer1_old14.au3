#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

_Wait4Image($WindowHandle, "HGicon")
_OKIF($WindowHandle, "HGin")
Local $a = TimerInit()
While 1
	If _imgSearch($WindowHandle, "HGred") = 1 Then
		_CtrlClick($WindowHandle, $x + 140, $y + 30)
		Sleep(500)
		Local $a1 = TimerInit()
		While 1
			If _imgSearch($WindowHandle, "HGnhan") = 1 Then
				_CtrlClick($WindowHandle, $x, $y)
				Sleep(200)
				Exit
			EndIf
			If TimerDiff($a) > 1000 Then
		ExitLoop
	EndIf
		WEnd
		Sleep(100)
		ExitLoop
	EndIf
	If TimerDiff($a) > 2000 Then
		ExitLoop
	EndIf
WEnd


AutoMain($WindowHandle, $port)
