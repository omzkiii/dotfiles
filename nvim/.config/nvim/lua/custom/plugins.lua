local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  -- {"nvim-neorg/neorg",lazy = false},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false;
    configs = function ()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    'alexghergh/nvim-tmux-navigation',
    lazy = false,
    config = function()
    local nvim_tmux_nav = require('nvim-tmux-navigation')

    nvim_tmux_nav.setup {
      disable_when_zoomed = true -- defaults to false
    }

    vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
    vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
    vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
    vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
    vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
    vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

  end
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Notes/Notes/",
        },
      },
      ui = {
        enable = false,  -- set to false to disable all additional syntax features
        update_debounce = 200,  -- update delay after a text change (in milliseconds)
        max_file_length = 5000,  -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },
      -- Set to false to disable completion.
      nvim_cmp = true,

      -- Trigger completion at 2 chars.
      min_chars = 2,

      -- Where to put new notes created from completion. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "current_dir",

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",

      -- Control how wiki links are completed with these (mutually exclusive) options:
      --
      -- 1. Whether to add the note ID during completion.
      -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
      -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
      prepend_note_id = true,
      -- 2. Whether to add the note path during completion.
      -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
      -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
      prepend_note_path = false,
      -- 3. Whether to only use paths during completion.
      -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
      -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
      use_path_only = false,
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      disable_frontmatter = true,
      finder = "telescope.nvim",
      finder_mappings = {
        -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
        -- Currently only telescope supports this.
        new = "<C-x>",
      },
      -- see below for full list of options 👇
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Notes/Excerpts",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          enable = false,
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        cursor = {
          -- Animate for 200 milliseconds with linear easing
          timing = animate.gen_timing.cubic({ duration = 20, unit = 'total' }),

          -- Animate with shortest line for any cursor move
          path = animate.gen_path.line({
            predicate = function() return true end,
          }),
        },
      }
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    lazy = true,
    ft = "python",
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      name = "env",
      auto_refresh = true,
      stay_on_this_version = true,
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- ft = "*",
    opts = function()
      return require "custom.configs.null-ls"
    end
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = true, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus' 
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = true }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+7", -- font size increment
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
      end,
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      { '<C-S-Z>', '<cmd>ZenMode<cr>' },
    },
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    -- lazy = true,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
        { desc = "Harpoon add" })
      -- vim.keymap.set("n", "<M-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>1", function() harpoon:list():replace_at(1) end,
        { desc = "Harpoon in 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():replace_at(2) end,
        { desc = "Harpoon in 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():replace_at(3) end,
        { desc = "Harpoon in 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():replace_at(4) end,
        { desc = "Harpoon in 4" })
      vim.keymap.set("n", "<leader>5", function() harpoon:list():replace_at(4) end,
        { desc = "Harpoon in 5" })

      vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end,
        { desc = "Harpoon to 1" })
      vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end,
        { desc = "Harpoon to 2" })
      vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end,
        { desc = "Harpoon to 3" })
      vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end,
        { desc = "Harpoon to 4" })
      vim.keymap.set("n", "<M-5>", function() harpoon:list():select(4) end,
        { desc = "Harpoon to 5" })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<M-->", function() harpoon:list():prev() end,
        { desc = "Harpoon prev" })
      vim.keymap.set("n", "<M-=>", function() harpoon:list():next() end,
        { desc = "Harpoon next" })

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers").new({}, {
            initial_mode = "normal",
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          }):find()
        end

        vim.keymap.set("n", "<M-e>", function() toggle_telescope(harpoon:list()) end,
          { desc = "Open harpoon window" })
    end
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    event = "VeryLazy",
    -- lazy = false,
    config = function()
      -- default config
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 25,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      })
      -- ...
    end
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    ft = "markdown",
    lazy = true,
    -- event = "VeryLazy",
    -- enabled = true,
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    -- dependencies = { 'nvim-treesitter/nvim-treesitter' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
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
          signs = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading icon and extends through the entire line
          -- backgrounds = { 'DiffAdd', 'DiffChange', 'DiffDelete' },
          backgrounds = { 'DiffAdd', 'String', 'DiagnosticWarn', 'Number', 'Keyword', 'DiffDelete' },
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading and sign icons
          foregrounds = { 'DiffAdd', 'String', 'DiagnosticWarn', 'Number', 'Keyword', 'DiffDelete' },
          -- foregrounds = { 'markdownH1', 'markdownH2', 'markdownH3', 'markdownH4', 'markdownH5', 'markdownH6' },
        },
        bullet = {
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { '•', '', '◆', '◇' },
          -- icons = { '• ', ' ', '◆ ', '◇ ' },
          -- Highlight for the bullet icon
          highlight = 'Normal',
        },
        checkbox = {
          unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'
            icon = '󰄱 ',
            -- Highlight for the unchecked icon
            highlight = '@markup.list.unchecked',
          },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'
            icon = ' ',
            -- icon = '󰱒 ',
            -- Highligh for the checked icon
            highlight = '@markup.heading',
          },
          -- Define custom checkbox states, more involved as they are not part of the markdown grammar
          -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
          -- Can specify as many additional states as you like following the 'todo' pattern below
          --   The key in this case 'todo' is for healthcheck and to allow users to change its values
          --   'raw': Matched against the raw text of a 'shortcut_link'
          --   'rendered': Replaces the 'raw' value when rendering
          --   'highlight': Highlight for the 'rendered' icon
          custom = {
            todo = { raw = '[>]', rendered = '󰥔 ', highlight = '@markup.raw' },
          },
        },
        callout = {
          note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'DiagnosticInfo' },
          tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'DiagnosticOk' },
          important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'DiagnosticHint' },
          warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'DiagnosticWarn' },
          caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'DiagnosticError' },
          -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
          abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'DiagnosticInfo' },
          todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'DiagnosticInfo' },
          success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'DiagnosticOk' },
          question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'DiagnosticWarn' },
          failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'DiagnosticError' },
          danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'DiagnosticError' },
          bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'DiagnosticError' },
          example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'DiagnosticHint' },
          quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = '@markup.quote' },
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
          style = 'language',
          -- Amount of padding to add to the left of code blocks
          left_pad = 0,
          -- Amount of padding to add to the right of code blocks when width is 'block'
          right_pad = 2,
          -- Width of the code block background:
          --  block: width of the code block
          --  full: full width of the window
          width = 'block',
          -- Determins how the top / bottom of code block are rendered:
          --  thick: use the same highlight as the code body
          --  thin: when lines are empty overlay the above & below icons
          border = 'thick',
          -- Used above code blocks for thin border
          above = '▄',
          -- Used below code blocks for thin border
          below = '▀',
          -- Highlight for code blocks & inline code
          highlight = 'RenderMarkdownCode',
          highlight_inline = 'RenderMarkdownCodeInline',
        },
      })
    end,
  },


  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   lazy = false,
  --   config = true, -- or `opts = {}`
  --
  -- },


  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
