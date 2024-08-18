return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },
  { "nvim-tree/nvim-web-devicons", event = "User FilePost" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
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
    "ggandor/leap.nvim",
    config = function()
      -- require("leap").create_default_mappings()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
    end,
  },
  {
    "preservim/vim-pencil",
  },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --
  --   config = function()
  --     local conf = {}
  --     conf.header = {
  --       "                                                       ",
  --       "                                                       ",
  --       "                                                       ",
  --       "                                                       ",
  --       "                                                       ",
  --       "                                                       ",
  --       " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  --       " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  --       " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  --       " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  --       " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  --       " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  --       "                                                       ",
  --       "                                                       ",
  --       "                                                       ",
  --       "                                                       ",
  --     }
  --
  --     conf.center = {
  --       {
  --         icon = "󰈞  ",
  --         desc = "Find  File                              ",
  --         key = "<Leader> <Leader>",
  --       },
  --       {
  --         icon = "󰈢  ",
  --         desc = "Recently opened files                   ",
  --         key = "<Leader> s o",
  --       },
  --       {
  --         icon = "  ",
  --         desc = "Open Nvim config                        ",
  --         key = "<Leader> s n",
  --       },
  --       {
  --         icon = "  ",
  --         desc = "New file                                ",
  --         action = "enew",
  --         key = "e",
  --       },
  --       {
  --         icon = "󰗼  ",
  --         desc = "Quit Nvim                               ",
  --         -- desc = "Quit Nvim                               ",
  --         action = "qa",
  --         key = "q",
  --       },
  --
  --       -- disable_move = true,
  --       change_to_vcs_root = true,
  --       -- hide = {
  --       --   winbar = true,
  --       -- },
  --     }
  --     require("dashboard").setup {
  --       theme = "doom",
  --       config = conf,
  --       -- shortcut_type = "number",
  --     }
  --   end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } },
  -- },
}
