#!/bin/zsh

# Function to count notifications in history
count_notifications() {
    dunstctl count history
}

# Function to get the current timestamp in 12-hour format
get_timestamp() {
    date +"%r" | sed 's/^0//'
}

# Initial notification about unseen notifications with persistence
unseen_notif_id=$(dunstify -u critical --timeout 0 "You have $(count_notifications) unseen notifications")

# Function to update the persistent notification
update_notification() {
    dunstify -r "$unseen_notif_id" -u critical --timeout 0 "You have $(count_notifications) unseen notifications"
}

# Sleep for 2 seconds
sleep 2s

# Limit to 10 notifications
max_notifications=10
counter=0

# Set to keep track of unique notifications
declare -A seen_notifications

# Pop each notification in history with a timestamp and program name, up to 10
while [ $counter -lt $max_notifications ] && [ $(count_notifications) -gt 0 ]; do
    notification=$(dunstctl history-pop)
    program=$(echo "$notification" | awk -F '\t' '{print $1}')

    # Check if the notification is already seen
    if [ -z "${seen_notifications["$notification"]}" ]; then
        dunstify -a "center" -t 1000 "🕒 $(get_timestamp): $program - $notification"
        seen_notifications["$notification"]=1
        counter=$((counter + 1))
        sleep 0.5
        update_notification  # Update the persistent notification each time a notification is popped
    fi
done

exit 0
