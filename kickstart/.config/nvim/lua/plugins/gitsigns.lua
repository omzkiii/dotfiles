return {
  {
    -- Here is a more advanced example where we pass configuration
    -- options to `gitsigns.nvim`. This is equivalent to the following Lua: require('gitsigns').setup({ ... }) See `:help gitsigns` to understand what the configuration keys do { -- Adds git related signs to the gutter, as well as utilities for managing changes "lewis6991/gitsigns.nvim",
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    -- lazy = true,
    opts = {},
    config = function()
      require("gitsigns").setup {
        signcolumn = true,
        current_blame_line = true,

        signs = {
          add = { text = "┃" },
          change = { text = "┋" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "𜰔" },
        },
        preview_config = {
          border = "single", -- 'single', 'double', 'rounded', 'solid', 'shadow'
          style = "minimal",
          relative = "cursor",
          row = 1,
          col = 1,
        },
        on_attach = function(bufnr)
          vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
          local gitsigns = require "gitsigns"

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal { "]c", bang = true }
            else
              gitsigns.nav_hunk "next"
            end
          end, { desc = "Jump to next git hunk (or diff change)" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal { "[c", bang = true }
            else
              gitsigns.nav_hunk "prev"
            end
          end, { desc = "Jump to previous git hunk (or diff change)" })

          -- Hunk Actions (Normal mode)
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage current hunk" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset current hunk" })

          -- Hunk Actions (Visual mode)
          map("v", "<leader>hs", function()
            gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, { desc = "Stage selected lines as hunk" })

          map("v", "<leader>hr", function()
            gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, { desc = "Reset selected lines as hunk" })

          -- Buffer Actions
          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage entire buffer" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset entire buffer" })

          -- Preview/Diff
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk in floating window" })
          map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
          map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })
          map("n", "<leader>hD", function()
            gitsigns.diffthis "~"
          end, { desc = "Diff against last commit" })

          -- Quickfix
          map("n", "<leader>hQ", function()
            gitsigns.setqflist "all"
          end, { desc = "Add all hunks to quickfix list" })

          map("n", "<leader>hq", gitsigns.setqflist, { desc = "Add current hunk to quickfix list" })

          -- Toggles
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
          map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

          -- Text Object
          map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select git hunk text object" })

          -- Git
          map("n", "<leader>gl", gitsigns.blame_line, { desc = "Git Blame Line" })
          map("n", "<leader>gb", gitsigns.blame, { desc = "Git Blame" })
        end,
      }
    end,
  },
}
