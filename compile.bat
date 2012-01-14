@echo off
::gcc -v --help
::gcc -C -E -P -o %NMLNAME%.nml - <src/%NMLNAME%.pnml
::gcc -C -E -P - <src/%NMLNAME%.pnml>%NMLNAME%.nml

:: ����� ��६���� ���㦥���
call config setup

:: ��।��塞 ⥪���� ॢ����
for /F %%i in ('hg id -n') do set REPO_REVISION=%%i

:: 㡨ࠥ� +, �᫨ �� ����
if "%REPO_REVISION:~-1%" == "+" set REPO_REVISION=%REPO_REVISION:~0,-1%

:: �᫨ MIN_COMPATIBLE_REVISION == 0, �ᯮ��㥬 REPO_REVISION
if "%MIN_COMPATIBLE_REVISION%" == "0" ^
  set MIN_COMPATIBLE_REVISION=%REPO_REVISION%

:: ᮧ��� 䠩� custom_tags
echo VERSION  :%REPO_REVISION%>%CUSTOM_TAGS%
echo MIN_COMPATIBLE_REVISION:%MIN_COMPATIBLE_REVISION%>>%CUSTOM_TAGS%
echo TITLE    :xUSSR Railway Set 1.0.%REPO_REVISION% Alpha>>%CUSTOM_TAGS%
echo FILENAME :xussr.grf>>%CUSTOM_TAGS%

:: ᮡ�ࠥ�
:: -E            Stop after the preprocessing stage;
::               do not run the compiler proper.
:: -C            Tell the preprocessor not to discard comments.
::               Used with the `-E' option.
:: -P            ��� �㦥����� �뢮��
:: -x c          ��⠥� ��室�� 䠩�� ����ᠭ�묨 �� ��
:: -o filename   १���� �����뢠�� � 䠩�
:: -D amacro=defn Define macro amacro as defn.
gcc -D REPO_REVISION=%REPO_REVISION% ^
  -D MIN_COMPATIBLE_REVISION=%MIN_COMPATIBLE_REVISION% ^
  -E -C -P -x c -o %NMLNAME%.nml src/%NMLNAME%.pnml
if /i not %errorlevel% == 0 goto :Error
:: ��������㥬
nmlc --nfo=%NMLNAME%.nfo --grf=%NMLNAME%.grf ^
  -M --MF=%NMLNAME%_dep.txt %NMLNAME%.nml
:: --nml=%NMLNAME%_optimized.nml
if /i not %errorlevel% == 0 goto :Error
:: �����㥬
xcopy /y %NMLNAME%.grf "%GRFFOLDER%\"
if /i not %errorlevel% == 0 goto :Error
echo [Ok]
goto :EOF
:Error
echo [ERR]
