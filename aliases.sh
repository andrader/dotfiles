#!/bin/bash

# Dotfiles sync aliases
# Source this file in your .zshrc or .bashrc to enable convenient dotfiles management

# Get the dotfiles directory (assumes this script is in the dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Basic dotfiles management aliases
alias dotfiles="cd $DOTFILES_DIR"
alias dots="cd $DOTFILES_DIR"

# Quick sync aliases
alias dotsync="(cd $DOTFILES_DIR && git add . && git commit -m 'Update dotfiles' && git push)"
alias dotpush="(cd $DOTFILES_DIR && git add . && git commit -m 'Update dotfiles' && git push)"
alias dotpull="(cd $DOTFILES_DIR && git pull origin main)"

# More descriptive sync aliases
alias dotcommit="(cd $DOTFILES_DIR && git add . && git commit)"
alias dotstatus="(cd $DOTFILES_DIR && git status)"
alias dotlog="(cd $DOTFILES_DIR && git log --oneline -10)"
alias dotdiff="(cd $DOTFILES_DIR && git diff)"

# Installation aliases
alias dotinstall="(cd $DOTFILES_DIR && ./install.sh)"
alias dotuninstall="(cd $DOTFILES_DIR && ./install.sh uninstall)"
alias dotbackup="(cd $DOTFILES_DIR && ./install.sh backup)"

# Functions for more complex operations
dotquick() {
    local message="${1:-Update dotfiles}"
    (
        cd "$DOTFILES_DIR"
        git add .
        git commit -m "$message"
        git pull
        git push
        echo "Dotfiles synced with message: $message"
    )
}



echo "Dotfiles aliases loaded! Type 'dothelp' for available commands."

##############
# Aliases
alias act='source .venv/bin/activate'
alias deact='deactivate'
alias c='clear'
alias precommit="pre-commit"
alias prec="pre-commit"

pym() { 
  local module="${1//\//.}"
  module="${module%.py}"
  echo "running: python -m $module ${@:2}"
  python -m "$module" "${@:2}"
}

adlias() {
  if [[ $# -ne 1 || ! "$1" =~ ^[^=]+=[^=]+$ ]]; then
    echo "Usage: adlias name=alias_cmd"
    return 1
  fi
  
  local alias_name="${1%%=*}"
  local alias_cmd="${1#*=}"
  
  echo "alias $alias_name=\"$alias_cmd\"" >> ~/.zshrc
  source ~/.zshrc
  echo "Added alias: $alias_name=\"$alias_cmd\""
}
gomain() { 
  stash_created=0; 
  git stash -u | grep -q 'Saved' && stash_created=1 && echo "Stash created"; 
  git checkout main && git pull && git dm; 
  if [ $stash_created -eq 1 ]; then 
    git stash pop; 
    echo "Stash popped"; 
  fi 
  }
