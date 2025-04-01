#!/bin/bash

# Function to get current volume
get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

# Change volume
case $1 in
up)
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    ;;
down)
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    ;;
esac

# Get the new volume
VOLUME=$(get_volume)

# Send notification
notify-send "Volume" "Volume: ${VOLUME}%" \
    -h int:value:$VOLUME \
    -h string:synchronous:volume \
    -t 1000 \
    -c volume
