#NoTrayIcon

Global Const $lciWM_SYSCommand = 274
Global Const $lciSC_MonitorPower = 61808
Global Const $lciPower_Off = 2
Global Const $lciPower_On = -1

Global $MonitorIsOff = False

HotKeySet("{F11}", "_Monitor_OFF")
HotKeySet("{F10}", "_Monitor_ON")
HotKeySet("{Esc}", "_Quit")
_Monitor_OFF()



Func _Monitor_ON()
    $MonitorIsOff = False
    Local $Progman_hwnd = WinGetHandle('[CLASS:Progman]')

    DllCall('user32.dll', 'int', 'SendMessage', _
                                                'hwnd', $Progman_hwnd, _
                                                'int', $lciWM_SYSCommand, _
                                                'int', $lciSC_MonitorPower, _
                                                'int', $lciPower_On)
EndFunc

Func _Monitor_OFF()
    $MonitorIsOff = True
    Local $Progman_hwnd = WinGetHandle('[CLASS:Progman]')

    While $MonitorIsOff = True
        DllCall('user32.dll', 'int', 'SendMessage', _
                                                    'hwnd', $Progman_hwnd, _
                                                    'int', $lciWM_SYSCommand, _
                                                    'int', $lciSC_MonitorPower, _
                                                    'int', $lciPower_Off)
        _IdleWaitCommit(0)
        Sleep(20)
    WEnd
EndFunc

Func _IdleWaitCommit($idlesec)
    Local $iSave, $LastInputInfo = DllStructCreate ("uint;dword")
    DllStructSetData ($LastInputInfo, 1, DllStructGetSize ($LastInputInfo))
    DllCall ("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr ($LastInputInfo))
    Do
        $iSave = DllStructGetData ($LastInputInfo, 2)
        Sleep(60)
        DllCall ("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr ($LastInputInfo))
    Until (DllStructGetData ($LastInputInfo, 2)-$iSave) > $idlesec Or $MonitorIsOff = False
    Return DllStructGetData ($LastInputInfo, 2)-$iSave
EndFunc

Func _Quit()
    _Monitor_ON()
    Exit
EndFunc