vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},

	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline") -- Disabled to use lualine instead

require("options")
require("autocmds")

vim.schedule(function()
	require("mappings")
	require("smear_cursor").setup({})
end)

-- Treesitter folding configuration
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.require'nvim-treesitter.fold'.get_fold_indic(v:lnum)"

-- Configure folding levels for better experience
vim.o.foldlevel = 99 -- Open all folds by default
vim.o.foldlevelstart = 99 -- Open all folds when opening files
vim.o.foldminlines = 1 -- Allow folding single lines
vim.o.foldenable = true -- Enable folding
vim.o.foldnestmax = 10 -- Maximum fold nesting
vim.o.cmdheight = 0
vim.o.showmode = false
vim.o.scrolloff = 8
vim.o.termguicolors = true
vim.o.updatetime = 50

-- Indentation settings (now in options.lua)
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

-- Configure fold text display for better visibility
-- vim.o.fillchars = "fold: ,foldopen:▾,foldclose:▸"
vim.o.foldtext = "v:lua.custom_fold_text()"

-- Custom fold text function to show closing tags/brackets like VS Code
_G.custom_fold_text = function()
	local start_line = vim.v.foldstart
	local end_line = vim.v.foldend

	-- Get the first line and last line text
	local first_line = vim.fn.getline(start_line)
	local last_line = vim.fn.getline(end_line)

	-- Remove leading whitespace from first line but preserve structure
	local first_trimmed = first_line:gsub("^%s+", "")

	-- Language-specific closing tag/bracket detection
	local ft = vim.bo.filetype

	if ft == "html" or ft == "htmlangular" or ft == "htmldjango" or ft == "xml" or ft == "vue" or ft == "svelte" then
		-- HTML-like languages: show closing tag
		local tag_match = last_line:match("</([%w%-:]+)>%s*$")
		if tag_match then
			return first_trimmed .. " ... </" .. tag_match .. ">"
		else
			-- Look for self-closing or other patterns
			local trimmed_last = last_line:gsub("^%s+", ""):gsub("%s+$", "")
			if trimmed_last:match("/>$") then
				return first_trimmed .. " ... />"
			else
				return first_trimmed .. " ..."
			end
		end
	elseif
		ft == "javascript"
		or ft == "typescript"
		or ft == "jsx"
		or ft == "tsx"
		or ft == "javascriptreact"
		or ft == "typescriptreact"
	then
		-- JavaScript/TypeScript: show closing brace/bracket/paren
		local last_trimmed = last_line:gsub("^%s+", ""):gsub("%s+$", "")

		-- Match closing characters with optional semicolon/comma
		if last_trimmed:match("^[}%]%);,]*$") then
			return first_trimmed .. " ..." .. last_trimmed
		else
			-- Infer closing character from opening line
			if first_line:match("{%s*$") then
				return first_trimmed .. " ...}"
			elseif first_line:match("%[%s*$") then
				return first_trimmed .. " ...]"
			elseif first_line:match("%(%s*$") then
				return first_trimmed .. " ...)"
			else
				return first_trimmed .. " ..."
			end
		end
	elseif ft == "css" or ft == "scss" or ft == "sass" or ft == "less" then
		-- CSS/SCSS: show closing brace
		local last_trimmed = last_line:gsub("^%s+", ""):gsub("%s+$", "")
		if last_trimmed == "}" then
			return first_trimmed .. " ...}"
		else
			return first_trimmed .. " ..."
		end
	elseif ft == "json" then
		-- JSON: show closing brace/bracket
		local last_trimmed = last_line:gsub("^%s+", ""):gsub("%s+$", "")
		if last_trimmed:match("^[}%],]*$") then
			return first_trimmed .. " ..." .. last_trimmed
		else
			return first_trimmed .. " ..."
		end
	elseif ft == "lua" or ft == "python" or ft == "go" or ft == "rust" or ft == "java" or ft == "c" or ft == "cpp" then
		-- Other programming languages
		local last_trimmed = last_line:gsub("^%s+", ""):gsub("%s+$", "")
		if last_trimmed:match("^[}%]%);,]*$") then
			return first_trimmed .. " ..." .. last_trimmed
		else
			-- Infer from opening line
			if first_line:match("{%s*$") then
				return first_trimmed .. " ...}"
			elseif first_line:match("%[%s*$") then
				return first_trimmed .. " ...]"
			else
				return first_trimmed .. " ..."
			end
		end
	else
		-- Default: just add ellipsis
		return first_trimmed .. " ..."
	end
