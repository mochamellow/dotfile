# My Dotfiles

Personal configuration files for development setup.

## What's included

- **Neovim**: Complete NvChad configuration with custom settings
  - Persistent undo with undotree support
  - Custom folding configuration  
  - TreeSitter integration
  - All plugins managed by Lazy.nvim

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git
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
   
   # Ubuntu/Debian
   sudo apt install neovim
   ```

4. Open Neovim to automatically install plugins:
   ```bash
   nvim
   ```

## Key Features

- **Persistent Undo**: Undo history preserved across sessions
- **No Swap Files**: Clean workspace with centralized undo storage
- **Custom Folding**: VS Code-like fold text display
- **TreeSitter**: Advanced syntax highlighting and folding

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

1. Make changes to your actual config files
2. Copy them back: `cp -r ~/.config/nvim/* ./nvim/`
3. Commit and push changes
