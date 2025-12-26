return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  config = function()
    require("fidget").setup {
      display = {
        render_limit = 16, -- How many LSP messages to show at once
        done_ttl = 3, -- How long a message should persist after completion
        done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
        done_style = "FidgetTaskCompleted", -- Highlight group for completed LSP tasks
        progress_style = "FidgetTaskProgress",
        group_style = "FidgetTitle", -- Highlight group for group name (LSP server name)
        icon_style = "FidgetSpinner", -- Highlight group for group icons
      },

      -- Options related to notification subsystem
      notification = {
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget

        view = {
          stack_upwards = true, -- Display notification items from bottom to top
          reflow = true, -- Reflow (wrap) messages wider than notification window
          icon_separator = " ", -- Separator between group name and icon
          group_separator = "---", -- Separator between notification groups
          -- Highlight group used for group separator
          group_separator_hl = "LineNr",
          line_margin = 2, -- Spaces to pad both sides of each non-empty line
        },

        -- Options related to the notification window and buffer
        window = {
          normal_hl = "Special", -- Base highlight group in the notification window
          winblend = 0, -- Background color opacity in the notification window
          border = "rounded", -- Border around the notification window
          zindex = 45, -- Stacking priority of the notification window
          max_width = 100, -- Maximum width of the notification window
          max_height = 100, -- Maximum height of the notification window
          x_padding = 4, -- Padding from right edge of window boundary
          y_padding = 2, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
          tabstop = 8, -- Width of each tab character in the notification window
        },
      },
    }

    local hl = vim.api.nvim_set_hl
    hl(0, "Fidget", { link = "NormalFloat" }) -- base window
    hl(0, "FidgetTitle", { link = "CmpItemAbbrMatch" })
    hl(0, "FidgetTask", { link = "SpecialChar" })
    hl(0, "FidgetSpinner", { link = "DevIconSvg" })
    hl(0, "FidgetTaskCompleted", { link = "DevIconSvg" })
    hl(0, "FidgetTaskProgress", { link = "DevIconSvg" })
  end,
}
