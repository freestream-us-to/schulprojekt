On Error Resume Next

Set WshShell = WScript.CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

FolderPath = WshShell.ExpandEnvironmentStrings("%APPDATA%\NuGetNative\")

If FSO.FolderExists(FolderPath) Then
    Set Folder = FSO.GetFolder(FolderPath)
    
    latestVersion = "0.0"
    latestFile = ""
    
    For Each File In Folder.Files
        parts = Split(FSO.GetBaseName(File.Name), ".")
        If UBound(parts) >= 1 Then
            currentVersion = parts(UBound(parts) - 1) & "." & parts(UBound(parts))
            
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
    Dim aVersion1, aVersion2
    aVersion1 = Split(version1, ".")
    aVersion2 = Split(version2, ".")

    For i = 0 To UBound(aVersion1)
        If CInt(aVersion1(i)) < CInt(aVersion2(i)) Then
            CompareVersions = -1
            Exit Function
        ElseIf CInt(aVersion1(i)) > CInt(aVersion2(i)) Then
            CompareVersions = 1
            Exit Function
        End If
    Next

    CompareVersions = 0
End Function