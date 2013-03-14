on getCurrentFolder()
	tell application "Path Finder"
		set selectionList to selection as list
		set firstItem to selectionList's first item
		set currentTarget to first finder window's target

		if firstItem is not missing value and selectionList's length is 1 then
			if firstItem's class is fsFolder then
				set currentFolder to firstItem
			else
				set currentFolder to firstItem's container
			end if
		else
			if currentTarget is missing value then
				return ""
			else
				set currentFolder to currentTarget
			end if
		end if

		return quoted form of (POSIX path of currentFolder as string)
	end tell
end getCurrentFolder

on openWithiTerm(thePath)
	tell application "iTerm"
		activate

		tell current session of current terminal
			write text "cd" & space & thePath
		end tell
	end tell
end openWithiTerm

on run
	set currentFolder to getCurrentFolder()

	if currentFolder is "" then
		display alert "Select only one folder or file"
		return
	end if

	openWithiTerm(currentFolder)
end run
