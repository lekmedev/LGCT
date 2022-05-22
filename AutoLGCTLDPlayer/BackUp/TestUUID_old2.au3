#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include "Data\UDF\HTTP.au3"
#include "Data\UDF\Json.au3"
#include <Misc.au3>
#include <WinAPICom.au3>
MsgBox(0,"",uuid())

Func uuid()
    Return StringFormat('%04x%04x-%04x-%04x-%04x-%04x%04x%04x', _
            Random(0, 0xffff), Random(0, 0xffff), _
            Random(0, 0xffff), _
            BitOR(Random(0, 0x0fff), 0x4000), _
            BitOR(Random(0, 0x3fff), 0x8000), _
            Random(0, 0xffff), Random(0, 0xffff), Random(0, 0xffff) _
        )
EndFunc
Func GetUUID()
	Local $ipport, $ip, $Port, $success
	$ipport = _HTTP_Get("https://www.uuidgenerator.net/api/version4")
	Local $UUID = FileRead(@ScriptDir &"\Data\UDF\efunDB.txt")
	$UUID = StringRegExpReplace($UUID, '(string name="EFUN_GOOGLE_ADVERTISING_ID">)(.+?)(<)', '${1}' & $ipport & '${3}')
	ConsoleWrite($UUID)
	FileWrite(@ScriptDir &"\Data\UDF\efunDB.txt",$UUID)
EndFunc   ;==>GetUUID
