---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "catppuccin" },

  changed_themes = {
    gruvbox = {
      base_16 = {
        base00 = "#1d2021",
      },
      base_30 = {
        black = "#1d2021",
      },
    },
  },
  -- hl_override = highlights.override,
  -- hl_add = highlights.add,

 hl_override = {
    Comment = {
      italic = true,
    },
    EndOfBuffer = {
      italic = true,
    },
    WinSeparator = {
      italic = true,
    },
    SignColumn = {
      italic = true,
    },
    -- LineNr = {
    --   italic = true,
    -- },
    LineNrAbove = {
      italic = true,
    },
    LineNrBelow = {
      italic = true,
    },
    CursorLineSign = {
      italic = true,
    },
    NonText = {
      italic = true,
    },

    SpecialKey = {
      italic = true,
    },

    WhiteSpace = {
      italic = true,
    },
  },

  statusline = {
    theme = "default",
    overriden_modules = function(modules)
      local file_info = function ()
          local function stbufnr()
            return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
          end
          local icon = " 󰈚 "
          local indicator = ""
          local path = vim.api.nvim_buf_get_name(stbufnr())
        local name
        if path == "" then
          name = "Empty "
        else
          -- Get the parent directory and file name
          local parent, file = path:match("(.+)/([^/]+)$")
          if parent and file then
            -- Use only the last directory in the path
            parent = parent:match("([^/]+)$") or ""
            name = parent .. "/" .. file
          else
            name = path:match("([^/]+)$") or "Empty"
          end
        end

          if name ~= "Empty " then
            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

            if devicons_present then
              local ft_icon = devicons.get_icon(name)
              icon = (ft_icon ~= nil and " " .. ft_icon) or icon
            end

            name = " " .. name .. " "
          end
        if vim.bo.modified then
        return "%#St_file_info#" .. icon .. name .. indicator .. "%#St_file_sep#"  .. "█"
        -- elseif not vim.bo.modifiable or vim.bo.readonly thenfdfdfd
      else
        return "%#St_file_info#" .. icon .. name .. "%#St_file_sep#" .. "█"
        end
       end
      modules[2] = file_info()
    end
  }
}

--   -- Override the fileInfo function
--   default_statusline.fileInfo = function()
--     local file_info = original_fileInfo() -- Get the original file info
--     -- Add modify indicator
--     if vim.bo.modified then
--       return file_info
--     elseif not vim.bo.modifiable or vim.bo.readonly then
--       file_info = file_info .. "%#St_modified#  %*"
--     end
--   end
-- end
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
