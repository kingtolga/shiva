#!/bin/bash

# idea's for dave

config_files=(
    "$HOME/shiva/Programs/*"
    "$HOME/shiva/Documents/*"

)

git_dir="$HOME/shiva/shiva.git"  # Use the correct path to the Git repository
work_tree="$HOME/shiva"    # Use the correct path to the working tree

# Navigate to the working tree directory
cd "$work_tree" || exit

for path in "${config_files[@]}"; do
    for file in $path; do
        git add "$file"
    done
done

git commit -m "update $(date)"
git push origin main  # Replace 'master' with the appropriate branch name
