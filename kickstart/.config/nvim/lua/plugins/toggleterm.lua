return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- lazy = true,
  opts = function()
    require("toggleterm").setup {
      shade_terminals = false,
      size = function(term)
        if term.direction == "horizontal" then
          return 25
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.5
        end
      end,
    }
  end,
  vim.keymap.set(
    "n",
    "<M-v>",
    '<Cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>',
    { desc = "Toggle Terminal Vertical" }
  ),
  vim.keymap.set(
    "t",
    "<M-v>",
    '<Cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>',
    { desc = "Toggle Terminal Vertical" }
  ),
  vim.keymap.set(
    "n",
    "<M-h>",
    '<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
    { desc = "Toggle Terminal Horizontal" }
  ),
  vim.keymap.set(
    "t",
    "<M-h>",
    '<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
    { desc = "Toggle Terminal Horizontal" }
  ),
  -- {
  -- "NvChad/nvterm",
  -- config = function()
  --   require("nvterm").setup {
  --     terminals = {
  --       shell = vim.o.shell,
  --       list = {},
  --       type_opts = {
  --         float = {
  --           relative = "editor",
  --           row = 0.3,
  --           col = 0.25,
  --           width = 0.5,
  --           height = 0.4,
  --           border = "single",
  --         },
  --         horizontal = { location = "rightbelow", split_ratio = 0.3 },
  --         vertical = { location = "rightbelow", split_ratio = 0.5 },
  --       },
  --     },
  --     behavior = {
  --       autoclose_on_quit = {
  --         enabled = false,
  --         confirm = true,
  --       },
  --       close_on_exit = true,
  --       auto_insert = true,
  --     },
  --   }
  -- end,

  -- vim.keymap.set(
  --   "n",
  --   "<M-v>",
  --   '<cmd> lua require("nvterm.terminal").new "vertical" <cr>',
  --   { desc = "Vertical Terminal" }
  -- ),
  -- vim.keymap.set(
  --   "t",
  --   "<M-v>",
  --   '<cmd> lua require("nvterm.terminal").new "vertical" <cr>',
  --   { desc = "Vertical Terminal" }
  -- ),
  --
  -- vim.keymap.set(
  --   "n",
  --   "<M-h>",
  --   '<cmd> lua require("nvterm.terminal").new "horizontal" <cr>',
  --   { desc = "Horizontal Terminal" }
  -- ),
  -- vim.keymap.set(
  --   "t",
  --   "<M-h>",
  --   '<cmd> lua require("nvterm.terminal").new "horizontal" <cr>',
  --   { desc = "Horizontal Terminal" }
  -- ),
}
