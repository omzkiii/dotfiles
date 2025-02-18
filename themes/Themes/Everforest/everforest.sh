#!/bin/bash
wal --theme ~/Themes/Everforest/pywal-everforest.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-everforest"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-everforest"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-everforest"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Everforest
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/ghibli-japanese-walled-garden.png --transition-type center
notify-send Everforest
