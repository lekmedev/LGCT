#include-once
#include "Data\UDF\HandleImgSearch.au3"
#include "Data\UDF\_ControlClick.au3"
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
#include <Misc.au3>
#include <String.au3>
#include <Constants.au3>
#include <Array.au3>
;~ 720x1280 320dpi
;~ _Singleton(
Global $port, $x = 0, $y = 0, $tenTK, $iniFile, $iGlobal1, $aPos, $aPoss, $rsMod, $sFilePathvang, $render_hwnd, $WindowHandle, $flag = 1, $motiec = 0, $flgMT = 0

;~ WinGetTitle($WindowHandle)
Func ClickSeeDay()
	If _imgSearch("iconFB") = 1 Then
		_ClickUtilSeeImg("iconDay", 135, 284)
	EndIf
	AdlibUnRegister("ClickSeeDay")
EndFunc   ;==>ClickSeeDay

Func IsEven($i)
	Return ($i / 2) = Round($i / 2)
EndFunc   ;==>IsEven

Func tem()
	_CtrlClickInGame(12, 159)
	Sleep(2000)
	_Wait4Image("mung")
	Sleep(1500)
	_CtrlClickInGame(177, 461)
	Local $x = 0, $y = 0
	For $i = 1 To 4
		_ClickUtilSeeImg("nhan", 71 + $x, 208)
;~ 		_CtrlClickInGame(71 + $x, 208)
		Sleep(1000)
		_CtrlClickInGame(140, 342)
		Sleep(1000)
		_CtrlClickInGame(255, 161)
		Sleep(1000)
		$x += 47
	Next

	For $i = 1 To 3
;~ 	_ClickUtilSeeImg("nhan", 93 + $y, 255)
		_CtrlClickInGame(93 + $y, 255)
		Sleep(1000)
		_CtrlClickInGame(140, 342)
		Sleep(1000)
		_CtrlClickInGame(255, 161)
		Sleep(1000)
		$y += 47
	Next
	Sleep(1000)
	_CtrlClickInGame(258, 28)


EndFunc   ;==>tem

;~ 		If $flag = 0 Then Return
Func AutoMain()
;~ 	$port = $port1
;~ 	$WindowHandle = $WindowHandle1
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf

	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	_ResetNewDay($fileIni)


;~ 			Mbox($iGlobal)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.hd.vngjyp', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 138, 62)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")

		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)


;~ 			Mbox($iGlobal)
		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

			$iGlobal1 = $iGlobal11
;~ 			Mbox($iGlobal1)
;~ 		Mbox($iGlobal1)
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
			If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 Then
					$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1)
				EndIf
				_OKIF("iconDay")
				Sleep(300)
				_ClickUtilSeeImg("iconListServer", 91, 349)

				_ChonSV($infoAcc[1], $fileIni)

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
			$samePWD = $infoAcc[2] ; Check Same Password
			If $flag = 0 Then ExitLoop
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
			Switch _curSV()
				Case "SV284"
					If IniRead($iniFile, "CHBANG", "isSTop", 1) = 0 Then
						Local $count284 = IniRead($iniFile, "CHBANG", "TodayCHBang", 0)
						If Third($infoAcc, "200V") Then
							$count284 = $count284 + 1
							IniWrite($iniFile, "CHBANG", "TodayCHBang", $count284)
							If $count284 > IniRead($iniFile, "CHBANG", "LastCHBang", 1) Then
								_CHBang()
							EndIf
						EndIf
					EndIf
				Case "SV120"
					If IniRead($iniFile, "CHBANG", "isSTop120", 1) = 0 Then
						Local $count120 = IniRead($iniFile, "CHBANG", "TodayCHBang120", 0)
						If Third($infoAcc, "200V") Then
							$count120 = $count120 + 1
							IniWrite($iniFile, "CHBANG", "TodayCHBang120", $count120)
							If $count120 > IniRead($iniFile, "CHBANG", "LastCHBang120", 1) Then
								_CHBang()
							EndIf
						EndIf
					EndIf
			EndSwitch
			ExitToLog($port)
		Next
		If ProcessExists(WinGetProcess($WindowHandle)) And $flag = 1 Then
			ProcessClose(WinGetProcess($WindowHandle))

			_WriteIni($iniFile, "General", "Time", @HOUR & " : " & @MIN)
			Sleep(2000)
			If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
;~ 				MsgBox(0, "", "60S SHUTDON", 3000)
				Sleep(3000)
				Shutdown(12)
			EndIf
			Exit
		EndIf

	WEnd
EndFunc   ;==>AutoMain

Func _Prison()
	If @WDAY = 2 Or @WDAY = 4 Or @WDAY = 6 Then Return
	AdlibRegister("_ClearApp", 60000)
	While 1 ;click ra ngoai
		If $flag = 0 Then Return
		_CtrlClickInGame(280, 24)
		Sleep(1000)
		If _imgSearch("iconEmail", 21, 387, 34 - 21, 396 - 387) = 1 Then
			If _imgSearch("okPrison") = 0 Then
				_ADB_CMD("input swipe 100 300 1000 300 150", $port)
				Sleep(2000)
				_CtrlClickInGame(244, 256)

			Else
				_ADB_CMD("input swipe 100 300 700 300 150", $port)
				Sleep(2000)
				_CtrlClickInGame(272, 221)
			EndIf
			ExitLoop
		EndIf
	WEnd


	While 1  ;click ulti phat nhat
		If $flag = 0 Then Return
		_CtrlClickInGame(248, 433)
		Sleep(500)
		If _imgSearch("iconPhatNhanh", 241, 459, 259 - 241, 477 - 459) = 1 Then
			ExitLoop
		EndIf
	WEnd
	While 1  ;click ulti ud danh ko du
		If $flag = 0 Then Return
		_CtrlClickInGame(144, 300)
		_CtrlClickInGame(144, 300)
		_CtrlClickInGame(144, 300)
		_CtrlClickInGame(144, 300)
		_CtrlClickInGame(144, 300)
		_CtrlClickInGame(144, 300)
		_CtrlClickInGame(144, 300)
;~ 		Sleep(500)
		If _imgSearch("donePrison", 177, 280, 186 - 177, 293 - 280) = 1 Or _imgSearch("donePrison2", 177, 279, 189 - 177, 294 - 280) = 1 Or _imgSearch("donePrison3") = 1 Then
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>_Prison

Func _Mail()
	AdlibRegister("_ClearApp", 30000)
	_CtrlClickInGame(27, 363)
	_OKIF("inEmail")
	While 1
		If $flag = 0 Then Return
		If _imgSearchW("haveEmail", 1500) = 1 Or _imgSearchW("haveEmail2", 1500) = 1 Then

			AdlibRegister("_ClearApp", 10000)
;~ 			MsgBox(0,$x,$y)
			_CtrlClickInGame($x, $y)
			Sleep(1000)
			_CtrlClickInGame(141, 419)
			Sleep(1000)
			_CtrlClickInGame(258, 82)
			_OKIF("inEmail")
		Else
			_CtrlClickInGame(264, 72)
			Sleep(500)
			Return
		EndIf
;~ 		If TimerDiff($aa) > 5000 Then
;~ 			_CtrlClickInGame(264, 72)
;~ 		EndIf
	WEnd
EndFunc   ;==>_Mail

