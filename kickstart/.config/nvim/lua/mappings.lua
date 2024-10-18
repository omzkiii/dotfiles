local function set_key_mappings(mappings)
  for mode, maps in pairs(mappings) do
    for key, map in pairs(maps) do
      local command = map[1]
      local description = map[2]
      vim.keymap.set(mode, key, command, { desc = description })
    end
  end
end

local diagnostics_active = true

function ToggleDiagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
    print "Diagnostics enabled"
  else
    vim.diagnostic.enable(false)
    print "Diagnostics disabled"
  end
end

-- Map the function to a key (e.g., <leader>d)
vim.api.nvim_set_keymap("n", "<leader>lo", ":lua ToggleDiagnostics()<CR>", { noremap = true, silent = true })

local key_mappings = {
  n = {
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- ["<C-u>"] = { "<C-u>zz", "Move up page" },
    -- ["<C-d>"] = { "<C-d>zz", "Move down page" },
    ["<C-u>"] = { "Hzz", "Move up page" },
    ["<C-d>"] = { "Lzz", "Move down page" },

    ["j"] = { "gj", "Down" },
    ["<k>"] = { "gk", "Up" },

    -- ["<M-;>"] = { ";", "Next FTft" },
    -- ["<M-,>"] = { ",", "Previous FTft" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<Tab>"] = { "<cmd> bn <CR>", "Next buffer" },
    ["<S-Tab>"] = { "<cmd> bp <CR>", "Previous buffer" },
    ["<M-d>"] = { "<cmd> bd! <CR>", "Close buffer" },
  },
  i = {},
  v = {
    ["J"] = { ":m '>+1<CR>gvgv=gv" },
    ["K"] = { ":m '<-2<CR>gvgv=gv" },

    [">"] = { ">gv" },
    ["<"] = { "<gv" },
  },
}

set_key_mappings(key_mappings)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- vim.keymap.set("n", ";", ":")
vim.keymap.set({ "n", "v" }, "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { expr = true, desc = "Move down" })

vim.keymap.set({ "n", "v" }, "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { expr = true, desc = "Move up" })

-- Diagnostic keymaps

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
