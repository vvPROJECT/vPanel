; ----- AUTO EXEC -----

Gui_AutoExec:

	cBarColor 			:= "222222"
	cTermColor 			:= "c" . "cccccc"
	cCommandColor 		:= "c" . "ffe48a "
	cResponseColor 		:= "c" . "9eb4fe"
	guiHeight 			:= 100
	
	guiYPosition := (A_ScreenHeight - guiHeight)
	guiState = closed
Return


; ----- GUI LAUNCH / CLOSE -OR- GO TO URL -----

CapsLock & Space::

	guiTempCopy	:= clipboard
	clipboard 	:=
	send, ^c
	clipWait, 0.2
	url := RegExReplace(Clipboard, "^\s+|\s+$")
	
	Gui_Spawn:
		If guiState != closed
		{
			Gui_Destroy()
			Return
		}

		guiTerm 		:=
		guiTermTrimmed 	:=
		guiResponseType := none
		guiState 		:= open

		Gui, Color, %cBarColor%, %cBarColor%
		Gui, +AlwaysOnTop +SysMenu +ToolWindow -caption +border
		Gui, Font, s16, Segoe UI
		Gui, Font, %cTermColor%
		Gui, Add, Edit, -E0x200 x14 y10 w452 h30 vguiTerm gGui_TermAuto
		Gui, Add, Button, x-10 y-10 w1 h1 Default gGui_TermSubmit
		Gui, Add, Text, %cResponseColor% x21 y10 w558 vguiResponse
		GuiControl, Hide, guiResponse
		Gui, Add, Text, %cCommandColor% x480 y10 w100 right vguiCommand
		GuiControl, Hide, guiCommand
		Gui, Show, y%guiYPosition% h50 w600, vPANEL
		
		If Clipboard !=
		{
			guiTermSpace 	:= clipboard " "
			clipboard 		:=
			clipboard 		:= guiTermSpace
			clipWait, 0.1
			Send ^v
		}
	
	clipboard :=
	clipboard := guiTempCopy
Return

#IfWinExist, vPANEL
	~LButton::
		MouseGetPos, , , id, control
		WinGetTitle, title, ahk_id %id%
		if (title != "vPANEL")
			Gui_Destroy()
	Return
#IfWinExist

GuiEscape: ; triggered on Escape key:
	Gui_Destroy()
Return


; ----- FUNCTIONS AND SUBROUTINES -----

Gui_TermAuto: ; Called when changes made to term
    Gui, Submit, NoHide
    #Include %A_ScriptDir%\GUI\Commands.ahk
	#Include %A_ScriptDir%\GUI\SearchLabel.ahk
Return

#WinActivateForce
Gui_Destroy()
{
    global guiState
	guiState = closed

	GuiControl,, guiTerm,
    Gosub, Gui_TooltipClear
    Gui, Destroy

    ; Bring focus back to another window found on the desktop
    WinActivate
}


; ----- SUBMIT-----

Gui_TermSubmit:
	if guiTerm == "" ; do nothing or repeat response
	{
		if guiResponseType != "none"
		{
			guiTempCopy := clipboard
			sleep, 20
			clipboard := ""
			sleep, 20
			clipboard := guiResponseType
			ClipWait, 0.1
			Send, ^v
			sleep, 20
			clipboard := ""
			sleep, 20
			clipboard := guiTempCopy		
		}
		else
		{
			Gui_Destroy()
		}
	}
	else if (RegExMatch(guiTerm, "^([0-9\-\*\+\s\(\)\=\.,]+)$")) ; Math
	{
		guiTerm		:= RegExReplace(guiTerm, "=")
		guiTermLast := SubStr(guiTerm,0,1)
		if (RegExMatch(guiTermLast, "^([-\*\+\(\=]+)$"))
			StringTrimRight, guiTerm, guiTerm, 1
		
		Gui_CommandShow(eval(guiTerm))
	
		guiTempCopy := clipboard
		sleep, 20
		clipboard := ""
		clipboard := eval(guiTerm)
		ClipWait, 0.1
		Send, ^a
		Send, {Backspace}
		Send, ^v
		sleep, 20
		clipboard := ""
		clipboard := guiTempCopy
	}
	else ; search last 2 letters for space & key letter
		#Include %A_ScriptDir%\GUI\Search.ahk
Return


; ----- ENCODE -----

Gui_UriEncode(Uri, RE="[0-9A-Za-z]")
{
    VarSetCapacity(Var,StrPut(Uri,"UTF-8"),0),StrPut(Uri,&Var,"UTF-8")
    While Code:=NumGet(Var,A_Index-1,"UChar")
    Res.=(Chr:=Chr(Code))~=RE?Chr:Format("%{:02X}",Code)
    Return, Res  
}


; ----- COMMAND -----

Gui_CommandShow(command)
{
	GuiControl,, guiCommand, %command%
	GuiControl, Hide, guiCommand
	GuiControl, Show, guiCommand
}

Gui_CommandHide()
{
	GuiControl, Hide, guiCommand
}


; ----- RESPONSE -----
Gui_ResponseShow(response)
{
	GuiControl,, guiResponse, %response%
	GuiControl, Hide, guiResponse
	GuiControl, Show, guiResponse
}

Gui_ResponseHide()
{
	GuiControl, Hide, guiResponse
}


; ----- TOOLTIP -----

Gui_TooltipClear:
    ToolTip
Return

Gui_CommandLibrary:
    ; hidden GUI used to pass font options to tooltip:
    CoordMode, Tooltip, Screen ; To make sure the tooltip coordinates is displayed according to the screen and not active window
    Gui, 2:Font,s20, Lucida Console
    Gui, 2:Add, Text, HwndhwndStatic

    tooltiptext =
    StringCaseSense, Off ; Matching to both if/If in the IfInString command below
    Loop, read, %A_ScriptDir%/GUI/Commands.ahk
    {
        ; search for the string If Gui_Term =, but search for each word individually because spacing between words might not be consistent. (might be improved with regex)
        If Substr(A_LoopReadLine, 1, 1) != ";" ; Do not display commented commands
        {
            If A_LoopReadLine contains if
            {
                IfInString, A_LoopReadLine, guiTerm 
				{
                    IfInString, A_LoopReadLine, =
                    {
                        StringGetPos, setpos, A_LoopReadLine,=
                        StringTrimLeft, trimmed, A_LoopReadLine, setpos+1 ; trim everything that comes before the = sign
                        StringReplace, trimmed, trimmed, `%A_Space`%,, All
						StringReplace, trimmed, trimmed, `;,%A_Tab%, All
                        tooltiptext .= trimmed
                        tooltiptext .= "`n"

                    }
				}
            }
        }
		Else If Substr(A_LoopReadLine, 1, 1) = ";" ; Display comments as titles
        {
			IfInString, A_LoopReadLine, =
			{
				StringGetPos, setpos, A_LoopReadLine,=
				StringTrimLeft, trimmed, A_LoopReadLine, setpos+1 ; trim everything that comes before the = sign
				StringReplace, trimmed, trimmed, `%A_Space`%,, All
				StringReplace, trimmed, trimmed, `:,`n, All
				tooltiptext .= trimmed
				tooltiptext .= "`n"
			}
        }
    }
    tooltiptextpadded =
    Loop, Parse, tooltiptext,`n
    {
        line = %A_LoopField%
        tooltiptextpadded .= line
        tooltiptextpadded .= "`n"
    }
    ToolTip %tooltiptextpadded%, 3, 3, 1
Return