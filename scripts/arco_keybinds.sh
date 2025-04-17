#!/bin/bash

menu() {
  echo -e '
MOD + e          | Atom Editor
MOD + c          | Toggle Conky
MOD + f          | Toggle Fullscreen
MOD + h          | htop Task Manager
MOD + o          | P3X OneNote
MOD + q          | Kill Window
MOD + a          | Cider App
MOD + e          | Evolution
MOD + w          | Floorp Browser
MOD + r          | Rofi Theme Selector
MOD + t          | urxvt Terminal
MOD + v          | PulseAudio Control
MOD + y          | Toggle Polybar
MOD + x          | Logout
MOD + Escape     | Mission Center
MOD + Return     | Kitty Terminal
F1               | Toggle Mute
Audio Mic Mute   | Dwm Folders Script
Launch1          | ROG Key Script
Shift + Launch1  | Maintenance Script
MOD + F3         | Inkscape
MOD + F4         | GIMP
MOD + F5         | Meld
MOD + F6         | VLC
MOD + F7         | VirtualBox
MOD + t          | Thunar File Manager
Shift + MOD + p  | Picom Toggle
F9               | Redshift
F11              | Screen Off
MOD + s          | Dmenu Web Search
MOD + z          | Rofi
F12              | Dropdown Terminal
Shift + MOD + d  | dmenu_run
MOD + d          | Launcher Script
MOD + r          | Recompile & Restart XMonad
Shift + MOD + q  | Kill Window
Shift + MOD + x  | Power Menu
Ctrl + Alt + Next| Conky Rotate Next
Ctrl + Alt + Prior|Conky Rotate Prev
Ctrl + Alt + a   | App Finder
Ctrl + Win + t   | Thunar File Manager
Ctrl + Alt + c   | Catfish
Ctrl + Alt + e   | Arch Linux Tweak Tool
Ctrl + Alt + f   | Firefox
Ctrl + Alt + g   | Chromium
Ctrl + Alt + i   | Nitrogen
Ctrl + Alt + k   | Logout
Ctrl + Alt + l   | Logout
Ctrl + Alt + m   | Settings Manager
Ctrl + Alt + o   | Picom Toggle
Ctrl + Alt + p   | Pamac Manager
Ctrl + Alt + r   | Rofi Theme Selector
Ctrl + Alt + s   | Spotify
Ctrl + Alt + t   | Alacritty
Ctrl + Alt + u   | PulseAudio Control
Ctrl + Alt + v   | Vivaldi Browser
Ctrl + Alt + w   | Welcome App
Ctrl + Alt + Return| Alacritty Terminal
Alt + f          | Variety - Next
Alt + n          | Variety - Next
Alt + p          | Variety - Prev
Alt + r          | Restart XMonad
Alt + t          | Variety - Trash
Alt + Up         | Variety - Pause
Alt + Down       | Variety - Resume
Alt + Left       | Variety - Prev
Alt + Right      | Variety - Next
Alt + F2         | App Finder (Collapsed)
Alt + F3         | App Finder
Shift + Alt + f  | Variety + PyWal
Shift + Alt + n  | Variety + PyWal
Shift + Alt + p  | Variety + PyWal
Shift + Alt + t  | Variety + PyWal
Shift + Alt + u  | Apply PyWal Wallpaper
Ctrl + Shift + Esc| Task Manager
Print            | Screenshot
Ctrl + Print     | Screenshot (Region)
Shift + Ctrl + Print| Screenshot (Interactive)
Ctrl + MOD + Print| Flameshot
Audio Mute       | Toggle Mute
Audio Lower Vol  | Lower Volume
Audio Raise Vol  | Raise Volume
Brightness Up    | Increase Brightness
Brightness Down  | Decrease Brightness
MOD + Space      | Next Layout
Alt + Tab        | Next Workspace
MOD + Tab        | Next Workspace
Ctrl + Alt + Left| Prev Workspace
Ctrl + Alt + Right|Next Workspace
Shift + MOD + Space| Reset Layout
MOD + j          | Focus Down
MOD + k          | Focus Up
Shift + MOD + m  | Focus Master
Shift + MOD + j  | Swap Down
Ctrl + MOD + Down| Swap Down
Shift + MOD + k  | Swap Up
Ctrl + MOD + Up  | Swap Up
Ctrl + Shift + h | Shrink
Ctrl + Shift + l | Expand
Ctrl + Shift + t | Push to Tiling
Ctrl + MOD + Left| Increase Master Windows
Ctrl + MOD + Right| Decrease Master Windows
'
}

choice=$(menu | rofi -i -dmenu -config /home/j3ll0/.config/rofi/config_folders.rasi)
eval "exec ${choice}"
