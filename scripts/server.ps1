###
# Server
###

$Folder = "C:\Exploitation\MonDrive"
Stop-Process -Force -Name "tiny" -ErrorAction SilentlyContinue

$VersionLocal = Get-Content $Folder\VERSION
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$VersionGit = (Invoke-WebRequest -URI https://raw.githubusercontent.com/Fl0wyn/MonDrive/master/VERSION | Format-Wide Content | Out-String).trim()

Write-Host "`n MonDrive - v$VersionLocal (https://github.com/Fl0wyn/MonDrive)" -ForegroundColor Yellow

#
#
#
if ($VersionLocal -ne $VersionGit ) {
    $OutTemp = "C:\Windows\Temp\MonDrive-Update.exe"
    Remove-Item $OutTemp -Force -ErrorAction SilentlyContinue

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -useb https://github.com/Fl0wyn/MonDrive/raw/master/MonDrive-Update.exe -OutFile $OutTemp

    Start-Process -FilePath "C:\Windows\Temp\MonDrive-Update.exe" -Wait
    Exit 0
}

Write-Output "`n Génération de la liste des lecteurs..`n"

. $Folder\app.ps1

Write-Host -ForegroundColor DarkGreen "`n Terminé !"

Start-sleep 2

$PortWeb = 3012
Set-Location $Folder ; Start-Process -FilePath "$Folder\tiny.exe" -ArgumentList "$Folder", "$PortWeb"
Start-Process http://localhost:$PortWeb

Start-sleep 60
Stop-Process -Force -Name "tiny" -ErrorAction SilentlyContinue