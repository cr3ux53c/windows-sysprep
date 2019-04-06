@setlocal
@cd /d %~dp0
@timeout /t 10

REM @echo update Windows Defender definitions...
REM onlinepkgs\defenderdefinitions\mpam-fe.exe

REM @timeout /t 10

REM @echo install online integrating updates...
REM @for %%a in (onlinepkgs\important\*.msu) do call :findMsuFile %%a
REM @for %%a in (onlinepkgs\importantsecurity\*.msu) do call :findMsuFile %%a
REM @for %%a in (onlinepkgs\optional\*.msu) do call :findMsuFile %%a
REM @for %%a in (onlinepkgs\monthlyrollup\*.msu) do call :findMsuFile %%a
REM @for %%a in (onlinepkgs\nfw3security\*.msu) do call :findMsuFile %%a
REM @for %%a in (onlinepkgs\nfw4security\*.msu) do call :findMsuFile %%a
REM @for %%a in (onlinepkgs\nfwmonthlyrollup\*.msu) do call :findMsuFile %%a

@echo Services optimizing...
sc config DPS start= disabled
sc config WdiServiceHost start= disabled
sc config WdiSystemHost start= disabled
sc config wercplsupport start= disabled
sc config PcaSvc start= disabled
sc config WerSvc start= disabled
sc config DiagTrack start= disabled

@echo Taskschd optimizing...
schtasks.exe /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable

REM @echo GroupPolicy optimizing...
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Activities" /v NoActivities /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v DisableAddSiteMode /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\SQM" /v DisableCustomerImprovementProgram /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v Enabled /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Internet Explorer\Activities" /v NoActivities /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Internet Explorer\Main" /v DisableAddSiteMode /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Internet Explorer\SQM" /v DisableCustomerImprovementProgram /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Internet Explorer\Suggested Sites" /v Enabled /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f
REM gpupdate

REM @timeout /t 10

@echo Sample Favorites deleting...
del "%systemdrive%\Users\Administrator\Favorites\Bing.url"
rd /s /q "%systemdrive%\Users\Administrator\Favorites\Links"
rd /s /q "%systemdrive%\Users\Administrator\Favorites\즐겨찾기 모음"

@echo Media link deleting...
del /f /q "%systemdrive%\Users\Public\Desktop\Media Player Center.lnk"
del /f /q "%systemdrive%\Users\Public\Desktop\Messenger Center.lnk"
del /f /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\Media Player Center.lnk"
del /f /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\Messenger Center.lnk"

@echo hypersleep off...
powercfg -h off

@echo install themes...
xcopy OEMWallpapers\*.* %WinDir%\web\Wallpaper\CraXicS\ /c /f /y
md "%systemdrive%\Users\Administrator\AppData\Local\Microsoft\Windows\Themes"
copy OEMThemes\*.theme %systemdrive%\Users\Administrator\AppData\Local\Microsoft\Windows\Themes\ /y

@echo register OEM info...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /t REG_SZ /d "CraXicS(TM)" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Model /t REG_SZ /d "Windows Facelift Edition 2018 R2 (2018.07.26)" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportPhone /t REG_SZ /d "cr3ux53c@gmail.com" /f
copy oemlogo.bmp %windir%\\system32\\oemlogo.bmp
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Logo /t REG_SZ /d "%windir%\\system32\\oemlogo.bmp" /f

@echo register watermark...
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 00000001 /f

@echo register taskschdule for legacy log-on UX...
schtasks /create /ru SYSTEM /sc ONLOGON /tn "Change to Legacy Logon UX" /tr "reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\UserSwitch" /v Enabled /t REG_DWORD /d 1 /f" /f /rl HIGHEST

@echo creating desktop IE link...
REG COPY HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30309D} HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D} /s /f
REG ADD HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D} /ve /d "Internet Explorer" /f
REG ADD HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\OpenHomePage /ve /d "홈페이지 열기(&H)" /f
REG ADD HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Properties /ve /d "속성&R)" /f
REG ADD HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Properties /v "Position" /d "bottom" /f
REG ADD HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Properties\command /ve /d "control.exe inetcpl.cpl" /f
REG DELETE HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D} /v "LocalizedString" /f
REG DELETE HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\OpenHomePage /v LegacyDisable /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{871C5380-42A0-1069-A2EA-08002B30301D} /f

@echo add Google searchengine...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v DisplayName /t REG_SZ /d Google /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v URL /t REG_SZ /d http://www.google.co.kr/search?hl=ko^&q={searchTerms} /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v ShowSearchSuggestions /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v SuggestionsURL_JSON /t REG_SZ /d http://suggestqueries.google.com/complete/search?output=firefox^&client=firefox^&qu={searchTerms} /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v OSDFileURL /t REG_SZ /d http://www.ieaddons.com/kr/DownloadHandler.ashx?ResourceId=1677 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v FaviconURL /t REG_SZ /d http://www.google.co.kr/favicon.ico /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\SearchScopes\{224FE01B-DD55-4A17-B269-48FA52144092}" /v FaviconPath /t REG_SZ /d "C:\\Users\\Administrator\\AppData\\LocalLow\\Microsoft\\Internet Explorer\\Services\\search_{224FE01B-DD55-4A17-B269-48FA52144092}.ico" /f

type BEEP
REM shutdown /r /t 10
exit /b

:findMsuFile
@wusa.exe %CD%\%~1 /quiet /norestart
@exit /b