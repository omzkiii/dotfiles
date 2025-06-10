-- HIGHLIGHTS
local colors = function()
  local norm = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local hint = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  local cursor = vim.api.nvim_get_hl(0, { name = "CursorColumn", link = false })
  local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  local nFloat = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
  local add = vim.api.nvim_get_hl(0, { name = "@character", link = false })

  local yellow = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
  -- local norm = vim.api.nvim_get_hl(0, { name = "Normal" })
  vim.api.nvim_set_hl(0, "LeapLabel", { bg = yellow.fg, fg = norm.bg, bold = true })
  -- vim.api.nvim_set_hl(0, "LeapLabelDimmed", {})
  -- vim.api.nvim_set_hl(0, "LeapLabelPrimary", {})
  vim.api.nvim_set_hl(0, "LeapBackdrop", { bg = comment.bg, fg = comment.fg })
  vim.api.nvim_set_hl(0, "LeapMatch", { bg = nFloat.bg, fg = comment.fg })
  --
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "NONE" })
  vim.api.nvim_set_hl(0, "RenderMarkdownLink", { underline = true })

  vim.api.nvim_set_hl(0, "FloatBorder", { fg = cursor.bg, bg = nFloat.bg })
  vim.api.nvim_set_hl(0, "FloatTitle", { fg = cursor.bg, bg = add.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerBoxBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "SnacksPickerListBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "SnacksPickerPreview", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "SnacksPickerList", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "SnacksPickerInput", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "SnacksPickerTitle", { link = "FloatTitle" })
  vim.api.nvim_set_hl(0, "SnacksPickerBoxTitle", { link = "FloatTitle" })
end
colors()
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = colors,
})
