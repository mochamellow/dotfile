return {
  "zapling/mason-conform.nvim",
  event = "BufWritePost",
  config = true,
  dependencies = {
    "mason-org/mason.nvim",
    "stevearc/conform.nvim",
  },
}
