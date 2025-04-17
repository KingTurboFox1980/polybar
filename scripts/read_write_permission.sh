#!/bin/bash

# List available drives using lsblk
echo "Available hard drives:"
lsblk -d -o NAME,SIZE,TYPE | grep disk

# Prompt the user to select a drive
read -p "Enter the name of the drive (e.g., sda): " drive

# Check if the selected drive exists
if lsblk | grep -q "^$drive"; then
    echo "Drive $drive found."
else
    echo "Error: Drive $drive not found."
    exit 1
fi

# Setting permissions (read and write) for the user on the drive
echo "Setting read and write permissions for /dev/$drive..."
sudo chmod u+rw /dev/$drive

if [ $? -eq 0 ]; then
    echo "Permissions updated successfully."
else
    echo "Failed to update permissions. Check your privileges."
fi
