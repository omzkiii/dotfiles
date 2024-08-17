#!/bin/bash
wal --theme ~/Themes/RosePine/pywal-rosepine.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-rosepine"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-rosepine"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-rosepine"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme RosePine
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/darkflower.png --transition-type center
notify-send RosePine
