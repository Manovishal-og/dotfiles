#!/bin/bash
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf" # This line defines the variable
WALLPAPER_DIR="$HOME/Pictures/Wallpaper/cyberpunk"
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f -name "wall*" | shuf -n 1)

echo "preload = $RANDOM_WALLPAPER" > ~/.config/hypr/hyprpaper.conf

echo "wallpaper = ,$RANDOM_WALLPAPER" >> ~/.config/hypr/hyprpaper.conf

sed -i '/background\s*{/,/}/{s|^\s*path\s*=\s*.*|    path = '"$RANDOM_WALLPAPER"'|}' "$HYPRLOCK_CONF" # This line uses the variable

