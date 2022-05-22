#include "Data\UDF\HandleImgSearch.au3"
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include "Data\UDF\CoProc.au3"

HotKeySet("{ESC}", "Terminate")
Global $WindowHandle = WinList("[CLASS:LDPlayerMainFrame]")

;_CoProc("AutoMain",$WindowHandle[2][1])
_CoProc("AutoMain",$WindowHandle[1][1])


;AutoMain($WindowHandle[1][1])





Func AutoMain($WindowHandle = Default)
	Local $fileIni = @ScriptDir & "\Data\file.ini", $fileList = @ScriptDir & "\AutoList.txt"
	$WindowHandle= HWnd($WindowHandle)
	MsgBox(0,"",WinGetTitle($WindowHandle))
	_Wait4Image($WindowHandle, "lgct")
EndFunc   ;==>AutoMain

Func _Wait4Image($WindowHandle, $bmp)
	Sleep(100)
	While 1
		Local $Result
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
		If Not @error Then
			;Sleep(100)
			ControlClick($WindowHandle, "", "", "left", 2, $Result[1][0], $Result[1][1])
			;_nextError($WindowHandle, $nextbmp)
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func OKIF($hwnd, $bmp)
	While 1
		$pos = _HandleImgSearch($hwnd, @ScriptDir & "\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
		If Not @error Then
			Return $pos
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

Func ADB($WindowHandle = "")
	Global $Nox_Path = "C:\Program Files\ChangZhi\LDPlayer"
	$DOS = Run($Nox_Path & "\adb.exe devices", $Nox_Path, @SW_SHOW, $STDERR_MERGED)
	While 1
		Sleep(50)
		If @error Or Not ProcessExists($DOS) Then ExitLoop
	WEnd
	$Message = StdoutRead($DOS)
	MsgBox(0, '', $Message)
EndFunc   ;==>ADB





























;---------------------------
Func ControlClickDrag($wHandle, $X1 = "", $Y1 = "", $X2 = "", $Y2 = "", $Button = "left")
	Local $MK_LBUTTON = 0x0001
	Local $WM_LBUTTONDOWN = 0x0201
	Local $WM_LBUTTONUP = 0x0202
	Local $MK_RBUTTON = 0x0002
	Local $WM_RBUTTONDOWN = 0x0204
	Local $WM_RBUTTONUP = 0x0205
	Local $WM_MOUSEMOVE = 0x0200
	Local $i = 0
	Select
		Case $Button = "left"
			$Button = $MK_LBUTTON
			$ButtonDown = $WM_LBUTTONDOWN
			$ButtonUp = $WM_LBUTTONUP
		Case $Button = "right"
			$Button = $MK_RBUTTON
			$ButtonDown = $WM_RBUTTONDOWN
			$ButtonUp = $WM_RBUTTONUP
	EndSelect
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $wHandle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X1, $Y1))
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $wHandle, "int", $ButtonUp, "int", $Button, "long", _MakeLong($X2, $Y2))
EndFunc   ;==>ControlClickDrag

Func _MakeLong($LoWord, $HiWord)
	Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc   ;==>_MakeLong


Func Terminate()
	Exit
EndFunc   ;==>Terminate
