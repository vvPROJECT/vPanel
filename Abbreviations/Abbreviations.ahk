CapsLock::
	capsPressed := 1
	Sleep, 5000
	capsPressed := 0
Return

#Hotstring EndChars -()[]{}:;'"/\,.?!`n `t

#If capsPressed = 1

; ----- HOTKEYS (TO RESET) -----

~$*(::
~$*)::
~$*[::
~$*]::
~$*{::
~$*}::
~$*:::
~$*;::
~$*'::
~$*"::
~$*/::
~$*\::
~$*,::
~$*.::
~$*?::
~$*!::
~$*space::
~$*tab::
~$*return::
	Sleep, 50
	capsPressed := 0
Return


; ----- HOTSRINGS -----


; ----- PERSONAL -----
::name::Michael Puckett ; name
::nick::PROJECT ; nickname

::@::michael.puckett.88@gmail.com ; main email
::@2::michael.puckett.signup@gmail.com ; signup email
::@3::michael-puckett@live.com ; spam email
::@4::spambegone@post.com ; live email

; ----- DATA -----
::date::
	Send %A_DD%.%A_MM%.%A_YYYY%
Return

::time::
	Send %A_hour%:%A_min%
Return

; ----- SAYINGS -----
::btw::by the way
::g2g::gotta go
::brb::be right back
::afaik::as far as I know

; ----- SAYINGS -----
::c::©
::r::®
::t::™

; ----- OBJECT -----
::wow::World of Warcraft
::br::battle royale
::fn::Fortnite
::ahk::AutoHotKey

Return
