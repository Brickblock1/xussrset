@echo off
if /i "%1" == "selfconfig" goto :SelfConfig
if /i "%1" == "gethgrev" goto :GetHgRev
if /i "%1" == "writecustomtags" goto :WriteCustomTags
::if /i "%1" == "echoparams" goto :EchoParams
if /i "%1" == "cleanup" goto :Cleanup

::gcc -v --help
::gcc -C -E -P -o %NMLNAME%.nml - <src/%NMLNAME%.pnml
::gcc -C -E -P - <src/%NMLNAME%.pnml>%NMLNAME%.nml

::: ��ࠬ���� ��� �����
call :SelfConfig
:: ��ࠬ���� ���짮��⥫�
call config user

:: ����� ��६���� ���㦥���
set PATH=%PATHMINGW%;%PATHNML%;%PATHTHG%;%PATH%

:: ��।��塞 ⥪���� ॢ����
call :GetHgRev

:: �᫨ MIN_COMPATIBLE_REVISION == 0, �ᯮ��㥬 REPO_REVISION
if "%MIN_COMPATIBLE_REVISION%" == "0" ^
  set MIN_COMPATIBLE_REVISION=%REPO_REVISION%

:::call :EchoParams
:::exit
:: ᮧ��� 䠩� custom_tags
call :WriteCustomTags>%CUSTOM_TAGS%

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
  -E -C -P -x c -o %NMLNAME%.nml %NMLNAME%.pnml
if /i not %errorlevel% == 0 goto :Error
:: ��������㥬
nmlc --grf=%NMLNAME%.grf %NMLCOPTION% %NMLNAME%.nml
if /i not %errorlevel% == 0 goto :Error
:: �����㥬, �᫨ ����� ����
if /i not "%GRFFOLDER%" == "" (
  xcopy /y %NMLNAME%.grf "%GRFFOLDER%\"
  if /i not %errorlevel% == 0 goto :Error
)
echo [Ok]
goto :EOF
:Error
echo [ERR]
goto :EOF

:: GetHgRev
:GetHgRev

:: ��।��塞 ⥪���� ॢ����
for /F %%i in ('hg id -n') do set REPO_REVISION=%%i

:: 㡨ࠥ� +, �᫨ �� ����
if "%REPO_REVISION:~-1%" == "+" set REPO_REVISION=%REPO_REVISION:~0,-1%

goto :EOF

:: WriteCustomTags
:WriteCustomTags
echo VERSION  :%REPO_REVISION%
echo MIN_COMPATIBLE_REVISION:%MIN_COMPATIBLE_REVISION%
echo TITLE    :xUSSR Railway Set 0.3.r%REPO_REVISION%
echo FILENAME :%NMLNAME%.grf
goto :EOF

:: SelfConfig
:SelfConfig
:: ��� 䠩�� � ����஬
set NMLNAME=xussr
:: ��� �㦥����� 䠩�� ��� ᡮન
set CUSTOM_TAGS=custom_tags.txt
:: �������쭠� ᮢ���⨬�� ॢ����
set MIN_COMPATIBLE_REVISION=496
goto :EOF

:EchoParams
echo --------------
echo NMLNAME=%NMLNAME%
echo CUSTOM_TAGS=%CUSTOM_TAGS%
echo MIN_COMPATIBLE_REVISION=%MIN_COMPATIBLE_REVISION%
echo REPO_REVISION=%REPO_REVISION%
echo NMLCOPTION=%NMLCOPTION%
echo GRFFOLDER=%GRFFOLDER%
echo PATHMINGW=%PATHMINGW%
echo PATHNML=%PATHNML%
echo PATHTHG=%PATHTHG%
echo PATH7Z=%PATH7Z%
echo --------------
goto :EOF

:: ���⪠ ����� �� ࠡ��� 䠩��� �� ������� "compile cleanup"
:Cleanup
call :SelfConfig
del /q /f %NMLNAME%.grf.cache %NMLNAME%.grf.cacheindex %NMLNAME%.grf ^
  %NMLNAME%.nfo %NMLNAME%.nml %NMLNAME%_optimized.nml parsetab.py ^
  custom_tags.txt %NMLNAME%_dep.txt
goto :EOF
