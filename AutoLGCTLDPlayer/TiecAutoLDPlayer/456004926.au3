Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=6 ', @SystemDir, @SW_HIDE)
Sleep(5555)

IniWrite("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec7.ini","A","IDtiec",StringTrimRight(@ScriptName,4))


ShellExecute("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer7.au3")
