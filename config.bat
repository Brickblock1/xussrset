
@echo off
if /i "%1" == "user" goto :User
:: No valid parameter, no run directly
echo.
echo This file contains configuration information.
echo Do not run directly!
echo ���� ᮤ�ন� ���㠫�� ��� �����⭮� ࠡ�祩 �⠭樨 ��ࠬ����
echo ��। �ਬ������� ����室��� �஢���� �ࠢ��쭮��� ��⥩
goto :EOF

:: User
:User

:: ����� 㪠�뢠���� ��� � MinGW, nmlc, 7-Zip � TortoiseHg
:: ��� �����⭮�� ���짮��⥫�᪮�� ��������

:: ���� � MinGW
set PATHMINGW=c:\MinGW\msys\1.0\bin;c:\MinGW\bin
:: ���� � NML 0.7.1
:: set PATHNML=C:\utils\nml.7.1
set PATHNML=C:\Python\Python310\Scripts
:: ���� � ��娢���� 7-Zip
set PATH7Z=C:\Program Files\7-Zip
:: ���� �� ���஬� ��������� ���� .grf ��᫥ �ᯥ譮� ᡮન
:: ���� ����, ⮣�� �� ��������� ���㤠
set GRFFOLDER=c:\github\OpenTTD\DATA
:: ��ࠬ���� nmlc: "-c" - ��१��� ᨭ��. ��㣨� - "nmlc --help"
set NMLCOPTION=-c --nfo=%NMLNAME%.nfo --nml=%NMLNAME%_optimized.nml -M --MF=%NMLNAME%_dep.txt

set YDPATH=C:\Users\GVBagaev\YandexDisk