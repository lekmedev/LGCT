#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:11; CLASS:LDPlayerMainFrame]")
$port = 5575
Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=10', @SystemDir, @SW_HIDE)
AutoMain()
;~ _AnTiec()
;~ _RegClone()