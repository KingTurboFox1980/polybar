#!/bin/bash
# Replace any occurance of dmenu with rofi-dmenu to make this a rofi menu instead of dmenu 

# Apply pywal colors
source "${HOME}/.cache/wal/colors.sh"

# Get a list of running processes
procs=$(ps -e -o pid,comm --sort=-%mem | awk '{print $2, $1}')

# Set the desired font size
FONT="monospace-14"

# Show processes in dmenu and get the selected one
selected=$(echo "$procs" | dmenu -i -l 20 -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn "$FONT" -p "Select process to kill:")

# Extract program name and PID of the selected process
program_name=$(echo "$selected" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')
pid=$(echo "$selected" | awk '{print $2}')

# Ask for confirmation before killing the process
kill_confirm=$(echo -e "No\nYes" | dmenu -i -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn "$FONT" -p "KILL $program_name?")

if [[ "$kill_confirm" == "Yes" ]]; then
  kill "$pid"
  notify-send "$program_name ($pid) has been killed."
else
  notify-send "$program_name ($pid) has not been killed."
fi
