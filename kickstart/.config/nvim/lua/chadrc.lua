local options = {
  base46 = {
    theme = "gruvbox", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {
      catppuccin = {
        base_16 = {
          base00 = "#1e1e2f",
        },
        base_30 = {
          black = "#1e1e2f",
        },
      },
      gruvbox = {
        base_16 = {
          -- base00 = "#1d2021",
          black = "#282828",
        },
        base_30 = {
          -- black = "#1d2021",
          black = "#282828",
        },
      },
      everforest = {
        base_16 = {
          base00 = "#272e33",
        },
        base_30 = {
          black = "#272e33",
        },
      },
    },
    transparency = false,
    -- theme_toggle = { "onedark", "one_light" },
  },

  ui = {
    cmp = {
      icons_left = true, -- only for non-atom styles!
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        tailwind = false, -- will work for css lsp too
        icon = "󱓻",
      },
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
      enabled = true,
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
    },
  },

  nvdash = {
    load_on_startup = false,
    header = {
      -- "                            ",
      -- "           eovim           ",
      -- "                            ",
      -- "                            ",
      -- "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
      -- "   ▄▀███▄     ▄██ █████▀    ",
      -- "   ██▄▀███▄   ███           ",
      -- "   ███  ▀███▄ ███           ",
      -- "   ███    ▀██ ███           ",
      -- "   ███      ▀ ███           ",
      -- "   ▀██ █████▄▀█▀▄██████▄    ",
      -- "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
      -- "                            ",
      -- "     Powered By  eovim    ",
      -- "                            ",
    },

    buttons = {
      { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
      { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
      { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
      -- { txt = "󱥚  Themes", keys = "Spc t h", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashLazy",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    },
  },

  term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { pkgs = {} },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

vim.keymap.set("n", "<leader><leader>", function()
  require("nvchad.themes").open()
end, { silent = true, buffer = true, desc = "nvchad themes" })
local status, chadrc = pcall(require, "chadrc")

return vim.tbl_deep_extend("force", options, status and chadrc or {})
