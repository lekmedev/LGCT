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
Global $port, $x = 0, $y = 0, $tenTK, $iniFile, $iGlobal1, $iCVH, $aPos, $aPoss, $rsMod, $sFilePathvang, $render_hwnd, $WindowHandle, $flag = 1, $motiec = 0, $flgMT = 0, $iCode, $code

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
Func AutoMain1()
;~ 	$port = $port1
	Opt("WinTitleMatchMode", 3)
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
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

;~ 			Mbox("1")
		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)


		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

			$iGlobal1 = $iGlobal11
;~ 			Mbox($iGlobal1)
;~ 		Mbox($iGlobal1)
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")
			If $infoAcc[1] == '-' Then
				ContinueLoop
			ElseIf _ReadIni(@ScriptDir & "\Data\Account\file.ini", "General", "code", "") == "" And _curSV() <> "SV49" And $iGlobal1 <> 1 Then
				$flag = 1
				ExitLoop
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

;~ 			Mbox($iGlobal)
			_DoiTK($infoAcc, $samePWD) ;Doi Tai Khoan

;~ 		------------------- del

;~ 	$iCode=_ReadIni( @ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", "General", "iCode", 1)
;~ 	Local $fileListc = @ScriptDir & "\Data\Account\code.txt", $i = $iCode, $count = _FileCountLines($fileListc)
;~ 	_ClickUtilSeeImg("iconDoiCode", 24, 412)
;~ 	Sleep(109)
;~ 	_Wait4Image("iconDoiCode")
;~ 	Sleep(109)
;~ 	_Wait4Image("iconNhapCode")
;~ 	Sleep(300)

;~ 	_CtrlClickInGame(195, 225, 2)
;~ 	Sleep(100)
;~ 	_CtrlClickInGame(195, 191, 2)
;~ 	Sleep(300)
;~ 	_CtrlClickInGame(195, 225, 2)
;~ 	Sleep(100)
;~ 	_OKIF("doneClear")
;~ 	Sleep(100)

;~ 	Local $startTime, $tdif
;~ 	While 1
;~ 		If $flag = 0 Then ExitLoop
;~ 		Sleep(1000)
;~ 		_CtrlClickInGame(195, 225, 2)
;~ 		ControlSend($WindowHandle, "", "", "{BS 20}")
;~ 		AdlibRegister("againCTSend",2500)
;~ 		_OKIF("doneClear")
;~ 		AdlibUnRegister("againCTSend")
;~ 		Sleep(400)
;~ 		$code = FileReadLine($fileListc,$i)

;~ 		AdlibRegister("_ClearApp", 15000)
;~ 		_ADB_CMD("input text " & $code, $port)
;~ 		Sleep(400)
;~ 		_CtrlClickInGame(134, 269)
;~ 			Sleep(330)
;~ 		_CtrlClickInGame(134, 269)
;~ 		Sleep(100)

;~ 		Sleep(1188)

;~ 		_WriteIni(@ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", "General", "iCode", $i)

;~ 		$i += 1

;~ 		If $count = $i Then
;~ 			_WriteIni(@ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", "General", "iCode", 1)
;~ 			ExitLoop

;~ 		EndIf
;~ 	WEnd

;~ 		------------------- del
			If _ReadIni(@ScriptDir & "\Data\Account\file.ini", "General", "code", "") <> "" Then
				DoiCode()
			EndIf

;~ 			If (_curSV() = "SV49" Or _curSV() = "SV284" Or _curSV() = "SV279") Then
;~  				_Mail()
;~  			EndIf

			$samePWD = $infoAcc[2] ; Check Same Password

			AdlibRegister("_ClearApp", 30000)
			If _curSV() = "SV49" Then
				_ThinhAn($infoAcc) ; Done Sung Bai Thinh An
				_CHBang()
			EndIf
			If $flag = 0 Then ExitLoop
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
;~ 			mbox("etlog",14)
			ExitToLog()
		Next
		If ProcessExists(WinGetProcess($WindowHandle)) And $flag = 1 Then
;~ 			If WinGetTitle($WindowHandle) = "2" Then
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
;~ 				mbox(WinGetTitle($WindowHandle))
			ShellExecuteWait("E:\App\AutoLGCTLDPlayer\war" & WinGetTitle($WindowHandle) & ".au3")
			Exit
			ProcessClose(WinGetProcess($WindowHandle))
			Sleep(2000)
			If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
;~ 				MsgBox(0, "", "60S SHUTDON", 3000)
;~ 				Run(@ComSpec & ' /c ChangeScreenResolution.exe /f=75 /d=0', @SystemDir, @SW_HIDE)
				Sleep(30000)
				Shutdown(12)
			EndIf
			Exit
		EndIf
	WEnd
EndFunc   ;==>AutoMain1

Func againCTSend()
	Sleep(500)
	_ADB_CMD("input tap 535 568  ", $port)
	_ADB_CMD("input tap 535 568  ", $port)
;~ 	Mbox(WinGetTitle($WindowHandle),1)
	_CtrlClickInGame(195, 225, 2)
	ControlSend($WindowHandle, "", "", "{BS 20}")
EndFunc   ;==>againCTSend
Func checkCVH()
	If _imgSearch("codeVH") Then
		_repeatIconCode2($code)
;~ 		$iCVH = -1
	EndIf
;~ 	AdlibUnRegister("checkCVH")
EndFunc   ;==>checkCVH

Func ChoSaleMat()
;~ 	$port = $port1
;~ 	$WindowHandle = $WindowHandle1
	Mbox("Mat", 22)
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf
	Local $fileIni = @ScriptDir & "\Data\Account\ChoSaleMat\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\ChoSaleMat\AutoList" & WinGetTitle($WindowHandle) & ".txt"
;~ 	Local $fileIni = @ScriptDir & "\Data\Account\ChoSaleMat\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\ChoSaleMat\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	_ResetNewDay($fileIni)


;~ 			Mbox($iGlobal)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")
;~ 	Mbox("Mat", 22)
		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)


;~ 			Mbox($iGlobal)
		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

			$iGlobal1 = $iGlobal11
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")
			If $infoAcc[1] == '-' Then
				ContinueLoop
;~ 			ElseIf  _curSV() <> "SV49" And $iGlobal1 <> 1 Then
;~ 				Exit
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

			AdlibRegister("_ClearApp", 30000)

			_MuaChoSaleMat()



			If $flag = 0 Then ExitLoop
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
			ExitToLog()
		Next
		If ProcessExists(WinGetProcess($WindowHandle)) And $flag = 1 Then
			ProcessClose(WinGetProcess($WindowHandle))
			Sleep(2000)
			If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
;~ 				MsgBox(0, "", "60S SHUTDON", 3000)
				Sleep(30000)
				Shutdown(12)
			EndIf
			Exit
		EndIf

	WEnd
EndFunc   ;==>ChoSaleMat

Func ChoSale()
;~ 	$port = $port1
;~ 	$WindowHandle = $WindowHandle1
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf
	Local $fileIni = @ScriptDir & "\Data\Account\ChoSale\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\ChoSale\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	_ResetNewDay($fileIni)
;~ 			Mbox($iGlobal)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
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
			ElseIf _ReadIni(@ScriptDir & "\Data\Account\file.ini", "General", "code", "") == "" And _curSV() = "SV102" And $iGlobal1 <> 1 Then
				Exit
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

			AdlibRegister("_ClearApp", 30000)

			_MuaChoSale()



			If $flag = 0 Then ExitLoop
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
			ExitToLog()
		Next
		If ProcessExists(WinGetProcess($WindowHandle)) And $flag = 1 Then
			ProcessClose(WinGetProcess($WindowHandle))
			Sleep(2000)
			If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
;~ 				MsgBox(0, "", "60S SHUTDON", 3000)
				Sleep(30000)
				Shutdown(12)
			EndIf
			Exit
		EndIf

	WEnd
EndFunc   ;==>ChoSale

Func _MuaChoSale()

	_CtrlClickInGame(280, 28)
	Sleep(800)
	_CtrlClickInGame(204, 83)
	Sleep(800)
	_CtrlClickInGame(94, 83)
	Sleep(800)
;~ 	AdlibRegister("_againChoSale", 6000)
	_againChoSale()
EndFunc   ;==>_MuaChoSale

Func _MuaChoSaleMat()

	_CtrlClickInGame(280, 28)
	Sleep(800)
;~	_CtrlClickInGame(252, 90)
	_CtrlClickInGame(205, 83)
	Sleep(800)
	_CtrlClickInGame(94, 83)
	Sleep(800)
;~ 	AdlibRegister("_againChoSale", 6000)
	_againChoSaleMat()
EndFunc   ;==>_MuaChoSaleMat

Func _againChoSaleMat()
	_ADB_CMD("input swipe 63 1274 62 299 510", $port)
	_ADB_CMD("input swipe 63 1274 62 299 510", $port)
	Sleep(1000)
	_ADB_CMD("input swipe 63 512 63 800 1550", $port)  ;xoa khi mua than mat ca nhan
	_ADB_CMD("input swipe 63 512 63 800 1550", $port)  ;xoa khi mua than mat ca nhan
	AdlibRegister("_ClearApp", 7000)
	Sleep(1000)
	AdlibRegister("_ClearApp", 35000)
	While 1
		If $flag = 0 Then Return
;~	_CtrlClickInGame(222, 188);mua mat ca nhan
		_CtrlClickInGame(224, 380)   ; mua mat bang
		Sleep(500)
		If _imgSearch("maxMat") = 1 Then
			ExitLoop
		EndIf
		If _imgSearch("knbkdu") = 1 Then
			ExitLoop
		EndIf
	WEnd

	Sleep(1000)
	AdlibRegister("_ClearApp", 35000)
	While 1
		If $flag = 0 Then Return
;~_CtrlClickInGame(224, 323);mua mat ca nhan
		_CtrlClickInGame(224, 244)   ;mua mat bang
		Sleep(500)
		If _imgSearch("maxMat") = 1 Then
			ExitLoop
		EndIf
		If _imgSearch("knbkdu") = 1 Then
			ExitLoop
		EndIf
	WEnd

	Sleep(1000)
EndFunc   ;==>_againChoSaleMat

Func _againChoSale()
;~ 	Mbox("1")
	_ADB_CMD("input swipe 63 1274 62 299 510", $port)
	_ADB_CMD("input swipe 63 1274 62 299 510", $port)
	Sleep(1000)
	_ADB_CMD("input swipe 63 312 63 800 1550", $port)
	_ADB_CMD("input swipe 63 312 63 800 1550", $port)
	Sleep(1100)
	AdlibRegister("_ClearApp", 3000)
;~ Mbox("1")
	Sleep(1100)
	While 1
		If $flag = 0 Then Return
		If _imgSearch("HungBang") = 1 Then
			ExitLoop
		ElseIf _imgSearch("HungBang1") = 1 Then
			ExitLoop
		EndIf
	WEnd
	If _imgSearch("HungBang") Or _imgSearch("HungBang1") Then
;~ 		AdlibUnRegister("_ClearApp")
		AdlibRegister("_ClearApp", 15000)
;~ Mbox("1")
		While 1
			If $flag = 0 Then Return
			_CtrlClickImg($x + 54, $y + 39)
			Sleep(500)
			If _imgSearch("maxHB") = 1 Then
				ExitLoop
			EndIf
			If _imgSearch("knbkdu") = 1 Then
				ExitLoop
			EndIf
		WEnd
	EndIf
	Sleep(1100)
	If _imgSearch("QuaTiec") Then
;~ Mbox("1")
		While 1
			If $flag = 0 Then Return
			_CtrlClickImg($x + 54, $y + 39)
			Sleep(500)
			If _imgSearch("maxHB") = 1 Then
				ExitLoop
			EndIf
			If _imgSearch("knbkdu") = 1 Then
				ExitLoop
			EndIf
		WEnd
	EndIf
EndFunc   ;==>_againChoSale

Func AutoMain()
;~ 	_RegClonePhase0()
;~ 	_RegClonePhase1()
;~ 	_RegClonePhase2()
;~  ChoSale()
;~ChoSaleMat()

	AutoMain1()

;~ 	_WrapperRegClone()
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
	AdlibRegister("_ClearApp", 40000)
	Sleep(1000)
	Opt("WinTitleMatchMode", 3)
	While 1
		If $flag = 0 Then Return
		_CtrlClickInGame(280, 14)
		Sleep(1000)
		If _imgSearch("iconEmail") = 1 Then
			ExitLoop
		EndIf
	WEnd
	Sleep(200)
	_ADB_CMD("input swipe 710 300 90 300 200", $port)
	Sleep(1000)
;~ 	Mbox("1")
	_CtrlClickInGame(87, 304)
	Sleep(1000)

	_OKIF("iconInBang")
	Sleep(500)
;~ 	-------------------- van tieu

	If _imgSearchW("netVT", 1000) = 1 Then
		_ADB_CMD("input swipe 528 1081 528 890 300", $port)
;~ 		Sleep(1000)
		_CtrlClickInGame(44, 416)
;~ 		Mbox("1")
	ElseIf _imgSearchW("pbang", 1000) = 1 Then
		_ADB_CMD("input swipe 528 1081 528 890 300", $port)
		Sleep(1000)
		_CtrlClickInGame(44, 416)
	Else
		_CtrlClickInGame(235, 420)
	EndIf
;~ 	----------------- addition nhan tieu




;~ end addition
;~

;~ 	Mbox("1")
	Sleep(400)
	_OKIF("inQuestVT")
	Sleep(700)
	_CtrlClickInGame(142, 107)
	AdlibRegister("vtClick", 2500)
	Sleep(1000)
	If _imgSearchW("inDi", 1000) Then
		Return
	EndIf
	AdlibUnRegister("vtClick")
	_ClickUtilSeeImg("inVT", 141, 299, 500)
	Sleep(600)
	_OKIF("inVT")
	If @MDAY = 16 Then
		_CtrlClickInGame(63, 454)
		Sleep(700)
		For $i = 1 To 30
			_CtrlClickInGame(199, 268)
		Next
		Sleep(500)
		_CtrlClickInGame(140, 304)
		Sleep(800)
	EndIf

	_CtrlClickInGame(132, 72)
	Sleep(600)
	_OKIF("inphai")
	Sleep(500)
	If _imgSearchW("phaiVT", 2000) = 1 Then
		_ClickUtilSeeImg("dphai", $x, $y - 36)
	ElseIf _imgSearch("dphai") = 1 Then
;~ 		Sleep(400)
;~ 		_CtrlClickImg($x, $y)
	EndIf
	Sleep(600)
	_CtrlClickInGame(139, 420)
	Sleep(600)
	_CtrlClickInGame(237, 454)

EndFunc   ;==>_CHBang

Func vtClick()
	Sleep(500)
	_CtrlClickInGame(142, 107)
	AdlibUnRegister("vtClick")
EndFunc   ;==>vtClick

Func showBang($willCH1)
	Return IniRead($iniFile, "CHBANG", $willCH1, 0)
EndFunc   ;==>showBang

Func updateBang($willCH, $value)
	IniWrite($iniFile, "CHBANG", $willCH, $value)
EndFunc   ;==>updateBang

Func ClickDTK()
;~ 	_CtrlClickInGame(38, 477)
;~ 	_CtrlClickInGame(38, 477)

;~ 	Mbox("1")
	_ADB_CMD("input tap 109 1228 ", $port)

EndFunc   ;==>ClickDTK

;~ netVT

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

Func _DoiTK($infoAcc, $samePWD)
	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconDay") = 1 Then
			ExitLoop
		ElseIf _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd
;~ 	Mbox("2")
	AdlibRegister("ClickDTK", 4000)
	Sleep(200)
	AdlibUnRegister("ClickSeeDay")
	_Wait4Image("iconDTK")
	_CtrlClickInGame(140, 286)
	Sleep(500)
	_OKIF("iconTK", 241, 276, 259 - 241, 289 - 276)
	AdlibUnRegister("ClickDTK")
;~ 	Mbox("1")
	Sleep(500)


	_CtrlClickInGame(205, 189)
	Sleep(300)
	_CtrlClickInGame(205, 189)
	ControlSend($WindowHandle, "", "", "{BS 33}")
	Sleep(300)
	_CtrlClickInGame(205, 189)
	ControlSend($WindowHandle, "", "", "{BS 33}")

	Sleep(400)

	_OKIF("iconBS")
	Sleep(250)
	_CtrlClickInGame(205, 189)
	_ADB_CMD("input text " & $infoAcc[1], $port)
	If Not ($samePWD = $infoAcc[2]) Then
		Sleep(200)
		_CtrlClickInGame(205, 228)
		Sleep(200)
		ControlSend($WindowHandle, "", "", "{BS 36}")
		_OKIF("iconBS2")
		_ADB_CMD("input text " & $infoAcc[2], $port)
	EndIf
	_CtrlClickInGame(136, 289)
	_CtrlClickInGame(136, 289)
	Sleep(100)
	_CtrlClickInGame(136, 289)
	Sleep(300)
	AdlibRegister("_checkPWD", 1500) ;ADLIB
	Sleep(200)
	_ADB_CMD("input keyevent 4", $port)
	_ADB_CMD("input keyevent 4", $port)
	_ADB_CMD("input keyevent 4", $port)
	Sleep(200)
	_CtrlClickInGame(194, 269)
	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconDay") = 1 Then
			ExitLoop
		ElseIf _imgSearch("iconMoi") = 1 Then
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
		If _imgSearch("iconXX") = 1 Then
			IniWrite($iniFile, "General", "SVDAY", 1)
			Local $GenegalFile = @ScriptDir & "\Data\Account\AutoListWrongPass.txt"
			FileWrite($GenegalFile, _curSV() & " ================================SVDay" & @CRLF & $tenTK[1] & " " & $tenTK[2] & @CRLF)
			_ClearApp()
		EndIf
	Until _imgSearch("iconTrangTri") = 1
;~ 	Until _imgSearch("iconPopup") = 1
;~ 	Sleep(1000)
;~ 	If _imgSearch("iconPopup") = 1 Then
;~ 		_CtrlClickImg($x, $y )
;~ 	EndIf ; Xoa Temp
;~ 	---------------



	_OKIF("iconTrangTri")

;~ 	_fullNV()

;~ 	AdlibUnRegister("ClickAgain")
;~ 	If Third($infoAcc, "qgia") Then
;~ 		QuanGia()
;~ 		_OKIF("iconTrangTri")
;~ 	ElseIf Third($infoAcc, "cthu") Then
;~ 		ChinhThu()
;~ 		_OKIF("iconTrangTri")
;~ 	EndIf
	_ClickUtilSeeImg("iconEmail", 280, 28, 700)
;~ 	_CtrlClickInGame()
	_OKIF("iconEmail")

EndFunc   ;==>_DoiTK




Func _fullNV()
	If _curSV() <> "SV102" Then
		Return
	EndIf
	AdlibRegister("_ClearApp", 70000)
	_OKIF("iconTrangTri")
	Sleep(500)
	_CtrlClickInGame(221, 379)
	Sleep(1000)
	_CtrlClickInGame(248, 97)
	Sleep(2000)
	_CtrlClickInGame(38, 97)
	Sleep(2000)
	_CtrlClickInGame(266, 41)
	_OKIF("iconTrangTri")
	_CtrlClickInGame(214, 231)
	Sleep(1000)

	_CtrlClickInGame(231, 471)
	Sleep(1300)
	_CtrlClickInGame(231, 471)
	Sleep(900)
	_CtrlClickInGame(231, 471)
	Sleep(2000) ;tham hoi
	_CtrlClickInGame(263, 43)
	Sleep(1000)


	_CtrlClickInGame(18, 201)
	Sleep(1000)
	_CtrlClickInGame(159, 382)
	Sleep(1000)

	_CtrlClickInGame(65, 339)
	Sleep(700)
	_CtrlClickInGame(65, 339)
	Sleep(700)
	_CtrlClickInGame(65, 339)
	Sleep(1000)
	_CtrlClickInGame(260, 18)

	Sleep(1000)
	_CtrlClickInGame(96, 421)
	Sleep(1000)
	_CtrlClickInGame(229, 481)
	If _imgSearch("huy") Then
		_CtrlClickInGame(195, 285)
		Sleep(400)
	EndIf
	Sleep(1000)
	_CtrlClickInGame(256, 18)
	_ClickUtilSeeImg("iconTrangTri", 264, 22, 1000)
	Sleep(1000)
	_CtrlClickInGame(22, 472)
	Sleep(1000)
	_CtrlClickInGame(48, 121) ; click chon hoa an
	Sleep(1000)
	If _imgSearch("CHSACH", 18, 332, 267 - 18, 408 - 332) Then
		_CtrlClickInGame($x + 18, $y + 332)
		Sleep(1000)
		_CtrlClickInGame(222, 268)
		Sleep(2400)
		_CtrlClickInGame(221, 335)
		Sleep(2400)
		_CtrlClickInGame(219, 403)
		Sleep(2400)
		_CtrlClickInGame(259, 135)
		Sleep(2400)
		_CtrlClickInGame(272, 16)

;~ 	Mbox("Done Hoa An")
		_ClickUtilSeeImg("iconTrangTri", 276, 44, 1000)
	EndIf
EndFunc   ;==>_fullNV

Func _fullNV2()
	AdlibRegister("_ClearApp", 70000)

	_OKIF("iconTrangTri")
	Sleep(200)
	_ClickUtilSeeImg("inTV", 219, 426, 1000) ; click thầy
	Sleep(200)
	_CtrlClickInGame(221, 379)
	Sleep(1000)
	_CtrlClickInGame(248, 97)
	Sleep(2000)
	_CtrlClickInGame(38, 97)
	Sleep(2000)
	_CtrlClickInGame(280, 41)
	_OKIF("iconTrangTri")
	_ClickUtilSeeImg("inHT", 214, 231, 1000) ; click hoi tham
	Sleep(300)
	_CtrlClickInGame(231, 471)
	Sleep(1300)
	_CtrlClickInGame(231, 471)
	Sleep(1300)
	_CtrlClickInGame(231, 471)
	Sleep(2000)
	_CtrlClickInGame(280, 43) ; out tham hoi
	Sleep(1000)

;~ 	If Third($infoAcc, "cthu") Then
;~ 		ChinhThu()
;~ 		_OKIF("iconTrangTri")
;~ 	EndIf


	_CtrlClickInGame(18, 201)
	Sleep(1000)
	_CtrlClickInGame(159, 382) ; click con
	Sleep(1000)


	_CtrlClickInGame(65, 339) ; hoi phuc nhanh
	Sleep(1000)

	_ClickUtilSeeImg("iconHP", 219, 340, 700)
	If _imgSearch("huyNC") Then
		_CtrlClickImg($x, $y)
	EndIf
	_ClickUtilSeeImg("inbmoi", 275, 18, 1100)

	_CtrlClickInGame(96, 421)
	Sleep(1000)
	_CtrlClickInGame(229, 481) ; hoi phuc tinh luc

	Sleep(2000)
	_ClickUtilSeeImg("inFuck", 250, 449, 1000)
	Sleep(1000)
	_CtrlClickInGame(229, 481) ; hoi phuc tinh luc
	Sleep(2000)
	_CtrlClickInGame(229, 481) ; hoi phuc tinh luc


	_CtrlClickInGame(256, 18)
	_ClickUtilSeeImg("iconTrangTri", 280, 22, 1000)
	Sleep(1000)

	_CtrlClickInGame(22, 472)
	Sleep(1000)
	_CtrlClickInGame(48, 121) ; click chon hoa an
	Sleep(1000)
	If _imgSearch("CHSACH", 18, 332, 267 - 18, 408 - 332) Then
		_CtrlClickInGame($x + 18, $y + 332)
		Sleep(1000)
		_CtrlClickInGame(222, 268)
		Sleep(2400)
		_CtrlClickInGame(221, 335)
		Sleep(2400)
		_CtrlClickInGame(219, 403)
		Sleep(2400)
		_CtrlClickInGame(259, 135)
		Sleep(2400)
		_CtrlClickInGame(279, 16)

		_ClickUtilSeeImg("iconEmail", 277, 17, 1000)

	EndIf

	_CtrlClickInGame(90, 388)
	Sleep(300)
	_CtrlClickInGame(90, 388)
;~ 	Sleep(1000)
	_OKIF("inCDTL")
	_CtrlClickInGame(236, 474)
	Sleep(3300)
	_ClickUtilSeeImg("iconEmail", 280, 17, 1000)
	_ADB_CMD("input swipe 710 300 90 300 200", $port)
	Sleep(600)
	_CtrlClickInGame(48, 227)
	Sleep(300)
	_CtrlClickInGame(48, 227)
	_OKIF("inLT")
	_CtrlClickInGame(28, 468)
	Sleep(700)

	For $i = 1 To 9
		_CtrlClickInGame(222, 261)
		Sleep(300)
	Next
	_CtrlClickInGame(138, 307)
	_ClickUtilSeeImg("inLT", 242, 99, 1000) ;done loan tac chua out





EndFunc   ;==>_fullNV2


Func ClickAgain()
	If _imgSearch("iconPopup") = 1 Then
		_CtrlClickImg($x, $y)
	EndIf
	AdlibUnRegister("ClickAgain")
EndFunc   ;==>ClickAgain

Func _DoiTKClone($infoAcc, $samePWD)
	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd

;~ 	Mbox("2")
	AdlibRegister("ClickDTK", 4000)
	Sleep(200)
	AdlibUnRegister("ClickSeeDay")
	_Wait4Image("iconDTK")
	AdlibUnRegister("ClickDTK")
	_CtrlClickInGame(140, 286)
	Sleep(500)
	_OKIF("iconTK", 241, 276, 259 - 241, 289 - 276)
;~ 	Mbox("1")
	Sleep(500)


	_CtrlClickInGame(205, 189)
	Sleep(300)
	_CtrlClickInGame(205, 189)
	ControlSend($WindowHandle, "", "", "{BS 33}")

	Sleep(100)

	_OKIF("iconBS")
	Sleep(250)
	_CtrlClickInGame(205, 189)
	_ADB_CMD("input text " & $infoAcc[1], $port)
	If Not ($samePWD = $infoAcc[2]) Then
		Sleep(200)
		_CtrlClickInGame(205, 228)
		Sleep(200)
		ControlSend($WindowHandle, "", "", "{BS 36}")
		_OKIF("iconBS2")
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
		If _imgSearch("iconDay49") = 1 Then
			ExitLoop
		ElseIf _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd
	AdlibUnRegister("_checkPWD")
	Sleep(500)

	_CtrlClickInGame(142, 415)
;~ 	Sleep(1000)
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

Func clone1($infoAcc, $samePWD)
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
EndFunc   ;==>clone1

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
		Case 185, 320, 585
			$Phu = $_Nhiep_Chinh
		Case 148, 149
			$Phu = $_Cung_Than
		Case 396
			$Phu = $_Van_Tuyen
		Case 49
			$Phu = $_Tieu_Dao
		Case 407, 586, 279, 284, 287
			$Phu = $_Binh_Tay
		Case 381, 182, 380, 416, 417, 433, 461
			$Phu = $_Tran_Nam
		Case Else
			$Phu = $_Thai_Hoa
	EndSwitch

;~ 	----------------------------- chon phu sung bai
	Sleep(100)
	_CtrlClickInGame($Phu[0], $Phu[1])
	_ClickUtilSeeImg("iconDaNhan", 243, 496, 400)
;~ 	Mbox("DaNhan",1)f
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
	If Third($infoAcc, "9t") Or IniRead($iniFile, "General", "SV", 0) = "SV120" Or IniRead($iniFile, "General", "SV", 0) = "SV280" Or IniRead($iniFile, "General", "SV", 0) = "SV589" Or IniRead($iniFile, "General", "SV", 0) = "SV283" Or IniRead($iniFile, "General", "SV", 0) = "SV281" Or IniRead($iniFile, "General", "SV", 0) = "SV586" Or IniRead($iniFile, "General", "SV", 0) = "SV284" Then
		SungBaiLSV($WindowHandle)
	EndIf

;~ 	Run(@ComSpec & ' /c ""C:\Program Files\ImageMagick-7.0.10-Q16\magick" convert "E:\Temp\LDPhoTo\' & $infoAcc[1] & '.jpg" -crop 65x20+520+110 ' & $sFilePathvang & '\' & $infoAcc[1] & '.jpg""', "", @SW_HIDE)
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

Func codeTT($doneCode)
	If $iCode < 45 Then
		If $doneCode = 1 Then Return

		AdlibRegister("_ClearApp", 110000)
		Local $fileList = @ScriptDir & "\Data\Account\code.txt", $i = $iCode, $count = _FileCountLines($fileList)
		_ClickUtilSeeImg("iconDoiCode", 24, 412)
		Sleep(109)
;~ 		func here~
		While 1
;~ 			Mbox(1)
			_Wait4Image("iconDoiCode")
			Sleep(109)
			_Wait4Image("iconNhapCode")
			Sleep(300)

			_CtrlClickInGame(195, 225, 2)
			Sleep(100)
;~ 			_CtrlClickInGame(195, 191, 2)
;~ 			Sleep(300)
;~ 			_CtrlClickInGame(195, 225, 2)
;~ 			Sleep(100)
;~ 			_OKIF("doneClear")
;~ 			Sleep(100)

;~ 			Sleep(1000)
			_CtrlClickInGame(195, 225, 2)
			ControlSend($WindowHandle, "", "", "{BS 20}")
;~ 	_OKIF("doneClear")
			Sleep(400)
			$code = FileReadLine($fileList, $i)
;~ 			Mbox($fileList)
			_ADB_CMD("input text " & $code, $port)
			Sleep(300)
			AdlibRegister("_ClearApp", 11000)
			While 1
				If $flag = 0 Then Return
;~ 			Mbox("flag")
				Sleep(330)
				_CtrlClickInGame(134, 269)
				If _imgSearch("doneCode") Or _imgSearch("doneCode1.bmp") Or _imgSearch("doneCode3.bmp") Or _imgSearch("doneCode2.bmp") Then
					Sleep(600)
					_CtrlClickInGame(245, 182, 2)
					AdlibRegister("_ClearApp", 11000)
					ExitLoop
				ElseIf _imgSearch("codeVH") Then
					_repeatIconCode2($code)
				EndIf
			WEnd

;~ 			AdlibRegister("_ClearApp", 7000)
			Sleep(1188)
			$i += 1

;~ 			MsgBox(0, $count, $i, 1)
			_WriteIni(@ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", "General", "iCode", $i)
			If $count = $i Then
				MsgBox(0, $count, $i, 1)
				ExitLoop
			EndIf
		WEnd


;~ 	 kho do

		AdlibRegister("_ClearApp", 29000)
		Sleep(1000)
		_CtrlClickInGame(246, 182, 2)
		Sleep(1000)
		_CtrlClickInGame(243, 88, 2)
	EndIf
	Sleep(1000)
	_CtrlClickInGame(72, 474, 2)
	Sleep(700)
;~ 	_OKIF("vip1k2")
	While 1
		If _imgSearch("vip1k2") Or _imgSearch("vip1k21") Or _imgSearch("vip1k22") Then
			Mbox("1", 1)
			_CtrlClickImg($x, $y)
			ExitLoop
		EndIf
	WEnd
;~ 	_Wait4Image("vip1k2")
	Sleep(800)
	_CtrlClickInGame(146, 469, 2)
	Sleep(600)
	For $i = 1 To 8
		Sleep(10)
		_CtrlClickInGame(232, 275, 2)
	Next
	Sleep(600)
	_CtrlClickInGame(143, 313, 2)
	Sleep(1000)
;~ 	_Wait4Image("binh")
	_OKIF("binh")
	If _imgSearch("binh") Then
		_CtrlClickImg($x, $y)
	EndIf
	Sleep(800)
	_CtrlClickInGame(146, 469, 2)
	Sleep(600)
	For $i = 1 To 35
		Sleep(10)
		_CtrlClickInGame(232, 275, 2)
	Next
	Sleep(600)
	_CtrlClickInGame(143, 313, 2)
	Sleep(1000)
	_CtrlClickInGame(264, 42, 1)
;~ 	kho do

	$doneCode = 1
EndFunc   ;==>codeTT


Func codeTT1($doneCode)
	If $iCode < 45 Then
		If $doneCode = 1 Then Return

		AdlibRegister("_ClearApp", 110000)
		Local $fileList = @ScriptDir & "\Data\Account\code.txt", $i = $iCode, $count = _FileCountLines($fileList)
		_ClickUtilSeeImg("iconDoiCode", 24, 412)
		Sleep(109)
		_Wait4Image("iconDoiCode")

		Sleep(109)
		_Wait4Image("iconNhapCode")
		Sleep(300)

		_CtrlClickInGame(195, 225, 2)
		Sleep(100)
		_CtrlClickInGame(195, 191, 2)
		Sleep(300)
		_CtrlClickInGame(195, 225, 2)
		Sleep(100)
		_OKIF("doneClear")
		Sleep(100)
		While 1
			Sleep(1000)
			_CtrlClickInGame(195, 225, 2)
			ControlSend($WindowHandle, "", "", "{BS 20}")
;~ 	_OKIF("doneClear")
			Sleep(400)
			$code = FileReadLine($fileList, $i)
			_ADB_CMD("input text " & $code, $port)
			Sleep(300)
			AdlibRegister("_ClearApp", 11000)
			While 1
				If $flag = 0 Then Return
;~ 			Mbox("flag")
				Sleep(330)
				_CtrlClickInGame(134, 269)
				If _imgSearch("doneCode") Or _imgSearch("doneCode1.bmp") Or _imgSearch("doneCode3.bmp") Or _imgSearch("doneCode2.bmp") Then
					AdlibRegister("_ClearApp", 11000)
					ExitLoop
				ElseIf _imgSearch("codeVH") Then
					_repeatIconCode2($code)
				EndIf
			WEnd
;~ 			AdlibRegister("_ClearApp", 7000)
			Sleep(1188)
			$i += 1

;~ 			MsgBox(0, $count, $i, 1)
			_WriteIni(@ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", "General", "iCode", $i)
			If $count = $i Then
				MsgBox(0, $count, $i, 1)
				ExitLoop
			EndIf
		WEnd


;~ 	 kho do

		AdlibRegister("_ClearApp", 29000)
		Sleep(1000)
		_CtrlClickInGame(246, 182, 2)
		Sleep(1000)
		_CtrlClickInGame(243, 88, 2)
	EndIf
	Sleep(1000)
	_CtrlClickInGame(72, 474, 2)
	Sleep(700)
;~ 	_OKIF("vip1k2")
	While 1
		If _imgSearch("vip1k2") Or _imgSearch("vip1k21") Or _imgSearch("vip1k22") Then
			Mbox("1", 1)
			_CtrlClickImg($x, $y)
			ExitLoop
		EndIf
	WEnd
;~ 	_Wait4Image("vip1k2")
	Sleep(800)
	_CtrlClickInGame(146, 469, 2)
	Sleep(600)
	For $i = 1 To 8
		Sleep(10)
		_CtrlClickInGame(232, 275, 2)
	Next
	Sleep(600)
	_CtrlClickInGame(143, 313, 2)
	Sleep(1000)
;~ 	_Wait4Image("binh")
	_OKIF("binh")
	If _imgSearch("binh") Then
		_CtrlClickImg($x, $y)
	EndIf
	Sleep(800)
	_CtrlClickInGame(146, 469, 2)
	Sleep(600)
	For $i = 1 To 35
		Sleep(10)
		_CtrlClickInGame(232, 275, 2)
	Next
	Sleep(600)
	_CtrlClickInGame(143, 313, 2)
	Sleep(1000)
	_CtrlClickInGame(264, 42, 1)
;~ 	kho do

	$doneCode = 1
EndFunc   ;==>codeTT1

Func _repeatIconCode2($a)
;~ 	Sleep(1000)
;~ 	_CtrlClickInGame(195, 225, 2)
;~ 	ControlSend($WindowHandle, "", "", "{BS 20}")
;~ 	Sleep(400)
;~ 	_ADB_CMD("input text " & $code, $port)
;~ 	Sleep(300)f
;~ 	While 1
;~ 		Sleep(10)
;~ 		_CtrlClickInGame(134, 269)
;~ 		If _imgSearch("doneCode") Then
;~ 			ExitLoop
;~ 		ElseIf _imgSearch("codeVH") Then
;~ 			_repeatIconCode2($code)
;~ 		EndIf
;~ 	WEnd

;~ 	While 1
	Sleep(1000)
	_CtrlClickInGame(195, 225, 2)
	ControlSend($WindowHandle, "", "", "{BS 20}")
	_OKIF("doneClear")
	Sleep(400)
	_ADB_CMD("input text " & $code, $port)
;~ 		Mbox($code)
	Sleep(400)
	_CtrlClickInGame(134, 269)
	Sleep(100)

	If _imgSearch("codeVH") Then
		_repeatIconCode2($code)
	EndIf
	Sleep(1188)
	;cdc
;~ 	WEnd
EndFunc   ;==>_repeatIconCode2



Func Pban()
	Sleep(1000)

	_ClickUtilSeeImg("iconEmail", 280, 25, 1100)
	Sleep(1000)
	_CtrlClickInGame(214, 335, 1)
	Sleep(500)
	AdlibRegister("_ClearApp", 120000)
	While 1
		_CtrlClickInGame(37, 362, 1)
		Sleep(50)
		_CtrlClickInGame(131, 305, 1)
		Sleep(50)
		_CtrlClickInGame(249, 165, 1)
		Sleep(50)
		If _imgSearch("donepb") Then
			Mbox("done[b", 1)
			ExitLoop
		EndIf
	WEnd
	Sleep(2100)

	_ClickUtilSeeImg("iconEmail", 280, 25, 1100)


	Sleep(1000)
	_CtrlClickInGame(70, 477, 2)
	While 1
		If _imgSearch("9t") Or _imgSearch("9t1") Or _imgSearch("9t2") Then
			_CtrlClickImg($x, $y)
			_CtrlClickImg($x, $y)
			_CtrlClickImg($x, $y)
			ExitLoop
		EndIf
	WEnd
	Sleep(500)
	_CtrlClickInGame(142, 469, 2)
	Sleep(1600)
	For $i = 1 To 15
		_CtrlClickInGame(232, 275, 2)
	Next
	Sleep(1600)
	_CtrlClickInGame(143, 313, 2)
	Sleep(1800)
	_CtrlClickInGame(261, 47, 2)
	Sleep(2200)

	_CtrlClickInGame(35, 40, 2)
	Sleep(2200)
	_CtrlClickInGame(243, 188, 2)
	For $i = 1 To 15
		Sleep(300)
		_CtrlClickInGame(142, 480, 2)
	Next
EndFunc   ;==>Pban


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
	If _imgSearch("iconSaiMK") = 1 Then
;~ 		MsgBox(0,"","sai pass",19)s
		IncrI()
;~ 		AdlibUnRegister("_checkPWD")
	EndIf
EndFunc   ;==>_checkPWD

Func _ClearApp()
	$flag = 0
;~ 	Mbox($iGlobal1,2)
EndFunc   ;==>_ClearApp

Func ExitToLog2()
	ControlSend($WindowHandle, "", "", "{ESC}")
	AdlibRegister("ExitToLog2")
EndFunc   ;==>ExitToLog2
Func ExitToLog()
	Sleep(500)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 4', "", @SW_HIDE)
	Sleep(800)
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



Func ShareLGCT()
	While 1
		If _imgSearchW("share", 1000) = 1 Then
;~ 			MsgBox(0, $x+ 146, $y)
			_CtrlClickImg($x + 146, $y + 17)
			_CtrlClickImg($x + 146, $y + 17)
			Return
		EndIf
		_ADB_CMD("input swipe 450 1100 450 520  1060", $port)
		_ADB_CMD("input tap 450 520", $port)
		Sleep(2000)
	WEnd
EndFunc   ;==>ShareLGCT

Func NhanNV()
	While 1
		If _imgSearchW("nhannv", 1000) = 1 Then
;~ 			MsgBox(0, $x+ 146, $y)
			_CtrlClickImg($x, $y)
			_CtrlClickImg($x, $y)
			Return
		EndIf
		_ADB_CMD("input swipe 450 1100 450 520  1060", $port)
		_ADB_CMD("input tap 450 520", $port)
		Sleep(2000)
	WEnd

EndFunc   ;==>NhanNV


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
;~ 		_imgSearch($SVer, $top = 0, $left = 0, $bot = -1, $right = -1)
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

		_HandleImgSearch($WindowHandle, @ScriptDir & "\Data\Images\" & $bmp & ".bmp", 0, 0, -1, -1, 40, 100)
		If Not @error Then
			Return
		EndIf
		_CtrlClickInGame($x1, $y1)
		Sleep($slp)
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

Func _Hanhi()
	AdlibRegister("_ClearApp", 13000)
	Sleep(1000)
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		_CtrlClickInGame(280, 14)
		Sleep(1000)
		If _imgSearch("iconEmail") = 1 Then
			ExitLoop
		EndIf
	WEnd
	Sleep(200)
	_ADB_CMD("input swipe 710 300 90 300 200", $port)
	Sleep(600)
	_CtrlClickInGame(87, 304)
	Sleep(1000)
	_OKIF("iconInBang")
	Sleep(300)
	_CtrlClickInGame(47, 361)
	_OKIF("inXay") ;c
	Sleep(500)
	_CtrlClickInGame(221, 267)
	_ClickUtilSeeImg("iconInBang", 258, 72, 300)
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		_CtrlClickInGame(276, 21)
		Sleep(1000)
		If _imgSearch("iconTrangTri") = 1 Then
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>_Hanhi

Func QuanGia()
	AdlibRegister("_ClearApp", 13000)
	_OKIF("iconTrangTri")

	Sleep(300)
	_CtrlClickInGame(257, 413)
	_CtrlClickInGame(257, 413)
	Sleep(1100)
	_CtrlClickInGame(167, 280)
	_CtrlClickInGame(167, 280)
	_CtrlClickInGame(201, 475)
;~ 	MouseClick("left", 826, 623, 1, 0)
	_OKIF("inquangia")
	Sleep(300)
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

	While 1
		Sleep(50)
		If $flag = 0 Then Return
		_CtrlClickInGame(253, 15)
		Sleep(1000)
		If _imgSearch("iconTrangTri") = 1 Then
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>QuanGia

Func HoiThamNhanh()
	AdlibRegister("_ClearApp", 13000)
	_ClickUtilSeeImg("inHTham",223, 253)
	_CtrlClickInGame(257, 77)
	_CtrlClickInGame(257, 77)
	Sleep(1000)
	_OKIF("iconHTN")
	_CtrlClickInGame(228, 471)
	Sleep(1000)
	_CtrlClickInGame(228, 471)

	While 1
		Sleep(50)
		If $flag = 0 Then Return
		_CtrlClickInGame(276, 43)
		Sleep(1000)
		If _imgSearch("iconTrangTri") = 1 Then
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>HoiThamNhanh

Func ThiTam()
	AdlibRegister("_ClearApp", 15000)
	_CtrlClickInGame(19, 218)
	_CtrlClickInGame(19, 218)
	Sleep(1000)
	_CtrlClickInGame(94, 342)
	Sleep(1000)
	_CtrlClickInGame(218, 482)
	Sleep(1000)
	_CtrlClickInGame(218, 482)

	While 1
		Sleep(50)
		If $flag = 0 Then Return
		_CtrlClickInGame(279, 31)
		Sleep(1000)
		If _imgSearch("iconTrangTri") = 1 Then
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>ThiTam

Func fullNV()
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		_CtrlClickInGame(279, 31)
		Sleep(1000)
		If _imgSearch("iconTrangTri") = 1 Then
			ExitLoop
		EndIf
	WEnd
	QuanGia()
	HoiThamNhanh()
	ThiTam()
	_Hanhi()
	shareFB()
	_nv14()
EndFunc   ;==>fullNV

Func _nv14()
	AdlibRegister("_ClearApp", 20000)
	Local $countNVtime = TimerInit()
	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconHaveNV") = 1 Then
;~ 			Mbox("havenv")
			_CtrlClickImg($x, $y) ;vao nv
			While 1
				Sleep(50)
				If $flag = 0 Then Return
				Sleep(800)
				If _imgSearch("nv14") = 1 Or _imgSearch("nv142") = 1 Then
					_CtrlClickImg($x, $y)
					AdlibRegister("_ClearApp", 15000)
				ElseIf _imgSearch("full140") = 1 Then
					For $i = 5 To 1 Step -1
    MsgBox($MB_SYSTEMMODAL, "", "Count down!" & @CRLF & $i)
Next

					50, 77
				Else
;~ 					Mbox("outnv")
					_CtrlClickInGame(279, 31) ;out nhan nv
					$countNVtime = TimerInit()
					ExitLoop
				EndIf
			WEnd
		EndIf
		If TimerDiff($countNVtime) > 5000 Then
			Return
		EndIf
	WEnd
EndFunc   ;==>_nv14

Func shareFB()
	AdlibRegister("_ClearApp", 15000)
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		Local $a = TimerInit()
;~ 		While 1
;~ 			Sleep(50)
;~ 			If $flag = 0 Then Return
		Sleep(1000)
		If _imgSearch("shareFB") = 1 or _imgSearch("shareFB1") = 1 Then
			_CtrlClickImg(234, $y)
			Return
		EndIf

;~ 		WEnd
		_ADB_CMD("input swipe 648 850 648 540 500", $port)
		_ADB_CMD("input swipe 648 540 648 540 500", $port)

	WEnd

EndFunc   ;==>shareFB

Func AutomainfullNV()
;~ 	$port = $port1
	Opt("WinTitleMatchMode", 3)
;~ 	$WindowHandle = $WindowHandle1
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf

	Local $fileIni = @ScriptDir & "\Data\Account\fullnv\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\fullnv\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	_ResetNewDay($fileIni)


;~ 			Mbox($iGlobal)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

;~ 			Mbox("1")
		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)


		For $iGlobal11 = $iGlobal To _FileCountLines($fileList)

			$iGlobal1 = $iGlobal11
;~ 			Mbox($iGlobal1)
;~ 		Mbox($iGlobal1)
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal1), " ")
			If $infoAcc[1] == '-' Then
				ContinueLoop
			ElseIf _ReadIni(@ScriptDir & "\Data\Account\file.ini", "General", "code", "") == "" And _curSV() <> "SV49" And $iGlobal1 <> 1 Then
				$flag = 1
				ExitLoop
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

;~ 			Mbox($iGlobal)
			_DoiTK($infoAcc, $samePWD) ;Doi Tai Khoan


;~ 		------------------- del
			If _ReadIni(@ScriptDir & "\Data\Account\file.ini", "General", "code", "") <> "" Then
				DoiCode()
			EndIf


			$samePWD = $infoAcc[2] ; Check Same Password

			AdlibRegister("_ClearApp", 30000)

			_ThinhAn($infoAcc)     ; Done Sung Bai Thinh An
			fullNV()

			If $flag = 0 Then ExitLoop
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
;~ 			mbox("etlog",14)
			ExitToLog()
		Next
		If ProcessExists(WinGetProcess($WindowHandle)) And $flag = 1 Then
;~ 			If WinGetTitle($WindowHandle) = "2" Then
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
;~ 				mbox(WinGetTitle($WindowHandle))
			ShellExecuteWait("E:\App\AutoLGCTLDPlayer\war" & WinGetTitle($WindowHandle) & ".au3")
			Exit
			ProcessClose(WinGetProcess($WindowHandle))
			Sleep(2000)
			If WinExists("[CLASS:LDPlayerMainFrame]") = 0 Then
;~ 				MsgBox(0, "", "60S SHUTDON", 3000)
;~ 				Run(@ComSpec & ' /c ChangeScreenResolution.exe /f=75 /d=0', @SystemDir, @SW_HIDE)
				Sleep(30000)
				Shutdown(12)
			EndIf
			Exit
		EndIf
	WEnd
EndFunc   ;==>AutomainfullNV




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
			ExitToLog()
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
	Opt("WinTitleMatchMode", 3)
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf

	Local $fileIni = @ScriptDir & "\Data\Account\Tiec\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\Tiec\AutoList" & WinGetTitle($WindowHandle) & ".txt"

	$iniFile = $fileIni
	Mbox("Tiec")
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)

		_Wait4Image("iconGame")

		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
;~ 		Mbox($WindowHandle, 1)

		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
;~ 		MsgBox(0,"","")
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
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
			ExitToLog()
;~ 		Next
		WEnd
	WEnd
EndFunc   ;==>_AnTiec

Func _TiecTiec1()
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		If _imgSearch("iconEmail") = 1 Then
			If _imgSearch("okPrison") = 0 Then
				_ADB_CMD("input swipe 100 300 1000 300 150", $port)
				Sleep(2000)
				_CtrlClickInGame(229, 401)

			Else
				_ADB_CMD("input swipe 710 300 90 300 160", $port)
				Sleep(1000)
				_CtrlClickInGame(215, 345)
				_CtrlClickInGame(215, 345)
			EndIf
			ExitLoop
		EndIf
	WEnd
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
		Sleep(50)
		Local $a = TimerInit()
		While 1
			Sleep(50)
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
EndFunc   ;==>_TiecTiec1
Func _kTiec()
	If _imgSearch("kTiec") = 1 Then
		$motiec = 1
	EndIf
EndFunc   ;==>_kTiec

Func _TiecTiec()
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		If _imgSearch("iconEmail") = 1 Then
			If _imgSearch("okPrison") = 0 Then
				_ADB_CMD("input swipe 100 300 1000 300 150", $port)
				Sleep(2000)
				_CtrlClickInGame(229, 401)

			Else
				_ADB_CMD("input swipe 710 300 90 300 160", $port)
				Sleep(1000)
				_CtrlClickInGame(215, 345)
				_CtrlClickInGame(215, 345)
			EndIf
			ExitLoop
		EndIf
	WEnd
	_OKIF("inTiec")
	Sleep(300)
	_CtrlClickInGame(238, 485)
	Sleep(700)
	_CtrlClickInGame(181, 163)
	Sleep(500)
	ControlSend($WindowHandle, "", "", IniRead($iniFile, "General", "MSDT", 0))
	Sleep(333)
	AdlibRegister("_kTiec", 3500)

	While 1
		Sleep(50)
		If $flag = 0 Or $motiec = 1 Then
			AdlibUnRegister("_kTiec")
;~ 			Mbox("11")
			Return
;~ 		EndIf
		ElseIf _imgSearch("searchTiec") Then
			ExitLoop
		EndIf
		_CtrlClickInGame(187, 190)
;~ 		Mbox("erro", 1)
		Sleep(1000)
	WEnd

;~ 	_ClickUtilSeeImg("searchTiec", 187, 190, 1000)
	_CtrlClickInGame(207, 371, 3)
	Sleep(500)
	If IniRead($iniFile, "General", "TK", 0) <> "NO" Then
		If _imgSearch("fullNho") = 1 Then
			$motiec = 1
			Return
		EndIf
	EndIf

	_OKIF("inChonBan")

	Sleep(500)
	AdlibRegister("_ClearApp", 30000)
	While 1
		Sleep(50)
		Local $a = TimerInit()
		While 1
			Sleep(50)
			If $flag = 0 Then Return
			If _imgSearch("vaoBan") = 1 Or _imgSearch("vaoBan2") = 1 Then
;~ 				MsgBox(0, $x, $y, 1)
				AdlibRegister("_vaoban", 3000)

				_CtrlClickImg($x + 1, $y + 10)
				_OKIF("cachDuTiec")
				AdlibUnRegister("_vaoban")
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
Func _vaoban()
	If _imgSearch("vaoBan") = 1 Or _imgSearch("vaoBan2") = 1 Then
;~ 				MsgBox(0, $x, $y, 1)
		AdlibRegister("_vaoban", 3000)

		_CtrlClickImg($x + 1, $y + 10)
		_OKIF("cachDuTiec")
		Sleep(500)
		_CtrlClickInGame(219, 228)
		Return
	EndIf
EndFunc   ;==>_vaoban

Func _MoTiec()
	While 1
		Sleep(50)
		If $flag = 0 Then Return
		Sleep(1000)
		If _imgSearch("iconEmail") = 1 Then
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

Func _DoiTKDK($infoAcc, $samePWD)
	While 1
		If $flag = 0 Then Return
		If _imgSearch("iconDay") = 1 Then
			ExitLoop
		ElseIf _imgSearch("iconMoi") = 1 Then
			ExitLoop
		EndIf
	WEnd

;~ 	Mbox("2")
	AdlibRegister("ClickDTK", 4000)
	Sleep(200)
	AdlibUnRegister("ClickSeeDay")
	_Wait4Image("iconDTK")
	AdlibUnRegister("ClickDTK")
	_CtrlClickInGame(140, 286)
	Sleep(500)
	_OKIF("iconTK", 241, 276, 259 - 241, 289 - 276)
	Sleep(500)
	_CtrlClickInGame(141, 345)
	Sleep(800)
	_ADB_CMD("input text " & $infoAcc[1], $port)
	Sleep(500)
	_CtrlClickInGame(203, 210)
	_ADB_CMD("input text " & $infoAcc[2], $port)
	Sleep(500)
	_CtrlClickInGame(203, 238)
	_ADB_CMD("input text " & $infoAcc[2], $port)
	Sleep(200)
	AdlibRegister("checkExist", 1000)
	_CtrlClickInGame(141, 345)

EndFunc   ;==>_DoiTKDK

Func checkExist()
	If _imgSearch("exist") = 1 Then
		_WriteIni($iniFile, "General", "BienI", _ReadIni(@ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", "General", "BienI", 1) + 1)
	EndIf
	AdlibUnRegister("checkExist")
EndFunc   ;==>checkExist

Func _WrapperRegClone()
;~ 	_RegClone()
	_RegClonePhase0() ; dang ky tai khoan
	_RegClonePhase1()
	_RegClonePhase2()
EndFunc   ;==>_WrapperRegClone

Func _RegClonePhase1()
;~ 	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
;~ 		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
;~ 		Exit
;~ 	EndIf
	Local $fileIni = @ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\Regclone\AutoList" & WinGetTitle($WindowHandle) & ".txt", $curTK = "null", $mainTK = "null1", $doneCode = 0
	$iniFile = $fileIni

	_ResetNewDay($fileIni)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)
		_Wait4Image("iconGame")
		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)
		While 1
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal), " ")
			If $infoAcc[1] == "END" Then
				IniWrite($fileIni, "General", "BienI", 1)
				_ClearApp()
				ExitLoop
			EndIf
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
			If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 And $flgMT = 0 Then
					$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1)
				EndIf
				_OKIF("iconMoi")
				Sleep(300)
				_ClickUtilSeeImg("iconListServer", 91, 349)
				_ChonSV($infoAcc[1], $fileIni)
				If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
					_WriteIni($fileIni, "General", "SVDAY", 0)
				EndIf
			EndIf
