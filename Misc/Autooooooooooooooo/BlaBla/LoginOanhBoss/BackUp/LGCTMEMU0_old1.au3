#include "lgct.au3"
local $WindowHandle = WinGetHandle("(MEmu - 0)"), $port = 21503
if _imgSearch($WindowHandle,"dotRed",73, 61,92, 78) Then
	MsgBox(0,$x+73,$y)
	endif
;~ AutoMain($WindowHandle,$port)