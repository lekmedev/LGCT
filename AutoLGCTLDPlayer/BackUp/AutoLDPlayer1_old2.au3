;~ #RequireAdmin
#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
;~ HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("1"), $port = 5555
;~ _bmbSearch("1","S181")




Local $Source = "C:\Users\Admin\Documents\LDPlayer\Misc\1.bmp"
Local $FindBmp = @ScriptDir & "\Data\Images\S181.bmp"
While 1
	Sleep(10)
	RunWait(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell screencap -p /sdcard/Misc/1.bmp', "", @SW_HIDE)
	Local $a1 = TimerInit()
	While 1
		$aPoss = _BmpImgSearch($Source, $FindBmp, 0, 0, -1, -1, 70, 500)
		If Not @error Then
		_ArrayDisplay($aPoss)
		_ADB_CMD_SLEEP("input tap " & $aPoss[1][0] & " " & $aPoss[1][1] & " ", $port, 550)
			Exit
		EndIf
		If TimerDiff($a1) > 3401 Then
			ExitLoop
		EndIf
	WEnd
WEnd





;~ AutoMain($WindowHandle,$port)
