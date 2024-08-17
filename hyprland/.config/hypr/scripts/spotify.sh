#!/bin/sh


player_status=$(playerctl -p spotify status 2>/dev/null)

	# if [ -z "$(playerctl -p spotify metadata album)" ]; then
	# 	if [ "$player_status" = "Playing" ]; then
	# 		echo "$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
	# 	elif [ "$player_status" = "Paused" ]; then
	# 		echo "   $(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
	#    else
	# 		echo ""
	# 	fi
	# else
	if [ "$player_status" = "Playing" ]; then
		echo ♪  $(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)
	elif [ "$player_status" = "Paused" ]; then
		echo ♪ $(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)
	else
		echo ""
	fi
	fi

	# sleep 1

