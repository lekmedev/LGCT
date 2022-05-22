#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:6; CLASS:LDPlayerMainFrame]")
$port = 5565
;~ Mbox("1")
Run(@ComSpec & ' /c "E:\Game\LDPlayer\dnplayer.exe" index=5', @SystemDir, @SW_HIDE)
AutoMain()
;~ _AnTiec()
;~ _RegClone()