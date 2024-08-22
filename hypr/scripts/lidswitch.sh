#!/usr/bin/env bash

option=$1

if [[ $option -eq "open" ]]; then
  hyprctl keyword monitor "eDP-1, 1920x1080@120, 0x0, 1"
else
  if [[ $(hyprctl monitors | grep "Monitor" | wc -l) != 1 ]]; then
    hyprctl keyword monitor "eDP-1, disable"
  fi
fi
