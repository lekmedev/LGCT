;~ #RequireAdmin
#include "lgct.au3"
#include <SendMessage.au3>
;~ HotKeySet("{ESC}", "Terminate")
Local $WindowHandle = WinGetHandle("6"), $port = 5565
;~ RunWait(@ComSpec & ' /c adb -s 127.0.0.1:5555 shell screencap -p /sdcard/Misc/1.0Minhthuan980981.bmp', "", @SW_HIDE)
AutoMain($WindowHandle,$port,11)
;~ _ChonSV($WindowHandle,"SV185",$iniFile)