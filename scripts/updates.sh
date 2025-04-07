#!/usr/bin/env bash

get_total_updates() {
    PACMAN_UPDATES=$(checkupdates 2>/dev/null | wc -l)
    AUR_UPDATES=$(paru -Qum 2>/dev/null | wc -l)
    UPDATES=$((PACMAN_UPDATES + AUR_UPDATES))
}

while true; do
    get_total_updates

    # when there are updates available
    # every 10 seconds another check for updates is done
    while (( UPDATES > 0 )); do
        if (( UPDATES == 1 )); then
            echo "$UPDATES"
        elif (( UPDATES > 1 )); then
            echo "$UPDATES"
        else
            echo "None"
        fi
        sleep 10
        get_total_updates
    done

    # when no updates are available, use a longer loop, this saves on CPU
    # and network uptime, only checking once every 60 min for new updates
    while (( UPDATES == 0 )); do
        echo "0"
        sleep 3600
        get_total_updates
    done
done
