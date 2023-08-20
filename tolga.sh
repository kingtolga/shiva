#!/bin/bash

# Tolga Erok
# ¯\_(ツ)_/¯

# 20/8/23

# ¯\_(ツ)_/¯ Random test
config_files=(
    "$HOME/shiva/"
)

# Check if the remote URL is set to SSH
remote_url=$(git remote get-url origin)

# Add some tweaks
git config --global core.compression 9
git config --global core.deltaBaseCacheLimit 2g
git config --global diff.algorithm histogram
git config --global http.postBuffer 524288000

if [[ $remote_url == *"git@github.com"* ]]; then
    echo "Remote URL is set to SSH. Proceeding with the script..."
else
    echo "Remote URL is not set to SSH. Please set up SSH key-based authentication for the remote repository."
    echo "If you haven't already, generate an SSH key pair:"
    echo "ssh-keygen -t ed25519 -C 'your email'"
    echo "Add your SSH key to the agent:"
    echo "eval $(ssh-agent -s)"
    echo "ssh-add ~/.ssh/id_ed25519"
    echo "Then, add your SSH public key to your GitHub account:"
    echo "cat ~/.ssh/id_ed25519.pub"
    echo "Finally, update your Git configuration to use SSH:"
    echo "git config --global credential.helper store"
    echo "Remote URL needs to be updated to SSH. Exiting..."
    exit 1
fi

# git_dir="$HOME/shiva/shiva.git"
work_tree="$HOME/shiva"

# Navigate to the working tree directory
cd "$work_tree" || exit

# Pull remote changes using merge
git pull origin main --no-rebase
echo "Pulled remote changes using merge"

# Add and commit local changes
for path in "${config_files[@]}"; do
    git add "$path"
done

commit_time=$(date +"%I:%M %p") # 12-hour format
git commit -m "update $(date) at $commit_time"
echo "Committed local changes"

# Handle file deletions
git add --all
commit_time=$(date +"%I:%M %p") # Update commit time
git commit -m "Edited commit @ $commit_time"
echo "Committed edits"

# Push changes to remote
push_time=$(date +"%I:%M %p") # Update push time
git push origin main
echo "Pushed changes to remote repository at $push_time"
