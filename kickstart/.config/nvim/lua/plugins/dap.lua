return {
  { "mfussenegger/nvim-dap", event = "VeryLazy" },
  { "nvim-neotest/nvim-nio", event = "VeryLazy" },
  {
    "rcarriga/nvim-dap-ui",
    -- cmd = { "DapContinue", "DapToggleBreakpoint" },
    event = "VeryLazy",
    -- lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>de", ":DapEvaluate<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>do", ":DapNew<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<M-n>", ":DapContinue<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dc", ":DapClearBreakpoints<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dt", ":DapTerminate<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dr", ":DapRestartFrame<CR>", { noremap = true, silent = true })

      -- cpp, c
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb", -- e.g., "/usr/bin/codelldb"
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Debug",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
      -- GO
      dap.adapters.delve = function(callback, config)
        if config.mode == "remote" and config.request == "attach" then
          callback {
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or "38697",
          }
        else
          callback {
            type = "server",
            port = "${port}",
            executable = {
              command = "dlv",
              args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
              detached = vim.fn.has "win32" == 0,
            },
          }
        end
      end
      --
      --   -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
          outputMode = "remote",
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    -- cmd = { "DapContinue", "DapToggleBreakpoint" },
    -- event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
    opts = {
      handlers = {},
      ensure_installed = { "debugpy", "codelldb", "delve", "jdtls" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    -- cmd = { "DapContinue", "DapToggleBreakpoint" },
    -- event = "VeryLazy",
    lazy = true,
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
}
