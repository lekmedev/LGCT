#include <Misc.au3>

;~ dnconsole.exe launch --index 1

;~ RunWait("startLD.bat")
Sleep(10000)
While 1
	Switch @HOUR
		Case 0 To 2
			for $i = 1 then
			Run(@ComSpec & " /c dnplayer.exe index=2", "", @SW_HIDE)
			Next
			Sleep(60000)
			ShellExecute("auto.bat")
			Exit
		Case 20
			MsgBox(0,"",1,"")
			ShellExecute("autoWar.bat")
			Exit
	EndSwitch
	Sleep(60000 * 5)
WEnd

