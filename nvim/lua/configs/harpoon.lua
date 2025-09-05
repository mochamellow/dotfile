local harpoon = require "harpoon"

-- REQUIRED
harpoon:setup()

-- Customize the UI
vim.api.nvim_create_autocmd("FileType", {
  pattern = "harpoon",
  callback = function(event)
    -- Change highlights
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#414344", bg = "#282828" })
    vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#F77C1E", bg = "#282828", bold = true })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#EBDBB2", bg = "#282828" })
    vim.api.nvim_set_hl(0, "HarpoonNormal", { bg = "#282828", fg = "#A79A84" }) -- background + text

    -- Function to rewrite lines
    local function rewrite_lines()
      local bufnr = event.buf
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      for i, line in ipairs(lines) do
        local filename = vim.fn.fnamemodify(line, ":t") -- tail (filename only)
        local icon = require("nvim-web-devicons").get_icon(filename, nil, { default = true })
        lines[i] = icon .. " " .. filename
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end

    -- Run once when opening
    rewrite_lines()

    -- Re-run whenever buffer changes (Harpoon refresh)
    vim.api.nvim_create_autocmd("BufWriteCmd", {
      buffer = event.buf,
      callback = rewrite_lines,
    })
    vim.api.nvim_create_autocmd("TextChanged", {
      buffer = event.buf,
      callback = rewrite_lines,
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

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<leader>-", function()
  harpoon:list():prev()
end)
map("n", "<leader>=", function()
  harpoon:list():next()
end)

map("n", "<leader>0", function()
  harpoon:list():clear()
  vim.notify("Harpoon list cleared!", vim.log.levels.INFO)
end, { desc = "Clear Harpoon list" })
