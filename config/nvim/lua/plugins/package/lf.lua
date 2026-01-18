return {
  "lmburns/lf.nvim",
  lazy = false,
  dependencies = { "akinsho/toggleterm.nvim", version = "*" },
  config = function()
    local fn = vim.fn
    local o = vim.o

    require("lf").setup {
      default_action = "drop",
      winblend = 0,
      direction = "float", --float horizontal vertical
      border = "rounded",
      height = fn.float2nr(fn.round(0.5 * o.lines)),
      width = fn.float2nr(fn.round(0.9 * o.columns)),
      escape_quit = true,
      focus_on_open = true,
      terminal_autocmds = true,
      mappings = true,
      tmux = false,
      default_file_manager = true,
      disable_netrw_warning = true,
      highlights = {
        Normal = { link = "black2" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "CmpDocBorder" },
      },
    }
  end,
}
