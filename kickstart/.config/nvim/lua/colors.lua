return {
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
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
    config = function()
      require("tokyonight").setup {
        on_highlights = function(hl, c)
          hl.TelescopeSelection = {
            bg = c.blue0,
          }
        end,
      }
    end,
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
  {
    "neanias/everforest-nvim",
    lazy = true,
    -- version = false,
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup {

        background = "hard",
        on_highlights = function(hl, palette)
          hl.LeapMatch = { fg = palette.yellow, bg = palette.yellow }
          hl.LeapLabelPrimary = { fg = palette.bg0, bg = palette.yellow, bold = true }
        end,
      }
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    "maxmx03/solarized.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("solarized").setup {

        styles = {
          enabled = true,
          -- types = { italic = true },
          -- functions = { bold = true },
          parameters = { italic = false },
          comments = { italic = true },
          strings = {},
          keywords = { bold = false },
          variables = {},
          constants = { bold = true },
        },
        -- theme = "neo", -- or comment to use solarized default theme.
        variant = "autumn",
        pallete = "solarized",
        on_colors = function(colors, colorhelper)
          local darken = colorhelper.darken
          local lighten = colorhelper.lighten
          local blend = colorhelper.blend

          return {
            -- base01 = lighten(colors.base01, 50),
            -- base02 = lighten(colors.base02, 5),
            -- base00 = lighten(colors.base00, 20),
            -- base0 = lighten(colors.base0, 20),
            -- base1 = lighten(colors.base1, 20),
            -- base2 = lighten(colors.base2, 20),
            -- base3 = lighten(colors.base3, 20),
            -- green = lighten(colors.green, 20),
            -- red = lighten(colors.red, 20),
            -- cyan = lighten(colors.cyan, 20),
            -- blue = lighten(colors.blue, 20),
            -- yellow = lighten(colors.yellow, 20),
          }
        end,

        on_highlights = function(colors, colorhelper)
          local darken = colorhelper.darken
          local lighten = colorhelper.lighten
          local blend = colorhelper.blend

          ---@type solarized.highlights
          local groups = {
            Normal = { fg = colors.base00 },
            -- LineNr = { fg = c.base1, bg = c.base02 },
            -- CursorLineNr = { bg = lighten(c.base03, 10) },
            CursorLine = { bg = lighten(colors.base03, 10) },
            Visual = { bg = darken(colors.base03, 30) },
            IblScope = { fg = colors.base1, bg = "NONE" },
            IblIndent = { fg = colors.base02, bg = "NONE" },
            b = { bg = colors.base01 },
            FloatBorder = { bg = "NONE" },
            NormalFloat = { fg = colors.base3 },
            SignColumn = { bg = colors.base03 },
            ColorColumn = { bg = colors.base03 },
            RenderMarkdownLink = { fg = colors.cyan },
            LineNr = { bg = colors.base03 },
            LeapMatch = { fg = colors.yellow },
            LeapLabelPrimary = { fg = colors.base03, bg = colors.yellow },
            Function = { fg = colors.cyan },
            Constant = { fg = colors.orange },
            String = { fg = colors.green },
            Keyword = { fg = colors.yellow },
            Variable = { fg = colors.base1 },
            -- Character = { fg = colors.base1 },
            Special = { fg = colors.blue },
            Identifier = { fg = colors.blue },
            Parameter = { fg = colors.magenta },
            -- Character = { fg = colors.magenta },
            -- PmenuThumb = { fg = colors.yellow, bg = colors.yellow },
            -- Visual = { bg = c.base02 },
          }
          return groups
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
      -- vim.g.gruvbox_baby_telescope_theme = 1
      vim.g.gruvbox_baby_keyword_style = "NONE"
      vim.g.gruvbox_baby_use_original_palette = true
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_background_color = "soft"
      vim.g.gruvbox_baby_highlights = {
        -- Normal = { fg = "#fbf1c7", bg = "#1d2021", style = "NONE" },
        -- Normal = { fg = "#ebdbb2", bg = "#1d2021", style = "NONE" },
        SignColumn = { fg = "None", bg = "NONE", style = "NONE" },
        TelescopeSelection = { fg = "#ebdbb2", bg = "#504945", style = "NONE" },
        Underlined = { fg = "#7fa2ac", bg = "NONE", style = "underline" },
        FlashCurrent = { fg = "NONE", bg = "#d65d0e", style = "NONE" },
        LeapMatch = { fg = "#fabd2f", bg = "#fabd2f", style = "bold" },
        LeapLabelPrimary = { fg = "#1d2021", bg = "#fabd2f", style = "bold" },
        WinSeparator = { fg = "#32392f", bg = "NONE", style = "NONE" },
        IblScope = { fg = "#928374", bg = "NONE", style = "NONE" },
        IblIndent = { fg = "#504945", bg = "NONE", style = "NONE" },
        LeapBackdrop = { fg = "#928374", bg = "NONE", style = "NONE" },
        FloatBorder = { fg = "#504945", bg = "#242424", style = "NONE" },
        RenderMarkdownH1Bg = { fg = "#282828", bg = "#fb4934", style = "bold" },
        RenderMarkdownH2Bg = { fg = "#282828", bg = "#fabd35", style = "bold" },
        RenderMarkdownH3Bg = { fg = "#282828", bg = "#d4879c", style = "bold" },
        RenderMarkdownH4Bg = { fg = "#282828", bg = "#8ec07c", style = "bold" },
        RenderMarkdownH5Bg = { fg = "#282828", bg = "#7fa2ac", style = "bold" },
        RenderMarkdownH6Bg = { fg = "#282828", bg = "#98971a", style = "bold" },
        SnacksPickerBoxBorder = { fg = "#504945", bg = "#282626", style = "bold" },
        SnacksPickerListBorder = { fg = "#504945", bg = "#282626", style = "bold" },
        SnacksPickerPreviewBorder = { fg = "#504945", bg = "#282626", style = "bold" },
        SnacksPickerInputBorder = { fg = "#504945", bg = "#282626", style = "bold" },
        DiagnosticUnderlineError = { fg = "NONE", bg = "NONE", style = "underline", sp = "#fb4934" },
        ContextLine = { fg = "NONE", bg = "NONE", style = "underline", sp = "#928374" },
        Normal = { fg = "#ebdbb2", bg = "#282828", style = "NONE" },
        CmpSel = { fg = "#282828", bg = "#7fa2ac", style = "NONE" },
        CmpBorder = { fg = "#504845", bg = "#282626", style = "NONE" },
        CmpDocBorder = { fg = "#504845", bg = "#282626", style = "NONE" },
        CmpPmenu = { fg = "#504845", bg = "#282626", style = "NONE" },
        CmpDoc = { fg = "#504845", bg = "#282626", style = "NONE" },
        CmpScrollBar = { fg = "#504845", bg = "#282626", style = "NONE" },
        FloatBorder = { fg = "#504845", bg = "#282626", style = "NONE" },
        -- SnacksPickerBoxBorder = { fg = "NONE", bg = "NONE", style = "NONE" },
        -- SnacksPickerInputBorder = { fg = "NONE", bg = "NONE", style = "NONE" },
        -- SnacksPickerListBorder = { fg = "NONE", bg = "NONE", style = "NONE" },
        -- SnacksPickerPreviewBorder = { fg = "NONE", bg = "NONE", style = "NONE" },

        -- RenderMarkdownH1Bg = { fg = "#fb4934", bg = "NONE", style = "bold" },
        -- RenderMarkdownH2Bg = { fg = "#fabd35", bg = "NONE", style = "bold" },
        -- RenderMarkdownH3Bg = { fg = "#d4879c", bg = "NONE", style = "bold" },
        -- RenderMarkdownH4Bg = { fg = "#8ec07c", bg = "NONE", style = "bold" },
        -- RenderMarkdownH5Bg = { fg = "#7fa2ac", bg = "NONE", style = "bold" },
        -- RenderMarkdownH6Bg = { fg = "#98971a", bg = "NONE", style = "bold" },
        -- RenderMarkdownH6 = { fg = "", bg = "", style = "" },
        -- RenderMarkdownH5 = { fg = "", bg = "", style = "" },
        -- RenderMarkdownH4 = { fg = "", bg = "", style = "" },
        -- RenderMarkdownH2 = { fg = "", bg = "", style = "" },
        -- RenderMarkdownH2 = { fg = "", bg = "", style = "" },
        -- RenderMarkdownH1 = { fg = "#1d2021", bg = "#d65d0e", style = "NONE" },
      }
      -- vim.api.nvim_create_autocmd("ColorScheme", {
      --   pattern = "*",
      --   callback = function()
      --     vim.api.nvim_set_hl(0, "@comment", { fg = "#504945", bg = "NONE", italic = true })
      --   end,
      -- })
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
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          -- Normal = { bg = "#1d2021" }, -- explicitly set Normal background color
          -- SignColumn = { bg = "#1d2021" }, -- explicitly set Normal background color
          -- SignColumn = { bg = "#1d2021" }, -- explicitly set Normal background color
        },
        dim_inactive = false,
        transparent_mode = true,
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
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
    lazy = true,
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
