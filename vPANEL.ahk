#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force

SetCapsLockState, AlwaysOff

; ----- Tray-----

Menu, tray, nostandard
Menu, tray, add, Reload, Script_Reload
Menu, tray, add
Menu, tray, add, Exit, Script_Exit


; ----- AUTO EXEC -----

Gosub, Gui_AutoExec
Gosub, AC_AutoExec
return


; ----- INCLUDE -----
#Include %A_ScriptDir%\GUI\GUI.ahk
#Include %A_ScriptDir%\DefaultCapsLock\DefaultCapsLock.ahk
#Include %A_ScriptDir%\SecondClipboard\SecondClipboard.ahk
#Include %A_ScriptDir%\SpellCheck\GoogleSpellCheck.ahk
#Include %A_ScriptDir%\AutoCorrect\AutoCorrect.ahk
#Include %A_ScriptDir%\Abbreviations\Abbreviations.ahk

Script_Reload:
	Reload
Return

Script_Exit:
	ExitApp
Return

#If, A_IsPaused
	$*Pause::
		suspend
		SoundBeep, 500, 300
		pause
	return
#If

$*Pause::
	suspend
	SoundBeep, 250, 300
	pause
return 