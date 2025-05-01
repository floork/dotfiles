#!/bin/bash

# Function to count active monitors
count_active_monitors() {
  hyprctl monitors | grep -c "^Monitor"
}

# Function to check if eDP-1 is enabled by checking Hyprland's config
is_edp_enabled() {
  hyprctl monitors | grep -q "^Monitor eDP-1"
  return $?
}

# Get current state
active_monitors=$(count_active_monitors)
edp_enabled=$(is_edp_enabled && echo 1 || echo 0)

# If eDP-1 is enabled and there are multiple monitors, disable it
if [[ $edp_enabled -eq 1 && $active_monitors -gt 1 ]]; then
  echo "Disabling eDP-1 (built-in display)"
  hyprctl keyword monitor "eDP-1,disable"
  exit 0
fi

# If eDP-1 is not shown (disabled) or we have no monitors, enable it
if [[ $edp_enabled -eq 0 || $active_monitors -eq 0 ]]; then
  echo "Enabling eDP-1 (built-in display)"
  hyprctl keyword monitor "eDP-1,1920x1080@120,0x0,1"
  exit 0
fi

echo "No action needed"
exit 0
