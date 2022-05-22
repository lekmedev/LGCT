#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Misc.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>

Func uuid()
	Return StringFormat('%04x%04x-%04x-%04x-%04x-%04x%04x%04x', _
			Random(0, 0xffff), Random(0, 0xffff), _
			Random(0, 0xffff), _
			BitOR(Random(0, 0x0fff), 0x4000), _
			BitOR(Random(0, 0x3fff), 0x8000), _
			Random(0, 0xffff), Random(0, 0xffff), Random(0, 0xffff) _
			)
EndFunc   ;==>uuid

;~ Func changeEID($t)
;~ 	Local $UUID = FileRead(@ScriptDir & "\Data\UDF\efunDBREad.txt")
;~ 	local $open = FileOpen(@ScriptDir & "\Data\UDF\efunDB"&$t&".txt",2)
;~ 	$UUID = StringRegExpReplace($UUID, '(string name="EFUN_GOOGLE_ADVERTISING_ID">)(.+?)(<)', '${1}' & uuid() & '${3}')
;~ 	FileWrite($open,$UUID)
;~ 	FileClose($open)
;~ EndFunc   ;==>GetUUID

Func changeEID($port)

Run(@ComSpec & ' /k adb -s 127.0.0.1:' & $port & ' shell su -c "rm -r /sdcard/Android/data/efun/"', "", @SW_SHOW)
EndFunc   ;==>GetUUID

;~ adb -s 127.0.0.1:5571 shell su -c 'rm -r /storage/emulated/0/Android/data/efun/'