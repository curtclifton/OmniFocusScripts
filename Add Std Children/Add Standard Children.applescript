(*
	Add Standard Children

	This script adds a standard set of child actions to a selected action or project.
	
	by Curt Clifton
	
	Copyright © 2015, Curtis Clifton
	
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		• Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		• Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	Version History:

		0.1, initial draft, Apr 12, 2015

*)

(*
	Configuration:
	• childrenTitles is a list of the titles for the child tasks that will be added
	• includeParentTitle controls whether the child tasks will be named like “Parent Name: Child Name” or just “Child Name”
*)
property childrenTitles : {"ALX", "CAL", "CHC", "MMM", "SIB"}
property includeParentTitle : false

(*
	The following properties are used for script notifications.
*)
property scriptSuiteName : "Curt’s Scripts"

tell application "OmniFocus"
	tell front document
		tell document window 1 -- (first document window whose index is 1)
			set theSelectedItems to selected trees of content
			if ((count of theSelectedItems) ≠ 1) then
				display alert "You must first select a task or project to add children to." message "Select a single task or project in the main outline." as warning
				return
			end if
		end tell
		
		set selectedItem to value of item 1 of theSelectedItems
		set theParentName to name of item 1 of theSelectedItems
		set rootTask to selectedItem
		if (class of rootTask is project) then
			set rootTask to root task of selectedItem
		end if
		if (class of rootTask is not task) then
			display alert "You must select a task or project to add children to." message "Select a task or project in the main outline." as warning
			return
		end if
		
		set will autosave to false
		try
			repeat with childTitle in childrenTitles
				if includeParentTitle then
					set childTitle to theParentName & ": " & childTitle
				end if
				set newTask to make new task with properties {name:childTitle} at after last task of rootTask
				-- HEREDAMMIT
			end repeat
		on error errStr number errorNumber
			set will autosave to true
			error errStr number errorNumber
		end try
		
		my notify("Children Added", "You may need to go to Projects to see the new children.")
		
	end tell
end tell

(*
	Uses Notification Center to display a notification message.
	theTitle – a string giving the notification title
	theDescription – a string describing the notification event
*)
on notify(theTitle, theDescription)
	display notification theDescription with title scriptSuiteName subtitle theTitle
end notify

