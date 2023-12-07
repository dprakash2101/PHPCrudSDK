#!/bin/sh

git_user_id="dprakash2101"
git_repo_id="PHPCrudSDK"
release_note="Your custom release note"
git_host="github.com"

# Check if Git token is set, otherwise use environment's Git credentials
if [ "$GIT_TOKEN" = "" ]; then
    echo "[INFO] \$GIT_TOKEN (environment variable) is not set. Using the git credential in your environment."
    git remote add origin https://${git_host}/${git_user_id}/${git_repo_id}.git
else
    git remote add origin https://${git_user_id}:"${GIT_TOKEN}"@${git_host}/${git_user_id}/${git_repo_id}.git
fi

# Initialize the local directory as a Git repository
git init

# Adds the files in the local repository and stages them for commit.
git add .

# Commits the tracked changes and prepares them to be pushed to a remote repository.
git commit -m "$release_note"

# Sets the new remote
git_remote=$(git remote)
if [ "$git_remote" = "" ]; then # git remote not defined
    git remote add origin https://${git_host}/${git_user_id}/${git_repo_id}.git
fi

git pull origin master

# Pushes (Forces) the changes in the local repository up to the remote repository
echo "Git pushing to https://${git_host}/${git_user_id}/${git_repo_id}.git"
git push origin master 2>&1 | grep -v 'To https'
