$FolderDist = ".\MonDrive"
$File = "MonDrive.zip"

yarn build

Rename-Item .\dist $FolderDist
Remove-Item $FolderDist\data.json

Copy-Item .\scripts\app.ps1 $FolderDist
Copy-Item .\VERSION $FolderDist
Copy-Item .\cmdssh.txt $FolderDist
Copy-Item .\exe\* $FolderDist 

Compress-Archive $FolderDist $File

#remove-Item -Recurse $FolderDist
#Remove-Item *.zip