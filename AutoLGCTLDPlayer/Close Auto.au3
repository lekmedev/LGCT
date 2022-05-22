#include <Misc.au3>
If _Singleton("Close Auto", 1) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
		Exit
EndIf
Run(@ComSpec & ' /c nordvpn','C:\Users\Admin\', @SW_HIDe)
Sleep(11000)
local $a[6] = ["Vietnam #21", "Vietnam #22", "Vietnam #23", "Vietnam #18", "Vietnam #25", "Vietnam #26"]
Local $a1 = $a[Random(0, 5, 1)]
Run(@ComSpec & ' /c nordvpn -c -n "'&$a1&'"','C:\Users\Admin\', @SW_HIDe)