Func _CHBang()
;~ 	Do
	AdlibRegister("_ClearApp", 40000)
	Sleep(1000)
	While 1
		If $flag = 0 Then Return
		_CtrlClickInGame(255, 14)
		Sleep(1000)
		If _imgSearch("iconEmail") = 1 Then
			ExitLoop
		EndIf
	WEnd
	Sleep(200)
	_ADB_CMD("input swipe 710 300 90 300 200", $port)
;~ 	_ADB_CMD("input swipe 710 300 90 300 100", $port)
	Sleep(600)
	_CtrlClickInGame(87, 304)
	Sleep(1000)
;~ 	if chua vBang---------------------------------
	_CtrlClickInGame(225, 414)
	_CtrlClickInGame(225, 414)
	_CtrlClickInGame(225, 414)
	_OKIF("iconClickedDSBang")
	Sleep(400)
	_CtrlClickInGame(129, 167)
	_CtrlClickInGame(129, 167)
	_CtrlClickInGame(129, 167)

	If _curSV() = "SV284" Then
		ControlSend($WindowHandle, "", "", "2840003")
;~ 	_SendKeys($render_hwnd, "2840003")

	ElseIf _curSV() = "SV120" Then
		ControlSend($WindowHandle, "", "", "1200002")
;~ 	_SendKeys($render_hwnd, "2840003")
	EndIf
	Sleep(1000)
;~ 	Mbox("CLlick")
;~ 	_CtrlClickInGame(215, 196+30)
	_ADB_CMD("input tap 550 500", $port)
	Sleep(500)
	_CtrlClickInGame(215, 196 - 30)
	_OKIF("infoBang")
;~ 	_CtrlClickInGame(213, 370)
	_CtrlClickInGame(213, 370)
;~ 	Sleep(100)
	Local $a = TimerInit()
	While 1
		If $flag = 0 Then Return
		If _imgSearch("bangfull", 179, 275, 200 - 179, 295 - 275) = 1 Then
;~ 		Mbox("123")
			If _curSV() = "SV284" Then
				updateBang("LastCHBang", showBang("TodayCHBang"))
				updateBang("isSTop", 1)

			ElseIf _curSV() = "SV120" Then
				updateBang("LastCHBang120", showBang("TodayCHBang120"))
				updateBang("isSTop120", 1)

			EndIf
			Return
		EndIf
		If TimerDiff($a) > 2000 Then
			ExitLoop
		EndIf
	WEnd
	Sleep(2000)

	_CtrlClickInGame(80, 260)
	_OKIF("iconInBang")
	Sleep(300)
;~ 	_CtrlClickInGame(47, 361)
;~ 	_CtrlClickInGame(47, 361)
	_CtrlClickInGame(47, 361)
	_OKIF("inXay") ;c
	Sleep(500)
	_CtrlClickInGame(221, 267)
;~ 	_CtrlClickInGame(221, 267)
;~ 	Sleep(700)
	Do
		If $flag = 0 Then Return
		If _imgSearch("fullCH") = 1 Then ;c
;~ 			Mbox("asdf")
			If _curSV() = "SV284" Then
				updateBang("LastCHBang", showBang("TodayCHBang"))
				updateBang("isSTop", 1)

			ElseIf _curSV() = "SV120" Then
				updateBang("LastCHBang120", showBang("TodayCHBang120"))
				updateBang("isSTop120", 1)

			EndIf
;~ 						MsgBox(0,"do until",$quit,1)
			ExitLoop
		EndIf
	Until _imgSearch("fullCH") = 1 Or _imgSearch("iconDaXay") = 1

;~ 	_ClickUtilSeeImg("iconDaXay", 221, 267)

	Sleep(1000)
	_CtrlClickInGame(259, 70)
;~ 	Mbox("icondaxay")
;~ 	_CtrlClickInGame(259, 70)q
;~ 	_CtrlClickInGame(259, 70)
	Sleep(400)
	_CtrlClickInGame(109, 372)
;~ 	_CtrlClickInGame(109, 372)
;~ 	_CtrlClickInGame(109, 372)
	Sleep(1000)
;~ 	_CtrlClickInGame(140, 431)
;~ 	_CtrlClickInGame(140, 431)
	_CtrlClickInGame(140, 431)
	Sleep(600)
;~ 	_CtrlClickInGame(83, 268)
;~ 	_CtrlClickInGame(83, 268)q
	_CtrlClickInGame(83, 268)
EndFunc   ;==>_CHBang

Func showBang($willCH1)
	Return IniRead($iniFile, "CHBANG", $willCH1, 0)
EndFunc   ;==>showBang

Func updateBang($willCH, $value)
	IniWrite($iniFile, "CHBANG", $willCH, $value)
EndFunc   ;==>updateBang

Func ClickDTK()
	_CtrlClickInGame(38, 477)
	_CtrlClickInGame(38, 477)
EndFunc   ;==>ClickDTK

Func _DoiTK($infoAcc, $samePWD)
;~ 	_OKIF("iconDay")

	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconDay") = 1 Then
			ExitLoop
		EndIf
	WEnd
	AdlibRegister("ClickDTK", 4000)
	Sleep(200)
	AdlibUnRegister("ClickSeeDay")
	_Wait4Image("iconDTK")
	_OKIF("iconFB")
	AdlibUnRegister("ClickDTK")
	_CtrlClickInGame(140, 286)
	Sleep(500)
	_OKIF("iconTK", 241, 276, 259 - 241, 289 - 276)
	Sleep(500)


	_CtrlClickInGame(205, 189)
	Sleep(300)
	_CtrlClickInGame(205, 189)
	ControlSend($WindowHandle, "", "", "{BS 33}")

	Sleep(100)
	_OKIF("iconBS", 65, 220, 76 - 65, 231 - 220)
	Sleep(250)
	_CtrlClickInGame(205, 189)
	_ADB_CMD("input text " & $infoAcc[1], $port)
	If Not ($samePWD = $infoAcc[2]) Then
		Sleep(200)
		_CtrlClickInGame(205, 228)
		Sleep(200)
		ControlSend($WindowHandle, "", "", "{BS 36}")
		_OKIF("iconBS2", 63, 251, 72 - 63, 262 - 251)
		_ADB_CMD("input text " & $infoAcc[2], $port)
	EndIf
	_CtrlClickInGame(136, 289)
	_CtrlClickInGame(136, 289)
	Sleep(100)
	_CtrlClickInGame(136, 289)
	Sleep(100)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconDay") = 1 Or _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd
	AdlibUnRegister("_checkPWD")
	Sleep(500)

	_CtrlClickInGame(142, 415)
;~ 	Sleep(1000)
	_CtrlClickInGame(142, 415)


