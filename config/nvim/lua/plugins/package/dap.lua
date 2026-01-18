return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "wojciech-kulik/xcodebuild.nvim",
      config = function()
        require("xcodebuild").setup {
          -- Pass the path here instead of the DAP setup
          integrations = {
            codelldb = {
              enabled = true,
              path = os.getenv "HOME" .. "/.local/share/nvim/mason/bin/codelldb",
            },
          },
        }
      end,
    },
  },
  config = function()
    local dap = require "dap"
    local xcodebuild = require "xcodebuild.integrations.dap"

    -- 1. Adapter Setup (Generic CodeLLDB for non-Xcode projects)
    local codelldb_path = os.getenv "HOME" .. "/.local/share/nvim/mason/bin/codelldb"
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }

    -- 2. Configurations (Generic Swift fallback)
    dap.configurations.swift = {
      {
        name = "Launch Swift",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        console = "integratedTerminal",
      },
    }

    -- 3. Xcodebuild DAP Integration
    -- Call setup() with no arguments (or just a boolean for loadBreakpoints)
    xcodebuild.setup()

    -- 4. Keymaps
    vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
    vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
    vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
    vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
    vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
    vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
  end,
}
