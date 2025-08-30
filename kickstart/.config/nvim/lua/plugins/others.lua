return {
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "VeryLazy",
  --   -- lazy = true,
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      }
    end,
  }, -- NOTE: Must be loaded before dependants
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },
  -- { "nvim-tree/nvim-web-devicons", event = "User FilePost" },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   event = "VeryLazy",
  --   opts = {
  --     indent = { highlight = highlight, char = "│" },
  --     whitespace = {
  --       highlight = highlight,
  --       remove_blankline_trail = false,
  --     },
  --     scope = { enabled = true },
  --   },
  -- },
  {
    "alexghergh/nvim-tmux-navigation",
    -- lazy = true,
    event = "VeryLazy",
    config = function()
      local nvim_tmux_nav = require "nvim-tmux-navigation"

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
  {

    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      -- require("leap").create_default_mappings()
      -- vim.keymap.set("n", "f", "<Plug>(leap)")
      -- vim.keymap.set("n", "F", "<Plug>(leap-from-window)")
      -- vim.keymap.set({ "x", "o" }, "f", "<Plug>(leap-forward)")
      -- vim.keymap.set({ "x", "o" }, "F", "<Plug>(leap-backward)")
      -- require("leap").opts.safe_labels = {}
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap)")
      -- vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", function()
        require("leap.remote").action()
      end)
      vim.keymap.set({ "x", "o" }, "s", function()
        local sk = vim.deepcopy(require("leap").opts.special_keys)
        -- The items in `special_keys` can be both strings or tables - the
        -- shortest workaround might be the below one.
        sk.next_target = vim.fn.flatten(vim.list_extend({ "s" }, { sk.next_target }))
        sk.prev_target = vim.fn.flatten(vim.list_extend({ "S" }, { sk.prev_target }))
        -- Remove these temporary traversal keys from `safe_labels`.
        local sl = {}
        for _, label in ipairs(vim.deepcopy(require("leap").opts.safe_labels)) do
          if label ~= "s" and label ~= "S" then
            table.insert(sl, label)
          end
        end
        pcall(function()
          require("leap.treesitter").select {
            opts = { special_keys = sk, safe_labels = sl },
          }
        end)
      end)
    end,
  },
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {
  --     -- function()
  --     --   require("flash").setup {
  --     --     vim.keymap.set("n", "<M-;>", ":"),
  --     --     vim.keymap.set("n", "<M-,>", ","),
  --     --   }
  --     -- end,
  --   },
  -- -- stylua: ignore
  -- keys = {
  --   { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --   { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --   { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --   { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --   { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  -- },
  -- },
  -- {
  --   "preservim/vim-pencil",
  --   -- lazy = true,
  -- },
  {
    "chipsenkbeil/distant.nvim",
    event = "VeryLazy",
    branch = "v0.3",
    config = function()
      require("distant"):setup {
        server = {
          ["*"] = {
            lsp = {
              ["pyright"] = {
                cmd = { "~/.local/share/nvim/mason/bin/pyright" },
                ft = { "python" },
              },
            },
          },
        },
        network = {
          --   private = true,
          unix_socket = "~/.cache/nvim/distant.nvim/nvim-6032.sock",
        },
        client = {
          bin = "~/.local/share/nvim/distant.nvim/bin/distant",
        },
      }
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
      notification = {
        -- override_vim_notify = true, -- Automatically override vim.notify() with Fidget
      },
    },
  },
}