;~ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;~ 	Sleep(1000)
;~ 	_OKIF("iconPopup")
;~ 	ProcessClose($DOS)
;~ 	Sleep(1000)
;~ 	Local $iPID = Run(@ComSpec & ' /c tshark.exe -x -r D:test1.pcap"', "C:\Program Files\Wireshark", @SW_HIDE, $STDOUT_CHILD), $wr
;~ 	While 1
;~ 		$sOutput = StdoutRead($iPID)
;~ 		If @error Then ExitLoop ;
;~ 		MsgBox(0, "", $sOutput, 1)
;~ 		$aa = _StringBetween($sOutput, '"cash":', ',')
;~ 		If ProcessExists("dumpcap.exe") Then
;~ 			ProcessClose("dumpcap.exe")
;~ 		EndIf
;~ 	WEnd
;~ 	Sleep(1400)
;~ 	if UBound($aa) < 2 Then
;~ 			MsgBox(0,"",UBound($aa),1)
;~ 			FileWriteLine("D:\SumVang120.txt", $infoAcc[1] &" "& $infoAcc[2]&" Null")
;~ 			Return
;~ 		EndIf
;~ 	If StringLen($aa[1]) < 7 Then
;~ 		$wr = $aa[1]
;~ 	Else
;~ 		$wr = $aa[0]
;~ 	EndIf
;~ 	FileWriteLine("D:\SumVang120.txt", $infoAcc[1] & " " & $wr)
;~ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ Sum Vnag

	Local $a = TimerInit()

	AdlibRegister("_ClearApp", 30000)
	Do
		If $flag = 0 Then Return
		If _imgSearch("svDay") = 1 Then
			IniWrite($iniFile, "General", "SVDAY", 1)
			Local $GenegalFile = @ScriptDir & "\Data\Account\AutoListWrongPass.txt"
			FileWrite($GenegalFile, _curSV() & " ================================SVDay" & @CRLF & $tenTK[1] & " " & $tenTK[2] & @CRLF)
			_ClearApp()
;~ 			IncrI()
;~ 			MsgBox(0, "", "SVday", 1)
		EndIf
;~ 	Until _imgSearch("iconPopupTemp") = 1
	Until _imgSearch("iconPopup", 251, 148, 262 - 251, 160 - 148) = 1
;~ 	Sleep(200)
;~ 	_CtrlClickInGame(239, 30)
;~ 	If _imgSearch("iconPopupTemp") = 1 Then

;~ 		AdlibRegister("ClickAgain", 3000)
;~ 	EndIf

;~ 	---------------
	_OKIF("iconPopup")
	Sleep(200)
	If _imgSearch("iconPopup", 251, 148, 262 - 251, 160 - 148) = 1 Then
;~ 		Mbox("See")
		_CtrlClickImg($x + 251, $y + 148)
	EndIf ; Xoa Temp
;~ 	---------------



	_OKIF("iconTrangTri")


	AdlibUnRegister("ClickAgain")
	If Third($infoAcc, "qgia") Then
		QuanGia()
		_OKIF("iconTrangTri")
	ElseIf Third($infoAcc, "cthu") Then
		ChinhThu()
		_OKIF("iconTrangTri")
	EndIf

	_CtrlClickInGame(280, 28)
	_OKIF("iconEmail")
EndFunc   ;==>_DoiTK

Func ClickAgain()
	If _imgSearch("iconPopup") = 1 Then
		_CtrlClickImg($x, $y)
	EndIf
	AdlibUnRegister("ClickAgain")
EndFunc   ;==>ClickAgain

Func _DoiTKClone($infoAcc, $samePWD)
;~ 	_OKIF("iconDay")

	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd

	AdlibUnRegister("ClickSeeDay")
	_Wait4Image("iconDTK")
	_OKIF("iconFB")
	_CtrlClickInGame(138, 285)
	Sleep(500)
	_OKIF("iconTK", 241, 276, 259 - 241, 289 - 276)
	Sleep(500)
	_CtrlClickInGame(205, 189)
	Sleep(200)
	ControlSend($WindowHandle, "", "", "{BS 32}")
	_OKIF("iconBS", 65, 220, 76 - 65, 231 - 220)
;~ 	E:\App\AutoLGCTLDPlayer\Data\Images\.bmp
	_CtrlClickInGame(205, 189)
	ControlSend($WindowHandle, "", "", $infoAcc[1])
	If Not ($samePWD = $infoAcc[2]) Then
		Sleep(200)
;~ 		_ClickUtilSeeImgNoSleep("iconBlueDTK", 30, 228)
;~ 		ControlSend("", "", $infoAcc[2])
		_CtrlClickInGame(205, 228)
		_CtrlClickInGame(205, 228)
		Sleep(200)
		ControlSend($WindowHandle, "", "", "{BS 35}")
		_OKIF("iconBS2", 63, 251, 72 - 63, 262 - 251)

		_CtrlClickInGame(205, 228)
		_CtrlClickInGame(205, 228)
		ControlSend($WindowHandle, "", "", $infoAcc[2])
	EndIf
	_CtrlClickInGame(136, 289)
	_CtrlClickInGame(136, 289)
	Sleep(100)
	_CtrlClickInGame(136, 289)
	Sleep(100)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	While 1
		If _imgSearch("iconDay") = 1 Or _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd
	AdlibUnRegister("_checkPWD")
	Sleep(100)
	_CtrlClickInGame(142, 415)

EndFunc   ;==>_DoiTKClone

Func Third($infoAcc, $para)
	If (UBound($infoAcc) > 3 And StringInStr($infoAcc[3], $para, 1)) Then
		Return True
	Else
;~ 	  MsgBox(0,"","false",1)
		Return False
	EndIf
EndFunc   ;==>Third

Func clone($infoAcc, $samePWD)
	_OKIF("iconThuong")
	_Wait4Image("iconDTK")
	;_Wait4Image("iconFB")
	_OKIF("iconFB")
;~ 	Mbox("asdfs")
	_CtrlClickInGame(134, 288)
	Sleep(500)
	_OKIF("iconTK")

;~ 	Nhap tai khoan
;~ 	Mbox("1")
;~ 	_ClickUtilSeeImg("iconBlueDTK", 45, 188)
	_ClickUtilSeeImgNoSleep("iconBlueDTK", 45, 188)
;~ 	Nhap mat khau
	Sleep(200)
;~ 	ClipPut($infoAcc[1])
	ControlSend($WindowHandle, "", "", $infoAcc[1])
	If Not ($samePWD = $infoAcc[2]) Then
;~ 	click passửod
		_ClickUtilSeeImgNoSleep("iconBlueDTK", 32, 235)
;~ 	Nhap mat khau
;~ 		ClipPut($infoAcc[2])
		Sleep(200)
		ControlSend($WindowHandle, "", "", $infoAcc[2])
	EndIf

	;click dang nhap khi nhap mat khau
	_CtrlClickInGame(137, 295)
	Sleep(100)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	_OKIF("iconThuong")
	AdlibUnRegister("_checkPWD")
	Sleep(100)
	_CtrlClickInGame(136, 425)

;~ 	---------------------
;~ 	_ClickUtilSeeImg("iconBlueDTK",243, 19)

	_CtrlClickInGame(136, 425)
	Sleep(700)
;~ 	_CtrlClick(131, 236)
	_ClickUtilSeeImg("HoaAn", 131, 236)
	Sleep(1000)
	_CtrlClickInGame(42, 349)
	Sleep(1000)
	_CtrlClickInGame(140, 354)
	Sleep(1000)
	_CtrlClickInGame(226, 353)
	Sleep(1000)
	_CtrlClickInGame(252, 117)
	_ClickUtilSeeImg("giano", 131, 236)
	Sleep(1000)
	_CtrlClickInGame(226, 353)

	_ClickUtilSeeImg("tangcap", 45, 109)
	Sleep(1000)
	_CtrlClickInGame(220, 257)

	Sleep(1000)
	_CtrlClickInGame(256, 77)
	Sleep(1000)
	_CtrlClickInGame(261, 46)
