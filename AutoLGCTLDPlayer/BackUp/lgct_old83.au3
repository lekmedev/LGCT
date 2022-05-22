#include-once
#include "Data\UDF\HandleImgSearch.au3"
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include "Data\UDF\CoProc.au3"
#include "Data\UDF\AndroidUDF\Android.au3"
#include <File.au3>
#include <GDIPlus.au3>
#include <Clipboard.au3>
#include <ScreenCapture.au3>
#include "Data\UDF\CoordPhu.au3"
;~ 720x1280 320dpi

Global $port, $x = 0, $y = 0, $WindowHandle, $tenTK, $iniFile, $iGlobal, $iGlobal1, $aPos, $aPoss, $rsMod, $sFilePathvang

Func AutoMain($WindowHandle1, $port1)
	$port = $port1
;~ 	Mbox($port)
	AdlibRegister("_ClearApp", 30000)
	ControlClick($WindowHandle, "", "", "left", 1, 218, 265 + 31)
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	$iniFile = $fileIni
	_ResetNewDay($fileIni)
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
;~ 		AdlibRegister("_ClearApp", 30000)
;~ 		$iGlobal = $iGlobal
		$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")

		If $infoAcc[1] == '-' Then
			ContinueLoop
		EndIf
		$tenTK = $infoAcc[1]
		Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV

		If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
			If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 Then
				$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1123123123)
			EndIf
			_OKIF($WindowHandle, "iconDay")
			Sleep(300)
			_ClickUtilSeeImg($WindowHandle, "iconListServer", 91, 349)
			AdlibRegister("_ClearApp", 60000)
			_ChonSV($WindowHandle, $infoAcc[1], $fileIni)
			If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				_WriteIni($fileIni, "General", "SVDAY", 0)
			EndIf
			If StringInStr($infoAcc[1], "SV", 1) Then
				ContinueLoop
			EndIf
		EndIf

;~ 		--------------------------------------------------------------------------------------------------------
		AdlibRegister("_ClearApp", 40000)
		_DoiTK($infoAcc, $samePWD) ;Doi Tai Khoan
		;Capt($infoAcc,$fileIni)
		CaptADB($infoAcc)
		If _ReadIni($fileIni, "General", "code", "") <> "" Then
			DoiCode()
		EndIf
		$samePWD = $infoAcc[2] ; Check Same Password
		_ThinhAn($WindowHandle, $infoAcc) ; Done Sung Bai Thinh An
;~ 		ocr($infoAcc[1])
		_WriteIni($fileIni, "General", "BienI", $iGlobal1 + 1)
		ExitToLog($WindowHandle, $port)
	Next
	WinGetProcess($WindowHandle)
	If ProcessExists(WinGetProcess($WindowHandle)) Then
;~ 		MsgBox(0, "", "60S SHUT2222DƠN", 60)
		ProcessClose(WinGetProcess($WindowHandle))
	EndIf
	If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
		MsgBox(0, "", "60S SHUTDON", 60)
		AdlibUnRegister
		Sleep(60000)
		Shutdown(12)
	EndIf
EndFunc   ;==>AutoMain

Func _DoiTK($infoAcc, $samePWD)
	_OKIF($WindowHandle, "iconDay")
;~ 	Mbox("iconDay")
	_Wait4Image($WindowHandle, "iconDTK")
;~ 	Mbox("1")

;~ 	_CtrlClick($WindowHandle, 44, 473)
	_OKIF($WindowHandle, "iconFB")
;~ 	Mbox("asdfs")
	_CtrlClickInGame($WindowHandle, 138, 285)
	Sleep(500)
	_OKIF($WindowHandle, "iconTK", 240, 234, 260, 258)
	_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 34, 191)

;~ 	Nhap mat khau
	Sleep(400)

;~ 	ClipPut($infoAcc[1])
	ControlSend($WindowHandle, "", "", $infoAcc[1])
	If Not ($samePWD = $infoAcc[2]) Then
		Sleep(100)

		_ClickUtilSeeImgNoSleep($WindowHandle, "iconBlueDTK", 30, 228)

;~ 	Nhap mat khau
;~ 		ClipPut($infoAcc[2])

		ControlSend($WindowHandle, "", "", $infoAcc[2])
	EndIf
	;click dang nhap khi nhap mat khau
