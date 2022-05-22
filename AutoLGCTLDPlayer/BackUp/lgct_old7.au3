#include "HandleImgSearch.au3"

Local $WindowHandle = WinGetHandle("1. hanhpham19791 1904")

While 1
	Local $Result
	$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Images\lgct.bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		Sleep(100)
		ControlClick($WindowHandle, "", "", "left", 2, $Result[1][0], $Result[1][1])
		If _HandleImgSearch($WindowHandle, @ScriptDir & "\Images\lgct.bmp", 0, 0, -1, -1, 100, 100) = 0 Then
			Exit

		EndIf
	EndIf
	Sleep(100)
WEnd

Func OKIF($hwnd, $bmp)
	While 1
		_HandleImgSearch($hwnd, @ScriptDir & "\Images\"&$bmp&".bmp", 0, 0, -1, -1, 100, 100)
		If Not @error Then
			Exit
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>OKIF
