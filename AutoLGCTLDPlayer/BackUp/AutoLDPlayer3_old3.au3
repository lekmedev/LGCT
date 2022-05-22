#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:3; CLASS:LDPlayerMainFrame]")
$port = 5559

;~ AutoMain()
;~ _CMSN()
;~ _RegClone()
;~ _AnTiec()
;~ tem()
Func abcss()
While 1
					If $flag = 0 Then Return
					If _imgSearch("doneKillBoss") Then
						Return
					ElseIf _imgSearch("bossDie") Then
						Return
					ElseIf _imgSearch("kcbos") Then
						$countBoss += 1
						If $countBoss > 11 Then
							$countBoss = 1
							If @HOUR = 20 Then
								Return
							EndIf
						EndIf
						AdlibRegister("_ClearApp", 15000)
					EndIf
					_CtrlClickInGame(141, 245)
					Sleep(300)
WEnd
EndFunc