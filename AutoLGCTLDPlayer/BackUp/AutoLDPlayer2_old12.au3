#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557


;~ ClickIntoPB()
if WinExists("[TITLE:2; CLASS:LDPlayerMainFrame]") Then
				ShellExecute("AutoLDPlayer2.au3")
				If _Singleton(WinGetTitle($WindowHandle), 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
EndIf
			EndIf

;~ AutoMain()






;~  _checkTQ()
;~ _RegClone()
;~ _Clone()
