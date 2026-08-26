# ------------------------------------------------------------
# info-systeme.ps1
# Objet    : affiche les informations de base du poste
# Auteur   : prenom.nom@exemple.fr
# Usage    : .\info-systeme.ps1
# Prérequis: PowerShell 5.1 ou supérieur
# ------------------------------------------------------------

Get-ComputerInfo -Property CsName, OsName, OsVersion, CsTotalPhysicalMemory
