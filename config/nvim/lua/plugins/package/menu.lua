return {
  "nvzone/menu",
  lazy = true,
  config = function()
    local menu = require "menu"
    menu.setup {}

    -- Mouse users + nvimtree users
    vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
      require("menu.utils").delete_old_menus()

      -- simulate default right-click behavior
      vim.cmd "normal! \\<RightMouse>"

      -- determine buffer type
      local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
      local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

      menu.open(options, { mouse = true })
    end, { noremap = true, silent = true })
  end,
}
