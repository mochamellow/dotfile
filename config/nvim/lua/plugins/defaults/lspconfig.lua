return {
  "neovim/nvim-lspconfig",
  config = function(_, opts)
    local nvchad_config = require "nvchad.configs.lspconfig"

    vim.filetype.add {
      extension = {
        html = function(path)
          if path:match "%.component%.html$" or path:match "%.container%.html$" then
            return "htmlangular"
          end
          return "html"
        end,
      },
    }

    -- Consolidated glance opener function
    local function open_glance(action)
      return function()
        local ok, glance = pcall(require, "glance")
        if ok then
          glance.open(action)
        end
      end
    end

    local function custom_on_attach(client, bufnr)
      -- lsp 'K' to view definition
      local function smart_hover()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if #clients == 0 then
          return
        end

        local client = clients[1]
        local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

        vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, config)
          if err or not result or not result.contents then
            return
          end
          vim.lsp.handlers["textDocument/hover"](err, result, ctx, config or {})
        end)
      end

      vim.keymap.set("n", "K", smart_hover, {
        buffer = bufnr,
        desc = "LSP Hover",
      })

      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
      end

      -- glance mappings
      map("n", "gd", open_glance "definitions", "glance definitions")
      map("n", "gr", open_glance "references", "glance references")
      map("n", "gy", open_glance "type_definitions", "glance type definitions")
      map("n", "gm", open_glance "implementations", "glance implementations")

      -- standard lsp mappings
      map("n", "gt", vim.lsp.buf.declaration, "go to declaration")
      map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
      map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
      map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "list workspace folders")
      map("n", "<leader>d", vim.lsp.buf.type_definition, "go to type definition")
      map("n", "<leader>ra", function()
        local ok, renamer = pcall(require, "nvchad.lsp.renamer")
        if ok then
          renamer()
        end
      end, "nvrenamer")
    end

    local servers = {
      "html",
      "cssls",
      "tailwindcss",
      "ts_ls",
      "angularls",
      "sourcekit",
      "emmet_ls",
    }

    if opts and opts.servers then
      for name, _ in pairs(opts.servers) do
        table.insert(servers, name)
      end
    end

    -- Server-specific configurations
    local server_configs = {
      sourcekit = {
        cmd = { "xcrun", "sourcekit-lsp" },
        -- 0.11 native API uses 'root_markers' for automatic detection
        root_markers = { "Package.swift", ".git", "buildServer.json", "compile_commands.json" },
        filetypes = { "swift", "objc", "objcpp" },
        initializationOptions = {
          fallbackFlags = {
            "-target",
            "arm64-apple-ios17.0-simulator",
            "-sdk",
            "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk",
          },
        },
      },
      cssls = {
        settings = {
          css = { lint = { unknownAtRules = "ignore" } },
          scss = { lint = { unknownAtRules = "ignore" } },
          less = { lint = { unknownAtRules = "ignore" } },
        },
      },
      tailwindcss = {
        filetypes = {
          "html",
          "htmlangular",
          "css",
          "scss",
          "sass",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
        },
        flags = {
          debounce_text_changes = 200,
        },
        settings = {
          tailwindCSS = {
            experimental = { classRegex = {} },
          },
        },
      },
      emmet_language_server = {
        filetypes = {
          "html",
          "htmlangular",
          "css",
          "scss",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
        },
      },
    }

    for _, server in ipairs(servers) do
      local server_opts = {
        on_attach = custom_on_attach,
        capabilities = nvchad_config.capabilities,
      }

      if server_configs[server] then
        server_opts = vim.tbl_deep_extend("force", server_opts, server_configs[server])
      end

      vim.lsp.config[server] = server_opts
      vim.lsp.enable(server)
    end

    -- diagnostics config
    vim.diagnostic.config {
      underline = true,
      virtual_text = false,
      update_in_insert = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ✘",
          [vim.diagnostic.severity.WARN] = " ▲",
          [vim.diagnostic.severity.HINT] = " ⚑",
          [vim.diagnostic.severity.INFO] = " »",
        },
      },
    }

    -- Floating window styling (Border and focus behavior)
    vim.lsp.util.open_floating_preview = (function(orig)
      return function(contents, syntax, float_opts, ...)
        float_opts = float_opts or {}
        float_opts.border = "rounded"
        float_opts.focusable = false
        float_opts.close_events = { "BufLeave", "CursorMoved", "InsertEnter" }
        return orig(contents, syntax, float_opts, ...)
      end
    end)(vim.lsp.util.open_floating_preview)

    -- Highlight groups
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "black2" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Special" })
    vim.api.nvim_set_hl(0, "LspCodeLens", { link = "Comment" })
    vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
      link = "Visual",
      bold = true,
    })
  end,
}
