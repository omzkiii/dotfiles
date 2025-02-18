return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        prompt = " ",
        auto_close = true,
        sources = {},
        focus = "list",
        layout = {
          cycle = true,
          preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
          end,
          layout = {
            backdrop = false,
            border = "solid",
          },
          -- present = "default",
          -- layout = { border = "double" },
        },
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
        win = {
          border = "none", -- Change border style: "none", "single", "double", "rounded", "solid", "shadow"
        },
      },

      explorer = {
        auto_close = true,
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
        "<leader>,",
        function()
          Snacks.picker.buffers(opts)
        end,
        desc = "Buffers",
      },
      -- {
      --   "<leader>/",
      --   function()
      --     Snacks.picker.grep()
      --   end,
      --   desc = "Grep",
      -- },
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
          Snacks.explorer { win = { border = "shadow" }, auto_close = true }
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
      -- {
      --   "<leader>fc",
      --   function()
      --     Snacks.picker.files { cwd = vim.fn.stdpath "config" }
      --   end,
      --   desc = "Find Config File",
      -- },
      -- {
      --   "<leader>ff",
      --   function()
      --     Snacks.picker.files(opts)
      --   end,
      --   desc = "Find Files",
      -- },
      -- {
      --   "<leader>fg",
      --   function()
      --     Snacks.picker.git_files(opts)
      --   end,
      --   desc = "Find Git Files",
      -- },
      -- {
      --   "<leader>fp",
      --   function()
      --     Snacks.picker.projects(opts)
      --   end,
      --   desc = "Projects",
      -- },
      -- {
      --   "<leader>fr",
      --   function()
      --     Snacks.picker.recent(opts)
      --   end,
      --   desc = "Recent",
      -- },
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
      -- {
      --   "<leader>gd",
      --   function()
      --     Snacks.picker.git_diff(opts)
      --   end,
      --   desc = "Git Diff (Hunks)",
      -- },
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
      -- {
      --   "<leader>sg",
      --   function()
      --     Snacks.picker.grep(opts)
      --   end,
      --   desc = "Grep",
      -- },
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
        '<leader>s"',
        function()
          Snacks.picker.registers(opts)
        end,
        desc = "Registers",
      },
      {
        "<leader>s/",
        function()
          Snacks.picker.search_history(opts)
        end,
        desc = "Search History",
      },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds(opts)
        end,
        desc = "Autocmds",
      },
      -- {
      --   "<leader>sb",
      --   function()
      --     Snacks.picker.lines(opts)
      --   end,
      --   desc = "Buffer Lines",
      -- },
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
      -- {
      --   "<leader>sd",
      --   function()
      --     Snacks.picker.diagnostics(opts)
      --   end,
      --   desc = "Diagnostics",
      -- },
      -- {
      --   "<leader>sD",
      --   function()
      --     Snacks.picker.diagnostics_buffer(opts)
      --   end,
      --   desc = "Buffer Diagnostics",
      -- },
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
      -- {
      --   "<leader>sm",
      --   function()
      --     Snacks.picker.marks(opts)
      --   end,
      --   desc = "Marks",
      -- },
      -- {
      --   "<leader>sM",
      --   function()
      --     Snacks.picker.man(opts)
      --   end,
      --   desc = "Man Pages",
      -- },
      -- {
      --   "<leader>sp",
      --   function()
      --     Snacks.picker.lazy(opts)
      --   end,
      --   desc = "Search for Plugin Spec",
      -- },
      -- {
      --   "<leader>sq",
      --   function()
      --     Snacks.picker.qflist(opts)
      --   end,
      --   desc = "Quickfix List",
      -- },
      -- {
      --   "<leader>sR",
      --   function()
      --     Snacks.picker.resume(opts)
      --   end,
      --   desc = "Resume",
      -- },
      {
        "<leader>su",
        function()
          Snacks.picker.undo(opts)
        end,
        desc = "Undo History",
      },
      -- {
      --   "<leader>uC",
      --   function()
      --     Snacks.picker.colorschemes(opts)
      --   end,
      --   desc = "Colorschemes",
      -- },
      -- LSP
      -- {
      --   "gd",
      --   function()
      --     Snacks.picker.lsp_definitions(opts)
      --   end,
      --   desc = "Goto Definition",
      -- },
      -- {
      --   "gD",
      --   function()
      --     Snacks.picker.lsp_declarations(opts)
      --   end,
      --   desc = "Goto Declaration",
      -- },
      -- {
      --   "gr",
      --   function()
      --     Snacks.picker.lsp_references(opts)
      --   end,
      --   nowait = true,
      --   desc = "References",
      -- },
      -- {
      --   "gI",
      --   function()
      --     Snacks.picker.lsp_implementations(opts)
      --   end,
      --   desc = "Goto Implementation",
      -- },
      -- {
      --   "gy",
      --   function()
      --     Snacks.picker.lsp_type_definitions(opts)
      --   end,
      --   desc = "Goto T[y]pe Definition",
      -- },
      -- {
      --   "<leader>ss",
      --   function()
      --     Snacks.picker.lsp_symbols(opts)
      --   end,
      --   desc = "LSP Symbols",
      -- },
      -- {
      --   "<leader>sS",
      --   function()
      --     Snacks.picker.lsp_workspace_symbols(opts)
      --   end,
      --   desc = "LSP Workspace Symbols",
      -- },
    },
  },
}
