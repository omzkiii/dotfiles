return {
  "samir-roy/code-bridge.nvim",
  config = function()
    require("code-bridge").setup()
    -- Basic tmux commands
    vim.keymap.set("n", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send file to claude" })
    vim.keymap.set("v", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send selection to claude" })
    vim.keymap.set("n", "<leader>ca", ":CodeBridgeTmuxAll<CR>", { desc = "Send all buffers to claude" })

    -- Advanced tmux commands
    vim.keymap.set("n", "<leader>ci", ":CodeBridgeTmuxInteractive<CR>", { desc = "Interactive prompt to claude" })
    vim.keymap.set("n", "<leader>cd", ":CodeBridgeTmuxDiff<CR>", { desc = "Send git diff to claude" })
    vim.keymap.set("n", "<leader>cr", ":CodeBridgeTmuxRecent<CR>", { desc = "Send recent files to claude" })
    vim.keymap.set("n", "<leader>ce", ":CodeBridgeTmuxDiagnostics<CR>", { desc = "Send diagnostics to claude" })

    -- Chat interface
    vim.keymap.set("n", "<leader>cq", ":CodeBridgeQuery<CR>", { desc = "Query claude with context" })
    vim.keymap.set("v", "<leader>cq", ":CodeBridgeQuery<CR>", { desc = "Query claude with selection" })
    vim.keymap.set("n", "<leader>cc", ":CodeBridgeChat<CR>", { desc = "Chat with claude" })
    vim.keymap.set("n", "<leader>ch", ":CodeBridgeHide<CR>", { desc = "Hide chat window" })
    vim.keymap.set("n", "<leader>cs", ":CodeBridgeShow<CR>", { desc = "Show chat window" })
    vim.keymap.set("n", "<leader>cx", ":CodeBridgeWipe<CR>", { desc = "Wipe chat and clear history" })
    vim.keymap.set("n", "<leader>ck", ":CodeBridgeCancelQuery<CR>", { desc = "Cancel running query" })
    vim.keymap.set("n", "<leader>cp", ":CodeBridgeResumePrompt<CR>", { desc = "Resume hidden prompt" })
  end,
}
