return {
  "nvchad/ui",
  dev = false,
  branch = "v3.0",
  dependencies = {
    "abeldekat/harpoonline",
    config = function()
      require("harpoonline").setup {
        on_update = function()
          vim.cmd.redrawstatus()
        end,
      }
    end,
  },
  config = function()
    require "nvchad"
  end,
}
