vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
})
vim.lsp.enable {
  "lua_ls",
  "pyright",
  "gopls",
  -- "jdtls",
  "clangd",
  "ruff",
  "debugpy",
  "codelldb",
  "ts_ls",
  "eslint_d",
  "htmx",
  "tailwindcss",
  "harper_ls",
}

local signs = {
  Error = " ",
  Warn = " ",
  Hint = "󰌵 ",
  Info = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    vim.diagnostic.config {
      virtual_text = false, -- disables inline text
      signs = true, -- keep the sign column indicators
      underline = false, -- optional: disable underline
      update_in_insert = false, -- optional: don't update in insert mode
      severity_sort = true, -- optional: sort by severity
    }
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc, noremap = true })
    end

    map("<leader>ra", "<cmd>lua vim.lsp.buf.rename(); vim.cmd('wa')<CR>", "Rename")
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<leader>lf", function()
      -- vim.diagnostic.open_float { border = "single" }
      vim.diagnostic.config { virtual_lines = { current_line = true }, virtual_text = false }
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
        callback = function()
          vim.diagnostic.config { virtual_lines = false, virtual_text = false, signs = true }
          return true
        end,
      })
    end, "Floating Diagnostics")
    map("K", function()
      vim.lsp.buf.hover { border = "single" }
    end, "Hover")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
        end,
      })
    end
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})
