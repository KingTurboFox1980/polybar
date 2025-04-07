#!/usr/bin/sh

BROWSER="floorp"

declare -a options=(

"Microsoft Rewards - https://rewards.bing.com/"
"AUR - https://aur.archlinux.org/"
"FC25 Web App - https://www.ea.com/ea-sports-fc/ultimate-team/web-app/"
"Torrents - https://www.1377x.to/"
"Plex - https://app.plex.tv/desktop/#!/"
"Amazon - https://www.amazon.ca/"
"iCloud - https://www.icloud.com/"
"TotalSportTek Streaming - https://totalsportek.io/"
"Accuweather - https://www.accuweather.com/en/ca/annex/m5r/weather-forecast/3379628"
"YRT Schedule - https://tripplanner.yrt.ca/#/app/nextdepartures/routeheadway/full/002/WESTBOUND/YRT/"
""
""
"https://ijavtorrent.com/"
"https://jav.guru/"
"https://onejav.com/"
"https://www.141jav.com/"
"https://javrls.net/"
"https://projectjav.com/"
"https://javtiful.com/main"
""
""

"quit"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 20 -p 'Bookmarks')


if [[ "$choice" == quit ]]; then
	echo "Program Terminated." && exit 1
elif [ "$choice" ]; then
	cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
	$BROWSER "$cfg"
else
	echo "Program Terminated." && exit 1
fi
