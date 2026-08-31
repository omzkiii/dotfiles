local M = {}

M.opacity = 1
M.terminal = "kitty -o background_opacity=" .. M.opacity
M.scriptPath = "~/.config/hypr/scripts"
M.color = dofile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua")
M.fileManager = M.terminal .. " lf"
M.taskManager = M.terminal .. " btop"
M.editor = M.terminal .. " nvim"
M.rofiScriptPath = ".config/rofi/scripts"

function M.toggle_scrolling()
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
end

function M.fit_into_scroll()
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
end

---@param dir "left"|"right"|"up"|"down"
function M.move_window(dir)
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
end

---@param name string
---@param exec string
function M.toggle_term_app(name, exec)
	return function()
		local w = hl.get_window("title:(^" .. name .. "$)")
		if w == nil then
			hl.dispatch(hl.dsp.exec_cmd(M.terminal .. " --single-instance -T " .. name .. " " .. exec))
			return
		else
			hl.dispatch(hl.dsp.window.kill({ window = "title:(^" .. name .. "$)" }))
		end
	end
end

return M
