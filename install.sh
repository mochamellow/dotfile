#!/bin/bash

# Comprehensive Dotfiles Installation Script

echo "🚀 Setting up dotfiles..."

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.nvim/undodir

# Function to backup existing configs
backup_if_exists() {
    if [ -e "$1" ]; then
        echo "📦 Backing up existing $1..."
        mv "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

# Install ~/.config files
echo "📁 Installing config files..."
for config in config/*; do
    if [ -d "$config" ] || [ -f "$config" ]; then
        config_name=$(basename "$config")
        backup_if_exists ~/.config/"$config_name"
        cp -r "$config" ~/.config/
        echo "  ✅ Installed $config_name"
    fi
done

# Install home directory files  
echo "🏠 Installing home directory files..."
for file in home/.*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        backup_if_exists ~/"$filename"
        cp "$file" ~/
        echo "  ✅ Installed $filename"
    fi
done

echo ""
echo "🎉 Dotfiles installation complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open nvim to install plugins automatically"
echo "  3. If using tmux, restart tmux sessions: tmux kill-server"
echo "  4. If using yabai/skhd, restart the services"
echo ""
echo "⚡ Your development environment is ready!"
