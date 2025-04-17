#!/bin/bash
# Script to display bookmarks in Dmenu

# Path to the bookmarks file
BOOKMARKS_FILE="/home/j3ll0/.config/scripts/floorp_bookmarks.txt"

# Read bookmarks from the file and display in Dmenu
dmenu_command=$(cat "$BOOKMARKS_FILE" | rofi -dmenu -i 20 -l 20 -p "Search Bookmarks")

# Execute the selected bookmark
if [ -n "$dmenu_command" ]; then
    xdg-open "$dmenu_command"
fi
