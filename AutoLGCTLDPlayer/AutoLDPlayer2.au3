#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557



Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=1', @SystemDir, @SW_HIDE)
AutoMain()

