return {
  "SmiteshP/nvim-navic",
  -- event = "VeryLazy",
  config = function()
    require("nvim-navic").setup {
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰠱 ",
        Method = "󰆧 ",
        Property = "󰜢 ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘 ",
        Interface = " ",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰙅 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
      lsp = {
        auto_attach = true,
        preference = { "vue" },
      },
      highlight = true,
      separator = "  ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = false,
      -- format_text = function(text)
      --   local filename = vim.fn.expand "%:t" -- gets the tail of the file name
      --   return filename .. " > " .. text
      -- end,
    }
    -- vim.api.nvim_set_hl(0, "NavicIconsFile", { link = "" })
    vim.api.nvim_set_hl(0, "NavicIconsModule", { link = "@module" })
    vim.api.nvim_set_hl(0, "NavicIconsNamespace", { link = "@namespace" })
    vim.api.nvim_set_hl(0, "NavicIconsPackage", { link = "@module" })
    vim.api.nvim_set_hl(0, "NavicIconsClass", { link = "@lsp.type.class" })
    vim.api.nvim_set_hl(0, "NavicIconsMethod", { link = "@method" })
    vim.api.nvim_set_hl(0, "NavicIconsProperty", { link = "@property" })
    vim.api.nvim_set_hl(0, "NavicIconsField", { link = "@field" })
    vim.api.nvim_set_hl(0, "NavicIconsConstructor", { link = "@constructor" })
    vim.api.nvim_set_hl(0, "NavicIconsEnum", { link = "@lsp.type.enum" })
    vim.api.nvim_set_hl(0, "NavicIconsInterface", { link = "@lsp.type.interface" })
    vim.api.nvim_set_hl(0, "NavicIconsFunction", { link = "@function" })
    vim.api.nvim_set_hl(0, "NavicIconsVariable", { link = "@variable" })
    vim.api.nvim_set_hl(0, "NavicIconsConstant", { link = "@constant" })
    vim.api.nvim_set_hl(0, "NavicIconsString", { link = "@string" })
    vim.api.nvim_set_hl(0, "NavicIconsNumber", { link = "@number" })
    vim.api.nvim_set_hl(0, "NavicIconsBoolean", { link = "@boolean" })
    vim.api.nvim_set_hl(0, "NavicIconsArray", { link = "@lsp.type.enum" })
    vim.api.nvim_set_hl(0, "NavicIconsObject", { link = "@constructor" })
    vim.api.nvim_set_hl(0, "NavicIconsKey", { link = "@keyword" })
    -- vim.api.nvim_set_hl(0, "NavicIconsNull", { link = "" })
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { link = "@lsp.type.enumMember" })
    vim.api.nvim_set_hl(0, "NavicIconsStruct", { link = "@lsp.type.struct" })
    vim.api.nvim_set_hl(0, "NavicIconsEvent", { link = "@lsp.type.event" })
    vim.api.nvim_set_hl(0, "NavicIconsOperator", { link = "@operator" })
    vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { link = "@lsp.type.typePArameter" })
    vim.api.nvim_set_hl(0, "NavicText", { link = "SnacksIndentScope" })
    vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Comment" })
  end,
}
