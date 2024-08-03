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

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    override = {
      "NvChad/ui",
      enabled = false,
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
