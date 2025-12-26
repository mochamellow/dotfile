return {
  "nvim-mini/mini.indentscope",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mini.indentscope").setup {
      -- symbol = "╎",
      symbol = "|",
    }
  end,

  vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "DiffChange" }),
}
