#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:8; CLASS:LDPlayerMainFrame]")
$port = 5569

Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=7', @SystemDir, @SW_HIDE)
AutoMain()
;~ tem()