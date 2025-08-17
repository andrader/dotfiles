#!/bin/bash

# Dotfiles installation script
# This script moves dotfiles from your home directory to the dotfiles repo
# and creates symlinks to maintain functionality

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# List of dotfiles to manage (add more as needed)
DOTFILES=(
    ".zshrc"
    ".gitconfig"
    ".vimrc"
    ".tmux.conf"
    ".bashrc"
    ".bash_profile"
    ".profile"
    ".inputrc"
    ".editorconfig"
    ".gemrc"
    ".npmrc"
)

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}


# Function to backup existing dotfiles
backup_file() {
    local file="$1"
    local backup_dir="$DOTFILES_DIR/backup"
    
    if [[ -f "$HOME_DIR/$file" && ! -L "$HOME_DIR/$file" ]]; then
        mkdir -p "$backup_dir"
        cp "$HOME_DIR/$file" "$backup_dir/$file.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backed up existing $file to $backup_dir"
    fi
}

# Function to move file and create symlink
install_dotfile() {
    local file="$1"
    local home_file="$HOME_DIR/$file"
    local dotfiles_file="$DOTFILES_DIR/$file"
    
    # Skip if file doesn't exist in home directory
    if [[ ! -f "$home_file" ]]; then
        print_warning "Skipping $file - not found in home directory"
        return
    fi
    
    # Skip if it's already a symlink pointing to our dotfiles
    if [[ -L "$home_file" && "$(readlink "$home_file")" == "$dotfiles_file" ]]; then
        print_info "$file is already properly symlinked"
        return
    fi
    
    # Backup existing file if it's not a symlink
    if [[ -f "$home_file" && ! -L "$home_file" ]]; then
        backup_file "$file"
        
        # Move the file to dotfiles directory
        mv "$home_file" "$dotfiles_file"
        print_info "Moved $file to dotfiles directory"
    elif [[ -L "$home_file" ]]; then
        # Remove existing symlink
        rm "$home_file"
        print_info "Removed existing symlink for $file"
    fi
    
    # Create symlink
    ln -s "$dotfiles_file" "$home_file"
    print_success "Created symlink for $file"
}

# Function to restore from backup
restore_backup() {
    local backup_dir="$DOTFILES_DIR/backup"
    
    if [[ ! -d "$backup_dir" ]]; then
        print_error "No backup directory found"
        return 1
    fi
    
    print_info "Available backups:"
    ls -la "$backup_dir"
    
    echo
    read -p "Enter the backup file name to restore (or 'q' to quit): " backup_file
    
    if [[ "$backup_file" == "q" ]]; then
        return 0
    fi
    
    if [[ -f "$backup_dir/$backup_file" ]]; then
        # Extract original filename
        original_file=$(echo "$backup_file" | sed 's/\.[0-9]*_[0-9]*$//')
        cp "$backup_dir/$backup_file" "$HOME_DIR/$original_file"
        print_success "Restored $original_file from backup"
    else
        print_error "Backup file not found"
    fi
}

# Function to uninstall (remove symlinks, restore original files)
uninstall() {
    print_info "Uninstalling dotfiles symlinks..."
    
    for file in "${DOTFILES[@]}"; do
        local home_file="$HOME_DIR/$file"
        local dotfiles_file="$DOTFILES_DIR/$file"
        
        if [[ -L "$home_file" && "$(readlink "$home_file")" == "$dotfiles_file" ]]; then
            rm "$home_file"
            
            # If we have the file in dotfiles, copy it back
            if [[ -f "$dotfiles_file" ]]; then
                cp "$dotfiles_file" "$home_file"
                print_success "Restored $file to home directory"
            fi
        fi
    done
}

# Main installation function
install() {
    print_info "Starting dotfiles installation..."
    print_info "Dotfiles directory: $DOTFILES_DIR"
    print_info "Home directory: $HOME_DIR"
    echo
    
    for file in "${DOTFILES[@]}"; do
        install_dotfile "$file"
    done
    
    echo
    print_success "Dotfiles installation completed!"
    print_info "Don't forget to commit and push your changes:"
    echo "  cd $DOTFILES_DIR"
    echo "  git add ."
    echo "  git commit -m 'Add dotfiles'"
    echo "  git push origin main"
}

# Show help
show_help() {
    echo "Dotfiles Management Script"
    echo
    echo "Usage: $0 [OPTION]"
    echo
    echo "Options:"
    echo "  install     Move dotfiles from home directory and create symlinks (default)"
    echo "  uninstall   Remove symlinks and restore original files"
    echo "  backup      Restore from backup"
    echo "  help        Show this help message"
    echo
    echo "Managed files:"
    for file in "${DOTFILES[@]}"; do
        echo "  $file"
    done
}

# Parse command line arguments
case "${1:-install}" in
    "install")
        install
        ;;
    "uninstall")
        uninstall
        ;;
    "backup")
        restore_backup
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        print_error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
