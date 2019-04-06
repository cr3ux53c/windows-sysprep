::CraXicS™ Integrated Windows Installation System
@echo off
pushd %~dp0
if exist %systemroot%\Setup\Scripts\HideUpdates.vbs (
	exit
) else (
	rd /s /q "%systemroot%\Setup\Scripts"
	schtasks /delete /tn "Delete OOBE Scripts" /f
	schtasks /delete /tn "Hide Unwanted Windows Updates" /f
	rd "%systemroot%\Setup\Scripts"
)
exit
