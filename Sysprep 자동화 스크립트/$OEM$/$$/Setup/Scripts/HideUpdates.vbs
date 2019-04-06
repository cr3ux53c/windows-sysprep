Dim hideupdates(22)
hideupdates(0) = "KB971033"		' Win7_amd64_Windows 정품 인증 기술 업데이트
hideupdates(1) = "KB3184143"		' Win7_amd64_Windows 10 무료 업그레이드 관련 업데이트 제거
hideupdates(2) = "KB3080149"		' Win7_amd64_기존의 장치에 대한 진단 및 원격 측정 서비스 업데이트 및 최신 Windows에 대한 정보 제공
hideupdates(3) = "KB3068708"		' Win7_amd64_원격 진단 및 고객 만족에 대한 업데이트
hideupdates(4) = "KB3021917"		' Win7_amd64_최신 Windows 설치 시 성능 문제가 발생할 수 있는지 결정하기 위해 진단 수행 및 정보 전송
hideupdates(5) = "KB2952664"		' Win7_amd64_Windows 7 업그레이드에 대한 호환성 업데이트
hideupdates(6) = "KB2994290"		' Win8.1_x86_amd64_37개 언어 인터페이스 팩 설치
hideupdates(7) = "KB3008242"		' Win8.1_x86_amd64_KB2996799 설치 후 시스템 연결 대기 모드 진입 실패 현상 해결
hideupdates(8) = "KB3031044"		' Win8.1_x86_amd64_2014년 11월 풀 미디어 리프레시 이미지로 제작된 OEM 버전에서 임베디드 락다운 매니저가 예상치 못하게 설치 될 수 있는 현상 해결
hideupdates(9) = "KB3044374"		' Win8.1_x86_amd64_Windows 10으로 업그레이드 옵션 제공
hideupdates(10) = "KB2976978"		' Win8.1_x86_amd64_CEIP(사용자 환경 개선 프로그램)에 참여하는 시스템에 대한 진단 수행
hideupdates(11) = "KB3013531"		' Win8.1_x86_amd64_Windows에서 Windows Phone으로 *.mkv 파일 복사를 지원
hideupdates(12) = "KB3013816"		' Win8.1_x86_amd64_2014년 12월 시스템 센터 모바일 장치 관리자 (MDM) 에이전트 기능 업데이트
hideupdates(13) = "KB3033446"		' Win8.1_x86_amd64_Atom 칩의 CHT(Intel Cherry Trail) 플랫폼 시스템에서 Wi-Fi 연결 문제 또는 성능 저하 문제 해결
hideupdates(14) = "KB3045717"		' Win8.1_x86_amd64_네레이터가 Crtl 키를 눌러도 읽기를 멈추지 않는 현상 해결
hideupdates(15) = "KB3054169"		' Win8.1_x86_amd64_OCA(Online Crash Analysis) 서버의 분류를 도와주는 미니덤프 파일에 필요한 정보를 더 추가
hideupdates(16) = "KB3061493"		' Win8.1_x86_amd64_새로운 장치를 지원하는 자기스트라이프 드라이버를 사용하는 업데이트
hideupdates(17) = "KB3080149"		' Win8.1_x86_amd64_고객 경험 및 진단 원격 측정용 업데이트
hideupdates(18) = "KB3095701"		' Win8.1_x86_amd64_TPM 2.0 장치를 인식할 수 없는 현상 해결
hideupdates(19) = "KB3133690"		' Win8.1_amd64_Azure R2 Windows Server 2012 기반 게스트 가상머신에서 실행되는 개별 장치 할당 지원을 추가
hideupdates(20) = "KB3137061"		' Win8.1_x86_amd64_Auzure 가상머신이 네트워크 끊김과 데이터 손상 이슈를 복구하지 않는 현상 해결
hideupdates(21) = "KB3137725"		' Win8.1_x86_amd64_"Get-StorageReliabilityCounter"가 올바른 온도값을 보고하지 않는 현상 해결
hideupdates(22) = "KB3184143"		' Win8.1_x86_amd64_Windows 10 업그레이드 관련 업데이트

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
