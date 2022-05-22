#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:4; CLASS:LDPlayerMainFrame]")
$port = 5561

Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=3', @SystemDir, @SW_HIDE)
AutoMain()
;~ _AnTiec()
