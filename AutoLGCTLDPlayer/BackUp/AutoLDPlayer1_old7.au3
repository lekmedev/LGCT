#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

If _imgSearch($WindowHandle, "test1") = 1 Then
_ArrayDisplay($result)
EndIf
;~ AutoMain($WindowHandle, $port)
