return {
  {
    "bngarren/checkmate.nvim",
    event = "VeryLazy",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      enabled = true,
      notify = false,
      files = { "*.todo*", "*.md" }, -- matches TODO, TODO.md, .todo.md
      -- files = { "*" }, -- matches TODO, TODO.md, .todo.md
      log = {
        level = "info",
        use_file = false,
        use_buffer = false,
      },
      -- Default keymappings
      keys = {
        ["<leader>ct"] = {
          rhs = "<cmd>Checkmate toggle<CR>",
          desc = "Toggle todo item",
          modes = { "n", "v" },
        },
        ["<leader>cc"] = {
          rhs = "<cmd>Checkmate toggle cancelled<CR>",
          desc = "Set todo item as cancelled",
          modes = { "n", "v" },
        },
        ["<leader>cu"] = {
          rhs = "<cmd>Checkmate uncheck<CR>",
          desc = "Set todo item as unchecked (not done)",
          modes = { "n", "v" },
        },
        ["<leader>cn"] = {
          rhs = "<cmd>Checkmate create<CR>",
          desc = "Create todo item",
          modes = { "n", "v" },
        },
        ["<leader>cR"] = {
          rhs = "<cmd>Checkmate remove_all_metadata<CR>",
          desc = "Remove all metadata from a todo item",
          modes = { "n", "v" },
        },
        ["<leader>cA"] = {
          rhs = "<cmd>Checkmate archive<CR>",
          desc = "Archive checked/completed todo items (move to bottom section)",
          modes = { "n" },
        },
        ["<leader>cv"] = {
          rhs = "<cmd>Checkmate metadata select_value<CR>",
          desc = "Update the value of a metadata tag under the cursor",
          modes = { "n" },
        },
        ["<leader>c]"] = {
          rhs = "<cmd>Checkmate metadata jump_next<CR>",
          desc = "Move cursor to next metadata tag",
          modes = { "n" },
        },
        ["<leader>c["] = {
          rhs = "<cmd>Checkmate metadata jump_previous<CR>",
          desc = "Move cursor to previous metadata tag",
          modes = { "n" },
        },
        ["<leader>c="] = {
          rhs = "<cmd>Checkmate cycle_next<CR>",
          desc = "Cycle todo item(s) to the next state",
          modes = { "n", "v" },
        },
        ["<leader>c-"] = {
          rhs = "<cmd>Checkmate cycle_previous<CR>",
          desc = "Cycle todo item(s) to the previous state",
          modes = { "n", "v" },
        },
      },
      default_list_marker = "-",
      todo_states = {
        -- Built-in states (cannot change markdown or type)
        unchecked = { marker = "□", order = 1 },
        checked = { marker = "✔", order = 2 },

        -- Custom states
        partial = {
          marker = "◐",
          markdown = ".", -- Saved as `- [.]`
          type = "incomplete", -- Counts as "not done"
          order = 50,
        },
        cancelled = {
          marker = "✗",
          markdown = "c", -- Saved as `- [c]`
          type = "complete", -- Counts as "done"
          order = 2,
        },
        hold = {
          marker = "⏸",
          markdown = "/", -- Saved as `- [/]`
          type = "inactive", -- Ignored in counts
          order = 100,
        },
      },
      style = {
        CheckmateCheckedMarker = { link = "GitSignsAdd" },
        CheckmatePartialMarker = { link = "DiagnosticWarning" },
        CheckmateCancelledMarker = { link = "DiagnosticError" },
        CheckmateHoldMarker = { link = "DiagnosticHint" },
        CheckmateCancelledMainContent = { link = "CheckmateCheckedMainContent" },
      },
      enter_insert_after_new = false, -- Should enter INSERT mode after :CheckmateCreate (new todo)
      smart_toggle = {
        enabled = true,
        check_down = "direct_children",
        uncheck_down = "none",
        check_up = "direct_children",
        uncheck_up = "direct_children",
      },
      show_todo_count = true,
      todo_count_position = "eol",
      todo_count_recursive = true,
      use_metadata_keymaps = true,
      metadata = {
        --   -- Example: A @priority tag that has dynamic color based on the priority value
        priority = {
          style = function(_value)
            local value = _value:lower()
            if value == "high" then
              return vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
            elseif value == "medium" then
              return vim.api.nvim_get_hl(0, { name = "DiagnosticWarning" })
            elseif value == "low" then
              return vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })
            else -- fallback
              return vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })
            end
          end,
          get_value = function()
            return "medium" -- Default priority
          end,
          key = "<leader>cp",
          jump_to_on_insert = "value",
          select_on_insert = true,
        },
        -- Example: A @started tag that uses a default date/time string when added
        started = {
          aliases = { "partial" },
          style = function()
            return vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
          end,
          get_value = function()
            return tostring(os.date "%m/%d/%y %H:%M")
          end,
          on_add = function()
            require("checkmate").toggle "partial"
          end,
          on_remove = function()
            require("checkmate").toggle "unchecked"
          end,
          key = "<leader>cs",
        },
        -- Example: A @done tag that also sets the todo item state when it is added and removed
        done = {
          aliases = { "completed", "finished" },
          style = function()
            return vim.api.nvim_get_hl(0, { name = "GitSignsAdd" })
          end,
          get_value = function()
            return tostring(os.date "%m/%d/%y %H:%M")
          end,
          key = "<leader>cd",
          on_add = function(todo_item)
            require("checkmate").set_todo_item(todo_item, "checked")
          end,
          on_remove = function(todo_item)
            require("checkmate").set_todo_item(todo_item, "unchecked")
          end,
        },
        due = {
          style = function()
            return vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
          end,
          get_value = function()
            return tostring(os.date "%m/%d/%y")
          end,
          key = "<leader>cD",
          jump_to_on_insert = "value",
          select_on_insert = true,
        },
      },
      archive = {
        heading = {
          title = "Completed",
          level = 2, -- e.g. ##
        },
        parent_spacing = 0, -- no extra lines between archived todos
      },
      linter = {
        enabled = true,
      },
    },
  },
}
