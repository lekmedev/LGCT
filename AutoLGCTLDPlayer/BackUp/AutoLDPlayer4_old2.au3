#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:4; CLASS:LDPlayerMainFrame]")
$port = 5561
;~ _RegClone()




;~ gate

Func GateCard()

While 1
	If _imgSearch("gate") = 1 Then
		Beep(500, 1000)
		SoundPlay(@ScriptDir & "\Alarm.mp3", 1)
	EndIf
WEnd
	EndFunc
;~ AutoMain()



;~ Mbox("Tiec")
;~ _AnTiec()
