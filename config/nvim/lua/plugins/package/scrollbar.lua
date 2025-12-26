return {
  "petertriho/nvim-scrollbar",
  enabled = false,
  event = "BufReadPost",
  config = function()
    require("scrollbar").setup {
      show = true,
      handle = {
        color = "#666666", -- scrollbar color
      },
      marks = {
        -- Search = { color = "yellow" },
        Error = { color = "red" },
        -- Warn = { color = "orange" },
        -- Info = { color = "blue" },
        -- Hint = { color = "green" },
        -- Misc = { color = "purple" },
      },
    }
  end,
}
