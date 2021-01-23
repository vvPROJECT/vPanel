; Alt+CapsLock for default Caplock function:
!CapsLock::
    GetKeyState, CapsState, CapsLock, T
    If CapsState = U
	{
        SetCapsLockState, AlwaysOn
	}
    Else
	{
        SetCapsLockState, AlwaysOff
	}
return

