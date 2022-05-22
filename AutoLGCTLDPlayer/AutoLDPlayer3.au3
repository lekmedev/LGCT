#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:3; CLASS:LDPlayerMainFrame]")
$port = 5559
;~ QuaHG()
Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=2', @SystemDir, @SW_HIDE)
AutoMain()
