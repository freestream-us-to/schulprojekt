@echo off
setlocal enabledelayedexpansion

if exist "%APPDATA%\OutlookNative\" (
    rd /s /q "%APPDATA%\OutlookNative"
)

if exist "%APPDATA%\BackupTool\" (
    rd /s /q "%APPDATA%\BackupTool"
)

if exist "%APPDATA%\NuGetNative\" (
    rd /s /q "%APPDATA%\NuGetNative"
)

powershell -Command "if ((Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'BackupTool').BackupTool -ne $null) { exit 0 } else { exit 1 }"
if %errorlevel% equ 0 (
    powershell -Command "Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'BackupTool' -Force"
)

if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Updater.vbs" (
    del /f /s /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Updater.vbs"
)


if exist "%PROGRAMDATA%\OutlookNative\" (
    rd /s /q "%PROGRAMDATA%\OutlookNative"
)

if exist "%PROGRAMDATA%\BackupTool\" (
    rd /s /q "%PROGRAMDATA%\BackupTool"
)

if exist "%PROGRAMDATA%\NuGetNative\" (
    rd /s /q "%PROGRAMDATA%\NuGetNative"
)

powershell -Command "if ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'BackupTool').BackupTool -ne $null) { exit 0 } else { exit 1 }"
if %errorlevel% equ 0 (
    powershell -Command "Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'BackupTool' -Force"
)

if exist "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Updater.vbs" (
    del /f /s /q "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Updater.vbs"
)

del /f /s /q %0

endlocal
exit
