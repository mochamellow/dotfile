-- configs/lspconfig.lua
local M = {}

function M.setup(opts)
  -- Load NvChad defaults (on_attach, capabilities, etc.)
  require("nvchad.configs.lspconfig").defaults()

  local lspconfig = require "lspconfig"

  -- Merge default config with user config
  local function setup_server(name, config)
    lspconfig[name].setup(vim.tbl_deep_extend("force", {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
    }, config or {}))
  end

  -- Handle simple servers from NvChad
  local default_servers = { "html", "cssls", "tailwindcss", "ts_ls" }
  for _, server in ipairs(default_servers) do
    setup_server(server, {})
  end

  -- Handle servers passed in via opts (like volar)
  if opts and opts.servers then
    for name, config in pairs(opts.servers) do
      setup_server(name, config)
    end
  end

  -- Swift LSP (sourcekit-lsp)
  setup_server("sourcekit", {
    cmd = { vim.trim(vim.fn.system "xcrun -f sourcekit-lsp") },
    filetypes = { "swift", "objective-c", "objective-cpp" },
    root_dir = lspconfig.util.root_pattern("Package.swift", ".git", "*.xcodeproj", "*.xcworkspace"),
  })

  -- Example: disable angularls (keep commented for later)
  -- setup_server("angularls", {
  --   on_new_config = function(new_config, new_root_dir)
  --     new_config.cmd = {
  --       "ngserver",
  --       "--stdio",
  --       "--tsProbeLocations",
  --       new_root_dir .. "/node_modules",
  --       "--ngProbeLocations",
  --       new_root_dir .. "/node_modules/@angular/language-service",
  --     }
  --   end,
  --   root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
  --   filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  --   single_file_support = false,
  -- })

  -- Diagnostics config
  vim.diagnostic.config {
    underline = false,
    virtual_text = false,
    update_in_insert = false,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
  }

  -- Floating window tweaks (hover, signature help, etc.)
  vim.lsp.util.open_floating_preview = (function(orig)
    return function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = "double"
      opts.focusable = false
      opts.relative = "cursor"
      opts.close_events = { "BufLeave", "CursorMoved", "InsertCharPre" }
      opts.max_width = 100
      opts.wrap = true
      opts.stylize_markdown = true
      opts.title = nil -- remove "Signature" title

      local win, _ = orig(contents, syntax, opts, ...)

      -- Highlight customization
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#2E3031" })
      vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
        fg = "#C6B99D",
        bg = "#2E3031",
        bold = true,
      })

      return win
    end
  end)(vim.lsp.util.open_floating_preview)
end

return M
