return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  ---
  opts = {
    formatters_by_ft = {
      bash = { "shfmt" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      angularhtml = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "biome" },
      markdown = { "markdownlint" },
      python = { "ruff_format" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      lua = { "stylua" },
      yaml = { "yamlfmt" },
    },

    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 5000, lsp_fallback = true }
    end,
    formatters = {
      yamlfmt = {
        args = { "-formatter", "retain_line_breaks_single=true" },
      },
    },
  },
}