;~ 		--------------------------------------------------------------------------------------------------------
			AdlibRegister("_ClearApp", 10000)
;~ 			_DoiTKDK($infoAcc, $samePWD) ;Doi Tai Khoan flag1
			_OKIF("iconMoi") ;flag1
;~ 			_DoiTK($infoAcc, $samePWD)

			_DoiTKClone($infoAcc, $samePWD) ;flag2
			Sleep(3000)
			$samePWD = $infoAcc[2] ; Check Same Password flag2
;~ 			$curTK = $infoAcc[1]
;~ 			If $curTK <> $mainTK Then
;~ 				$doneCode = 0
;~ 			EndIf
;~ 			--------------------
;~ 			codeTT($doneCode)
;~ 			Pban()
;~ 			-------------------------
			If _imgSearch("iconXX") Then
				NameClone()
			EndIf
			_Clone() ;flag 2
			If $flag = 0 Then ExitLoop
			$iGlobal = $iGlobal + 1
			$mainTK = $curTK
			_WriteIni($iniFile, "General", "BienI", $iGlobal)
			If _FileCountLines($fileList) < $iGlobal Then
				_WriteIni($fileIni, "General", "Day", @MDAY + 10)
				Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
				Sleep(3000)
				Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
				Return
			EndIf
			ExitToLog() ;flag2
