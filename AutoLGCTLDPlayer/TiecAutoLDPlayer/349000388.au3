Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=3 ', @SystemDir, @SW_HIDE)
Sleep(5555)

IniWrite("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec4.ini","A","IDtiec",StringTrimRight(@ScriptName,4))


ShellExecute("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer4.au3")
