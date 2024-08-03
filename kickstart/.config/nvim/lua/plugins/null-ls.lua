return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua.with {
          extra_args = { "--config-path", vim.fn.expand "~/.config/nvim/.stylua.toml" },
        },
      },
    }
  end,
}
