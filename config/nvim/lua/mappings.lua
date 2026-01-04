require "nvchad.mappings"

local map = vim.keymap.set

-- Disabled nvimtreesitter for lf instead.
map("n", "<C-n>", function()
  local buf = vim.api.nvim_buf_get_name(0)
  local dir

  if buf == "" then
    dir = vim.fn.getcwd()
  else
    dir = vim.fn.fnamemodify(buf, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      dir = vim.fn.getcwd()
    end
  end

  -- pass a table with `dir` key
  require("lf").start { dir = dir }
end, { desc = "Toggle lf" })

map("i", "<Del>", "<C-o>x", { noremap = true, desc = "Delete char under cursor" })
map("i", "<M-BS>", "<C-w>", { noremap = true, desc = "Delete word backwards" })
map("i", "<M-Del>", "<C-o>dw", { noremap = true, desc = "Delete word forwards" })
map({ "i", "c" }, "<M-Left>", "<C-Left>", { noremap = true, desc = "Move left by word" })
map({ "i", "c" }, "<M-Right>", "<C-Right>", { noremap = true, desc = "Move right by word" })

map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move lines down while highlighting" })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move lines up while highlighting" })
map("n", "J", "mzJ`z", { desc = "keep cursor in place on J" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Move lines up/down
map("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-j>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-k>", ":m .-2<CR>", { desc = "Move line up" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Split Panes
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<C-\\>", "<cmd>vsplit<cr>", { desc = "Split vertical" })

-- NvChad
map("n", "<leader>th", function()
  require("nvchad.themes").open { style = "flat" }
end, { desc = "Open theme picker" })

-- Quick resize pane
map("n", "<C-A-h>", "5<C-w>>", { desc = "Window increase width by 5" })
map("n", "<C-A-l>", "5<C-w><", { desc = "Window decrease width by 5" })
map("n", "<C-A-k>", "5<C-w>+", { desc = "Window increase height by 5" })
map("n", "<C-A-j>", "5<C-w>-", { desc = "Window decrease height by 5" })
