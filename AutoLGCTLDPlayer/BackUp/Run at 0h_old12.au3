#include <Misc.au3>

;~ dnconsole.exe launch --index 1

RunWait("startLD.bat")

Sleep(10000)
While 1



		Switch @HOUR
			Case 0 to 2
				Sleep(60000)
		ShellExecute("auto.bat")
			Case 12 To 17
				$sMsg = "Good Afternoon"
			Case 18 To 21
				$sMsg = "Good Evening"
			Case Else
				$sMsg = "What are you still doing up?"
		EndSwitch



		Exit

	Sleep(60000 * 5)
WEnd

