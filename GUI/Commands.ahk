; ----- =SITES


if guiTerm = reddit ; Reddit
{
	Gui_Destroy()
    try	Run, www.reddit.com
}
else if guiTerm = gmail ; Gmail
{
	Gui_Destroy()
    try	Run, https://gmail.google.com/
}
else if guiTerm = drive ; Drive
{
	Gui_Destroy()
    try	Run, https://drive.google.com/
}


; ----- =:APPS

else if guiTerm = text ; Text editor
{
	Gui_Destroy()
    try	Run, C:\Program Files (x86)\Notepad++\Notepad++.exe
}
else if guiTerm = comms ; Comms app
{
	Gui_Destroy()
    try	Run, C:\Users\%A_Username%\AppData\Local\Discord\app-0.0.300\discord.exe
}
else if guiTerm = music ; Music app
{
	Gui_Destroy()
    try	Run, C:\Users\%A_Username%\AppData\Local\headset\headset.exe
}
else if guiTerm = calc ; Calculator
{
	Gui_Destroy()
    try	Run, calc
}
else if guiTerm = reg ; RegEdit
{
	Gui_Destroy()
	try	Run, regedit
}


; ----- =:GAMES

else if guiTerm = /epic ; Epic Launcher
{
	Gui_Destroy()
    try	Run, C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32\epicgameslauncher.exe
}
else if guiTerm = /steam ; Steam
{
	Gui_Destroy()
    try	Run, C:\Program Files (x86)\Steam\steam.exe
}
else if guiTerm = /battle ; Battle.net
{
	Gui_Destroy()
    try	Run, C:\Program Files (x86)\Blizzard App\Battle.net.exe 
}


; ----- =:TYPE

else if guiTerm = name ; Name
{
	Gui_Destroy()
    Send, FirstName LastName
}
else if guiTerm = @ ; Email
{
	Gui_Destroy()
    Send, your@email.com
}


; ----- =:FOLDERS

else if guiTerm = down ; Downloads
{
	Gui_Destroy()
    try	Run, C:\Users\%A_Username%\Downloads
}
else if guiTerm = /user ; User Directory
{
	Gui_Destroy()
    try	Run, C:\Users\%A_Username%
}
else if guiTerm = open ; Script Folder
{
	Gui_Destroy()
    try	Run, "%A_ScriptDir%"
}
else if guiTerm = bin ; Recycle Bin
{
	Gui_Destroy()
    try	Run, ::{645FF040-5081-101B-9F08-00AA002F954E}
}


; ----- =:TOOLS

else if guiTerm = speed ; Speed Test
{
	Gui_Destroy()
    try	Run, "http://www.speedtest.net/run"
}
else if guiTerm = ping ; Ping Test
{
	Gui_Destroy()
    try	Run, cmd /K "ping www.google.com"
}
else if guiTerm = rel ; Reload Script
{
	Gui_Destroy()
		Reload
}

; ----- =:DISPLAY
else if guiTerm = roll ; Roll a Dice
{
	guiResponseType = roll
	GuiControl,, guiTerm,
    Random, ucRandomNumber, 1, 6
	Gui_ResponseShow("You rolled a " ucRandomNumber)
}
else if guiTerm = flip ; Flip a Coin
{
	guiResponseType = flip
	GuiControl,, guiTerm,
	Random, ucRandomNumber, 1, 2
	If (ucRandomNumber = 1)
	{
		Gui_ResponseShow("Heads - (Coin Flip)")
	}
	Else
	{
		Gui_ResponseShow("Tails - (Coin Flip)")
	}
}
else if guiTerm = ran  ; Random 1 - 100
{
	guiResponseType = ran
	GuiControl,, guiTerm,
    Random, ucRandomNumber, 1, 100
	Gui_ResponseShow(ucRandomNumber " - (Random 1-100)")
}
else if (RegExMatch(guiTerm, "^([0-9\-\*\+\s\(\)\=\.,]+)$")) ; Math
{
	guiResponseType	:= math
}
else if guiTerm = date ; Date
{	
	guiResponseType = date
	GuiControl,, guiTerm,
    FormatTime, dateDayName,, dddd
	FormatTime, dateDay,, d
	FormatTime, dateMonth,, MMMM
	FormatTime, dateYear,, yyyy
	Gui_ResponseShow(dateDayName " " dateDay " " dateMonth )
}
else if guiTerm = ? ; Command List
{
    GuiControl,, guiTerm, ; Clear the input box
    Gosub, Gui_CommandLibrary
}
else if guiTerm !=
{
	Gui_ResponseHide()
	guiResponseType = none
}