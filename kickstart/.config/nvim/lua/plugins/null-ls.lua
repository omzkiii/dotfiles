return {
  --   "nvimtools/none-ls.nvim",
  --   config = function()
  --     local null_ls = require "null-ls"
  --
  --     null_ls.setup {
  --       sources = {
  --         null_ls.builtins.formatting.stylua.with {
  --           extra_args = { "--config-path", vim.fn.expand "~/.config/nvim/.stylua.toml" },
  --         },
  --         null_ls.builtins.formatting.prettierd,
  --         null_ls.builtins.diagnostics.eslint_d,
  --       },
  --
  --     --   on_attach = function(client, bufnr)
  --     --     if client.supports_method "textDocument/formatting" then
  --     --       vim.api.nvim_clear_autocmds {
  --     --         group = vim.api.nvim_create_augroup("LspFormatting", {}),
  --     --         buffer = bufnr,
  --     --       }
  --     --       vim.api.nvim_create_autocmd("BufWritePre", {
  --     --         group = vim.api.nvim_create_augroup("LspFormatting", {}),
  --     --         buffer = bufnr,
  --     --         callback = function()
  --     --           vim.lsp.buf.format { bufnr = bufnr }
  --     --         end,
  --     --       })
  --     --     end
  --     --   end,
  --     }
  --   end,
}
