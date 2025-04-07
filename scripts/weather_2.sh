#!/usr/bin/env bash

TERMINAL="kitty --hold -e"
FLAGS="-q"

# Directly fetch weather for Markham, Ontario
choice="wttr.in/Thornhill,Canada"

$TERMINAL curl $FLAGS $choice
