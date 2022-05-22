#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

	_OKIF("iconTrangTri")
	Sleep(500)
	_CtrlClickInGame(221, 379)
	Sleep(1000)
	_CtrlClickInGame(248, 97)
	Sleep(2000)
	_CtrlClickInGame(38, 97)
	Sleep(2000)
	_CtrlClickInGame(266, 41)
	_OKIF("iconTrangTri")
	_CtrlClickInGame(214, 231)
	Sleep(1000)

	_CtrlClickInGame(231, 471)
	Sleep(1300)
	_CtrlClickInGame(231, 471)
		Sleep(900)
	_CtrlClickInGame(231, 471)
	Sleep(2000) ;tham hoi
	_CtrlClickInGame(263, 43)
	Sleep(1000)


	_CtrlClickInGame(18, 201)
	Sleep(1000)
	_CtrlClickInGame(159, 382)
	Sleep(1000)

	_CtrlClickInGame(65, 339)
	Sleep(700)
	_CtrlClickInGame(65, 339)
	Sleep(700)
	_CtrlClickInGame(65, 339)
	Sleep(1000)
	_CtrlClickInGame(260, 18)

	Sleep(1000)
	_CtrlClickInGame(96, 421)
	Sleep(1000)
	_CtrlClickInGame(229, 481)
	if _imgSearch("huy") Then
		_CtrlClickInGame(195, 285)
		Sleep(400)
	EndIf
	Sleep(1000)
	_CtrlClickInGame(256, 18)
	_ClickUtilSeeImg("iconTrangTri", 264, 22,1000)
	Sleep(1000)
	_CtrlClickInGame(22, 472)
	Sleep(1000)
	_CtrlClickInGame(48, 121) ; click chon hoa an
	Sleep(1000)
	if _imgSearch("CHSACH",18, 332, 267 - 18, 408 - 332) Then
		_CtrlClickInGame($x + 18, $y+332)
		Sleep(1000)
		_CtrlClickInGame(222, 268)
		Sleep(2400)
		_CtrlClickInGame(221, 335)
		Sleep(2400)
		_CtrlClickInGame(219, 403)
		Sleep(2400)
		_CtrlClickInGame(259, 135)
		Sleep(2400)
		_CtrlClickInGame(272, 16)

;~ 	Mbox("Done Hoa An")
	_ClickUtilSeeImg("iconTrangTri", 276, 44,1000)
	EndIf

;~ AutoMain()
