#!/bin/bash
# Replace any occurance of dmenu with rofi-dmenu to make this a rofi menu instead of dmenu 

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

# Directory where your scripts are stored
SCRIPTS_DIR="/home/j3ll0/.config/scripts/"

# Function to get the remaining snooze time
get_remaining_snooze_time() {
    if [ -f /tmp/snooze_end_time ]; then
        snooze_end_time=$(cat /tmp/snooze_end_time)
        current_time=$(date +%s)
        remaining_time=$((snooze_end_time - current_time))

        if (( remaining_time > 0 )); then
            echo $remaining_time
        else
            rm /tmp/snooze_end_time
            echo "0"
        fi
    else
        echo "0"
    fi
}

# Get dunst status and remaining snooze time
if dunstctl is-paused | grep -q "true"; then
    status="  SILENCED"
    remaining_time=$(get_remaining_snooze_time)
    if (( remaining_time > 0 )); then
        snooze_timer=" (Resumes in $((remaining_time / 60))m $((remaining_time % 60))s)"
    else
        snooze_timer=""
    fi
else
    status="  ACTIVE"
    snooze_timer=""
fi

# Get the number of pending notifications
num_notifications=$($SCRIPTS_DIR/count_notifications.sh)

# Define the options to be presented in dmenu
OPTIONS=$(cat <<EOF
$status$snooze_timer ($num_notifications) ( + N)
⏰ SNOOZE NOTIFICATIONS
📂 FAV PLACES (ROG KEY)
🔎 WEB SEARCH (  + S)
🔗 WEB FAVS
🗓️ CALENDAR
🌂 WEATHER
💡 DWM KEYHINTS (F5)
💡 VIM KEYHINTS (SHIFT + F5)
🛠️ MAINTENANCE
📊 MISSION CENTER (  + ESCAPE)
🔌 POWER OPTIONS (  + X)
💻 REDSHIFT (SHIFT + F9)
💻 PICOM TOGGLE
🐧 RECOMPILE (  + SHIFT + R)
💻 SCREEN OFF (F11)
EOF
)

# Use dmenu to select an option
CHOICE=$(echo -e "$OPTIONS" | dmenu -i -l 23 -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -p " " -fn "Times New Roman-20" )

# Check if no option was selected (Escape was pressed)
if [ -z "$CHOICE" ]; then
    exit 0
fi

# Launch the corresponding script based on the choice
case $CHOICE in
    "  SILENCED"*)
        $SCRIPTS_DIR/pause_dunst.sh
        ;;
    "  ACTIVE"*)
        $SCRIPTS_DIR/pause_dunst.sh
        ;;
    "📂 FAV PLACES (ROG KEY)")
        $SCRIPTS_DIR/dwmfolders.sh
        ;;
    "📢 MANAGE NOTIFICATIONS")
        $SCRIPTS_DIR/pause_dunst.sh
        ;;
    "🗓️ CALENDAR")
        gnome-calendar
        ;;
    "🌂 WEATHER")
        /home/j3ll0/.config/polybar/scripts/weather.sh
        ;;
    "💡 DWM KEYHINTS (F5)")
        /home/j3ll0/.config/polybar/scripts/keyhintdwm.sh
        ;;
    "💡 VIM KEYHINTS (SHIFT + F5)")
        /home/j3ll0/.config/polybar/scripts/keyhintvim.sh
        ;;
    "🛠️ MAINTENANCE")
        /home/j3ll0/.config/scripts/maintenance.sh
        ;;
    "🔌 POWER OPTIONS (  + X)")
        $SCRIPTS_DIR/powermenu/powermenu.sh
        ;;
    "🔎 WEB SEARCH (  + S)")
        $SCRIPTS_DIR/dmenu-websearch.sh
        ;;
    "🔗 WEB FAVS")
        $SCRIPTS_DIR/dmenu-bookmark.sh
        ;;
    "📊 MISSION CENTER (  + ESCAPE)")
        exec missioncenter
        ;;
    "💻 REDSHIFT (SHIFT + F9)")
        /home/j3ll0/.config/scripts/redshift.sh
        ;;
    "💻 PICOM TOGGLE")
        /home/j3ll0/.config/scripts/picom-toggle.sh
        ;;
    "🐧 RECOMPILE (  + SHIFT + R)")
        exec kitty -e /home/j3ll0/.suckless/recompile.sh
        ;;
    "💻 SCREEN OFF (F11)")
        xset dpms force off
        ;;
    "⏰ SNOOZE NOTIFICATIONS")
        snooze_time=$(echo -e "5m\n10m\n15m\n30m\n90m\n120m\n180m" | dmenu -i -p "Snooze for:" -nb $background -nf $foreground -sb $color1 -sf $foreground)
        if [ -n "$snooze_time" ]; then
            notify-send "⏰ Notifications snoozed" "Notifications will be paused for $snooze_time."
            dunstctl set-paused true
            snooze_end_time=$(($(date +%s) + $(echo $snooze_time | sed 's/[a-z]//g') * 60))
            echo $snooze_end_time > /tmp/snooze_end_time
            sleep $snooze_time && dunstctl set-paused false && notify-send "📨 Notifications resumed" "Snooze period ended."
        fi
        ;;
    *)
        echo "No valid option chosen."
        ;;
esac
