#!/bin/bash
wal --theme ~/Themes/AyuDark/pywal-ayudark.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-ayudark"
gsettings set org.gnome.desktop.interface icon-theme "oomox-ayudark"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-ayudark"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar &
cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Spotify
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/711-korean-night.jpg --transition-type center
notify-send AyuDark
