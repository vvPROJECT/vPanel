; CapsLock + S autocorrect selected text using google
CapsLock & s::
	spellOld :=
	spellTempCopy := clipboard
	clipboard :=
	Send ^{c}
	ClipWait, 1
	Loop
	{
		UrlDownloadToFile % "https://www.google.co.uk/search?q=" . clipboard, temp
		FileRead, contents, temp
		FileDelete temp
		If (RegExMatch(contents, "(Showing results for|Did you mean:)</span>.*?>(.*?)</a>", match))
		{
			StringReplace, clipboard, match2, <b><i>,, All
			StringReplace, clipboard, clipboard, </i></b>,, All
			clipboard := RegExReplace(clipboard, "&#39;", "'")
			clipboard := RegExReplace(clipboard, "&amp;", "&")
		}
		If (spellOld != clipboard)
		{
			spellOld := clipboard
		}
		else
		{
			break
		}
	}
	Send ^{v}
	Sleep 20
	clipboard := spellTempCopy
Return
