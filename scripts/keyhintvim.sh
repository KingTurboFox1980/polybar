#!/usr/bin/env bash
# An array of search engines.  You can edit this list to add/remove
# search engines. The format must be: "engine_name - url".
# The url format must allow for the search keywords at the end of the url.
# For example: https://www.amazon.com/s?k=XXXX searches Amazon for 'XXXX'.
declare -a options=(
"i          - enter INSERT Mode"
"R          - enter REPLACE mode"
"Escape     - exit INSERT / REPLACE  mode"
":w         - write"
":q!        - quit without saving"
":wq        - write and quit"
":%d        - delete all lines"
":1,5d      - delete lines 1-5 etc"
":num       - jump to specific line"
"b / e      - jump to beginning / end of word"
"gg / G     - jump to top / bottom of file"
"dd / dw    - delete line / word"
"x          - delete character"
"/          - search | n - next or N - previous"
"yy         - copy line"
"P / p      - paste above / below"
"u / U      - undo / redo"
""
"quit"
)

# Picking a search engine.
while [ -z "$engine" ]; do
enginelist=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i 20 -p 'VIM Keys') || exit
engineurl=$(echo "$enginelist" | awk '{print $NF}')
engine=$(echo "$enginelist" | awk '{print $1}')
done

# Searching the chosen engine.
while [ -z "$query" ]; do
query=$(rofi -dmenu -i 20 -p "Searching $engine:") || exit
done

# Display search results in web browser
$DMBROWSER "$engineurl""$query"








#!/usr/bin/env bash
#
# Script name: dmsearch

# Defining our web browser.
DMBROWSER="firefox"

# An array of search engines.  You can edit this list to add/remove
# search engines. The format must be: "engine_name - url".
# The url format must allow for the search keywords at the end of the url.
# For example: https://www.amazon.com/s?k=XXXX searches Amazon for 'XXXX'.
declare -a options=(

"quit"
)

# Picking a search engine.
while [ -z "$engine" ]; do
enginelist=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i 20 -p 'Choose search engine:') || exit
engineurl=$(echo "$enginelist" | awk '{print $NF}')
engine=$(echo "$enginelist" | awk '{print $1}')
done

# Searching the chosen engine.
while [ -z "$query" ]; do
query=$(rofi -dmenu -i 20 -p "Searching $engine:") || exit
done

# Display search results in web browser
$DMBROWSER "$engineurl""$query"
