*#!/bin/bash
# ------------------------------------------------------------
# purge-logs.sh
# Objet    : supprime les fichiers de log de plus de N jours dans un dossier
# Auteur   : luc.soulerin/@oclock.shcool
# Usage    : ./purge-logs.sh <dossier> [jours]
# Prérequis: droit d'écriture sur le dossier cible, testé sur Debian 12/13
# Retour   : 0 = OK / 1 = usage incorrect / 2 = dossier introuvable
#            3 = droits insuffisants
# ------------------------------------------------------------

FICHIER_LOG="/tmp/purge-logs.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$FICHIER_LOG"
}

echo "Script appelé avec $# argument(s)"


if [ "$#" -lt 1 ]; then
    echo "Usage : $0 <dossier> [jours]" >&2
    echo "Exemple : $0 /tmp/faux-logs 30" >&2
    exit 1
fi


DOSSIER="$1"  
JOURS="${2:-30}"

# Le nombre de jours doit être un entier positif.
# Si ce n'est pas le cas, la comparaison numérique échoue : on jette son
# message d'erreur et on affiche le nôtre, qui est lisible.
if ! [ "$JOURS" -ge 0 ] 2>/dev/null; then
    echo "Erreur : '$JOURS' n'est pas un nombre de jours valide" >&2
    echo "Usage : $0 <dossier> [jours]" >&2
    exit 1
fi

echo "Fichiers de plus de $JOURS jours dans $CHEMIN :"

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier $DOSSIER est introuvable" >&2
    exit 2
fi

if [ ! -w "$DOSSIER" ]; then
    echo "Erreur : pas de droit d'écriture sur $DOSSIER" >&2
    log "ERREUR : droits insuffisants sur $DOSSIER"
    exit 3
fi


NB=$(find "$DOSSIER" -type f -name "*.log" -mtime +"$JOURS" | wc -l)
TAILLE=$(find "$DOSSIER" -type f -name "*.log" -mtime +"$JOURS" -exec du -ch {} + 2>/dev/null | tail -n 1 | cut -f1)


log "=== Démarrage : dossier=$DOSSIER, seuil=$JOURS jours ==="

if [ "$NB" -eq 0 ]; then
    echo "Aucun fichier de plus de $JOURS jours dans $DOSSIER, rien à faire"
   log "Aucun fichier à supprimer"
else
    echo "$NB fichier(s) à supprimer :"
    find "$DOSSIER" -type f -name "*.log" -mtime +"$JOURS" -print
    log "$NB fichier(s) de plus de $JOURS jours supprimé(s)"
    l
    find "$DOSSIER" -type f -name "*.log" -mtime +"$JOURS" -delete
fi

log "=== Fin de la purge ==="

exit 0
