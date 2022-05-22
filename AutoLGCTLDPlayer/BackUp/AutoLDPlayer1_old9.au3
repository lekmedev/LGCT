#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555
while 1
If _imgSearch($WindowHandle, "iconFB") = 1 Then
		_ClickUtilSeeImg($WindowHandle, "iconDay", 135, 284)
	EndIf
wend
AutoMain($WindowHandle, $port)
