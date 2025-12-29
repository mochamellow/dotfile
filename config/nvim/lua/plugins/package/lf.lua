return {
  "lmburns/lf.nvim",
  lazy = false,
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    local fn = vim.fn
    local o = vim.o

    require("lf").setup {
      default_action = "drop",
      winblend = 0,
      dir = "",
      direction = "horizontal",
      border = "double",
      height = fn.float2nr(fn.round(0.75 * o.lines)),
      width = fn.float2nr(fn.round(0.75 * o.columns)),
      escape_quit = true,
      focus_on_open = true,
      terminal_autocmds = true,
      mappings = true,
      tmux = false,
      default_file_manager = false,
      disable_netrw_warning = true,
      highlights = {
        Normal = { link = "Normal" },
        NormalFloat = { link = "black" },
        FloatBorder = { link = "Special" },
      },
      layout_mapping = "<M-u>",
      views = {
        { width = 0.800, height = 0.800 },
        { width = 0.600, height = 0.600 },
        { width = 0.950, height = 0.950 },
        { width = 0.500, height = 0.500, col = 0, row = 0 },
        { width = 0.500, height = 0.500, col = 0, row = 0.5 },
        { width = 0.500, height = 0.500, col = 0.5, row = 0 },
        { width = 0.500, height = 0.500, col = 0.5, row = 0.5 },
      },
    }
  end,
}
