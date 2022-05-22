#include "HandleImgSearch.au3"

Local $WindowHandle = WinGetHandle("1. hanhpham19791 1904")

While 1
	Local $Result
	$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Images\lgct.bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
		Exit
	EndIf
	Sleep(100)
WEnd

Func OKIF($hwnd, $bmp)
	while 1
	_HandleImgSearch($WindowHandle, @ScriptDir & "\Images\day.bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		Exit
	EndIf
	Sleep(100)
	WEnd
EndFunc   ;==>OKIF
