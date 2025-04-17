#!/bin/bash

# Load Pywal colors
source "$HOME/.cache/wal/colors.sh"

# Notify user that update check is starting
notify-send "System Update" "Checking for Updates..."

# Check for updates
pacman_updates=$(checkupdates 2>/dev/null)
aur_updates=$(paru -Qua 2>/dev/null)
flatpak_updates=$(flatpak update --dry-run | grep "Update" | wc -l)
snap_updates=$(snap refresh --list | wc -l)

# Count actual updates (ignoring empty lines)
pacman_count=$(echo "$pacman_updates" | grep -v '^$' | wc -l)
aur_count=$(echo "$aur_updates" | grep -v '^$' | wc -l)
total_updates=$(( pacman_count + aur_count + flatpak_updates + snap_updates ))

if [[ $total_updates -gt 0 ]]; then
    # Show available updates in a notification using Pywal colors
    notify-send "Available Updates" "$(echo -e "$pacman_updates\n$aur_updates\nFlatpak: $flatpak_updates updates\nSnap: $snap_updates updates")"

    # Prompt user to update using Pywal colors in dmenu
    choice=$(echo -e "Update System\nCancel" | dmenu -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color7" -i -p "$total_updates updates available")

    if [[ "$choice" == "Update System" ]]; then
        kitty -o background_opacity=0.9 -o background="$color0" -e bash -c "sudo pacman -Syu && paru -Syu && flatpak update && snap refresh && sudo pacman -Sc"
        notify-send "System Cleanup" "Package cache cleaned!"
    fi
else
    notify-send "System Update" "Your system is up to date!"
fi
