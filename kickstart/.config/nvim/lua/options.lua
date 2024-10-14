vim.opt.laststatus = 3
vim.g.vim_markdown_folding_style_pythonic = 2
vim.g.vim_markdown_folding_level = 6
vim.g.vim_markdown_conceal = 3
vim.g.vim_markdown_conceal_links = 1
-- vim.g.maplocalleader = "\\"
vim.g.vim_markdown_borderless_table = 1
-- vim.g.vim_markdown_folding_disabled = 1 -- markdown folding
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Allow breaking within lines
vim.opt.breakat = vim.o.breakat -- Set break indent to vim default (using arabic characters to avoid keyword conflict)
vim.o.cmdheight = 0
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.signcolumn = "number"
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Conceal Level
vim.opt.conceallevel = 3
vim.opt.concealcursor = ""

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  -- eol = "↵",
  -- space = "·",
  extends = "›",
  precedes = "‹",
  -- lead = "·",
  -- multispace = "···+",
}
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Key mapping
-- vim.api.nvim_set_keymap("n", "<leader>g", ":lua Google()<CR>", { noremap = true, silent = true })
--
-- -- Google function
-- function Google()
--   -- Get the word under the cursor
--   local keyword = vim.fn.expand "<cword>"
--
--   -- Construct the URL
--   local url = "http://www.google.com/search?q=" .. keyword
--
--   -- Construct and execute the command
--   local cmd = string.format('xdg-open "%s"', url)
--
--   -- Execute the command
--   vim.fn.jobstart(cmd, { detach = true })
-- end
--

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt.numberwidth = 2
    -- vim.opt.foldcolumn = "2"
    -- vim.opt.foldenable = false
  end,
})
-- Key mapping
vim.api.nvim_set_keymap("n", "<leader>gg", ":lua OpenURL()<CR>", { noremap = true, silent = true })

-- Function to open URL
function OpenURL()
  -- Get the current line
  local current_line = vim.api.nvim_get_current_line()

  -- Extract the URL from within quotes
  local url = current_line:match 'https?://[^%)%s"]+'

  if not url then
    print "No URL found between quotes in the current line."
    return
  end

  -- Construct the command to open the URL
  local cmd = string.format('xdg-open "%s" &', url)
  -- local cmd = string.format('librewolf "%s" &', url)

  -- Execute the command
  vim.fn.jobstart(cmd, { detach = true })

  -- print("Opening URL: " .. url)
end

-- Key mapping
vim.api.nvim_set_keymap("n", "<leader>p", ":lua OpenPDFWithZathura()<CR>", { noremap = true, silent = true })

-- Function to open PDF with Zathura
function OpenPDFWithZathura()
  -- Get the current line
  local current_line = vim.api.nvim_get_current_line()

  -- Extract the file path from within quotes
  local file_path = current_line:match "[h+]"

  if not file_path then
    print "No file path found between quotes in the current line."
    return
  end

  -- Check if the file is a PDF
  if vim.fn.fnamemodify(file_path, ":e"):lower() ~= "pdf" then
    print "The file is not a PDF."
    return
  end

  -- Construct the command
  local cmd = string.format('zathura "%s" &', file_path)

  -- Execute the command
  vim.fn.jobstart(cmd, { detach = true })

  -- print("Opening PDF with Zathura: " .. file_path)
end

vim.api.nvim_set_keymap("n", "<leader>c=", ":set cmdheight=1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c-", ":set cmdheight=0<CR>", { noremap = true, silent = true })
