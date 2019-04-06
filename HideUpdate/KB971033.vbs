RequireAdmin

Remove971033

Dim WSHShell, StartTime, ElapsedTime, strUpdateName, strAllHidden

Dim hideupdates
hideupdates = "KB971033"


Set updateSession = CreateObject("Microsoft.Update.Session")
updateSession.ClientApplicationID = "MSDN Sample Script"
Set updateSearcher = updateSession.CreateUpdateSearcher()
Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Software'")

For I = 0 To searchResult.Updates.Count-1
Set update = searchResult.Updates.Item(I)
strUpdateName = update.Title

if instr(1, strUpdateName, hideupdates, vbTextCompare) <> 0 then
update.IsHidden = True
end if

Next



Function RequireAdmin()
Dim reg_valuename, WShell, Cmd, CmdLine, I

GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")_
.EnumValues &H80000003, "S-1-5-19\Environment",  reg_valuename
If IsArray(reg_valuename) <> 0 Then
RequireAdmin = 1
Exit Function
End If

Set Cmd = WScript.Arguments
For I = 0 to Cmd.Count - 1
If Cmd(I) = "/admin" Then
Wscript.Echo "To script you must have administrator rights!"
'RequireAdmin = 0
'Exit Function
WScript.Quit
End If
CmdLine = CmdLine & Chr(32) & Chr(34) & Cmd(I) & Chr(34)
Next
CmdLine = CmdLine & Chr(32) & Chr(34) & "/admin" & Chr(34)

Set WShell= WScript.CreateObject( "WScript.Shell")
CreateObject("Shell.Application").ShellExecute WShell.ExpandEnvironmentStrings(_
"%SystemRoot%\System32\WScript.exe"),Chr(34) & WScript.ScriptFullName & Chr(34) & CmdLine, "", "runas"
WScript.Quit
End Function



Function Remove971033()
Dim reg_valuename, WShell, Cmd, CmdLine, I

Dim objShell, SDCommand

Set objShell = CreateObject("Wscript.Shell")

SDCommand = objShell.Run("wusa.exe /kb:971033 /uninstall /quiet /norestart")
End Function