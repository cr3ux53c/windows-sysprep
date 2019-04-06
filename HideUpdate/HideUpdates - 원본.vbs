Dim hideupdates(7)
hideupdates(0) = "Microsoft Security Essentials - KB2267621"
hideupdates(1) = "Microsoft Security Essentials - KB2691894"
hideupdates(2) = "Bing Desktop"
hideupdates(3) = "Windows Internet Explorer 9 for Windows 7"
hideupdates(4) = "Windows Internet Explorer 9 for Windows 7 for x64-based Systems"
hideupdates(5) = "KB971033"
hideupdates(6) = "Update for Windows 7 for x64-based Systems (KB971033)"
hideupdates(7) = "KB2483139"

set updateSession = createObject("Microsoft.Update.Session")
set updateSearcher = updateSession.CreateupdateSearcher()

Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Software'")

For i = 0 To searchResult.Updates.Count-1
	set update = searchResult.Updates.Item(i)
	For j = LBound(hideupdates) To UBound(hideupdates) 
	'MsgBox hideupdates(j)
	if instr(1, update.Title, hideupdates(j), vbTextCompare) = 0 then
	  'Wscript.echo "No match found for " & hideupdates(j)
	else
	Wscript.echo "Hiding " & hideupdates(j)
	update.IsHidden = True
	end if
	Next
Next