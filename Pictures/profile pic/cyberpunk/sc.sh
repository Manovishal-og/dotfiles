#!/bin/bash

# Kill previous feh instances if any
pkill feh

# Show image on right
feh --geometry 500x500+900+300 /home/zamipter/Pictures/profile\ pic/cyberpunk/prof.jpg &

# Launch Rofi on left
rofi -show drun 

