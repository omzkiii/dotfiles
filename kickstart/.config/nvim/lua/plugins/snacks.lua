return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    event = "BufReadPre",
    lazy = false,
    --
    opts = {
      indent = {
        priority = 1,
        enabled = true,
      },
      styles = {
        zen = {
          enter = true,
          fixbuf = false,
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
        },
        win = { style = "zen" },
        on_open = function(win) end,
        on_close = function(win) end,
        --- Options for the `Snacks.zen.zoom()`
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
              backdrop = false,
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

              backdrop = false,
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
      --     Snacks.picker.smart(opts)
      --   end,
      --   desc = "Smart Find Files",
      -- },
      {
        "<M-tab>",
        function()
          Snacks.picker.buffers(opts)
        end,
        desc = "Buffers",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history(opts)
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications(opts)
        end,
        desc = "Notification History",
      },
      {
        "<leader>e",
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
      --     Snacks.picker.buffers(opts)
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
          Snacks.picker.files(opts)
        end,
        desc = "Find Files",
      },
      -- {
      --   "<leader>fg",
      --   function()
      --     Snacks.picker.git_files(opts)
      --   end,
      --   desc = "Find Git Files",
      -- },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects(opts)
        end,
        desc = "Projects",
      },

      {
        "<leader>so",
        function()
          Snacks.picker.recent(opts)
        end,
        desc = "Old Files",
      },
      -- git
      -- {
      --   "<leader>gb",
      --   function()
      --     Snacks.picker.git_branches(opts)
      --   end,
      --   desc = "Git Branches",
      -- },
      -- {
      --   "<leader>gl",
      --   function()
      --     Snacks.picker.git_log(opts)
      --   end,
      --   desc = "Git Log",
      -- },
      -- {
      --   "<leader>gL",
      --   function()
      --     Snacks.picker.git_log_line(opts)
      --   end,
      --   desc = "Git Log Line",
      -- },
      -- {
      --   "<leader>gs",
      --   function()
      --     Snacks.picker.git_status(opts)
      --   end,
      --   desc = "Git Status",
      -- },
      -- {
      --   "<leader>gS",
      --   function()
      --     Snacks.picker.git_stash(opts)
      --   end,
      --   desc = "Git Stash",
      -- },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff(opts)
        end,
        desc = "Git Diff (Hunks)",
      },
      -- {
      --   "<leader>gf",
      --   function()
      --     Snacks.picker.git_log_file(opts)
      --   end,
      --   desc = "Git Log File",
      -- },
      -- Grep
      -- {
      --   "<leader>sb",
      --   function()
      --     Snacks.picker.lines(opts)
      --   end,
      --   desc = "Buffer Lines",
      -- },
      -- {
      --   "<leader>sB",
      --   function()
      --     Snacks.picker.grep_buffers(opts)
      --   end,
      --   desc = "Grep Open Buffers",
      -- },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep(opts)
        end,
        desc = "Grep",
      },
      -- {
      --   "<leader>sw",
      --   function()
      --     Snacks.picker.grep_word(opts)
      --   end,
      --   desc = "Visual selection or word",
      --   mode = { "n", "x" },
      -- },
      -- search
      {
        "<leader>sr",
        function()
          Snacks.picker.registers(opts)
        end,
        desc = "Registers",
      },
      -- {
      --   "<leader>s/",
      --   function()
      --     Snacks.picker.search_history(opts)
      --   end,
      --   desc = "Search History",
      -- },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds(opts)
        end,
        desc = "Autocmds",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.command_history(opts)
        end,
        desc = "Command History",
      },
      {
        "<leader>sC",
        function()
          Snacks.picker.commands(opts)
        end,
        desc = "Commands",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics(opts)
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics_buffer(opts)
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help(opts)
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sH",
        function()
          Snacks.picker.highlights(opts)
        end,
        desc = "Highlights",
      },
      {
        "<leader>si",
        function()
          Snacks.picker.icons(opts)
        end,
        desc = "Icons",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps(opts)
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps(opts)
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist(opts)
        end,
        desc = "Location List",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks(opts)
        end,
        desc = "Marks",
      },
      {
        "<leader>sM",
        function()
          Snacks.picker.man(opts)
        end,
        desc = "Man Pages",
      },
      {
        "<leader>ss",
        -- function()
        --   -- Snacks.picker.lazy(opts)
        -- end,
        "<cmd> lua Snacks.picker() <CR>",
        -- desc = "Search for Plugin Spec",
        desc = "Search for Pickers",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist(opts)
        end,
        desc = "Quickfix List",
      },
      {
        "<M-Backspace>",
        function()
          Snacks.picker.resume(opts)
        end,
        desc = "Resume",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo(opts)
        end,
        desc = "Undo History",
      },
      {
        "<leader>uc",
        function()
          Snacks.picker.colorschemes(opts)
        end,
        desc = "Colorschemes",
      },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions(opts)
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations(opts)
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references(opts)
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations(opts)
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions(opts)
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "<leader>ds",
        function()
          Snacks.picker.lsp_symbols(opts)
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.lsp_workspace_symbols(opts)
        end,
        desc = "LSP Workspace Symbols",
      },

      -- ZEN
      {
        "<C-S-z>",
        function()
          Snacks.zen.zen(opts)
        end,
        desc = "LSP Workspace Symbols",
      },
    },
  },
}
