return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  config = function()
    vim.opt.updatetime = 400
    vim.diagnostic.config { virtual_text = false }
    require("tiny-inline-diagnostic").setup {
      preset = "classic",
      bland = {
        factor = 1.0,
      },
      options = {
        break_line = {
          enabled = false,
          -- after = 48,
        },
      },
    }
  end,
}
