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
set nBuild=2001
set strCompress=max
set strScratchDir=scr
set strPackagesDir=pkgs
set strUnCompDir=disc
set strSourceFileName=install.wim
set strTargetISOFileName=AutoAudit.iso
set strTargetISOLabel=AuditMode
set strUnattendFileName=AutoInstall.xml
set strUserComments=ISO �����ӿ�ũ�� �����մϴ�.

::Define Constants
for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
set strDISMDir=dism_x64
set strBandizipDir=..\tools\BANDIZIP-PORTABLE-KR-64BIT
set strOscdimgDir=..\tools\oscdimg_x64
set strISOFileName=N/A
for %%a in (*.iso) do call :findISOFile %%a
set nWorkStage=0
set nTotalStage=19
set strBeepDir=..\tools

::Init
echo Initializing...
type %strBeepDir%\BEEP
title CraXicS(TM) Nexprep(TM) Framework %nVersion% #%nBuild%
md %strScratchDir%
md %strUnCompDir%
md %strPackagesDir%

::Output Info
echo.
echo �۾� ���͸�:		%CD%
echo ��ũ��Ʈ ����ѹ�:	%nBuild%
if not exist %strISOFileName% call :errNotFoundISOFile
echo �ҽ� ISO ����:		%strISOFileName%
title CraXicS(TM) Nexprep(TM) Framework %nVersion% #%nBuild%: %strISOFileName%
echo �۾� ���:		%strUserComments%
echo.

::Working
echo ����: �۾��� �Ͻ������Ϸ��� Ctrl+C Ű�� �����ʽÿ�.
pause
color 1F

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ISO ���� ���� ����
color 5F
echo ����: %strUnCompDir% ������ ���ϴ�.
timeout /t 10
color 1F
del /s /q %strUnCompDir%\*
%strBandizipDir%\Bandizip64.exe x %strISOFileName% %strUnCompDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ISO ���� �淮ȭ
md %strUnCompDir%\sources_exp
move %strUnCompDir%\sources\setup.exe %strUnCompDir%\sources_exp
rd /s /q %strUnCompDir%\sources
ren %strUnCompDir%\sources_exp sources
rd /s /q %strUnCompDir%\support
del /q %strUnCompDir%\boot\fonts\chs_boot.ttf
del /q %strUnCompDir%\boot\fonts\cht_boot.ttf
del /q %strUnCompDir%\boot\fonts\jpn_boot.ttf
del /q %strUnCompDir%\efi\microsoft\boot\fonts\chs_boot.ttf
del /q %strUnCompDir%\efi\microsoft\boot\fonts\cht_boot.ttf
del /q %strUnCompDir%\efi\microsoft\boot\fonts\jpn_boot.ttf
del /q %strUnCompDir%\setup.exe
del /q %strUnCompDir%\autorun.inf
copy /y ..\tools\autoboot.wim %strUnCompDir%\sources\boot.wim
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% �ܰ�] ���� �������� �߰�
copy /y ei.cfg %strUnCompDir%\sources\ei.cfg
echo.

type %strBeepDir%\BEEP
color 8f
echo ���: �۾� �Ϸ�!
echo ����: ISO �����ӿ�ũ�� �����Ͽ����ϴ�.
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