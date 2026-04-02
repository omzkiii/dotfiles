return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- { path = "snacks.nvim", words = { "Snacks" } },
        "neovim-api",
      },
    },
  },
  {
    "folke/snacks.nvim",
    event = "BufReadPre",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      indent = {
        enabled = true,
        priority = 1,
        char = "│",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        },
        chunk = {
          enabled = false,
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "│",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndentScope",
        },
      },
      styles = {
        zen = {
          enter = true,
          fixbuf = true,
          minimal = true,
          width = 100,
          height = 0,
          backdrop = { transparent = false, blend = 99 },
          keys = { q = false },
          zindex = 40,
          wo = {
            winhighlight = "NormalFloat:Normal",
          },
          w = {
            snacks_main = true,
          },
        },
      },
      zen = {
        toggles = {
          dim = false,
          git_signs = false,
          mini_diff_signs = false,
          -- diagnostics = false,
          -- inlay_hints = false,
        },
        show = {
          statusline = false, -- can only be shown when using the global statusline
          tabline = false,
          tmux = false,
        },
        win = { style = "zen" },
        on_open = function(win)
          vim.opt.wrap = true -- Enable line wrapping
          vim.opt.linebreak = true -- Allow breaking within lines
          vim.opt.breakat = vim.o.breakat -- Set break indent to vim default (using arabic characters to avoid keyword conflict)
        end,
        on_close = function(win) end,
        -- --- Options for the `Snacks.zen.zoom()`
        zoom = {
          toggles = {},
          show = { statusline = true, tabline = true },
          win = {
            backdrop = false,
            width = 0, -- full width
          },
        },
      },
      image = {
        enabled = true,
        math = {
          enabled = true, -- THIS is often the missing piece
        },
        doc = {
          -- enable image viewer for documents
          -- a treesitter parser must be available for the enabled languages.
          enabled = true,
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          inline = true,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          max_width = 80,
          max_height = 40,
          -- Set to `true`, to conceal the image text when rendering inline.
          -- (experimental)
          -- conceal = function(lang, type)
          --   -- only conceal math expressions
          --   return type == "math"
          -- end,
        },
      },
      picker = {
        prompt = "   ",
        auto_close = true,
        sources = {},
        focus = "list",
        border = "single",
        layout = function()
          local default = {
            layout = {
              backdrop = true,
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.8,
              {
                box = "vertical",
                border = "none",
                -- title = "{title} {live} {flags}",
                { win = "input", height = 1, title = "{title} {live} {flags}", border = "single" },
                { win = "list", border = "single" },
              },
              { win = "preview", title = "{preview}", border = "single", width = 0.5 },
            },
          }
          local vertical = {
            layout = {

              backdrop = true,
              width = 0.5,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "single",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          }
          return vim.o.columns >= 120 and default or vertical
        end,
        matcher = {

          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          sort_empty = false,
        },
        sort = {
          fields = { "score:desc", "#text", "idx" },
        },
        ui_select = true,
      },
    },

    keys = {
      -- Top Pickers & Explorer
      -- {
      --   "<leader><space>",
      --   function()
      --     Snacks.picker.smart()
      --   end,
      --   desc = "Smart Find Files",
      -- },
      {
        "<M-tab>",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer {
            finder = "explorer",
            sort = { fields = { "sort" } },
            supports_live = true,
            tree = true,
            watch = true,
            diagnostics = true,
            diagnostics_open = true,
            git_status = true,
            git_status_open = true,
            git_untracked = true,
            follow_file = true,
            focus = "list",
            auto_close = true,
            jump = { close = false },
            layout = { preset = "sidebar", preview = false },
            config = function(opts)
              return require("snacks.picker.source.explorer").setup(opts)
            end,
          }
        end,
        desc = "File Explorer",
      },
      -- find
      -- {
      --   "<leader>fb",
      --   function()
      --     Snacks.picker.buffers()
      --   end,
      --   desc = "Buffers",
      -- },
      {
        "<leader>sn",
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath "config" }
        end,
        desc = "Find Config File",
      },
      {
        "<leader>sf",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      -- {
      --   "<leader>fg",
      --   function()
      --     Snacks.picker.git_files()
      --   end,
      --   desc = "Find Git Files",
      -- },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },

      {
        "<leader>so",
        function()
          Snacks.picker.recent()
        end,
        desc = "Old Files",
      },
      -- git
      -- {
      --   "<leader>gb",
      --   function()
      --     Snacks.picker.git_branches()
      --   end,
      --   desc = "Git Branches",
      -- },
      -- {
      --   "<leader>gl",
      --   function()
      --     Snacks.picker.git_log()
      --   end,
      --   desc = "Git Log",
      -- },
      -- {
      --   "<leader>gL",
      --   function()
      --     Snacks.picker.git_log_line()
      --   end,
      --   desc = "Git Log Line",
      -- },
      -- {
      --   "<leader>gs",
      --   function()
      --     Snacks.picker.git_status()
      --   end,
      --   desc = "Git Status",
      -- },
      -- {
      --   "<leader>gS",
      --   function()
      --     Snacks.picker.git_stash()
      --   end,
      --   desc = "Git Stash",
      -- },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      -- {
      --   "<leader>gf",
      --   function()
      --     Snacks.picker.git_log_file()
      --   end,
      --   desc = "Git Log File",
      -- },
      -- Grep
      -- {
      --   "<leader>sb",
      --   function()
      --     Snacks.picker.lines()
      --   end,
      --   desc = "Buffer Lines",
      -- },
      -- {
      --   "<leader>sB",
      --   function()
      --     Snacks.picker.grep_buffers()
      --   end,
      --   desc = "Grep Open Buffers",
      -- },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      -- {
      --   "<leader>sw",
      --   function()
      --     Snacks.picker.grep_word()
      --   end,
      --   desc = "Visual selection or word",
      --   mode = { "n", "x" },
      -- },
      -- search
      {
        "<leader>sr",
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      -- {
      --   "<leader>s/",
      --   function()
      --     Snacks.picker.search_history()
      --   end,
      --   desc = "Search History",
      -- },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>sC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>si",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>sM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>ss",
        -- function()
        --   -- Snacks.picker.lazy()
        -- end,
        "<cmd> lua Snacks.picker() <CR>",
        -- desc = "Search for Plugin Spec",
        desc = "Search for Pickers",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<M-Backspace>",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      {
        "<leader>uc",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "grr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gri",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "<leader>ds",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },

      -- ZEN
      {
        "<leader>z",
        function()
          Snacks.zen.zen()
        end,
        desc = "Zen Mode",
      },

      -- IMAGE
      {
        "<leader>k",
        function()
          Snacks.image.hover()
        end,
        desc = "Zen Mode",
      },
    },
  },
}
