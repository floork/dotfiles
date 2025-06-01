#!/bin/sh

# Autostart applications
riverctl spawn "waybar"
riverctl spawn "pypr" # For pyprpaper
riverctl spawn "wl-paste --watch cliphist store"
riverctl spawn "nm-applet"
riverctl spawn "legcord"
# riverctl spawn "spotify" # Uncomment if you want spotify to autostart
# riverctl spawn "element-desktop --hidden" # Uncomment if you want element-desktop to autostart
riverctl spawn "thunderbird"
