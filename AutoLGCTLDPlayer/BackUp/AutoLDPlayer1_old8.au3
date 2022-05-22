#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

_CtrlClickInGame($WindowHandle, 205, 189)
	Sleep(200)
	ControlSend($WindowHandle, "", "", "{BS 20}")

;~ 	_CtrlClickInGame($WindowHandle, 39, 191)
;~ 	_OKIF($WindowHandle, "iconBS",67,221,75-67,230-221)
;~ 	Mbox("bs")
;~ 	Sleep(1000)
;~ 	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input text '& $infoAcc[1] &'', "", @SW_HIDE)
;~ 	Sleep(800)
	ControlSend($WindowHandle, "", "", $infoAcc[1])

;~ AutoMain($WindowHandle, $port)
