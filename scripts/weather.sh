#!/usr/bin/env bash

TERMINAL="kitty --hold -e"
FLAGS="-q"

# Ensure pywal colors are available
if [ -f "${HOME}/.cache/wal/colors.sh" ]; then
    . "${HOME}/.cache/wal/colors.sh"
else
    echo "Pywal colors not found. Please generate colors with pywal first."
    exit 1
fi

# Prompt for city and fetch the weather using dmenu with pywal colors
city=$(echo "Enter city name or ESC to view current city" | dmenu -i -l 1 -p "City: " -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15")
choice="wttr.in/${city}"

$TERMINAL curl $FLAGS $choice
