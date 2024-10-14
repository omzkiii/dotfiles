lua << EOF
-- NOTE: GUI Options
-------------
-- Nvim-qt --
-------------

if vim.g.GuiLoaded then
  -- local font_name = "Iosevka Nerd Font"
  local font_name = "MesloLGS Nerd Font"
  local font_size = 12
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
vim.opt.linespace = 1
-- vim.opt.guifont = "MesloLGS Nerd Font:h12"
  vim.opt.guifont = "Iosevka Nerd Font:h12"
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
  vim.keymap.set("n", "<F11>", toggle_fullscreen, { silent = true })
  vim.keymap.set("n", "<F10>", toggle_transparency, { silent = true })
end

EOF