;~ _ClickUtilSeeImg("HoaAn",131, 236)
;~ 	Sleep(100)
;~ 	_Wait4Image("iconPopup")
;~ 	Sleep(150)
;~ 	_OKIF("iconTrangTri")
;~ 	_CtrlClick(264, 19)
EndFunc   ;==>clone

Func _ThinhAn($infoAcc)
	;ULTI SEE EMAIL
;~ 	Mbox("bb")
	_OKIF("iconEmail")
;~ 	Sleep(400)
	AdlibRegister("repeatClickHC", 3000)
	_CtrlClickInGame(207, 193)
	_OKIF("iconInHoangCung")
	AdlibUnRegister("repeatClickHC")
	;_Wait4Image("iconInHoangCung") ; khang hy phu
;~ 	----------------------------- chon phu sung bai
;~ 	Mbox(_curSV())
	Local $Phu
	Switch StringTrimLeft(_curSV(), 2)

		Case 120
			$Phu = $_Vu_Huan
		Case 123
			$Phu = $_Vu_Thanh
		Case 62, 98, 108
			$Phu = $_Khoai_Hoat
		Case 185, 320, 585, 109, 111
			$Phu = $_Nhiep_Chinh
		Case 148, 149
			$Phu = $_Cung_Than
		Case 396
			$Phu = $_Van_Tuyen
		Case 407, 586, 279, 284, 287, 278
			$Phu = $_Binh_Tay
		Case 381, 182, 380, 433, 461, 408
			$Phu = $_Tran_Nam
		Case 416, 417, 415
			$Phu = $_Hoa_Thac
		Case Else
			$Phu = $_Khang_Hy
	EndSwitch

;~ 	----------------------------- chon phu sung bai
	Sleep(1100)
	_CtrlClickInGame($Phu[0], $Phu[1])

	If _curSV() = "SV284" Or _curSV() = "SV287" Or _curSV() = "SV278" Or _curSV() = "SV279" Then
		_OKIF("inPhu")
		If _imgSearch("Thung") = 0 Then
			_CtrlClickInGame(254, 247)
		EndIf
	EndIf

	_ClickUtilSeeImg("iconDaNhan", 243, 496, 400)

	_ClickUtilSeeImg("iconXepHang", 280, 24)
	Sleep(100)
	_ClickUtilSeeImg("iconInBangXepHang", 206, 475)
	_CtrlClickInGame(100, 97)
	_ClickUtilSeeImg("iconDaSungBai", 227, 441) ;Bang TL
	Sleep(150)
	_ClickUtilSeeImg("iconInBangPB", 99, 54)
	_ClickUtilSeeImg("iconDaSungBai", 227, 441) ;Bang PB
	Sleep(150)
	_ClickUtilSeeImg("iconInBangTM", 167, 55)
	_ClickUtilSeeImg("iconDaSungBai", 227, 441) ;Bang TM
