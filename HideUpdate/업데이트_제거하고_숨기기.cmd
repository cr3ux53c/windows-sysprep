@prompt $s
@color 1f
@cd /d %~dp0
@title ������Ʈ_�����ϰ�_�����
@mode con cols=200 lines=1000
@setlocal enabledelayedexpansion

@echo �����ڱ��� Ȯ�ο� >%windir%\admin.confirm || @(
echo Set UAC = CreateObject^("Shell.Application"^) > "%tmp%\admin.vbs"
echo UAC.ShellExecute "%~0", "", "", "runas", 1 >> "%tmp%\admin.vbs"
wscript.exe "%tmp%\admin.vbs" & del "%tmp%\admin.vbs" & exit)
@del %windir%\admin.confirm

@echo.
@echo.
@echo.   ������Ʈ_�����ϰ�_�����~.vbs ���ϵ� �ִ� ������ �����Ͻø� ���� ����˴ϴ�
@echo.
@pause

@echo.

@for /f "tokens=* usebackq" %%a in (`"dir /a-d /b /on *.vbs"`) do  @(

echo.
echo.  =====  "%%a" ���� ���Դϴ�  =====
echo.

"%%a"

)

@echo.
@echo.  =====  ��� �۾��� �Ϸ��߽��ϴ�  =====
@echo.
@pause
@exit


