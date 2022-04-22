<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonDrive</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-1.2-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" />
	<br/><br/>
</div>

Afficher les lecteurs locaux d'une liste de serveur Windows

<img src="src/assets/demo.png" />

## Installation

### Windows 2012 et supérieur

Lancer la commande PowerShell suivante

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; iwr -useb https://raw.githubusercontent.com/Fl0wyn/MonDrive/master/scripts/install.ps1 | iex
```

> Entrer la commande PowerShell ci dessous si l'éxécution des scripts n'est pas autorisées

```powershell
Set-ExecutionPolicy Unrestricted -Force
```

## Configuration

Editer le fichier **ListMonDrive.txt** dans `C:\Exploitation\`

## Exécution

Lancer l'applcation <img src="src/assets/logo.svg" width="16"/> **MonDrive.exe** présent sur le bureau

## Ressources

- [Tabler](https://tabler.io/)
- [Font Awesome](https://fontawesome.com)
- [TinyWeb](https://www.ritlabs.com/en/products/tinyweb/)
- [PS2EXE](https://github.com/MScholtes/PS2EXE)
