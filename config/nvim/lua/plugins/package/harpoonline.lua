return {
  "abeldekat/harpoonline",
  dependencies = { "nvim-lualine/lualine.nvim" }, -- Optional, but good practice
  config = function()
    require("harpoonline").setup {
      -- This ensures the statusline refreshes when Harpoon marks change
      on_update = function()
        vim.cmd.redrawstatus()
      end,
    }
  end,
}
