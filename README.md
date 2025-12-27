# Dotfiles

Personal configuration files for development setup.

## What's included

### Terminal & Shell

- **Ghostty**: Modern terminal emulator configuration
- **Fish**: Shell configuration with custom functions
- **Zsh**: Alternative shell setup
- **Starship**: Cross-shell prompt configuration
- **Tmux**: Terminal multiplexer with custom keybindings

### Development Tools  

- **Neovim**: Complete NvChad configuration with custom settings

### System Management

- **Yabai**: Tiling window manager configuration
- **SKHD**: Keyboard shortcuts daemon

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/mochamellow/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:

   ```bash
   ./install.sh
   ```

3. Install Neovim (if not already installed):

   ```bash
   # macOS
   brew install neovim
   
4. Open Neovim to automatically install plugins:

   ```bash
   nvim
   ```

## Directory Structure

- `nvim/` - Complete Neovim configuration
- `install.sh` - Automated setup script

## Manual Setup

If you prefer manual installation:

1. Copy `nvim/` to `~/.config/nvim/`
2. Create undo directory: `mkdir -p ~/.nvim/undodir`
3. Open nvim to install plugins

## Updating

To update your dotfiles:

1. Run the update script: `./update.sh`
2. Review and commit changes: `git add . && git commit -m 'update message'`
3. Push to GitHub: `git push`
