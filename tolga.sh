#!/bin/bash

# Tolga Erok
# 20/8/23

config_files=(

    "shiva"
)

# Check if the remote URL is set to SSH
remote_url=$(git remote get-url origin)

if [[ $remote_url == *"git@github.com"* ]]; then
    echo "Remote URL is set to SSH. Proceeding with the script..."
else
    echo "Remote URL is not set to SSH. Please set up SSH key-based authentication for the remote repository."
    echo "ssh-keygen -t ed25519 -C 'eroktolga@gmail.com'"
    echo "eval \$(ssh-agent -s)"
    echo "ssh-add ~/.ssh/id_ed25519"
    echo "cat ~/.ssh/id_ed25519.pub"
    echo "git config --global credential.credentialStore gpg"
    echo "eval $(ssh-agent -s)"
    exit 1
fi

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