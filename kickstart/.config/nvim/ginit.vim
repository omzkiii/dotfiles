lua << EOF
-- NOTE: GUI Options
-------------
-- Nvim-qt --
-------------

if vim.g.GuiLoaded then
  -- local font_name = "Iosevka Nerd Font"
  local font_name = "MesloLGS Nerd Font"
  local font_size = 15
  local not_transparent = false

  local function toggle_transparency()
    not_transparent = not not_transparent
    if not_transparent then
      vim.cmd("GuiWindowOpacity " .. (0.9))
    else
      vim.cmd("GuiWindowOpacity " .. (0.9))
    end
  end

  vim.keymap.set("n", "<F10>", toggle_transparency, { silent = true })

  local function toggle_fullscreen()
    if vim.g.GuiWindowFullScreen == 0 then
      vim.cmd("call GuiWindowFullScreen(" .. 1 .. ")")
    else
      vim.cmd("call GuiWindowFullScreen(" .. 0 .. ")")
    end
  end

  vim.keymap.set("n", "<F11>", toggle_fullscreen, { silent = true })
  

  vim.cmd [[
  GuiTabline 0
  GuiPopupmenu 0
  ]]
  vim.cmd("GuiFont! " .. font_name .. ":h" .. font_size)

end

-------------
-- Neovide --
-------------

if vim.g.neovide then
vim.opt.linespace = 5
vim.opt.guifont = "Inconsolata Nerd Font:h15"
-- vim.opt.guifont = "MesloLGMDZ Nerd Font:h15"
  -- vim.opt.guifont = "Iosevka NFM:h15:w10"
  -- vim.opt.guifont = "Iosevka Nerd Font:h15:w0"
  -- vim.opt.guifont = "InconsolataGo Nerd Font:h15"
  -- vim.opt.guifont = "DejaVu Sans Mono:h15"
  vim.g.remember_window_size = false
  vim.g.remember_window_position = false
  -- vim.g.neovide_transparency = 0.95
  vim.g.experimental_layer_grouping = false
  vim.g.neovide_floating_shadow = false
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_cursor_vfx_particle_density = 70.0
  -- vim.g.neovide_cursor_vfx_particle_lifetime = 3.2
  -- vim.g.neovide_cursor_smooth_blink = true

-- Disable animation
vim.g.neovide_position_animation_length = 0.03
vim.g.neovide_cursor_animation_length = 0.03
-- vim.g.neovide_cursor_trail_size = 3
-- vim.g.neovide_cursor_animate_in_insert_mode = false
-- vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_scroll_animation_far_lines = 0
-- vim.g.neovide_scroll_animation_length = 0.50
-- vim.g.neovide_transparency = 0.95



vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 5
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10


if vim.g.neovide then
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      vim.cmd(":mksession!")
    end,
  })
end

if vim.g.neovide then
  vim.api.nvim_create_autocmd("UIEnter", {
    once= true,
    callback = function()
    vim.defer_fn(function()
      vim.cmd(":source Session.vim")
    end, 0.1)
    end,
  })
end
  local function IncreasePadding()
      -- Get the current padding values or default to 0 if not set
      local right = tonumber(vim.g.neovide_padding_right or 10)
      local left = tonumber(vim.g.neovide_padding_left or 10)

      -- Increment the padding values
      right = right + 10
      left = left + 10

      -- Set the updated values back to vim.g
      vim.g.neovide_padding_right = right
      vim.g.neovide_padding_left = left
  end
  local function DecreasePadding()
      -- Get the current padding values or default to 0 if not set
      local right = tonumber(vim.g.neovide_padding_right or 0)
      local left = tonumber(vim.g.neovide_padding_left or 0)

      -- Increment the padding values
      right = right - 10
      left = left - 10

      -- Set the updated values back to vim.g
      vim.g.neovide_padding_right = right
      vim.g.neovide_padding_left = left
  end
  
  local function IncreaseFontSize()
      local current_font = vim.opt.guifont:get()
      local font_name, current_size = string.match(current_font[1], "([^:]+):h(%d+)")
      current_size = tonumber(current_size) + 1
      vim.opt.guifont = font_name .. ":h" .. current_size
  end

  local function DecreaseFontSize()
      local current_font = vim.opt.guifont:get()
      local font_name, current_size = string.match(current_font[1], "([^:]+):h(%d+)")
      current_size = tonumber(current_size) - 1
      vim.opt.guifont = font_name .. ":h" .. current_size
  end


  local function toggle_transparency()
    if vim.g.neovide_transparency == 1.0 then
      vim.cmd "let g:neovide_transparency=0.8"
    else
      vim.cmd "let g:neovide_transparency=1.0 "
    end
  end

  local function toggle_fullscreen()
    if vim.g.neovide_fullscreen == false then
      vim.cmd "let g:neovide_fullscreen=v:true"
    else
      vim.cmd "let g:neovide_fullscreen=v:false"
    end
  end
  vim.keymap.set('n', '<C-=>', IncreaseFontSize, { noremap = true, silent = true })
  vim.keymap.set('n', '<C-->', DecreaseFontSize, { noremap = true, silent = true })
  vim.keymap.set('n', '<C-->', DecreaseFontSize, { noremap = true, silent = true })
  vim.keymap.set('n', '<C-+>', IncreasePadding, { noremap = true, silent = true })
  vim.keymap.set('n', '<C-_>', DecreasePadding, { noremap = true, silent = true })
  vim.keymap.set("n", "<F11>", toggle_fullscreen, { silent = true })
  vim.keymap.set("n", "<F10>", toggle_transparency, { silent = true })
end

EOF
