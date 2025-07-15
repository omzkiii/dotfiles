return {
  {
    "bngarren/checkmate.nvim",
    event = "VeryLazy",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      enabled = true,
      notify = false,
      files = { "*.todo*" }, -- matches TODO, TODO.md, .todo.md
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
          rhs = "<cmd>Checkmate check<CR>",
          desc = "Set todo item as checked (done)",
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
      },
      default_list_marker = "-",
      todo_markers = {
        unchecked = "",
        checked = "",
      },
      style = {},
      todo_action_depth = 1, --  Depth within a todo item's hierachy from which actions (e.g. toggle) will act on the parent todo item
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
          aliases = { "init" },
          style = function()
            return vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
          end,
          get_value = function()
            return tostring(os.date "%m/%d/%y %H:%M")
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
          title = "Archive",
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
