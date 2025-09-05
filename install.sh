#!/bin/bash

# Dotfiles installation script

echo "Setting up dotfiles..."

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.nvim/undodir

# Backup existing configs
if [ -d ~/.config/nvim ]; then
    echo "Backing up existing nvim config..."
    mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

# Install Neovim config
echo "Installing Neovim config..."
cp -r nvim ~/.config/

echo "Dotfiles installation complete!"
echo "Open nvim to install plugins automatically via Lazy.nvim"
