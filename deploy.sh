#!/usr/bin/env bash
# jins-kitchen deploy — run from Cowork's device shell (device_bash). A push to main = a production publish (15 Netlify credits).
# Since 14 Nov 2026 it goes THROUGH THE CLOUD: the linked computer's workspace refuses git push to GitHub, so
# Travel/Resources/app-deploy.js stores Cooking/jins-kitchen (source of truth) in Supabase and a GitHub Actions
# job (jins-trips app-deploy.yml) writes it into github.com/yungjinchew/jins-kitchen exactly as this script's
# rsync --delete used to (deploy/, backups/, *.zip and site/netlify.toml stay out); Netlify builds `site/`.
# Usage: bash deploy.sh "commit message"                    -> production (branch main)
#        bash deploy.sh --preview "commit message"          -> free branch deploy (branch dev):
#                                                              https://dev--jins-kitchen.netlify.app
#        bash deploy.sh --dry-run "commit message"          -> the cloud job reports what would change; no push
# Spend switch: the database reads the Netlify switch itself before a production deploy (paused -> refused;
# SPEND_OVERRIDE=1 only on Jin's explicit yes; economy -> a reminder). SPEND_MODE is no longer needed.
# Previews cost 0 credits and skip the switch. Rule: Cooking/CLAUDE.md § Resources (deploy.sh row).
# Fallback when the cloud route is down: the same rsync and push from Git Bash on Jin's PC.
set -e
PREVIEW=""; DRY=""
while [ "${1:-}" = "--preview" ] || [ "${1:-}" = "--dry-run" ]; do
  [ "$1" = "--preview" ] && PREVIEW="--preview"
  [ "$1" = "--dry-run" ] && DRY="--dry-run"
  shift
done
MSG="${1:-update}"
OVR=""; [ "${SPEND_OVERRIDE:-0}" = "1" ] && OVR="--override"
PG="$HOME/mnt/Claude Cowork Playground"
[ -d "$PG" ] || PG="$(cd "$(dirname "$0")/../.." && pwd)"
exec node "$PG/Travel/Resources/app-deploy.js" kitchen $PREVIEW $DRY $OVR "$MSG"
