local u = require("modules.utils")
---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

-- Programs
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(u.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(u.fileManager))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(u.editor))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd(u.taskManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(u.terminal .. " --single-instance -T Tasks taskwarrior-tui"))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.kill({ window = "title:(^Tasks$)" }))
hl.bind(
	mainMod .. " + slash",
	hl.dsp.exec_cmd(u.terminal .. " --single-instance -T Projects " .. u.scriptPath .. "/ff.sh")
)
hl.bind(mainMod .. " + slash", hl.dsp.window.kill({ window = "title:(^Projects$)" }))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(u.terminal .. " -T tmux tmux attach"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("cd ~/Documents/Notes/Notes && " .. u.terminal .. " nvim TODOs.md"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("killall waybar || waybar"))

-- WM operations
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", u.toggle_scrolling)
hl.bind(mainMod .. " + SHIFT + F", u.fit_into_scroll)

-- Rofi
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(u.rofiScriptPath .. "/launcher || pkill rofi"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(u.rofiScriptPath .. "/wallpaper || pkill rofi"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(u.rofiScriptPath .. "/themes || pkill rofi"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(u.rofiScriptPath .. "/powermenu || pkill rofi"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(u.rofiScriptPath .. "/books || pkill rofi"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(u.rofiScriptPath .. "/calc || pkill rofi"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(u.rofiScriptPath .. "/emoji || pkill rofi"))
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.exec_cmd(u.rofiScriptPath .. "/newproject || pkill rofi"))

-- Move focus with mainMod
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod
hl.bind(mainMod .. " + SHIFT + H", u.move_window("left"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", u.move_window("right"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", u.move_window("up"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", u.move_window("down"), { repeating = true })

-- Resize window with mainMod
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5% && " .. u.scriptPath .. "/volume up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5% && " .. u.scriptPath .. "/volume down"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(u.scriptPath .. "/volume mute"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("xbacklight +5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("xbacklight -2"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"), { locked = true })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("slurp -c 00000010| grim -g - - | wl-copy"), { locked = true })
hl.bind(
	mainMod .. " + SHIFT + Print",
	hl.dsp.exec_cmd(
		"grim /home/geo/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S.png') && notify-send \"Screenshot Saved as\" $(date +'%Y-%m-%d-%H%M%S.png'"
	),
	{ locked = true }
)
