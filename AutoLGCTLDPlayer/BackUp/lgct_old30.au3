#include "Data\UDF\HandleImgSearch.au3"
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include "Data\UDF\CoProc.au3"
#include "Data\UDF\AndroidUDF\Android.au3"

HotKeySet("{ESC}", "Terminate")
Global $WindowHandle = WinList("(MEmu -")

;~ For $i = 1 To $WindowHandle[0][0]
;~ 	_CoProc("AutoMain", $WindowHandle[$i][1])
;~ Next

;_Wait4Image($WindowHandle[1][1], "iconNewMail")

;~ _ThinhAn($WindowHandle[1][1])
;~ _DoiTK($WindowHandle[1][1])
;~ AutoMain($WindowHandle[1][1])
Func AutoMain($WindowHandle = Default)
	$WindowHandle = HWnd($WindowHandle)
	Local $fileIni = @ScriptDir & "\Data\file.ini", $fileList = @ScriptDir & "\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	_Wait4Image($WindowHandle, "iconGame")
	;_Wait4Image($WindowHandle, "iconDay")
;~ 	Doi sv list
	;_OKIF($WindowHandle, "iconListServer")
	_OKIF($WindowHandle, "iconDay")
	Local $p = WinGetTitle($WindowHandle)
	Local $splitted = StringSplit($p, "- ")
	Local $port = Number(StringTrimRight($splitted[2], 1))
	Sleep(100)
	_DoiTK($WindowHandle)
	;Scrolllll
	;_ADB_CMD("input swipe 200 800 200 650 1000", $port)

EndFunc   ;==>AutoMain

Func _DoiTK($WindowHandle)
	_OKIF($WindowHandle, "iconDay")
	_Wait4Image($WindowHandle, "iconDTK")
	;_Wait4Image($WindowHandle, "iconFB")
	_OKIF($WindowHandle, "iconFB")
;~ 	Mbox("asdfs")
	_CtrlClick($WindowHandle, 134, 288)
	Sleep(500)
	_OKIF($WindowHandle, "iconTK")
	Sleep(500)
;~ 	Nhap tai khoan
;~
;~ 	Nhap mat khau
;~
	;click dang nhap khi nhap mat khau
	_CtrlClick($WindowHandle, 137, 295)
	Sleep(100)
	_OKIF($WindowHandle, "iconDay")
	Sleep(100)
	_CtrlClick($WindowHandle, 136, 425)
	Sleep(100)
	_Wait4Image($WindowHandle, "iconPopup")
EndFunc   ;==>_DoiTK

Func _Wait4Image($WindowHandle, $bmp, $x1 = 0, $x2 = 0, $x3 = -1, $x4 = -1)
	Sleep(100)
	While 1
		Local $Result
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", $x1, $x2, $x3, $x4, 10, 100)
		If Not @error Then
			Sleep(100)
			ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
			Return
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func _OKIF($hwnd, $bmp)
	While 1
		_HandleImgSearch($hwnd, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_OKIF

Func _nextError($hwnd, $bmp)
	_HandleImgSearch($hwnd, @ScriptDir & "\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 100, 100)
	If Not @error Then
		Exit
	EndIf
EndFunc   ;==>_nextError

Func _CtrlClick($WindowHandle, $x, $y)
	;MsgBox(0,"","")
	$WindowHandle = HWnd($WindowHandle)
	ControlClick($WindowHandle, "", "", "left", 1, $x, $y + 31)
	Sleep(200)
	;ControlClick($WindowHandle, "", "", "left", 1, $x, $y)
EndFunc   ;==>_CtrlClick

Func _ADB_CMD($command, $port)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:215' & $port & '3 shell ' & $command, "", @SW_HIDE)
EndFunc   ;==>_ADB_CMD


Func _ThinhAn($WindowHandle)
	;ULTI SEE EMAIL
	_OKIF($WindowHandle, "iconEmail")
;~ 	Mbox("ssss")
	Sleep(100)
	_CtrlClick($WindowHandle, 200, 200)

EndFunc   ;==>_ThinhAn

Func _ClickUtilSeeImg($WindowHandle,$bmp, $x, $y)
	While 1
		Sleep(100)
		_CtrlClick($WindowHandle, $x, $y)
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
	WEnd

EndFunc   ;==>_LoopUtilImg

Func Mbox($ndung)
	MsgBox(0, "", $ndung)
EndFunc   ;==>Mbox

















;---------------------------
Func _CtrlClickDrag($wHandle, $x1 = "", $Y1 = "", $x2 = "", $Y2 = "", $Button = "left")
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

	DllCall("user32.dll", "int", "SendMessage", "hwnd", $wHandle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($x1, $Y1))
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $wHandle, "int", $ButtonUp, "int", $Button, "long", _MakeLong($x2, $Y2))
EndFunc   ;==>_CtrlClickDrag



Func _MakeLong($LoWord, $HiWord)
	Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc   ;==>_MakeLong

Func Terminate()
	Exit
EndFunc   ;==>Terminate
