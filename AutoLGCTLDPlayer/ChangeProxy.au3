#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include "Data\UDF\HTTP.au3"
#include "Data\UDF\Json.au3"
#include <Misc.au3>
;~ #RequireAdmin

If _Singleton("ChangeProxy", 1) = 0 Then
	Exit
EndIf
	changeProxy()
Func changeProxy()
	Local $ipport, $ip, $Port, $success
	$ipport = _HTTP_Get("http://proxy.tinsoftsv.com/api/changeProxy.php?key=TLVpukJgUTjwP7dX3gr8n4u51uZDBweyb0hEdG&location=0")
;~ 	$ipport = _HTTP_Get("http://proxy.tinsoftsv.com/api/changeProxy.php?key=TLLjItXUdXYDXlTEigwx9oHnEhedN0xAlxSMbe&location=0")
	$ipport = Json_Decode($ipport)
	$success = Json_ObjGet($ipport, "success")

	If $success = "true" Then
		$ipport = Json_ObjGet($ipport, "proxy")
		$ip = StringSplit($ipport, ":")[1]
		$Port = StringSplit($ipport, ":")[2]
		$ppx = FileRead(@AppDataDir & "\Proxifier\Profiles\run.ppx")
;~ 		MsgBox(0, "", $ppx)
;~ 		exit
;~ 		$ppx = StringRegExpReplace($ppx, "(<Address>)(.*)(<\/Address>[\s\S]*<Port>)(\d*)(<\/Port>)", '${1}' & $ip & '${3}' & $Port & '${5}')
		$ppx = StringRegExpReplace($ppx, '([\s\S]*<ConnectionLoopDetection enabled=")(\w+)([\s\S]*)(<Address>)(.*)(<\/Address>[\s\S]*<Port>)(\d*)(<\/Port>)', '${1}' & 'false' & '${3}' & '${4}' & $ip & '${6}'& $Port & '${8}')


		FileWrite(@ScriptDir & "\run.ppx", $ppx)
;~ 		MsgBox(0,"",1)
		FileMove(@ScriptDir & "\run.ppx", @AppDataDir & "\Proxifier\Profiles\run.ppx", 1)
		Run(@ComSpec & ' /c "C:\Program Files (x86)\Proxifier\Proxifier.exe" C:\Users\Admin\AppData\Roaming\Proxifier\Profiles\Default1.ppx silent-load', "", @SW_HIDE)
		Sleep(500)

;~ 		MsgBox(0, $ip, $ppx)
		Run(@ComSpec & ' /c "C:\Program Files (x86)\Proxifier\Proxifier.exe" C:\Users\Admin\AppData\Roaming\Proxifier\Profiles\run.ppx silent-load', "", @SW_HIDE)

	Else
		Local $success = Json_ObjGet($ipport, "description")
;~ 		MsgBox(0, "Faile", $success, 4)
	EndIf
;~ MsgBox(0, "", "", 60)
	Sleep(60000)
EndFunc   ;==>changeProxy