-- TreeSitter configuration with folding enabled
-- Start with NvChad's base config
local nvchad_config = require "nvchad.configs.treesitter"

-- Create a new config table to avoid modifying the original
local config = vim.deepcopy(nvchad_config)

-- Explicitly enable folding
config.fold = {
  enable = true,
  disable = {}, -- Can disable for specific languages if needed: {"html"}
}

-- Disable TreeSitter indentation - using guess-indent instead
config.indent = {
  enable = false, -- Let guess-indent handle all indentation
}

-- Ensure we have the required parsers for folding and indentation
config.ensure_installed = vim.list_extend(config.ensure_installed or {}, {
  "html", "css", "javascript", "typescript", "python", "go", "rust", "swift", "scss"
})

return config
