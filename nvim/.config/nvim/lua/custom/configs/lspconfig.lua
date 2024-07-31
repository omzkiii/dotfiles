local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require 'lspconfig'

-- lspconfig.htmx.setup{}
-- lspconfig.jdtls.setup{}
-- lspconfig.tailwindcss.setup{}
-- lspconfig.html.setup{}

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
  "nil_ls",
  "pyright",
  "ruff_lsp",
  "gopls",
  "jdtls",
  "tailwindcss",
}


for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
  }
end

--
-- -- Function to get include directories for a package
-- local function get_include_dirs(package_name)
--     local output = vim.fn.system("pkg-config --cflags " .. package_name )
--     if vim.v.shell_error ~= 0 then
--         return {}
--     end
--     return vim.fn.split(output, " ")
-- end
--
-- -- Function to get all include directories
-- local function get_all_include_dirs()
--     local include_dirs = {}
--     local packages = { "gtk4","glib-2.0", "gobject-2.0", "gio-2.0", "gmodule-2.0", "gdk-pixbuf-2.0",} -- Add more GTK related packages if needed
--     -- local packages = { "gtk+-2.0","glib-2.0", "gobject-2.0", "gio-2.0", "gmodule-2.0", "gdk-pixbuf-2.0",} -- Add more GTK related packages if needed
--     for _, package in ipairs(packages) do
--         local dirs = get_include_dirs(package)
--         for _, dir in ipairs(dirs) do
--             table.insert(include_dirs, dir)
--         end
--     end
--     return include_dirs
-- end
--
-- -- Set up clangd with pthreads
-- local clangd_flags = {
--   "-pthreads",
-- }
--
-- for _, dir in ipairs(get_all_include_dirs()) do
--     table.insert(clangd_flags, dir)
-- end
--
-- lspconfig.clangd.setup {
--     cmd = {
--         "clangd",
--         "--background-index",
--         "--suggest-missing-includes",
--         "--clang-tidy",
--     },
--     filetypes = { "c", "cpp", "objc", "objcpp" },
--     root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
--     init_options = {
--         clangdFileStatus = true,
--         usePlaceholders = true,
--         completeUnimported = true,
--         semanticHighlighting = true,
--         clangdResourceDir = "",
--         fallbackFlags = clangd_flags,
--     },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
--
-- lspconfig.null_ls.setup {
--   sources = {
--     null_ls.builtins.formatting.prettier, -- Replace with your desired formatter (e.g., stylua for Lua)
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- 
-- lspconfig.pyright.setup { blabla}
