#!/bin/bash

# Script name: dm-weather

curl -s "https://wttr.in/${_location// /%20}?T&${weather_opts}" | yad --text-info --maximized