;~ 	If $flag = 0 Then Return
;~ 	khu vuc sung bai bxh
	If Third($infoAcc, "9t") Or IniRead($iniFile, "General", "SV", 0) = "SV468" Or IniRead($iniFile, "General", "SV", 0) = "SV472" Or IniRead($iniFile, "General", "SV", 0) = "SV589" Or IniRead($iniFile, "General", "SV", 0) = "SV283" Or IniRead($iniFile, "General", "SV", 0) = "SV281" Or IniRead($iniFile, "General", "SV", 0) = "SV586" Or IniRead($iniFile, "General", "SV", 0) = "SV284" Then
		SungBaiLSV($WindowHandle)
	EndIf

	Run(@ComSpec & ' /c ""C:\Program Files\ImageMagick-7.0.10-Q16\magick" convert "E:\Temp\LDPhoTo\' & $infoAcc[1] & '.jpg" -crop 65x20+520+110 ' & $sFilePathvang & '\' & $infoAcc[1] & '.jpg""', "", @SW_HIDE)
EndFunc   ;==>_ThinhAn

Func SungBaiLSV($WindowHandle)
;~ 	Sleep(500)
;~ 	If $flag = 0 Then Return
	_ClickUtilSeeImg("iconInBangXepHang", 280, 12, 700)
	_OKIF("iconInBangXepHang")
	_CtrlClickInGame(219, 238)
	Sleep(150)
	;_ClickUtilSeeImg("inTlLSV", 218, 440)
	_ClickUtilSeeImg("iconDaSungBaiLSV", 227, 441) ;Bang TM
	Sleep(150)
	_ClickUtilSeeImg("iconBangLSV", 111, 58, 700) ; bang lsv
	Sleep(300)
	_ClickUtilSeeImg("iconDaSungBaiLSV", 227, 441) ;Bang TM
	_ClickUtilSeeImg("inTlLSV", 183, 59)
	_ClickUtilSeeImg("iconDaSungBaiLSV", 227, 441) ;Bang TM
;~  	_CtrlClick($backHandle,279+14, 392)
	;Mbox("Done")
;~ 	Mbox(WinGetHandle("[TITLE:"&WinGetTitle($WindowHandle)&"; CLASS:Qt5QWindowIcon; INSTANCE:7]"))
EndFunc   ;==>SungBaiLSV

Func DoiCode()
	Local $code = IniRead(@ScriptDir & "\Data\Account\file.ini", "General", "code", 0)
	_ClickUtilSeeImg("iconDoiCode", 24, 412)
	Sleep(109)
	_Wait4Image("iconDoiCode")
	Sleep(109)
	_Wait4Image("iconNhapCode")
	Sleep(300)
	_CtrlClickInGame(78, 225, 2)

	ControlSend($WindowHandle, "", "", $code)
;~ 	_SendKeys($render_hwnd, $code)
	Sleep(400)
;~ 	Mbox("Click")
	_CtrlClickInGame(134, 269)
	Sleep(300)
	_CtrlClickInGame(134, 269)
	Sleep(300)

	If _imgSearch("codeVH") Then
		_repeatIconCode($code)
	EndIf

;~ 	_CtrlClickInGame(134, 269)
;~ codeVH
;~ 	_CtrlClickInGame(134, 269)
	_ClickUtilSeeImg("iconDoiCode", 243, 182)
	Sleep(300)
	_CtrlClickInGame(242, 97)

EndFunc   ;==>DoiCode

Func _repeatIconCode($code)
	_ClickUtilSeeImg("iconDoiCode", 243, 182)
	Sleep(400)
	_Wait4Image("iconDoiCode")
	Sleep(209)
	_Wait4Image("iconNhapCode")
	Sleep(400)
	_CtrlClickInGame(78, 225, 2)
	Sleep(300)
	ControlSend($WindowHandle, "", "", $code)
	_CtrlClickInGame(134, 269)
	Sleep(300)
	_CtrlClickInGame(134, 269)
	Sleep(300)
	Sleep(300)
	If _imgSearch("codeVH") Then
		_repeatIconCode($code)
	EndIf
EndFunc   ;==>_repeatIconCode

Func _ChonSV($SVer, $fileIni)
;~ 	Mbox($SVer, 1)
	AdlibUnRegister("ClickSeeDay")
	Local $SVtrimmed = StringTrimLeft($SVer, 2), $tempSVerfile = _ReadIni($fileIni, "General", "SV", 1)
	If StringInStr($SVer, "SV", 1) And $flgMT <> 2 Then
		IniWrite($fileIni, "General", "SV", $SVer)
	EndIf
	AdlibRegister("_ClearApp", 90000)
	Local $grsv = GrSV($SVtrimmed), $SVerfile = GrSV($tempSVerfile)
	While 1
		If $flag = 0 Then Return
		Local $startTime = TimerInit(), $tdif
		While 1
			If $flag = 0 Then Return
			Sleep(10)
;~ 			Local $SVerfile = _ReadIni($fileIni, "General", "SV", 1)

			If _bmbSearch(WinGetTitle($WindowHandle), $grsv) = 1 Then
;~ 				Sleep(400)
;~ 				MsgBox(0, $aPoss[1][0], $aPoss[1][1], 1)
				_ADB_CMD_SLEEP("input tap " & $aPoss[1][0] & " " & $aPoss[1][1] & " ", $port, 550)
;~ 				_CtrlClickInGame($CoorControl[0], $CoorControl[1])
;~ 				_CtrlClickInGame($CoorControl[0], $CoorControl[1])s
;~ 				_CtrlClickInGame($CoorControl[0], $CoorControl[1])

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
;~ 			If _imgSearch("S181",60, 197,82, 342) = 1
			$tdif = TimerDiff($startTime)
			If $tdif > 1000 Then
				ExitLoop
			EndIf
		WEnd
		Sleep(100)
;~
		_ADB_CMD_SLEEP("input swipe 251 800 251 522 1500", $port, 2200)
;~ 		846.5 522



		If StringInStr($SVer, "SV", 1) And $flgMT <> 2 Then
			IniWrite($fileIni, "General", "SV", $SVer)
;~ 			adb -s 127.0.0.1:5557 shell input swipe 200 531 200 866 1000
		EndIf
	WEnd
EndFunc   ;==>_ChonSV

Func _ChonSV1($SVer, $fileIni)
	Mbox($SVer)
	While 1
		If _imgSearch($SVer, 1000) = 1 Then
			_CtrlClickImg($x, $y)
			Mbox("see")
			Return
		EndIf
		Sleep(400)
		_ADB_CMD_SLEEP("input swipe 531 401 531 329", $port, 2200)
	WEnd
EndFunc   ;==>_ChonSV1

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

Func IncrI()
	Local $GenegalFile = @ScriptDir & "\Data\Account\AutoListWrongPass.txt"
	FileWrite($GenegalFile, _curSV() & " ================================" & @CRLF & $tenTK[1] & " " & $tenTK[2] & @CRLF)
	IniWrite($iniFile, "General", "BienI", $iGlobal1 + 1)
	_ClearApp()
EndFunc   ;==>IncrI

Func _checkPWD()
	If _imgSearch("iconSaiMK", 184, 422 + 38, 26, 23) = 1 Or _imgSearch("iconTKKT") = 1 Then
;~ 		MsgBox(0,"","sai pass",19)s
		IncrI()
;~ 		AdlibUnRegister("_checkPWD")
	EndIf
EndFunc   ;==>_checkPWD

Func _ClearApp()
	$flag = 0
;~ 	Mbox($iGlobal1,2)
EndFunc   ;==>_ClearApp

Func ExitToLog($port)
	ControlSend($WindowHandle, "", "", "{ESC}")
	Sleep(500)
	_ClickUtilSeeImg("iconDTK", 86, 268, 300)
EndFunc   ;==>ExitToLog

Func _OKIF($bmp, $x = 0, $y = 0, $x1 = -1, $x2 = -1)
	While 1
		If $flag = 0 Then Return
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", $x, $y, $x1, $x2, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_OKIF

Func _Start($bmpfb, $bmptk, $bmpday) ;seeefb
	While 1
		If $flag = 0 Then Return
		If _imgSearch($bmptk) = 1 Then
;~ 			Mbox("2")
;~ 			Mbox("0")
			Sleep(1000)
			While 1
				If $flag = 0 Then Return
				If _imgSearch($bmpfb) = 1 Then
					Sleep(1000)
;~ 					Mbox("1")
					_ClickUtilSeeImg($bmpday, 136, 288)
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

Func _imgSearch($SVer, $top = 0, $left = 0, $bot = -1, $right = -1)
	Local $startTime = TimerInit(), $tdif

	While 1
		If $flag = 0 Then Return
		Sleep(10)
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $SVer & ".bmp", $top, $left, $bot, $right, 34, 100)
		If Not @error Then
			Sleep(10)
			$x = $Result[1][0] + 3
			$y = $Result[1][1] + 3
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

Func _imgSearchW($SVer, $while = 400, $top = 0, $left = 0, $bot = -1, $right = -1)
	Local $startTime = TimerInit(), $tdif

	While 1
		If $flag = 0 Then Return
		Sleep(10)
		$Result = _HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $SVer & ".bmp", $top, $left, $bot, $right, 34, 100)
		If Not @error Then
			Sleep(10)
			$x = $Result[1][0] + 3
			$y = $Result[1][1] + 3
			Return 1
		Else
			Return 0
		EndIf
		$tdif = TimerDiff($startTime)
		If $tdif > $while Then
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>_imgSearchW

Func _CtrlClickImg($x1, $y1)
	ControlClick($WindowHandle, "", "", "left", 1, $x1, $y1 - 36)
;~ 	Sleep(100)
;~ 	ControlClick($WindowHandle, "", "", "left", 2, $x1, $y1 - 36)
;~ 	Sleep(10)
EndFunc   ;==>_CtrlClickImg

Func _CtrlClickInGame($x1, $y1, $a = 1)
	ControlClick($WindowHandle, "", "", "left", $a, $x1, $y1)
	Sleep(10)
EndFunc   ;==>_CtrlClickInGame

Func _ADB_CMD($command, $port)
	RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell ' & $command, "", @SW_HIDE)
EndFunc   ;==>_ADB_CMD

Func _ADB_CMD_SLEEP($command, $port, $slep = 500)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell ' & $command, "", @SW_HIDE)
	Sleep($slep)
EndFunc   ;==>_ADB_CMD_SLEEP

Func _Wait4Image($bmp, $top = 0, $left = 0, $bot = -1, $right = -1)
;~ 	Mbox("iconDay")
	Sleep(200)
	While 1
;~ 	Mbox("a")
		If $flag = 0 Then Return
		If _imgSearch($bmp, $top, $left, $bot, $right) = 1 Then
			_CtrlClickImg($x, $y)
			Sleep(200)

			Return
		EndIf
	WEnd
EndFunc   ;==>_Wait4Image

Func _ClickUtilSeeImg($bmp, $x1, $y1, $slp = 10)
	While 1
		If $flag = 0 Then Return
		_CtrlClickInGame($x1, $y1)
		Sleep($slp)
		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			Return
		EndIf
	WEnd

EndFunc   ;==>_ClickUtilSeeImg

