#!/bin/bash

# First install rclone-browser, rclone and rclone-mount-service with paru
# then rclone-config in terminal to setup One Drive.  The first reference # to OneDrive below refers to the name of the remote and the second
# reference below is the location of the folder where it will be mounted

rclone --vfs-cache-mode writes mount OneDrive: /home/j3ll0/OneDrive/
