return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    validate = true,
    useESLintClass = false,
    nodePath = "",
    experimental = {
      useFlatConfig = false,
    },
  },
}
