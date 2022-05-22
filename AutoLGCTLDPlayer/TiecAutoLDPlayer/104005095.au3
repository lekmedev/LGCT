Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=8 ', @SystemDir, @SW_HIDE)
Sleep(5555)

IniWrite("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec9.ini","A","IDtiec",StringTrimRight(@ScriptName,4))


ShellExecute("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer9.au3")
