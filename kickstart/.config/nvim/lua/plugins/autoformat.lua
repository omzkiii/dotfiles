return {
  -- Autoformat
  {
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
      -- format_on_save = function(bufnr)
      --   -- local disable_filetypes = { c = true, cpp = true }
      --   return {
      --     timeout_ms = 500,
      --     -- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      --   }
      -- end,
      formatters_by_ft = {
        lua = { "stylua" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        jsonc = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        python = { "black" },
        c = { "clang-format" },
        php = { "pretty-php" },
        sh = { "shfmt" },
        go = { "gofumpt" },
        cs = { "csharpier" },
        razor = { "csharpier" },
        sql = { "sleek" },
        http = { "trim_whitespace" },
      },
      formatters = {
        injected = {
          options = {
            ignore_errors = true,
            lang_to_formatters = {
              sql = { "sleek" },
            },
          },
        },
        prettierd = {
          args = {
            "--stdin-filepath",
            "$FILENAME",
            -- "--use-tabs",
            -- "--tab-width=4",
            -- "--print-width=500",
          },
        },
        csharpier = {
          prepend_args = { "--stdio" },
        },
      },
    },
  },
}
