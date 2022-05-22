#include <Misc.au3>

;~ dnconsole.exe launch --index 1

RunWait("startLD.bat")

Sleep(10000)
While 1
	If @HOUR = 0 Then
		Sleep(60000)

		Switch @HOUR
    Case 6 To 11
        $sMsg = "Good Morning"
    Case 12 To 17
        $sMsg = "Good Afternoon"
    Case 18 To 21
        $sMsg = "Good Evening"
    Case Else
        $sMsg = "What are you still doing up?"
EndSwitch



		ShellExecute("auto.bat")
		Exit
	EndIf
	Sleep(60000*5)
WEnd

