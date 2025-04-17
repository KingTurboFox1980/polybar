#!/bin/bash
# Replace any occurance of dmenu with rofi-dmenu to make this a rofi menu instead of dmenu

# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Rofi menu for Quick Edit/View of Settings

# Define preferred text editor and terminal
tty=kitty

# Paths to configuration directories
configs="$HOME/j3ll0/.config/"
suckless="$HOME/j3ll0/.suckless/"

# Function to display the menu options
menu() {
    cat <<EOF
BASH
EDIT THIS MENU
FAV PLACES
DUNST CONFIG
KITTY CONFIG
PACMAN CONFIG (SUDO)
PARU CONFIG (SUDO)
PICOM (SUDO)
Polybar Bookmarks
D-Menu Search Engines
STARSHIP TOML
VIM Keyhints
DWM Keyhints
ZSH
EOF
}

# Main function to handle menu selection
main() {
    choice=$(menu | rofi -i -dmenu -config /home/j3ll0/.config/rofi/config.rasi | cut -d. -f1)

    # Map choices to corresponding files
    case $choice in
        "BASH") file="$HOME/.bashrc" ;;
        "EDIT THIS MENU") file="/home/j3ll0/.config/scripts/dwmconfig.sh" ;;
        "FAV PLACES") file="/home/j3ll0/.config/scripts/dwmfolders.sh" ;;
        "DUNST CONFIG") exec kitty -e sudo vim /etc/dunst/dunstrc ;;
        "KITTY CONFIG") file="/home/j3ll0/.config/kitty/kitty.conf" ;;
        "PACMAN CONFIG (SUDO)") exec kitty -e sudo vim /etc/pacman.conf ;;
        "PARU CONFIG (SUDO)") exec kitty -e sudo vim /etc/paru.conf ;;
        "PICOM (SUDO)") exec kitty -e sudo vim /etc/xdg/picom.conf ;;
        "Polybar Bookmarks") file="/home/j3ll0/.config/scripts/dmenu_bookmarks.txt" ;;
        "D-Menu Search Engines") file="/home/j3ll0/.config/scripts/dmenu-websearch.sh" ;;
        "STARSHIP TOML") file="/home/j3ll0/.config/starship.toml" ;;
        "VIM Keyhints") file="/home/j3ll0/.config/polybar/scripts/keyhintvim.sh" ;;
        "DWM Keyhints") file="/home/j3ll0/.config/polybar/scripts/keyhintdwm.sh" ;;
        "ZSH") file="$HOME/.zshrc" ;;
        *) return ;;  # Do nothing for invalid choices
    esac

    # Open the selected file in the terminal with the text editor
    $tty -e vim "$file"
}

main
