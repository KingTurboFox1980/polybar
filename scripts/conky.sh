#!/bin/bash

# Define your Conky config paths
conky1="/home/j3ll0/.xmonad/scripts/system-overview.conkyrc"
conky2="/home/j3ll0/.xmonad/scripts/AUR-Allinone.conkyrc"

# Function to launch Conky with chosen config
launch_conky() {
    local config="$1"
    # Check if any Conky is running and kill it
    pkill conky
    # Start the new Conky using nohup
    nohup conky -c "$config" > /dev/null 2>&1 &
}

# Display options in dmenu and get user selection
choice=$(echo -e "system-overview\nAUR-Allinone" | dmenu -i -p "Choose Conky config:")

# Match user selection to config path
case "$choice" in
    "system-overview")
        launch_conky "$conky1"
        ;;
    "AUR-Allinone")
        launch_conky "$conky2"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
