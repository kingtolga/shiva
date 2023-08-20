#!/bin/bash

# Tolga Erok

config_files=(
    "shiva/Programs"
    "shiva/Documents"
    "shiva"
)

git_dir="$HOME/shiva/shiva.git"
work_tree="$HOME/shiva"

# Navigate to the working tree directory
cd "$work_tree" || exit

# Pull remote changes using merge
git pull origin main --no-rebase

# Add and commit local changes
for path in "${config_files[@]}"; do
    git add "$path"
done

git commit -m "update $(date)"

# Handle file deletions
git add --all
git commit -m "commit all deletions"

# Push changes to remote
git push origin main
