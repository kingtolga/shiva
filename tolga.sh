#!/bin/bash

# idea's for dave

config_files=(
    "$HOME/Programs/*"
    "$HOME/Documents/*"
    "$HOME/shiva/*"
)

git_dir="$HOME/shiva.git"  # Use the correct path to the Git repository
work_tree="$HOME/shiva"    # Use the correct path to the working tree

# Navigate to the working tree directory
cd "$work_tree" || exit

# Pull remote changes using merge
git pull origin main --no-rebase

for path in "${config_files[@]}"; do
    for file in $path; do
        git add "$file"
    done
done

git commit -m "update $(date)"
git push origin main
