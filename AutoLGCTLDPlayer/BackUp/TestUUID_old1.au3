#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include "Data\UDF\HTTP.au3"
#include "Data\UDF\Json.au3"
#include <Misc.au3>




Func GetUUID()
	Local $ipport, $ip, $Port, $success
	$ipport = _HTTP_Get("https://www.uuidgenerator.net/api/version4")
	local $UUID = FileRead("C:\Users\Admin\Desktop\autoo\AutoLGCTLDPlayer\Data\UDF\efunDB.txt")
$UUID = StringRegExpReplace($UUID, '(string name="EFUN_GOOGLE_ADVERTISING_ID">)(.+?)(<)','${1}' & $ipport & '${3}')
EndFunc   ;==>changeProxy
