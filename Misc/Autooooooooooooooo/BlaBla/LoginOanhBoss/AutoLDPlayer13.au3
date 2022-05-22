#include "lgct.au3"
#include <SendMessage.au3>
Local $WindowHandle = WinGetHandle("3"), $port = 5559
AutoMain($WindowHandle,$port,25)