#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555
	Mbox(@ScriptName)
	If ProcessExists("AutoLDPlayer1.au3") Then
		Mbox(@ScriptName)
		Exit
	EndIf

































AutoMain($WindowHandle, $port)