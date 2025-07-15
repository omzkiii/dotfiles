return {
  {

    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = true, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      -- separator = "─",
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      local colors = function()
        local ul = vim.api.nvim_get_hl(0, { name = "SnacksIndentScope", link = false })
        local ul = vim.api.nvim_get_hl(0, { name = "Comment", link = false })

        vim.api.nvim_set_hl(0, "TreesitterContextBottom", { fg = "NONE", bg = "NONE", underline = true, sp = ul.fg })
        vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { link = "TreesitterContextBottom" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" }) -- or LineNr, Normal, etc.
        vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { link = "SnacksIndentScope" }) -- or LineNr, Normal, etc.
        vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "LineNr" })
      end
      colors()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = colors,
      })
    end,
  },
}
