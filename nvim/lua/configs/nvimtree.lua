local overrides = {
  view = {
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = function()
        local columns = vim.o.columns
        local lines = vim.o.lines
        local width = math.floor(columns * 0.20)
        local min_width = 36

        if width < min_width then
          width = min_width
        end

        return {
          relative = "editor",
          border = "double", -- "single", "double", "shadow", "none"
          width = width,
          height = lines - 5, -- full height but leave top+bottom margin
          row = 1, -- top margin
          col = 3, -- left margin
        }
      end,
    },
    preserve_window_proportions = false,
  },
  -- Add this to ensure no layout adjustments
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = function(path)
      local folder_name = vim.fn.fnamemodify(path, ":t") -- last folder only
      return "    " .. vim.fn.fnamemodify(path, ":t")
    end,
    icons = {
      glyphs = {
        default = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    --
    -- highlight overrides
    vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "#282828" }) -- floating window bg
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#404344" })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1e1e2e", fg = "#cdd6f4" }) -- normal text
    vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#C0BDB7", bold = true }) -- folder names
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#C0BDB7", bold = true, italic = true })
    vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#F77C1E", bold = true }) -- root folder
    vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#a6e3a1", bold = true }) -- executable files
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#fab387" }) -- git changes
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#94e2d5" }) -- git new
    vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#EC6B64" }) -- git deleted
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#303030" }) -- line under cursor
    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#2D3031" }) -- │ indentation markers

    -- Folder customizationd
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#89B483" }) -- blue
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", { fg = "#F77C1E" }) -- orange
    vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderIcon", { fg = "#6C6C6C" }) -- teal
    vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderIcon", { fg = "#cba6f7" }) -- lavender

    vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = "#6C6C6C" })
    vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = "#F77C1E" })
  end,
})

return overrides
