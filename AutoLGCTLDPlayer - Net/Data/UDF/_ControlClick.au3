;================Include UDF========================
#include-once
#include <WinAPI.au3>
;================Varibles to use====================
Global Const $WM_LButton = 0x01
Global Const $WM_MButton = 0x10
Global Const $WM_RButton = 0x02
Global Const $WM_MouseMove = 0x0200

Global Const $WM_LButtonDown = 0x0201
Global Const $WM_LButtonUp = 0x0202
Global Const $WM_LButtonDBlClk = 0x0203

Global Const $WM_RButtonDown = 0x0204
Global Const $WM_RButtonUp = 0x0205
Global Const $WM_RButtonDBlClk = 0x0206

Global Const $WM_MButtonNDown = 0x0207
Global Const $WM_MButtonUp = 0x0208
Global Const $WM_MButtonDBlClk = 0x0209
;===================================================
Global $SUB_LDPLAYER_HWND = DllStructCreate("hwnd")

Func __EnumWindowsProcLDPlayer($hwnd, $param)

    If _WinAPI_GetWindowText($hwnd) = "TheRender" Then
        DllStructSetData($SUB_LDPLAYER_HWND, 1, $hwnd)
        Return False
    EndIf

    Return True
EndFunc


;~ Local $hwnd = _WinAPI_FindWindow("LDPlayerMainFrame", "")
;~ Local $hEnumProc = DllCallbackRegister('__EnumWindowsProcLDPlayer', 'bool', 'hwnd;lparam')
;~ DllCall('user32.dll', 'bool', 'EnumChildWindows', 'hwnd', $hWnd, 'ptr', DllCallbackGetPtr($hEnumProc), 'lparam', 0)

;~ $render_hwnd = DllStructGetData($SUB_LDPLAYER_HWND, 1)

;~ MsgBox(0,"",$render_hwnd)
;~ _ControlClickDrag($render_hwnd,81, 308,81, 222)

;==================_ControlClick====================
;  Parameters:   + $hwnd: handle to the window
;                + $x: x coordinates to click
;                + $y: y coordinates to click
;                + $Btn: button to click - "left", "right", "middle"
;  Return:       - True: clicked
;                - False:
;                  + @error: 1 -> MouseDown failed
;                  + @error: 2 -> MouseUp failed
;==================================================
Func _ControlClick($hwnd, $x, $y, $Btn = "left")
	Local $lParam =  $x + $y * 0x10000, $Return[2]
    If $Btn = "right" Then
		$Return[0] = _WinAPI_PostMessage($hwnd, $WM_RButtonDown, $WM_RButton, $lParam)
		$Return[1] = _WinAPI_PostMessage($hwnd, $WM_RButtonUp, 0, $lParam)
	ElseIf $Btn = "middle" Then
		$Return[0] = _WinAPI_PostMessage($hwnd, $WM_RButtonDown, $WM_MButton, $lParam)
		$Return[1] = _WinAPI_PostMessage($hwnd, $WM_RButtonUp, 0, $lParam)
	Else
		$Return[0] = _WinAPI_PostMessage($hwnd, $WM_LButtonDown, $WM_LButton, $lParam)
		$Return[1] = _WinAPI_PostMessage($hwnd, $WM_LButtonUp, 0, $lParam)
	EndIf
	For $i = 0 to UBound($Return) - 1
		If Not $Return[$i] Then Return SetError($i, 0, False)
	Next
	Return True
EndFunc

;==================_ControlClick====================
;  Parameters:   + $hwnd: handle to the window
;                + $x1: x coordinates to start drag
;                + $y1: y coordinates to start drag
;                + $x1: x coordinates to end drag
;                + $y1: y coordinates to end drag
;                + $Btn: button to click - "left", "right", "middle"
;  Return:       - True: dragged
;                - False:
;                  + @error: 1 -> MouseDown failed
;                  + @error: 2 -> MouseMove failed
;                  + @error: 3 -> MouseUp failed
;==================================================
Func _ControlClickDrag($hwnd, $x1, $y1, $x2, $y2, $Btn = "left")
	Local $Return[3]
	Local $lParam1 =  $x1 + $y1 * 0x10000
	Local $lParam2 =  $x2 + $y2 * 0x10000
   If $Btn = "right" Then
		$Return[0] = _WinAPI_PostMessage($hwnd, $WM_RButtonDown, $WM_RButton, $lParam1)
		$Return[1] = _WinAPI_PostMessage($hwnd, $WM_MouseMove, 0, $lParam2)
		$Return[2] = _WinAPI_PostMessage($hwnd, $WM_RButtonUp, 0, $lParam2)
	ElseIf $Btn = "middle" Then
		$Return[0] = _WinAPI_PostMessage($hwnd, $WM_RButtonDown, $WM_MButton, $lParam1)
		$Return[1] = _WinAPI_PostMessage($hwnd, $WM_MouseMove, 0, $lParam2)
		$Return[2] = _WinAPI_PostMessage($hwnd, $WM_RButtonUp, 0, $lParam2)
	Else
		$Return[0] = _WinAPI_PostMessage($hwnd, $WM_LButtonDown, $WM_LButton, $lParam1)
		$Return[1] = _WinAPI_PostMessage($hwnd, $WM_MouseMove, 0, $lParam2)
		$Return[2] = _WinAPI_PostMessage($hwnd, $WM_LButtonUp, 0, $lParam2)
	EndIf
	For $i = 0 to UBound($Return) - 1
		If Not $Return[$i] Then Return SetError($i, 0, False)
	Next
	Return True
EndFunc