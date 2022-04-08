###
# Install
###

<#
[int[]][char[]]'à' = $([char]224)
[int[]][char[]]'é' = $([char]233)
[int[]][char[]]'è' = $([char]232)
#>

$Folder = "C:\Exploitation"
if ( -Not $(Test-Path -Path $Folder) ) {
    New-Item -Path "C:\Exploitation" -ItemType "directory" > $null
}

Stop-Process -Force -Name "MonDrive" -ErrorAction SilentlyContinue
Stop-Process -Force -Name "speedtest" -ErrorAction SilentlyContinue
Stop-Process -Force -Name "tiny" -ErrorAction SilentlyContinue

Remove-Item $Folder\MonDrive* -Recurse -Force

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$VersionGit = (Invoke-WebRequest -URI https://raw.githubusercontent.com/Fl0wyn/MonDrive/master/VERSION | Format-Wide Content | Out-String).trim()

Write-Host "`n MonDrive - v$VersionGit (https://github.com/Fl0wyn/MonDrive)`n" -ForegroundColor Yellow

$Total = 7
function FuncOut($nb, $name) {
    Write-Output " [$nb/$Total] $name"
}

#
#
#
FuncOut 1 " D$([char]233)terminer la derni$([char]232)re version"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$repo = "Fl0wyn/MonDrive"
$file = "MonDrive.zip"
$releases = "https://api.github.com/repos/$repo/releases"

$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name
    
$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$zip = "$name-$tag.zip"
$dir = "$name-$tag"

#
#
#
FuncOut 2 " T$([char]233)l$([char]233)chargement de la derni$([char]232)re version"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -OutFile $zip

#
#
#
FuncOut 3 " Extraction des fichiers"
if (Get-Command Expand-Archive -errorAction SilentlyContinue) {
    # >= Win 2016
    Expand-Archive $zip -Force
}
else {
    # = Win 2012
    [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
    [System.IO.Compression.ZipFile]::ExtractToDirectory("$(Get-Location)\$zip", "$(Get-Location)\$dir")
}

#
#
#
FuncOut 4 " Nettoyage du r$([char]233)pertoire cible"
Remove-Item $name -Recurse -Force -ErrorAction SilentlyContinue 

#
#
#
FuncOut 5 " D$([char]233)placement du r$([char]233)pertoire temporaire vers `"$Folder\MonDrive`""
Move-Item $dir\$name -Destination $Folder\$name -Force

#
#
#
FuncOut 6 " Suppression des fichiers temporaires"
Remove-Item $zip -Force
Remove-Item $dir -Recurse -Force

Unblock-File $Folder\$name\*

#
#
#
FuncOut 7 " Cr$([char]233)ation d'un raccourci sur le bureau"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -useb https://github.com/Fl0wyn/MonDrive/raw/master/MonDrive.exe -OutFile $env:USERPROFILE\Desktop\MonDrive.exe

#
#
#
FuncOut 8 " Cr$([char]233)ation du fichier 'ListServeurs.txt' dans $Folder"
$FileListServer = "C:\Exploitation\MonDrive\ListMonDrive.txt"
if (Test-Path -Path $Folder\ListMonDrive.txt -PathType leaf) {
    Write-Output "Le fichier 'ListMonDrive.txt' ne sera pas remplac$([char]233)"
}
else {
    Move-Item -Path $FileListServer -Destination $Folder\ListMonDrive.txt
}

#
#
#
Write-Host "`n Installation Termin$([char]233)e !" -ForegroundColor Green
Start-sleep 2