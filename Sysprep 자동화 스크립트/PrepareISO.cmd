@echo off
setlocal
mode con cols=120 lines=9999
color 2f
prompt $T$H$H$H $P$G
cd /d %~dp0

echo CraXicS(TM) Nexprep(TM) Framework
echo Copyleft 2016-2018, by CraXicS(TM), Korea.
echo.

::User Variables
set nVersion=2
set nBuild=2101
set strCompress=max
set strScratchDir=scr
set strPackageDir=pkgs
set strOnlinePackageDir=onlinepkgs
set strUnCompDir=disc
set strISODir=iso
set strISOFrameworkDir=..\ISO_Framework\disc
set strSourceFileName=install.wim
set strTargetISOFileName=AutoAudit.iso
set strTargetISOLabel=AuditMode
set strUnattendFileName=AutoAudit.xml
set nSourceIndex=1
set strUserComments=Windows Media Center 기능을 활성화하고 일부 Windows 기능을 끕니다. 불필요한 앱을 삭제합니다. 불필요한 파일을 삭제합니다.
set strTargetWindows=Windows 8.1 Pro K with Media Center with Update_amd64_ko

::Define Constants
for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
set strMountDir=mnt
set strDISMDir=dism_x64
set strBandizipDir=..\tools\BANDIZIP-PORTABLE-KR-64BIT
set strOscdimgDir=oscdimg_x64
set strSxsDir=%strUnCompDir%\sources\sxs
set strISOFileName=N/A
for %%a in (*.iso) do call :findISOFile %%a
set nWorkStage=0
set nTotalStage=19
set strBeepDir=..\tools

::Init
echo Initializing...
type %strBeepDir%\BEEP
title CraXicS(TM) Nexprep(TM) Framework %nVersion% #%nBuild%
md %strMountDir%
md %strScratchDir%
md %strUnCompDir%
md %strPackageDir%
md %strISODir%

::Output Info
echo.
echo 작업 디렉터리:		%CD%
echo 스크립트 빌드넘버:	%nBuild%
if not exist %strISOFileName% call :errNotFoundISOFile
echo 소스 ISO 파일:		%strISOFileName%
title CraXicS(TM) Nexprep(TM) Framework %nVersion% #%nBuild%: %strISOFileName%
echo 소스 인덱스:		%nSourceIndex%
echo 목표 Windows:	%strTargetWindows%
echo 작업 요약:		%strUserComments%
echo.

::Working
echo 정보: 작업을 일시정지하려면 Ctrl+C 키를 누르십시오.
pause
color 1F

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] ISO 파일 압축 해제
color 5F
echo 주의: %strUnCompDir% 및 %strISODir% 폴더를 비웁니다.
timeout /t 10
color 1F
del /s /q %strUnCompDir%\*
del /s /q %strISODir%\*
%strBandizipDir%\Bandizip64.exe x %strISOFileName% %strUnCompDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 소스 파일(%strSourceFileName%) 정보 출력
%strDISMDir%\dism.exe /get-imageinfo /imagefile:%strUnCompDir%\sources\install.wim
%strDISMDir%\dism.exe /get-imageinfo /imagefile:%strUnCompDir%\sources\install.wim /index:%nSourceIndex%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 이전에 탑재된 이미지 폐기
dir /b /a "%strMountDir%\*" | >nul findstr "^" && (color 5F) || (goto :notFoundFiles)
echo 주의: %strMountDir% 폴더를 비웁니다.
timeout /t 10
color 1F
%strDISMDir%\dism.exe /unmount-wim /mountdir:%strMountDir% /discard /scratchdir:%strScratchDir%
goto :notFoundFiles_end
:notFoundFiles
echo 정보: %strMountDir% 폴더가 이미 비어있습니다.
:notFoundFiles_end
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 소스 파일(%strSourceFileName%) 탑재
color 5F
echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
timeout /t 10
color 1F
%strDISMDir%\dism.exe /mount-wim /wimfile:%strUnCompDir%\sources\%strSourceFileName% /index:%nSourceIndex% /mountdir:%strMountDir% /scratchdir:%strScratchDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] Media Center 활성화
%strDISMDir%\dism.exe /image:%strMountDir% /get-targeteditions
%strDISMDir%\dism.exe /image:%strMountDir% /set-edition:ProfessionalWMC
echo.

