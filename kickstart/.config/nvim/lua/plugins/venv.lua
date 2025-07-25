return {
  {
    "linux-cultist/venv-selector.nvim",
    lazy = true,
    cmd = { "VenvSelect", "VenvSelectCached" },
    -- branch = "regexp", -- This is the regexp branch, use this for the new version
    -- ft = { "python" },
    dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    config = function()
      require("venv-selector").setup {
        -- Your options go here
        name = "env",
        auto_refresh = true,
        stay_on_this_version = true,
        -- settings = {
        --   search = {
        --     my_venvs = {
        --       command = "fd 'env/bin/python$' ../$CWD --full-path -a -",
        --     },
        --   },
        -- },
        --
      }
      local venv = require("venv-selector").get_active_venv()
      if venv then
        require("dap-python").setup(venv .. "/bin/python")
      end
    end,
    -- event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },

  -- { "mfussenegger/nvim-dap-python", ft = "python", lazy = true },
}
