#!/bin/bash
# exec waybar

trap "killall waybar" EXIT

while true; do
    # \cp -r .cache/wal/colors-waybar.css .config/waybar &
    # waybar -c .config/waybar/config.json -s .config/waybar/style.css &
    ln -s $XDG_RUNTIME_DIR/hypr /tmp/hypr
	#create,modify $CONFIG_FILES
    killall waybar
    exec waybar
done
