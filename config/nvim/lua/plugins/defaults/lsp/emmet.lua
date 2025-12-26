local lspconfig = require "lspconfig"
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.emmet_ls.setup {
  capabilities = cmp_capabilities,
  filetypes = {
    "html",
    "htmlangular",
    "scss",
    "css",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
    "php",
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
}
