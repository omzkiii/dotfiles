#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/wofi/powermenu/type-1"
theme='style-2'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown='󰐥'
reboot=''
lock=''
#suspend='󰏦  Suspend'
logout='󰿅'
yes='  Yes'
no='  No'

# wofi CMD
wofi_cmd() {
	wofi -dmenu \
		-p "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	wofi -theme-str 'window {width: 500px; location: center; anchor: center; fullscreen: false;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {font: "MesloLGS Nerd Font 18"; horizontal-align: 0.5; padding: 10px;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to wofi dmenu
run_wofi() {
	echo -e "$lock\n$logout\n$reboot\n$shutdown" | wofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			tmux kill-server &
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			tmux kill-server &
			systemctl reboot
		elif [[ $1 == '--lock' ]]; then
			# tmux kill-server &&
			$HOME/.config/hypr/scripts/lock
		# elif [[ $1 == '--suspend' ]]; then
		# 	mpc -q pause
		# 	amixer set Master mute
		# 	systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			tmux kill-server &
			hyprctl dispatch exit
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_wofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
    run_cmd --lock
        ;;
  #   $suspend)
		# run_cmd --suspend
  #       ;;
    $logout)
		run_cmd --logout
        ;;
esac
