(*
	This script scans all projects and action groups in the front OmniFocus document identifying any that
	lack a next action.
	
	by Curt Clifton
	
	Copyright © 2007-2014, Curtis Clifton
	
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		¥ Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		¥ Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	version 1.0.3: Fixed a bug when cleaning up after an item with no title had been given a next action.
	version 1.0.2: Fixed a bug when more than 10 items were missing next actions. Improved error handling. Speed improvements.
	version 1.0.1: Fixed to work with the Mac App Store version as well
	version 1.0: Updated for OmniFocus 2:
				¥ Added property to control whether single action lists are searched
				¥ Approximately twice as fast!
				¥ Uses Notification Center
				¥ Offers to reveal the projects and action groups that are missing next actions
				¥ Running the script again after added actions (or marking items completed) clears the Ò(missing next action)Ó suffix
				¥ Better error reporting
	version 0.5.1: Added a script to remove suffix to the package
	version 0.5: Move tag string to be a suffix rather than a prefix
	version 0.4.1: Removed sometimes-problematic use of 'activate' command
	version 0.4: Doesn't flag singleton holding projects as missing next actions even if they are empty
	version 0.3: Limited list of next-action-lacking projects in the dialog to 10.  More than 10 results in a dialog giving the number of such projects (along with the usual identifying-string instructions from the previous release).
	version 0.2: Added identifying string to offending projects based on idea from spiralocean.  Fixed bug where top-level projects without any actions were omitted.
	version 0.1: Original release
*)

property shouldCheckSingleActionLists : false
property lackingListingDelim : (return & "    ¥ ")
property missingNASuffix : "(missing next action)"
property missingNADelimiter : " "

(*
	The following properties are used for script notifications.
*)
property scriptSuiteName : "CurtÕs Scripts"

tell application "OmniFocus"
	tell front document
		try
			set will autosave to false
			my removeSuffixes(it)
			set lackingNextActions to my accumulateMissingNAs(it, {})
			set will autosave to true
		on error errText number errNum
			set will autosave to true
			display dialog "Error: " & errNum & return & errText
			return
		end try
		if (lackingNextActions is {}) then
			if shouldCheckSingleActionLists then
				set msg to "Next actions are identified for all active projects, action groups, and single action lists."
			else
				set msg to "Next actions are identified for all active projects and action groups."
			end if
			my notify("Congratulations!", msg)
		else
			set titleText to "Some active projects or action groups are missing next actions. You can reveal them if you want to correct this."
			set pluralizedItems to "items"
			if ((count of lackingNextActions) is 1) then
				set titleText to "An active project or action group is missing a next action. You can reveal it if you want to correct this."
				set msg to "There is no next action for Ò" & item 1 of lackingNextActions & "Ò. "
				set pluralizedItems to "item"
			else if ((count of lackingNextActions) > 10) then
				set msg to "There are " & (count of lackingNextActions) & " active projects or action groups without next actions. " as text
			else
				set oldDelim to AppleScript's text item delimiters
				set AppleScript's text item delimiters to lackingListingDelim
				set lackingListing to (lackingNextActions as text)
				set AppleScript's text item delimiters to oldDelim
				set msg to "These active projects or action groups do not have next actions:" & lackingListingDelim & lackingListing & return
			end if
			set alertResult to {button returned:""}
			try
				set alertResult to display alert titleText message msg & "Mark the " & pluralizedItems & " as completed, or add actions as needed and re-run this script to remove the Ò" & missingNASuffix & "Ó suffix." buttons {"OK", "Reveal"} default button 2 cancel button 1
			on error errNum
				if (errNum ­ -128) then
					log "Expected user cancelled error but got " & errNum
				end if
			end try
			if (button returned of alertResult is "Reveal") then
				set aWindow to make new document window at before first document window
				tell aWindow
					set selected sidebar tab to projects tab
					set selected of every descendant tree of sidebar to no
					set selected task state filter identifier of content to "incomplete"
					set currentSearchTerm to search term
					if (currentSearchTerm is missing value) then
						display alert "The missing actions cannot be revealed without having the Search field in the toolbar." message "To add the Search field, control-click on the toolbar, choose ÒCustomize ToolbarÉÓ, and drag the Search field onto the toolbar. Re-run this script to reveal the missing actions." buttons {"OK"}
					else
						set search term to "(missing next action)"
					end if
				end tell
			end if
		end if
	end tell
