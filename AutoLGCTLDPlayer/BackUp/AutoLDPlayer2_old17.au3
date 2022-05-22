#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557


;~ If _imgSearch("iconHG") = 1 Then
;~ 	_CtrlClickImg($x, $y)
;~ 	_OKIF("iconInHG")
If _imgSearch("iconHG1") = 1 Then
	_CtrlClickImg($x, $y)
	Sleep(1000)
	_OKIF("iconInHGNhan")
	mbox("2")
	If _imgSearch("iconHGNhan") = 1 Then
	mbox("1")
		iconHGNhan()
	EndIf
EndIf
;~ EndIf

Func iconHGNhan()
	Sleep(1000)
	mbox("3")
	If _imgSearch("iconHGNhan") = 1 Then
		Mbox($x)
		_CtrlClickImg($x, $y)
		_OKIF("iconInHGNhan")
		If _imgSearch("iconHGNhan") = 1 Then
			iconHGNhan()
		EndIf
	EndIf

EndFunc   ;==>iconHGNhan



;~ AutoMain()


