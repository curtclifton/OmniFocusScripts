(*
	This script clears every flag in the front OmniFocus database.
			
	version 0.1, by Curt Clifton
	
	Copyright © 2010, Curtis Clifton
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		¥ Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		¥ Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	version 0.1: Original release
*)

(*
	The following properties are used for script notification via Growl.
*)
property growlAppName : "Curt's Scripts"
property scriptStartNotification : "Script Began"
property scriptFinishNotification : "Script Completed"
property defaultNotifications : {scriptFinishNotification}
property allNotifications : defaultNotifications & {scriptStartNotification}
property iconLoaningApplication : "OmniFocus.app"

(*
	Main entry point.
*)
try
	set theResponse to display dialog "Really clear every flag in the OmniFocus database?" buttons {"Clear Flags", "Cancel"} default button "Cancel" cancel button "Cancel" with title "Clear Every Flag?" with icon caution
on error
	return
end try
tell application "OmniFocus"
	
	tell front document
		set flagged of (every flattened task whose flagged is true) to false
	end tell
	
end tell
my notify("Flags Cleared", "Flags cleared on all items in the database.", scriptFinishNotification)

(*
	Uses Growl to display a notification message.
	theTitle Ð a string giving the notification title
	theDescription Ð a string describing the notification event
	theNotificationKind Ð a string giving the notification kind (must be an element of allNotifications)
*)
on notify(theTitle, theDescription, theNotificationKind)
	tell application "Growl"
		register as application growlAppName all notifications allNotifications default notifications defaultNotifications icon of application iconLoaningApplication
		notify with name theNotificationKind title theTitle application name growlAppName description theDescription
	end tell
end notify