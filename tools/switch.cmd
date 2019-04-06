@echo off
setlocal
echo Initializing...
prompt $T$H$H$H $P$G
cd /d %~dp0

::Init
echo CraXicS(TM) Nexprep(TM) AutoAudit
echo Copyleft 2016-2018, by CraXicS(TM), Korea.
set nVersion=2
set nBuild=1011
set strTargetDrive=NULL
set strDestDrive=NULL
title CraXicS(TM) Nexprep(TM) AutoAudit %nVersion% #%nBuild%

for %%a in (Z Y W V U T S R Q P O N M L K J I H G F E D C B A) do (
	if exist %%a:\Windows\ (
		set strTargetDrive=%%a
	)
)
for %%a in (Z Y W V U T S R Q P O N M L K J I H G F E D C B A) do (
	if exist %%a:\CAPTURE_READY (
		set strDestDrive=%%a
		goto G_CAPTURE
	)
)

:G_INST
echo Info: Starting Windows install.
X:\sources\setup.exe /unattend:Y:\sources\unattend.xml
pause

:G_CAPTURE
echo Info: Starting Image capture.
X:\sources\imagex.exe /capture %strTargetDrive%: %strDestDrive%:\install_Sysprep.wim /compress max "Sysprep" /verify
goto G_QUIT

:G_QUIT
echo Completed!
echo Windows PE will be shutdown.
wpeutil shutdown
pause
