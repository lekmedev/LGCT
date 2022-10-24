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
	AdsiD($port)
EndFunc   ;==>changeEID

Func uuid()
	Return StringFormat('%04x%04x-%04x-%04x-%04x-%04x%04x%04x', _
			Random(0, 0xffff), Random(0, 0xffff), _
			Random(0, 0xffff), _
			BitOR(Random(0, 0x0fff), 0x4000), _
			BitOR(Random(0, 0x3fff), 0x8000), _
			Random(0, 0xffff), Random(0, 0xffff), Random(0, 0xffff) _
			)
EndFunc   ;==>uuid

Func AdsiD($port)
	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' pull /data/data/com.hd.vngjyp/shared_prefs/Efun.db.xml "' & @ScriptDir & "\AdsID\" & $port, "", @SW_HIDE)
	Sleep(400)
	$ppx = FileRead(@ScriptDir & "\AdsID\" & $port & "\Efun.db.xml")
	Sleep(300)
	$ppy = StringRegExpReplace($ppx, '([\s\S]*ADVERTISING_ID">)([\s\S]*?)(<\/string>)([\s\S]*)', '${1}' & uuid() & '${3}' & '${4}')
	FileOpen(@ScriptDir & "\AdsID\" & $port & "\Efun.db.xml", 2)
	FileWrite(@ScriptDir & "\AdsID\" & $port & "\Efun.db.xml", $ppy)
	FileClose(@ScriptDir & "\AdsID\" & $port & "\Efun.db.xml")
 	Run(@ComSpec & ' /c adb -s 127.0.0.1:' & $port & ' push ' & @ScriptDir & "\AdsID\" & $port & "\Efun.db.xml /data/data/com.hd.vngjyp/shared_prefs/", "", @SW_HIDE)
EndFunc   ;==>AdsiD
;~ ([\s\S]*ADVERTISING_ID">)([\s\S]*?)(<\/string>)([\s\S]*)