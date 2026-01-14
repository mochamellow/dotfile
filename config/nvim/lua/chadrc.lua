---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",

  hl_override = {
    Comment = { italic = true },
    Conditional = { italic = true },
    Repeat = { italic = true },
    Function = { bold = true },
    Keyword = { bold = true },
    Type = { bold = true },
    CursorLineNr = {
      fg = "orange",
      bold = true,
    },
    NvDashAscii = { link = "Special" },

    -- Keywords
    ["@comment"] = { italic = true },
    ["@keyword"] = { bold = true },
    ["@keyword.conditional"] = { italic = true },
    ["@keyword.repeat"] = { italic = true },
    ["@keyword.return"] = { italic = true },
    ["@keyword.operator"] = { italic = true },
    ["@keyword.import"] = { italic = true },
    ["@keyword.exception"] = { italic = true },
    ["@keyword.modifier"] = { italic = true },
    ["@keyword.directive"] = { italic = true },

    -- Language Specific
    ["@keyword.angular"] = { italic = true },
    ["@keyword.typescript"] = { italic = true },

    -- Types
    ["@type"] = { bold = true },
    ["@type.builtin"] = { italic = true },
    ["@type.definition"] = { bold = true },

    -- Functions / methods
    ["@function"] = { bold = true },
    ["@function.call"] = { bold = true },
    ["@function.builtin"] = { italic = true, force = true },
    ["@function.call.typescript"] = { italic = true },
    ["@lsp.type.function.typescript"] = { italic = true, force = true },

    ["@method"] = { bold = true },
    ["@method.call"] = { bold = true },

    -- Variables / constants
    ["@variable.builtin"] = { italic = true },
    ["@variable.typescript"] = { italic = true },
    ["@constant"] = { bold = true },
    ["@constant.builtin"] = { italic = true },

    -- Preprocessor
    ["@preproc"] = { italic = true },

    integrations = {
      "blankline",
      "cmp",
      "codeactionmenu",
      "dap",
      "devicons",
      "lsp",
      "markview",
      "mason",
      "nvimtree",
      "rainbowdelimiters",
      "todo",
      "whichkey",
    },
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    "                            ",
    "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    "   ▄▀███▄     ▄██ █████▀    ",
    "   ██▄▀███▄   ███           ",
    "   ███  ▀███▄ ███           ",
    "   ███    ▀██ ███           ",
    "   ███      ▀ ███           ",
    "   ▀██ █████▄▀█▀▄██████▄    ",
    "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    "                            ",
    "     Powered By  eovim    ",
    "                            ",
  },

  buttons = {
    {
      txt = "  Search",
      keys = "f",
      cmd = "lua require('telescope').extensions.frecency.frecency({prompt_title='Search',theme='dropdown',default_text='',workspace='CWD',db_safe_mode=false})",
    },
    {
      txt = "󰋚  Restore Last Session",
      keys = "s",
      cmd = "lua require('persistence').load({ last = true })",
    },
  },
}

M.ui = {
  tabufline = { enabled = false },
  statusline = {
    theme = "minimal",
    separator_style = "block",
    order = { "mode", "file", "git", "%=", "harpoon", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      harpoon = function()
        local ok, harpoonline = pcall(require, "harpoonline")
        if not ok or type(harpoonline) ~= "table" or type(harpoonline.format) ~= "function" then
          return ""
        end
        return "%#PmenuMatch# " .. harpoonline.format() .. " "
      end,

      lsp = function()
        if not rawget(vim, "lsp") then
          return ""
        end

        local bufnr = vim.api.nvim_get_current_buf()

        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.attached_buffers and client.attached_buffers[bufnr] then
            if vim.o.columns > 100 then
              return "  " .. client.name .. "  "
            else
              return "  "
            end
          end
        end

        return ""
      end,
    },
  },
}

return M
