return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" }, -- Added command triggers for efficiency
  opts = {
    enhanced_diff_hl = true, -- Optional: cleaner highlights
    view = {
      -- Note: removed the leading space and put it inside 'view'
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
    },
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
    { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
  },
}
