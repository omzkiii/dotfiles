#!/bin/bash
wal --theme ~/Themes/Kanagawa/pywal-kanagawa.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-kanagawa"
gsettings set org.gnome.desktop.interface icon-theme "oomox-kanagawa"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-kanagawa"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar &
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Kanagawa
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/camp.jpg --transition-type center
notify-send Kanagawa