;~ 		Next
		WEnd
	WEnd
EndFunc   ;==>_RegClonePhase1

Func _RegClonePhase2()
;~ 	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
;~ 		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
;~ 		Exit
;~ 	EndIf
	Local $fileIni = @ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\Regclone\AutoList" & WinGetTitle($WindowHandle) & ".txt", $curTK = "null", $mainTK = "null1", $doneCode = 0
	$iniFile = $fileIni

	_ResetNewDay($fileIni)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)
		_Wait4Image("iconGame")
		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)
		While 1
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal), " ")
			If $infoAcc[1] == "END" Then
				IniWrite($fileIni, "General", "BienI", 1)
				_ClearApp()
				ExitLoop
			EndIf
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
			If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 And $flgMT = 0 Then
					$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1)
				EndIf
				_OKIF("iconMoi")
				Sleep(300)
				_ClickUtilSeeImg("iconListServer", 91, 349)
				_ChonSV($infoAcc[1], $fileIni)
				If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
					_WriteIni($fileIni, "General", "SVDAY", 0)
				EndIf
			EndIf
;~ 		--------------------------------------------------------------------------------------------------------
			AdlibRegister("_ClearApp", 10000)
;~ 			_DoiTKDK($infoAcc, $samePWD) ;Doi Tai Khoan flag1
;~ 			_OKIF("iconMoi") ;flag1
			_DoiTK($infoAcc, $samePWD)

