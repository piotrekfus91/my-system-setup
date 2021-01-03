#!/bin/bash -x

operator=$([ "$1" == "up" ] && echo "+" || echo "-")

current_brigthness=$(xrandr --verbose | grep -m 1 Brightness | awk '{print $2}')
new_brigthness=$(echo "$current_brigthness $operator 0.1" | bc)
xrandr --output eDP1 --brightness $new_brigthness
notify-send "Brightness: $new_brigthness" -t 1000