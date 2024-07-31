#!/bin/bash
wal --theme ~/Themes/Catppuccin-Mocha/pywal-catppuccin-mocha.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-catppuccin-mocha"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-catppuccin-mocha"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-catppuccin-mocha"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Catppuccin-Mocha
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/catppuccin.png --transition-type center
notify-send Catppuccin-Mocha
