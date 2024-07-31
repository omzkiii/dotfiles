#!/bin/bash
wal --theme ~/Themes/Dracula/pywal-dracula.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-dracula"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-dracula"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-dracula"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Dracula
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/arch-dracula.png --transition-type center
notify-send Dracula
