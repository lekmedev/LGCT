#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:9; CLASS:LDPlayerMainFrame]")
$port = 5571
Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=8', @SystemDir, @SW_HIDE)
AutoMain()

