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
        latex = {
          enabled = false,
        },
        paragraph = {
          enabled = false,
          left_margin = 0.5,
          min_width = 30,
        },
        win_options = {
          -- See :h 'conceallevel'
          conceallevel = {
            -- Used when not being rendered, get user setting
            default = vim.api.nvim_get_option_value("conceallevel", {}),
            -- default = 1,
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
          enabled = true,
          -- width = "block",
          width = "full",
          -- Amount of padding to add to the left of headings
          left_pad = 0,
          -- Amount of padding to add to the right of headings when width is 'block'
          right_pad = 3,
          -- Minimum width to use for headings when width is 'block'
          min_width = 0,
          -- Determines how the icon fills the available space:
          --  inline:  underlying '#'s are concealed resulting in a left aligned icon
          --  overlay: result is left padded with spaces to hide any additional '#'
          position = "inline",

          -- Replaces '#+' of 'atx_h._marker'
          -- The number of '#' in the heading determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- The result is left padded with spaces to hide any additional '#'
          -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          -- icons = { "󰫎 ", " ", " ", "󰠖 ", "✸ ", " " },
          icons = { "󰪥 ", "🞇 ", " ", "󰠖 ", "✸ ", " " },
          -- icons = { "", "", "", "", "", "" },
          -- Added to the sign column⭗
          -- The 'level' is used to index into the array using a cycle
          -- signs = { '󰫎 ' },
          sign = false,
          -- signs = { "󰪥 ", "🞇 ", " ", "󰠖 ", "✸ ", " " },
          -- signs = { "󰐣 " },
          -- signs = { "󰶻 󰐣" },
          -- signs = { "󰫎 ", " ", " ", "󰠖 ", "✸ ", " " },
          signs = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          border = false,
          -- Highlight the start of the border using the foreground highlight
          border_prefix = false,
          -- Used above heading for border
          above = "▄",
          -- Used below heading for border
          below = "▀",
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading icon and extends through the entire line
          -- backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
          backgrounds = {
            "Bold",
            "Number",
            "CmpItemKind",
            "CmpItemKindConstant",
            "Added",
            "Changed",
          },
          -- backgrounds = {
          -- "RenderMarkdownH1Bg",
          -- "RenderMarkdownH2Bg",
          -- "RenderMarkdownH3Bg",
          -- "RenderMarkdownH4Bg",
          -- "RenderMarkdownH5Bg",
          -- "RenderMarkdownH6Bg",
          -- },
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading and sign icons
          foregrounds = {
            "RenderMarkdownH5",
            "Number",
            "CmpItemKind",
            "CmpItemKindConstant",
            "Added",
            "Changed",
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
          icons = { "•" },
          -- icons = { '• ', ' ', '◆ ', '◇ ' },
          -- Highlight for the bullet icon
          highlight = "Normal",
        },
        checkbox = {
          unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'
            icon = "󰄱 ",
            -- Highlight for the unchecked icon
            highlight = "@neorg.todo_items.undone",
          },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'
            icon = " ",
            -- icon = '󰱒 ',
            -- Highligh for the checked icon
            highlight = "",
          },
          -- Define custom checkbox states, more involved as they are not part of the markdown grammar
          -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
          -- Can specify as many additional states as you like following the 'todo' pattern below
          --   The key in this case 'todo' is for healthcheck and to allow users to change its values
          --   'raw': Matched against the raw text of a 'shortcut_link'
          --   'rendered': Replaces the 'raw' value when rendering
          --   'highlight': Highlight for the 'rendered' icon
          custom = {
            -- pending = { raw = "[>]", rendered = "• 󰥔 ", highlight = "@neorg.todo_items.pending" },
            cancelled = { raw = "[~]", rendered = "󰰱 ", highlight = "@neorg.todo_items.cancelled" },
            urgent = { raw = "[!]", rendered = " ", highlight = "@neorg.todo_items.urgent" },
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
        -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
        -- level of the heading. Indenting starts from level 2 headings onward.
        indent = {
          -- Turn on / off org-indent-mode
          enabled = false,
          -- Amount of additional padding added for each heading level
          per_level = 2,
          -- Heading levels <= this value will not be indented
          -- Use 0 to begin indenting from the very first level
          skip_level = 1,
          -- Do not indent heading titles, only the body
          skip_heading = true,
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
          style = "full",
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
        link = {
          -- Turn on / off inline link icon rendering
          enabled = true,
          -- Inlined with 'image' elements
          image = "󰥶 ",
          -- Fallback icon for 'inline_link' elements
          -- hyperlink = "󰌹 ",
          hyperlink = "",
          -- Applies to the fallback inlined icon
          highlight = "RenderMarkdownLink",
          wiki = { icon = "", highlight = "RenderMarkdownWikiLink" },
          -- Define custom destination patterns so icons can quickly inform you of what a link
          -- contains. Applies to 'inline_link' and wikilink nodes.
          -- Can specify as many additional values as you like following the 'web' pattern below
          --   The key in this case 'web' is for healthcheck and to allow users to change its values
          --   'pattern':   Matched against the destination text see :h lua-pattern
          --   'icon':      Gets inlined before the link text
          --   'highlight': Highlight for the 'icon'
          custom = {
            web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
          },
        },
      }
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
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
  {
    "jbyuki/nabla.nvim",
    lazy = false,
    -- ft = "markdown",
    -- config = function()
    --   require("nabla").enable_virt()
    -- end,
    vim.api.nvim_set_keymap(
      "n",
      "<M-m>",
      [[:lua require("nabla").popup({border = 'single'})<CR>]],
      { noremap = true, silent = true }
    ),
  },

  -- {
  --   "lervag/vimtex",
  --   lazy = false, -- we don't want to lazy load VimTeX
  --   -- tag = "v2.15", -- uncomment to pin to a specific release
  --   init = function()
  --     -- VimTeX configuration goes here, e.g.
  --     vim.g.vimtex_view_method = "zathura"
  --   end,
  -- },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true, -- or `opts = {}`
  -- },
}
