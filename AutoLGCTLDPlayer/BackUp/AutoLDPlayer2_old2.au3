#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

	_ClickUtilSeeImgNoSleep("cloneTT", 131, 236)

		Do
		If $flag = 0 Then Return

	_CtrlClickInGame(42, 349)
	Until _imgSearch("fullCH") = 1


	Sleep(1000)
	_CtrlClickInGame(42, 349)
	_CtrlClickInGame(42, 349)
	_CtrlClickInGame(42, 349)
	Mbox("1")
	Sleep(1000)
	_CtrlClickInGame(140, 354)
	_CtrlClickInGame(140, 354)
	_CtrlClickInGame(140, 354)
	Mbox("2")
	Sleep(1000)
	_CtrlClickInGame(226, 353)
	_CtrlClickInGame(226, 353)
	_CtrlClickInGame(226, 353)
	Mbox("3")
	Sleep(1000)
	_CtrlClickInGame(252, 117)
	_CtrlClickInGame(252, 117)
	_CtrlClickInGame(252, 117)
	Mbox("tt")
	_ClickUtilSeeImg("cloneTT", 131, 236)
	Sleep(1000)
	_CtrlClickInGame(226, 353)

	_ClickUtilSeeImg("tangcap", 45, 109)
	Sleep(1000)
	_CtrlClickInGame(220, 257)

	Sleep(1000)
	_CtrlClickInGame(256, 77)
	Sleep(1000)
	_CtrlClickInGame(261, 46)
;~ AutoMain()

;~ ChangePwd()













;~ if $
;~ _AnTiec()

;~ _RegClone()