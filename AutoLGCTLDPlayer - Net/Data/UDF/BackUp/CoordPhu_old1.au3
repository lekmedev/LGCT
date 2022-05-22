#include-once
Global $_Nhiep_Chinh[2]			= [28 , 335]
Global $_Binh_Tay[2]			= [184, 329]
Global $_Vu_Thanh[2]			= [55 , 369]
Global $_Van_Tuyen[2]			= [97, 333]
Global $_Khoai_Hoat[2]			= [71 , 451]
Global $_Vu_Huan[2]				= [224, 369]

Global $_Khang_Hy[2]			= [143, 60]
Global $_Thai_Hoa[2]			= [244, 87]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]
;~ Global $_[2]			= [ ]


;~ ======================================== Bang
;~ #include <Array.au3>
Global $_Arr_Bang_CH[2][4] =  [["isSTop120","TodayCHBang120","LastCHBang120","330"],["isSTop","TodayCHBang","LastCHBang","150"]]
;~ _ArrayDisplay($_Arr_Bang_CH)
;~ MsgBox(0,"",$_Arr_Bang_CH[1][3])
MsgBox(0,"",(UBound($_Arr_Bang_CH, 1) - 1))
If $j = 2 Then
					If showBang($_Arr_Bang_CH[$i][$j]) > $_Arr_Bang_CH[$i][$j + 1] Then
						MsgBox(0, "", "today > phân tu 4", 1)
						updateBang($_Arr_Bang_CH[$i][$j], 0)
					EndIf
				EndIf