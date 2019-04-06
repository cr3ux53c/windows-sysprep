Dim hideupdates(22)
hideupdates(0) = "KB971033"		' Win7_amd64_Windows ��ǰ ���� ��� ������Ʈ
hideupdates(1) = "KB3184143"		' Win7_amd64_Windows 10 ���� ���׷��̵� ���� ������Ʈ ����
hideupdates(2) = "KB3080149"		' Win7_amd64_������ ��ġ�� ���� ���� �� ���� ���� ���� ������Ʈ �� �ֽ� Windows�� ���� ���� ����
hideupdates(3) = "KB3068708"		' Win7_amd64_���� ���� �� �� ������ ���� ������Ʈ
hideupdates(4) = "KB3021917"		' Win7_amd64_�ֽ� Windows ��ġ �� ���� ������ �߻��� �� �ִ��� �����ϱ� ���� ���� ���� �� ���� ����
hideupdates(5) = "KB2952664"		' Win7_amd64_Windows 7 ���׷��̵忡 ���� ȣȯ�� ������Ʈ
hideupdates(6) = "KB2994290"		' Win8.1_x86_amd64_37�� ��� �������̽� �� ��ġ
hideupdates(7) = "KB3008242"		' Win8.1_x86_amd64_KB2996799 ��ġ �� �ý��� ���� ��� ��� ���� ���� ���� �ذ�
hideupdates(8) = "KB3031044"		' Win8.1_x86_amd64_2014�� 11�� Ǯ �̵�� �������� �̹����� ���۵� OEM �������� �Ӻ���� ���ٿ� �Ŵ����� ����ġ ���ϰ� ��ġ �� �� �ִ� ���� �ذ�
hideupdates(9) = "KB3044374"		' Win8.1_x86_amd64_Windows 10���� ���׷��̵� �ɼ� ����
hideupdates(10) = "KB2976978"		' Win8.1_x86_amd64_CEIP(����� ȯ�� ���� ���α׷�)�� �����ϴ� �ý��ۿ� ���� ���� ����
hideupdates(11) = "KB3013531"		' Win8.1_x86_amd64_Windows���� Windows Phone���� *.mkv ���� ���縦 ����
hideupdates(12) = "KB3013816"		' Win8.1_x86_amd64_2014�� 12�� �ý��� ���� ����� ��ġ ������ (MDM) ������Ʈ ��� ������Ʈ
hideupdates(13) = "KB3033446"		' Win8.1_x86_amd64_Atom Ĩ�� CHT(Intel Cherry Trail) �÷��� �ý��ۿ��� Wi-Fi ���� ���� �Ǵ� ���� ���� ���� �ذ�
hideupdates(14) = "KB3045717"		' Win8.1_x86_amd64_�׷����Ͱ� Crtl Ű�� ������ �б⸦ ������ �ʴ� ���� �ذ�
hideupdates(15) = "KB3054169"		' Win8.1_x86_amd64_OCA(Online Crash Analysis) ������ �з��� �����ִ� �̴ϴ��� ���Ͽ� �ʿ��� ������ �� �߰�
hideupdates(16) = "KB3061493"		' Win8.1_x86_amd64_���ο� ��ġ�� �����ϴ� �ڱ⽺Ʈ������ ����̹��� ����ϴ� ������Ʈ
hideupdates(17) = "KB3080149"		' Win8.1_x86_amd64_�� ���� �� ���� ���� ������ ������Ʈ
hideupdates(18) = "KB3095701"		' Win8.1_x86_amd64_TPM 2.0 ��ġ�� �ν��� �� ���� ���� �ذ�
hideupdates(19) = "KB3133690"		' Win8.1_amd64_Azure R2 Windows Server 2012 ��� �Խ�Ʈ ����ӽſ��� ����Ǵ� ���� ��ġ �Ҵ� ������ �߰�
hideupdates(20) = "KB3137061"		' Win8.1_x86_amd64_Auzure ����ӽ��� ��Ʈ��ũ ����� ������ �ջ� �̽��� �������� �ʴ� ���� �ذ�
hideupdates(21) = "KB3137725"		' Win8.1_x86_amd64_"Get-StorageReliabilityCounter"�� �ùٸ� �µ����� �������� �ʴ� ���� �ذ�
hideupdates(22) = "KB3184143"		' Win8.1_x86_amd64_Windows 10 ���׷��̵� ���� ������Ʈ

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
			'Wscript.echo "Hiding " & hideupdates(j)
			update.IsHidden = True
		end if
	Next
Next
'Re-Search Updates for Refresh Hidden Updates List.
updateSearcher.Search("IsInstalled=0 and Type='Software'")
'Delete files....
Dim WshShell : Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "schtasks /delete /tn ""Hide Unwanted Windows Updates"" /f"

Sub DEL (Execute)
set fso = CreateObject("Scripting.FileSystemObject")
fso.DeleteFile Execute
Set wshShell = Nothing
End Sub

set winsh = CreateObject("WScript.Shell")
set winenv = winsh.Environment("Process")
SYSTEMROOT = winenv("SYSTEMROOT")
DEL SYSTEMROOT & "\Setup\Scripts\HideUpdates.vbs"
