#!/bin/bash
# Replace any occurance of dmenu with rofi-dmenu to make this a rofi menu instead of dmenu 
#
# A simple dmenu session script with pywal colors
#
###

# Source pywal colors
source ~/.cache/wal/colors.sh

# Check if dunstctl and notify-send are available
if ! command -v dunstctl &> /dev/null || ! command -v notify-send &> /dev/null; then
    echo "dunstctl or notify-send not found. Please install them first."
    exit 1
fi

# Get dunst status
if dunstctl is-paused | grep -q "true"; then
    status="🔕 NOTIFICATIONS SILENCED"
else
    status="🔔 NOTIFICATIONS RUNNING"
fi

# Get the number of pending notifications
num_notifications=$(~/.config/scripts/count_notifications.sh)

DMENU="dmenu -i -p 📨 -nb $background -nf $foreground -sb $color1 -sf $foreground"
choice=$(echo -e "📨 ($num_notifications) NEW\n🧹 CLEAR ALL\n🔕 SILENCE [HIDE]\n▶️ RESUME\n✅ TEST\n PREVIOUS" | $DMENU | cut -f 1)

case "$choice" in
 "📨 ($num_notifications) NEW")
    dunstctl set-paused false
    notify-send "🔔 Notifications resumed" "Notifications are now active."
    exec /home/j3ll0/.config/scripts/show_dunst.sh
    ;;
 "🧹 CLEAR ALL")
    dunstctl close-all
    notify-send "🧹 All Notifications Cleared" "All pending notifications have been removed."
    ;;
 "🔕 SILENCE [HIDE]")
    dunstctl set-paused true
    ;;
 "▶️ RESUME")
    dunstctl set-paused false
    notify-send "▶️ Notifications Resumed" "Notifications are now active."
    ;;
 "✅ TEST")
    notify-send "✅ Notifications Test"
    exec /home/j3ll0/.config/scripts/test_dunst.sh
    ;;
 "🔕 NOTIFICATIONS SILENCED"*)
    dunstctl set-paused false
    ;;
 "🔔 NOTIFICATIONS RUNNING"*)
    dunstctl set-paused true
    notify-send "▶️ Notifications resumed" "Notifications are now active."
    ;;
 " PREVIOUS")
    exec /home/j3ll0/.config/scripts/rog_key_scripts.sh
    exit 0
    ;;
 *)
    exit 1
    ;;
esac