;~ 	Mbox("asdfs111")
	_CtrlClickInGame($WindowHandle, 136, 289)
	_CtrlClickInGame($WindowHandle, 136, 289)
	Sleep(100)
	_CtrlClickInGame($WindowHandle, 136, 289)
	Sleep(100)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	_OKIF($WindowHandle, "iconDay")
	AdlibUnRegister("_checkPWD")
	Sleep(100)
	_CtrlClickInGame($WindowHandle, 142, 415)
	Do
		If _imgSearch($WindowHandle, "svDay") = 1 Then
			IniWrite($iniFile, "General", "SVDAY", 1)
			_ClearApp()
;~ 			MsgBox(0, "", "SVday", 1)
		EndIf
	Until _imgSearch($WindowHandle, "iconPopup") = 1
	Sleep(300)

	_CtrlClickInGame($WindowHandle, 255, 116)
;~ 	_Wait4Image($WindowHandle, "iconPopup")
;~ 	Sleep(150)
	_OKIF($WindowHandle, "iconTrangTri")
	If Third($infoAcc, "qgia") Then
;~ 			AdlibRegister("test",30000)
		QuanGia()
		_OKIF($WindowHandle, "iconTrangTri")
	EndIf
	_CtrlClickInGame($WindowHandle, 260, 16)
	_OKIF($WindowHandle, "iconEmail")
;~ 	$aPos=WinGetPos($WindowHandle)
;~ 	WinMove($WindowHandle,"",0,0,588, 1044)
;~ 	Sleep(2009)
EndFunc   ;==>_DoiTK

Func Third($infoAcc, $para)
	If (UBound($infoAcc) > 3 And StringInStr($infoAcc[3], $para, 1)) Then
		Return True
	Else
;~ 	  MsgBox(0,"","false",1)
		Return False
	EndIf
EndFunc   ;==>Third

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
	_ClickUtilSeeImg($WindowHandle, "HoaAn", 131, 236)
	Sleep(1000)
	_CtrlClick($WindowHandle, 42, 349)
	Sleep(1000)
	_CtrlClick($WindowHandle, 140, 354)
	Sleep(1000)
	_CtrlClick($WindowHandle, 226, 353)
	Sleep(1000)
	_CtrlClick($WindowHandle, 252, 117)
	_ClickUtilSeeImg($WindowHandle, "giano", 131, 236)
	Sleep(1000)
	_CtrlClick($WindowHandle, 226, 353)

	_ClickUtilSeeImg($WindowHandle, "tangcap", 45, 109)
	Sleep(1000)
	_CtrlClick($WindowHandle, 220, 257)

	Sleep(1000)
	_CtrlClick($WindowHandle, 256, 77)
	Sleep(1000)
	_CtrlClick($WindowHandle, 261, 46)
;~ _ClickUtilSeeImg($WindowHandle, "HoaAn",131, 236)
;~ 	Sleep(100)
;~ 	_Wait4Image($WindowHandle, "iconPopup")
;~ 	Sleep(150)
;~ 	_OKIF($WindowHandle, "iconTrangTri")
;~ 	_CtrlClick($WindowHandle, 264, 19)
EndFunc   ;==>clone

Func _ThinhAn($WindowHandle, $infoAcc)
	;ULTI SEE EMAIL
	_OKIF($WindowHandle, "iconEmail")
;~ 	Sleep(400)
	AdlibRegister("repeatClickHC", 3000)
	_CtrlClickInGame($WindowHandle, 207, 193)
	_OKIF($WindowHandle, "iconInHoangCung")
	AdlibUnRegister("repeatClickHC")
	;_Wait4Image($WindowHandle, "iconInHoangCung") ; khang hy phu
;~ 	----------------------------- chon phu sung bai
	Local $Phu
	Switch _curSV()
		Case 185
			$Phu = $_Nhiep_Chinh
		Case Else
			$Phu = $_Khang_Hy
	EndSwitch
;~ 	----------------------------- chon phu sung bai


	_CtrlClickInGame($WindowHandle, $Phu[0],$Phu[1])

	_ClickUtilSeeImg($WindowHandle, "iconDaNhan", 228, 489)
	_ClickUtilSeeImg($WindowHandle, "iconXepHang", 253, 21)
	Sleep(100)
	;_OKIF($WindowHandle, "iconXepHang")
