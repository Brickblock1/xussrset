@echo off
call compile selfconfig
call config user

:: ����� ��६���� ���㦥���
set PATH=%PATHMINGW%;%PATH7Z%;%PATHTHG%;%PATH%

:: ��।��塞 ⥪���� ॢ����
call compile gethgrev

:: create grf.7z arhive
7z a %NMLNAME%.%REPO_REVISION%.grf.7z %NMLNAME%.grf

:: create src.7z arhive
7z a -r %NMLNAME%.%REPO_REVISION%.src.7z docs\* lang\* src\*
7z a %NMLNAME%.%REPO_REVISION%.src.7z ^
  *.bat %NMLNAME%.nfo %NMLNAME%.nml %CUSTOM_TAGS%

:: create hg.7z arhive
7z a -r %NMLNAME%.%REPO_REVISION%.hg.7z .hg\*
