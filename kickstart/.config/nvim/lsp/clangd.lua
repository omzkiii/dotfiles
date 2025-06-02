return {
  cmd = { "clangd", "--log=verbose", "--compile-commands-dir=./build", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
}
