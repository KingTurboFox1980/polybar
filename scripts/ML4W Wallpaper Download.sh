#!/bin/bash

wget -P ~/Downloads/ https://gitlab.com/stephan-raabe/wallpaper/-/archive/main/wallpaper-main.zip
        unzip -o ~/Downloads/wallpaper-main.zip -d ~/Downloads/
        if [ ! -d ~/wallpaper/ ]; then
            mkdir ~/wallpaper
        fi
        cp ~/Downloads/wallpaper-main/* ~/wallpaper/
        echo "Wallpapers from the repository installed successfully."