REM set /a nWorkStage+=1
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 사전 업데이트 통합
REM color 5F
REM echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
REM timeout /t 10
REM color 1F
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 사전 업데이트 통합 - 서비싱스택 업데이트 통합 중...
REM %strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /add-package /packagepath:%strPackageDir%\windows8.1-kb3173424-x64_ServicingStack_1607.msu
REM color 5F
REM echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
REM timeout /t 10
REM color 1F
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 사전 업데이트 통합 - 1607 롤업 통합 중...
REM %strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /add-package /packagepath:%strPackageDir%\Windows8.1-KB3172614-x64_Rollup_1607.msu
REM color 5F
REM echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
REM timeout /t 10
REM color 1F
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 사전 업데이트 통합 - 1608 롤업 통합 중...
REM %strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /add-package /packagepath:%strPackageDir%\Windows8.1-KB3179574-x64_Rollup_1608.msu
REM echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] .Net Framework 3.5 기능 활성화
color 5F
echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
timeout /t 10
color 1F
%strDISMDir%\dism.exe /image:%strMountDir% /Enable-Feature /FeatureName:netfx3 /all /source:%strSxsDir% /limitaccess
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] Windows 기능 최적화
color 5F
echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
timeout /t 10
color 1F
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:Microsoft-Windows-MobilePC-LocationProvider-INF
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:Xps-Foundation-Xps-Viewer
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:Printing-XPSServices-Features
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:WindowsMediaPlayer
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:MediaPlayback
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:MSRDC-Infrastructure
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:Printing-Foundation-Features
%strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /Disable-Feature /FeatureName:WorkFolders-Client
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 불필요한 Windows Store 앱 제거
color 5F
echo 주의: 기다리십시오. 오류를 방지하기 위해 잠시 대기합니다...
timeout /t 10
color 1F
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingFinance_2014.926.253.3184_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingFoodAndDrink_2014.926.254.3803_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingHealthAndFitness_2014.926.255.3988_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingMaps_2014.830.1811.3840_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingSports_2014.926.258.4003_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingTravel_2014.926.259.4931_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.HelpAndTips_2014.716.611.79_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Office.OneNote_2014.921.1853.4418_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.SkypeApp_2014.731.933.5139_neutral_~_kzf8qxf38zg5c
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:microsoft.windowscommunicationsapps_2014.830.2330.2719_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxLIVEGames_2013.1011.10.5965_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Reader_2014.312.322.1510_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsAlarms_2013.1204.852.3011_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsCalculator_2013.1007.1950.2960_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsReadingList_2014.626.1418.1617_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsScan_2013.1007.2015.3834_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsSoundRecorder_2013.1010.500.2928_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ZuneMusic_2014.929.2145.59_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ZuneVideo_2014.1002.954.4888_neutral_~_8wekyb3d8bbwe
%strDISMDir%\dism.exe /image:%strMountDir% /Remove-DefaultAppAssociations
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 변경사항 적용 및 탑재 해제
%strDISMDir%\dism.exe /unmount-wim /mountdir:%strMountDir% /commit /scratchdir:%strScratchDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 소스 파일(%strSourceFileName%) 최적화
%strDISMDir%\dism.exe /export-image /sourceimagefile:%strUnCompDir%\sources\%strSourceFileName% /sourceindex:%nSourceIndex% /destinationimagefile:%strUnCompDir%\sources\%strSourceFileName%.exp /compress:%strCompress% /scratchdir:%strScratchDir%
del /q %strUnCompDir%\sources\%strSourceFileName%
ren %strUnCompDir%\sources\%strSourceFileName%.exp %strSourceFileName%
echo.

pause

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] ISO 프레임워크 복사
xcopy %strISOFrameworkDir% %strISODir%\ /Y /E /H /R
echo.

pause

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 소스 파일 및 기타 스크립트 추가
copy /y %strUnCompDir%\sources\%strSourceFileName% %strISODir%\sources\%strSourceFileName%
copy /y ..\tools\%strUnattendFileName% %strISODir%\sources\unattend.xml
copy /y ..\tools\switch.cmd %strISODir%\sources\switch.cmd
copy /y ..\tools\Y.MNT %strISODir%\Y.MNT
copy /y copyprofile.xml %strISODir%\sources\copyprofile.xml
copy /y AutoAudit.cmd %strISODir%\sources\AutoAudit.cmd
xcopy OEMThemes %strISODir%\sources\OEMThemes\ /Y /E
xcopy OEMWallpapers %strISODir%\sources\OEMWallpapers\ /Y /E
copy /y ..\tools\BEEP %strISODir%\sources\BEEP
xcopy %strOnlinePackageDir% %strISODir%\sources\onlinepkgs\ /Y /E /H /R
xcopy manualinst %strISODir%\sources\manualinst\ /Y /E /H /R
copy /y ..\tools\oemlogo.bmp %strISODir%\sources\oemlogo.bmp
REM xcopy $OEM$ %strISODir%\sources\$OEM$\ /Y /E /H /R
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] ISO 파일 생성
%strOscdimgDir%\oscdimg.exe -bootdata:2#p0,e,b%strISODir%\boot\etfsboot.com#pEF,e,b%strISODir%\efi\microsoft\boot\efisys.bin %strISODir% -o -h -m -l%strTargetISOLabel% -u2 -udfver102 %strTargetISOFileName%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 작업 디렉터리 삭제
color 5F
echo 주의: %strUnCompDir%, %strISODir% 폴더 및 모든 임시 폴더를 삭제합니다.
timeout /t 10
color 1F
rd /s /q %strScratchDir%
rd /s /q %strMountDir%
rd /s /q %strUnCompDir%
rd /s /q %strISODir%
echo.

type %strBeepDir%\BEEP
color 8f
echo 결과: 작업 완료!
echo 정보: 감사모드로 진입할 준비를 마쳤습니다. Sysprep 작업을 시작하려면 %strTargetISOFileName% 파일로 부팅하십시오.
echo.
pause
exit

:findISOFile
if exist %~1 (set strISOFileName=%~1)
exit /b
:errNotFoundISOFile
color 4F
type %strBeepDir%\BEEP
type %strBeepDir%\BEEP
echo.
echo 오류: 현재 디렉터리에서 ISO 파일을 찾을 수 없습니다.
echo 정보: %CD%
echo 결과: 배치 프로그램을 종료합니다.
echo.
pause
exit