end

-- Force TreeSitter folding to be enabled after all plugins load
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Wait a bit for all plugins to load
		vim.defer_fn(function()
			-- Reconfigure TreeSitter with folding enabled
			local success, ts_configs = pcall(require, "nvim-treesitter.configs")
			if success then
				local config = require("configs.treesitter")
				ts_configs.setup(config)
			end
		end, 100) -- 100ms delay
	end,
})

-- Aggressive fold initialization fix for pickers and file explorers
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWinEnter" }, {
	callback = function(args)
		local buf = args.buf or vim.api.nvim_get_current_buf()

		-- Skip non-file buffers
		if vim.bo[buf].buftype ~= "" then
			return
		end

		-- Exit insert mode immediately if we're in it
		if vim.fn.mode() == "i" then
			vim.cmd("stopinsert")
		end

		-- Force immediate fold setup with multiple attempts
		local function setup_folds()
			local ft = vim.bo[buf].filetype

			-- Map filetypes to parsers
			local filetype_to_parser = {
				htmlangular = "html",
				htmldjango = "html",
				javascriptreact = "javascript",
				typescriptreact = "typescript",
				jsx = "javascript",
				tsx = "typescript",
			}

			local parser_name = filetype_to_parser[ft] or ft

			-- Check if we should apply TreeSitter folding
			local has_parser_module = pcall(require, "nvim-treesitter.parsers")
			if has_parser_module then
				local parsers = require("nvim-treesitter.parsers")
				if parsers.has_parser(parser_name) then
					-- Force folding settings with correct scope
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.require'nvim-treesitter.fold'.get_fold_indic(v:lnum)"
					vim.wo.foldenable = true
					vim.wo.foldlevel = 99
					vim.wo.foldcolumn = "1"

					-- Force immediate fold calculation
					vim.cmd("silent! normal! zx")

					return true
				end
			end
			return false
		end

		-- Try immediately
		if not setup_folds() then
			-- If it didn't work, try after a short delay
			vim.defer_fn(function()
				if vim.api.nvim_buf_is_valid(buf) then
					setup_folds()
				end
			end, 50)
		end

		-- Also try after an even longer delay as a fallback
		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_current_buf() == buf then
				setup_folds()
			end
		end, 200)
	end,
})

-- Comprehensive FileType autocmd for TreeSitter folding
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		-- Web technologies
		"html",
		"htmlangular",
		"htmldjango",
		"xml",
		"css",
		"scss",
		"sass",
		"less",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"jsx",
		"tsx",
		"vue",
		"svelte",
		"astro",
		"angular",

		-- Programming languages
		"python",
		"go",
		"rust",
		"lua",
		"c",
		"cpp",
		"java",
		"kotlin",
		"swift",
		"php",
		"ruby",
		"perl",
		"bash",
		"zsh",
		"fish",
		"json",
		"yaml",
		"toml",
		"sql",
		"graphql",

		-- Other languages
		"markdown",
		"dockerfile",
		"nginx",
		"terraform",
		"hcl",
		"vim",
		"vimdoc",
		"helm",
		"proto",
		"prisma",
	},
	callback = function()
		local ft = vim.bo.filetype

		-- Map file types to TreeSitter parsers
		local filetype_to_parser = {
			htmlangular = "html",
			htmldjango = "html",
			javascriptreact = "javascript",
			typescriptreact = "typescript",
			jsx = "javascript",
			tsx = "typescript",
		}

		local parser_name = filetype_to_parser[ft] or ft

		-- Only apply TreeSitter folding if parser is available
		local has_parser_module = pcall(require, "nvim-treesitter.parsers")
		if has_parser_module then
			local parsers = require("nvim-treesitter.parsers")
			if parsers.has_parser(parser_name) then
				vim.opt_local.foldmethod = "expr"
				vim.opt_local.foldexpr = "v:lua.require'nvim-treesitter.fold'.get_fold_indic(v:lnum)"
				vim.opt_local.foldenable = true
				vim.opt_local.foldlevel = 99

				-- Add fold column to make folds visible (applied after NvChad loads)
				vim.opt_local.foldcolumn = "1"
				vim.opt_local.signcolumn = "yes"
			end
		end
	end,
})
