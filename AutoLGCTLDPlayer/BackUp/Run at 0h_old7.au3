#include <Misc.au3>

	For $i = 2 To 12
		If WinExists("[TITLE:" & $i & "; CLASS:LDPlayerMainFrame]") Then
			ShellExecute("AutoLDPlayer" & $i & ".au3")
		EndIf
		Sleep(30)
	Next
	Sleep(60000 * 5)