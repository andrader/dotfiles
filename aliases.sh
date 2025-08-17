#!/bin/bash

# Dotfiles sync aliases
# Source this file in your .zshrc or .bashrc to enable convenient dotfiles management

# Get the dotfiles directory (assumes this script is in the dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Basic dotfiles management aliases
alias dotfiles="cd $DOTFILES_DIR"
alias dots="cd $DOTFILES_DIR"

# Quick sync aliases
alias dotsync="cd $DOTFILES_DIR && git add . && git commit -m 'Update dotfiles' && git push"
alias dotpush="cd $DOTFILES_DIR && git add . && git commit -m 'Update dotfiles' && git push"
alias dotpull="cd $DOTFILES_DIR && git pull origin main"

# More descriptive sync aliases
alias dotcommit="cd $DOTFILES_DIR && git add . && git commit"
alias dotstatus="cd $DOTFILES_DIR && git status"
alias dotlog="cd $DOTFILES_DIR && git log --oneline -10"
alias dotdiff="cd $DOTFILES_DIR && git diff"

# Installation aliases
alias dotinstall="cd $DOTFILES_DIR && ./install.sh"
alias dotuninstall="cd $DOTFILES_DIR && ./install.sh uninstall"
alias dotbackup="cd $DOTFILES_DIR && ./install.sh backup"

# Functions for more complex operations
dotquick() {
    local message="${1:-Update dotfiles}"
    cd "$DOTFILES_DIR"
    git add .
    git commit -m "$message"
    git push
    echo "Dotfiles synced with message: $message"
}

dotupdate() {
    echo "Pulling latest dotfiles..."
    cd "$DOTFILES_DIR"
    git pull origin main
    echo "Dotfiles updated!"
}

dothelp() {
    echo "Dotfiles Management Aliases:"
    echo ""
    echo "Navigation:"
    echo "  dotfiles, dots    - Navigate to dotfiles directory"
    echo ""
    echo "Quick Sync:"
    echo "  dotsync, dotpush  - Add, commit with default message, and push"
    echo "  dotpull           - Pull latest changes from remote"
    echo "  dotquick [msg]    - Quick commit and push with custom message"
    echo "  dotupdate         - Pull and show status"
    echo ""
    echo "Git Operations:"
    echo "  dotcommit         - Add and commit (interactive)"
    echo "  dotstatus         - Show git status"
    echo "  dotlog            - Show recent commit history"
    echo "  dotdiff           - Show current changes"
    echo ""
    echo "Installation:"
    echo "  dotinstall        - Run install script"
    echo "  dotuninstall      - Remove symlinks"
    echo "  dotbackup         - Restore from backup"
    echo ""
    echo "Help:"
    echo "  dothelp           - Show this help message"
}

# Auto-completion for dotquick function (bash)
if [[ -n "$BASH_VERSION" ]]; then
    _dotquick_completion() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local suggestions=("Update dotfiles" "Fix configuration" "Add new settings" "Sync changes")
        COMPREPLY=($(compgen -W "${suggestions[*]}" -- "$cur"))
    }
    complete -F _dotquick_completion dotquick
fi

# Auto-completion for dotquick function (zsh)
if [[ -n "$ZSH_VERSION" ]]; then
    _dotquick() {
        local suggestions=("Update dotfiles" "Fix configuration" "Add new settings" "Sync changes")
        _describe 'commit messages' suggestions
    }
    compdef _dotquick dotquick
fi

echo "Dotfiles aliases loaded! Type 'dothelp' for available commands."
