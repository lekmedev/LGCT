Run(@ComSpec & ' /c "E:\Games\LDPlayer\dnplayer.exe" index=11 ', @SystemDir, @SW_HIDE)
Sleep(5555)

IniWrite("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer\iniFile\tiec12.ini","A","IDtiec",StringTrimRight(@ScriptName,4))


ShellExecute("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\TiecAutoLDPlayer12.au3")
