#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <repository-url> <main-branch> [<worktree-dir>]"
    exit 1
fi

REPO_URL=$1
MAIN_BRANCH=$2
WORKTREE_DIR=${3:-"worktrees/$MAIN_BRANCH"}

# Create a base directory for the repository
BASE_DIR="base_repo"
mkdir -p $BASE_DIR

# Clone the repository into the base directory if not already cloned
if [ ! -d "$BASE_DIR/.git" ]; then
    git clone "$REPO_URL" "$BASE_DIR"
fi

# Navigate to the base directory
cd "$BASE_DIR" || exit

# Create the worktree directory if it doesn't exist
mkdir -p ../worktrees

# Add the main branch as a worktree
git worktree add "../$WORKTREE_DIR" "$MAIN_BRANCH"

echo "Worktree for branch '$MAIN_BRANCH' created at '$WORKTREE_DIR'"

