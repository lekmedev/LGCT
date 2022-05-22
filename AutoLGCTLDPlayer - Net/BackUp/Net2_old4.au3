#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557

;~ _OKIF("iconTrangTri")
;~ Sleep(200)
;~ _ClickUtilSeeImg("inTV", 219, 426, 1000) ; click thầy
;~ Sleep(200)
;~ _CtrlClickInGame(221, 379)
;~ Sleep(1000)
;~ _CtrlClickInGame(248, 97)
;~ Sleep(2000)
;~ _CtrlClickInGame(38, 97)
;~ Sleep(2000)
;~ _CtrlClickInGame(280, 41)
;~ _OKIF("iconTrangTri")
;~ _ClickUtilSeeImg("inHT", 214, 231, 1000) ; click hoi tham
;~ Sleep(300)
;~ _CtrlClickInGame(231, 471)
;~ Sleep(1300)
;~ _CtrlClickInGame(231, 471)
;~ Sleep(1300)
;~ _CtrlClickInGame(231, 471)
;~ Sleep(2000)
;~ _CtrlClickInGame(280, 43) ; out tham hoi
;~ Sleep(1000)

;~ If Third($infoAcc, "cthu") Then
;~ 	ChinhThu()
;~ 	_OKIF("iconTrangTri")
;~ EndIf


;~ _CtrlClickInGame(18, 201)
;~ Sleep(1000)
;~ _CtrlClickInGame(159, 382) ; click con
;~ Sleep(1000)


;~ _CtrlClickInGame(65, 339) ; hoi phuc nhanh
;~ Sleep(1000)

;~ _ClickUtilSeeImg("iconHP", 219, 340, 700)
;~ If _imgSearch("huyNC") Then
;~ 	_CtrlClickImg($x, $y)
;~ EndIf
_ClickUtilSeeImg("inbmoi", 275, 18, 1100)

_CtrlClickInGame(96, 421)
Sleep(1000)
_CtrlClickInGame(229, 481) ; hoi phuc tinh luc

Sleep(2000)
_ClickUtilSeeImg("inFuck", 250, 449, 1000)
Sleep(1000)
_CtrlClickInGame(229, 481) ; hoi phuc tinh luc
Sleep(2000)
_CtrlClickInGame(229, 481) ; hoi phuc tinh luc


;~ _CtrlClickInGame(256, 18)
_ClickUtilSeeImg("iconTrangTri", 280, 22, 1000)
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
	_CtrlClickInGame(279, 16)

;~ 	Mbox("Done Hoa An")
	_ClickUtilSeeImg("iconEmail", 280, 14, 1000)
;~ 	Sleep(1000)
EndIf

_CtrlClickInGame(90, 388)
	Sleep(300)
	_CtrlClickInGame(90, 388)
;~ 	Sleep(1000)
	_OKIF("inCDTL")
	_CtrlClickInGame(236, 474)
	Sleep(1300)
	_ClickUtilSeeImg("iconEmail", 280, 17, 1000)
	_ADB_CMD("input swipe 710 300 90 300 200", $port)
	Sleep(600)
	_CtrlClickInGame(48, 227)
	Sleep(300)
	_CtrlClickInGame(48, 227)
	_OKIF("inLT")
	_CtrlClickInGame(28, 468)
	Sleep(700)

	For $i = 1 To 9
		_CtrlClickInGame(222, 261)
		Sleep(300)
	Next
	_CtrlClickInGame(138, 307)
	_ClickUtilSeeImg("inLT", 242, 99, 1000) ;done loan tac chua out

;~ AutoMain()
