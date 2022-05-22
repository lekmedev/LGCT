;~ #RequireAdmin
#include "lgct.au3"
#include <SendMessage.au3>
;~ HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("2"), $port = 5557
;~ AutoMain($WindowHandle,$port)

	If showBang($_Arr_Bang_CH[1][2]) > $_Arr_Bang_CH[1][2 + 1] Then
		MsgBox(0, "", "today > phân tu 4", 1)
		updateBang($_Arr_Bang_CH[1][2], 0)
	EndIf
;~ _AnTiec($WindowHandle, $port)
