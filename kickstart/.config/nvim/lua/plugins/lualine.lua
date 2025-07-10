return {
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    dependencies = { "echasnovski/mini.nvim" },
    event = "VeryLazy",
    config = function()
      require("mini.icons").mock_nvim_web_devicons()
      local navic = require "nvim-navic"
      local function recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        else
          return "[ @" .. reg .. "]"
        end
      end
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "   ", right = "｜" },
          -- component_separators = { left = "|", right = "|" },
          -- section_separators = { left = " ", right = "" },
          section_separators = { left = " ", right = "" },
          -- section_separators = { left = "█ ", right = " █" },
          -- section_separators = { left = " ", right = " " },
          disabled_filetypes = {
            -- statusline = {},
            -- winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 100,
            -- tabline = 1000,
            -- winbar = 100,
          },
          -- fmt = string.lower,
          --
        },

        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                local mode_map = {
                  ["NORMAL"] = "N",
                  ["INSERT"] = "I",
                  ["VISUAL"] = "V",
                  ["V-LINE"] = "V-L",
                  ["V-BLOCK"] = "V-B",
                  ["COMMAND"] = "C",
                  ["SELECT"] = "S",
                  ["S-LINE"] = "SL",
                  ["S-BLOCK"] = "SB",
                  -- ["NORMAL"] = "",
                  -- ["INSERT"] = "󰏪",
                  -- ["VISUAL"] = "󰴲",
                  -- ["V-LINE"] = "󱊅",
                  -- ["V-BLOCK"] = "󰒉",
                  -- ["COMMAND"] = "",
                  -- ["SELECT"] = "S",
                  -- ["SELECT LINE"] = "SL",
                  -- ["SELECT BLOCK"] = "SB",
                }

                return mode_map[str]
              end,
            },
          },
          lualine_b = {
            -- {
            --   "filetype",
            --   color = "CursorColumn",
            --   separator = "",
            --   colored = true, -- Displays filetype icon in color if set to true
            --   icon_only = true, -- Display only an icon for filetype
            --   align = "right",
            --   -- separator = "",
            --   padding = { right = -3, left = 1 },
            -- },
            {
              "filename",
              color = "CursorColumn",
              separator = "",
              file_status = true, -- Displays file status (readonly status, modified status)
              padding = { right = 1, left = 1 },
              newfile_status = false, -- Display new file status (new file means no write after created)
              path = 4, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory

              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = "●",
                readonly = " ", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                newfile = "[New]", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_c = {
            { "branch" },
            { recording },
          },

          lualine_x = {
            {
              "searchcount",
              maxcount = 999,
              timeout = 500,
            },
            {
              "diff",
              diff_color = {
                -- Same color values as the general color option can be used here.
                -- added = "DiffAdd", -- Changes the diff's added color
                -- modified = "DiffChange", -- Changes the diff's modified color
                -- removed = "DiffDelete", -- Changes the diff's removed color you
              },
              -- symbols = { added = "  ", modified = "  ", removed = "  " }, -- Changes the symbols used by the diff.
              symbols = { added = " ", modified = " ", removed = "󰍵 " }, -- Changes the symbols used by the diff.
            },
            {
              "diagnostics",

              symbols = {
                error = "󰅙 ",
                warn = " ",
                hint = "󰌵 ",
                info = " ",
              }, -- Changes the symbols used by the diff.
            },
            {
              "harpoon2",
              -- color = "CursorColumn",
              icon = "󰛢",
              -- indicators = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" },
              -- active_indicators = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" },
              color_active = "DiagnosticWarn",
              _separator = " ",
              no_harpoon = "Harpoon not loaded",
            },
          },
          lualine_y = {
            {
              "progress",
              color = "CursorColumn",
            },
          },
          lualine_z = { { "location" } },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {
          lualine_c = {
            {
              "filetype",
              separator = "",
              color = "WinBar",
              colored = true, -- Displays filetype icon in color if set to true
              icon_only = true, -- Display only an icon for filetype
              align = "right",
              padding = { right = -3, left = 1 },
            },

            {
              "filename",
              separator = "",
              color = "SnacksIndentScope",
              file_status = true, -- Displays file status (readonly status, modified status)
              padding = { right = 1, left = 0 },
              newfile_status = false, -- Display new file status (new file means no write after created)
              path = 0, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory

              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = "",
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
            {
              "navic",
              -- color = "Float",
              -- color_correction = nil,
              -- navic_opts = nil,
            },
          },
          -- lualine_b = {},
        },
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  {
    "letieu/harpoon-lualine",

    event = "VeryLazy",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
  -- {
  --   {
  --     "freddiehaddad/feline.nvim",
  --     opts = {},
  --     -- config = function() end,
  --   },
  -- },
}
