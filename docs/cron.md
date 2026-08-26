# Planification de purge-logs.sh

## Ligne de crontab

```cron
30 2 * * * /home/admin/scripts-infra/bash/purge-logs.sh /tmp/faux-logs 30 >> /tmp/purge-cron.log 2>&1
```

## Lecture des cinq champs

| Champ | Valeur | Signification |
|---|---|---|
| minute | `30` | à la 30e minute |
| heure | `2` | de la 2e heure |
| jour du mois | `*` | tous les jours du mois |
| mois | `*` | tous les mois |
| jour de la semaine | `*` | tous les jours de la semaine |

Soit : tous les jours à 2h30 du matin.

La sortie standard et les erreurs sont redirigées vers `/tmp/purge-cron.log`,
sinon cron les enverrait dans un e-mail local que personne ne lit.

## Preuve d'exécution

Testé d'abord en `* * * * *`. Extrait de `/tmp/purge-logs.log` :

```text
[2026-08-12 21:14:01] === Démarrage : dossier=/tmp/faux-logs, seuil=30 jours ===
[2026-08-12 21:14:01] 4 fichier(s) de plus de 30 jours supprimé(s)
[2026-08-12 21:14:01] === Fin de la purge ===
[2026-08-12 21:15:01] === Démarrage : dossier=/tmp/faux-logs, seuil=30 jours ===
[2026-08-12 21:15:01] Aucun fichier à supprimer
[2026-08-12 21:15:01] === Fin de la purge ===
```

Ces deux exécutions n'ont demandé aucune intervention, et la seconde
montre que le script est idempotent : rien à faire, aucune erreur.
