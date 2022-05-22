#include "lgct.au3"

$WindowHandle = WinGetHandle("[TITLE:5; CLASS:LDPlayerMainFrame]")
$port = 5563
Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=4', @SystemDir, @SW_HIDE)
;~ _Mail()
AutoMain()


