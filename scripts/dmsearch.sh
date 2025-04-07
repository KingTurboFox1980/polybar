#!/usr/bin/env bash
#
# Script name: dmsearch

# Defining our web browser.
DMBROWSER="floorp"

# An array of search engines.  You can edit this list to add/remove
# search engines. The format must be: "engine_name - url".
# The url format must allow for the search keywords at the end of the url.
# For example: https://www.amazon.com/s?k=XXXX searches Amazon for 'XXXX'.
declare -a options=(
"BING - https://www.bing.com/search?q="
"GOOGLE - https://www.google.com/search?q="
"AMAZON - https://www.amazon.ca/s?k="
"AUR - https://archlinux.org/packages/?sort=&q="
"Arch Wiki - https://wiki.archlinux.org/index.php?search="
"Reddit - https://www.reddit.com/search/?q="
"YouTube - https://www.youtube.com/results?search_query="
""
"quit"
)

# Picking a search engine.
while [ -z "$engine" ]; do
enginelist=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i 20 -p 'Choose search engine') || exit
engineurl=$(echo "$enginelist" | awk '{print $NF}')
engine=$(echo "$enginelist" | awk '{print $1}')
done

# Searching the chosen engine.
while [ -z "$query" ]; do
query=$(rofi -dmenu -i 20 -p "Searching $engine:") || exit
done

# Display search results in web browser
$DMBROWSER "$engineurl""$query"
