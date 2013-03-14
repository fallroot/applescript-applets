on getSelectedFiles()
	set selectedFiles to {}

	tell application "Path Finder"
		set theSelection to selection

		if theSelection is missing value then
			set targetfolder to target of first finder window

			if targetfolder is not missing value then
				copy path of targetfolder to the end of selectedFiles
			end if
		else
			repeat with selectedFile in theSelection
				copy path of selectedFile to the end of selectedFiles
			end repeat
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
