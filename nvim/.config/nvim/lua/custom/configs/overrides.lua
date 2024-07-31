local M = {}

M.nvterm = {
  require("nvterm").setup({
    terminals = {
      type_opts = {
        horizontal = {
          split_ratio = 0.5  -- This sets the height to 30% of the window
        },
      },
    },
  })
}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    -- "html",
    "css",
    "embedded_template",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "bash",
    "java",
  },
  -- auto_install = true,
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html",
    "htmx-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "tailwindcss-language-server",
    "java",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  actions = {
    open_file = {
      quit_on_open = true,
    },
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}


return M
