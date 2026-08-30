-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = "1",
})
-- monitor= eDP-1, 1920x1080@61,0x0,1
-- monitor= HDMI-A-1, 1360x768@60,1920x0,1

require("modules.devices")
require("modules.autostart")
require("modules.settings")
require("modules.keybinds")
require("modules.windows")
require("modules.animations")
require("modules.events")
