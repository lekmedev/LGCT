#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

;~ AutoMain($WindowHandle, $port)
While 1
		Local $a = TimerInit()
		While 1
			Sleep(1500)
			If _imgSearch($WindowHandle, "vaoBan") = 1 Then
				MsgBox(0, "", "", 1)
				_CtrlClickInGame($WindowHandle, $x, $y)
				_OKIF($WindowHandle, "cachDuTiec")
				Sleep(500)
				_CtrlClickInGame($WindowHandle, 222, 221)
				Exit
			EndIf
			If TimerDiff($a) > 3000 Then
				MsgBox(0, "", "", 1)
				ExitLoop
			EndIf
		WEnd

		_ADB_CMD("input swipe 648 850 648 580 1500", $port)
	WEnd
;~ _AnTiec($WindowHandle, $port)