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

# VSCode configuration
if [ -d "$HOME/.vscode" ]; then
    echo "📦 Backing up existing VSCode config"
    mv "$HOME/.vscode" "$BACKUP_DIR/"
fi
backup_and_link "$DOTFILES_DIR/vscode/.vscode" "$HOME/.vscode"

# Config directory
if [ -d "$HOME/.config" ]; then
    echo "📦 Backing up existing .config directory"
    mv "$HOME/.config" "$BACKUP_DIR/"
fi
backup_and_link "$DOTFILES_DIR/config/.config" "$HOME/.config"

echo "✅ Dotfiles installation complete!"
echo "📦 Backups stored in: $BACKUP_DIR"
echo "🔄 You may need to restart your shell or source ~/.zshrc"