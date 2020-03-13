(*
	This script is a template for use in scripts that need to process every project in an OmniFocus database.  The template provides stubs for two handlers that script developers can complete to create custom solutions.  Script developers, see the handlers shouldProjectBeIncluded and handleProjects.
	
	At this writing (Feb 10, 2010) there is no command in OmniFocus's dictionary to get all the projects, so this template uses a brute force recursion over the Library tree.
	
	version 0.1, by Curt Clifton
	
	Copyright © 2010, Curtis Clifton
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		¥ Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		¥ Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	version 0.1: Original release
*)

(* TODO: Change this property to control whether the script looks at projects inside folders that are hidden. The hidden property of a folder seems to correspond to the Dropped setting for a folder in the OmniFocus user interface. *)
property shouldLookInHiddenFolders : false

(*
	Tests whether the given OmniFocus project should be included in the list of projects to be processed.
	
	Developers should customize this handler if they wish to filter out some projects.
*)
on shouldProjectBeIncluded(theProject)
	using terms from application "OmniFocus"
		-- TODO: test theProject and return true to include it or false to exclude it
		-- For example: return theProject is flagged
		return true
		-- -----------------------------------------------------------------------------
	end using terms from
end shouldProjectBeIncluded

(*
	Processes the list of all matched projects.
	
	Developers should customize this handler to process the projects.
*)
on handleProjects(theMatchedProjects)
	using terms from application "OmniFocus"
		-- TODO: replace the following with code to process the projects (perhaps looping over them to process them individually)
		return count of theMatchedProjects
		-- -----------------------------------------------------------------------------
	end using terms from
end handleProjects

(*
	Main entry point.
*)
tell application "OmniFocus"
	tell front document
		set theSections to every section
		set matchedProjects to my accumulateProjects(theSections, {})
		my handleProjects(matchedProjects)
	end tell
end tell

(* 
	Recurses over the given sections of the Library. Accumulates a list of projects that satisfy the 'shouldProjectBeIncluded' handler.

	theSections: a list of folders, projects, and tasks
	accum: the matching projects that have been found so far 
*)
on accumulateProjects(theSections, accum)
	if (theSections is {}) then return accum
	return accumulateProjects(rest of theSections, accumulateProjectsHelper(item 1 of theSections, accum))
end accumulateProjects

(* 
	Recurses over the tree rooted at the given item. Accumulates a list of projects that satisfy the 'shouldProjectBeIncluded' handler.

	theItem: a folder, project, or task
	accum: the matching projects that have been found so far 
*)
on accumulateProjectsHelper(theItem, accum)
	using terms from application "OmniFocus"
		if (class of theItem is project) then
			-- screens the item before accumulating it
			if my shouldProjectBeIncluded(theItem) then
				set end of accum to theItem
			end if
			return accum
		else if (class of theItem is folder) then
			return my accumulateProjectsInFolder(theItem, accum)
		else
			(* The item must be a task. Shouldn't really reach here since we don't recurse into projects or SALs. *)
			error "Script attempted to process inside a project.  This script is supposedly designed to just process projects.  So, it looks like there's a bug.  Please contact the developer.  We apologize for the inconvenience."
		end if
	end using terms from
end accumulateProjectsHelper

(* 
	Recurses over the tree rooted at the given folder. Accumulates a list of projects that satisfy the 'shouldProjectBeIncluded' handler.

	theFolder: a folder
	accum: the items lacking next actions that have been found so far 
*)
on accumulateProjectsInFolder(theFolder, accum)
	using terms from application "OmniFocus"
		if ((not shouldLookInHiddenFolders) and hidden of theFolder) then return accum
		set theChildren to every section of theFolder
		return my accumulateProjects(theChildren, accum)
	end using terms from
end accumulateProjectsInFolder

