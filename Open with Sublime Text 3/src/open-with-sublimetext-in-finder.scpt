on getSelectedFiles()
	set selectedFiles to {}

	tell application "Finder"
		try
			set theSelection to selection as alias list
		on error
			return {}
		end try

		if theSelection is {} then
			set targetFolder to target of front Finder window as string

			if targetFolder is not "" and targetFolder is not ":" then
				set selectedFiles to targetFolder
			end if
		else
			set selectedFiles to theSelection
		end if
	end tell

	return selectedFiles
end getSelectedFiles

on openWithSublimeText(theFiles)
	tell application "Sublime Text"
		open theFiles
		activate
	end tell
end openWithSublimeText

on run
	set selectedFiles to getSelectedFiles()

	if selectedFiles's length is 0 then
		display alert "Select proper folder or file"
		return
	end if

	openWithSublimeText(selectedFiles)
end run
