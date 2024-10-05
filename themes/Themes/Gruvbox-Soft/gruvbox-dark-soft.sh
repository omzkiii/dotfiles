#!/bin/bash
wal --theme ~/Themes/Gruvbox-Soft/pywal-gruvbox-dark-soft.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-gruvbox-dark-soft"
gsettings set org.gnome.desktop.interface icon-theme "oomox-gruvbox-dark-soft"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-gruvbox-dark-soft"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar &
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Gruvbox
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/wall.jpg --transition-type center
notify-send Gruvbox-Soft
