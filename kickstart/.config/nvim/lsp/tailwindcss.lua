return {
  cmd = { "tailwindcss-language-server" },
  filetypes = { "html", "javascriptreact", "typescriptreact" },
  root_markers = { "tailwind.config.*", "postcss.config.*", "package.json", ".git" },
  settings = {
    tailwindCSS = {
      classFunctions = { "clsx", "cn" },
    },
  },
}
