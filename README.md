<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonDrive</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-1.3-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" />
	<br/><br/>
</div>

Afficher l'état des disques des serveurs Windows & Linux

<img src="src/assets/demo.png" />

## Installation

### Prérequis

- Windows 2012 où supérieur
- Navigateur web moderne par défault
- Autoriser l'exécution des scripts PowerShell (`Set-ExecutionPolicy Unrestricted -Force`)

Lancer la commande PowerShell suivante:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; iwr -useb https://raw.githubusercontent.com/Fl0wyn/MonDrive/master/scripts/install.ps1 | iex
```

## Configuration

Editer le fichier **ListMonDrive.txt** dans `C:\Exploitation` en respectant le format suivant:

```yml
# Windows
SRV-1
SRV-2

# Linux
root@SRV-3 22 motDePasse
root@SRV-4 22 motDePasse
```

Valider une première fois les clés SSH pour chaques serveurs Linux
```powershell
cd C:\Exploitation\MonDrive

.\pkink.exe -ssh root@SRV-3 22
.\pkink.exe -ssh root@SRV-7 22
```

## Exécution

Lancer l'applcation <img src="src/assets/logo.svg" width="16"/> **MonDrive.exe** présent sur le bureau

## Désinstallation

Supprimer l'éxécutable **C:\Windows\Temp\MonDrive-Update.exe**

Supprimer le dossier **C:\Exploitation\MonDrive** et l'icône sur le bureau

Arrêter le serveur web si le dossier est en cours d'utilisation

```powershell
Stop-Process -Force -Name "tiny"
```

## Ressources

- [Tabler](https://tabler.io/)
- [Font Awesome](https://fontawesome.com)
- [TinyWeb](https://www.ritlabs.com/en/products/tinyweb/)
- [PS2EXE](https://github.com/MScholtes/PS2EXE)
- [Plink](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
