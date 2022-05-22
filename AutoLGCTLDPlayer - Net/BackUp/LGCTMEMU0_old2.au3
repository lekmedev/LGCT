#include "lgct.au3"
Local $WindowHandle = WinGetHandle("(MEmu - 0)"), $port = 21503
If _imgSearch($WindowHandle, "dotRed", 73, 61, 92, 78) Then
Local $aPos = WinGetPos($WindowHandle)
_CtrlClick($WindowHandle,71, 86)
EndIf
;~ AutoMain($WindowHandle,$port)
