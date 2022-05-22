#include-once
#include <File.au3>
#include <HTTP.au3>
;~ MsgBox(0,'','1 = ' & _Crypt_HashData("1"))



$fileList = @ScriptDir & "\ChangePWD.txt"
$AllLine = _FileCountLines($fileList)
$infoAcc = StringSplit(FileReadLine($fileList, 1), " ")
;~ MsgBox($MB_SYSTEMMODAL, "", $AllLine)


For $i = 1 To $AllLine
	$loginName = $infoAcc[1]
	$loginPwd = _Crypt_HashData($infoAcc[2])
	$newPwd = _Crypt_HashData($infoAcc[3])
	$signature = _Crypt_HashData(signa($loginName,StringUpper($loginPwd),StringUpper($newPwd)))


Global $MD5 = _HTTP_Post("http://www.login.aseugame.com/standard_changePwd.shtml", "advertising_id=b5ac8c87-ef55-447e-9acb-443a45fd6960&packageName=com.hd.vngjyp&versionCode=1&signature=02BDDD7E6CA017AD1C529DC352375CD7&region=&appPlatform=e00001&timestamp=1639283674253&userArea=&gameCode=vnypa&loginName=ngocthuan67&eid=4c6880c0-6129-4b20-9c2f-c9c0143ebcb4&newPwd=C4CA4238A0B923820DCC509A6F75849B&language=vi_VN&gameVersion=1.0.1&loginPwd=C4CA4238A0B923820DCC509A6F75849B&os_language=en")
MsgBox(64, "MD5", $MD5)


;~ 	curl -H "accept: */*" -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -H "Cookie: SERVERID=9c2a090410c454cc5ef266f73900eb44|1639283658|1639283658" -H "User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.1.1; SM-G973N Build/LMY47I)" -H "Host: login.aseugame.com" --data-binary "advertising_id=b5ac8c87-ef55-447e-9acb-443a45fd6960&packageName=com.hd.vngjyp&versionCode=1&signature="&$signature&"&region=&appPlatform=e00001&timestamp=1639283674253&userArea=&gameCode=vnypa&loginName="&$loginName&"&eid=4c6880c0-6129-4b20-9c2f-c9c0143ebcb4&newPwd="$newPwd"&language=vi_VN&gameVersion=1.0.1&loginPwd="$loginPwd$"&os_language=en" --compressed "https://login.aseugame.com/standard_changePwd.shtml"

;~ 	RunWait(@ComSpec & '/C curl -H "accept: */*" -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -H "Cookie: SERVERID=9c2a090410c454cc5ef266f73900eb44|1639283658|1639283658" -H "User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.1.1; SM-G973N Build/LMY47I)" -H "Host: login.aseugame.com" --data-binary "advertising_id=b5ac8c87-ef55-447e-9acb-443a45fd6960&packageName=com.hd.vngjyp&versionCode=1&signature="&$signature&"&region=&appPlatform=e00001&timestamp=1639283674253&userArea=&gameCode=vnypa&loginName="&$loginName&"&eid=4c6880c0-6129-4b20-9c2f-c9c0143ebcb4&newPwd="$newPwd"&language=vi_VN&gameVersion=1.0.1&loginPwd="$loginPwd$"&os_language=en" --compressed "https://login.aseugame.com/standard_changePwd.shtml"', "", @SW_SHOW)
;~ 	$CMD = "ipconfig /flushdns"
;~ RunWait(@ComSpec & " /k " & $CMD, @WindowsDir, @SW_SHOW)
	exit
Next

Func signa($par1, $par2, $par3)
	return "9B5C7E482C380118B3CC0DFDA9C9AC9A1639283674253"&$par1&""&$par2&""&$par3&"vnypa"
EndFunc
















;===============================================================================
; Function Name:    _Crypt_HashData()
; Description:          Calculate hash from data
; Syntax:
; Parameter(s):     $vData - data to hash, can be binary or a string
;                   $iAlgID - hash algorithm identifier, can be one of the following:
;                       0x8001 = MD2
;                       0x8002 = MD4
;                       0x8003 = MD5 (default)
;                       0x8004 = SHA1
;                       also see http://msdn.microsoft.com/en-us/library/aa375549(VS.85).aspx
; Requirement(s):
; Return Value(s):  Success = Returns hash string
;                   Failure = Returns empty string and sets error:
;                       @error -1 = error opening advapi32.dll
;                       @error 1 = failed CryptAcquireContext
;                       @error 2 = failed CryptCreateHash
;                       @error 3 = failed CryptHashData
; Author(s):   Siao
; Modification(s):
;===============================================================================
Func _Crypt_HashData($vData, $iAlgID = 0x8003)
    Local $hDll = DllOpen('advapi32.dll'), $iLen = BinaryLen($vData), $hContext, $hHash, $aRet, $sRet = "", $iErr = 0, $tDat = DllStructCreate("byte[" & $iLen+1 & "]"), $tBuf
    DllStructSetData($tDat, 1, $vData)
    If $hDll = -1 Then Return SetError($hDll,0,$sRet)
    $aRet = DllCall($hDll,'int','CryptAcquireContext', 'ptr*',0, 'ptr',0, 'ptr',0, 'dword',1, 'dword',0xF0000000) ;PROV_RSA_FULL = 1; CRYPT_VERIFYCONTEXT = 0xF0000000
    If Not @error And $aRet[0] Then
        $hContext = $aRet[1]
        $aRet = DllCall($hDll,'int','CryptCreateHash', 'ptr',$hContext, 'dword',$iAlgID, 'ptr',0, 'dword',0, 'ptr*',0)
        If $aRet[0] Then
            $hHash = $aRet[5]
            $aRet = DllCall($hDll,'int','CryptHashData', 'ptr',$hHash, 'ptr',DllStructGetPtr($tDat), 'dword',$iLen, 'dword',0)
            If $aRet[0] Then
                $aRet = DllCall($hDll,'int','CryptGetHashParam', 'ptr',$hHash, 'dword',2, 'ptr',0, 'int*',0, 'dword',0) ;HP_HASHVAL = 2
                $tBuf = DllStructCreate("byte[" & $aRet[4] & "]")
                DllCall($hDll,'int','CryptGetHashParam', 'ptr',$hHash, 'dword',2, 'ptr',DllStructGetPtr($tBuf), 'int*',$aRet[4], 'dword',0)
                $sRet = Hex(DllStructGetData($tBuf, 1))
            Else
                $iErr = 3
            EndIf
            DllCall($hDll,'int','CryptDestroyHash', 'ptr',$hHash)
        Else
            $iErr = 2
        EndIf
        DllCall($hDll,'int','CryptReleaseContext', 'ptr',$hContext, 'dword',0)
    Else
        $iErr = 1
    EndIf
    DllClose($hDll)
    Return SetError($iErr,0,$sRet)
EndFunc