;~ 			_DoiTKClone($infoAcc, $samePWD) ;flag2
			Sleep(3000)
			$samePWD = $infoAcc[2] ; Check Same Password flag2
;~ 			$curTK = $infoAcc[1]
			If $curTK <> $mainTK Then
				$doneCode = 0
			EndIf
;~ 			--------------------
			$iCode = _ReadIni($fileIni, "General", "iCode", 1)

			codeTT($doneCode)
			If $flag = 0 Then ExitLoop
			Pban()
;~ 			-------------------------
;~ 			If _imgSearch("iconXX") Then
;~ 				NameClone()
;~ 			EndIf
;~ 			_Clone() ;flag 2
			If $flag = 0 Then ExitLoop
			$iGlobal = $iGlobal + 1
;~ 			$mainTK = $curTK
			_WriteIni($iniFile, "General", "BienI", $iGlobal)
			_WriteIni($iniFile, "General", "iCode", 1)
;~ 			$iCode=1
			If _FileCountLines($fileList) < $iGlobal Then
				_WriteIni($fileIni, "General", "Day", @MDAY + 10)
				Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
				Sleep(3000)
				Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
				Return
			EndIf
			ExitToLog() ;flag2
;~ 		Next
		WEnd
	WEnd
EndFunc   ;==>_RegClonePhase2


