#!/bin/bash

if [[ $(hyprctl monitors | grep "eDP-1" | wc -l) == 1 ]]; then
  hyprctl keyword monitor "eDP-1, disable"
else
  hyprctl keyword monitor "eDP-1, 1920x1080@120, 0x0, 1"
fi
