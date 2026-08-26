#!/bin/bash
#-------------------------------------
# purpose : FakeLog generator in /tmp/faux-logs
#-------------------------------------

OLD_PATH=$PWD
DOSSIER="${1:/tmp/faux-logs}"

mkdir -p "$DOSSIER"
cd "$DOSSIER" || exit 1

touch -d "60 days ago" tres-vieux.log
touch -d "40 days ago" vieux1.log
touch -d "40 days ago" vieux2.log
touch -d "40 days ago" "rapport de mars.log"
touch -d "10 days ago" moyen.log
touch -d "2 days ago"  recent.log
touch -d "40 days ago" archive-fevrier.gz

echo "FakeLog generated in $DOSSIER: "
ls -l --time-style=long-iso
cd "$OLD_PATH" || return
