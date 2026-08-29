return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      local dap = require "dap"
      vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>de", ":DapEval<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>do", ":DapViewToggle<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dnn", ":DapContinue<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dni", ":DapStepInto<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dno", ":DapStepOver<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dnx", ":DapStepOut<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dc", ":DapClearBreakpoints<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dt", ":DapTerminate<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dr", ":DapRestartFrame<CR>", { noremap = true, silent = true })
      vim.fn.sign_define("DapBreakpoint", {
        text = "⏺ ", -- Custom icon (e.g., red circle)
        texthl = "DiagnosticInfo", -- Highlight group for the sign
        linehl = "", -- Optional: Line highlight
        numhl = "", -- Optional: Number column highlight
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "󰜺 ", -- Custom icon (e.g., no-entry sign)
        texthl = "DiagnosticError",
      })
      -- python
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug Current File",
          program = "${file}", -- Debug the currently open file
          pythonPath = function()
            return "/usr/bin/python3" -- Adjust to your Python path
          end,
        },
      }
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
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to server",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
      }
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch TS (tsx)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "npx",
          runtimeArgs = { "tsx" },
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to server",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
      }

      -- dap.adapters.firefox = {
      --   type = "executable",
      --   command = "node",
      --   args = { vim.fn.stdpath "data" .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
      -- }
      --
      -- dap.configurations.typescriptreact = {
      --   {
      --     name = "Debug with Firefox",
      --     type = "firefox",
      --     request = "launch",
      --     reAttach = true,
      --     url = "http://localhost:5173",
      --     webRoot = "${workspaceFolder}",
      --     firefoxExecutable = "/usr/bin/firefox",
      --   },
      -- }
    end,
  },
  { "nvim-neotest/nvim-nio", event = "VeryLazy" },
  {
    "igorlfs/nvim-dap-view",
    -- let the plugin lazy load itself
    lazy = false,
    version = "1.*",
    opts = {
      winbar = {
        show = true,
        -- You can add a "console" section to merge the terminal with the other views
        sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
        -- Must be one of the sections declared above
        default_section = "watches",
        -- Append hints with keymaps within the labels
        show_keymap_hints = true,
        -- List of up to 2 strings, defining left and right separators
        separators = nil,
        -- Configure each section individually
        base_sections = {
          -- Labels can be set dynamically with functions
          -- Each function receives the window's width and the current section as arguments
          breakpoints = { label = "Breakpoints", keymap = "B" },
          scopes = { label = "Scopes", keymap = "S" },
          exceptions = { label = "Exceptions", keymap = "E" },
          watches = { label = "Watches", keymap = "W" },
          threads = { label = "Threads", keymap = "T" },
          repl = { label = "REPL", keymap = "R" },
          sessions = { label = "Sessions", keymap = "K" },
          console = { label = "Console", keymap = "C" },
        },
        -- Add your own sections
        custom_sections = {},
        controls = {
          enabled = false,
          position = "right",
          buttons = {
            "play",
            "step_into",
            "step_over",
            "step_out",
            "step_back",
            "run_last",
            "terminate",
            "disconnect",
          },
          custom_buttons = {},
        },
      },
      windows = {
        size = 0.25,
        position = "below",
        terminal = {
          size = 0.5,
          position = "left",
          -- List of debug adapters for which the terminal should be ALWAYS hidden
          hide = {},
        },
      },
      icons = {
        collapsed = "󰅂 ",
        disabled = "",
        disconnect = "",
        enabled = "",
        expanded = "󰅀 ",
        filter = "󰈲",
        negate = " ",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
      },
      help = {
        border = nil,
      },
      render = {
        -- Optionally a function that takes two `dap.Variable`'s as arguments
        -- and is forwarded to a `table.sort` when rendering variables in the scopes view
        sort_variables = nil,
        -- Full control of how frames are rendered, see the "Custom Formatting" page
        threads = {
          -- Choose which items to display and how
          format = function(name, lnum, path)
            return {
              { part = name, separator = " " },
              { part = path, hl = "FileName", separator = ":" },
              { part = lnum, hl = "LineNumber" },
            }
          end,
          -- Align columns
          align = false,
        },
        -- Full control of how breakpoints are rendered, see the "Custom Formatting" page
        breakpoints = {
          -- Choose which items to display and how
          format = function(line, lnum, path)
            return {
              { part = path, hl = "FileName" },
              { part = lnum, hl = "LineNumber" },
              { part = line, hl = true },
            }
          end,
          -- Align columns
          align = false,
        },
      },
      -- Requires neovim 0.12+
      virtual_text = {
        -- Control with `DapViewVirtualTextToggle`
        enabled = false,
        format = function(variable, _, _)
          -- Strip out excessive whitespace
          return " " .. variable.value:gsub("%s+", " ")
        end,
      },
      -- Controls how to jump when selecting a breakpoint or navigating the stack
      -- Comma separated list, like the built-in 'switchbuf'. See :help 'switchbuf'
      -- Only a subset of the options is available: newtab, useopen, usetab and uselast
      -- Can also be a function that takes the current winnr and the destination bufnr
      -- If a function, should return the winnr of the destination window
      switchbuf = "usetab,uselast",
      -- Auto open when a session is started and auto close when all sessions finish
      -- Alternatively, can be a string:
      -- - "keep_terminal": as above, but keeps the terminal when the session finishes
      -- - "open_term": open the terminal when starting a new session, nothing else
      auto_toggle = false,
      -- Reopen dapview when switching to a different tab
      -- Can also be a function to dynamically choose when to follow, by returning a boolean
      -- If a function, receives the name of the adapter for the current session as an argument
      follow_tab = false,
    },
    config = function() end,
  },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   -- cmd = { "DapContinue", "DapToggleBreakpoint" },
  --   event = "VeryLazy",
  --   -- lazy = true,
  --   dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  --   config = function()
  --     local dap, dapui = require "dap", require "dapui"
  --     dapui.setup()
  --     dap.listeners.before.attach.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       dapui.close()
  --     end
  --     vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>de", ":DapEval<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>do", ":DapNew<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dnn", ":DapContinue<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dni", ":DapStepInto<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dno", ":DapStepOver<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dnx", ":DapStepOut<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dc", ":DapClearBreakpoints<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dt", ":DapTerminate<CR>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dr", ":DapRestartFrame<CR>", { noremap = true, silent = true })
  --     vim.fn.sign_define("DapBreakpoint", {
  --       text = "⏺ ", -- Custom icon (e.g., red circle)
  --       texthl = "DiagnosticInfo", -- Highlight group for the sign
  --       linehl = "", -- Optional: Line highlight
  --       numhl = "", -- Optional: Number column highlight
  --     })
  --     vim.fn.sign_define("DapBreakpointRejected", {
  --       text = "󰜺 ", -- Custom icon (e.g., no-entry sign)
  --       texthl = "DiagnosticError",
  --     })
  --     -- python
  --     dap.adapters.python = {
  --       type = "executable",
  --       command = "python",
  --       args = { "-m", "debugpy.adapter" },
  --     }
  --
  --     dap.configurations.python = {
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Debug Current File",
  --         program = "${file}", -- Debug the currently open file
  --         pythonPath = function()
  --           return "/usr/bin/python3" -- Adjust to your Python path
  --         end,
  --       },
  --     }
  --     -- cpp, c
  --     dap.adapters.codelldb = {
  --       type = "server",
  --       port = "${port}",
  --       executable = {
  --         command = "codelldb", -- e.g., "/usr/bin/codelldb"
  --         args = { "--port", "${port}" },
  --       },
  --     }
  --     dap.configurations.cpp = {
  --       {
  --         name = "Debug",
  --         type = "codelldb",
  --         request = "launch",
  --         program = function()
  --           return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  --         end,
  --         cwd = "${workspaceFolder}",
  --         stopOnEntry = true,
  --         args = {},
  --       },
  --     }
  --     dap.configurations.c = dap.configurations.cpp
  --     -- GO
  --     dap.adapters.delve = function(callback, config)
  --       if config.mode == "remote" and config.request == "attach" then
  --         callback {
  --           type = "server",
  --           host = config.host or "127.0.0.1",
  --           port = config.port or "38697",
  --         }
  --       else
  --         callback {
  --           type = "server",
  --           port = "${port}",
  --           executable = {
  --             command = "dlv",
  --             args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
  --             detached = vim.fn.has "win32" == 0,
  --           },
  --         }
  --       end
  --     end
  --     --
  --     --   -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  --     dap.configurations.go = {
  --       {
  --         type = "delve",
  --         name = "Debug",
  --         request = "launch",
  --         program = "${file}",
  --         outputMode = "remote",
  --       },
  --       {
  --         type = "delve",
  --         name = "Debug test", -- configuration for debugging test files
  --         request = "launch",
  --         mode = "test",
  --         program = "${file}",
  --       },
  --       -- works with go.mod packages and sub packages
  --       {
  --         type = "delve",
  --         name = "Debug test (go.mod)",
  --         request = "launch",
  --         mode = "test",
  --         program = "./${relativeFileDirname}",
  --       },
  --     }
  --     dap.adapters["pwa-node"] = {
  --       type = "server",
  --       host = "localhost",
  --       port = "${port}",
  --       executable = {
  --         command = "node",
  --         -- 💀 Make sure to update this path to point to your installation
  --         args = {
  --           vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
  --           "${port}",
  --         },
  --       },
  --     }
  --     dap.configurations.javascript = {
  --       {
  --         type = "pwa-node",
  --         request = "launch",
  --         name = "Launch file",
  --         program = "${file}",
  --         cwd = "${workspaceFolder}",
  --       },
  --       {
  --         type = "pwa-node",
  --         request = "attach",
  --         name = "Attach to server",
  --         processId = require("dap.utils").pick_process,
  --         cwd = "${workspaceFolder}",
  --         sourceMaps = true,
  --         skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  --         resolveSourceMapLocations = {
  --           "${workspaceFolder}/**",
  --           "!**/node_modules/**",
  --         },
  --       },
  --     }
  --     dap.configurations.typescript = {
  --       {
  --         type = "pwa-node",
  --         request = "launch",
  --         name = "Launch TS (tsx)",
  --         program = "${file}",
  --         cwd = "${workspaceFolder}",
  --         runtimeExecutable = "npx",
  --         runtimeArgs = { "tsx" },
  --         sourceMaps = true,
  --         skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  --         resolveSourceMapLocations = {
  --           "${workspaceFolder}/**",
  --           "!**/node_modules/**",
  --         },
  --         console = "integratedTerminal",
  --       },
  --       {
  --         type = "pwa-node",
  --         request = "attach",
  --         name = "Attach to server",
  --         processId = require("dap.utils").pick_process,
  --         cwd = "${workspaceFolder}",
  --         sourceMaps = true,
  --         skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  --         resolveSourceMapLocations = {
  --           "${workspaceFolder}/**",
  --           "!**/node_modules/**",
  --         },
  --       },
  --     }
  --
  --     -- dap.adapters.firefox = {
  --     --   type = "executable",
  --     --   command = "node",
  --     --   args = { vim.fn.stdpath "data" .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
  --     -- }
  --     --
  --     -- dap.configurations.typescriptreact = {
  --     --   {
  --     --     name = "Debug with Firefox",
  --     --     type = "firefox",
  --     --     request = "launch",
  --     --     reAttach = true,
  --     --     url = "http://localhost:5173",
  --     --     webRoot = "${workspaceFolder}",
  --     --     firefoxExecutable = "/usr/bin/firefox",
  --     --   },
  --     -- }
  --   end,
  -- },

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
