@prompt $s
@color 1f
@cd /d %~dp0
@title 업데이트_제거하고_숨기기
@mode con cols=200 lines=1000
@setlocal enabledelayedexpansion

@echo 관리자권한 확인용 >%windir%\admin.confirm || @(
echo Set UAC = CreateObject^("Shell.Application"^) > "%tmp%\admin.vbs"
echo UAC.ShellExecute "%~0", "", "", "runas", 1 >> "%tmp%\admin.vbs"
wscript.exe "%tmp%\admin.vbs" & del "%tmp%\admin.vbs" & exit)
@del %windir%\admin.confirm

@echo.
@echo.
@echo.   업데이트_제거하고_숨기기~.vbs 파일들 있는 곳에서 실행하시면 전부 적용됩니다
@echo.
@pause

@echo.

@for /f "tokens=* usebackq" %%a in (`"dir /a-d /b /on *.vbs"`) do  @(

echo.
echo.  =====  "%%a" 실행 중입니다  =====
echo.

"%%a"

)

@echo.
@echo.  =====  모든 작업을 완료했습니다  =====
@echo.
@pause
@exit


