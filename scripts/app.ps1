$Folder = "C:\Exploitation\MonDrive"
$ListServeurs = Get-Content C:\Exploitation\ListMonDrive.txt | Where-Object { $_.trim() -ne "" }

Write-Output '{"info": {' | Out-File "$Folder\data.json"

foreach ($i in $ListServeurs) {
    Write-Output `"$i`": [ | Out-File -Append "$Folder\data.json"
  
    # Tester la connexion (ping) vers l'hôte
    ping -n 1 $i | Out-Null
  
    # Si l'hôte répond, alors on liste les disques
    if ($?) {
        Write-Output '{"name": "Status", "val": "on"},' | Out-File -Append "$Folder\data.json"
     
        # Affichee la liste des disque logiques
        $CmdDisk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $i 2> $null | Select-Object -Property DeviceID, VolumeName, FreeSpace, Size | ConvertTo-Json

        # Vérifier que la commande "Get-CimInstance" existe
        if ($?) { 
            Write-Output '{"name": "psver", "val": "ok"},' | Out-File -Append "$Folder\data.json"

            # Vérifier s'il existe plus d'un disque
            if ( (Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $i | Measure-Object).Count -eq "1") {
                function buildJson {
                    Write-Output "["
                    $CmdDisk
                    Write-Output "]"
                }
                buildJson | Out-File -Append "$Folder\data.json"
            }
            else {
                $CmdDisk | Out-File -Append  "$Folder\data.json"
            } 
        }
        else {
            Write-Output '{"name": "psver", "val": "ko"}' | Out-File -Append "$Folder\data.json"
        }
    }
    else {
        # Si l'hôte ne répond pas
        Write-Output '{"name": "Status", "val": "off"}' | Out-File -Append "$Folder\data.json"
    }
  
    # Supprimer la virgule à la dernière ligne
    if ($i -eq $ListServeurs[-1]) {
        Write-Output ']' | Out-File -Append "$Folder\data.json"
    }
    else {
        Write-Output '],' | Out-File -Append "$Folder\data.json"
    }
}

Write-Output '}}' | Out-File -Append "$Folder\data.json"
