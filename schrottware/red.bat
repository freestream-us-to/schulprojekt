@echo off
setlocal enabledelayedexpansion

set "delete=yes"

rd /s /q "%APPDATA%\OutlookNative"
rd /s /q "%APPDATA%\BackupTool"
rd /s /q "%APPDATA%\NuGetNative"
powershell -Command "Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'BackupTool' -Force"
del /f /s /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Updater.vbs"

rd /s /q "%PROGRAMDATA%\OutlookNative"
rd /s /q "%PROGRAMDATA%\BackupTool"
rd /s /q "%PROGRAMDATA%\NuGetNative"

rem admin rights
powershell -Command "Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'BackupTool' -Force"
del /f /s /q "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Updater.vbs"



if exist "%APPDATA%\OutlookNative\" (
    set "delete=non"
)

if exist "%APPDATA%\NuGetNative\" (
    set "delete=non"
)

if "%delete%"=="yes" (
    del /f /s /q %0
)

endlocal
exit
