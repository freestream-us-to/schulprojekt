On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\DiscordUpdateChecker\UpdateChecker.bat",0,True
WshShell.Run "%PROGRAMDATA%\DiscordUpdateChecker\UpdateChecker.bat",0,True