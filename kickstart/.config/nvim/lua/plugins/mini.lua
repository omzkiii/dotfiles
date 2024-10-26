return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup {
        mappings = {
          add = "<M-s>a", -- Add surrounding in Normal and Visual modes
          delete = "<M-s>d", -- Delete surrounding
          find = "<M-s>f", -- Find surrounding (to the right)
          find_left = "<M-s>F", -- Find surrounding (to the left)
          highlight = "<M-s>h", -- Highlight surrounding
          replace = "<M-s>r", -- Replace surrounding
          update_n_lines = "<M-s>n", -- Update `n_lines`

          -- add = "sa", -- Add surrounding in Normal and Visual modes
          -- delete = "sd", -- Delete surrounding
          -- find = "sf", -- Find surrounding (to the right)
          -- find_left = "sF", -- Find surrounding (to the left)
          -- highlight = "sh", -- Highlight surrounding
          -- replace = "sr", -- Replace surrounding
          -- update_n_lines = "sn", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- set use_icons to true if you have a Nerd Font

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      -- -@diagnostic disable-next-line: duplicate-set-field

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs { "Up", "Down" } do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require "mini.animate"
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
          timing = animate.gen_timing.linear { duration = 70, unit = "total" },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
        cursor = {
          enable = false,
          -- -- Animate for 200 milliseconds with linear easing
          -- timing = animate.gen_timing.cubic { duration = 20, unit = "total" },
          --
          -- -- Animate with shortest line for any cursor move
          -- path = animate.gen_path.line {
          --   predicate = function()
          --     return true
          --   end,
          -- },
        },
      }
    end,
  },
}
