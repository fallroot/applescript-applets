on getCurrentFolder()
	tell application "Finder"
		set selectionList to (selection as list)

		if length of selectionList is 1 then
			set firstItem to selectionList's first item

			(**
			 * Selection's item is not accessible.
			 * - When the Finder was just loaded.
			 * - Selection is Network, Remote Disc and so on.
			**)
			try
				set itemKind to kind of firstItem
			on error
				return ""
			end try

			if itemKind is "Folder" or itemKind is "Application" or itemKind is "Volume" then
				set currentFolder to firstItem as string
			else
				set currentFolder to firstItem's container as alias
			end if
		else
			set currentTarget to target of front Finder window as string

			if currentTarget is "" then
				return ""
			else
				set currentFolder to currentTarget
			end if
		end if

		return quoted form of POSIX path of currentFolder
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
