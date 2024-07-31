#!/bin/bash
wal --theme ~/Themes/Nord/pywal-nord.json
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
gsettings set org.gnome.desktop.interface gtk-theme "oomox-nord"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-nord"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-nord"
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Nord
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/nord.png --transition-type center
notify-send Nord

