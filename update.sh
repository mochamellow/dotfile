#!/bin/bash

# Update dotfiles from current system configuration

echo "🔄 Updating dotfiles from current system..."

# Update ~/.config files
echo "📁 Updating config files..."
configs_to_sync=(
    "nvim"
    "ghostty"
    "fish"
    "lf"
    "tmux"
    "starship.toml"
    "yabai"
    "skhd"
)

for config in "${configs_to_sync[@]}"; do
    if [ -e ~/.config/"$config" ]; then
        echo "  📋 Copying $config"
        cp -r ~/.config/"$config" config/
    else
        echo "  ⚠️  $config not found, skipping"
    fi
done

# Update home directory files
echo "🏠 Updating home directory files..."
home_files=(
    ".gitconfig"
)

for file in "${home_files[@]}"; do
    if [ -f ~/"$file" ]; then
        echo "  📋 Copying $file"
        cp ~/"$file" home/
    else
        echo "  ⚠️  $file not found, skipping"
    fi
done

# Update LazyGit config
echo "📂 Updating Application Support config..."
app_support_files=(
    "lazygit"
)

for file in "${app_support_files[@]}"; do
    SRC="$HOME/Library/Application Support/$file"
    DEST="Application Support/$file" # keeps original structure in your repo

    if [ -d "$SRC" ]; then
        mkdir -p "$DEST"
        echo "  📋 Copying $file"
        cp -r "$SRC"/* "$DEST"/
    else
        echo "  ⚠️  $file not found at $SRC, skipping"
    fi
done

echo ""
echo "✅ Dotfiles updated!"
echo ""
echo "💡 Don't forget to:"
echo "  1. Review changes: git status"
echo "  2. Commit changes: git add . && git commit -m 'Update configs'"
echo "  3. Push to GitHub: git push"
