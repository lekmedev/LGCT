#include "HandleImgSearch.au3"
HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("1. hanhpham19791 1904")

While 1
	Local $Result
	$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Images\lgct.bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		Sleep(100)
		ControlClick($WindowHandle, "", "", "left", 2, $Result[1][0], $Result[1][1])
		_nextError($WindowHandle,"day")
	EndIf
	Sleep(100)
WEnd

Func OKIF($hwnd, $bmp)
	While 1
		_HandleImgSearch($hwnd, @ScriptDir & "\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
		If Not @error Then
			Exit
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>OKIF

Func _nextError($hwnd, $bmp)
	_HandleImgSearch($hwnd, @ScriptDir & "\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		Exit
	EndIf
EndFunc   ;==>Wait4Img

Func ControlClickDrag($wHandle, $Button="left", $X1="", $Y1="", $X2="", $Y2="")
   Local $MK_LBUTTON  = 0x0001
   Local $WM_LBUTTONDOWN  = 0x0201
   Local $WM_LBUTTONUP  = 0x0202
   Local $MK_RBUTTON  = 0x0002
   Local $WM_RBUTTONDOWN  = 0x0204
   Local $WM_RBUTTONUP  = 0x0205
   Local $WM_MOUSEMOVE  = 0x0200
   Local $i = 0
   Select
Case $Button = "left"
$Button  = $MK_LBUTTON
$ButtonDown  = $WM_LBUTTONDOWN
$ButtonUp  = $WM_LBUTTONUP
Case $Button = "right"
$Button  = $MK_RBUTTON
$ButtonDown  = $WM_RBUTTONDOWN
$ButtonUp  = $WM_RBUTTONUP
   EndSelect
   DllCall("user32.dll", "int", "SendMessage", "hwnd", $wHandle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X1, $Y1))
   DllCall("user32.dll", "int", "SendMessage", "hwnd", $wHandle, "int", $ButtonUp, "int", $Button, "long", _MakeLong($X2, $Y2))
EndFunc

Func _MakeLong($LoWord,$HiWord)
Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc


Func Terminate()
    Exit
EndFunc   ;==>Terminate