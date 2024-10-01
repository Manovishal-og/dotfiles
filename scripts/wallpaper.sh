#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpaper"
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

echo "preload = $RANDOM_WALLPAPER" > ~/.config/hypr/hyprpaper.conf

echo "wallpaper = ,$RANDOM_WALLPAPER" >> ~/.config/hypr/hyprpaper.conf
