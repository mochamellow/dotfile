require("nvchad.mappings")

-- add yours here
local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ================================
-- VIM CONFIGURATION & OPTIMIZATION
-- ================================

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

-- ===========================================
-- Override NvChad Telescope keybindings with Snacks picker
-- ===========================================

-- Replace Telescope file finding
map("n", "<leader>ff", function()
	require("snacks").picker.files({ layout = "select" })
end, { desc = "Find Files" })

map("n", "<leader>fA", function()
	require("snacks").picker.files({ hidden = true, no_ignore = true })
end, { desc = "Find All Files" })

-- Replace Telescope live grep
map("n", "<leader>fw", function()
	require("snacks").picker.grep({ layout = "sidebar" })
end, { desc = "Live Grep" })

-- Replace Telescope buffers
map("n", "<leader>fb", function()
	require("snacks").picker.buffers({ layout = "select" })
end, { desc = "Find Buffers" })

-- Replace Telescope help tags
map("n", "<leader>fh", function()
	require("snacks").picker.help()
end, { desc = "Help Tags" })

-- Replace Telescope marks
map("n", "<leader>ma", function()
	require("snacks").picker.marks()
end, { desc = "Find Marks" })

-- Replace Telescope oldfiles
map("n", "<leader>fr", function()
	require("snacks").picker.recent()
end, { desc = "Find Recent Files" })

-- Replace Telescope current buffer fuzzy find
map("n", "<leader>fn", function()
	require("snacks").picker.lines()
end, { desc = "Find in Current Buffer" })

map("n", "<C-f>", function()
	require("snacks").picker.lines()
end, { desc = "Find in Current Buffer" })

-- Replace Telescope git commits
map("n", "<leader>cm", function()
	require("snacks").picker.git_log()
end, { desc = "Git Commits" })

-- Replace Telescope git status
map("n", "<leader>gt", function()
	require("snacks").picker.git_status()
end, { desc = "Git Status" })

-- Replace Telescope terms (approximate with recent files)
map("n", "<leader>pt", function()
	require("snacks").picker.files({ cwd = vim.fn.stdpath("data") .. "/lazy" })
end, { desc = "Pick Hidden Term (Plugin Files)" })

-- ===========================================
-- Additional Snacks Features Keybindings
-- ===========================================

-- Toggle word detection highlighting
map("n", "<leader>tw", function()
	require("snacks").words.toggle()
end, { desc = "Toggle Word Detection" })

-- LazyGit integration (if you want it)
map("n", "<leader>gg", function()
	require("neogit").open({ kind = "floating" })
end, { desc = "Open Neogit" })

-- Snacks notification history
map("n", "<leader>nh", function()
	require("snacks").notifier.show_history()
end, { desc = "Notification History" })

-- Dismiss all notifications
map("n", "<leader>nd", function()
	require("snacks").notifier.hide()
end, { desc = "Dismiss Notifications" })

map("n", "<leader>ut", function()
	require("snacks").toggle.zen():map("<leader>uz")
end, { desc = "Toggle zen mode" })

-- ================================
-- Custom Fold Keybindings
-- ================================

-- Replace zi default function (toggle folding feature) with individual fold toggle
map("n", "zi", "za", { desc = "Toggle fold" })

vim.api.nvim_del_keymap("n", "<leader>ds")
vim.keymap.del("n", "<leader>x")

-- Fidget keymaps
map("n", "<leader>ic", "<cmd>Fidget clear<cr>", { desc = "Fidget: Clear active notifications" })
map("n", "<leader>ih", "<cmd>Fidget history<cr>", { desc = "Fidget: Show notifications history" })
map("n", "<leader>id", "<cmd>Fidget clear_history<cr>", { desc = "Fidget: Clear notifications history" })
map("n", "<leader>is", "<cmd>Fidget suppress<cr>", { desc = "Fidget: Suppress notification window" })
map("n", "<leader>il", "<cmd>Fidget lsp_suppress<cr>", { desc = "Fidget: Suppress LSP progress" })

map("n", "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undo Tree" })

-- Vertical split (to the right)
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", { noremap = true, silent = true })
