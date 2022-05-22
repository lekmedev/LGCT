#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:7; CLASS:LDPlayerMainFrame]")
$port = 5567
Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=6', @SystemDir, @SW_HIDE)
AutoMain()
;~ _AnTiec()
;~ _RegClone()



