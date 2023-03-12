On Error Resume Next
Set WshShell = WScript.CreateObject( "WScript.Shell" )
WshShell.Run "%APPDATA%\DiscordUpdateChecker\DiscordUpdateChecker.bat",0,True
WshShell.Run "%PROGRAMDATA%\DiscordUpdateChecker\DiscordUpdateChecker.bat",0,True