#!/bin/bash

# go to your project dir (no spaces in name!)
cd Web_Scracper_text/ || { echo "✖️ Cannot cd into project dir"; exit 1; }

# fetch remote changes
git fetch origin

# compute hashes
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

# compare states
if [ "$LOCAL" = "$REMOTE" ]; then
    echo "✅ Already up to date."

elif [ "$LOCAL" = "$BASE" ]; then
    echo "⬇️ Changes detected. Pulling latest updates..."
    git pull
    echo "🔄 Done. Restarting Gunicorn…"

else
    echo "⚠️ Local and remote have diverged. Manual intervention needed."
fi
gunicorn -b 0.0.0.0:5000 app:app
