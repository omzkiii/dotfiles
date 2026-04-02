-- return {
--   "rest-nvim/rest.nvim",
--   event = "VeryLazy",
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       opts.ensure_installed = opts.ensure_installed or {}
--       table.insert(opts.ensure_installed, "http")
--     end,
--   },
--   init = function()
--     vim.g.rest_nvim = {
--       request = {
--         skip_ssl_verification = false,
--         hooks = {
--           encode_url = true,
--           set_content_type = true,
--         },
--       },
--       response = {
--         hooks = {
--           decode_url = false,
--           format = false,
--         },
--       },
--       ui = {
--         winbar = true,
--       },
--     }
--   end,
--   keys = {
--     { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run HTTP request under cursor" },
--     { "<leader>rl", "<cmd>Rest last<cr>", desc = "Run last HTTP request" },
--   },
-- }
return {
  "mistweaverco/kulala.nvim",
  -- event="VeryLazy",
  ft = { "http", "rest" },
  keys = {
    { "<leader>rs", desc = "Send request" },
    { "<leader>ra", desc = "Send all requests" },
    { "<leader>rb", desc = "Open scratchpad" },
  },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    icons = {
      inlay = {
        loading = "",
        done = "",
        error = "",
      },
      lualine = "",
      textHighlight = "WarningMsg", -- highlight group for request elapsed time
    },
    -- write_cookies = true,
    ui = {
      max_response_size = 102400,
      pickers = {
        snacks = {
          layout = function()
            local ok, snacks = pcall(require, "snacks")
            if ok and snacks.config.picker.layout then
              return snacks.config.picker.layout("snacks")
            end
            return "default"
          end,
        },
      },
    },
  },
}