;~ 	_CtrlClick($WindowHandle, 206, 475)
	_ClickUtilSeeImg($WindowHandle, "iconInBangXepHang", 206, 475)
;~ 	_OKIF($WindowHandle, "iconInBangXepHang")
	;Mbox("in bxh")
	_CtrlClickInGame($WindowHandle, 100, 97)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBai", 227, 441) ;Bang TL
	Sleep(150)
	_ClickUtilSeeImg($WindowHandle, "iconInBangPB", 99, 54)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBai", 227, 441) ;Bang PB
	Sleep(150)
	_ClickUtilSeeImg($WindowHandle, "iconInBangTM", 167, 55)
	_ClickUtilSeeImg($WindowHandle, "iconDaSungBai", 227, 441) ;Bang TM

;~ 	khu vuc sung bai bxh
	If Third($infoAcc, "9t") Or IniRead($iniFile, "General", "SV", 0) = "SV283" Or IniRead($iniFile, "General", "SV", 0) = "SV341" Or IniRead($iniFile, "General", "SV", 0) = "SV338" Or IniRead($iniFile, "General", "SV", 0) = "SV555" Or IniRead($iniFile, "General", "SV", 0) = "SV487" Or IniRead($iniFile, "General", "SV", 0) = "SV281" Or IniRead($iniFile, "General", "SV", 0) = "SV284" Then
		SungBaiLSV($WindowHandle)
	EndIf
