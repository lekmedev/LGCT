#include-once
#include "Data\UDF\HandleImgSearch.au3"
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include "Data\UDF\CoProc.au3"
#include "Data\UDF\AndroidUDF\Android.au3"
#include <File.au3>
;~ HotKeySet("{ESC}", "Terminate")
Global $port, $x, $y, $WindowHandle, $tenTK, $iniFile, $iGlobal, $iGlobal1

Func AutoMain($WindowHandle1, $port1)
	$port = $port1
;~ 	Mbox($port)
	AdlibRegister("_ClearApp", 30000)
	Global $WindowHandle = $WindowHandle1
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	$iniFile = $fileIni
	If ProcessExists(_ReadIni($fileIni, "General", "PID", 1)) Then ;Close PID
		ProcessClose(_ReadIni($fileIni, "General", "PID", 1))
	EndIf
	_Wait4Image($WindowHandle, "iconGame")
	_Start($WindowHandle, "iconFB", "iconDTK", "iconDay")
	Local $infoAcc, $samePWD
	$iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 	Local $port = 21503
;~ Mbox($iGlobal)
	For $iGlobal1 = $iGlobal To _FileCountLines($fileList)
;~   		Mbox($iGlobal1)
		AdlibRegister("_ClearApp", 30000)
;~ 		$iGlobal = $iGlobal
		$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")

		If $infoAcc[1] == '-' Then
			ContinueLoop
		EndIf
		$tenTK = $infoAcc[1]
		Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
		If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
			_OKIF($WindowHandle, "iconDay")
			Sleep(300)
;~ 			Local $aPos = WinGetPos($WindowHandle)
;~ 			_reSize($WindowHandle) aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
			_ClickUtilSeeImg($WindowHandle, "iconListServer", 91, 349)
			_ChonSV($WindowHandle, $infoAcc[1], $fileIni)
			If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				_WriteIni($fileIni, "General", "SVDAY", 0)
			EndIf
			If StringInStr($infoAcc[1], "SV", 1) Then
				ContinueLoop
			EndIf
		EndIf
;~ 		--------------------------------------------------------------------------------------------------------

		_DoiTK($WindowHandle, $infoAcc, $samePWD) ;Doi Tai Khoan
		$samePWD = $infoAcc[2] ; Check Same Password
		_ThinhAn($WindowHandle) ; Done Sung Bai Thinh An
		_WriteIni($fileIni, "General", "BienI", $iGlobal1 + 1)
		ExitToLog($WindowHandle, $port)
	Next
EndFunc   ;==>AutoMain

Func _DoiTK($WindowHandle, $infoAcc, $samePWD)
	_OKIF($WindowHandle, "iconDay")
	_Wait4Image($WindowHandle, "iconDTK")
	;_Wait4Image($WindowHandle, "iconFB")
	_OKIF($WindowHandle, "iconFB")
;~ 	Mbox("asdfs")
	_CtrlClick($WindowHandle, 134, 288)
	Sleep(500)
	_OKIF($WindowHandle, "iconTK")

;~ 	Nhap tai khoan
;~ 	Mbox("1")
;~ 	_ClickUtilSeeImg($WindowHandle, "iconBlueDTK", 45, 188)
	_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 45, 188)
;~ 	Nhap mat khau
	Sleep(200)
;~ 	ClipPut($infoAcc[1])
	ControlSend($WindowHandle, "", "", $infoAcc[1])
	If Not ($samePWD = $infoAcc[2]) Then
;~ 	click passửod
		_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 32, 235)
;~ 	Nhap mat khau
;~ 		ClipPut($infoAcc[2])
		Sleep(200)
		ControlSend($WindowHandle, "", "", $infoAcc[2])
	EndIf

	;click dang nhap khi nhap mat khau
	_CtrlClick($WindowHandle, 137, 295)
	Sleep(100)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	_OKIF($WindowHandle, "iconDay")
	AdlibUnRegister("_checkPWD")
	Sleep(100)
	_CtrlClick($WindowHandle, 136, 425)
	Sleep(100)
	_Wait4Image($WindowHandle, "iconPopup")
	Sleep(150)
	_OKIF($WindowHandle, "iconTrangTri")
	_CtrlClick($WindowHandle, 264, 19)

EndFunc   ;==>_DoiTK

Func clone($WindowHandle, $infoAcc, $samePWD)
	_OKIF($WindowHandle, "iconThuong")
	_Wait4Image($WindowHandle, "iconDTK")
	;_Wait4Image($WindowHandle, "iconFB")
	_OKIF($WindowHandle, "iconFB")
;~ 	Mbox("asdfs")
	_CtrlClick($WindowHandle, 134, 288)
	Sleep(500)
	_OKIF($WindowHandle, "iconTK")

