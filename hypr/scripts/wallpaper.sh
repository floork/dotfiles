#!/bin/env bash

####################
# Constants
####################

LOCK_FILE="/tmp/set_wallpaper.lock"
WALLPAPERS_DIR="$HOME/.config/wallpapers"
RANDOM_WALLPAPER_SCRIPT="hypr/scripts/random_wallpaper.sh"
ROFI_CMD="wofi --show dmenu -i -p 'Select a wallpaper: '"

# Define associative array of backends with their corresponding functions
declare -A backends=(
	["swaybg"]="apply_swaybg_wallpaper"
	["hyprpaper"]="apply_hyprpaper_wallpaper"
)

####################
# Custom Functions
####################

# Function to apply wallpaper using swaybg
function apply_swaybg_wallpaper() {
	local wallpaper="$1"
	swaybg -i "$wallpaper" -m fill & # Set wallpaper using swaybg
}

# Function to apply wallpaper using hyprpaper
function apply_hyprpaper_wallpaper() {
	local wallpaper="$1"
	sleep 1
	hyprpaper & # Set wallpaper using hyprpaper
}

####################
# Functions
####################

# Function to kill a process if it is running
function kill_process() {
	local process="$1"
	if pgrep -x "$process" >/dev/null; then
		pkill "$process"
	fi
}

# Function to kill the random wallpaper script if it is running
function kill_random_wallpaper() {
	local pid=$(pgrep -f $RANDOM_WALLPAPER_SCRIPT)
	if [ -n "$pid" ]; then
		kill "$pid"
	fi
}

# Function to apply a wallpaper
function apply_wallpaper() {
	local wallpaper="$1"
	local backend="$2"

	kill_process "$backend" # Kill any existing process related to wallpaper_backend
	kill_random_wallpaper   # Kill the random wallpaper script

	cp "$wallpaper" ~/.cache/current.png # Copy the selected wallpaper to cache directory

	if [ "${backends[$backend]+isset}" ]; then
		"${backends[$backend]}" "$wallpaper"
	else
		echo "Backend not found: $backend" # Print error if backend not found
	fi
}

# Function to show a menu of wallpapers and apply the selected wallpaper
function show_wallpaper_menu() {
	local wallpapers=($(fd . --full-path "$WALLPAPERS_DIR" -e png)) # List of wallpapers
	local options=$(printf "%s\n" "${wallpapers[@]}")               # Options for wallpaper selection menu
	local selected_option=$(echo -e "$options" | $ROFI_CMD)         # Selected wallpaper option

	if [ -n "$selected_option" ]; then
		apply_wallpaper "$selected_option" "$WALLPAPER_BACKEND" # Apply the selected wallpaper
	else
		echo "No wallpaper selected."
	fi
}

# Function to check if the wofi menu is open
function check_wofi_open() {
	pgrep -x wofi >/dev/null
}

####################
# Main Logic
####################

# Check if the wofi menu is open, if not, show the wallpaper menu
if ! check_wofi_open; then
	show_wallpaper_menu
fi
