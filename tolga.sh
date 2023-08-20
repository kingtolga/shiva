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
    echo "eval \$(ssh-agent -s)"
    exit 1
fi

git_dir="$HOME/shiva/shiva.git"
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

# Check if there are changes to commit
if ! git diff-index --quiet HEAD; then
    commit_time=$(date +"%I:%M %p")  # 12-hour format
    git commit -m "Update files at $commit_time"
    commit_action="Committed changes"
else
    commit_action="No changes to commit"
fi

# Handle file deletions
git add --all
if [[ $(git diff --staged --name-status) == *"D"* ]]; then
    deletion_time=$(date +"%I:%M %p")  # Update deletion time
    git commit -m "Delete files at $deletion_time"
    deletion_action="Committed deletions"
else
    deletion_action="No deletions to commit"
fi

# Push changes to remote
push_time=$(date +"%I:%M %p")  # Update push time
git push origin main
echo "Pushed changes to remote repository at $push_time"

# Display commit and deletion actions
echo "$commit_action"
echo "$deletion_action"
