require "nvchad.options"

-- add yours here!

-- Enable both relative and absolute line numbers
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- SMART WORD WRAPPING SETTINGS (overrides init.lua)
vim.opt.wrap = true           -- Enable line wrapping (overrides init.lua's false)
vim.opt.linebreak = true      -- Break at word boundaries, not mid-word
vim.opt.breakindent = true    -- Maintain indentation on wrapped lines
vim.opt.showbreak = "↪ "      -- Visual indicator for wrapped lines (optional)
vim.opt.breakat = " ^I!@*-+;:,./?"  -- Characters where line breaks are allowed

-- DEFAULT INDENTATION (guess-indent will override per-file)
-- Set good defaults that guess-indent can fall back to
vim.opt.tabstop = 4        -- Default tab width
vim.opt.softtabstop = 4    -- Default soft tab width
vim.opt.shiftwidth = 4     -- Default shift width
vim.opt.expandtab = true   -- Use spaces by default

-- Pure guess-indent approach - let it handle everything
vim.opt.autoindent = true     -- Copy indent from current line only
vim.opt.smartindent = false   -- Disable - causes conflicts
vim.opt.cindent = false       -- Disable - causes conflicts
vim.opt.indentexpr = ""       -- Disable expression-based indenting

-- Minimal indent triggers - let guess-indent do the work
vim.opt.indentkeys = ""       -- Disable automatic re-indenting

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
