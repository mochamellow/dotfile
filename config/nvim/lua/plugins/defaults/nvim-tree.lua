return {
  "nvim-tree/nvim-tree.lua",
  enabled = true,
  init = function()
    vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
  end,
  config = function()
    -- Load cached settings
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { link = "PmenuSbar" })

    local nvtree = require "nvim-tree"
    local api = require "nvim-tree.api"

    -- Custom key mappings on attach
    local function custom_on_attach(bufnr)
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      local map = vim.keymap.set
      map("n", "+", api.tree.change_root_to_node, opts "CD")
      map("n", "?", api.tree.toggle_help, opts "Help")
      map("n", "<ESC>", api.tree.close, opts "Close")
    end

    -- Automatically open file on creation
    api.events.subscribe(api.events.Event.FileCreated, function(file)
      vim.cmd("edit " .. file.fname)
    end)

    -- Automatically notify LSP on renamed nodes
    api.events.subscribe(api.events.Event.NodeRenamed, function(data)
      local stat = vim.uv.fs_stat(data.new_name)
      if not stat then
        return
      end

      local type = ({ file = "file", directory = "folder" })[stat.type]
      local clients = vim.lsp.get_clients {}
      local uri_from_path = function(path)
        return vim.uri_from_fname(path)
      end

      for _, client in ipairs(clients) do
        local filters = vim.tbl_get(client.server_capabilities, "workspace", "fileOperations", "didRename", "filters")
          or {}

        for _, filter in pairs(filters) do
          -- Only support "file" scheme
          if filter.scheme == nil or filter.scheme == "file" then
            client.notify("workspace/didRenameFiles", {
              files = {
                { oldUri = uri_from_path(data.old_name), newUri = uri_from_path(data.new_name) },
              },
            })
          end
        end
      end
    end)

    -- NvimTree setup with overrides
    nvtree.setup {
      on_attach = custom_on_attach,
      view = {
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = function()
            local columns = vim.o.columns
            local lines = vim.o.lines
            local width = math.max(math.floor(columns * 0.2), 36)
            return {
              relative = "editor",
              border = "double",
              width = width,
              height = lines - 5,
              row = 1,
              col = 3,
            }
          end,
        },
        preserve_window_proportions = false,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = function(path)
          return "    " .. vim.fn.fnamemodify(path, ":t")
        end,
        icons = {
          glyphs = {
            default = "",
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    }
  end,
}
