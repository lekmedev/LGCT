;~ While 1
;~ 	If @HOUR = 0 Then
;~ 		Sleep(10000)
;~ 		ShellExecute("auto.bat")
		While 1

			If WinExists("[TITLE:2; CLASS:LDPlayerMainFrame]") And Not ProcessExists("AutoLDPlayer2.au3") Then
				MsgBox(0,"","1",2)
				ShellExecuteWait("AutoLDPlayer2.au3")
			EndIf



			Sleep(60000 * 2)
		WEnd
;~ 	EndIf

;~ 	Sleep(60000 * 10)
;~ WEnd
