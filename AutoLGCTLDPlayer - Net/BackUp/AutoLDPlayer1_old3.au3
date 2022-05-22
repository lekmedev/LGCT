;~ #RequireAdmin
#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
;~ HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("1"), $port = 5555
;~ _bmbSearch("1","S181")






Local $Source = "C:\Users\Admin\Documents\LDPlayer\Misc\"&$SVnoTrim&".bmp"
	Local $FindBmp = @ScriptDir & "\Data\Images\S"&$SVtrimmed&".bmp"
	While 1
		Sleep(10)
		RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell screencap -p /sdcard/Misc/'&$SVnoTrim&'.bmp', "", @SW_HIDE)
		Local $a1 = TimerInit()
		While 1
			$aPoss = _BmpImgSearch($Source, $FindBmp, 0, 0, -1, -1, 50, 500)
			If Not @error Then
				Return 1
			EndIf
			If TimerDiff($a1) > 3001 Then
				Mbox(TimerDiff($a1))
				Return
			EndIf
		WEnd
	WEnd



AutoMain($WindowHandle,$port)
