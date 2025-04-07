#!/bin/sh

# A dmenu wrapper script for system functions.

case "$(readlink -f /sbin/init)" in
	*systemd*) ctl='systemctl' ;;
	*) ctl='loginctl' ;;
esac

#declare -A icons
#icons[lockscreen]="\uf023"
#icons[switchuser]="\uf518"
#icons[logout]="\uf842"
#icons[suspend]="\uf9b1"
#icons[hibernate]="\uf7c9"
#icons[reboot]="\ufc07"
#icons[shutdown]="\uf011"
#icons[cancel]="\u00d7"

cmds="\
🖥️ POWER OFF	$ctl poweroff -i

🚪 LOGOUT	kill -TERM $(pidof -s dwm)

♻ RELOAD DWM	kill -HUP $(pidof -s dwm)

🔃 REBOOT	$ctl reboot -i"

choice="$(echo "$cmds" | cut -d'	' -f 1 | rofi -dmenu -p "⏻ Power:")" || exit 1

`echo "$cmds" | grep "^$choice	" | cut -d '	' -f2-`