;~

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
;~ 	EndIfbig_daisy083
	Run(@ComSpec & ' /c ""C:\Program Files\ImageMagick-7.0.10-Q16\magick" convert "E:\Temp\LDPhoTo\' & $infoAcc[1] & '.jpg" -crop 65x20+520+110  "D:\Vang\Vang\' & _curSV & '\' & $infoAcc[1] & '.jpg""', "", @SW_HIDE)
EndFunc   ;==>_ThinhAn
;~ C:\Users\Admin\Desktop\2pc\AutoLGCTLDPlayer\Data\Images
Func OCR($img)
	$ImageToReadPath = '"D:\Vang\Vang\' & _ReadIni($iniFile, "General", "SV", 0) & '\' & $img & '.jpg"'
	$ResultTextPath = @ScriptDir & "\Result"
	$OutPutPath = $ResultTextPath & ".txt"
	$TesseractExePath = @ScriptDir & "\Tesseract-OCR\Tesseract.exe"

	ShellExecuteWait($TesseractExePath, '"' & $ImageToReadPath & '" "' & $ResultTextPath & '"', "", "", @SW_HIDE)

	If @error Then
		Exit MsgBox(0, "Error", @error, 1)
	EndIf
	If StringInStr(FileRead($OutPutPath), "K") Then
		Local $aaa = StringReplace(FileRead($OutPutPath), "K", "*1000")
		MsgBox(0, "Error", $aaa, 6)
	EndIf

;~ FileDelete($OutPutPath)
EndFunc   ;==>OCR

Func SungBaiLSV($WindowHandle)
;~ 	Sleep(500)
	_ClickUtilSeeImg($WindowHandle, "iconInBangXepHang", 255, 12, 700)
	_OKIF($WindowHandle, "iconInBangXepHang")
	_CtrlClickInGame($WindowHandle, 219, 238)
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

Func DoiCode()
	Local $code = IniRead($iniFile, "General", "code", 0)
	_ClickUtilSeeImg($WindowHandle, "iconDoiCode", 24, 409)
	Sleep(29)
	_Wait4Image($WindowHandle, "iconDoiCode")
	Sleep(10)
	_Wait4Image($WindowHandle, "iconNhapCode")
	Sleep(300)
;~ 	ClipPut($code)
;~ 	_SendMessage($WindowHandle, 0x0302, 0, 0)
;~ 	_SendMessage ($WindowHandle, $code,0,0)
	ControlSend($WindowHandle, "", "", $code)
;~ 	Mbox($code)
	Sleep(10)
	_CtrlClick($WindowHandle, 136, 271)
	_ClickUtilSeeImg($WindowHandle, "iconDoiCode", 243, 184)
	_CtrlClick($WindowHandle, 243, 98)
EndFunc   ;==>DoiCode

Func _ChonSV($WindowHandle, $SVer, $fileIni)
;~ 	Mbox($SVer, 1)
	Local $SVtrimmed = StringTrimLeft($SVer, 2), $tempSVerfile = _ReadIni($fileIni, "General", "SV", 1)

	If StringInStr($SVer, "SV", 1) Then
		IniWrite($fileIni, "General", "SV", $SVer)
	EndIf
	AdlibRegister("_ClearApp", 130000)
	Local $grsv = GrSV($SVtrimmed), $SVerfile = GrSV($tempSVerfile)

	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input swipe 200 860 200 500 100 ', "", @SW_HIDE)
	Sleep(500)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input swipe 200 860 200 500 100 ', "", @SW_HIDE)
	Sleep(500)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input swipe 200 860 200 500 100 ', "", @SW_HIDE)
	Sleep(500)
	While 1
		Local $startTime = TimerInit(), $tdif
		While 1
			Sleep(10)
;~ 			Local $SVerfile = _ReadIni($fileIni, "General", "SV", 1)

			If _bmbSearch(WinGetTitle($WindowHandle), $grsv) = 1 Then
;~ 				Sleep(400)
;~ 				MsgBox(0, $CoorControl[0], $CoorControl[1], 1)
				_ADB_CMD_SLEEP("input tap " & $aPoss[1][0] & " " & $aPoss[1][1] & " ", $port, 550)
;~ 				_CtrlClickInGame($WindowHandle, $CoorControl[0], $CoorControl[1])
;~ 				_CtrlClickInGame($WindowHandle, $CoorControl[0], $CoorControl[1])
;~ 				_CtrlClickInGame($WindowHandle, $CoorControl[0], $CoorControl[1])

;~ 				------------------------------------------------------------- Click Sver Con
				Sleep(699)
;~ 				MsgBox(0, "SV Trimmight", StringRight($SVer, 1), 1)
				Local $baby = StringRight($SVer, 1)
				If $baby = 1 Then
					_ADB_CMD_SLEEP("input swipe 593.2 835 593.2 522 100", $port, 1500)
					_ADB_CMD_SLEEP("input tap 400 853", $port, 550)
				ElseIf $baby = 2 Then
					_ADB_CMD_SLEEP("input swipe 593.2 835 593.2 522 100", $port, 1500)
					_ADB_CMD_SLEEP("input tap 400 787", $port, 550)
				ElseIf $baby = 3 Then
					_ADB_CMD_SLEEP("input swipe 593.2 835 593.2 522 100", $port, 1500)
					_ADB_CMD_SLEEP("input tap 400 720", $port, 550)
				ElseIf $baby = 4 Then
					_ADB_CMD_SLEEP("input swipe 593.2 835 593.2 522 100", $port, 1500)
					_ADB_CMD_SLEEP("input tap 400 662", $port, 550)
				ElseIf $baby = 5 Then
					_ADB_CMD_SLEEP("input tap 400 853", $port, 550)
				ElseIf $baby = 6 Then
					_ADB_CMD_SLEEP("input tap 400 787", $port, 550)
				ElseIf $baby = 7 Then
					_ADB_CMD_SLEEP("input tap 400 720", $port, 550)
				ElseIf $baby = 8 Then
					_ADB_CMD_SLEEP("input tap 400 662", $port, 550)
				ElseIf $baby = 9 Then
					_ADB_CMD_SLEEP("input tap 400 600", $port, 550)
				ElseIf $baby = 0 Then
					_ADB_CMD_SLEEP("input tap 400 540", $port, 550)
				EndIf



;~ 				-------------------------------------------------------------
;~ 				MouseMove($CoorControl[0],$CoorControl[1])
;~ 				MsgBox(0,$x,$y)
				Return
			EndIf
;~ 			If _imgSearch($WindowHandle, "S181",60, 197,82, 342) = 1
			$tdif = TimerDiff($startTime)
			If $tdif > 1000 Then
				ExitLoop
			EndIf
		WEnd
		Sleep(100)
;~
		_ADB_CMD_SLEEP("input swipe 251 522 251 800 1500", $port, 3000)
;~ 		846.5 522
		If StringInStr($SVer, "SV", 1) Then
			IniWrite($fileIni, "General", "SV", $SVer)
;~ 			adb -s 127.0.0.1:5557 shell input swipe 200 531 200 866 1000
		EndIf
	WEnd
EndFunc   ;==>_ChonSV

Func GrSV($sv)
	Local $rsInt, $rsFinal
	$rsInt = Int($sv / 10)
	$rsMod = Mod($sv, 10)
	If $rsMod = 0 Then
		$rsFinal = $sv - 9
	Else
		$rsFinal = $sv - ($rsMod - 1)
	EndIf
	Return $rsFinal
EndFunc   ;==>GrSV
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
	Local $GenegalFile = @ScriptDir & "\Data\Account\file.ini"
	$PassChanged = IniRead($GenegalFile, "General", "WrongPass", '') & " || " & ClipGet()
	IniWrite($GenegalFile, "General", "WrongPass", $PassChanged)
	IniWrite($iniFile, "General", "BienI", _ReadIni($iniFile, "General", "BienI", 1) + 1)
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

	Sleep(1500)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.hd.vngjyp', "", @SW_HIDE)
	Sleep(7000)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)

	ShellExecuteWait(@ScriptDir & '\' & @ScriptName)
	Sleep(1)
EndFunc   ;==>_ClearApp

Func _reSize($WindowHandle)

	Local $aPos = WinGetPos($WindowHandle)

	WinMove($WindowHandle, "", 0, 0, 591, 1010)
	Sleep(1000)

EndFunc   ;==>_reSize

Func CaptADB($infoAcc)
	Local $sv = IniRead($iniFile, 'General', 'SV', 0)
	If $sv == "SV377" Or $sv == "SV379" Or $sv == "SV376" Or $sv == "SV374" Then
		$sv = "TuanMatLozzzz"
	EndIf
	If Third($infoAcc, "OtherKNB") Then
		Local $name = StringSplit($infoAcc[3], "_")
		$sv = $name[2]
	EndIf
	$sFilePathvang = "D:\Vang\Vang\" & $sv
	If FileExists($sFilePathvang) = 0 Then
		DirCreate($sFilePathvang)
;~ 		MsgBox(0,"asdf","asdfa",1)
	EndIf
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell screencap -p /sdcard/Pictures/' & $infoAcc[1] & '.jpg', "", @SW_HIDE)
EndFunc   ;==>CaptADB

Func _bmbSearch($SVnoTrim, $SVtrimmed)
	Local $Source = "C:\Users\Admin\Documents\LDPlayer\Misc\1.bmp"
	Local $FindBmp = @ScriptDir& "\Data\Images\S181.bmp"
	While 1
		Sleep(10)
		RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell screencap -p /sdcard/Misc/1.bmp', "", @SW_HIDE)
		Local $a1 = TimerInit
		While 1
;~ 			MsgBox(0, "", "$a = _BmpImgSearch", 1)
			$aPoss = _BmpImgSearch($Source, $FindBmp, 0,0,-1, -1, 70, 500)
			If Not @error Then
				return 1
			EndIf
			If TimerDiff($a1) > 3401 Then
				return
			EndIf
		WEnd
	WEnd
EndFunc   ;==>_bmbSearch

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

Func _curSV()
	Return IniRead($iniFile, "General", "SV", "")
EndFunc   ;==>_curSV

Func ExitToLog($WindowHandle, $port)
;~ 	Mbox("exittoloop")
	_ADB_CMD("input keyevent 4", $port)
	Sleep(500)
	_ClickUtilSeeImg($WindowHandle, "iconDTK", 86, 268, 300)
EndFunc   ;==>ExitToLog

Func _OKIF($hwnd, $bmp, $x = 0, $y = 0, $x1 = -1, $x2 = -1)
	While 1
		_HandleImgSearch($hwnd, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", $x, $y, $x1, $x2, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_OKIF

Func _Start($WindowHandle, $bmpfb, $bmptk, $bmpday) ;seeefb
	While 1
		If _imgSearch($WindowHandle, $bmptk) = 1 Then
;~ 			Mbox("2")
;~ 			Mbox("0")
			Sleep(2000)
			While 1
				If _imgSearch($WindowHandle, $bmpfb) = 1 Then
					Sleep(2000)
;~ 					Mbox("1")
					_ClickUtilSeeImg($WindowHandle, $bmpday, 136, 288)
					Return
				Else
;~ 					Mbox("20")
					Return
				EndIf
				Sleep(100)
			WEnd
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_Start

Func _imgSearch($WindowHandle, $SVer, $top = 0, $left = 0, $bot = -1, $right = -1)
	Local $startTime = TimerInit(), $tdif

	While 1
		Sleep(10)
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $SVer & ".bmp", $top, $left, $bot, $right, 34, 100)
		If Not @error Then
			Sleep(10)
			$x = $Result[1][0]
			$y = $Result[1][1]
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

Func _CtrlClick($WindowHandle, $x1, $y1)
	;MsgBox(0,"","")
	$WindowHandle = HWnd($WindowHandle)
	ControlClick($WindowHandle, "", "", "left", 2, $x1, $y1 - 36)
	Sleep(100)
	ControlClick($WindowHandle, "", "", "left", 2, $x1, $y1 - 36)
	Sleep(10)
	;ControlClick($WindowHandle, "", "", "left", 1, $x, $y)
EndFunc   ;==>_CtrlClick

Func _CtrlClickInGame($WindowHandle, $x1, $y1)
	;MsgBox(0,"","")
	$WindowHandle = HWnd($WindowHandle)
	ControlClick($WindowHandle, "", "", "left", 1, $x1, $y1)
	Sleep(10)
	;ControlClick($WindowHandle, "", "", "left", 1, $x, $y)
EndFunc   ;==>_CtrlClickInGame

Func _ADB_CMD($command, $port)
	RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell ' & $command, "", @SW_HIDE)
EndFunc   ;==>_ADB_CMD

Func _ADB_CMD_SLEEP($command, $port, $slep = 500)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell ' & $command, "", @SW_HIDE)
	Sleep($slep)
EndFunc   ;==>_ADB_CMD_SLEEP

Func _Wait4Image($WindowHandle, $bmp)
	Sleep(200)
	While 1
		If _imgSearch($WindowHandle, $bmp) = 1 Then
;~ 			Mbox("iconDay")
			_CtrlClick($WindowHandle, $x, $y)
			Sleep(200)

			Return
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func _ClickUtilSeeImg($WindowHandle, $bmp, $x1, $y1, $slp = 10)
	While 1
		_CtrlClickInGame($WindowHandle, $x1, $y1)
		Sleep($slp)
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
	WEnd

EndFunc   ;==>_ClickUtilSeeImg

Func _ClickUtilSeeImgNoSleep($WindowHandle, $bmp, $x1, $y1)
	Sleep(100)
	While 1
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 22, 196, 42, 248, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
;~ 		_CtrlClickInGame($WindowHandle, $x1, $y1)
		_CtrlClickInGame($WindowHandle, $x1, $y1)
		_CtrlClickInGame($WindowHandle, $x1, $y1)
		_CtrlClickInGame($WindowHandle, $x1, $y1)
	WEnd

EndFunc   ;==>_ClickUtilSeeImgNoSleep

Func Mbox($ndung, $time = 1)
	MsgBox(0, "", $ndung, $time)

EndFunc   ;==>Mbox

Func QuanGia()
	_OKIF($WindowHandle, "iconTrangTri")
	Sleep(300)
	_CtrlClickInGame($WindowHandle, 257, 413)

;~ 	MouseClick("left", 826, 623, 1, 0)
	_OKIF($WindowHandle, "inquangia")
	_CtrlClickInGame($WindowHandle, 230, 252)
;~ 	OKIF("inquangia", 848, 351, 860, 370)
;~ 	MouseClick("left", 800, 400, 1, 0)
	Do
;~ 		_imgSearch($WindowHandle,"fullqg.bmp")
		If _imgSearch($WindowHandle, "fullqg") = 1 Then
			Sleep(300)
			_CtrlClickInGame($WindowHandle, 253, 15)
;~ 			MouseClick("left", 253, 15, 1, 0)
			Return
		EndIf
	Until _imgSearch($WindowHandle, "okqg") = 1
	_Wait4Image($WindowHandle, "okqg")
	_CtrlClickInGame($WindowHandle, 253, 15)
;~ 	Wait4Img('okqg.bmp', 648, 726, 648, 726, 663, 746)
	_OKIF($WindowHandle, "inquangia")
	Sleep(300)
	_CtrlClick($WindowHandle, 253, 15)
EndFunc   ;==>QuanGia

Func repeatClickHC()
	_CtrlClickInGame($WindowHandle, 207, 193)
;~ 	AdlibUnRegister("repeatClickHC")
EndFunc   ;==>repeatClickHC
