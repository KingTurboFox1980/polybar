#!/bin/bash

# Path to the file containing URLs
FILE="/home/j3ll0/.config/scripts/dmenu_bookmarks.txt"
EDIT_OPTION="📝 Edit This List"

# Add the edit option to the top of the list of URLs
MENU=$(echo "$EDIT_OPTION" && cat "$FILE")

# Generate colors with pywal
wal -i /path/to/your/wallpaper.jpg

# Read colors from pywal
. "${HOME}/.cache/wal/colors.sh"

# Read the selected option using dmenu with pywal colors and set the window to 25 lines
URL=$(echo "$MENU" | rofi -dmenu -i -l 20 -p "Select website" -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -l 25)

# Check if the edit option was selected
if [ "$URL" == "$EDIT_OPTION" ]; then
    # Open the websites list file in Kate
    kate "$FILE"
elif [ -n "$URL" ]; then
    # Open the selected URL in the default web browser
    xdg-open "$URL"
else
    echo "No website selected."
fi
