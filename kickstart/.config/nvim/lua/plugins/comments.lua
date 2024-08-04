return {
  {
    "numToStr/Comment.nvim",
    -- keys = {
    --   { "<leader>/", mode = "n", desc = "Comment toggle current line" },
    --   { "<leader>/", mode = { "n", "o" }, desc = "Comment toggle linewise" },
    --   { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
    --   { "gbc", mode = "n", desc = "Comment toggle current block" },
    --   { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
    --   { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    -- },
    config = function(_, opts)
      require("Comment").setup(opts)
      vim.keymap.set("n", "<leader>/", function()
        require("Comment.api").toggle.linewise.current()
      end, { desc = "[/] Comment" })
      vim.keymap.set(
        "v",
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { desc = "[/] Comment" }
      )
    end,
  },
}
