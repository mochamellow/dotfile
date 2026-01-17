return {
  "wojciech-kulik/xcodebuild.nvim",
  ft = { "swift" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local progress_handle

    require("xcodebuild").setup {
      -- Configure for your setup
      code_coverage = {
        enabled = true,
      },
      logs = {
        auto_open_on_success_tests = false,
        auto_open_on_failed_tests = true,
        auto_open_on_success_build = false,
        auto_open_on_failed_build = true,

        notify = function(message, severity)
          local fidget = require "fidget"
          if progress_handle then
            progress_handle.message = message
            if not message:find "Loading" then
              progress_handle:finish()
              progress_handle = nil
              if vim.trim(message) ~= "" then
                vim.notify(message, severity)
              end
            end
          else
            vim.notify(message, severity)
          end
        end,
        notify_progress = function(message)
          local progress = require "fidget.progress"

          if progress_handle then
            progress_handle.title = ""
            progress_handle.message = message
          else
            progress_handle = progress.handle.create {
              message = message,
              lsp_client = { name = "xcodebuild.nvim" },
            }
          end
        end,
      },
      integrations = {
        pymobiledevice = {
          enabled = true,
        },
        xcodebuild_offline = {
          enabled = true, -- improves build time by blocking Apple servers during builds
        },
      },
    }
    vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
    vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
    vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildSetup<cr>", { desc = "Setup Project" })
    vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
    vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
    vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
    vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
    vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
    vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
    vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
    vim.keymap.set(
      "n",
      "<leader>xC",
      "<cmd>XcodebuildShowCodeCoverageReport<cr>",
      { desc = "Show Code Coverage Report" }
    )
    vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })
  end,
}
