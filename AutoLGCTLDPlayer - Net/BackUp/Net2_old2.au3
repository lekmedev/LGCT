#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

;~ _OKIF("iconTrangTri")
;~ Sleep(200)
;~ _ClickUtilSeeImg("inTV", 219, 426,1000) ; click thầy
;~ Sleep(200)
;~ _CtrlClickInGame(221, 379)
;~ Sleep(1000)
;~ _CtrlClickInGame(248, 97)
;~ Sleep(2000)
;~ _CtrlClickInGame(38, 97)
;~ Sleep(2000)
;~ _CtrlClickInGame(280, 41)
_OKIF("iconTrangTri")
_ClickUtilSeeImg("inHT",214, 231,1000) ; click hoi tham
Sleep(300)
_CtrlClickInGame(231, 471)
Sleep(1300)
_CtrlClickInGame(231, 471)
Sleep(1300)
_CtrlClickInGame(231, 471)
Sleep(2000)
_CtrlClickInGame(280, 43) ; out tham hoi
Sleep(1000)

if Third($infoAcc, "cthu") Then
		ChinhThu()
		_OKIF("iconTrangTri")
EndIf


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
If _imgSearch("huy") Then
	_CtrlClickInGame(195, 285)
	Sleep(400)
EndIf
Sleep(1000)
_CtrlClickInGame(256, 18)
_ClickUtilSeeImg("iconTrangTri", 264, 22, 1000)
Sleep(1000)
_CtrlClickInGame(22, 472)
Sleep(1000)
_CtrlClickInGame(48, 121)     ; click chon hoa an
Sleep(1000)
If _imgSearch("CHSACH", 18, 332, 267 - 18, 408 - 332) Then
	_CtrlClickInGame($x + 18, $y + 332)
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
	_ClickUtilSeeImg("iconTrangTri", 276, 44, 1000)
EndIf

;~ AutoMain()
