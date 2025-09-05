-- configs/dap.lua
local M = {}

local dap = require "dap"

-- === Adapter setup ===
-- Set up codelldb adapter (used by both generic Swift and xcodebuild.nvim)
local codelldb_path = os.getenv "HOME" .. "/.local/share/nvim/mason/bin/codelldb"
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

-- === Configurations ===

-- Swift - Generic fallback configuration
-- This will be used if xcodebuild.nvim doesn't override it
dap.configurations.swift = {
  {
    name = "Launch Swift",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- === Xcodebuild Integration ===
-- This function will be called when xcodebuild.nvim is loaded
function M.setup_xcodebuild_integration()
  local has_xcodebuild, xcodebuild = pcall(require, "xcodebuild.integrations.dap")
  if has_xcodebuild then
    -- Let xcodebuild.nvim set up its Swift configuration and adapter
    xcodebuild.setup(codelldb_path)
    print("Xcodebuild DAP integration setup completed")
  end
end

-- === Keymaps ===
-- Note: Xcodebuild keymaps are set per-buffer in autocmds.lua for Swift files
-- Generic DAP keymaps for other languages can be added here

-- === Setup function (optional) ===
function M.setup()
  -- Nothing else needed, config already applied
end

return M
