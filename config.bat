
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
set PATHMINGW=f:\MinGW\msys\1.0\bin;f:\MinGW\bin
:: ���� � NML 0.3
set PATHNML=f:\Utils\nml
:: ���� � ��娢���� 7-Zip
set PATH7Z=C:\Program Files\7-Zip
:: ���� � TortoiseHg
set PATHTHG=C:\Program Files\TortoiseHg
:: ���� �� ���஬� ��������� ���� .grf ��᫥ �ᯥ譮� ᡮન
:: ���� ����, ⮣�� �� ��������� ���㤠
set GRFFOLDER=f:\GAMES\OpenTTD\DATA
:: ��ࠬ���� nmlc: "-c" - ��१��� ᨭ��. ��㣨� - "nmlc --help"
set NMLCOPTION=-c --nfo=%NMLNAME%.nfo --nml=%NMLNAME%_optimized.nml -M --MF=%NMLNAME%_dep.txt

set YDPATH=F:\���_���㬥���\YandexDisk