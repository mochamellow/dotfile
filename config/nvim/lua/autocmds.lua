require "nvchad.autocmds"

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.swift",
  callback = function()
    local ok, xcodebuild_dap = pcall(require, "xcodebuild.integrations.dap")
    if ok and not vim.g.xcodebuild_dap_setup_done then
      -- Ensure DAP integration is registered
      local dap_config_ok, dap_config = pcall(require, "configs.dap")
      if dap_config_ok and dap_config.setup_xcodebuild_integration then
        dap_config.setup_xcodebuild_integration()
      end
      vim.g.xcodebuild_dap_setup_done = true
    end

    -- just the keybindings (no auto setup/run)
    local buffer = vim.api.nvim_get_current_buf()
    if not vim.b[buffer].xcodebuild_keymaps_set then
      local opts = { buffer = buffer, desc = "" }
      vim.keymap.set(
        "n",
        "<leader>dd",
        xcodebuild_dap.build_and_debug,
        vim.tbl_extend("force", opts, { desc = "Build & Debug" })
      )
      vim.keymap.set(
        "n",
        "<leader>dr",
        xcodebuild_dap.debug_without_build,
        vim.tbl_extend("force", opts, { desc = "Debug Without Building" })
      )
      vim.keymap.set(
        "n",
        "<leader>dt",
        xcodebuild_dap.debug_tests,
        vim.tbl_extend("force", opts, { desc = "Debug Tests" })
      )
      vim.keymap.set(
        "n",
        "<leader>dT",
        xcodebuild_dap.debug_class_tests,
        vim.tbl_extend("force", opts, { desc = "Debug Class Tests" })
      )
      vim.keymap.set(
        "n",
        "<leader>b",
        xcodebuild_dap.toggle_breakpoint,
        vim.tbl_extend("force", opts, { desc = "Toggle Breakpoint" })
      )
      vim.keymap.set(
        "n",
        "<leader>B",
        xcodebuild_dap.toggle_message_breakpoint,
        vim.tbl_extend("force", opts, { desc = "Toggle Message Breakpoint" })
      )
      vim.keymap.set(
        "n",
        "<leader>dx",
        xcodebuild_dap.terminate_session,
        vim.tbl_extend("force", opts, { desc = "Terminate Debugger" })
      )

      -- optional build/run/test helpers
      vim.keymap.set(
        "n",
        "<leader>xb",
        "<cmd>XcodebuildBuild<cr>",
        vim.tbl_extend("force", opts, { desc = "Xcode Build" })
      )
      vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildRun<cr>", vim.tbl_extend("force", opts, { desc = "Xcode Run" }))
      vim.keymap.set(
        "n",
        "<leader>xt",
        "<cmd>XcodebuildTest<cr>",
        vim.tbl_extend("force", opts, { desc = "Xcode Test" })
      )
      vim.keymap.set(
        "n",
        "<leader>xs",
        "<cmd>XcodebuildSetup<cr>",
        vim.tbl_extend("force", opts, { desc = "Xcode Setup" })
      )
      vim.keymap.set(
        "n",
        "<leader>xp",
        "<cmd>XcodebuildPicker<cr>",
        vim.tbl_extend("force", opts, { desc = "Xcode Picker" })
      )

      vim.b[buffer].xcodebuild_keymaps_set = true
    end
  end,
})
