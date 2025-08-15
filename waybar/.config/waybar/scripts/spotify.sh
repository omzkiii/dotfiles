#!/bin/sh
while true; do
	# player=$(playerctl -l 2>/dev/null | grep -E 'spotify_player|spotify' | head -n 1)
	#
	# if [ -z "$player" ]; then
	# 	echo ""
	# 	sleep 1
	# 	continue
	# fi
	#
	# player_status=$(playerctl -p "$player" status 2>/dev/null)
	#
	# if [ -z "$(playerctl -p "$player" metadata album 2>/dev/null)" ]; then
	# 	if [ "$player_status" = "Playing" ]; then
	# 		echo "$(playerctl -p "$player" metadata artist) - $(playerctl -p "$player" metadata title)"
	# 	elif [ "$player_status" = "Paused" ]; then
	# 		echo "   $(playerctl -p "$player" metadata artist) - $(playerctl -p "$player" metadata title)"
	# 	else
	# 		echo ""
	# 	fi
	# else
	# 	if [ "$player_status" = "Playing" ]; then
	# 		echo "<span color='#1db954'>tst</span> $(playerctl -p "$player" metadata artist) - $(playerctl -p "$player" metadata title)"
	# 	elif [ "$player_status" = "Paused" ]; then
	# 		echo "<span color='#1db954'> </span> $(playerctl -p "$player" metadata artist) - $(playerctl -p "$player" metadata title)"
	# 	else
	# 		echo ""
	# 	fi
	# fi
	echo '{}'

	sleep 1
done
