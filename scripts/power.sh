#!/usr/bin/env bash
# shutdown menu i3blocks
MENU="$(rofi -sep "|" -dmenu -i -p 'System' -width 12 -hide-scrollbar -line-padding 6 -padding 20 -lines 4 -font "Misc Termsyn 12" <<< "Lock|Logout|Reboot|Shutdown")"
case "$MENU" in
	*Lock) i3lock ;;
	*Logout) i3-msg exit;;
	*Reboot) sudo shutdown -r now ;;
	*Shutdown) sudo shutdown -P now
esac