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
      vim.g.terminal_color_0 = "#2b3339" -- black
      vim.g.terminal_color_1 = "#e67e80" -- red
      vim.g.terminal_color_2 = "#a7c080" -- green
      vim.g.terminal_color_3 = "#dbbc7f" -- yellow
      vim.g.terminal_color_4 = "#7fbbb3" -- blue
      vim.g.terminal_color_5 = "#d699b6" -- magenta
      vim.g.terminal_color_6 = "#83c092" -- cyan
      vim.g.terminal_color_7 = "#d3c6aa" -- white
      vim.g.terminal_color_8 = "#7a8478" -- bright black (gray)
      vim.g.terminal_color_9 = "#e67e80"
      vim.g.terminal_color_10 = "#a7c080"
      vim.g.terminal_color_11 = "#dbbc7f"
      vim.g.terminal_color_12 = "#7fbbb3"
      vim.g.terminal_color_13 = "#d699b6"
      vim.g.terminal_color_14 = "#83c092"
      vim.g.terminal_color_15 = "#d3c6aa"
      require("everforest").setup {

        background = "hard",
        on_highlights = function(hl, palette)
          hl.Normal = { fg = palette.fg, bg = palette.bg0 }
          hl.LeapMatch = { fg = palette.yellow, bg = palette.yellow }
          hl.LeapLabelPrimary = { fg = palette.bg0, bg = palette.yellow, bold = true }
          hl.CursorColumn = { fg = palette.fg, bg = palette.bg3, bold = true }
          hl.NormalFloat = { fg = palette.fg, bg = palette.bg1, bold = true }
          hl.CursorLine = { fg = palette.fg, bg = palette.bg2 }
          hl.Terminal = { fg = palette.bg, bg = palette.fg }
        end,
      }
    end,
  },
  -- {
  --   "sainnhe/everforest",
  --   config = function()
  --     vim.api.nvim_set_hl(0, "Normal", { fg = "#d3c6aa", bg = "#2b3339" })
  --     vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#dbbc7f", bg = "#dbbc7f" })
  --     vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#2b3339", bg = "#dbbc7f", bold = true })
  --     vim.api.nvim_set_hl(0, "CursorColumn", { fg = "#d3c6aa", bg = "#3c4841", bold = true })
  --     vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#d3c6aa", bg = "#323d3f", bold = true })
  --     vim.api.nvim_set_hl(0, "CursorLine", { fg = "#d3c6aa", bg = "#3a4647" })
  --     vim.g.everforest_enable_italic = true
  --   end,
  -- },
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
        theme = "neo", -- or comment to use solarized default theme.
        variant = "summer",
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
            -- Normal = { fg = colors.base00 },
            -- LineNr = { fg = c.base1, bg = c.base02 },
            CursorLineNr = { bg = colors.base03 },
            CursorLine = { bg = lighten(colors.base03, 10) },
            WinSeparator = { bg = colors.base03 },
            SnacksPickerTree = { bg = colors.base04 },
            SnacksPickerCol = { bg = colors.base04 },
            -- Visual = { bg = darken(colors.base03, 30) },
            -- IblScope = { fg = colors.base1, bg = "NONE" },
            -- IblIndent = { fg = colors.base02, bg = "NONE" },
            -- b = { bg = colors.base01 },
            -- FloatBorder = { bg = "NONE" },
            -- NormalFloat = { fg = colors.base3 },
            -- SignColumn = { bg = colors.base03 },
            -- ColorColumn = { bg = colors.base0, fg = colors.base03 },
            -- LineNr = { bg = colors.base03 },
            -- LeapMatch = { fg = colors.yellow },
            -- LeapLabelPrimary = { fg = colors.base03, bg = colors.yellow },
            -- Function = { fg = colors.cyan },
            -- Constant = { fg = colors.orange },
            -- String = { fg = colors.green },
            -- Keyword = { fg = colors.yellow },
            -- Variable = { fg = colors.base1 },
            -- -- Character = { fg = colors.base1 },
            -- Special = { fg = colors.blue },
            -- Identifier = { fg = colors.blue },
            -- Parameter = { fg = colors.magenta },
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
      -- vim.g.gruvbox_baby_background_color = "hard"
      vim.g.gruvbox_baby_highlights = {
        -- Normal = { fg = "#fbf1c7", bg = "#1d2021", style = "NONE" },
        -- Normal = { fg = "#ebdbb2", bg = "#1d2021", style = "NONE" },
        TelescopeSelection = { fg = "#ebdbb2", bg = "#504945", style = "NONE" },
        Underlined = { fg = "#7fa2ac", bg = "NONE", style = "underline" },
        WinSeparator = { fg = "#32392f", bg = "NONE", style = "NONE" },
        SnacksIndentScope = { fg = "#928374", bg = "NONE", style = "NONE" },
        SnacksIndent = { fg = "#504945", bg = "NONE", style = "NONE" },
        RenderMarkdownH1Bg = { fg = "#282828", bg = "#fb4934", style = "bold" },
        RenderMarkdownH2Bg = { fg = "#282828", bg = "#fabd35", style = "bold" },
        RenderMarkdownH3Bg = { fg = "#282828", bg = "#d4879c", style = "bold" },
        RenderMarkdownH4Bg = { fg = "#282828", bg = "#8ec07c", style = "bold" },
        RenderMarkdownH5Bg = { fg = "#282828", bg = "#7fa2ac", style = "bold" },
        RenderMarkdownH6Bg = { fg = "#282828", bg = "#98971a", style = "bold" },
        Normal = { fg = "#ebdbb2", bg = "#282828", style = "NONE" },
        TelescopeNormal = { fg = "NONE", bg = "#282626", style = "NONE" },
        TelescopeBorder = { fg = "#504845", bg = "#282626", style = "NONE" },
        TelescopeTitle = { fg = "#282626", bg = "#98971a", style = "bold" },
        DiagnosticUnderlineError = { sp = "#fb4934", style = "undercurl" },

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
          emphasis = true,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        -- contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          -- Normal = { bg = "#1d2021" }, -- explicitly set Normal background color
          -- Normal = { bg = "#282828" }, -- explicitly set Normal background color
          NormalFloat = { bg = "#282626" }, -- explicitly set Normal background color
          -- CursorColumn = { bg = "#504945" },
          -- SignColumn = { bg = "#1d2021" },
          ErrorMsg = { link = "GruvboxRed" },
          WarningMsg = { link = "GruvboxYellow" },
          DiagnosticSignError = { link = "GruvboxRed" },
          DiagnosticSignWarn = { link = "GruvboxYellow" },
          DiagnosticSignHint = { link = "GruvboxAqua" },
          DiagnosticSignInfo = { link = "GruvboxBlue" },
          DiagnosticSignOk = { link = "GruvboxGreen" },

          RenderMarkdownH1Bg = { fg = "#282828", bg = "#fb4934", bold = true },
          RenderMarkdownH2Bg = { fg = "#282828", bg = "#fabd35", bold = true },
          RenderMarkdownH3Bg = { fg = "#282828", bg = "#d4879c", bold = true },
          RenderMarkdownH4Bg = { fg = "#282828", bg = "#8ec07c", bold = true },
          RenderMarkdownH5Bg = { fg = "#282828", bg = "#7fa2ac", bold = true },
          RenderMarkdownH6Bg = { fg = "#282828", bg = "#98971a", bold = true },

          TelescopeBorder = { fg = "#504845", bg = "#282626" },
          TelescopeNormal = { fg = "#504845", bg = "#282626" },
          TelescopeTitle = { fg = "#282626", bg = "#98971a", bold = true },
          TelescopeSelection = { fg = "#ebdbb2", bg = "#504945" },

          WinSeparator = { fg = "#32392f", bg = "NONE" },
          SnacksIndentScope = { fg = "#928374", bg = "NONE" },
          -- SnacksIndent = { fg = "#504945", bg = "NONE" },

          CursorLineNr = { fg = "#ebdbb2", bg = "#282828", bold = true },
        },
        dim_inactive = false,
        transparent_mode = false,
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
            -- CursorLineNr = { bg = colors.palette.sumiInk2 },
            -- Visual = { bg = colors.palette.sumiInk6 },
            LineNr = { bg = colors.palette.sumiInk0, fg = colors.palette.sumiInk4 },
            LineNrAbove = { bg = colors.palette.sumiInk3, fg = colors.palette.springViolet1 },
            LineNrBelow = { bg = colors.palette.sumiInk3, fg = colors.palette.springViolet1 },
            SnacksPickerCol = { bg = colors.palette.sumiInk0, fg = colors.palette.sumiInk4 },
            SnacksPickerTree = { bg = colors.palette.sumiInk0, fg = colors.palette.sumiInk4 },
          }
        end,
      }
    end,
  },
  {
    "gbprod/nord.nvim",
    lazy = true,
    config = function()
      require("nord").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
        borders = true, -- Enable the border between verticaly split windows visible
        errors = { mode = "bg" }, -- Display mode for errors and diagnostics
        -- values : [bg|fg|none]
        search = { theme = "vim" }, -- theme for highlighting search results
        -- values : [vim|vscode]
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},

          -- To customize lualine/bufferline
          bufferline = {
            current = {},
            modified = { italic = true },
          },
        },

        -- colorblind mode
        -- see https://github.com/EdenEast/nightfox.nvim#colorblind
        -- simulation mode has not been implemented yet.
        colorblind = {
          enable = false,
          preserve_background = false,
          severity = {
            protan = 0.0,
            deutan = 0.0,
            tritan = 0.0,
          },
        },

        -- Override the default colors
        ---@param colors Nord.Palette
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with all highlights and the colorScheme table
        ---@param colors Nord.Palette
        on_highlights = function(highlights, colors)
          highlights.NormalFloat = {
            bg = colors.polar_night.origin,
          }
          highlights.CursorColumn = {
            bg = colors.polar_night.light,
          }
          highlights.CursorLine = {
            bg = colors.polar_night.bright,
          }

          highlights.SnacksPickerListCursorLine = {
            -- bg = colors.polar_night.brightest,
            bg = colors.frost.artic_ocean,
            fg = colors.snow_storm.brightest,
          }
        end,
      }
    end,
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
          Normal = { bg = "#0a0e14" },
          NormalFloat = { bg = colors.black },
          -- ColorColumn = { bg = "None" },
          -- SignColumn = { bg = "None" },
          -- Folded = { bg = "None" },
          -- FoldColumn = { bg = "None" },
          -- CursorLine = { bg = "None" },
          -- CursorColumn = { bg = "None" },
          -- VertSplit = { bg = "None" },
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
          legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
        highlight_groups = {
          TelescopeSelection = { fg = "gold", bg = "overlay" },
          SnacksIndent = { fg = "highlight_med" },
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },
      }
    end,
  },
}
