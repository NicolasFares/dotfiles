# 🏠 Dotfiles

My personal configuration files for macOS development environment.

## 📁 Structure

```
dotfiles/
├── zsh/           # Zsh shell configuration
│   ├── .zshrc     # Main Zsh configuration
│   └── .zprofile  # Zsh profile settings
├── git/           # Git configuration
│   └── .gitconfig # Git global settings
├── vscode/        # Visual Studio Code settings
│   └── .vscode/   # User settings and extensions
├── config/        # Application configurations
│   └── .config/   # Various app configs
├── install.sh     # Installation script
└── README.md      # This file
```

## 🚀 Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/NicolasFares/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```

3. **Restart your terminal or reload your shell:**
   ```bash
   source ~/.zshrc
   ```

## 🔧 Manual Installation

If you prefer to install specific components manually:

### Zsh Configuration
```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/.zprofile ~/.zprofile
```

### Git Configuration
```bash
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
```

### VS Code Settings
```bash
ln -s ~/dotfiles/vscode/.vscode ~/.vscode
```

### App Configurations
```bash
ln -s ~/dotfiles/config/.config ~/.config
```

## 📦 What's Included

- **Zsh**: Shell configuration with Oh My Zsh
- **Git**: Global Git settings and aliases
- **VS Code**: User settings and configuration
- **App Configs**: Various application configurations

## 🛡️ Security

- Sensitive files (SSH keys, tokens, etc.) are excluded via `.gitignore`
- The installation script creates backups of existing files
- All symlinks preserve your existing setup while using version-controlled configs

## 🔄 Updating

To update your dotfiles:

1. Pull the latest changes:
   ```bash
   cd ~/dotfiles
   git pull origin main
   ```

2. The symlinks will automatically reflect the changes!

## 📝 Customization

Feel free to fork this repository and customize it for your needs. The structure is designed to be modular and easy to extend.

## 📞 Support

If you run into any issues or have questions, please open an issue in this repository.

---

**Note**: These dotfiles are configured for macOS. Some adjustments may be needed for other operating systems.