Func _RegClonePhase0()
	If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
	EndIf
	Local $fileIni = @ScriptDir & "\Data\Account\Regclone\file" & WinGetTitle($WindowHandle) & ".ini", $fileList = @ScriptDir & "\Data\Account\Regclone\AutoList" & WinGetTitle($WindowHandle) & ".txt", $curTK = "null", $mainTK = "null1", $doneCode = 0
	$iniFile = $fileIni

	_ResetNewDay($fileIni)
	While 1
		If $flag = 0 Then
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
			Sleep(3000)
			Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
			$flag = 1
		EndIf
		AdlibRegister("_ClearApp", 30000)
		_Wait4Image("iconGame")
		Local $iGlobal = _ReadIni($fileIni, "General", "BienI", 1)
		ControlClick($WindowHandle, "", "", "left", 1, 243, 152)
		_OKIF("iconDTK")
		Sleep(2000)
		_CtrlClickInGame(153, 276)
		_CtrlClickInGame(153, 276)
		Local $infoAcc, $samePWD = "null"
		AdlibRegister("ClickSeeDay", 3000)
		While 1

			If _FileCountLines($fileList) < $iGlobal Then
				_WriteIni($fileIni, "General", "Day", @MDAY + 10)
				Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell am force-stop com.tfun.lgct.luck', "", @SW_HIDE)
				Sleep(3000)
				Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell input keyevent 3', "", @SW_HIDE)
				Return
			EndIf
			$infoAcc = StringSplit(FileReadLine($fileList, $iGlobal), " ")
			If $infoAcc[1] == "END" Then
				IniWrite($fileIni, "General", "BienI", 1)
				_ClearApp()
				ExitLoop
			EndIf
			If $infoAcc[1] == '-' Then
				ContinueLoop
			EndIf
			$tenTK = $infoAcc
			Sleep(100)
