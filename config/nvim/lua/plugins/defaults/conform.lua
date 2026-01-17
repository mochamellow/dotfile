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
      html = { "lsp" },
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
      swift = { "swiftformat" },
      markdown = { "cbfmt", "prettierd", "markdownlint" },
    },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype

      if ft == "htmlangular" then
        return {
          timeout_ms = 500,
          lsp_fallback = false, -- 👈 CRITICAL
        }
      end

      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
    formatters = {
      prettierd = {
        command = "/Users/gil/.local/share/nvim/mason/bin/prettierd",
        args = { "--stdin-filepath", "$FILENAME" },
      },
    },
  },
}
