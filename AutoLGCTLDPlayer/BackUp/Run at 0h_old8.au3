#include <Misc.au3>
if @HOUR = 0 Then
	For $i = 2 To 12
	If WinExists("[TITLE:" & $i & "; CLASS:LDPlayerMainFrame]") Then
		ShellExecute("AutoLDPlayer" & $i & ".au3")
	EndIf
	Sleep(30)
Next

	EndIf


