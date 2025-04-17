#!/bin/bash

# Ensure necessary commands are installed
for cmd in dmenu redshift wal; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd is not installed. Please install it and try again."
        exit 1
    fi
done

# Import pywal colors
if [ -f "${HOME}/.cache/wal/colors.sh" ]; then
    . "${HOME}/.cache/wal/colors.sh"
else
    echo "Pywal colors not found. Please generate colors with pywal first."
    exit 1
fi

# Temperature options with auto and reset first
temps=(AUTO RESET 3000K 3500K 4000K 4500K 5000K 5500K 6000K 6500K)

# Function to determine the current time of day and set temperature
auto_mode() {
    redshift -x  # Reset first
    hour=$(date +%H)
    if [ "$hour" -ge 6 ] && [ "$hour" -lt 18 ]; then
        temp_value=5000  # Daytime temperature
    else
        temp_value=4000  # Nighttime temperature
    fi
    redshift -O "$temp_value"
    notify-send "Redshift" "Auto mode: Color temperature set to ${temp_value}K."
}

# Get user input with pywal colors applied to dmenu
temp=$(printf "%s\n" "${temps[@]}" | dmenu -i -p "Choose color temperature:" -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn "Monospace-18")

# Exit if no input
if [ -z "$temp" ]; then
    exit 0
fi

# Apply chosen temperature or reset
if [ "$temp" = "RESET" ]; then
    redshift -x
    notify-send "Redshift" "Color temperature reset."
elif [ "$temp" = "AUTO" ]; then
    auto_mode
else
    # Reset the color first
    redshift -x
    temp_value="${temp%K}"
    redshift -O "$temp_value"
    notify-send "Redshift" "Color temperature set to ${temp}."
fi

# Reapply pywal colors
wal -R
