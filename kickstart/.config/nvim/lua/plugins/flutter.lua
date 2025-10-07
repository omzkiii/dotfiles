return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      -- alternatively you can override the default configs
      require("flutter-tools").setup {
        dev_log = {
          enabled = true,
          filter = nil, -- optional callback to filter the log
          -- takes a log_line as string argument; returns a boolean or nil;
          -- the log_line is only added to the output if the function returns true
          notify_errors = false, -- if there is an error whilst running then notify the user
          open_cmd = "15split", -- command to use to open the log buffer
          focus_on_open = false, -- focus on the newly opened log window
        },
        lsp = {
          -- Inside your LSP setup
          on_attach = function(client, bufnr)
            -- Override didChange handler
            client.handlers["textDocument/didChange"] = function(err, method, params, client_id, bufnr, config)
              -- Example: normalize contentChanges so they all share the same base range
              local changes = params.contentChanges

              if changes and #changes > 1 then
                -- Force all changes to use the same range (from the first one)
                local base_range = changes[1].range
                for i = 2, #changes do
                  changes[i].range = base_range
                end
              end

              -- Pass the modified notification along to the default handler
              return vim.lsp.handlers["textDocument/didChange"](err, method, params, client_id, bufnr, config)
            end
          end,
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = true, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            -- background_color = { r = 19, g = 17, b = 24 },
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight
          },

          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt", -- "always"
            enableSnippets = true,
            updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
          },
        },
      }

      vim.keymap.set("n", "<leader>fl", "<cmd>FlutterLogToggle<CR>")
      vim.keymap.set("n", "<leader>fr", "<cmd>FlutterLspRestart<CR>")
      vim.keymap.set("n", "<leader>f<space>", "<cmd>FlutterOutlineToggle<CR>")
    end,
  },
}
