(*
	This script updates the next review date for pending projects.  Pending projects are those with start dates in the future.  For each such project, the script sets its next review date to its start date.
	
	Future enhancements:
		- add flag to allow not making review dates earlier than already scheduled
		- add code to move the review date for on-hold projects forward to the next weekly review day
			
	version 1.0.1, by Curt Clifton
	
	Copyright © 2010, 2014, 2018 Curtis Clifton
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		• Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		• Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	version 1.0: initial public release
	version 0.2: updated for OmniFocus 2 for Mac
	version 0.1: prototype, not yet released
*)

(*
	The following properties are used for script notifications.
*)
property scriptSuiteName : "Curt’s Scripts"

tell application id "com.omnigroup.Omnifocus3"
	tell default document
		(* Moves next review date of any pending project to match its start date. *)
		set pendingProjects to (every flattened project whose (status is active status or status is on hold status) and defer date comes after (current date))
		repeat with i from 1 to count of pendingProjects
			tell item i of pendingProjects
				set next review date to defer date
			end tell
		end repeat
	end tell
end tell

my notify("Review Dates Updated", "Review dates updated for all pending projects.")

(*
	Uses Notification Center to display a notification message.
	theTitle – a string giving the notification title
	theDescription – a string describing the notification event
*)
on notify(theTitle, theDescription)
	display notification theDescription with title scriptSuiteName subtitle theTitle
end notify

