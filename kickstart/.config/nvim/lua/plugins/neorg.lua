return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = "true",
    -- event = "VeryLazy",
    ft = "norg",
    opts = {
      vim.keymap.set("n", "<leader>on", "<Plug>(neorg.dirman.new-note)", { desc = "New Note" }),
      vim.keymap.set("n", "<leader>oi", ":Neorg index<CR>", { desc = "Index" }),
      vim.keymap.set("n", "<leader>o<Tab>", ":Neorg toc<CR>", { desc = "ToC" }),
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.ui"] = {},
        ["core.summary"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        -- ["core.integrations.nvim-cmp"] = {
        --   config = {
        --     sources = {
        --       name = "neorg",
        --     },
        --   },
        -- },
        ["core.qol.toc"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = "all",
          },
        },
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "hrsh7th/nvim-cmp",
        config = {
          sources = {
            name = "neorg",
          },
        },
      },
      {
        -- YOU ALMOST CERTAINLY WANT A MORE ROBUST nvim-treesitter SETUP
        -- see https://github.com/nvim-treesitter/nvim-treesitter
        "nvim-treesitter/nvim-treesitter",
        opts = {
          auto_install = true,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        },
        config = function(_, opts)
          require("nvim-treesitter.configs").setup(opts)
        end,
      },
    },
  },
}
