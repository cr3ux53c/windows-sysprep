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
set strUserComments=ISO 프레임워크를 제작합니다.

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
echo 작업 디렉터리:		%CD%
echo 스크립트 빌드넘버:	%nBuild%
if not exist %strISOFileName% call :errNotFoundISOFile
echo 소스 ISO 파일:		%strISOFileName%
title CraXicS(TM) Nexprep(TM) Framework %nVersion% #%nBuild%: %strISOFileName%
echo 작업 요약:		%strUserComments%
echo.

::Working
echo 정보: 작업을 일시정지하려면 Ctrl+C 키를 누르십시오.
pause
color 1F

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] ISO 파일 압축 해제
color 5F
echo 주의: %strUnCompDir% 폴더를 비웁니다.
timeout /t 10
color 1F
del /s /q %strUnCompDir%\*
%strBandizipDir%\Bandizip64.exe x %strISOFileName% %strUnCompDir%
echo.

set /a nWorkStage+=1
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] ISO 파일 경량화
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
echo %time%%BS%%BS%%BS% ^>[%nWorkStage%/%nTotalStage% 단계] 버전 구성파일 추가
copy /y ei.cfg %strUnCompDir%\sources\ei.cfg
echo.

type %strBeepDir%\BEEP
color 8f
echo 결과: 작업 완료!
echo 정보: ISO 프레임워크를 생성하였습니다.
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