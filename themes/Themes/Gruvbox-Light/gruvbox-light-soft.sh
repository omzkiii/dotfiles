#!/bin/bash
wal --theme ~/Themes/Gruvbox-Light/pywal-gruvbox-light-soft.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-gruvbox-light-soft"
gsettings set org.gnome.desktop.interface icon-theme "oomox-gruvbox-light-soft"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-gruvbox-light-soft"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar &
cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Spotify
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/Sif.png --transition-type center
notify-send Gruvbox-Light
