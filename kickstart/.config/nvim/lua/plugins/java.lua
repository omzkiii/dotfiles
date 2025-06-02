return {
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    config = function()
      vim.lsp.enable "jdtls"
    end,
  },
}
