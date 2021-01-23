if (SubStr(guiTerm,-1,2) == " g") ; Google
	Gui_CommandShow("Google")

else if (SubStr(guiTerm,-1,2) == " m") ; Map
	Gui_CommandShow("Map")

else if (SubStr(guiTerm,-1,2) == " l") ; Lucky
	Gui_CommandShow("Lucky")

else if (SubStr(guiTerm,-1,2) == " y") ; YouTube
	Gui_CommandShow("YouTube")

else if (SubStr(guiTerm,-1,2) == " a") ; Amazon
	Gui_CommandShow("Amazon")

else if (SubStr(guiTerm,-1,2) == " b") ; Bing
	Gui_CommandShow("Bing")

else if (SubStr(guiTerm,-1,2) == " r") ; SubReddit
	Gui_CommandShow("Reddit")

else if (SubStr(guiTerm,-1,2) == " w") ; Wikipedia
	Gui_CommandShow("Wiki")

else if (SubStr(guiTerm,-1,2) == " d") ; Dictionary
	Gui_CommandShow("Define")

else if (RegExMatch(guiTerm, "^([0-9\-\*\+\s\(\)\=\.,]+)$")) ; Math
{
	guiTerm		:= RegExReplace(guiTerm, "=")
	guiTermLast := SubStr(guiTerm,0,1)
	if (RegExMatch(guiTermLast, "^([-\*\+\(\=]+)$"))
		StringTrimRight, guiTerm, guiTerm, 1
		
	Gui_CommandShow(eval(guiTerm))
}
else
	Gui_CommandHide()