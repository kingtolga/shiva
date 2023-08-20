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

for file in "${config_files[@]}"; do
    git add "$file"
done

git commit -m "update $(date)"
git push origin main  # Replace 'master' with the appropriate branch name
