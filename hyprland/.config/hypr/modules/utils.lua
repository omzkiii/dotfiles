return {
	opacity = 1,
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

	--@param window window
	kill_window = function(window)
		 return hl.dsp.window.kill({
			class = "^(kitty)$",
			title = "^(Tasks)$",
		})
	end,
}
