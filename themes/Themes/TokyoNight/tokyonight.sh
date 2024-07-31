#!/bin/bash
wal --theme ~/Themes/TokyoNight/pywal-tokyonight.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-tokyodark"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-tokyodark"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-tokyodark"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme TokyoNight
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/fullcolor.jpg --transition-type center
notify-send TokyoNight
