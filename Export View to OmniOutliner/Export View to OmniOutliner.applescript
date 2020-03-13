(*
	This script generates an OmniOutliner outline from the currently displayed view in OmniFocus.
	
	version 1.2, by Curt Clifton
	
	Copyright © 2007Ð9, 2015, Curtis Clifton
	
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		¥ Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		¥ Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

tell front document of application "OmniFocus"
	tell document window 1
		set topLevelTrees to every tree of content
	end tell
end tell

tell application "OmniOutliner"
	activate
	make new document at before documents
end tell

createRows(topLevelTrees)
return

-- theItems is a list of top-level trees
on createRows(theItems)
	if (theItems is {}) then return
	createRow(item 1 of theItems)
	createRows(rest of theItems)
end createRows

-- anItem is a tree
on createRow(anItem)
	set rowData to getRowData from anItem
	tell front document of application "OmniOutliner"
		set aRow to make new row at end of every child with properties {topic:(rowTopic of rowData), note:(rowNote of rowData)}
	end tell
	createChildren(anItem, aRow)
end createRow

on getRowData from anItem
	using terms from application "OmniFocus"
		try
			set theTopic to name of anItem
		on error errMsg number errNum
			log errMsg & ": " & errNum
			set theTopic to ""
		end try
		
		try
			set itemValue to value of anItem
			set theNote to ""
			repeat with aRun in every attribute run of note of itemValue
				log aRun as text
				set runText to aRun as text
				set runStyle to style of aRun
				set linkAttribute to (first attribute of runStyle whose name is "link")
				set linkAttributeText to value of linkAttribute as text
				if linkAttributeText = "" or linkAttributeText = runText then
					set theNote to theNote & runText
				else
					set theNote to theNote & runText & " (" & linkAttributeText & ")"
				end if
			end repeat
		on error errMsg number errNum
			log errMsg & ": " & errNum
			if errNum = -1728 then
				-- Not all tree nodes have notes, so punt on this error
				set theNote to ""
			else
				set theNote to "Error " & errNum & " getting note"
			end if
		end try
	end using terms from
	return {rowTopic:theTopic, rowNote:theNote}
end getRowData

-- anItem is a tree
-- aRow is an OmniOutliner row
on createChildren(anItem, aRow)
	using terms from application "OmniFocus"
		set itemChildren to every tree of anItem
	end using terms from
	createChildrenHelper(itemChildren, aRow)
end createChildren

-- itemChildren is a list of trees
-- aRow is an OmniOutliner row
on createChildrenHelper(itemChildren, aRow)
	if (itemChildren is {}) then return
	set childItem to item 1 of itemChildren
	set rowData to getRowData from childItem
	tell front document of application "OmniOutliner"
		set childRow to make new row with properties {topic:(rowTopic of rowData), note:(rowNote of rowData)} at after last child of aRow
	end tell
	createChildren(childItem, childRow)
	createChildrenHelper(rest of itemChildren, aRow)
end createChildrenHelper