$Folder = "C:\Exploitation\MonDrive"
$ListServeurs = Get-Content C:\Exploitation\ListMonDrive.txt | Where-Object { $_.trim() -ne "" }

Write-Output '{"info": {' | Out-File "$Folder\data.json"

foreach ($i in $ListServeurs) {

    #
    # Supprimer le symbole @ et les lignes en dessous
    #
    $MonDriveHost = ($i | Select-String -NotMatch "#") -replace '(?s)^.*\@' -replace '(.+?)\ .+', '$1'
    
    if ($MonDriveHost) {
        Write-Output `"$MonDriveHost`": [ | Out-File -Append "$Folder\data.json"
    }

    #
    # Tester la connexion (ping) vers l'hôte
    #
    ping -n 1 $MonDriveHost | Out-Null

    #
    # Si l'hôte répond, alors on liste les disques
    #
    if ($?) {

        Write-Output '{"name": "Status", "val": "on"},' | Out-File -Append "$Folder\data.json"

        #
        # Si Windows
        #
        $Windows = $i | Select-String -NotMatch "@", "#"
        if ($Windows) {
            #
            # Afficher la liste des disque logiques
            #
            $CmdDisk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $Windows 2> $null | `
                Select-Object -Property VolumeName, DeviceID, @{Name = "FreeSpace"; Expression = { $_.freespace -replace ".{3}$" } }, @{Name = "Size"; Expression = { $_.size -replace ".{3}$" } } | ConvertTo-Json

            #
            # Ajout du tag Windows
            #
            Write-Output '{"name": "OS", "val": "Windows"},' | Out-File -Append "$Folder\data.json"

            # 
            # Vérifier que la commande "Get-CimInstance" existe
            #
            if ($?) { 
                Write-Output '{"name": "compatibility", "val": "ok"},' | Out-File -Append "$Folder\data.json"
                #
                # Vérifier s'il existe plus d'un disque
                #
                if ( (Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $Windows | Measure-Object).Count -eq "1") {
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
                Write-Output '{"name": "compatibility", "val": "ko"}' | Out-File -Append "$Folder\data.json"
            }
        }

        #
        # Si Linux
        #
        else {
            $Linux = ($i | Select-String "@") -split (' ')

            #
            # Si non vide
            #
            if ($Linux[0]) {
                $LinuxUserAndIp = $Linux[0]
                $LinuxPort = $Linux[1]
                $LinuxPassword = $Linux[2]
            
                Write-Output '{"name": "OS", "val": "Linux"},' | Out-File -Append "$Folder\data.json"

                $sshcmd = Write-Output y | plink -ssh -batch $LinuxUserAndIp -P $LinuxPort -pw $LinuxPassword -m $Folder\sshcmd.txt
                # 
                # Vérifier le retour de la commande "plink"
                #
                if ($?) { 
                    Write-Output '{"name": "compatibility", "val": "ok"},' | Out-File -Append "$Folder\data.json"
                    $sshcmd | Out-File -Append "$Folder\data.json"
                }
                else {
                    Write-Output '{"name": "compatibility", "val": "ko"}' | Out-File -Append "$Folder\data.json"
                }
            }
        }
        
    }
    elseif ($MonDriveHost) {
        
        # 
        # Si l'hôte ne répond pas et qu"il n'est pas vide
        #
        Write-Output '{"name": "Status", "val": "off"}' | Out-File -Append "$Folder\data.json"
    }
  
    #
    # Supprimer la virgule à la dernière ligne
    #
    if ($i -eq $ListServeurs[-1]) {
        Write-Output ']' | Out-File -Append "$Folder\data.json"
    }
    elseif ($MonDriveHost) {
        Write-Output '],' | Out-File -Append "$Folder\data.json"
    }
}

Write-Output '}}' | Out-File -Append "$Folder\data.json"
