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
}
