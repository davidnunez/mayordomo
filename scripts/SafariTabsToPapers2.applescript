(*
Safari URLs List to Papers 2
Copyright (C) 2013 David Nunez (www.davidnunez.com)

This script takes every tab in Safari and attempts to export to papers 2 (note there are sometimes issues w/ IEEE (perhaps cookie related)

It then closes this tab.

When all tabs are closed, the script posts a growl notification.

Derived from these scripts:

- http://veritrope.com/code/export-all-safari-tabs-to-evernote/
- http://veritrope.com/code/safari-tab-list-to-omnifocus
- http://shawnblanc.net/2012/08/frontmost-safari-tabs-omnifocus/
- [closing tabs - note the countdown from number of tabs to 1] http://stackoverflow.com/questions/2503372/how-to-close-all-or-only-some-tabs-in-safari-using-applescript
*)

set tabs_to_close to {}
set the date_stamp to ((the current date) as string)
set NoteTitle to "URL List from Safari Tabs on " & the date_stamp
tell application "Safari"
	activate
	set safariWindow to window 1
	try
		log "2"
		set throttle to 10
		set tab_count to count of tabs of safariWindow
		if (tab_count < throttle) then set throttle to tab_count
		repeat with j from (count of tabs of safariWindow) to 1 by -1
			log (count of tabs of safariWindow)
			set t to tab j of safariWindow
			
			--repeat with t in (tabs of safariWindow)
			set TabTitle to (name of t)
			set TabURL to (URL of t)
			set TabInfo to ("" & TabTitle & return & TabURL & return & return)
			open location "papers2://url/" & urlencode(TabURL) of me & "&title=" & urlencode(TabTitle) of me
			
			--'papers2://url/'+encodeURIComponent(location.href)+'&title='+encodeURIComponent(document.title)
			--close t
		end repeat
		
	end try
end tell


tell application "Growl"
	set the allNotificationsList to {"Success Notification", "Failure Notification"}
	set the enabledNotificationsList to {"Success Notification", "Failure Notification"}
	
	register as application Â
		"Safari Tabs to OmniFocus Script" all notifications allNotificationsList Â
		default notifications enabledNotificationsList Â
		icon of application "Safari"
	
	notify with name Â
		"Success Notification" title Â
		"Successfully Logged" description Â
		"All Safari tabs have been sent tot OmniFocus" application name Â
		"Safari Tabs to OmniFocus Script"
end tell



-- from http://harvey.nu/applescript_url_encode_routine.html

on urlencode(theText)
	set theTextEnc to ""
	repeat with eachChar in characters of theText
		set useChar to eachChar
		set eachCharNum to ASCII number of eachChar
		if eachCharNum = 32 then
			set useChar to "+"
		else if (eachCharNum ­ 42) and (eachCharNum ­ 95) and (eachCharNum < 45 or eachCharNum > 46) and (eachCharNum < 48 or eachCharNum > 57) and (eachCharNum < 65 or eachCharNum > 90) and (eachCharNum < 97 or eachCharNum > 122) then
			set firstDig to round (eachCharNum / 16) rounding down
			set secondDig to eachCharNum mod 16
			if firstDig > 9 then
				set aNum to firstDig + 55
				set firstDig to ASCII character aNum
			end if
			if secondDig > 9 then
				set aNum to secondDig + 55
				set secondDig to ASCII character aNum
			end if
			set numHex to ("%" & (firstDig as string) & (secondDig as string)) as string
			set useChar to numHex
		end if
		set theTextEnc to theTextEnc & useChar as string
	end repeat
	return theTextEnc
end urlencode