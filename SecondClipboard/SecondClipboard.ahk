; CapsLock + C to copy to second clipboard
CapsLock & c::
    capsTempCopy := clipboard
	Sleep, 20
	clipboard := ""
	Sleep, 20
	Send, ^{c}
	Sleep, 20
	If Clipboard =
	{
	}
	Else
	{
	capsCopy := clipboard
	}
	Sleep, 20
	clipboard := capsTempCopy
Return

; CapsLock + V to paste second clipboard
CapsLock & v::
	capsTempCopy := clipboard
	Sleep, 20
	clipboard := capsCopy
	Sleep, 20
	Send, ^{v}
	Sleep, 20
	clipboard := capsTempCopy
Return