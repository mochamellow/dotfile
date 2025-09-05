local Snacks = require "snacks" -- for keymap functions

local keys = {
  -- Grep excluding some files
  {
    "<leader>sg",
    function()
      Snacks.picker.grep {
        exclude = { "dictionaries/words.txt" },
        layout = "sidebar",
      }
    end,
    desc = "Grep",
  },

  -- Git Log vertical view
  {
    "<leader>gl",
    function()
      Snacks.picker.git_log {
        finder = "git_log",
        format = "git_log",
        preview = "git_show",
        confirm = "git_checkout",
        layout = "vertical",
      }
    end,
    desc = "Git Log",
  },

  -- Search incomplete tasks
  {
    "<leader>tt",
    function()
      Snacks.picker.grep {
        prompt = " ",
        search = "TODO:",
        regex = true,
        live = false,
        dirs = { vim.fn.getcwd() },
        cwd = vim.fn.getcwd(),
        args = { "--no-require-git" },
        on_show = function()
          vim.cmd.stopinsert()
        end,
        finder = "grep",
        format = "file",
        show_empty = true,
        supports_live = false,
        layout = "sidebar",
      }
    end,
    desc = "[P]Search for incomplete tasks",
  },

  -- Search completed tasks
  {
    "<leader>tb",
    function()
      Snacks.picker.grep {
        prompt = " ",
        search = "BUG:",
        regex = true,
        live = false,
        dirs = { vim.fn.getcwd() },
        cwd = vim.fn.getcwd(),
        args = { "--no-require-git", "--glob", "!.git/*", "--glob", "!node_modules/*" },
        on_show = function()
          vim.cmd.stopinsert()
        end,
        finder = "grep",
        format = "file",
        show_empty = true,
        supports_live = false,
        layout = "vscode",
      }
    end,
    desc = "[P]Search for complete tasks",
  },
  -- {
  --   "<leader>uz",
  --   function()
  --     Snacks.toggle.zen():map("<leader>uz")
  --   end,
  --   desc = "Toggle Zen Mode",
  -- },

  -- Git branches
  {
    "<M-b>",
    function()
      Snacks.picker.git_branches { layout = "select" }
    end,
    desc = "Branches",
  },

  -- Keymaps view
  {
    "<M-k>",
    function()
      Snacks.picker.keymaps { layout = "vertical" }
    end,
    desc = "Keymaps",
  },

  -- File picker
  {
    "<leader><space>",
    function()
      Snacks.picker.files {
        finder = "files",
        format = "file",
        show_empty = true,
        supports_live = true,
        layout = "select",
      }
    end,
    desc = "Find Files",
  },

  -- Additional useful pickers
  {
    "<leader>sc",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History",
  },

  {
    "<leader>sr",
    function()
      Snacks.picker.registers()
    end,
    desc = "Registers",
  },

  {
    "<leader>sj",
    function()
      Snacks.picker.jumps()
    end,
    desc = "Jump List",
  },

  {
    "<leader>sd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Diagnostics",
  },

  {
    "<leader>sk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Keymaps",
  },
}

