require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt = "both" -- to enable cursorline!

-- Enable both relative and absolute line numbers
o.number = true -- Show absolute line numbers
o.relativenumber = true -- Show relative line numbers

-- SMART WORD WRAPPING SETTINGS (overrides init.lua)
o.wrap = true -- Enable line wrapping (overrides init.lua's false)
o.linebreak = true -- Break at word boundaries, not mid-word
o.breakindent = true -- Maintain indentation on wrapped lines
o.showbreak = "↪ " -- Visual indicator for wrapped lines (optional)
o.breakat = " ^I!@*-+;:,./?" -- Characters where line breaks are allowed

-- DEFAULT INDENTATION (guess-indent will override per-file)
-- Set good defaults that guess-indent can fall back to
o.tabstop = 4 -- Default tab width
o.softtabstop = 4 -- Default soft tab width
o.shiftwidth = 4 -- Default shift width
o.expandtab = true -- Use spaces by default
o.scrolloff = 8

-- Pure guess-indent approach - let it handle everything
o.autoindent = true -- Copy indent from current line only
o.smartindent = false -- Disable - causes conflicts
o.cindent = false -- Disable - causes conflicts
o.indentexpr = "" -- Disable expression-based indenting

-- Minimal indent triggers - let guess-indent do the work
o.indentkeys = "" -- Disable automatic re-indenting

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]
