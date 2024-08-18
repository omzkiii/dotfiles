return {
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    lazy = true,
    -- init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme("tokyonight-night")

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi("Comment gui=none")
    -- end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },

  -- Highlight todo, notes, etc in comments
  {
    "maxmx03/solarized.nvim",
    lazy = true,
    config = function()
      require("solarized").setup {
        theme = "neo", -- or comment to use solarized default theme.
        -- pallete = "solarized",
        colors = function(colors, colorhelper)
          local darken = colorhelper.darken
          local lighten = colorhelper.lighten
          local blend = colorhelper.blend

          return {
            -- base01 = lighten(colors.base01, 50),
            base02 = lighten(colors.base02, 5),
            base00 = lighten(colors.base00, 20),
            -- base0 = lighten(colors.base0, 20),
            -- base1 = lighten(colors.base1, 20),
            -- base2 = lighten(colors.base2, 20),
            -- base3 = lighten(colors.base3, 20),
            green = lighten(colors.green, 20),
            red = lighten(colors.red, 20),
            cyan = lighten(colors.cyan, 20),
            blue = lighten(colors.blue, 20),
            yellow = lighten(colors.yellow, 20),
          }
        end,
        highlights = function(colors, colorhelper)
          local darken = colorhelper.darken
          local lighten = colorhelper.lighten
          local blend = colorhelper.blend
          local c = colors
          return {
            Normal = { fg = c.base3 },
            -- LineNr = { fg = c.base1, bg = c.base02 },
            -- CursorLineNr = { bg = lighten(c.base03, 10) },
            CursorLine = { bg = lighten(c.base03, 10) },
            Visual = { bg = darken(c.base03, 30) },
            IblScope = { fg = c.base1, bg = "NONE" },
            IblIndent = { fg = c.base02, bg = "NONE" },
            b = { bg = c.base01 },
            FloatBorder = { bg = "NONE" },
            NormalFloat = { fg = c.base3 },
            -- PmenuThumb = { fg = c.yellow, bg = c.yellow },
            -- Function = { italic = false },
            -- Visual = { bg = c.base02 },
          }
        end,
      }
    end,
  },
  -- {
  --   "shaunsingh/solarized.nvim",
  -- },
  {
    "luisiacc/gruvbox-baby",
    lazy = true,
    config = function()
      -- vim.g.gruvbox_baby_keyword_style = "normal"
      -- vim.g.gruvbox_baby_use_original_palette = "true"
      vim.g.gruvbox_baby_background_color = "medium"
      vim.g.gruvbox_baby_highlights = {
        Normal = { fg = "#fbf1c7", bg = "#1d2021", style = "NONE" },
        SignColumn = { fg = "None", bg = "#1d2021", style = "NONE" },
        TelescopeSelection = { fg = "#fbf1c7", bg = "#504945", style = "NONE" },
        Underlined = { fg = "#7fa2ac", bg = "NONE", style = "underline" },
        -- IblScope = { fg = "#928374", bg = "NONE", style = "NONE" },
        IblScope = { fg = "#a89984", bg = "NONE", style = "NONE" },
        IblIndent = { fg = "#504945", bg = "NONE", style = "NONE" },
      }
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      -- Default options:
      require("gruvbox").setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = false, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          Normal = { bg = "#1d2021" }, -- explicitly set Normal background color
          SignColumn = { bg = "#1d2021" }, -- explicitly set Normal background color
        },
        dim_inactive = false,
        transparent_mode = true,
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        overrides = function(colors)
          return {
            -- Assign a static color to strings
            -- String = { fg = colors.palette.carpYellow, italic = true },
            -- theme colors will update dynamically when you change theme!
            -- SomePluginHl = { fg = colors.theme.syn.type, bold = true },
            SignColumn = { bg = colors.palette.sumiInk3 },
            CursorLineNr = { bg = colors.palette.sumiInk3 },
            Visual = { bg = colors.palette.sumiInk6 },
            LineNr = { bg = colors.palette.sumiInk3 },
          }
        end,
      }
    end,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    config = function()
      local colors = require "ayu.colors"
      colors.generate(true) -- Pass `true` to enable mirage

      require("ayu").setup {
        overrides = {
          IblScope = { fg = colors.fg },
        },
      }
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
        highlight_groups = {
          TelescopeSelection = { fg = "gold", bg = "overlay" },
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },
      }
    end,
  },
}
