#!/bin/sh

# Reload pywal colors
source ~/.cache/wal/colors.sh

function graphics {
    options="Cancel\nHybrid\nIntel\nNvidia"
    selected=$(echo -e $options | dmenu -i -p "Current Graphics Mode: $GPU_STATUS (Logout after selection)" -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15")
    if [[ $selected = "Hybrid" ]]; then
       exec st -e '/home/j3ll0/.config/polybar/scripts/graphics_switch_hybrid.sh'
    elif [[ $selected = "Intel" ]]; then
       exec st -e '/home/j3ll0/.config/polybar/scripts/graphics_switch_intel.sh'
    elif [[ $selected = "Nvidia" ]]; then
       exec st -e '/home/j3ll0/.config/polybar/scripts/graphics_switch_nvidia.sh'
    elif [[ $selected = "Cancel" ]]; then
        return
    fi
}

graphics
