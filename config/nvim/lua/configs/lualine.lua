local function xcodebuild_device()
	if vim.g.xcodebuild_platform == "macOS" then
		return " macOS"
	end

	local deviceIcon = ""
	if vim.g.xcodebuild_platform:match("watch") then
		deviceIcon = "􀟤"
	elseif vim.g.xcodebuild_platform:match("tv") then
		deviceIcon = "􀡴 "
	elseif vim.g.xcodebuild_platform:match("vision") then
		deviceIcon = "􁎖 "
	end

	if vim.g.xcodebuild_os then
		return deviceIcon .. " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
	end

	return deviceIcon .. " " .. vim.g.xcodebuild_device_name
end

-----------------------

-- Recording macro

vim.api.nvim_set_hl(0, "LualineMacroText", { bg = "#3C3836", fg = "#FCE094" }) -- color for @
vim.api.nvim_set_hl(0, "LualineMacroReg", { bg = "#3C3836", fg = "#F77C1E", bold = true }) -- color for register

local function recording_macro()
	local rec = vim.fn.reg_recording()
	if rec == "" then
		return ""
	end
	return "%#LualineMacroText#󰡩 Recording: " .. "%#LualineMacroReg#@" .. rec .. "%*"
end

-- Timer on neovim running

local start_time = os.time()
local timer_component = function()
	local diff = os.difftime(os.time(), start_time)
	local hours = math.floor(diff / 3600)
	local minutes = math.floor((diff % 3600) / 60)
	return string.format("󰄉 %dh:%dm spent", hours, minutes)
end

-- Current Time
local current_time = function()
	return os.date("%I:%M %p")
end

------------------------

require("lualine").setup({
	options = {

		-- theme = "dracula", -- or your preferred theme
		theme = "gruvbox_dark", -- or your preferred theme
		-- component_separators = { left = "", right = "" },
		-- component_separators = { left = "   ", right = "   " },

		component_separators = { left = "", right = "   " },
		section_separators = { left = " ", right = " " },
		disabled_filetypes = {},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{ "filename", icon = "" },
			{ "location", icon = "󰆤" },
			{ recording_macro },
			"%=",
			{
				"harpoon2",
				icon = " ",
				indicators = { "1", "2", "3", "4", "5" },
				active_indicators = { "1", "2", "3", "4", "5" },
				color_active = { fg = "#F77C1E" },
				-- _separator = " ",
				separator = { left = "", right = "" },
				no_harpoon = "Waiting for a catch",
			},
		},
		lualine_x = {
			{ "' ' .. vim.g.xcodebuild_last_status" },
			{ "'󰙨 ' .. vim.g.xcodebuild_test_plan" },
			{ xcodebuild_device },
			-- -- "encoding",
			-- -- "fileformat",
			-- {{ "", icon = ""}},
			{
				function()
					local msg = "No Active LSP"
					local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
					local clients = vim.lsp.get_clients()

					if next(clients) == nil then
						return msg
					end

					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = "", -- 󰇈 󰼾 
				color = {},
			},
			{ "filetype" },
		},
		lualine_y = { timer_component },
		lualine_z = { current_time },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "lazy", "mason", "nvim-dap-ui", "trouble" },
})
