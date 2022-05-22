#include <CoProc.au3>


Local $WindowHandle = WinList("[CLASS:LDPlayerMainFrame]")
MsgBox(0, "", $WindowHandle[2][1])
_CoProc("a", $WindowHandle[2][1])

Func a($WindowHandle)
	MsgBox(0, "", $WindowHandle)
EndFunc   ;==>a
