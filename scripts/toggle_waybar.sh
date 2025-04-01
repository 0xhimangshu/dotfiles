#!/bin/bash

if pgrep -x "waybar" > /dev/null; then
    hyprctl dispatch exec pkill waybar
else
    hyprctl dispatch  exec waybar &
fi

