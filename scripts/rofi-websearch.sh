#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

declare -A URLS

URLS=(
  ["bing"]="https://www.bing.com/search?q="
  ["google"]="https://www.google.com/search?q="
  ["yahoo"]="https://search.yahoo.com/search?p="
  ["github"]="https://github.com/search?q="
  ["Amazon"]="https://www.amazon.ca/s?k="
  ["AUR"]="https://aur.archlinux.org/packages?O=0&K="
  ["JAV QUICK (TORRENT)"]="https://javquick.com/search?q="
  ["24AV (TORRENT)"]="https://24av.net/en/search?keyword="
  ["JAV Guru (TUBE)"]="https://jav.guru/?s="
  ["iJavTorrent (TORRENT)"]="https://ijavtorrent.com/?searchTerm="
  ["OneJAV (TORRENT)"]="https://onejav.com/search/"
  ["ProjectJAV (TORRENT)"]="https://projectjav.com/?searchTerm="
  ["JAVAngel (TORRENT)"]="https://jav-angel.net/?s="
  ["BBC"]="https://www.bbc.co.uk/search?q="
  ["Stack Overflow"]="https://stackoverflow.com/search?q="
  ["CNN"]="https://www.cnn.com/search?q="
  ["eBay"]="https://www.ebay.ca/sch/i.html?_nkw="
  ["GitHub"]="https://github.com/search?q="
  ["DuckDuckGo"]="https://duckduckgo.com/?q="
  ["Unsplash"]="https://unsplash.com/s/photos/"
  ["Wallpaper Cave"]="https://wallpapercave.com/search?q="
  ["Wikipedia"]="https://en.wikipedia.org/wiki/Special:Search?search="
  ["YouTube"]="hhttps://www.youtube.com/results?search_query="
  ["Reddit"]="hhttps://www.reddit.com/search/?q="
  ["Reuters"]="hhttps://www.reuters.com/search/news?blob="
  ["goodreads"]="https://www.goodreads.com/search?q="
  ["stackoverflow"]="http://stackoverflow.com/search?q="
  ["symbolhound"]="http://symbolhound.com/?q="
  ["searchcode"]="https://searchcode.com/?q="
  ["openhub"]="https://www.openhub.net/p?ref=homepage&query="
  ["superuser"]="http://superuser.com/search?q="
  ["askubuntu"]="http://askubuntu.com/search?q="
  ["imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
  ["rottentomatoes"]="https://www.rottentomatoes.com/search/?search="
  ["piratebay"]="https://thepiratebay.org/search/"
  ["youtube"]="https://www.youtube.com/results?search_query="
  ["vimawesome"]="http://vimawesome.com/?q="
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the query input to rofi first
  query=$( (echo ) | rofi -dmenu -matching fuzzy -location 0 -p "🔎" )

  if [[ -n "$query" ]]; then
    platform=$( (gen_list) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "Search Engine" )
    
    if [[ -n "$platform" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      exit
    fi

  else
    exit
  fi
}

main

exit 0
