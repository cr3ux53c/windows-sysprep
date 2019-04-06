Dim hideupdates(5)
hideupdates(0) = "KB971033"
hideupdates(1) = "KB3184143"
hideupdates(2) = "KB3080149"
hideupdates(3) = "KB3068708"
hideupdates(4) = "KB3021917"
hideupdates(5) = "KB2952664"

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