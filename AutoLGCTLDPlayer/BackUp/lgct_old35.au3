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
;~ SungBaiLSV($WindowHandle[1][1])
;~ _DoiTK($WindowHandle[1][1])
AutoMain($WindowHandle[1][1])
Func AutoMain($WindowHandle = Default)
	$WindowHandle = HWnd($WindowHandle)
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	;MsgBox(0,$fileIni,$fileList)
	_Wait4Image($WindowHandle, "iconGame")
	;_Wait4Image($WindowHandle, "iconDay")
;~ 	Doi sv list
	;_OKIF($WindowHandle, "iconListServer")
	Local $p = WinGetTitle($WindowHandle)
		Local $splitted = StringSplit($p, "- ")
		Local $port = Number(StringTrimRight($splitted[2], 1))
	For i = 1 To _FileCountLines($fileList)
		_OKIF($WindowHandle, "iconDay")

		Sleep(100)
		_DoiTK($WindowHandle)
		_ThinhAn($WindowHandle)
		ExitToLog($WindowHandle, $port)
	Next
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
	_ClickUtilSeeImg($WindowHandle, "iconBlueDTK", 32, 189)
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
	Sleep(150)
	_OKIF($WindowHandle, "iconTrangTri")
	_CtrlClick($WindowHandle, 264, 19)

EndFunc   ;==>_DoiTK

Func _ThinhAn($WindowHandle)
	;ULTI SEE EMAIL
	_OKIF($WindowHandle, "iconEmail")
	Sleep(100)
	_CtrlClick($WindowHandle, 200, 200)
	_OKIF($WindowHandle, "iconInHoangCung")
	;_Wait4Image($WindowHandle, "iconInHoangCung") ; khang hy phu
	_CtrlClick($WindowHandle, 181, 335)
	_ClickUtilSeeImg($WindowHandle, "iconDaNhan", 228, 489)
	_ClickUtilSeeImg($WindowHandle, "iconXepHang", 253, 21)
	;_OKIF($WindowHandle, "iconXepHang")
	_CtrlClick($WindowHandle, 206, 475)
	_OKIF($WindowHandle, "iconInBangXepHang")
	;Mbox("in bxh")
	_CtrlClick($WindowHandle, 104, 191)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBai", 227, 441) ;Bang TL
	Sleep(150)
	_ClickUtilSeeImg($WindowHandle, "iconInBangPB", 99, 54)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBai", 227, 441) ;Bang PB
	Sleep(150)
	_ClickUtilSeeImg($WindowHandle, "iconInBangTM", 167, 55)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBai", 227, 441) ;Bang TM

;~ 	khu vuc sung bai bxh
	SungBaiLSV($WindowHandle)

;~ 	safsdf
;~ 	_ClickUtilSeeImg($WindowHandle,"iconXepHang", 228, 489)
;~ 	If IniRead($fileIni, "General", "SV", 0) = "SV358" Then
;~ 		Wait4Img('BTVphu.bmp', 756, 695)
;~ 	ElseIf IniRead($fileIni, "General", "SV", 0) = "SV356" Then
;~ 		Wait4Img('BTVphu.bmp', 756, 695)
;~ 	ElseIf IniRead($fileIni, "General", "SV", 0) = "SV284" Then
;~ 		Wait4Img('BTVphu.bmp', 734, 522)
;~ 		OKIF("QuanPham", 465, 722, 496, 744)
;~ 		MsgBox(0, "", "see", 1)
;~ 		If Not _ImageSearchArea('Data\Images\thuan.bmp', 1, 633, 204, 683, 257, $x7, $y7, 40) = 1 Then
;~ 			MouseClick("left", 832, 395, 1, 0)
;~ 			MsgBox(0, "", "see2", 1)
;~ 		EndIf
;~ 		Wait4Img('BTVphu.bmp', 537, 571)
;~ 	Else
;~ 		Wait4Img('BTVphu.bmp', 724, 642)
;~ 	EndIf

EndFunc   ;==>_ThinhAn

Func SungBaiLSV($WindowHandle)
	Sleep(500)
	_CtrlClick($WindowHandle, 258, 15)
	_OKIF($WindowHandle, "iconInBangXepHang")
	_CtrlClick($WindowHandle, 219, 238)
	Sleep(150)
	;_ClickUtilSeeImg($WindowHandle, "inTlLSV", 218, 440)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBaiLSV", 227, 441) ;Bang TM
	Sleep(150)
	_ClickUtilSeeImg($WindowHandle, "inTlLSV", 183, 59)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBaiLSV", 227, 441) ;Bang TM
;~  	_CtrlClick($backHandle,279+14, 392)
	;Mbox("Done")
;~ 	Mbox(WinGetHandle("[TITLE:"&WinGetTitle($WindowHandle)&"; CLASS:Qt5QWindowIcon; INSTANCE:7]"))
EndFunc   ;==>SungBaiLSV
;187 app switch, 4 back , 3 home
















Func ExitToLog($WindowHandle, $port)
	_ADB_CMD("input keyevent 4", $port)
	Sleep(300)
	_CtrlClick($WindowHandle, 81, 270)
EndFunc   ;==>ExitToLog

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

Func _Wait4Image($WindowHandle, $bmp)
	Sleep(100)
	While 1
		Local $Result
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 10, 100)
		If Not @error Then
			Sleep(100)
			ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
			Return
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func _ClickUtilSeeImg($WindowHandle, $bmp, $x, $y)
	While 1
		Sleep(100)

		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
		_CtrlClick($WindowHandle, $x, $y)
	WEnd

EndFunc   ;==>_ClickUtilSeeImg

Func Mbox($ndung)
	MsgBox(0, "", $ndung)

EndFunc   ;==>Mbox

Func Terminate()
	Exit
EndFunc   ;==>Terminate