local opts = {
  -- Smooth scrolling
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 15, total = 250 },
      easing = "linear",
    },
  },

  -- Word detection and highlighting
  words = {
    enabled = true,
    debounce = 100,
    notify_jump = false,
    notify_end = true,
    foldopen = true,
    jumplist = true,
    modes = { "n", "i", "c" },
  },

  -- Indentation guides
  indent = {
    enabled = true,
    char = "│",
    blank = " ",
    only_scope = false,
    only_current = false,
    hl = "SnacksIndent",
    chunk = {
      enabled = true,
      only_current = false,
      hl = "SnacksIndentChunk",
      char = {
        corner_top = "┌",
        corner_bottom = "└",
        horizontal = "─",
        vertical = "│",
        arrow = ">",
      },
    },
    scope = {
      enabled = true,
      animate = {
        enabled = true,
        easing = "linear",
        duration = {
          step = 20,
          total = 500,
        },
      },
      char = "│",
      underline = false,
      hl = "SnacksIndentScope",
    },
  },

  -- Statuscolumn enhancements
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    right = { "fold", "git" }, -- priority of signs on the right (high to low)
    folds = {
      enabled = true,
      open = true, -- show open fold icons
      git_hl = false, -- use Git Signs hl for fold icons
    },
    git = {
      enabled = true,
      patterns = { "GitSigns", "MiniDiffSign" },
    },
    refresh = 50, -- refresh at most every 50ms
  },

  -- Input enhancements
  input = {
    enabled = true,
    icon = "󰍩 ",
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
    prompt_pos = "title",
    win = { style = "input" },
    expand = true,
  },

  -- Quickfile for better file opening
  quickfile = {
    enabled = true,
  },

  -- BigFile handling
  bigfile = {
    enabled = true,
    notify = true, -- show notification when big file detected
    size = 1.5 * 1024 * 1024, -- 1.5MB
    -- treesitter, syntax, matchparen, vimopts, indent, lsp
    setup = function(ctx)
      vim.cmd [[NoMatchParen]]
      Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
      vim.b.minianimate_disable = true
      vim.schedule(function()
        vim.bo[ctx.buf].syntax = ctx.ft
      end)
    end,
  },

  -- Zen mode
  zen = {
    enabled = true,
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = false,
      diagnostics = false,
      inlay_hints = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
    win = { style = "zen" },
  },

  picker = {
    transform = function(item)
      if not item.file then
        return item
      end
      if item.file:match "lazyvim/lua/config/keymaps%.lua" then
        item.score_add = (item.score_add or 0) - 30
      end
      return item
    end,
    debug = { scores = false },
    matcher = { frecency = true },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
          ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
        },
      },
    },
    formatters = { file = { filename_first = true, truncate = 80 } },
  },

  lazygit = {
    theme = { selectedLineBgColor = { bg = "CursorLine" } },
    win = { width = 0, height = 0 },
  },

  notifier = {
    enabled = false,
    top_down = false,
  },
  styles = { snacks_image = { relative = "editor", col = -1 } },

  image = {
    enabled = true,
    doc = {
      inline = vim.g.neovim_mode == "skitty",
      float = true,
      max_width = vim.g.neovim_mode == "skitty" and 5 or 60,
      max_height = vim.g.neovim_mode == "skitty" and 2.5 or 30,
    },
  },

  dashboard = {
    width = 48,
    row = nil, -- dashboard position. nil for center
    col = nil, -- dashboard position. nil for center
    pane_gap = 4, -- empty columns between vertical panes
    preset = {
      keys = {
        { icon = " ", key = "f", desc = "Search File", action = ":lua Snacks.dashboard.pick('files')" },
        -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = " ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      --       header = [[
      -- ███╗   ██╗███████╗ ██████╗ ██████╗ ███████╗ █████╗ ███╗   ██╗
      -- ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗████╗  ██║
      -- ██╔██╗ ██║█████╗  ██║   ██║██████╔╝█████╗  ███████║██╔██╗ ██║
      -- ██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██╔══╝  ██╔══██║██║╚██╗██║
      -- ██║ ╚████║███████╗╚██████╔╝██████╔╝███████╗██║  ██║██║ ╚████║
      -- ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
      --       ]],
      --       header = [[
      -- ██╗    ███╗   ██╗ ██████╗ ██╗███████╗███████╗
      -- ██║    ████╗  ██║██╔═══██╗██║██╔════╝██╔════╝
      -- ██║    ██╔██╗ ██║██║   ██║██║███████╗█████╗
      -- ╚═╝    ██║╚██╗██║██║   ██║██║╚════██║██╔══╝
      -- ██╗    ██║ ╚████║╚██████╔╝██║███████║███████╗
      -- ╚═╝    ╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚══════╝╚══════╝
      --       ]],
      header = [[
 █████╗ ██╗██████╗  ██████╗ 
██╔══██╗██║██╔══██╗██╔═══██╗
███████║██║██████╔╝██║   ██║
██╔══██║██║██╔══██╗██║   ██║
██║  ██║██║██████╔╝╚██████╔╝
╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ 
      ]],
    },
    sections = {
      { section = "header" },
      { icon = "", title = "", section = "keys", gap = 1, indent = 2, padding = 0 },
      { icon = "", title = "", section = "recent_files", limit = 5, gap = 1, indent = 2, padding = 4 },
      { section = "startup" },
    },
  },
}

vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#404344" })

return {
  keys = keys,
  opts = opts,
}