end tell

(* 
	Accumulates a list of items that are:
		¥ not complete and 
		¥ have subtasks, but 
		¥ have no incomplete or pending subtasks.
	theContainer: a document or folder containing flattened projects
	accum: the items lacking next actions that have been found so far 
*)
on accumulateMissingNAs(theContainer, accum)
	log theContainer
	using terms from application "OmniFocus"
		if shouldCheckSingleActionLists then
			set theProjects to every flattened project of theContainer whose status is active status
		else
			set theProjects to every flattened project of theContainer whose status is active status and singleton action holder is false
		end if
		set accum to my accumulateMissingNAsProjects(theProjects, accum)
	end using terms from
end accumulateMissingNAs

(* 
	Recurses over the trees rooted at the given projects, accumulates a list of items that are:
		¥ not complete and 
		¥ have subtasks, but 
		¥ have no incomplete or pending subtasks.
	theProjects: a list of projects
	accum: the items lacking next actions that have been found so far 
*)
on accumulateMissingNAsProjects(theProjects, accum)
	using terms from application "OmniFocus"
		repeat with aProject in theProjects
			log "Checking project: " & (name of aProject)
			set projectContainer to container of aProject
			if (class of projectContainer is not folder or (class of projectContainer is folder and projectContainer is not hidden)) then
				set theRootTask to root task of aProject
				set accum to my accumulateMissingNAsTask(theRootTask, true, accum)
			else
				log "skipped"
			end if
		end repeat
	end using terms from
	return accum
end accumulateMissingNAsProjects

(* 
	Recurses over the tree rooted at the given task, accumulates a list of items that are:
		¥ not complete and 
		¥ have subtasks, but 
		¥ have no incomplete or pending subtasks.
	theTask: a task
	isProjectRoot: true iff theTask is the root task of a project
	accum: the items lacking next actions that have been found so far 
*)
on accumulateMissingNAsTask(theTask, isProjectRoot, accum)
	using terms from application "OmniFocus"
		tell theTask
			set isAProjectOrSubprojectTask to isProjectRoot or (count of (get tasks)) > 0
			if (completed or not isAProjectOrSubprojectTask) then return accum
			set incompleteChildTasks to every task whose completed is false
			if ((count incompleteChildTasks) is 0) then
				set end of accum to name
				-- The following idea of tagging the items with an identifying string is due to user spiralocean on the OmniFocus Extras forum at OmniGroup.com:
				if (name does not end with missingNASuffix) then
					set name to (name & missingNADelimiter & missingNASuffix)
				end if
				return accum
			else
				return my accumulateMissingNAsTasks(incompleteChildTasks, accum)
			end if
		end tell
	end using terms from
end accumulateMissingNAsTask

(* 
	Recurses over the trees rooted at the given tasks, accumulates a list of items that are:
		¥ not complete and 
		¥ have subtasks, but 
		¥ have no incomplete or pending subtasks.
	theTasks: a list of tasks, none of which are project root tasks
	accum: the items lacking next actions that have been found so far 
*)
on accumulateMissingNAsTasks(theTasks, accum)
	using terms from application "OmniFocus"
		repeat with aTask in theTasks
			set accum to my accumulateMissingNAsTask(aTask, false, accum)
		end repeat
	end using terms from
	return accum
end accumulateMissingNAsTasks

(*
	Removes "missing next action" suffixes from all tasks and projects.
	theDocument: an OmniFocus document
*)
on removeSuffixes(theDocument)
	using terms from application "OmniFocus"
		set theTasks to every flattened task of theDocument whose name ends with missingNASuffix
		repeat with aTask in theTasks
			set newName to name of aTask
			if (newName is missingNASuffix) then
				set newName to ""
			else
				set newName to text 1 thru -(1 + (length of missingNASuffix)) of newName
			end if
			if (newName is missingNADelimiter) then
				set newName to ""
			else if (newName ends with missingNADelimiter) then
				set newName to text 1 thru -(1 + (length of missingNADelimiter)) of newName
			end if
			set name of aTask to newName
		end repeat
	end using terms from
end removeSuffixes

(*
	Uses Notification Center to display a notification message.
	theTitle Ð a string giving the notification title
	theDescription Ð a string describing the notification event
*)
on notify(theTitle, theDescription)
	display notification theDescription with title scriptSuiteName subtitle theTitle
end notify
