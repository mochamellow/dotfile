---@type NvPluginSpec
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "hrsh7th/cmp-cmdline" },
    { "brenoprata10/nvim-highlight-colors" },
  },
  config = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    -- ─────────────────────────────────────────────
    -- Cmdline completion
    -- ─────────────────────────────────────────────
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
        { name = "path" },
        {
          name = "lazydev",
          group_index = 0,
        },
      },
    })

    -- ─────────────────────────────────────────────
    -- Formatting (NvChad compatible)
    -- ─────────────────────────────────────────────
    local colors = require "nvim-highlight-colors.color.utils"
    local utils = require "nvim-highlight-colors.utils"

    opts.formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, item)
        local icons = require "nvchad.icons.lspkind"
        icons.Color = "󱓻"

        local icon = " " .. icons[item.kind] .. " "
        item.kind = string.format("%s%s ", icon, item.kind)

        local entryItem = entry:get_completion_item()
        if not entryItem or type(entryItem.documentation) ~= "string" then
          return item
        end

        local color_hex = colors.get_color_value(entryItem.documentation)
        if not color_hex then
          return item
        end

        local hl = utils.create_highlight_name("fg-" .. color_hex)
        vim.api.nvim_set_hl(0, hl, { fg = color_hex, default = true })
        item.kind_hl_group = hl

        return item
      end,
    }

    -- ─────────────────────────────────────────────
    -- Helper: disable cmp briefly on delete
    -- ─────────────────────────────────────────────
    local function disable_cmp_and_delete(fallback)
      if cmp.visible() then
        cmp.close()
      end

      vim.b.cmp_disabled = true
      fallback()

      vim.defer_fn(function()
        vim.b.cmp_disabled = false
      end, 120)
    end

    -- ─────────────────────────────────────────────
    -- Global cmp setup (non-Tailwind)
    -- ─────────────────────────────────────────────
    local custom_opts = {
      enabled = function()
        if vim.bo.buftype == "prompt" then
          return false
        end

        return not vim.b.cmp_disabled
      end,

      sources = {
        { name = "nvim_lsp", priority = 100, max_item_count = 16 },
        { name = "luasnip", priority = 80 },
        { name = "buffer", priority = 50 },
        { name = "nvim_lua", priority = 50 },
        { name = "path", priority = 30 },
      },

      mapping = {
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<BS>"] = cmp.mapping(function(fallback)
          disable_cmp_and_delete(fallback)
        end, { "i", "s" }),

        ["<M-BS>"] = cmp.mapping(function(fallback)
          disable_cmp_and_delete(fallback)
        end, { "i", "s" }),

        -- Scroll documentation window
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Scroll down
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scroll up

        -- Alternative: use <C-f> and <C-b> (forward/backward)
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      },

      window = {
        completion = {
          border = "rounded",
          autocomplete = false, -- manual trigger only
          max_height = 8,
          scrollbar = true,
        },
        documentation = {
          border = "rounded",
          max_height = 15,
          max_width = 100,
          wrap = true,
          scrollbar = true,
        },
      },
      performance = {
        debounce = 120,
        throttle = 60,
        max_view_entries = 16,
      },
    }

    opts = vim.tbl_deep_extend("force", opts, custom_opts)
    cmp.setup(opts)

    -- ─────────────────────────────────────────────
    -- Tailwind filetypes: LOWER LSP PRIORITY
    -- ─────────────────────────────────────────────
    cmp.setup.filetype({
      "html",
      "htmlangular",
      "css",
      "scss",
      "sass",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    }, {
      sources = {
        { name = "nvim_lsp", priority = 10, max_item_count = 16 },
        { name = "luasnip", priority = 80 },
        { name = "buffer", priority = 50 },
        { name = "nvim_lua", priority = 50 },
        { name = "path", priority = 30 },
      },
    })
  end,
}
