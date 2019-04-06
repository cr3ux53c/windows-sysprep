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
set strUserComments=Windows Media Center ����� Ȱ��ȭ�ϰ� �Ϻ� Windows ����� ���ϴ�. ���ʿ��� ���� �����մϴ�. ���ʿ��� ������ �����մϴ�.
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
echo �۾� ���͸�:		%CD%
echo ��ũ��Ʈ ����ѹ�:	%nBuild%
if not exist %strISOFileName% call :errNotFoundISOFile
echo �ҽ� ISO ����:		%strISOFileName%
title CraXicS(TM) Nexprep(TM) Framework %nVersion% #%nBuild%: %strISOFileName%
echo �ҽ� �ε���:		%nSourceIndex%
echo ��ǥ Windows:	%strTargetWindows%
echo �۾� ���:		%strUserComments%
echo.

::Working
echo ����: �۾��� �Ͻ������Ϸ��� Ctrl+C Ű�� �����ʽÿ�.
pause
color 1F

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ISO ���� ���� ����
color 5F
echo ����: %strUnCompDir% �� %strISODir% ������ ���ϴ�.
timeout /t 10
color 1F
del /s /q %strUnCompDir%\*
del /s /q %strISODir%\*
%strBandizipDir%\Bandizip64.exe x %strISOFileName% %strUnCompDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] �ҽ� ����(%strSourceFileName%) ���� ���
%strDISMDir%\dism.exe /get-imageinfo /imagefile:%strUnCompDir%\sources\install.wim
%strDISMDir%\dism.exe /get-imageinfo /imagefile:%strUnCompDir%\sources\install.wim /index:%nSourceIndex%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ������ ž��� �̹��� ���
dir /b /a "%strMountDir%\*" | >nul findstr "^" && (color 5F) || (goto :notFoundFiles)
echo ����: %strMountDir% ������ ���ϴ�.
timeout /t 10
color 1F
%strDISMDir%\dism.exe /unmount-wim /mountdir:%strMountDir% /discard /scratchdir:%strScratchDir%
goto :notFoundFiles_end
:notFoundFiles
echo ����: %strMountDir% ������ �̹� ����ֽ��ϴ�.
:notFoundFiles_end
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] �ҽ� ����(%strSourceFileName%) ž��
color 5F
echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
timeout /t 10
color 1F
%strDISMDir%\dism.exe /mount-wim /wimfile:%strUnCompDir%\sources\%strSourceFileName% /index:%nSourceIndex% /mountdir:%strMountDir% /scratchdir:%strScratchDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] Media Center Ȱ��ȭ
%strDISMDir%\dism.exe /image:%strMountDir% /get-targeteditions
%strDISMDir%\dism.exe /image:%strMountDir% /set-edition:ProfessionalWMC
echo.

REM set /a nWorkStage+=1
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ���� ������Ʈ ����
REM color 5F
REM echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
REM timeout /t 10
REM color 1F
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ���� ������Ʈ ���� - ����̽��� ������Ʈ ���� ��...
REM %strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /add-package /packagepath:%strPackageDir%\windows8.1-kb3173424-x64_ServicingStack_1607.msu
REM color 5F
REM echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
REM timeout /t 10
REM color 1F
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ���� ������Ʈ ���� - 1607 �Ѿ� ���� ��...
REM %strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /add-package /packagepath:%strPackageDir%\Windows8.1-KB3172614-x64_Rollup_1607.msu
REM color 5F
REM echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
REM timeout /t 10
REM color 1F
REM echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ���� ������Ʈ ���� - 1608 �Ѿ� ���� ��...
REM %strDISMDir%\dism.exe /image:%strMountDir% /scratchdir:%strScratchDir% /add-package /packagepath:%strPackageDir%\Windows8.1-KB3179574-x64_Rollup_1608.msu
REM echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] .Net Framework 3.5 ��� Ȱ��ȭ
color 5F
echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
timeout /t 10
color 1F
%strDISMDir%\dism.exe /image:%strMountDir% /Enable-Feature /FeatureName:netfx3 /all /source:%strSxsDir% /limitaccess
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] Windows ��� ����ȭ
color 5F
echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
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
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ���ʿ��� Windows Store �� ����
color 5F
echo ����: ��ٸ��ʽÿ�. ������ �����ϱ� ���� ��� ����մϴ�...
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
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ������� ���� �� ž�� ����
%strDISMDir%\dism.exe /unmount-wim /mountdir:%strMountDir% /commit /scratchdir:%strScratchDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] �ҽ� ����(%strSourceFileName%) ����ȭ
%strDISMDir%\dism.exe /export-image /sourceimagefile:%strUnCompDir%\sources\%strSourceFileName% /sourceindex:%nSourceIndex% /destinationimagefile:%strUnCompDir%\sources\%strSourceFileName%.exp /compress:%strCompress% /scratchdir:%strScratchDir%
del /q %strUnCompDir%\sources\%strSourceFileName%
ren %strUnCompDir%\sources\%strSourceFileName%.exp %strSourceFileName%
echo.

pause

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ISO �����ӿ�ũ ����
xcopy %strISOFrameworkDir% %strISODir%\ /Y /E /H /R
echo.

pause

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] �ҽ� ���� �� ��Ÿ ��ũ��Ʈ �߰�
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
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ISO ���� ����
%strOscdimgDir%\oscdimg.exe -bootdata:2#p0,e,b%strISODir%\boot\etfsboot.com#pEF,e,b%strISODir%\efi\microsoft\boot\efisys.bin %strISODir% -o -h -m -l%strTargetISOLabel% -u2 -udfver102 %strTargetISOFileName%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] �۾� ���͸� ����
color 5F
echo ����: %strUnCompDir%, %strISODir% ���� �� ��� �ӽ� ������ �����մϴ�.
timeout /t 10
color 1F
rd /s /q %strScratchDir%
rd /s /q %strMountDir%
rd /s /q %strUnCompDir%
rd /s /q %strISODir%
echo.

type %strBeepDir%\BEEP
color 8f
echo ���: �۾� �Ϸ�!
echo ����: ������� ������ �غ� ���ƽ��ϴ�. Sysprep �۾��� �����Ϸ��� %strTargetISOFileName% ���Ϸ� �����Ͻʽÿ�.
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
echo ����: ���� ���͸����� ISO ������ ã�� �� �����ϴ�.
echo ����: %CD%
echo ���: ��ġ ���α׷��� �����մϴ�.
echo.
pause
exit