#!/usr/bin/env bash

# Define the path for the lock file
LOCK_FILE="/tmp/set_wallpaper.lock"
WALLPAPERS_DIR="$HOME/.config/wallpapers"
INTERVAL=600

####################
# Wallpaper Backends
####################

# Define associative array of backends with their corresponding functions
declare -A backends=(
	["hyprpaper"]="hyprpaper_change"
	["swaybg"]="swaybg_change"
)

# Function for the swaybg backend
function swaybg_change() {
	sleep 1 && hyprpaper &
}

# Function for the hyprpaper backend
function hyprpaper_change() {
	sleep 1
	hyprpaper &
}

####################
# Utility Functions
####################

# Function to acquire the lock
function acquire_lock() {
	if [ -e "$LOCK_FILE" ]; then
		echo "Another instance is already running. Exiting."
		exit 1
	else
		touch "$LOCK_FILE"
	fi
}

# Function to release the lock
function release_lock() {
	rm -f "$LOCK_FILE"
}

# Function to get a random wallpaper from the specified directory
function get_wallpaper() {
	if [ ! -d "$1" ]; then
		echo "Error: Wallpapers directory '$1' does not exist."
		exit 1
	fi

	wallpaper=$(find "$1" -type f -name '*.png' | shuf -n 1)
	if [ -z "$wallpaper" ]; then
		echo "Error: No PNG wallpapers found in '$1'."
		exit 1
	fi
}

# Function to kill a process
function kill_process() {
	if pgrep -x "$1" >/dev/null; then
		killall "$1"
	fi
}

# Function to change the wallpaper
function change_wallpaper() {
	local program="$1"
	if ! [[ -v backends[$program] ]]; then
		echo "Wallpaper backend is not allowed"
		exit 1
	fi

	kill_process "$program"

	"${backends[$program]}" "$wallpaper"
}

# Function to set wallpaper
function set_wallpaper() {
	get_wallpaper "$WALLPAPERS_DIR"
	cp "$wallpaper" ~/.cache/current.png
	change_wallpaper "$WALLPAPER_BACKEND"
}

# Function to handle cleanup
function cleanup() {
	release_lock
}

# Trap cleanup function on exit
trap cleanup EXIT

############
# Main Logic
############

# Main function
function main() {
	acquire_lock

	set_wallpaper

	# Set wallpaper at intervals
	while true; do
		sleep "$INTERVAL"
		set_wallpaper
	done
}

main
