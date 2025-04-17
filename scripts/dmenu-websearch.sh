#!/usr/bin/bash

# Load Pywal colors
source "$HOME/.cache/wal/colors.sh"

DMENU="dmenu -i -fn 'Dina-18' -nb $color0 -nf $color15 -sb $color1 -sf $color15 -p 🔎"

engines=("Bing"
"Google"
"Yahoo"
"AUR"
"Reddit"
"Stack Overflow"
"Amazon"
"JAV QUICK (TORRENT)"
"24AV (TORRENT)"
"JAV Guru (TUBE)"
"iJavTorrent (TORRENT)"
"OneJAV (TORRENT)"
"ProjectJAV (TORRENT)"
"JAVAngel (TORRENT)"
"BBC"
"CNN"
"eBay"
"GitHub"
"DuckDuckGo"
"Unsplash"
"Wallpaper Cave"
"Wikipedia"
"YouTube"
"Reuters"
)

function encode() {
  echo -n "$*" | jq -sRr @uri
}

# Get search query from clipboard or dmenu
clipboard_content=$(xclip -selection clipboard -o 2>/dev/null || echo "Clipboard is empty")
query=$(echo "$clipboard_content" | $DMENU -l 20 -p "🔎")
if [ -z "$query" ]; then exit; fi

# Choose search engine
sel=$(printf "%s\n" "${engines[@]}" | $DMENU -l 24 -p "Search Engine:")
if [ -z "$sel" ]; then exit; fi

# Define search URLs
case "$sel" in
	"Bing") url="https://www.bing.com/search?q=";;
	"Google") url="https://www.google.com/search?q=";;
	"Yahoo") url="https://search.yahoo.com/search?p=";;
	"Amazon") url="https://www.amazon.ca/s?k=";;
	"AUR") url="https://aur.archlinux.org/packages?O=0&K=";;
	"JAV QUICK (TORRENT)") url="https://javquick.com/search?q=";;
	"24AV (TORRENT)") url="https://24av.net/en/search?keyword=";;
	"JAV Guru (TUBE)") url="https://jav.guru/?s=";;
	"iJavTorrent (TORRENT)") url="https://ijavtorrent.com/?searchTerm=";;
	"OneJAV (TORRENT)") url="https://onejav.com/search/";;
	"ProjectJAV (TORRENT)") url="https://projectjav.com/?searchTerm=";;
	"JAVAngel (TORRENT)") url="https://jav-angel.net/?s=";;
	"BBC") url="https://www.bbc.co.uk/search?q=";;
	"Stack Overflow") url="https://stackoverflow.com/search?q=";;
	"CNN") url="https://www.cnn.com/search?q=";;
	"eBay") url="https://www.ebay.ca/sch/i.html?_nkw=";;
	"GitHub") url="https://github.com/search?q=";;
	"DuckDuckGo") url="https://duckduckgo.com/?q=";;
	"Unsplash") url="https://unsplash.com/s/photos/";;
	"Wallpaper Cave") url="https://wallpapercave.com/search?q=";;
	"Wikipedia") url="https://en.wikipedia.org/wiki/Special:Search?search=";;
	"YouTube") url="hhttps://www.youtube.com/results?search_query=";;
	"Reddit") url="hhttps://www.reddit.com/search/?q=";;
	"Reuters") url="hhttps://www.reuters.com/search/news?blob=";;
  *) exit;;
esac

# Encode query and open in browser
encoded_query=$(encode "$query")
vivaldi "${url}${encoded_query}"
