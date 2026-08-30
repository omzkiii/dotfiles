local opacity = 1
local terminal = "kitty -o background_opacity=" .. opacity

return {
	color = dofile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua"),
	opacity = opacity,
	terminal = terminal,
	fileManager = terminal .. " lf",
	taskManager = terminal .. " btop",
	editor = terminal .. " nvim",
	scriptPath = "~/.config/hypr/scripts",
	rofiScriptPath = ".config/rofi/scripts",
	toggle_scrolling = function()
		local ws = hl.get_active_workspace()
		if ws == nil then
			return
		end
		local current = ws.tiled_layout

		local next_layout = (current == "scrolling") and "master" or "scrolling"

		hl.workspace_rule({
			workspace = tostring(ws.id),
			layout = next_layout,
		})
	end,

	fit_into_scroll = function()
		local ws = hl.get_active_workspace()
		if ws == nil then
			return
		end
		local current = ws.tiled_layout

		if current ~= "scrolling" then
			hl.workspace_rule({
				workspace = tostring(ws.id),
				layout = "scrolling",
			})
		else
			hl.dispatch(hl.dsp.layout("fit active"))
		end

	end,
	---@param dir "left"|"right"|"up"|"down"
	move_window = function(dir)
		return function()
			local w = hl.get_active_window()
			if w == nil then
				return
			end
			local float_dir = {
				left = { x = -50, y = 0, relative = true },
				right = { x = 50, y = 0, relative = true },
				up = { x = 0, y = -50, relative = true },
				down = { x = 0, y = 50, relative = true },
			}

			local val = { direction = dir }
			if w.floating then
				val = float_dir[dir]
			end

			hl.dispatch(hl.dsp.window.move(val))
		end
	end,
}
