---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    --page movement
    ["<C-u>"] = { "<C-u>zz", "Move up page" },
    ["<C-d>"] = { "<C-d>zz", "Move down page" },

    ["<tab>"] = { "<cmd>bn<CR>", "Next buffer" },
    ["<S-tab>"] = { "<cmd>bp<CR>", "Previous buffer" },
    ["<M-d>"] = { "<cmd>bd<CR>", "Close buffer" },

    ["<leader>fs"] = {
      "<cmd> Telescope lsp_document_symbols <CR>",
      "LSP document symbols",
    },

    ["<leader>fd"] = {
      "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>",
      "LSP dynamic workspace symbols",
    },

    ["<leader>s"] = {
      "<cmd> Telescope spell_suggest <CR>",
      "Spell Suggest",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },

    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
  },

  t = {
    ["<C-k>"] = {
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "n", true)
        -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>k", true, true, true), 'n', true)
        vim.cmd "wincmd p"
      end,
      "Move away from terminal",
    },
  },
}

M.telescope = {
  n = {
    ["<M-tab>"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    -- ['<C-d>'] = require('telescope.actions').delete_buffer
    -- ["<M-d>"] = {
    --     "<cmd> require('telescope.actions').delete_buffer <CR>",
    --   "Close buffer",
    -- },
  },
}

M.lspconfig = {
  n = {
    ["gr"] = {
      "<cmd> Telescope lsp_references <CR>",
      "LSP references",
    },
  },
}

return M
