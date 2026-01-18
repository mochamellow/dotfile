return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      direction = "float",
      float_opts = {
        title = "",
        title_pos = "right",
      },
      winbar = {
        enabled = false,
      },
    }

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new {
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "none",
      },
    }

    -- fix colors for lazygit selection
    vim.api.nvim_set_hl(0, "GhostCursorLine", { bg = "#3b4261", fg = "#c0caf5" })
    vim.api.nvim_set_hl(0, "GhostNormal", { bg = "#1e1e2e", fg = "#c0caf5" })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>gg", function()
      _LAZYGIT_TOGGLE()
    end, { desc = "LazyGit" })
  end,
}
