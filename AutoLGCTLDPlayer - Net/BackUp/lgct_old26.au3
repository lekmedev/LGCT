#include "Data\UDF\HandleImgSearch.au3"
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include "Data\UDF\CoProc.au3"
#RequireAdmin
HotKeySet("{ESC}", "Terminate")
Global $WindowHandle = WinList("(MEmu")
;MsgBox(0,"",$WindowHandle[0][0])
_CtrlClickDrag($WindowHandle[1][1],101, 323,101, 221)
For $i = 1 To $WindowHandle[0][0]
	_CoProc("AutoMain", $WindowHandle[$i][1])
Next

Func AutoMain($WindowHandle = Default)
	$WindowHandle = HWnd($WindowHandle)
	Local $fileIni = @ScriptDir & "\Data\file.ini", $fileList = @ScriptDir & "\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	_Wait4Image($WindowHandle, "iconGame")
	_Wait4Image($WindowHandle, "iconDay")
	_OKIF($WindowHandle,"iconListServer")
	MsgBox(0,"","1")
	_CtrlClick($WindowHandle, 93, 349)
	;
	_CtrlClickDrag($WindowHandle,101, 323,101, 221)
EndFunc   ;==>AutoMain

Func _Wait4Image($WindowHandle, $bmp)
	Sleep(100)
	While 1
		Local $Result
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 10, 100)
		If Not @error Then
			Sleep(1100)
			_CtrlClick($WindowHandle, $Result[1][0], $Result[1][1])
			Return
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func _OKIF($hwnd, $bmp)

	While 1
		_HandleImgSearch($hwnd, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>OKIF

Func _nextError($hwnd, $bmp)
	_HandleImgSearch($hwnd, @ScriptDir & "\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		Exit
	EndIf
EndFunc   ;==>_nextError

Func _CtrlClick($WindowHandle, $x, $y)
	;MsgBox(0,"","")
	$WindowHandle=HWnd($WindowHandle)
	ControlClick($WindowHandle, "", "", "left", 1, $x, $y)
	Sleep(200)
	ControlClick($WindowHandle, "", "", "left", 1, $x, $y)
EndFunc   ;==>_CtrlClick




























;---------------------------
Func _CtrlClickDrag($wHandle, $Button="left", $X1="", $Y1="", $X2="", $Y2="")
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
