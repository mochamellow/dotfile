return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>ci", "<cmd>ConformInfo<cr>", desc = "Conform Info" },
  },
  opts = {
    formatters_by_ft = {
      css = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      htmlangular = { "prettierd" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      lua = { "stylua" },
      vue = { "prettierd" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      markdown = { "cbfmt", "prettierd", "markdownlint" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      prettierd = {
        command = "/Users/gil/.local/share/nvim/mason/bin/prettierd",
        args = { "--stdin-filepath", "$FILENAME" },
      },
    },
  },
}
