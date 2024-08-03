local plugin_dir = vim.fn.stdpath "config" .. "/lua/plugins/"
local plugins = {}

for _, file in ipairs(vim.fn.readdir(plugin_dir, [[v:val =~ '\.lua$']])) do
  local plugin = file:gsub("%.lua$", "")
  if plugin ~= "init" then
    table.insert(plugins, require("plugins." .. plugin))
  end
end

return plugins
