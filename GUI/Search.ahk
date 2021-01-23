if (SubStr(guiTerm,-1,2) == " g") ; g = google
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://www.google.com/search?q=%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " m") ; m = map
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://www.google.com/maps/search/%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " l") ; l = lucky google
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, http://www.google.com/search?q=%guiTermEncoded%&btnI=Im+Feeling+Lucky
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " y") ; y = youtube
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://www.youtube.com/results?search_query=%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " a") ; a = Amazon
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://www.amazon.co.uk/s/ref=nb_sb_noss_2?url=search-alias3Daps&field-keywords=%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " b") ; b = Bing
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://www.bing.com/search?q=%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " r") ; r = Reddit
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	StringReplace , guiTermTrimmed, guiTermTrimmed, %A_Space%,,All
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://www.reddit.com/r/%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " w") ; w = Wikipedia
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	guiTermEncoded := Gui_UriEncode(guiTermTrimmed)
	try Run, https://en.wikipedia.org/wiki/%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,-1,2) == " d") ; d = Dictionary
{
	StringTrimRight, guiTermTrimmed, guiTerm, 2
	try Run, http://dictionary.reference.com/browse/%guiTermEncoded%
	Gui_Destroy()
}
else if (SubStr(guiTerm,0,1) == "=") ; c = Calc
{
	StringTrimRight, guiTermTrimmed, guiTerm, 1
	#Include %A_ScriptDir%\GUI\Calculator.ahk
	guiResponseType = Gui_ResponseShow(eval(guiTermTrimmed))
	GuiControl,, guiTerm
	Gui_ResponseShow(eval(guiTermTrimmed))
}
else ; default = google
{
	guiTermEncoded := Gui_UriEncode(guiTerm)
	try Run, https://www.google.com/search?q=%guiTermEncoded%
	Gui_Destroy()
}