#!/bin/bash

# Function to get the current timestamp in 12-hour format
get_timestamp() {
    date +"%r" | sed 's/^0//'
}

notify-send -u critical -i dialog-error "🚨 Alert: $(get_timestamp)" "CHECK"
sleep 0.1

notify-send -u normal -i dialog-information "💬 Notice: $(get_timestamp)" "normal test 1"
sleep 0.1

notify-send -u low -i dialog-information "ℹ️ Info: $(get_timestamp)" "low test 2"
sleep 0.1

notify-send -u critical -i dialog-error "🚨 Alert: $(get_timestamp)" "THIS"
sleep 0.1

notify-send -u normal -i dialog-information "💬 Notice: $(get_timestamp)" "normal test 3"
sleep 0.1

notify-send -u low -i dialog-information "ℹ️ Info: $(get_timestamp)" "low test 4"
sleep 0.1

notify-send -u critical -i dialog-error "🚨 Alert: $(get_timestamp)" "IS"
sleep 0.1

notify-send -u normal -i dialog-information "💬 Notice: $(get_timestamp)" "normal test 5"
sleep 0.1

notify-send -u low -i dialog-information "ℹ️ Info: $(get_timestamp)" "low test 6"
sleep 0.1

notify-send -u critical -i dialog-error "🚨 Alert: $(get_timestamp)" "A"
sleep 0.1

notify-send -u normal -i dialog-information "💬 Notice: $(get_timestamp)" "normal test 7"
sleep 0.1

notify-send -u low -i dialog-information "ℹ️ Info: $(get_timestamp)" "low test 8"
sleep 0.1

notify-send -u critical -i dialog-error "🚨 Alert: $(get_timestamp)" "NOTIFICATION TEST"
sleep 0.1

exit
