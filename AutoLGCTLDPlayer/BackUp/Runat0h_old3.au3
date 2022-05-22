#include <Misc.au3>
#include <lgct.au3>



Func CheckADBDevices()

EndFunc   ;==>CheckADBDevices



MsgBox(0, "", "Run at 0h 30s remain", 30)
;~ Run(@ComSpec & " /c dnplayer.exe index=0", "", @SW_HIDE)
Run(@ComSpec & " /c adb start-server", "", @SW_HIDE)
Sleep(15000)

For $i = 1 To 11
	Run(@ComSpec & ' /c "C:\Program Files\ChangZhi\LDPlayer\dnplayer.exe" index=' & $i & "", @SystemDir, @SW_HIDE)
	Sleep(3000)
Next

Sleep(15000)
	Local $iPID = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, 2)
	If @error Or Not $iPID Then Exit
	Local $sStdOut = ""
	Do
		Sleep(10)
		$sStdOut &= StdoutRead($iPID)
	Until @error

	MsgBox(0, '', $sStdOut)
	If StringInStr($sStdOut, "127.0.0.1:5571", 2) <> 0 Then Return 1



While 1
	Switch @HOUR
		Case 0 To 2
			For $i = 1 To 11
				ShellExecute(@ScriptDir & "/AutoLDPlayer" & $i + 1 & ".au3")
			Next
			Exit
		Case 12, 13, 20
			For $i = 1 To 11
				ShellExecute(@ScriptDir & "/war" & $i + 1 & ".au3")
			Next
			Exit
		Case 15
			For $i = 1 To 11
				ShellExecute("E:\App\AutoLGCTLDPlayer - Net\Net" & $i + 1 & ".au3")
			Next
			Exit
	EndSwitch
;~ 	Sleep(60000 * 5)
WEnd