Func _ClickUtilSeeImgNoSleep($bmp, $x1, $y1)
	Sleep(100)
	While 1
		If $flag = 0 Then Return
		_HandleImgSearch(@ScriptDir & "\Data\Images\" & $bmp & ".bmp", 22, 196, 42, 248, 40, 100)
		If Not @error Then
			;MsgBox(0,"","ok")
			Return
		EndIf
;~ 		_CtrlClickInGame($x1, $y1)
		_CtrlClickInGame($x1, $y1)
	WEnd

EndFunc   ;==>_ClickUtilSeeImgNoSleep

Func QuanGia()
	_OKIF("iconTrangTri")
	While 1
		If $flag = 0 Then Return
;~ 		Mbox("Ưhile")
		If _imgSearch("iconGL", 234, 422, 281, 422) = 1 Then
;~ 			Mbox("GL1")
			Return
		ElseIf _imgSearch("iconQG", 238, 422, 278, 422) = 1 Then
;~ 			Mbox("GL2")
			ExitLoop
		EndIf
	WEnd

	Sleep(300)
	_CtrlClickInGame(257, 413)

;~ 	MouseClick("left", 826, 623, 1, 0)
	_OKIF("inquangia")
	_CtrlClickInGame(230, 252)
;~ 	OKIF("inquangia", 848, 351, 860, 370)
;~ 	MouseClick("left", 800, 400, 1, 0)
	Do
		If $flag = 0 Then Return
;~ 		_imgSearch("fullqg.bmp")
		If _imgSearch("fullqg") = 1 Then
			Sleep(300)
			_CtrlClickInGame(253, 15)
;~ 			MouseClick("left", 253, 15, 1, 0)
			Return
		EndIf
	Until _imgSearch("okqg") = 1
	_Wait4Image("okqg")
	_CtrlClickInGame(253, 15)
;~ 	Wait4Img('okqg.bmp', 648, 726, 648, 726, 663, 746)
	_OKIF("inquangia")
	Sleep(300)
	_CtrlClickInGame(253, 15)
EndFunc   ;==>QuanGia

Func ChinhThu()
	_OKIF("iconTrangTri")

	Sleep(300)
;~ 	_CtrlClickInGame(51, 328)
	Sleep(200)
	While 1
		If _imgSearch("hoaan1", 0, 0, -1, -1) = 1 Or _imgSearch("hoaan2", 0, 0, -1, -1) = 1 Or _imgSearch("hoaan3", 0, 0, -1, -1) = 1 Then
;~ 			Mbox("iconDay")
			_CtrlClickImg($x, $y)
			Sleep(200)
			ExitLoop
		EndIf
	WEnd
;~ 	_Wait4Image("hoaan1")

;~ 	MouseClick("left", 826, 623, 1, 0)
	_OKIF("ThuNhanh")
;~ 	Mbox("1")
	Sleep(1000)
	_CtrlClickInGame(32, 400)
	Sleep(1000)
	_CtrlClickInGame(248, 118)
	Sleep(1000)
EndFunc   ;==>ChinhThu



;~ ================================================================================================================
Func repeatClickHC()
	_CtrlClickInGame(207, 193)
	_CtrlClickInGame(170, 212)
;~ 	AdlibUnRegister("repeatClickHC")
EndFunc   ;==>repeatClickHC

Func repeatClickPopUp()
	_CtrlClickInGame(255, 116)
;~ 	AdlibUnRegister("repeatClickHC")
EndFunc   ;==>repeatClickPopUp


Func Mbox($ndung, $time = 19)
	MsgBox(0, "", $ndung, $time)

EndFunc   ;==>Mbox

Func CloneLSV()
;~ 	$port = $port1
;~ 	$WindowHandle = $WindowHandle1
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf
	Local $fileIni = @ScriptDir & "\Data\Account\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\AutoList" & WinGetTitle($WindowHandle) & ".txt"
	$iniFile = $fileIni
	_ResetNewDay($fileIni)
;~ 			Mbox($iGlobal)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.hd.vngjyp', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 138, 62)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")

		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)


;~ 			Mbox($iGlobal)
		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

			$iGlobal1 = $iGlobal11
;~ 			Mbox($iGlobal1)
;~ 		Mbox($iGlobal1)
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
			If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 Then
					$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1)
				EndIf
				_OKIF("iconDay")
				Sleep(300)
				_ClickUtilSeeImg("iconListServer", 91, 349)
;~ 				AdlibRegister("_ClearApp", 60000)q
				_ChonSV($infoAcc[1], $fileIni)
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
			RaoClone()
			$samePWD = $infoAcc[2] ; Check Same Password

			AdlibRegister("_ClearApp", 30000)


			If $flag = 0 Then ExitLoop
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
			ExitToLog($port)
		Next
		If ProcessExists(WinGetProcess($WindowHandle)) And $flag = 1 Then
			ProcessClose(WinGetProcess($WindowHandle))
			Sleep(2000)
			If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
;~ 				MsgBox(0, "", "60S SHUTDON", 3000)
				Sleep(3000)
				Shutdown(12)
			EndIf
			Exit
		EndIf
	WEnd
EndFunc   ;==>CloneLSV

Func RaoClone()
	_ClickUtilSeeImg("inChat", 208, 451)
	Sleep(700)
	_CtrlClickInGame(153, 479)
	Sleep(700)
	_CtrlClickInGame(153, 479)
	Sleep(800)
	ControlSend($WindowHandle, "", "", "bán clone 10k 1 acc (còn 200 con), nhận sb thỉnh an. Zalo 094.775.9965")
	Sleep(3000)
;~ 	Mbox("1")
	_CtrlClickInGame(245, 478)
	_CtrlClickInGame(245, 478)
	Sleep(1000)
	_CtrlClickInGame(245, 478)

EndFunc   ;==>RaoClone

Func CaptADB($infoAcc)
	If $flag = 0 Then Return
	Local $sv = IniRead($iniFile, 'General', 'SV', 0)
	If ($sv == "SV377" Or $sv == "SV379") And Third($infoAcc, "OtherKNB") == False Then
		$sv = "SV377379"
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
	Local $Source = "C:\Users\Admin\Documents\LDPlayer\Misc\" & $SVnoTrim & ".bmp"
	Local $FindBmp = @ScriptDir & "\Data\Images\S" & $SVtrimmed & ".bmp"
	While 1
		Sleep(10)
		RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell screencap -p /sdcard/Misc/' & $SVnoTrim & '.bmp', "", @SW_HIDE)
		Local $a1 = TimerInit()
		While 1
			$aPoss = _BmpImgSearch($Source, $FindBmp, 0, 0, -1, -1, 90, 500)
;~ 			$aPoss = _BmpImgSearch($Source, $FindBmp, 3800, 300, 35+2, 24+2,90, 500)
			If Not @error Then
				Return 1
			EndIf
			If TimerDiff($a1) > 3001 Then
;~ 				Mbox(TimerDiff($a1))
				Return
			EndIf
		WEnd
	WEnd

EndFunc   ;==>_bmbSearch

Func _ResetNewDay($fileIni)
;~ 	If _ReadIni(@ScriptDir & "\Data\Account\file.ini", "General", "Day", 0) <> @MDAY Then
;~ 		_WriteIni(@ScriptDir & "\Data\Account\file.ini", "General", "Day", @MDAY)
;~ 		IniWrite(@ScriptDir & "\Data\Account\file.ini", "General", "Prison", IniRead(@ScriptDir & "\Data\Account\file.ini", "General", "Prison", 0) + 1) ; increse Prison
;~ 		Mbox(IniRead(@ScriptDir & "\Data\Account\file.ini", "General", "Prison", 0))
;~ 	EndIf
	If _ReadIni($fileIni, "General", "Day", 0) <> @MDAY Then
		_WriteIni($fileIni, "General", "Day", @MDAY)
		_WriteIni($fileIni, "General", "BienI", 1)
		_WriteIni($fileIni, "General", "Prison", _ReadIni($fileIni, "General", "Prison", 0) + 1)
