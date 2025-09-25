#!/bin/bash

# Dotfiles installation script
# This script creates symlinks for all configuration files

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🔗 Setting up dotfiles symlinks..."

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup and symlink
backup_and_link() {
    local source_file="$1"
    local target_file="$2"
    
    # Backup existing file if it exists and is not already a symlink
    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "📦 Backing up existing $target_file"
        mv "$target_file" "$BACKUP_DIR/"
    elif [ -L "$target_file" ]; then
        echo "🔗 Removing existing symlink $target_file"
        rm "$target_file"
    fi
    
    # Create symlink
    echo "🔗 Linking $source_file -> $target_file"
    ln -s "$source_file" "$target_file"
}

# Zsh configuration
backup_and_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

# Git configuration
backup_and_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# VSCode User configuration
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_USER_DIR" ]; then
    # Backup individual settings files instead of entire directory
    [ -f "$VSCODE_USER_DIR/settings.json" ] && cp "$VSCODE_USER_DIR/settings.json" "$BACKUP_DIR/vscode_settings.json"
    [ -f "$VSCODE_USER_DIR/keybindings.json" ] && cp "$VSCODE_USER_DIR/keybindings.json" "$BACKUP_DIR/vscode_keybindings.json"
    [ -f "$VSCODE_USER_DIR/extensions.json" ] && cp "$VSCODE_USER_DIR/extensions.json" "$BACKUP_DIR/vscode_extensions.json"
else
    mkdir -p "$VSCODE_USER_DIR"
fi

# Create symlinks for VSCode user settings
backup_and_link "$DOTFILES_DIR/vscode/User/settings.json" "$VSCODE_USER_DIR/settings.json"
backup_and_link "$DOTFILES_DIR/vscode/User/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
backup_and_link "$DOTFILES_DIR/vscode/User/extensions.json" "$VSCODE_USER_DIR/extensions.json"

# Config directory
if [ -d "$HOME/.config" ]; then
    echo "📦 Backing up existing .config directory"
    mv "$HOME/.config" "$BACKUP_DIR/"
fi
backup_and_link "$DOTFILES_DIR/config/.config" "$HOME/.config"

echo "✅ Dotfiles installation complete!"
echo "📦 Backups stored in: $BACKUP_DIR"
echo "🔄 You may need to restart your shell or source ~/.zshrc"
echo "💻 VS Code will use the new settings when you restart it"