#include "lgct.au3"
$WindowHandle = WinGetHandle("[TITLE:2; CLASS:LDPlayerMainFrame]")
$port = 5557


;~ If _imgSearch("iconHG") = 1 Then
;~ 	_CtrlClickImg($x, $y)
;~ 	_OKIF("iconInHG")
	if _imgSearch("iconHG1") = 1 Then
	Mbox($x)
		_CtrlClickImg($x, $y)
		if _imgSearch("iconHG1") = 1 Then
			Mbox($x)
			_CtrlClickImg($x, $y)

	EndIf
	EndIf
;~ EndIf

;~ AutoMain()


