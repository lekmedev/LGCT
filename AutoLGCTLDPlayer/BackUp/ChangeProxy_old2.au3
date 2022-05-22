#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include "Data\UDF\HTTP.au3"
#include "Data\UDF\Json.au3"
#include <Misc.au3>
If _Singleton("ChangeProxy", 1) = 0 Then
	MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running", 1)
	Exit
EndIf
while 1
changeProxy()
Sleep
WEnd
Func changeProxy()
	MsgBox(0, "", "Running", 1)
;~ 	AdlibRegister("changeProxy", 130000)
	Local $ipport, $ip, $Port, $success
;~ 	$ipport = _HTTP_Get("http://proxy.tinsoftsv.com/api/changeProxy.php?key=TLVpukJgUTjwP7dX3gr8n4u51uZDBweyb0hEdG&location=0")
;~ 	ConsoleWrite($ipport)
	$ipport = Json_Decode($ipport)
	$success = Json_ObjGet($ipport, "success")

	If $success = "true" Then
		$ipport = Json_ObjGet($ipport, "proxy")
		$ip = StringSplit($ipport, ":")[1]
		$Port = StringSplit($ipport, ":")[2]
		$ppx = FileRead(@AppDataDir & "\Proxifier\Profiles\run.ppx")
		$ppx = StringRegExpReplace($ppx, "(<Address>)(.*)(<\/Address>[\s\S]*<Port>)(\d*)(<\/Port>)", '${1}' & $ip & '${3}' & $Port & '${5}')
		FileWrite(@ScriptDir & "\run.ppx", $ppx)
		FileMove(@ScriptDir & "\run.ppx", @AppDataDir & "\Proxifier\Profiles\run.ppx", 1)
		Run(@ComSpec & ' /c "C:\Program Files (x86)\Proxifier\Proxifier.exe" C:\Users\Admin\AppData\Roaming\Proxifier\Profiles\Temp.ppx silent-load', "", @SW_HIDE)
		Sleep(100)
		Run(@ComSpec & ' /c "C:\Program Files (x86)\Proxifier\Proxifier.exe" C:\Users\Admin\AppData\Roaming\Proxifier\Profiles\run.ppx silent-load', "", @SW_HIDE)
	Else
		Local $success = Json_ObjGet($ipport, "description")
		MsgBox(0, "Faile", $success, 4)
	EndIf

EndFunc   ;==>changeProxy
