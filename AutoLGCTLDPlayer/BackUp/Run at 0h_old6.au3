MsgBox(0, "", @AutoItPID,10)
While 1
	For $i = 2 To 12
;~ 		MsgBox(0, "", "[TITLE:" & $i &"; CLASS:LDPlayerMainFrame]", 2)s
		If WinExists("[TITLE:"& $i &"; CLASS:LDPlayerMainFrame]") Then
;~
			ShellExecute("AutoLDPlayer" & $i &".au3")
		EndIf
	Next
	Sleep(60000 * 5)

WEnd
