vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
  files = {
    watch = true,
  },
})
vim.lsp.enable {
  "lua_ls",
  "pyright",
  "gopls",
  "dockerfile",
  "dockercompose",
  "emmet",
  "clangd",
  "css",
  "debugpy",
  "codelldb",
  "typescript-language-server",
  "eslint",
  "htmx",
  "tailwindcss",
  "harper_ls",
}
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    -- OPTIONS
    local signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅙 ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "󰌵 ",
        [vim.diagnostic.severity.INFO] = " ",
      },
      linehl = {
        -- [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        -- [vim.diagnostic.severity.WARN] = "WarningMsg",
        -- [vim.diagnostic.severity.HINT] = "HintMsg",
        -- [vim.diagnostic.severity.INFO] = "Info",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        [vim.diagnostic.severity.WARN] = "WarningMsg",
        [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        [vim.diagnostic.severity.INFO] = "DiagnosticsInfo",
      },
    }

    vim.diagnostic.config {
      virtual_text = false, -- disables inline text
      underline = false, -- optional: disable underline
      update_in_insert = false, -- optional: don't update in insert mode
      severity_sort = true, -- optional: sort by severity
      signs = signs,
    }

    -- MAPPINGS
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc, noremap = true })
    end

    map("<leader>ra", "<cmd>lua vim.lsp.buf.rename(); vim.cmd('wa')<CR>", "Rename")
    -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    -- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    -- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    -- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<leader>lf", function()
      -- vim.diagnostic.open_float { border = "single" }
      vim.diagnostic.config { virtual_lines = { current_line = true }, virtual_text = false }
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
        callback = function()
          vim.diagnostic.config { virtual_lines = false, virtual_text = false, signs = signs }
          return true
        end,
      })
    end, "Floating Diagnostics")
    map("K", function()
      vim.lsp.buf.hover { border = "single", max_width = 80 }
    end, "Hover")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- AUTOCMD
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

    -- PLUGINS
    -- local navic = require "nvim-navic"
    -- function get_name()
    --   local icons = require "mini.icons"
    --   local parent = vim.fn.fnamemodify(vim.fn.expand "%:h", ":t")
    --   local filename = vim.fn.expand "%:t" .. " %#IblIndent# "
    --   local display_name = parent .. "/" .. filename .. "  "
    --   local extension = vim.fn.expand "%:e"
    --   local icon, icon_hl = icons.get("extension", extension)
    --   -- local icon = icon_data.icon or " "
    --   -- local icon_hl = icon_data.hl or "MiniIconsDefault"
    --   local result = "%#" .. icon_hl .. "#" .. icon .. "%* " .. filename
    --   if navic.is_available() then
    --     return result .. navic.get_location()
    --   else
    --     return result
    --   end
    -- end

    -- navic.attach(client, event.buf)
    -- print "NAVIC"
    -- vim.o.winbar = "%{%v:lua.get_name()%}"
    -- vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
  end,
})
