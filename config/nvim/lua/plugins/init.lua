	return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				swift = { "swiftformat" },
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "oil" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end

				return { timeout_ms = 500, lsp_fallback = true }
			end,
			log_level = vim.log.levels.ERROR,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function(_, opts)
			require("configs.lspconfig").setup(opts)
		end,
		opts = {
			servers = {
				tailwindcss = {
					settings = {
						tailwindCSS = {
							lint = {
								invalidApply = false,
							},
						},
					},
				},
				cssls = {
					settings = {
						css = {
							validate = true,
							lint = { unknownAtRules = "ignore" },
						},
						scss = {
							validate = true,
							lint = { unknownAtRules = "ignore" },
						},
					},
				},
				volar = {
					settings = {
						css = {
							validate = true,
							lint = { unknownAtRules = "ignore" },
						},
						scss = {
							validate = true,
							lint = { unknownAtRules = "ignore" },
						},
					},
				},
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			vim.opt.updatetime = 100
			vim.diagnostic.config({ virtual_text = false })
			vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#f76464" })
			vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#f7bf64" })
			vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#64bcf7" })
			vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#64f79d" })
			require("tiny-inline-diagnostic").setup({
				blend = {
					factor = 0.1,
				},
			})
		end,
	},

	-- Disable Telescope (using Snacks picker instead)
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false, -- Load immediately
		config = function()
			require("configs.lualine")
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("configs.fidget")
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup({
				-- minimal setup example
				show = true,
				handle = {
					color = "#666666", -- scrollbar color
				},
				marks = {
					Search = { color = "yellow" },
					Error = { color = "red" },
					Warn = { color = "orange" },
					Info = { color = "blue" },
					Hint = { color = "green" },
					Misc = { color = "purple" },
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			local Snacks = require("snacks")
			local cfg = require("configs.snacksconf") -- your separate config file

			Snacks.setup(cfg.opts) -- pass options to setup

			-- DASHBOARD COLORS
			vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#F77C1E", bold = true })
			vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#F77C1E" })
			vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#F77C1E" })
			vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#C6B99D" })
			vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#6C6C6C" })
			vim.api.nvim_set_hl(0, "SnacksDashboardFile", { fg = "#A8B665" })
			vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#A8B665" })
			vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = "#F77C1E", bold = true })

			-- Snacks Picker custom highlights
			vim.api.nvim_set_hl(0, "SnacksPicker", { fg = "#C6B99D" })
			vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#494B4C" })
			vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#F77C1E", bold = true })
			vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#6C6C6C" })
			vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#F77C1E", bold = true })
			vim.api.nvim_set_hl(0, "SnacksPickerDesc", { fg = "#F77C1E", bold = true })
			vim.api.nvim_set_hl(0, "SnacksPickerUnselected", { fg = "#F77C1E", bold = true })
			vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = "#6C6C6C", bold = true })

			-- Register keymaps
			for _, keymap in ipairs(cfg.keys) do
				if type(keymap[2]) == "function" then
					vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap.desc })
				end
			end
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				progress = { enabled = false },
				signature = { enabled = false },
				hover = { enabled = false },
			},
			messages = { enabled = false },
			notify = { enabled = false },
			cmdline = {
				enabled = true,
			},
			views = {
				cmdline_popup = {
					border = {
						style = "solid",
						padding = { 0, 1 },
					},
					position = {
						row = "40%",
						col = "50%",
					},
					size = {
						width = 50,
						height = "auto",
					},
				},
			},
		},
		config = function(_, opts)
			require("noice").setup(opts)

			-- Highlight overrides (orange text)
			vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = "#F77C1E" })
			vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#F77C1E" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#F77C1E" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "#F77C1E" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "#282828" }) -- example dark gray

			-- Snacks Indent Scope
			vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#6C6C6C" })

			-- Make CmdLine Title nothing.
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "NONE", bg = "NONE" })
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function()
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = function()
			return require("configs.nvimtree") -- your existing config
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {
			-- Faster + Smear
			stiffness = 0.8, -- 0.6      [0, 1]
			trailing_stiffness = 0.6, -- 0.45     [0, 1]
			stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
			trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
			damping = 0.95, -- 0.85     [0, 1]
			damping_insert_mode = 0.95, -- 0.9      [0, 1]
			distance_stop_animating = 0.5, -- 0.1      > 0

			-- No Smear + Fast
			-- stiffness = 0.5,
			-- trailing_stiffness = 0.5,
			-- matrix_pixel_threshold = 0.5,
			-- time_interval = 7, -- milliseconds

			-- Defaults
			smear_between_buffers = true,
			smear_between_neighbor_lines = true,
			scroll_buffer_space = true,
			legacy_computing_symbols_support = false,
			smear_insert_mode = true,
		},
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			custom_surroundings = nil,
			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`
				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
			n_lines = 20,
			respect_selection_type = false,
			search_method = "cover",
			silent = false,
		},
	},
	{
		"wojciech-kulik/xcodebuild.nvim",
		ft = { "swift" }, -- Load for Swift files only
		cmd = { "XcodebuildSetup", "XcodebuildBuild", "XcodebuildRun", "XcodebuildTest", "XcodebuildClean" }, -- Load on these commands
		dependencies = {
			-- Uncomment a picker that you want to use, snacks.nvim might be additionally
			-- useful to show previews and failing snapshots.

			-- You must select at least one:
			-- "nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"folke/snacks.nvim", -- (optional) to show previews
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-tree.lua", -- (optional) to manage project files
			-- "stevearc/oil.nvim", -- (optional) to manage project files
			"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
		},
		config = function()
			local progress_handle

			require("xcodebuild").setup({
				-- Configure for your setup
				code_coverage = {
					enabled = true,
				},
				logs = {
					auto_open_on_success_tests = false,
					auto_open_on_failed_tests = true,
					auto_open_on_success_build = false,
					auto_open_on_failed_build = true,

					notify = function(message, severity)
						local fidget = require("fidget")
						if progress_handle then
							progress_handle.message = message
							if not message:find("Loading") then
								progress_handle:finish()
								progress_handle = nil
								if vim.trim(message) ~= "" then
									vim.notify(message, severity)
								end
							end
						else
							vim.notify(message, severity)
						end
					end,
					notify_progress = function(message)
						local progress = require("fidget.progress")

						if progress_handle then
							progress_handle.title = ""
							progress_handle.message = message
						else
							progress_handle = progress.handle.create({
								message = message,
								lsp_client = { name = "xcodebuild.nvim" },
							})
						end
					end,
				},
				integrations = {
					pymobiledevice = {
						enabled = true,
					},
					xcodebuild_offline = {
						enabled = true, -- improves build time by blocking Apple servers during builds
					},
				},
			})
		end,
	},
	-- nvim-dap + UI + codelldb
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("configs.dap")
			local dapui = require("dapui")
			dapui.setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			win = {
				padding = { 1, 2 },
				border = "double",
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = "#282828" }),
		vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "#282828", fg = "#404344" }),
		vim.api.nvim_set_hl(0, "WhichKeyTitle", { bg = "#282828", fg = "#F77C1E", bold = true }),
		vim.api.nvim_set_hl(0, "WhichKey", { fg = "#F77C1E", bold = true }),
	},
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				cascade = {
					mode = "diagnostics", -- inherit from diagnostics mode
					filter = function(items)
						local severity = vim.diagnostic.severity.HINT
						for _, item in ipairs(items) do
							severity = math.min(severity, item.severity)
						end
						return vim.tbl_filter(function(item)
							return item.severity == severity
						end, items)
					end,
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics ()",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.harpoon")
		end,
	},
	{
		"letieu/harpoon-lualine",
		dependencies = {
			{
				"ThePrimeagen/harpoon",
				branch = "harpoon2",
			},
		},
	},
	{
		"jiaoshijie/undotree",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		---@module 'undotree.collector'
		opts = {
			float_diff = true, -- using float window previews diff, set this `true` will disable layout option
			layout = "left_bottom", -- "left_bottom", "left_left_bottom"
			position = "left", -- "right", "bottom"
			ignore_filetype = {
				"undotree",
				"undotreeDiff",
				"qf",
				"TelescopePrompt",
				"spectre_panel",
				"tsplayground",
			},
			window = {
				winblend = 30,
			},
			keymaps = {
				j = "move_next",
				k = "move_prev",
				gj = "move2parent",
				J = "move_change_next",
				K = "move_change_prev",
				["<cr>"] = "action_enter",
				p = "enter_diffbuf",
				-- q = "quit",
			},
			-- your options
		},
	},
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
	},
	{
		"tzachar/highlight-undo.nvim",
		event = "VeryLazy",
		opts = {
			hlgroup = "HighlightUndo",
			duration = 300,
			pattern = { "*" },
			ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
			-- ignore_cb is in comma as there is a default implementation. Setting
			-- to nil will mean no default os called.
			-- ignore_cb = nil,
		},
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = "󰐱 ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "󰾆 ", color = "info", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "󰙨", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#F77C1E" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
		},
	},
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		},
	},
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"folke/snacks.nvim",
		},
	},
	{
		"nmac427/guess-indent.nvim",
		event = "BufReadPre", -- Load earlier for better detection
		config = function()
			require("guess-indent").setup({
				-- Auto-detect indentation on file open
				auto_cmd = true,
				-- Override editorconfig if detected indentation differs
				override_editorconfig = true,
				-- Default to 4 spaces when detection fails
				default_tab_width = 4,
				-- More aggressive detection
				range = { 1, 200 }, -- Check first 200 lines for pattern
				-- Exclude certain filetypes from detection
				filetype_exclude = {
					"help", "dashboard", "lazy", "mason", "notify", "toggleterm",
					"undotree", "diff", "qf", "gitcommit"
				},
				-- Exclude certain buffer types
				buftype_exclude = {
					"help", "nofile", "terminal", "prompt"
				},
			})
		end,
	},
}
