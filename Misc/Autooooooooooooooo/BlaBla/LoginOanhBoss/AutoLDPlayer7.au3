;~ #RequireAdmin
#include "lgct.au3"
#include <SendMessage.au3>
;~ HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("7"), $port = 5567
;~ RunWait(@ComSpec & ' /c adb -s 127.0.0.1:5555 shell screencap -p /sdcard/Misc/1.0Minhthuan980981.bmp', "", @SW_HIDE)
AutoMain($WindowHandle,$port,13)
;~ _ChonSV($WindowHandle,"SV185",$iniFile)