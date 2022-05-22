#include <Misc.au3>
#include <lgct.au3>

ShellExecute(@ScriptDir & "/ChangeProxy.au3")
;~ exit
Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=12 ', @SystemDir, @SW_HIDE)
Sleep(10000)
Run(@ComSpec & ' /c dnconsole.exe quit --index 12', @SystemDir, @SW_HIDE)

For $i = 1 To 11
	Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=' & $i & "", @SystemDir, @SW_HIDE)
	Sleep(2000)
Next

;~ - ------------------- Check Devices
Sleep(15000)
Local $iPID = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, 2)
If @error Or Not $iPID Then Exit
Local $sStdOut = ""
Do
	Sleep(10)
	$sStdOut &= StdoutRead($iPID)
Until @error


For $i = 1 To 11
	If StringInStr($sStdOut, "127.0.0.1:55" & 55 + $i * 2 & "	device") = 0 Then
		MsgBox(0, "", $i, 3)
		Run(@ComSpec & ' /c dnconsole.exe quit --index ' & $i & "", @SystemDir, @SW_HIDE)
		Sleep(3500)
		Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=' & $i & "", @SystemDir, @SW_HIDE)
		Sleep(3000)
	EndIf
Next
;~ - ------------------- Check Devices

Sleep(10000)
While 1
	Switch @HOUR
		Case 0 To 5
			For $i = 1 To 11
				ShellExecute(@ScriptDir & "/AutoLDPlayer" & $i + 1 & ".au3")
				Sleep(6000)
			Next
			ShellExecute(@ScriptDir & "/AutoLDPlayer13.au3")
			Exit
		Case 12, 13, 20
;~ 			ShellExecute(@ScriptDir & "/ChangeProxy.au3")
			For $i = 1 To 11
				ShellExecute(@ScriptDir & "/war" & $i + 1 & ".au3")
				Sleep(6000)
			Next
			If @HOUR = 12 Then
				ShellExecute(@ScriptDir & "/war13.au3")
			EndIf
			Exit
		Case 8 to 9
			For $i = 1 To 11
;~ 				ShellExecute("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer - Net\Net" & $i + 1 & ".au3")
				ShellExecute(@ScriptDir & "/VanTieuAutoLDPlayer" & $i + 1 & ".au3")
				Sleep(6000)
			Next
			Exit
	EndSwitch
;~ 	Sleep(60000 * 5)
WEnd
while 1
	If TimerDiff($countTime) > 250000 Then
		Exit
;~ 		Mbox("CountTime If",2)
		_WriteIni(@ScriptDir & "\Data\Account\file.ini", "General", "iVPN", 0)
		$countTime = TimerInit()
		Sleep(5000)
		ShellExecute(@ScriptDir & "/ChangeProxy.au3")
	EndIf
	WEnd