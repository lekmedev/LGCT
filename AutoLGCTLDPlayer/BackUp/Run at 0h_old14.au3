#include <Misc.au3>

Sleep(10000)
While 1
	Switch @HOUR
		Case 0 To 2
			For $i = 1 to 11Then
				Run(@ComSpec & " /c dnplayer.exe index=" &$i& "", "", @SW_HIDE)
			Next
			Sleep(60000)
			ShellExecute("auto.bat")
			Exit
		Case 20
			For $i = 1 to 11Then
				Run(@ComSpec & " /c dnplayer.exe index=" &$i& "", "", @SW_HIDE)
Next
Sleep(60000)
			ShellExecute("autoWar.bat")
			Exit
	EndSwitch
	Sleep(60000 * 5)
WEnd

