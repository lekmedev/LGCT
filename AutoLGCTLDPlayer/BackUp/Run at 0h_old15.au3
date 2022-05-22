#include <Misc.au3>

While 1
	Switch @HOUR
		Case 0 To 2
			For $i = 1 To 11
				Run(@ComSpec & " /c dnplayer.exe index=" & $i & "", "", @SW_HIDE)
				Sleep(5000)
				ShellExecute("AutoLDPlayer"&$i&".au3")
			Next
;~ 			Sleep(65000)

			Exit
		Case 12, 20
			For $i = 1 To 11
				Run(@ComSpec & " /c dnplayer.exe index=" & $i & "", "", @SW_HIDE)
				Sleep(5000)
				ShellExecute("AutoLDPlayer"&$i&".au3")
			Next
;~ 			Sleep(65000)
;~ 			ShellExecute("autoWar.bat")
			Exit
	EndSwitch
	Sleep(60000 * 5)
WEnd

