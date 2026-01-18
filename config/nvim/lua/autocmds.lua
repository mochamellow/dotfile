require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

autocmd("ExitPre", {
  pattern = "*",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

-- CUSTOMIZATIONS
local ok, base46 = pcall(require, "base46")
if not ok then
  return
end

local colors = base46.get_theme_tb "base_30"

vim.api.nvim_set_hl(0, "FloatTitle", {
  fg = "NONE",
  bg = colors.black,
})