;~ 	Nhap tai khoan
;~ 	Mbox("1")
;~ 	_ClickUtilSeeImg($WindowHandle, "iconBlueDTK", 45, 188)
	_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 45, 188)
;~ 	Nhap mat khau
	Sleep(200)
;~ 	ClipPut($infoAcc[1])
	ControlSend($WindowHandle, "", "", $infoAcc[1])
	If Not ($samePWD = $infoAcc[2]) Then
;~ 	click passửod
		_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 32, 235)
;~ 	Nhap mat khau
;~ 		ClipPut($infoAcc[2])
		Sleep(200)
		ControlSend($WindowHandle, "", "", $infoAcc[2])
	EndIf

	;click dang nhap khi nhap mat khau
	_CtrlClick($WindowHandle, 137, 295)
	Sleep(100)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	_OKIF($WindowHandle, "iconThuong")
	AdlibUnRegister("_checkPWD")
	Sleep(100)
	_CtrlClick($WindowHandle, 136, 425)

;~ 	---------------------
;~ 	_ClickUtilSeeImg($WindowHandle, "iconBlueDTK",243, 19)

	_CtrlClick($WindowHandle, 136, 425)
	Sleep(700)
;~ 	_CtrlClick($WindowHandle, 131, 236)
_ClickUtilSeeImg($WindowHandle, "HoaAn",131, 236)
Sleep(1000)
_CtrlClick($WindowHandle, 42, 349)
Sleep(1000)
_CtrlClick($WindowHandle, 140, 354)
Sleep(1000)
_CtrlClick($WindowHandle, 226, 353)
Sleep(1000)
_CtrlClick($WindowHandle, 252, 117)
_ClickUtilSeeImg($WindowHandle, "giano",131, 236)
Sleep(1000)
_CtrlClick($WindowHandle, 226, 353)

_ClickUtilSeeImg($WindowHandle, "tangcap",45, 109)
Sleep(1000)
_CtrlClick($WindowHandle,220, 257)

Sleep(1000)
_CtrlClick($WindowHandle,256, 77)
Sleep(1000)
_CtrlClick($WindowHandle,261, 46)
;~ _ClickUtilSeeImg($WindowHandle, "HoaAn",131, 236)
;~ 	Sleep(100)
;~ 	_Wait4Image($WindowHandle, "iconPopup")
;~ 	Sleep(150)
;~ 	_OKIF($WindowHandle, "iconTrangTri")
;~ 	_CtrlClick($WindowHandle, 264, 19)
EndFunc   ;==>clone


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
;~ 	Sleep(500)
	_ClickUtilSeeImg($WindowHandle, "iconInBangXepHang", 255, 12, 700)
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

Func _ChonSV($WindowHandle, $SVer, $fileIni)
	If StringInStr($SVer, "SV", 1) Then
		IniWrite($fileIni, "General", "SV", $SVer)
	EndIf
	AdlibRegister("_ClearApp", 130000)
	While 1
		Local $Result, $i = 0, $rsult = 0, $startTime = TimerInit(), $tdif
		While 1
			Sleep(10)
			$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $SVer & ".bmp", 0, 0, -1, -1, 40, 100)
			If Not @error Then
;~ 				WinMove($WindowHandle, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3]) ; win move
				Sleep(100)
;~ 				Local $tempHwnd = WinGetHandle($WindowHandle)
				_CtrlClick($WindowHandle, $Result[1][0], $Result[1][1] - 31)
				Return
			EndIf
			$tdif = TimerDiff($startTime)
			If $tdif > 400 Then
				ExitLoop
			EndIf
		WEnd
		Sleep(100)
		_ADB_CMD("input swipe 528 414 541 327 500", $port)
		If StringInStr($SVer, "SV", 1) Then
			;MsgBox(0, "", "", 1)
			IniWrite($fileIni, "General", "SV", $SVer)
		EndIf
	WEnd
EndFunc   ;==>_ChonSV

;~ ============================================================================================================================ Bang
Func showBang($willCH1, $fileIni)
	Return _ReadIni($fileIni, "CHBANG", $willCH1, 0)
EndFunc   ;==>showBang

Func updateBang($fileIni, $willCH, $value)
	_WriteIni($fileIni, "CHBANG", $willCH, $value)
EndFunc   ;==>updateBang

;~ ============================================================================================================================ End Bang
Func IncrI()
	MsgBox(0, "", "Wrong Pass", 1)
	ClipPut($tenTK)
	$PassChanged = IniRead($iniFile, "General", "WrongPass", '') & " || " & ClipGet()
	IniWrite($iniFile, "General", "WrongPass", $PassChanged)
	IniWrite($iniFile, "General", "BienI", $iGlobal1 + 1)
	_ClearApp()
EndFunc   ;==>IncrI

