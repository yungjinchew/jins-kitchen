#!/usr/bin/env bash
# jins-kitchen deploy — run from Cowork's device shell (device_bash). Push = publish.
# Syncs Cooking/jins-kitchen (source of truth) into a scratch clone outside OneDrive, commits, pushes to
# github.com/yungjinchew/jins-kitchen; Netlify auto-builds `site/` in ~10 s.
# Usage: bash deploy.sh "commit message"
set -e
MSG="${1:-update}"
SRC="$HOME/mnt/Claude Cowork Playground/Cooking/jins-kitchen"
W="$HOME/jins-kitchen-repo"
REMOTE=$(git -C "$HOME/mnt/Claude Cowork Playground/cooking-governance" remote get-url origin | sed -E 's#(github\.com/yungjinchew/)jins-cooking-governance\.git#\1jins-kitchen.git#')
if [ ! -d "$W/.git" ]; then
  rm -rf "$W"; git clone -q "$REMOTE" "$W"
fi
cd "$W"
git remote set-url origin "$REMOTE"
git config user.name "Jin (Cowork)"; git config user.email "yjchew@gmail.com"
git fetch -q origin main && git reset -q --hard origin/main
rsync -a --delete --exclude '.git' --exclude 'deploy/' --exclude 'backups/' --exclude '*.zip' --exclude 'site/netlify.toml' "$SRC/" "$W/"
printf '[build]\n  publish = "site"\n  command = ""\n' > netlify.toml
printf 'deploy/\nbackups/\n*.zip\nThumbs.db\n.DS_Store\n' > .gitignore
git add -A
if git diff --cached --quiet; then echo "nothing to deploy"; exit 0; fi
git commit -q -m "$MSG"
git push -q origin main
echo "pushed $(git rev-parse --short HEAD) — Netlify will publish in ~10 s; verify with the Netlify deploy reader (commit_ref must match)"
