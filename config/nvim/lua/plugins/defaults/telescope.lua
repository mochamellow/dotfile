-- plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "kkharji/sqlite.lua",
    "j-hui/fidget.nvim",
  },
  keys = {
    { "<leader><leader>", desc = "Search" },
    { "<leader>ff", desc = "Search" },
    { "<leader>fa", desc = "Search all files" },
    { "<leader>fw", desc = "Live Grep" },
  },

  config = function(_, opts)
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local layout_actions = require "telescope.actions.layout"
    local builtin = require "telescope.builtin"
    local trouble = require "trouble.sources.telescope"
    local telescope_theme = require "toki.telescope-theme"

    telescope_theme.apply()
    telescope.load_extension "frecency"
    telescope.load_extension "fidget"

    local frecency = telescope.extensions.frecency
    local map = vim.keymap.set

    local SIZES = {
      WIDTH = 0.35,
      HEIGHT = 0.5,
    }

    opts = vim.tbl_deep_extend("force", {
      defaults = {
        history = {
          path = vim.fn.stdpath "data" .. "/telescope_history.sqlite3",
          limit = 100,
        },
        preview = { hide_on_startup = true },
        results_title = false,
        selection_caret = " ",
        entry_prefix = " ",
        file_ignore_patterns = { "node_modules" },
        path_display = function(_, path)
          local cwd = vim.loop.cwd() .. "/"
          path = path:gsub("^" .. vim.pesc(cwd), "")
          local parts = vim.split(path, "/", { trimempty = true })
          if #parts <= 4 then
            return path
          end
          return string.format("%s/%s/.../%s/%s", parts[1], parts[2], parts[#parts - 1], parts[#parts])
        end,
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = SIZES.WIDTH,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = layout_actions.toggle_preview,
            ["<F1>"] = layout_actions.toggle_preview,
            ["<C-t>"] = trouble.open,
          },
          n = {
            ["<C-h>"] = layout_actions.toggle_preview,
            ["<F1>"] = layout_actions.toggle_preview,
            ["<C-t>"] = trouble.open,
          },
        },
      },
      extensions = {
        frecency = {
          show_unindexed = true,
          workspace = "CWD",
          db_safe_mode = false, -- disables popup
        },
      },
    }, opts or {})

    telescope.setup(opts)

    ------------------------------------------------------------------
    -- FILE SEARCHES (ALL USING FREQUENCY)
    ------------------------------------------------------------------

    -- Smart default
    local search_files = function()
      frecency.frecency {
        prompt_title = "Search",
        theme = "dropdown",
        default_text = "",
        workspace = "CWD",
        db_safe_mode = false,
      }
    end

    map("n", "<leader><leader>", search_files, { desc = "Search" })
    map("n", "<leader>ff", search_files, { desc = "Search" })

    -- All files (show unindexed)
    map("n", "<leader>fa", function()
      frecency.frecency {
        prompt_title = "All Files",
        show_unindexed = true,
        theme = "dropdown",
        default_text = "",
        db_safe_mode = false,
      }
    end, { desc = "Search all files" })
    ------------------------------------------------------------------
    -- NON-FILE PICKERS
    ------------------------------------------------------------------

    -- Live grep
    map("n", "<leader>fw", function()
      builtin.live_grep()
    end, { desc = "Live Grep" })

    -- Buffers
    map("n", "<leader>fb", function()
      builtin.buffers { sort_lastused = true }
    end, { desc = "Buffers" })

    -- notify in telescope
    map("n", "<leader>fn", function()
      telescope.extensions.fidget.fidget()
    end, { desc = "Notifications" })
  end,
}
