#!/bin/bash

# Fix undotree ns_id: -1 error after plugin reinstall

UNDOTREE_FILE="$HOME/.local/share/nvim/lazy/undotree/lua/undotree/collector.lua"

if [ ! -f "$UNDOTREE_FILE" ]; then
    echo "❌ Undotree plugin not found at $UNDOTREE_FILE"
    echo "Make sure the plugin is installed first."
    exit 1
fi

echo "🔧 Fixing undotree ns_id error..."

# Create backup
cp "$UNDOTREE_FILE" "$UNDOTREE_FILE.backup.$(date +%Y%m%d_%H%M%S)"

# Apply fix - replace the problematic line
sed -i '' 's/vim\.hl\.range(self\.diff_bufnr, -1, hl, {i - 1, 0}, {i - 1, -1}, { timeout = -1 })/pcall(vim.hl.range, self.diff_bufnr, vim.api.nvim_create_namespace('\''undotree_diff'\''), hl, {i - 1, 0}, {i - 1, -1})/g' "$UNDOTREE_FILE"

echo "✅ Undotree fix applied!"
echo "🔄 Restart Neovim to apply changes."
