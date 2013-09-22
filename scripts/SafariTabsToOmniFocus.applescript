(*
Safari URLs List to OmniFocus Inbox as Individual Tasks
Copyright (C) 2013 David Nunez (www.davidnunez.com)

This script takes every tab in Safari and creates a brand new task in OmniFocus inbox with the tab title as the task name and the url as the task note.

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
		
		repeat with j from (count of tabs of safariWindow) to 1 by -1
			log (count of tabs of safariWindow)
			set t to tab j of safariWindow
			
			--repeat with t in (tabs of safariWindow)
			set TabTitle to (name of t)
			set TabURL to (URL of t)
			set TabInfo to ("" & TabTitle & return & TabURL & return & return)
			tell front document of application "OmniFocus"
				make new inbox task with properties {name:(TabTitle), note:TabURL}
			end tell
			close t
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

