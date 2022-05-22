#include "lgct.au3"
#include <SendMessage.au3>
Local $WindowHandle = WinGetHandle("[TITLE:3; CLASS:LDPlayerMainFrame]"), $port = 5559
Local $hwnd = _WinAPI_FindWindow("LDPlayerMainFrame", WinGetTitle($WindowHandle))
	Local $hEnumProc = DllCallbackRegister('__EnumWindowsProcLDPlayer', 'bool', 'hwnd;lparam')
	DllCall('user32.dll', 'bool', 'EnumChildWindows', 'hwnd', $hwnd, 'ptr', DllCallbackGetPtr($hEnumProc), 'lparam', 0)
	$render_hwnd = DllStructGetData($SUB_LDPLAYER_HWND, 1)
;~ _ControlClickDrag($render_hwnd,53, 68,207, 68)
_ControlClick($render_hwnd,195, 338)
;~ AutoMain($WindowHandle,$port)

;~ _AnTiec($WindowHandle, $port)