;~ 		IniWrite(@ScriptDir & "\Data\Account\file.ini", "General", "Prison", IniRead(@ScriptDir & "\Data\Account\file.ini", "General", "Prison", 0) + 1) ; increse Prison
		For $i = 0 To (UBound($_Arr_Bang_CH, 1) - 1)
			updateBang($_Arr_Bang_CH[$i][0], 0)
			updateBang($_Arr_Bang_CH[$i][1], 0)
			For $j = 0 To 2
				If $j = 2 Then
					If showBang(Number($_Arr_Bang_CH[$i][$j])) > Number($_Arr_Bang_CH[$i][$j + 1]) Then

						updateBang($_Arr_Bang_CH[$i][$j], 0)
					EndIf
				EndIf
			Next
		Next
;~ 		updateBang("isSTop120", 0)
;~ 		updateBang("isSTop", 0)
;~ 		updateBang("TodayCHBang120", 0)
;~ 		updateBang("TodayCHBang", 0)
;~ 		If showBang("LastCHBang120") > 330 Then
;~ 			updateBang("LastCHBang120", 0)
;~ 		EndIf
;~ 		If showBang("LastCHBang") > 150 Then
;~ 			updateBang("LastCHBang", 0)
;~ 		EndIf

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

Func _SendKeys($hwnd, $keys)
	If $hwnd <= 0 Or StringLen($keys) = 0 Then
		SetError(-1)
		Return False
	EndIf
	$keys = StringUpper($keys)
	Local $i, $ret
	Local $shiftdown = False
	For $i = 1 To StringLen($keys)
		$ret = DllCall("user32.dll", "int", "MapVirtualKey", "int", Asc(StringMid($keys, $i, 1)), "int", 0)
		If IsArray($ret) Then
			If _CheckString(StringMid($keys, $i, 1)) = True Then
				DllCall("user32.dll", "int", "PostMessage", "hwnd", $hwnd, "int", 0x102, "int", Asc(StringMid($keys, $i, 1)), "long", _MakeLong(1, $ret[0]))
			Else
				DllCall("user32.dll", "int", "PostMessage", "hwnd", $hwnd, "int", 0x100, "int", Asc(StringMid($keys, $i, 1)), "long", _MakeLong(1, $ret[0]))
			EndIf
			Sleep(1)
			DllCall("user32.dll", "int", "PostMessage", "hwnd", $hwnd, "int", 0x101, "int", Asc(StringMid($keys, $i, 1)), "long", _MakeLong(1, $ret[0]) + 0xC0000000)
		EndIf
	Next
	Return True
EndFunc   ;==>_SendKeys

Func _MakeLong($LoWord, $HiWord)
	Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc   ;==>_MakeLong

Func _CheckString($keys)
	Local $CheckKey_ = [ _
			'_', _
			'@' _
			]
	For $j = 0 To UBound($CheckKey_) - 1
		If StringInStr($keys, $CheckKey_[$j]) Then
			Return True
			ExitLoop
		EndIf
	Next
	Return False
EndFunc   ;==>_CheckString

Func sumVang()
	$DOS = Run(@ComSpec & ' /k tshark.exe -x -r D:\test1.pcap', "C:\Program Files\Wireshark", @SW_SHOW, $STDOUT_CHILD)

	_OKIF("iconPopup")
	ProcessClose($DOS)

	Local $iPID = Run(@ComSpec & ' /k tshark.exe -x -r D:test1.pcap"', "C:\Program Files\Wireshark", @SW_SHOW, $STDOUT_CHILD)
	Local $a
	While 1
		$sOutput = StdoutRead($iPID)
		If @error Then ExitLoop ; Exit the loop if the process closes or StdoutRead returns an error.
;~ 		MsgBox(0, "Stdout Read:", $sOutput, 1)
		$a = _StringBetween($sOutput, '63 61 73 68 22 3a', '2c')
	WEnd
;~ 	MsgBox(0, "", _HexToString(StringReplace($a[0], " ", "")))
	FileWriteLine("D:\SumVang120.txt", _HexToString(StringReplace($a[0], " ", "")))

EndFunc   ;==>sumVang

Func _AnTiec()
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf

	Local $fileIni = @ScriptDir & "\Data\Account\Tiec\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\Tiec\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	Mbox("Tiec")
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.hd.vngjyp', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 138, 62)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")

		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)
		While 1
;~ 		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

;~ 			$iGlobal1 = $iGlobal11
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal), " ")

;~ 				Mbox($infoAcc[1],1)
			If $infoAcc[1] == "END" Then
;~ 				Mbox("End OF FIle",1)
				IniWrite($fileIni, "General", "BienI", 1)
				_ClearApp()
				ExitLoop
			EndIf
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			If $motiec = 1 And _ReadIni($fileIni, "General", "SV", 1) <> _ReadIni($fileIni, "General", "SV9", 1) Then
				$flgMT = 2
				$infoAcc[1] = _ReadIni($fileIni, "General", "SV9", 1)
			EndIf
			Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
			If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Or $flgMT = 2 Then
				If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 And $flgMT = 0 Then
					$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1)
				EndIf
				_OKIF("iconDay")
				Sleep(300)
				_ClickUtilSeeImg("iconListServer", 91, 349)
;~ 				AdlibRegister("_ClearApp", 60000)q
				_ChonSV($infoAcc[1], $fileIni)
				If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
					_WriteIni($fileIni, "General", "SVDAY", 0)
				EndIf
				If $flgMT = 2 Then
;~ 					Mbox($flgMT)
					$flgMT = 0
					If _ReadIni($fileIni, "General", "SV9", 1) <> _ReadIni($fileIni, "General", "SV", 1) Then
;~ 					ContinueLoop

						_WriteIni($fileIni, "General", "SVDAY", 1)
					EndIf
				Else
					$iGlobal = $iGlobal + 1
					ContinueLoop

				EndIf
			EndIf

;~ 		--------------------------------------------------------------------------------------------------------
			AdlibRegister("_ClearApp", 40000)
			If $motiec = 1 Then
				$infoAcc[1] = _ReadIni($fileIni, "General", "TK", 1)
				$infoAcc[2] = _ReadIni($fileIni, "General", "MK", 1)
			EndIf
			_DoiTK($infoAcc, $samePWD) ;Doi Tai Khoan
			$samePWD = $infoAcc[2] ; Check Same Password
			AdlibRegister("_ClearApp", 30000)
			If $motiec = 1 Then
				_MoTiec()
				$iGlobal = $iGlobal - 2
				_WriteIni($iniFile, "General", "BienI", $iGlobal)
;~ 				ExitLoop
			Else
				_TiecTiec()
			EndIf
			If $flag = 0 Then ExitLoop
			$iGlobal = $iGlobal + 1
			_WriteIni($iniFile, "General", "BienI", $iGlobal)
			ExitToLog($port)
;~ 		Next
		WEnd
	WEnd
EndFunc   ;==>_AnTiec

Func _RegClone()
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf

	Local $fileIni = @ScriptDir & "\Data\Account\RegClone\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\RegClone\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	_ResetNewDay($fileIni)


