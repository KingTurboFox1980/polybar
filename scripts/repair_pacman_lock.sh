#!/bin/bash

# Function to check if any package manager processes are running
check_pacman_processes() {
    if pgrep -x pacman >/dev/null || pgrep -x pamac >/dev/null || pgrep -x yay >/dev/null; then
        echo "Another package manager is currently running. Please close it before running this script."
        exit 1
    fi
}

# Function to delete the lock file if no package manager processes are running
repair_pacman_lock() {
    lock_file="/var/lib/pacman/db.lck"

    if [ -f "$lock_file" ]; then
        echo "Lock file exists: $lock_file"
        check_pacman_processes
        echo "No package manager processes found. Deleting the lock file..."
        sudo rm "$lock_file"
        echo "Lock file deleted successfully."
    else
        echo "No lock file found. No action needed."
    fi
}

# Function to update the system
update_system() {
    echo "Updating the system..."
    sudo pacman -Syu
}

# Run the functions
repair_pacman_lock
update_system
