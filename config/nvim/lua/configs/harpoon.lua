local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()

-- Customize the UI
vim.api.nvim_create_autocmd("FileType", {
	pattern = "harpoon",
	callback = function(event)
		-- highlight groups
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#414344", bg = "#282828" })
		vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#F77C1E", bg = "#282828", bold = true })
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#282828", bg = "#282828" })
		vim.api.nvim_set_hl(0, "HarpoonNormal", { bg = "#282828", fg = "#A79A84" })

		local ns = vim.api.nvim_create_namespace("HarpoonIcons")
		local devicons = require("nvim-web-devicons")

		local function decorate()
			local bufnr = event.buf
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			for i, line in ipairs(lines) do
				local filename = vim.fn.fnamemodify(line, ":t")
				local icon, icon_hl = devicons.get_icon(filename, nil, { default = true })
				if not icon then
					icon, icon_hl = "", "Normal" -- fallback
				end

				-- overwrite the entire line visually
				vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
					virt_text = { { icon .. " " .. filename, icon_hl } },
					virt_text_pos = "overlay", -- hides the actual text
				})
			end
		end

		decorate()

		-- reapply whenever list changes
		vim.api.nvim_create_autocmd({ "TextChanged", "BufWritePost" }, {
			buffer = event.buf,
			callback = decorate,
		})
	end,
})

-- KEYBINDINGS

local map = vim.keymap.set

map("n", "<leader>a", function()
	harpoon:list():add()
end)
-- map("n", "<C-e>", function()
--   harpoon.ui:toggle_quick_menu(harpoon:list())
-- end)

map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list(), {

		-- WINDOW SIZE & POSITIONING
		ui_width_ratio = 0.3, -- 40% of screen width instead of default
		ui_height_ratio = 0.6, -- Height as ratio of screen (0.1-1.0)
		ui_fallback_width = 60, -- Fallback width in columns
		ui_fallback_height = 20, -- Fallback height in rows
		ui_max_width = 80,
		ui_max_height = 40, -- Maximum height in rows
		ui_min_width = 50, -- Minimum width in columns
		ui_min_height = 15, -- Minimum height in rows

		-- WINDOW APPEARANCE
		border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
		title = "   Harpoon ", -- title with spaces for padding
		title_pos = "center", -- Title position: "left", "center", "right"

		-- WINDOW POSITIONING
		relative = "editor", -- Relative to: "editor", "win", "cursor"
		row = nil, -- Row position (nil for auto-center)
		col = nil, -- Column position (nil for auto-center)
		anchor = "NW", -- Anchor point: "NW", "NE", "SW", "SE"

		-- STYLE OPTIONS
		focusable = true, -- Whether window can be focused
		zindex = 50, -- Z-index for window layering
	})
end)

map("n", "<leader>1", function()
	harpoon:list():select(1)
end)
map("n", "<leader>2", function()
	harpoon:list():select(2)
end)
map("n", "<leader>3", function()
	harpoon:list():select(3)
end)
map("n", "<leader>4", function()
	harpoon:list():select(4)
end)
map("n", "<leader>5", function()
	harpoon:list():select(5)
end)

map("n", "<leader>-", function()
	harpoon:list():remove()
end, { desc = "Clear Current Harpoon list" })

map("n", "<leader><Del>", function()
	harpoon:list():clear()
	vim.notify("Harpoon list cleared!", vim.log.levels.INFO)
end, { desc = "Clear Harpoon list" })
