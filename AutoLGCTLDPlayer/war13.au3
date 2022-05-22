#include "lgct.au3"
Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=12 ', @SystemDir, @SW_HIDE)
Sleep(5555)
$WindowHandle = WinGetHandle("[TITLE:13; CLASS:LDPlayerMainFrame]")
$port = 5579
;~ AutoMain()
;~ _AnTiec()
;~ _RegClone()
_BossWar()