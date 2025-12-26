return {
  "karb94/neoscroll.nvim",
  event = "WinScrolled",

  config = function()
    local neoscroll = require "neoscroll"

    neoscroll.setup {
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.0,
      performance_mode = false,
      ignored_events = {
        "WinScrolled",
        "CursorMoved",
      },
    }

    -- custom smooth scroll keymaps
    local keymap = {
      ["<C-u>"] = function()
        neoscroll.ctrl_u { duration = 250, easing = "sine" }
      end,
      ["<C-d>"] = function()
        neoscroll.ctrl_d { duration = 250, easing = "sine" }
      end,

      ["<C-y>"] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 50, easing = "quadratic" })
      end,

      ["<C-e>"] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 50, easing = "quadratic" })
      end,
    }

    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func, { silent = true })
    end
  end,
}