;~ 			Mbox($iGlobal)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.hd.vngjyp', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 138, 62)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")

		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)


;~ 			Mbox($iGlobal)
		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

			$iGlobal1 = $iGlobal11
;~ 			Mbox($iGlobal1)
;~ 		Mbox($iGlobal1)
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			Sleep(100)

			AdlibRegister("_ClearApp", 40000)
			_DoiTKClone($infoAcc, $samePWD)
			NameClone()

			If $flag = 0 Then ExitLoop

			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
			ExitToLog($port)
		Next

	WEnd
EndFunc   ;==>_RegClone

Func NameClone()
	_OKIF("iconXX")
	_CtrlClickInGame(204, 415)
	Sleep(100)
	_CtrlClickInGame(204, 415)
	Sleep(800)
	_CtrlClickInGame(155, 477)
	_CtrlClickInGame(155, 477)
	_CtrlClickInGame(155, 477)
	_OKIF("iconNext")
EndFunc   ;==>NameClone

Func TanThuClone($WindowHandle1)
	$WindowHandle = $WindowHandle1
	_CtrlClickInGame(38, 345)
;~ 	_ClickUtilSeeImg("TTBTCC", 135, 238,200)
;~ 	Sleep(1000)

;~ 	Mbox("TThoaan")
	_ClickUtilSeeImg("TThoaAn", 135, 238, 200)
;~ 	Mbox("1")
;~ 	_ClickUtilSeeImg("TTKinhNong", 38, 345)
	Sleep(1000)
	_CtrlClickInGame(38, 345)
	Sleep(1000)
	_CtrlClickInGame(38, 345)
	Sleep(1000)
	_CtrlClickInGame(140, 352)
	Sleep(1000)
	_CtrlClickInGame(229, 352)
	Sleep(1000)
	_CtrlClickInGame(244, 113) ; exit tai san kinh doanh
	Sleep(1000)
	_ClickUtilSeeImg("TTGiaNo", 25, 477, 600)
;~ 	Mbox("TTGiaNo")
	Sleep(1000)
	_CtrlClickInGame(51, 126)
	Sleep(1000)
	_ClickUtilSeeImg("TTdoneLV", 228, 251)
	Sleep(1000)
	_ClickUtilSeeImg("TTPB", 256, 28, 600)
	_ClickUtilSeeImg("TTlv1pb", 219, 340, 599) ; click to see VInh QUy CO luy

	Mbox("a")
	Sleep(1000)
	_CtrlClickInGame(359, 599)
	Sleep(1000)
	_ClickUtilSeeImg("TTdonePB", 132, 265)
	Sleep(1000)
	_CtrlClickInGame(263, 96)
	Sleep(1000)
	_CtrlClickInGame(261, 43)
	Mbox("TTGiaNo")
	Sleep(5000)

	_CtrlClickInGame(82, 303)
	Sleep(3000)
	_CtrlClickInGame(82, 303)
	Sleep(1000)

	_CtrlClickInGame(24, 31) ; click nhan vat
	Sleep(1000)
	_CtrlClickInGame(256, 199)
	Sleep(1000)
	_CtrlClickInGame(139, 474)
	Sleep(1000)
	_CtrlClickInGame(139, 474)
	Sleep(1000)
	_CtrlClickInGame(139, 474)
	Sleep(3000)
	_CtrlClickInGame(260, 46)
	Sleep(2000)
	_CtrlClickInGame(260, 46)
	Sleep(2000)
	_CtrlClickInGame(252, 17)
	Sleep(1000)
	Mbox("a")
	_ClickUtilSeeImg("TTTC", 63, 237, 500)
	Sleep(4000)

	Mbox("a")
	_ClickUtilSeeImg("TTclickmn", 245, 34)


	Sleep(5000)
	_CtrlClickInGame(45, 252)
	Sleep(2000)
	_CtrlClickInGame(45, 252)
	Sleep(2000)

	_ClickUtilSeeImg("TTchich", 111, 351)
	Mbox("Chich")
	Sleep(2000)
	_CtrlClickInGame(222, 477)
	Sleep(2000)
	_CtrlClickInGame(257, 29)
	Sleep(2000)
	_CtrlClickInGame(257, 29)

EndFunc   ;==>TanThuClone

Func _TiecTiec()
	While 1
		If $flag = 0 Then Return
		Sleep(1000)
		If _imgSearch("iconEmail", 21, 387, 34 - 21, 396 - 387) = 1 Then
			ExitLoop
		EndIf
	WEnd
	Sleep(500)
	_ADB_CMD("input swipe 710 300 90 300 160", $port)
	Sleep(1000)
	_CtrlClickInGame(215, 345)
	_CtrlClickInGame(215, 345)
	_OKIF("inTiec")
	Sleep(300)
	_CtrlClickInGame(238, 485)
	Sleep(700)
	_CtrlClickInGame(181, 163)
	Sleep(500)
	ControlSend($WindowHandle, "", "", IniRead($iniFile, "General", "MSDT", 0))
	Sleep(333)
	_ClickUtilSeeImg("searchTiec", 187, 190, 1000)
	Sleep(500)
	_CtrlClickInGame(207, 371)
	_OKIF("inChonBan")
	If _imgSearch("fullNho") = 1 Then
		$motiec = 1
		Return
	EndIf
	Sleep(500)
	AdlibRegister("_ClearApp", 30000)
	While 1
		Local $a = TimerInit()
		While 1
			If $flag = 0 Then Return
			If _imgSearch("vaoBan") = 1 Or _imgSearch("vaoBan2") = 1 Then
;~ 				MsgBox(0, $x, $y, 1)

				_CtrlClickImg($x + 1, $y + 10)
				_OKIF("cachDuTiec")
				Sleep(500)
				_CtrlClickInGame(219, 228)
				Return
			EndIf
			If TimerDiff($a) > 400 Then
				ExitLoop
			EndIf
		WEnd
		Sleep(200)
		_ADB_CMD("input swipe 648 950 648 540 500", $port)
		_CtrlClickInGame(265, 282)
		Sleep(500)
	WEnd
EndFunc   ;==>_TiecTiec

Func _MoTiec()
	While 1
		If $flag = 0 Then Return
		Sleep(1000)
		If _imgSearch("iconEmail", 21, 387, 34 - 21, 396 - 387) = 1 Then
			ExitLoop
		EndIf
	WEnd
	Sleep(2000)
	_ADB_CMD("input swipe 710 300 90 300 160", $port)
	Sleep(2000)
	_CtrlClickInGame(215, 345)
	_OKIF("inTiec")
	Sleep(500)
	_CtrlClickInGame(139, 89)
	_Wait4Image("xntiec")
	Sleep(1000)
	_CtrlClickInGame(257, 21)
	Sleep(1000)
	_CtrlClickInGame(139, 89)
	Sleep(2000)
	_CtrlClickInGame(224, 232)
	$motiec = 0
	Sleep(2000)
EndFunc   ;==>_MoTiec


;~ ================================================================================================================ .net

Func checkChuot($WindowHandle1)
	$WindowHandle = $WindowHandle1
	While 1
		_CtrlClickInGame(190, 189)
		If _imgSearch("checkChuot") Then
			Beep(500, 500)

		EndIf
		Sleep(2000)
	WEnd
EndFunc   ;==>checkChuot
