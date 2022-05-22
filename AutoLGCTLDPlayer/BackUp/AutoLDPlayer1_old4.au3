#include "lgct.au3"
#include <SendMessage.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

While 1
	ControlSend($WindowHandle, "", "", "{DEL 4}")
		Sleep($slp)
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
	WEnd

AutoMain($WindowHandle, $port)


