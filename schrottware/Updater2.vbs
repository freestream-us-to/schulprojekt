On Error Resume Next

Set WshShell = WScript.CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

FolderPath = WshShell.ExpandEnvironmentStrings("%APPDATA%\NuGetNative\")

If FSO.FolderExists(FolderPath) Then
    Set Folder = FSO.GetFolder(FolderPath)
    
    latestVersion = "0"
    latestFile = ""
    
    For Each File In Folder.Files
        parts = Split(FSO.GetBaseName(File.Name), ".")
        If UBound(parts) >= 0 Then
            currentVersion = parts(UBound(parts))
            
            If CompareVersions(currentVersion, latestVersion) > 0 Then
                latestVersion = currentVersion
                latestFile = File.Path
            End If
        End If
    Next

    If latestFile <> "" Then
        If FSO.GetExtensionName(latestFile) = "jar" Then
            WshShell.Run "java -jar """ & latestFile & """", 0, True
        Else
            WshShell.Run """" & latestFile & """", 0, True
        End If
    End If
End If

Function CompareVersions(version1, version2)
    If CInt(version1) < CInt(version2) Then
        CompareVersions = -1
    ElseIf CInt(version1) > CInt(version2) Then
        CompareVersions = 1
    Else
        CompareVersions = 0
    End If
End Function