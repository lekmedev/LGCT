#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

;~ If _imgSearch("dd") = 1 Then
;~ 			_CtrlClickImg($x, $y )
;~ 			_CtrlClickImg($x , $y )
;~ EndIf
;~ _AnTiec()
;~ AutoMain()
;~ codeTT()
;~ _RegClone()
;~ Pban()
while 1
		Sleep(50)
		_CtrlClickInGame(255, 66, 1)
		Sleep(300)
		_CtrlClickInGame(99, 231, 1)
		Sleep(50)
		_CtrlClickInGame(91, 371, 1)
		Sleep(50)
		_CtrlClickInGame(132, 151, 1)
		Sleep(50)
		_CtrlClickInGame(194, 167, 1)
		Sleep(50)
		_CtrlClickInGame(75, 206, 1)
		Sleep(50)
		_CtrlClickInGame(37, 362, 1)
		Sleep(50)
		_CtrlClickInGame(131, 305, 1)
		Sleep(50)
		_CtrlClickInGame(249, 165, 1)
		Sleep(50)
		_CtrlClickInGame(189, 250, 1)
		if _imgSearch("donepb") Then
			mbox("1")
			EndIf
	WEnd