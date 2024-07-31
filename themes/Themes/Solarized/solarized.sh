#!/bin/bash
wal --theme ~/Themes/Solarized/pywal-solarized.json
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
gsettings set org.gnome.desktop.interface gtk-theme "oomox-solarized"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-solarized"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-solarized"
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Solarized
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/solarized-plane-crash.png --transition-type center
notify-send Solarized

