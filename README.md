# Dotfiles

A collection of my personal configuration files (dotfiles) managed with Git and automatically synchronized across machines.

## Overview

This repository helps you manage your dotfiles by:

- Moving configuration files from your home directory to this repository
- Creating symbolic links so applications can still find them
- Tracking changes with Git for version control and backup
- Easy synchronization across multiple machines

## Quick Start

### Initial Setup

1. **Clone this repository:**

   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the installation script:**

   ```bash
   ./install.sh
   ```

3. **Commit and push your dotfiles:**
   ```bash
   git add .
   git commit -m "Add initial dotfiles"
   git push origin main
   ```

### Setting Up on a New Machine

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install the dotfiles:**
   ```bash
   ./install.sh
   ```

## Usage

### Installation Script

The `install.sh` script provides several commands:

```bash
# Install dotfiles (default action)
./install.sh
./install.sh install

# Remove symlinks and restore original files
./install.sh uninstall

# Restore from backup
./install.sh backup

# Show help
./install.sh help
```

### What the Script Does

1. **Backup**: Creates backups of existing files before moving them
2. **Move**: Moves dotfiles from `~/` to `~/dotfiles/`
3. **Symlink**: Creates symbolic links from `~/dotfiles/` back to `~/`
4. **Safety**: Checks for existing symlinks and handles conflicts

### Managed Files

The script currently manages these dotfiles:

- `.zshrc` - Zsh shell configuration
- `.gitconfig` - Git configuration
- `.vimrc` - Vim editor configuration
- `.tmux.conf` - Tmux terminal multiplexer configuration
- `.bashrc` - Bash shell configuration
- `.bash_profile` - Bash profile
- `.profile` - Shell profile
- `.inputrc` - Readline configuration
- `.editorconfig` - Editor configuration
- `.gemrc` - Ruby gems configuration
- `.npmrc` - NPM configuration

To add more files, edit the `DOTFILES` array in `install.sh`.

## Workflow

### Making Changes

1. Edit your dotfiles as usual (they're symlinked, so changes are immediate)
2. Commit changes:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update configuration"
   git push
   ```

### Updating on Other Machines

```bash
cd ~/dotfiles
git pull origin main
```

### Adding New Dotfiles

1. Add the filename to the `DOTFILES` array in `install.sh`
2. Run `./install.sh` to process the new file
3. Commit and push the changes

## Safety Features

- **Automatic Backups**: Original files are backed up before being moved
- **Conflict Detection**: Existing symlinks are handled gracefully
- **Uninstall Option**: Easy way to restore original setup
- **Backup Restoration**: Restore specific files from backup

## Directory Structure

```
~/dotfiles/
├── README.md          # This file
├── install.sh         # Installation script
├── backup/           # Backup directory (created automatically)
│   └── .zshrc.20240101_120000
├── .zshrc            # Your dotfiles
├── .gitconfig
└── .vimrc
```

## Troubleshooting

### Script Won't Run

```bash
chmod +x install.sh
```

### Symlink Issues

If you encounter symlink issues, you can uninstall and reinstall:

```bash
./install.sh uninstall
./install.sh install
```

### Restore from Backup

If something goes wrong, restore from backup:

```bash
./install.sh backup
```

## Customization

### Adding New Files

Edit the `DOTFILES` array in `install.sh`:

```bash
DOTFILES=(
    ".zshrc"
    ".gitconfig"
    ".your-new-file"  # Add your file here
)
```

### Custom Installation Logic

The script is modular - you can extend the `install_dotfile()` function for special handling of specific files.

## Contributing

Feel free to fork this repository and adapt it for your own dotfiles. The script is designed to be easily customizable for different setups.

## License

This project is in the public domain. Feel free to use and modify as needed.
