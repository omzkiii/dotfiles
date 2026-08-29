--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
	},
	float = true,
	fullscreen = false,
	pin = false,

	no_focus = true,
})

hl.window_rule({
	name = "books",
	match = {
		class = "^(kitty)$",
		title = "^(Books)$",
		xwayland = false,
	},
	float = true,
	fullscreen = false,
	pin = false,

	no_focus = false,
})

hl.window_rule({
	name = "projects",
	match = {
		class = "^(kitty)$",
		title = "^(Projects)$",
		xwayland = false,
	},
	float = true,
	fullscreen = false,
	pin = false,
	no_focus = false,
    size = {"(monitor_w*0.7)", "(monitor_h*0.5)"}
})

hl.window_rule({
	name = "tasks",
	match = {
		class = "^(kitty)$",
		title = "^(Tasks)$",
		xwayland = false,
	},
	float = true,
	fullscreen = false,
	pin = false,
    size = {"(monitor_w*0.5)", "(monitor_h*0.5)"},

	no_focus = false,
})

hl.window_rule({
	name = "idleinhibit",
	match = {
		class = "^(.*)$",
		title = "^(.*)$",
		xwayland = false,
		float = false,
		fullscreen = true,
		pin = false,
	},

	no_focus = false,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.layer_rule({
	name = "notifications",
	match = { namespace = "notification" },
	animation = "slide",
})

hl.layer_rule({
	name = "rofi",
	match = { namespace = "rofi" },
	dim_around = true
})

hl.layer_rule({
	name = "hyprpicker",
	match = { namespace = "hyprpicker" },
	animation = "fade",
})

hl.layer_rule({
	name = "selection",
	match = { namespace = "selection" },
	animation = "fade",
})
