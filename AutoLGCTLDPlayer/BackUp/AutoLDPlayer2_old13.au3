#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557


_OKIF("inQuestVT")
	Sleep(600)
	_CtrlClickInGame(251, 427)
	_CtrlClickInGame(132, 176)
	Sleep(700)
	Mbox("1")
	_ClickUtilSeeImg("inQuestVT", 210, 215, 500)

AutoMain()


