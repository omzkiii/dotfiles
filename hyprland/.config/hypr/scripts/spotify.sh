#!/usr/bin/env bash


player=$(playerctl -l 2>/dev/null | grep -E 'spotifyd|spotify' | head -n 1)
player_status=$(playerctl -p "$player" status 2>/dev/null)

	# if [ -z "$(playerctl -p "$player" metadata album)" ]; then
	# 	if [ "$player_status" = "Playing" ]; then
	# 		echo "$(playerctl -p "$player" metadata artist) - $(playerctl -p spotify metadata title)"
	# 	elif [ "$player_status" = "Paused" ]; then
	# 		echo "   $(playerctl -p "$player" metadata artist) - $(playerctl -p spotify metadata title)"
	#    else
	# 		echo ""
	# 	fi
	# else
if [[ $player == "" ]]; then
	echo ""
else
	if [ "$player_status" = "Playing" ]; then
		echo ♪  $(playerctl -p "$player" metadata artist) - $(playerctl -p "$player" metadata title)
	elif [ "$player_status" = "Paused" ]; then
		echo ♪ $(playerctl -p "$player" metadata artist) - $(playerctl -p "$player" metadata title)
	fi
fi
fi

	# sleep 1

