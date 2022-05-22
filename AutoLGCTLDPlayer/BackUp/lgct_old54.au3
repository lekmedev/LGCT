#include "Data\UDF\HandleImgSearch.au3"
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include "Data\UDF\CoProc.au3"
#include "Data\UDF\AndroidUDF\Android.au3"
#include <File.au3>
HotKeySet("{ESC}", "Terminate")
Global $WindowHandle = WinGetHandle("(MEmu - 0)")

;~ _reSize($WindowHandle[1][1])
;~ While 1@
;~ local $Result = _HandleImgSearch($WindowHandle[1][1], @ScriptDir & "\Data\Images\SV533.bmp", 189, 254-30, 265,375, 30, 100)
;~ IF not @error then
;~ 	Mbox("adf")
;~ 	ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
;~ 	ExitLoop
;~ 	EndIf
;~ WEnd

;~ ControlClick($WindowHandle[1][1], "", "", "left", 1, $Result[1][0], $Result[1][1])
;~ _ClearApp()
;~ _reSize($WindowHandle)

AutoMain($WindowHandle)
Func AutoMain($WindowHandle = Default)
;~ 	$WindowHandle = HWnd($WindowHandle)
;~ 	_WriteIni($fileIni, "General", "Hwnd", 0)
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	;MsgBox(0,$fileIni,$fileList)
	If ProcessExists(_ReadIni($fileIni, "General", "PID", 1)) Then ;Close PID
		ProcessClose(_ReadIni($fileIni, "General", "PID", 1))
	EndIf
	_Wait4Image($WindowHandle, "iconGame")
	_Start($WindowHandle, "iconFB", "iconDTK")
	;_Wait4Image($WindowHandle, "iconDay")
;~ 	Doi sv list
	;_OKIF($WindowHandle, "iconListServer")
	;Local $p =ngocthuan123
	Local $infoAcc, $samePWD, $i = 1
	Local $splitted = StringSplit(WinGetTitle($WindowHandle), "- ")
	Local $port = Number(StringTrimRight($splitted[2], 1))

	For $i = $i To _FileCountLines($fileList)
		$infoAcc = StringSplit(FileReadLine($fileList, $i), " ")
		If $infoAcc[1] == '-' Then
			ContinueLoop
		EndIf
		Sleep(100)

;~ 		----------------------------------------------------------------------------------------------------------- Change SV
		If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
			_OKIF($WindowHandle, "iconDay")
			Sleep(300)
			;MouseClick("left", 577, 543, 1, 0)
			Local $aPos = WinGetPos($WindowHandle)
			_reSize($WindowHandle)
			_ClickUtilSeeImg($WindowHandle, "iconListServer", 183, 714)
;~ 			OKIF($WindowHandle, "iconListServer")
;~ 			Mbox(" sen lsts")
			_ChonSV($WindowHandle, $infoAcc[1], $fileIni, $port,$aPos)
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
		_WriteIni($fileIni, "General", "BienI", $i + 1)
		ExitToLog($WindowHandle, $port)
	Next

	;Scrolllll
	;_ADB_CMD("input swipe 200 800 200 650 1000", $port)

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
	ClipPut($infoAcc[1])
	ControlSend($WindowHandle, "", "", "^V")
	If Not ($samePWD = $infoAcc[2]) Then
;~ 	click passửod
		_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 32, 235)
;~ 	Nhap mat khau
		ClipPut($infoAcc[2])
		Sleep(200)
		ControlSend($WindowHandle, "", "", "^V")
	EndIf

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
;187 app switch, 4 back , 3 home

;~ 323, 534  54.6531302876 x

;~ 591, 1010 52.8712871287 y


Func _ChonSV($WindowHandle, $SVer, $fileIni, $port,$aPos)
	If StringInStr($SVer, "SV", 1) Then
		IniWrite($fileIni, "General", "SV", $SVer)
	EndIf
	AdlibRegister("_ClearApp", 130000)
	While 1
		Local $Result, $i = 0, $rsult = 0, $startTime = TimerInit(), $tdif
		While 1
			Sleep(10)
			$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $SVer & ".bmp", 0,0,-1,-1, 40, 100)
			If Not @error Then
				WinMove($WindowHandle, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
				Sleep(100)

				_CtrlClick($WindowHandle, $Result[1][0], $Result[1][1])
Return
			EndIf
			$tdif = TimerDiff($startTime)
			If $tdif > 400 Then
				ExitLoop
;~ 				Mbox("Tdif")
			EndIf

;~ 			Mbox("Tdif2")
		WEnd
;~ 		Mbox("1")
		Sleep(100)
		_ADB_CMD("input swipe 528 414 541 327 500", $port)
;~ 		Mbox("adb swpe")
;~ 			if TimerDiff($start) >= 500 then
;~ 			 ExitLoop
;~ 			endif
;~ 		WEnd6
;~ 		 89, 116, 138, 175, 10,
;~ 		If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
;~ 			$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & _ReadIni($fileIni, "General", "SV", 1) & ".bmp", 75, 114, 204, 179, 100)
;~ 		EndIf
;~ 		If $rsult=1 Then
;~ 			MsgBox(0, $Result[1][0], $Result[1][1], 2)
;~ 			Sleep(100)
;~ 			_CtrlClick($WindowHandle, $Result[1][0], $Result[1][1])
;~ 			Sleep(200)
;~ 			ControlClick($WindowHandle, "", "", "left", 1, $Result[1][0], $Result[1][1])
;~ 			MsgBox(0, "", "No error", 2)
;~ 			_ADB_CMD("input tap " & $Result[1][0] & " " & $Result[1][1] & "", $port)

;~ 			WinMove($WindowHandle, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
;~ 			Return
;~ 		EndIf

		If StringInStr($SVer, "SV", 1) Then
			;MsgBox(0, "", "", 1)
			IniWrite($fileIni, "General", "SV", $SVer)
		EndIf

;~ 		MouseClickDrag("left", 770, 261, 770, 215, 1)
;~ 		MouseClick("left", 770, 215, 1, 0)
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

Func _ClearApp()
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini"
	_WriteIni($fileIni, "General", "PID", @AutoItPID)
	Local $splitted = StringSplit(WinGetTitle($WindowHandle), "- ")
	Local $port = Number(StringTrimRight($splitted[2], 1))
	_ADB_CMD("input keyevent 187", $port)
	Sleep(2000)
	_ADB_CMD("input swipe 502 552 188 552", $port)

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
	Sleep(300)
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

Func _Start($WindowHandle, $bmpfb, $bmptk) ; seeefb
	;_OKIF($WindowHandle, "iconDTK")
;~ 	Sleep(2000)
	While 1
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmpfb & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			_ClickUtilSeeImg($WindowHandle, $bmptk, 136, 288)
			Return

		Else
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_Start

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
	RunWait(@ComSpec & ' /c adb -s 127.0.0.1:215' & $port & '3 shell ' & $command, "", @SW_HIDE)
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
