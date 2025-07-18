return {
  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fb",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "[F]ormat [B]uffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },

        java = { "google-java-format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        python = { "black" },
        c = { "clang-format" },

        sh = { "shfmt" },
        go = { "gofumpt" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   -- event = "VeryLazy",
  --   lazy = true,
  --   ft = "*",
  --   opts = {
  --     on_attach = function(client, bufnr)
  --       if client.supports_method "textDocument/formatting" then
  --         vim.api.nvim_clear_autocmds {
  --           group = vim.api.nvim_create_augroup("LspFormatting", {}),
  --           buffer = bufnr,
  --         }
  --         vim.api.nvim_create_autocmd("BufWritePre", {
  --           group = vim.api.nvim_create_augroup("LspFormatting", {}),
  --           buffer = bufnr,
  --           callback = function()
  --             vim.lsp.buf.format { bufnr = bufnr }
  --           end,
  --         })
  --       end
  --     end,
  --   },
  -- },
}
