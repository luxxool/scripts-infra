#!/usr/bin/env bash
#
# archiv-it - Ajoute un fichier à l'archive .tar.gz du jour
#
# Usage:
#   archiv-it <fichier> [dossier_archives]
#
# Description:
#   Ajoute le fichier donné en premier argument à une archive nommée
#   AAAA-MM-JJ.tar.gz (date du jour). Cette archive est stockée dans le
#   dossier donné en second argument, ou par défaut dans un sous-dossier
#   "archives" situé au même emplacement que le fichier à archiver.
#   Ce dossier est créé automatiquement s'il n'existe pas.

set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") <fichier> [dossier_archives]" >&2
    exit 1
}

# --- Vérification des arguments -------------------------------------------

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
fi

fichier="$1"

if [[ ! -e "$fichier" ]]; then
    echo "Erreur : le fichier '$fichier' n'existe pas." >&2
    exit 1
fi

if [[ ! -f "$fichier" ]]; then
    echo "Erreur : '$fichier' n'est pas un fichier régulier." >&2
    exit 1
fi

# --- Détermination du dossier d'archives -----------------------------------

# Chemin absolu du dossier contenant le fichier
fichier_dir="$(cd "$(dirname "$fichier")" && pwd)"
fichier_nom="$(basename "$fichier")"

if [[ $# -eq 2 ]]; then
    archive_dir="$2"
else
    archive_dir="$fichier_dir/archives"
fi

# Création du dossier d'archives s'il n'existe pas
if [[ ! -d "$archive_dir" ]]; then
    mkdir -p "$archive_dir"
    echo "Dossier d'archives créé : $archive_dir"
fi

# Chemin absolu du dossier d'archives
archive_dir="$(cd "$archive_dir" && pwd)"

# --- Détermination de l'archive du jour -------------------------------------

date_jour="$(date +%Y-%m-%d)"
archive="$archive_dir/${date_jour}.tar.gz"

# --- Ajout du fichier à l'archive -------------------------------------------
#
# tar ne permet pas d'ajouter directement à une archive déjà compressée
# (.tar.gz). Si l'archive existe déjà, on la décompresse temporairement,
# on y ajoute le fichier, puis on la recompresse.

tmp_tar="$(mktemp "${TMPDIR:-/tmp}/archiv-it.XXXXXX.tar")"
trap 'rm -f "$tmp_tar"' EXIT

if [[ -f "$archive" ]]; then
    gunzip -c "$archive" > "$tmp_tar"
    tar --append --file="$tmp_tar" -C "$fichier_dir" "$fichier_nom"
else
    tar --create --file="$tmp_tar" -C "$fichier_dir" "$fichier_nom"
fi

gzip -c "$tmp_tar" > "$archive"

echo "'$fichier_nom' ajouté à l'archive : $archive"
