#include "HandleImgSearch.au3"

Local $WindowHandle = WinList("[CLASS:LDPlayerMainFrame]")
;MsgBox(0,$WindowHandle[1][0],$WindowHandle[1][1])
;MsgBox(0,$WindowHandle[2][0],$WindowHandle[2][1])
;_TestHandle(10,$WindowHandle[1][1])
while 1
	Local $Result
_HandleImgSearch($WindowHandle, @ScriptDir & "\Images\lgct.bmp", 0, 0, -1, -1, 100, 100)
ControlClick($WindowHandle,"","","left",1,$Result[1][0],$Result[1][1])
WEnd


Func _TestHandle($Count, $Handle = "")
	$_HandleImgSearch_IsDebug = True
	Local $Result
	For $i = 1 to $Count
		$Result = _HandleImgSearch($Handle, @ScriptDir & "\Images\lgct.bmp", 0, 0, -1, -1, 100, 100)
		If not @error Then
			ConsoleWrite("_HandleImgSearch (Total: " & $Result[0][0] & "): " & $Result[1][0] &" - " & $Result[1][1] & @CRLF)
			ControlClick($Handle,"","","left",1,$Result[1][0],$Result[1][1])
		EndIf
		Sleep(10)
		exit
	Next
EndFunc