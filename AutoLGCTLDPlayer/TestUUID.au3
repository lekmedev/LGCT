#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Misc.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>



;~ Func changeEID($t)
;~ 	Local $UUID = FileRead(@ScriptDir & "\Data\UDF\efunDBREad.txt")
;~ 	local $open = FileOpen(@ScriptDir & "\Data\UDF\efunDB"&$t&".txt",2)
;~ 	$UUID = StringRegExpReplace($UUID, '(string name="EFUN_GOOGLE_ADVERTISING_ID">)(.+?)(<)', '${1}' & uuid() & '${3}')
;~ 	FileWrite($open,$UUID)
;~ 	FileClose($open)
;~ EndFunc   ;==>GetUUID

Func changeEID($port)

	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' shell su -c "rm -r /sdcard/Android/data/efun/"', "", @SW_HIDE)
EndFunc   ;==>changeEID

;~ adb -s 127.0.0.1:5571 shell su -c 'rm -r /storage/emulated/0/Android/data/efun/'
