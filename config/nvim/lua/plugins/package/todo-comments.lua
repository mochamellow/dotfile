return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  config = function()
    -- dofile(vim.g.base46_cache .. "todo")
    require("todo-comments").setup {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "#F77C1E" },
        HACK = { icon = "󰐱 ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰾆 ", color = "info", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "#7CCAF4", alt = { "INFO" } },
        TEST = { icon = "󰙨", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = { multiline = true },
    }
  end,
}
