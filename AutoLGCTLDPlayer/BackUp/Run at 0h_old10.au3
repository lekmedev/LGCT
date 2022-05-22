#include <Misc.au3>
while 1
If @HOUR = 0 Then

Sleep(60000)
ShellExecute("auto.bat")

Sleep(30)


EndIf
WEnd

