While 1
	for $i = 2 to 12
	If WinExists("[TITLE:2; CLASS:LDPlayerMainFrame]") And ProcessExists("AutoLDPlayer2.au3") <> 0  Then
		MsgBox(0, "", "1", 2)
		ShellExecuteWait("AutoLDPlayer2.au3")
	EndIf
	Next
	Sleep(60000 * 2)
WEnd