;~ 		----------------------------------------------------------------------------------------------------------- Change SV
			If StringInStr($infoAcc[1], "SV", 1) Or _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
				If _ReadIni($fileIni, "General", "SVDAY", 0) = 1 And $flgMT = 0 Then
					$infoAcc[1] = _ReadIni($fileIni, "General", "SV", 1)
				EndIf
				_OKIF("iconMoi")
				Sleep(300)
				_ClickUtilSeeImg("iconListServer", 91, 349)
				_ChonSV($infoAcc[1], $fileIni)
				If _ReadIni($fileIni, "General", "SVDAY", 1) = 1 Then
					_WriteIni($fileIni, "General", "SVDAY", 0)
				EndIf
			EndIf
;~ 		--------------------------------------------------------------------------------------------------------
			AdlibRegister("_ClearApp", 10000)
			_DoiTKDK($infoAcc, $samePWD) ;Doi Tai Khoan flag1
			_OKIF("iconMoi") ;flag1
;~ 			_DoiTK($infoAcc, $samePWD)

;~ 			_DoiTKClone($infoAcc, $samePWD) ;flag2
;~ 			Sleep(3000)
;~ 			$samePWD = $infoAcc[2] ; Check Same Password flag2
;~ 			$curTK = $infoAcc[1]
;~ 			If $curTK <> $mainTK Then
;~ 				$doneCode = 0
;~ 			EndIf
;~ 			--------------------
;~ 			codeTT($doneCode)
;~ 			Pban()
;~ 			-------------------------
;~ 			If _imgSearch("iconXX") Then
;~ 				NameClone()
;~ 			EndIf
;~ 			_Clone() ;flag 2
			If $flag = 0 Then ExitLoop
			$iGlobal = $iGlobal + 1
			$mainTK = $curTK
			_WriteIni($iniFile, "General", "BienI", $iGlobal)
