return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        else
          return "rec @" .. reg .. ""
        end
      end
      require("lualine").setup {
        options = {
          -- color = "Normal",
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = " ╱ ", right = "   " },
          -- component_separators = { left = "|", right = "|" },
          -- section_separators = { left = " ", right = "" },
          section_separators = { left = " ", right = "" },
          -- section_separators = { left = "█ ", right = " █" },
          -- section_separators = { left = " ", right = " " },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 500,
            -- tabline = 1000,
            -- winbar = 1000,
          },
          -- fmt = string.lower,
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
            {
              "filetype",
              color = "CursorLine",
              separator = "",
              colored = false, -- Displays filetype icon in color if set to true
              icon_only = true, -- Display only an icon for filetype
              align = "right",
              -- separator = "",
              padding = { right = -3, left = 1 },
            },
            {
              "filename",
              color = "CursorLine",
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
          lualine_c = { "branch", recording },
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
              symbols = { added = "  ", modified = "  ", removed = "  " }, -- Changes the symbols used by the diff.
            },
            "diagnostics",
          },
          lualine_y = {
            {
              "progress",
              color = "CursorLine",
            },
          },
          lualine_z = { "location" },
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
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  -- {
  --   {
  --     "freddiehaddad/feline.nvim",
  --     opts = {},
  --     -- config = function() end,
  --   },
  -- },
}
