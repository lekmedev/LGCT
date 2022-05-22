;~ #RequireAdmin
#include "lgct.au3"
#include <SendMessage.au3>
;~ HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("3"), $port = 5559
;~ RunWait(@ComSpec & ' /c adb -s 127.0.0.1:5555 shell screencap -p /sdcard/Misc/1.0Minhthuan980981.bmp', "", @SW_HIDE)
;~ _ChonSV($WindowHandle, "SV112", $iniFile)

AutoMain($WindowHandle,$port,5)