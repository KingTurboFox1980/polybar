#!/bin/sh

notify-send " " "$(cal | sed "s/\<$(date +'%e'|tr -d ' ')\>/<b><span color='red' size='x-large'>&<\/span><\/b>/; s/.*/<span color='yellow'>&<\/span>/")"
