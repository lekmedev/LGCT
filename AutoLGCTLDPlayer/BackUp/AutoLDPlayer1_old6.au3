#include "lgct.au3"
#include <SendMessage.au3>
#include <Array.au3>
Local $WindowHandle = WinGetHandle("1"), $port = 5555

if _bmbSearch("1","S581") Then
	_ArrayDisplay($aPoss)
Endif



Mbox("done")
;~ AutoMain($WindowHandle, $port)
