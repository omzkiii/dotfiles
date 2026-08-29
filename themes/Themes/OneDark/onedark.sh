#!/bin/bash
wal --theme ~/Themes/OneDark/pywal-onedark.json
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
gsettings set org.gnome.desktop.interface gtk-theme "oomox-onedark"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-onedark"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-onedark"
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme OneDark
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/onedark.png --transition-type center
notify-send Onedark

