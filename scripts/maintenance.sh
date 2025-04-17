#!/bin/bash

# Replace any occurrence of dmenu with rofi-dmenu to make this a rofi menu instead of dmenu 

# Import the color scheme
. "${HOME}/.cache/wal/colors.sh"

# Directory where your scripts are stored
SCRIPTS_DIR="/home/j3ll0/.config/scripts/"

# Function to check for updates
check_updates() {
    local pacman_updates=$(checkupdates 2>/dev/null | wc -l)
    local aur_updates=$(paru -Qua 2>/dev/null | wc -l)
    local total_updates=$((pacman_updates + aur_updates))
    
    if [ "$total_updates" -gt 0 ]; then
        echo "📦 $total_updates Update(s) Available"
    else
        echo "🛑 NO UPDATES"
    fi
}

# Get the update status
update_status=$(check_updates)

# Define the options to be presented in rofi
OPTIONS=$(cat <<EOF
$update_status
AUTOMATED MAINTENANCE
VIEW ERROR LOGS
DWM CONFIGS
GRAPHICS MODE
REDSHIFT
TIMESHIFT
DISK MANAGEMENT
SYSTEM MONITOR
KILL PROCESS
REPAIR PACMAN LOCK
BLEACHBIT
CONTROL PANEL
RETURN TO PREVIOUS MENU
EOF
)

# Use dmenu to select an option, with 5 lines added to the window height
CHOICE=$(echo -e "$OPTIONS" | dmenu -i -l 16 -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn "Times New Roman-20" -p "🔧")


# Launch the corresponding script based on the choice
case $CHOICE in
    "📦 "*)
        exec kitty -e paru
        ;;
    "🛑 NO UPDATES")
        echo "No updates available."
        ;;
    "AUTOMATED MAINTENANCE")
        exec kitty -e /home/j3ll0/update.sh
        ;;
    "VIEW ERROR LOGS")
        exec kitty -e journalctl -p err -xe
        ;;
    "DWM CONFIGS")
        $SCRIPTS_DIR/dwmconfig.sh
        ;;
    "GRAPHICS MODE")
        /home/j3ll0/.config/polybar/scripts/graphicsswitch.sh
        ;;
    "REDSHIFT")
        /home/j3ll0/.config/scripts/redshift.sh
        ;;
    "TIMESHIFT")
        exec timeshift-launcher 
        ;;
    "DISK MANAGEMENT")
        exec kitty -e /home/j3ll0/.config/polybar/scripts/disks.sh
        ;;
    "SYSTEM MONITOR")
        exec neohtop
        ;;
    "KILL PROCESS")
        /home/j3ll0/.config/scripts/dmenu-process.sh
        ;;
    "REPAIR PACMAN LOCK")
        exec kitty -e /home/j3ll0/.config/scripts/repair_pacman_lock.sh
        ;;
    "BLEACHBIT")
        exec bleachbit
        ;;
    "CONTROL PANEL")
        exec xfce4-settings-manager
        ;;
    "RETURN TO PREVIOUS MENU")
        exec /home/j3ll0/.config/scripts/rog_key_scripts.sh
        ;;
    *)
        echo "No valid option chosen."
        ;;
esac

exit 0
