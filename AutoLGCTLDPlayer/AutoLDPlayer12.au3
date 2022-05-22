#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:12; CLASS:LDPlayerMainFrame]")
$port = 5577

Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=11', @SystemDir, @SW_HIDE)
AutoMain()
