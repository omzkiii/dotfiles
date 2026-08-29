-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function()
	hl.exec_cmd("hypridle")
	hl.exec_cmd("~/.config/hypr/scripts/sleep.sh")
	hl.exec_cmd("~/.config/hypr/scripts/waybar.sh & awww-daemon")
	hl.exec_cmd("poweralertd")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)

