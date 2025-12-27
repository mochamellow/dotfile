return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local presets = require "markview.presets"

    local function generic_hl(group)
      return { group_name = group }
    end

    return {
      preview = {
        icon_provider = "devicons",
        filetypes = { "md", "markdown", "txt", "word" },
      },
      markdown = {
        headings = {
          heading_1 = { style = "icon" },
          heading_2 = { style = "label", sign = "" },
          heading_3 = { style = "decorated", sign = "" },
          heading_4 = { style = "simple", sign = "" },
        },

        block_quotes = {
          enable = true,
          wrap = true,
        },

        code_blocks = {
          enable = true,
          style = "simple",
          sign = false,
        },
      },
      markdown_inline = {
        checkboxes = presets.checkboxes.nerd,
        hyperlinks = generic_hl "MarkviewHyperlink",
        uri_autolinks = generic_hl "MarkviewEmail",
      },
      typst = {
        url_links = generic_hl "MarkviewEmail",
      },
    }
  end,
}
