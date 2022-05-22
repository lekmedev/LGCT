#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

_Wait4Image($WindowHandle, "HGicon")
_OKIF($WindowHandle, "HGin")
local $a=TimerInit()
While 1
		If _imgSearch($WindowHandle, "HGred",0,0,-1,-1) = 1 Then
;~ 			Mbox("iconDay")
			_CtrlClick($WindowHandle, $x, $y+10)
			Sleep(200)

			Return
		EndIf
WEnd



AutoMain($WindowHandle, $port)