;~ 			ExitToLog2() ;flag2
;~ 		Next
		WEnd
	WEnd
EndFunc   ;==>_RegClonePhase0



Func _Clone()
;~ 	Sleep(2000)
	AdlibRegister("_ClearApp", 30000)
	While 1
		Sleep(50)
		If $flag = 0 Then
			Return
		EndIf
		_CtrlClickInGame(73, 416)
		_CtrlClickInGame(131, 236)
		_CtrlClickInGame(42, 349)
		_CtrlClickInGame(62, 352)
		_CtrlClickInGame(144, 354)
		_CtrlClickInGame(226, 353)
		_CtrlClickInGame(24, 476)
		_CtrlClickInGame(45, 109)
		_CtrlClickInGame(220, 257)
		_CtrlClickInGame(265, 20)
		_CtrlClickInGame(268, 46)
		_CtrlClickInGame(280, 17)
		_CtrlClickInGame(221, 332)
		_CtrlClickInGame(33, 366)
		_CtrlClickInGame(267, 95)
		_CtrlClickInGame(140, 275)
		_CtrlClickInGame(276, 43)
		_CtrlClickInGame(254, 118)
		_CtrlClickInGame(60, 303)
		_CtrlClickInGame(243, 192)
		_CtrlClickInGame(29, 38)
		_CtrlClickInGame(64, 249)

		If _imgSearch("cloneEnd") = 1 Or _imgSearch("cloneEnd2") = 1 Then
			_WriteIni($iniFile, "General", "BienI", $iGlobal1 + 1)
			Return
		EndIf
	WEnd
EndFunc   ;==>_Clone

Func NameClone()
	_OKIF("iconXX")
	AdlibRegister("_ClearApp", 5000)
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
