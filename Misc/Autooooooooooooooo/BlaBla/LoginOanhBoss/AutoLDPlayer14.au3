#include "lgct.au3"
#include <SendMessage.au3>
Local $WindowHandle = WinGetHandle("4"), $port = 5561
AutoMain($WindowHandle,$port,27)