return {
  "mattn/emmet-vim",
  ft = {
    "html",
    "htmlangular",
    "angularls",
    "emmet_ls",
    "css",
    "scss",
    "javascript",
    "typescript",
    "ts",
    "js",
    "vue",
    "svelte",
    "php",
  },
  init = function()
    vim.g.user_emmet_leader_key = "<C-y>"
  end,
}
