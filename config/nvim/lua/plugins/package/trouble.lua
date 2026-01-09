return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<C-t>",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>tt",
      "<cmd>Trouble todo<cr>",
      desc = "Trouble Todo",
    },
  },
}
