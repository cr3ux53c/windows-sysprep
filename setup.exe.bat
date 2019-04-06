::CraXicS(TM) Windows Facelift Edition: Sysprep Start Setup Consol
::Copyleft 2016-2017, by CraXicS(TM)

::Main
@echo off
echo Initializing...
cd /d %~dp0
echo Mounting Y: Drive...
X:\Windows\MountPEmedia.exe -ini X:\Windows\MountPEmedia.ini
if not exist Y:\Y.MNT (
	echo Y: Drive Mount Failed.
)
call Y:\sources\switch.cmd
