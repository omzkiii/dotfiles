return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- commit = "81566202651c4a65cd19d2b7353ca6a1eee34448",
    ft = "markdown",
    -- lazy = true,
    -- event = "VeryLazy",
    -- enabled = true,
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    -- dependencies = { 'nvim-treesitter/nvim-treesitter' },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup {
        win_options = {
          -- See :h 'conceallevel'
          conceallevel = {
            -- Used when not being rendered, get user setting
            -- default = vim.api.nvim_get_option_value('conceallevel', {}),
            default = 3,
            -- Used when being rendered, concealed text is completely hidden
            rendered = 3,
          },
          -- See :h 'concealcursor'
          concealcursor = {
            -- Used when not being rendered, get user setting
            -- default = vim.api.nvim_get_option_value('concealcursor', {}),
            default = "",
            -- Used when being rendered, conceal text in all modes
            rendered = "",
          },
        },
        heading = {
          -- Replaces '#+' of 'atx_h._marker'
          -- The number of '#' in the heading determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- The result is left padded with spaces to hide any additional '#'
          -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          icons = { "󰫎 ", " ", " ", "󰠖 ", "✸ ", " " },
          -- icons = { " ", " ", " ", "󰠖 ", "✸ ", " " },
          -- Added to the sign column
          -- The 'level' is used to index into the array using a cycle
          -- signs = { '󰫎 ' },
          -- signs = { "󰫎 ", " ", " ", "󰠖 ", "✸ ", " " },
          signs = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading icon and extends through the entire line
          -- backgrounds = { 'DiffAdd', 'DiffChange', 'DiffDelete' },
          backgrounds = {
            "RenderMarkdownH5",
            "Added",
            "Changed",
            "Number",
            "CmpItemKind",
            "Boolean",
          },
          -- backgrounds = {
          --   "RenderMarkdownH5",
          --   "Number",
          --   "Function",
          --   "CmpItemKindClass",
          --   "CmpItemKindEnum",
          --   "Boolean",
          -- },
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading and sign icons
          foregrounds = {
            "RenderMarkdownH5",
            "Added",
            "Changed",
            "Number",
            "CmpItemKind",
            "Boolean",
          },
          -- foregrounds = {
          --   "RenderMarkdownH6",
          --   "RenderMarkdownH5",
          --   "RenderMarkdownH4",
          --   "RenderMarkdownH3",
          --   "RenderMarkdownH2",
          --   "RenderMarkdownH1",
          -- },
        },
        bullet = {
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { "•", "", "◆", "◇" },
          -- icons = { '• ', ' ', '◆ ', '◇ ' },
          -- Highlight for the bullet icon
          highlight = "Normal",
        },
        checkbox = {
          unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'
            icon = "󰄱 ",
            -- Highlight for the unchecked icon
            highlight = "@markup.list.unchecked",
          },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'
            icon = " ",
            -- icon = '󰱒 ',
            -- Highligh for the checked icon
            highlight = "@markup.heading",
          },
          -- Define custom checkbox states, more involved as they are not part of the markdown grammar
          -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
          -- Can specify as many additional states as you like following the 'todo' pattern below
          --   The key in this case 'todo' is for healthcheck and to allow users to change its values
          --   'raw': Matched against the raw text of a 'shortcut_link'
          --   'rendered': Replaces the 'raw' value when rendering
          --   'highlight': Highlight for the 'rendered' icon
          custom = {
            todo = { raw = "[>]", rendered = "󰥔 ", highlight = "@markup.raw" },
          },
        },
        callout = {
          note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "DiagnosticInfo" },
          tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "DiagnosticOk" },
          important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "DiagnosticHint" },
          warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "DiagnosticWarn" },
          caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "DiagnosticError" },
          -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
          abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "DiagnosticInfo" },
          todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "DiagnosticInfo" },
          success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "DiagnosticOk" },
          question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "DiagnosticWarn" },
          failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "DiagnosticError" },
          danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "DiagnosticError" },
          bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "DiagnosticError" },
          example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "DiagnosticHint" },
          quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "@markup.quote" },
        },
        code = {
          -- Turn on / off code block & inline code rendering
          enabled = true,
          -- Turn on / off any sign column related rendering
          sign = false,
          -- Determines how code blocks & inline code are rendered:
          --  none: disables all rendering
          --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
          --  language: adds language icon to sign column if enabled and icon + name above code blocks
          --  full: normal + language
          style = "language",
          -- Amount of padding to add to the left of code blocks
          left_pad = 0,
          -- Amount of padding to add to the right of code blocks when width is 'block'
          right_pad = 2,
          -- Width of the code block background:
          --  block: width of the code block
          --  full: full width of the window
          width = "block",
          -- Determins how the top / bottom of code block are rendered:
          --  thick: use the same highlight as the code body
          --  thin: when lines are empty overlay the above & below icons
          border = "thick",
          -- Used above code blocks for thin border
          above = "▄",
          -- Used below code blocks for thin border
          below = "▀",
          -- Highlight for code blocks & inline code
          highlight = "RenderMarkdownCode",
          highlight_inline = "RenderMarkdownCodeInline",
        },
      }
    end,
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     -- You will not need this if you installed the
  --     -- parsers manually
  --     -- Or if the parsers are in your $RUNTIMEPATH
  --     "nvim-treesitter/nvim-treesitter",
  --
  --     "nvim-tree/nvim-web-devicons",
  --     code_blocks = {
  --       style = "minimal",
  --       position = nil,
  --       min_width = 70,
  --
  --       pad_amount = 3,
  --       pad_char = " ",
  --
  --       language_direction = "left",
  --       language_names = {},
  --
  --       hl = "CursorLine",
  --
  --       sign = true,
  --       sign_hl = nil,
  --     },
  --   },
  -- },
  {
    "preservim/vim-markdown",
    ft = "markdown",
  },
}
