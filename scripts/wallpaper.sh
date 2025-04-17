#!/bin/bash

# Directory containing wallpapers
wallpaper_dir="/mnt/4681ad39-ed76-4fe7-ab87-d3a03816a8a1/Wallpaper/"

# Function to change wallpaper
change_wallpaper() {
    if [ -d "$wallpaper_dir" ] && [ "$(ls -A $wallpaper_dir)" ]; then
        # Pick a random wallpaper
        wallpaper=$(ls "$wallpaper_dir"/* | shuf -n 1)

        # Apply it with pywal
        wal -q -i "$wallpaper" -n

        # Source the colors
        source ~/.cache/wal/colors.sh

        # Use xwallpaper to apply the final wallpaper
        xwallpaper --zoom "$wallpaper"

        # Update pywalfox
        pywalfox update

        echo "Wallpaper changed successfully!"
    else
        echo "Error: Wallpaper directory is empty or does not exist."
        exit 1
    fi
}

# Check for interval option
if [ "$1" == "--interval" ]; then
    interval=$2
    if [ -z "$interval" ]; then
        echo "Error: No interval specified."
        exit 1
    fi

    # Loop to change wallpaper at specified intervals
    while true; do
        change_wallpaper
        sleep "$interval"
    done
else
    # Change wallpaper once
    change_wallpaper
fi