Func _checkPWD()
	If _imgSearch($WindowHandle, "iconSaiMK") = 1 Or _imgSearch($WindowHandle, "iconTKKT") = 1 Then
		IncrI()
;~ 		AdlibUnRegister("_checkPWD")
	EndIf
EndFunc   ;==>_checkPWD

Func _ClearApp()
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini"
	_WriteIni($fileIni, "General", "PID", @AutoItPID)
	Local $splitted = StringSplit(WinGetTitle($WindowHandle), "- ")
;~ 	_ADB_CMD("input keyevent 187", $port)
;~ 	RunWait(@ComSpec & ' /c adb kill-server', "", @SW_HIDE)
;~ 	RunWait(@ComSpec & ' /c adb start-server', "", @SW_HIDE)
	RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 187', "", @SW_HIDE)
	MsgBox(0, $port, "done 187")
	Sleep(2000)
	_Wait4Image($WindowHandle, "iconClose")

;~ 	_ADB_CMD("input swipe 502 552 188 552", $port)

	ShellExecuteWait(@ScriptDir & '\' & @ScriptName)
EndFunc   ;==>_ClearApp

Func _reSize($WindowHandle)

	Local $aPos = WinGetPos($WindowHandle)

	WinMove($WindowHandle, "", 0, 0, 591, 1010)
	Sleep(1000)

EndFunc   ;==>_reSize

Func _ResetNewDay($fileIni)
	If _ReadIni($fileIni, "General", "Day", 0) <> @MDAY Then
		_WriteIni($fileIni, "General", "Day", @MDAY)
		_WriteIni($fileIni, "General", "BienI", 1)

	Else
		$i = _ReadIni($fileIni, "General", "BienI", 1)
	EndIf
EndFunc   ;==>_ResetNewDay

Func _WriteIni($filePath, $Section, $Key, $value = 1)
	IniWrite($filePath, $Section, $Key, $value)
EndFunc   ;==>_WriteIni

Func _ReadIni($filePath, $Section, $Key, $value = 1)
	Return IniRead($filePath, $Section, $Key, $value)
EndFunc   ;==>_ReadIni

Func ExitToLog($WindowHandle, $port)
	_ADB_CMD("input keyevent 4", $port)
	Sleep(500)
	_ClickUtilSeeImg($WindowHandle, "iconDTK", 81, 270, 300)
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

Func _Start($WindowHandle, $bmpfb, $bmptk, $bmpday) ; seeefb
	;_OKIF($WindowHandle, "iconDTK")
;~ 	Sleep(8000)
	While 1
		If _imgSearch($WindowHandle, $bmptk) = 1 Then
;~ 		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmptk & ".bmp", 0, 0, -1, -1, 40, 100)
;~ 		If Not @error Then
			Mbox("2")
			Sleep(2000)
			While 1
;~ 				Mbox("2")
;~ 				_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmpfb & ".bmp", 0, 0, -1, -1, 40, 100)
				If _imgSearch($WindowHandle, $bmpfb) = 1 Then
					Sleep(2000)
					_ClickUtilSeeImg($WindowHandle, $bmpday, 136, 288)
					Return

				Else
					Return
				EndIf
				Sleep(100)
			WEnd
			Return

		Else
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_Start

Func _imgSearch($WindowHandle, $SVer)
	Local $startTime = TimerInit(), $tdif
	While 1
		Sleep(10)
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $SVer & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			Sleep(10)
			$x = $Result[1][0]
			$y = $Result[1][1] - 31
			Return 1
		Else
			Return 0
		EndIf
		$tdif = TimerDiff($startTime)
		If $tdif > 400 Then
			ExitLoop
		EndIf
	WEnd

EndFunc   ;==>_imgSearch

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
	RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell ' & $command, "", @SW_HIDE)
EndFunc   ;==>_ADB_CMD

Func _Wait4Image($WindowHandle, $bmp)
	Sleep(100)
	While 1
		Local $Result
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 50, 100)
		If Not @error Then
			Sleep(100)
			ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
;~ 			Sleep(200)
;~ 			ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
			;Mbox(" a")
			Return
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func _ClickUtilSeeImg($WindowHandle, $bmp, $x, $y, $slp = 100)
	While 1
		_CtrlClick($WindowHandle, $x, $y)
		Sleep($slp)
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
	WEnd

EndFunc   ;==>_ClickUtilSeeImg

Func _ClickUtilSeeImgNoSleep($WindowHandle, $bmp, $x, $y)
	Sleep(100)
	While 1
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 13, 156, 58, 238, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
		ControlClick($WindowHandle, "", "", "left", 3, $x, $y + 31)
	WEnd

EndFunc   ;==>_ClickUtilSeeImgNoSleep

Func Mbox($ndung)
	MsgBox(0, "", $ndung)

EndFunc   ;==>Mbox

Func Terminate()
	Exit
EndFunc   ;==>Terminate
