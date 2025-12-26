return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.stdpath "data" .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize" },
    autosave = true,
  },
}
