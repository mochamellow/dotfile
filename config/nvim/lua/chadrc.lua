---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    Conditional = { italic = true },
    Repeat = { italic = true },
    Function = { bold = true },
    ["@function"] = { bold = true },
    Keyword = { bold = true },
    ["@keyword"] = { bold = true },
    Type = { bold = true },
    ["@type"] = { bold = true },
    NvDashAscii = { link = "Special" },

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
